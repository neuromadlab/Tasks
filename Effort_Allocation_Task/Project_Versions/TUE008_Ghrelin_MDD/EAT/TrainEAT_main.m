%%===================Effort allocation Training=============
% Script needed for EAT_main.m
%
% author: Monja P. Neuser, Vanessa Teckentrup, 
%         Nils B. Kroemer
% adaptations: Mechteld van den Hoek Ostende,
% Input: fiber optic response grip force device or Xbox360 controller, 
%        computer mouse for non-mri settings
%%=========================================================
%%   Determine individual maximum Frequency (3x10secs)
%% Clear data vectors / initialize start values

if settings.do_gamepad == 1 % if frEAT
    load('./input_specs/JoystickSpecification.mat')
    findJoystick
    % initialize frequency specific values
    i_step_fr           = 1;  % Enummarate over loops
    count_joy           = 1;
    t_button            = 0;
    i_resp              = 1;
    xbox_buffer         = zeros(1,50);  %will buffer 50 button press status
    maxfreq_estimate    = 5.5;
    t_button_vec        = [];
    
    % Initialize drawing factors
    input_device.maxEffort   = 4.5;
    draw_frequency           = 0; % used to determine ball height
    draw_frequency_normalize = maxfreq_estimate/input_device.maxEffort; 
    draw_frequency_factor    = Tube.height*0.3 * draw_frequency_normalize; % scale to tube
    
    max_Boundary_yposition   = Tube.YBottom -Ball.width - draw_frequency * draw_frequency_factor;
    
    % Initialise exponential weighting
    forget_fact         = 0.6;
    prev_weight_fact    = 0;
    prev_movingAvrg     = 0;
    current_input       = 0; 
    Avrg_value          = 0;   
    frequency_estimate  = 0;
    freq_interval       = 1;    % Frequency estimation interval 1 sec
    prev_movingAvrg_phantom(1,1) = prev_movingAvrg;
    phantom_current_input       = 0;

    collect_freq.t_button_interval  = []; %!! Remove? seems unused 
    collect_freq.avrg               = []; %!! Remove? seems unused 

    i_phantom = 1;

    %!! evaluate necessity of all these output structures
    % Initialize frEAT specific output structures
    output.t_button                 = []; % stores clicks: timestamps of button presses %!!(Required?)
    output.t_button_referenced      = []; % referenced to trial start (t_trial_onset)   %!!(Required?)
    output.frequency_button         = []; %!!(Required?) 
    output.t_100                    = []; % Timestamp every 100ms %!!(Required?)    
    output.frequency_t100           = []; % Tracks frequency every 100 ms 
    
else % grip force device (grEAT)
    % initialize grip force device
    load('./input_specs/GripForceSpec.mat')
    % initialize grip force specific values    
    if windows

        initrestforce    = getfield(GripForceSpec, 'restforce'); %normal holding force
        initmaxforce     = getfield(GripForceSpec, 'maxpossibleforce'); %upper limit of GFD
        clckforce = 25000;
        if (settings.do_fmri == 1) && (settings.debug == 0)
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        else
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec);
        end
        gripforce_value = Joystick.Y;

     elseif linux
         
        initrestforce   = -5000; %normal holding force
        initmaxforce    = -23000; %upper limit of GFD   
        clckforce       = -12000;
        axisState       = Gamepad('GetAxis', grip_force_idx, grip_force_axis);
        gripforce_value = axisState;

    end
    
    i_step_gr           = 1;  % Enummarate over loops
    delta_pos_force     = initrestforce - initmaxforce;
    ForceMat            = initrestforce;
    effort_vector       = []; 
    LowerBoundBar       = setup.ScrHeight - Tube.offset - Ball.width;
    UpperBoundBar       = Tube.height + Ball.width;
    BarBoundAbs         = LowerBoundBar - UpperBoundBar;
    BarBound2Scale      = BarBoundAbs/delta_pos_force;
    
    max_Boundary_yposition  = LowerBoundBar;
    
end

%% Prepare output structures to determine max effort across training
collectMax.maxEffort = nan(1,3);  %stores maxEffort of 3 practice trials
collectMax.values_per_trial = [];


% Prepare output struct to determin min force across training
collectMax.minEffort = nan(1,3);  %stores minEffort of 4 practice trials

%% start training
% basic instructions
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.train_instr, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
Screen('Flip',w);

if settings.do_fmri == 0
    GetClicks(setup.screenNum);
    
    % first round instructions
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.first_round_train, 'center', Text.height, color.black, 60, [], [], 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum);
elseif settings.do_fmri == 1
    WaitSecs(4);        
    while gripforce_value > clckforce
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        gripforce_value = Joystick.Y;
    end
end

for i_collectMax = 1:settings.train_trials 
    %% instructions
    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');
    if i_collectMax == 2 && settings.train_trials == 3
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.middle_round_train, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);
        if settings.do_fmri == 0
            GetClicks(setup.screenNum);
        elseif settings.do_fmri == 1
            WaitSecs(3);        
            while gripforce_value > clckforce
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                gripforce_value = Joystick.Y;
            end
        end
    elseif i_collectMax ~= 1 
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.last_round_train, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);
        if settings.do_fmri == 0
            GetClicks(setup.screenNum);
        elseif settings.do_fmri == 1
            WaitSecs(3);        
            while gripforce_value > clckforce
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                gripforce_value = Joystick.Y;
            end
        end
    end
    
    %% Show fixation cross at the beginning of each trial 
    fix = '+';
    Screen('TextSize',w,64);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', color.black,80);
    time.fix = Screen('Flip', w);

    WaitSecs(1); %Show screen for 1s
    
    %% Actual training trial start (recortstart time)
    t_collectMax_onset = GetSecs;
    t_buttonN_1        = t_collectMax_onset;
    
    % Loop during 10 sec duration (training trial length)
    while (10  > (GetSecs - t_collectMax_onset))
        
        % Draw graphical display         
        % Draw Tube
        Screen('DrawLine',effort_scr,color.black,Tube.XCor1 , Tube.height,  Tube.XCor1 , Tube.YBottom,6);
        Screen('DrawLine',effort_scr,color.black,Tube.XCor2 , Tube.height,  Tube.XCor2 , Tube.YBottom,6);
        Screen('DrawLine',effort_scr,color.black,Tube.XCor1 , Tube.YBottom, Tube.XCor2 , Tube.YBottom,6);
        Screen('CopyWindow',effort_scr,w);
          
         % Draw upper bound blue line 
         if settings.do_gamepad == 0
             if ForceMat < initrestforce       
                 Boundary_yposition = BarBound2Scale*ForceMat + UpperBoundBar - initmaxforce * BarBound2Scale; 
             else            
                 Boundary_yposition = LowerBoundBar;       
             end
             
         elseif settings.do_gamepad == 1
             % Store for timestamps and actual frequency every 100ms
             t_step = GetSecs;
             
             if (0.1 * i_step_fr) <= (t_step - t_collectMax_onset)           
                t_100_vector(1,i_step_fr)   = t_step;
                effort_vector(1,i_step_fr)  = draw_frequency;
                i_step_fr                   = i_step_fr + 1;
             end
             Boundary_yposition = ((setup.ScrHeight-Tube.offset-Ball.width)-(draw_frequency * draw_frequency_factor));
         end
         
         max_Boundary_yposition = min(max_Boundary_yposition, Boundary_yposition);
         Screen('DrawLine',w,color.darkblue,Tube.XCor1, max_Boundary_yposition, Tube.XCor2, max_Boundary_yposition,3);
        

        % Draw Ball
        Ball.position = [(setup.xCen-Ball.width/2) (Boundary_yposition) (setup.xCen+Ball.width/2) (Boundary_yposition + Ball.width)];
        Ball.color = color.darkblue;
        Screen('FillOval',w,Ball.color,Ball.position);
        Screen('Flip', w);
        
        if settings.do_gamepad == 0
            [b,c] = KbQueueCheck;      
            % Continuously log position and time of the button for the right index
            % finger -> Joystick.Z
            if windows
                if settings.do_fmri == 1 && settings.debug == 0
                    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                else
                    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                end
                gripforce_value = Joystick.Y;                
            elseif linux               
                axisState       = Gamepad('GetAxis', grip_force_idx, grip_force_axis);
                gripforce_value = axisState;               
            end               
            % Getting values from Grip Force Device -> Joystick.Y
            ForceMat                = gripforce_value;
                
            % Saving force over time           
            effort_vector           = [effort_vector, gripforce_value]; 
                
           % Store for timestamps and actual force every 100ms
            t_step                      = GetSecs;
            t_vector(1,i_step_gr)       = t_step;
            i_step_gr                   = i_step_gr + 1;

         elseif settings.do_gamepad == 1
             [b,c] = KbQueueCheck;  
             % Continuously log position and time of the button for the right index
             % finger -> Joystick.Z
             [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
             
             %Buffer routine
             for buffer_i = 2:50 %buffer_size
                    
                joy.pos_Z(count_joy,i_collectMax)    = Joystick.Z;
                joy.time_log(count_joy,i_collectMax) = GetSecs - t_collectMax_onset;
                count_joy                            = count_joy + 1;
                
                if Joystick.Z < 200
                    Joystick.RI_button = 1;
                else
                    Joystick.RI_button = 0;
                end
                
                xbox_buffer(buffer_i) = Joystick.RI_button; %Joystick.Button(1);
                
                if xbox_buffer(buffer_i)==1 && xbox_buffer(buffer_i-1)==0
                    count_joystick = 1;
                    %Stores time stamp of BP
                    t_button = GetSecs; 

                else
                    count_joystick = 0;
                end
                
                if buffer_i == 50
                    buffer_i        = 2;
                    xbox_buffer(1)  = xbox_buffer(50);
                end
                
                if c(keys.resp) > 0 || count_joystick == 1                
                
                    if (t_button > (t_collectMax_onset + 0.1)) %Prevents too fast button press at the beginning                    
                    t_button_vec(1,i_resp) = t_button;
                    %Exponential weightended Average of RT for frequency estimation
                    current_input = t_button - t_buttonN_1;
                    current_weight_fact = forget_fact * prev_weight_fact + 1;
                    Avrg_value = (1-(1/current_weight_fact)) * prev_movingAvrg + ((1/current_weight_fact) * current_input);
                    frequency_estimate = freq_interval/Avrg_value;                    
                    
                    %update Ball height and store frequency for output
                    draw_frequency             = frequency_estimate; 
                    frequency_vector(1,i_resp) = frequency_estimate;                    
                    
                    %Refresh values
                    prev_weight_fact = current_weight_fact; 
                    prev_movingAvrg  = Avrg_value;
                    t_buttonN_1      = t_button;                    
                    
                    collect_freq.avrg(1,i_resp)              = Avrg_value;
                    collect_freq.t_button_interval(1,i_resp) = current_input;                    
                    
                    i_resp         = i_resp + 1;
                    count_joystick = 0;
                    
                    % stores the previous moving average for use in case
                    % button press ceases; used to maintain draw_frequency while 
                    % listening for button presses
                    prev_movingAvrg_phantom(1,2) = prev_movingAvrg_phantom(1,1);
                    prev_movingAvrg_phantom(1,1) = Avrg_value;                
                
                    end
                
                % if no button press happened: Frequency should decrease slowly based on phantom estimates
                % ball stays afloat for a time of 1.5*Avrg_value, meanwhile
                % draw_frequency from last button press is maintained
            
            elseif (GetSecs - t_buttonN_1) < (1.5*Avrg_value) && (i_resp > 1)                    
                
                phantom_t_buttonN_1     = GetSecs - current_input;             
                
                % begin ball descent 
            elseif (GetSecs - t_buttonN_1) > (1.5*Avrg_value) && (i_resp > 1)                    
                
                phantom_current_input   = GetSecs - phantom_t_buttonN_1;
                    current_weight_fact     = forget_fact * prev_weight_fact + 1;
                    Estimate_Avrg_value     = (1-(1/current_weight_fact)) * prev_movingAvrg_phantom(1,2) + ((1/current_weight_fact) * phantom_current_input);
                    phantom.freq            = freq_interval/Estimate_Avrg_value;
                    
                %update Ball height
                    draw_frequency          = phantom.freq;                     
                    
                %Refresh values in phantom output vector
                    prev_weight_fact        = current_weight_fact; 
                    prev_movingAvrg         = Estimate_Avrg_value;                    
                    
                    phantom.avrg(1,i_phantom)               = Avrg_value;
                    phantom.t_button_interval(1,i_phantom)  = current_input;
                    phantom.frequency(1,i_phantom)          = phantom.freq;                     
                    
                    i_phantom = i_phantom + 1;
                    
                end
                
             end
        end
        
    end
    
    % End of trial    
    count_joy = 1;
    
    %% Prepare Output

    if settings.do_gamepad == 0
%         % Store maxEffort for each training trial in a vector, take the minimum, because lower values indicate
%         % higher forces
%         collectMax.maxEffort(1,i_collectMax) = min(effort_vector);
%         collectMax.maxEffort                 = collectMax.maxEffort(collectMax.maxEffort ~= 0); 
%         input_device.maxEffort               = min(collectMax.maxEffort);
%         % Store minEffort for each training trial in a vector
%         if windows
%             collectMax.minEffort(1,i_collectMax) = max(effort_vector);
%         elseif linux
%             collectMax.minEffort(1,i_collectMax) = max(effort_vector(effort_vector<0));
%         end
%         collectMax.minEffort     = collectMax.minEffort(collectMax.minEffort ~= 0);
%         input_device.minEffort   = max(collectMax.minEffort);
        % Reference t_vector to collectMax_onset 
        t_ref_vector          = t_vector - t_collectMax_onset;
    elseif settings.do_gamepad == 1
%         % shorten effort_vector to prevent measurement errors to affect max
%         ffrt_vctr_capped  = effort_vector(1,16:length(effort_vector));
%         % Catch empty trials (if no button prass has happened)
%         if isempty(effort_vector)
%             effort_vector = [nan];
%         end
%         if isempty(t_button_vec)
%             t_button_vec = [nan];
%         end
%         % Store MaxFrequency for each training trial in a vector  
%         collectMax.maxEffort(1,i_collectMax) = max(ffrt_vctr_capped);   
%         collectMax.minEffort(1,i_collectMax) = nan;  
        t_ref_vector         = t_100_vector - t_collectMax_onset;
    end
      
    % Copy Output Values into Output Matrix
    % Name of struct = collectMax; to disentangle from practice trials (!different array size) 
    collectMax.values_per_trial = [collectMax.values_per_trial, [ones(1,length(effort_vector)) * subj.id; ... %Subj_ID
    %                               ones(1,length(effort_vector)) * i_collectMax ; ...                         %Trial_ID
                                   (1:length(effort_vector)) ; ...                                            %t_Button ID
                                   t_ref_vector ; ...                                                         %time referenced to 10 second trial start
                                   effort_vector ; ...                                                        %Force at t_Button
                                   ones(1,length(effort_vector)) * collectMax.maxEffort(1,i_collectMax); ...                %Maximum effort
                                   ones(1,length(effort_vector)) * collectMax.minEffort(1,i_collectMax)]];                  %Minimum effort
    
    % Create & Save temporary output data
    if windows
        collectMax.filename = sprintf('%s\\data\\effort_%s_%s_s%s_temp', pwd, subj.study, subj.subjectID, subj.sessionID);
        save([collectMax.filename '.mat'], 'collectMax', 'subj')
    elseif linux
        collectMax.filename = sprintf('%s/data/effort_%s_%s_s%s_temp', pwd, subj.study, subj.subjectID, subj.sessionID);
        save([collectMax.filename '.mat'], 'collectMax', 'subj')
    end   
    
    %% Clear Variables to initiate new trial

    i_resp          = 1;   
    t_vector        = [];
    effort_vector   = [];
    
    if settings.do_gamepad == 0
        i_step_gr       = 1;
        ForceMat        = initrestforce;        
    else
        draw_frequency  = 0; %resets Ball position
        current_input   = 0;
        i_step_fr       = 1;
        count_joystick  = 0;
        Avrg_value      = 0;
        t_button_vec    = [];
        i_phantom       = 1;
        frequency_vector    = [];
        current_weight_fact = 0;
        frequency_estimate  = 0;
        prev_weight_fact    = 0; 
        prev_movingAvrg     = 0;
        
        collectMax.avrg(1,i_resp)              = Avrg_value;
        collectMax.t_button_interval(1,i_resp) = current_input; 
        
        phantom_current_input       = 0;
        Estimate_Avrg_value         = 0;
        phantom.freq                = 0;
        phantom.avrg                = [];
        phantom.t_button_interval   = [];
        phantom.frequency           = []; 
    end

    WaitSecs(1.5);
    
end

% Prepare Individual maxEffort as input for Trials
effort_vals = collectMax.values_per_trial(4,:);
if settings.do_gamepad == 0
    input_device.maxEffort = min(effort_vals);
    if windows
       input_device.minEffort = max(effort_vals);
    elseif linux
       input_device.minEffort = max(effort_vals(effort_vals<0));
    end
    input_device.minEffort = max(collectMax.values_per_trial(4,:));
elseif settings.do_gamepad == 1
    if prctile(effort_vals,95) <= 7.5
    input_device.maxEffort = prctile(effort_vals,95); 
    else
    input_device.maxEffort = 7.5;     
    end
    input_device.minEffort = nan;
end

%% Calibrate value of food with respect to value of money
if settings.do_val_cal == 1
    collectBid.values_per_trial = [];
    %set bidding variables
    final_effort = zeros(1, 6);
    random_bidcond = bidcond(randperm(size(bidcond, 1)), :); 
    bidding.food = zeros(2,3);
    f_bidcount = 1;
    bidding.money = zeros(2,3);
    m_bidcount = 1;
    
    % instructions
    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.bidding, 'center', Text.height, color.black, 60, [], [], 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum);
    
    for calround = 1:6
        i_collectMax = i_collectMax + 1;
        
        % Prepare graphical display with corresponding reward items    
        % load incentive & counter icon
        if random_bidcond(calround, 1) == 1 && random_bidcond(calround, 2) == 50
            incentive = stim.bidding_money50;
        elseif random_bidcond(calround, 1) == 1 && random_bidcond(calround, 2) == 100
            incentive = stim.bidding_money100;
        elseif random_bidcond(calround, 1) == 1 && random_bidcond(calround, 2) == 200
            incentive = stim.bidding_money200;
        elseif random_bidcond(calround, 1) == 0 && random_bidcond(calround, 2) == 50
            incentive = stim.bidding_food50;
        elseif random_bidcond(calround, 1) == 0 && random_bidcond(calround, 2) == 100
            incentive = stim.bidding_food100;
        elseif random_bidcond(calround, 1) == 0 && random_bidcond(calround, 2) == 200
            incentive = stim.bidding_food200;
        end
        
        %% Show fixation cross at the beginning of each trial 
        fix = '+';
        Screen('TextSize',w,64);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', color.black,80);
        time.fix = Screen('Flip', w);

        WaitSecs(1); %Show screen for 1s

        % Show reward type before start of effort input
        Screen('DrawTexture', w, incentive,[], Coin.loc); 

        % Draw Tube without difficulty
        Screen('DrawLine',effort_scr,color.black,Tube.XCor1, Tube.height, Tube.XCor1, Tube.YBottom ,6);
        Screen('DrawLine',effort_scr,color.black,Tube.XCor2, Tube.height, Tube.XCor2, Tube.YBottom ,6);
        Screen('DrawLine',effort_scr,color.black,Tube.XCor1, Tube.YBottom, Tube.XCor2, Tube.YBottom,6);

        %Incentive
        Screen('DrawTexture', effort_scr, incentive,[], Coin.loc);
        Screen('CopyWindow',effort_scr,w);

        [time.img, starttime] = Screen('Flip', w);
        
        WaitSecs(1.5); %Show screen for 1s before trial start
        
        %% Actual traing trial start (recortstart time)
        t_calibrate_onset = GetSecs;
        t_buttonN_1       = t_calibrate_onset;

        while timings.bidding_length > (GetSecs - t_calibrate_onset)

            % Draw graphical display         
            % Draw Tube
            Screen('DrawLine',effort_scr,color.black,Tube.XCor1 , Tube.height,  Tube.XCor1 , Tube.YBottom,6);
            Screen('DrawLine',effort_scr,color.black,Tube.XCor2 , Tube.height,  Tube.XCor2 , Tube.YBottom,6);
            Screen('DrawLine',effort_scr,color.black,Tube.XCor1 , Tube.YBottom, Tube.XCor2 , Tube.YBottom,6);
            Screen('CopyWindow',effort_scr,w);

            % Draw upper bound blue line 
            if settings.do_gamepad == 0
                if ForceMat < initrestforce       
                    Boundary_yposition = BarBound2Scale*ForceMat + UpperBoundBar - input_device.maxEffort * BarBound2Scale; 
                else            
                    Boundary_yposition = LowerBoundBar;       
                end
            elseif settings.do_gamepad == 1
            % Store for timestamps and actual frequency every 100ms
                t_step = GetSecs;
                if (0.1 * i_step_fr) <= (t_step - t_collectMax_onset)           
                   t_100_vector(1,i_step_fr)   = t_step;
                   effort_vector(1,i_step_fr)  = draw_frequency;
                   i_step_fr                   = i_step_fr + 1;
                end
                Boundary_yposition = Tube.YBottom - Ball.width-draw_frequency * draw_frequency_factor;
            end
            Screen('DrawLine',w,color.darkblue,Tube.XCor1, Boundary_yposition, Tube.XCor2, Boundary_yposition,3);
            
            % Draw Ball
            Ball.position = [(setup.xCen-Ball.width/2) (Boundary_yposition) (setup.xCen+Ball.width/2) (Boundary_yposition + Ball.width)];
            Ball.color = color.darkblue;
            Screen('FillOval',w,Ball.color,Ball.position);
            Screen('Flip', w);
            
            if settings.do_gamepad == 0
                [b,c] = KbQueueCheck;      
                % Continuously log position and time of the button for the right index
                % finger -> Joystick.Z
                if windows
                    if settings.do_fmri == 1 && settings.debug == 0
                        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                    else
                        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec);
                    end
                    gripforce_value = Joystick.Y;                
                elseif linux               
                    axisState       = Gamepad('GetAxis', grip_force_idx, grip_force_axis);
                    gripforce_value = axisState;               
                end               
                % Getting values from Grip Force Device -> Joystick.Y
                ForceMat                = gripforce_value;

                % Saving force over time           
                effort_vector           = [effort_vector, gripforce_value]; 

               % Store for timestamps and actual force every 100ms
                t_step                      = GetSecs;
                t_vector(1,i_step_gr)       = t_step;
                i_step_gr                   = i_step_gr + 1;

             elseif settings.do_gamepad == 1
                 [b,c] = KbQueueCheck;  
                 % Continuously log position and time of the button for the right index
                 % finger -> Joystick.Z
                 [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);

                 %Buffer routine
                 for buffer_i = 2:50 %buffer_size

                    joy.pos_Z(count_joy,i_collectMax)    = Joystick.Z;
                    joy.time_log(count_joy,i_collectMax) = GetSecs - t_collectMax_onset;
                    count_joy                            = count_joy + 1;

                    if Joystick.Z < 200
                        Joystick.RI_button = 1;
                    else
                        Joystick.RI_button = 0;
                    end

                    xbox_buffer(buffer_i) = Joystick.RI_button; %Joystick.Button(1);

                    if xbox_buffer(buffer_i)==1 && xbox_buffer(buffer_i-1)==0
                        count_joystick = 1;
                        %Stores time stamp of BP
                        t_button = GetSecs; 

                    else
                        count_joystick = 0;
                    end

                    if buffer_i == 50
                        buffer_i        = 2;
                        xbox_buffer(1)  = xbox_buffer(50);
                    end

                    if c(keys.resp) > 0 || count_joystick == 1
                        if (t_button > (t_collectMax_onset + 0.1))  % Prevents too fast button press at the beginning
                                                                    % (if keypress starts during fixation phase, 
                                                                    % the initial interval might be too short. 
                                                                    % Frequency estim. distribution becomes skewed)

                            % Add latest button press to vector                         
                            t_button_vec(1,i_resp) = t_button;

                            % Exponential weightended Average of RT for frequency estimation
                            current_input       = t_button - t_buttonN_1;                    
                            current_weight_fact = forget_fact * prev_weight_fact + 1;
                            Avrg_value          = (1-(1/current_weight_fact)) * prev_movingAvrg + ((1/current_weight_fact) * current_input);
                            frequency_estimate  = freq_interval/Avrg_value;


                            % Update Ball height and store frequency for output
                            draw_frequency              = frequency_estimate;
                            frequency_vector(1,i_resp)  = frequency_estimate;

                            % Refresh values
                            prev_weight_fact    = current_weight_fact; 
                            prev_movingAvrg     = Avrg_value;
                            t_buttonN_1         = t_button;

                            collectMax.avrg(1,i_resp)               = Avrg_value;
                            collectMax.t_button_interval(1,i_resp)  = current_input;

                            i_resp          = i_resp + 1;
                            count_joystick  = 0;

                        end
                     elseif (GetSecs - t_buttonN_1) > (1.5 * Avrg_value) && (i_resp > 1)

                        phantom_current_input = GetSecs - t_buttonN_1;
                        current_weight_fact = forget_fact * prev_weight_fact + 1;
                        Estimate_Avrg_value = (1-(1/current_weight_fact)) * prev_movingAvrg + ((1/current_weight_fact) * phantom_current_input);
                        phantom.freq = freq_interval/Estimate_Avrg_value;  

                        % Update Ball height
                        draw_frequency = phantom.freq; 

                        % Refresh values in phantom output vector
                        prev_weight_fact = current_weight_fact; 
                        prev_movingAvrg = Estimate_Avrg_value;

                        % t_buttonN_1 = t_button;                       %Not necessary for phantom count, Last key press remains unchanged 
                        % output.t_button(1,output_index) = t_button;   %Not necessary for phantom count, Last key press remains unchanged

                        phantom.avrg(1,i_phantom) = Avrg_value;
                        phantom.t_button_interval(1,i_phantom) = current_input;
                        phantom.frequency(1,i_phantom) = phantom.freq; 

                        i_phantom = i_phantom + 1;

                    end
                 end
            end
        end
        
            % End of trial    
        count_joy = 1;

        %% Prepare Output

        if settings.do_gamepad == 0
            % Store maxEffort for each training trial in a vector, take the minimum, because lower values indicate
            % higher forces
            collectMax.maxEffort(1,i_collectMax) = min(effort_vector);
            collectMax.maxEffort                 = collectMax.maxEffort(collectMax.maxEffort ~= 0); 
            input_device.maxEffort               = min(collectMax.maxEffort);
            % Reference t_vector to collectMax_onset 
            t_ref_vector             = t_vector - t_collectMax_onset;
        elseif settings.do_gamepad == 1
            % shorten effort_vector to prevent measurement errors to affect max
            ffrt_vctr_capped  = effort_vector(1,16:length(effort_vector));
            % Catch empty trials (if no button prass has happened)
            if isempty(effort_vector)
                effort_vector = [nan];
            end
            if isempty(t_button_vec)
                t_button_vec = [nan];
            end
            % Store MaxFrequency for each training trial in a vector  
            %ffrt_vctr_capped_10max = sort(ffrt_vctr_capped, 'descend'); %changed
            collectMax.maxEffort(1,i_collectMax) = max(ffrt_vctr_capped);   
            %collectMax.maxEffort(1,i_collectMax) = mean(ffrt_vctr_capped_10max(1:10));   

            collectMax.minEffort(1,i_collectMax) = nan;  
            t_ref_vector                         = t_100_vector - t_collectMax_onset;
        end
        
        %determine 'bid' 
        if settings.do_gamepad == 1
            final_effort(calround,1) = effort_vector(end);
        elseif settings.do_gamepad == 0
            final_effort(calround,1) = (((input_device.minEffort - effort_vector(end)) * 100)./(input_device.minEffort - input_device.maxEffort));
        end
        if random_bidcond(calround, 1) == 0
            bidding.food(1, f_bidcount) = final_effort(calround, 1);
            bidding.food(2, f_bidcount) = random_bidcond(calround, 2);
            f_bidcount = f_bidcount + 1;
        else
            bidding.money(1, m_bidcount) = final_effort(calround, 1);
            bidding.money(2, m_bidcount) = random_bidcond(calround, 2);
            m_bidcount = m_bidcount + 1;
        end
        
        % Copy Output Values into Output Matrix
        % Name of struct = collectMax; to disentangle from practice trials (!different array size) 
        collectBid.values_per_trial = [collectBid.values_per_trial, [ones(1,length(effort_vector)) * subj.id; ... %Subj_ID
                                       ones(1,length(effort_vector)) * calround ; ...                             %Trial_ID
                                       (1:length(effort_vector)) ; ...                                            %t_Button ID
                                       %t_ref_vector ; ...                                                         %time referenced to 10 second trial start
                                       effort_vector ; ...                                                        %Force at t_Button
                                       ones(1,length(effort_vector)) * final_effort(1,calround); ...              %Bid for this trial
                                       ones(1,length(effort_vector)) * random_bidcond(calround,1); ...            %reward type bidding
                                       ones(1,length(effort_vector)) * random_bidcond(calround,2); ...            %reward size bididng
                                       ones(1,length(effort_vector)) * collectMax.maxEffort(1,i_collectMax)]];    %Maximum effort

        % Create & Save temporary output data
        if windows
            collectMax.filename = sprintf('%s\\data\\effort_%s_%s_s%s_temp', pwd, subj.study, subj.subjectID, subj.sessionID);
            save([collectMax.filename '.mat'], 'collectMax', 'subj', 'input_device', 'collectBid')
        elseif linux
            collectMax.filename = sprintf('%s/data/effort_%s_%s_s%s_temp', pwd, subj.study, subj.subjectID, subj.sessionID);
            save([collectMax.filename '.mat'], 'collectMax', 'subj', 'input_device', 'collectBid')
        end   

        %% Clear Variables to initiate new trial

        i_resp          = 1;   
        t_vector        = [];
        effort_vector   = [];

        if settings.do_gamepad == 0
            i_step_gr       = 1;
            ForceMat        = initrestforce;        
        else
            draw_frequency  = 0; %resets Ball position
            current_input   = 0;
            i_step_fr       = 1;
            count_joystick  = 0;
            Avrg_value      = 0;
            t_button_vec    = [];
            i_phantom       = 1;
            frequency_vector    = [];
            current_weight_fact = 0;
            frequency_estimate  = 0;
            prev_weight_fact    = 0; 
            prev_movingAvrg     = 0;
            prev_movingAvrg_phantom(1,1) = prev_movingAvrg;


            collectMax.avrg(1,i_resp)              = Avrg_value;
            collectMax.t_button_interval(1,i_resp) = current_input; 

            phantom_current_input       = 0;
            Estimate_Avrg_value         = 0;
            phantom.freq                = 0;
            phantom.avrg                = [];
            phantom.t_button_interval   = [];
            phantom.frequency           = []; 
        end

        
    end

% % Prepare Individual maxEffort as input for Trials
% if settings.do_gamepad == 0
%     collectMax.maxEffort   = collectMax.maxEffort(collectMax.maxEffort ~= 0);
%     input_device.maxEffort = min(collectMax.maxEffort);
%     input_device.minEffort = max(collectMax.minEffort);
% elseif settings.do_gamepad == 1
%     input_device.maxEffort = max(collectMax.maxEffort);
%     input_device.minEffort = nan;
% end

% Determine linear fit money and food value
coeff_money = polyfit(bidding.money(2,:), bidding.money(1,:), 1);
coeff_food  = polyfit(bidding.food(2,:), bidding.food(1,:), 1);

% Compute factor different
eff_money_standard = coeff_money(1)*100 + coeff_money(2);
x_food             = ((eff_money_standard - coeff_food(2))/coeff_food(1))/100; %compute the x-value for which food is worth the same amount of effort as 1 euro

if x_food >= 0.5 && x_food <= 2
    input_device.value_factor    = x_food;
elseif x_food > 2
    input_device.value_factor    = 2;
elseif x_food < 0.5
    input_device.value_factor    = 0.5;
end

value_factor             = input_device.value_factor;
input_device.value_money = settings.value_money;
input_device.value_food  = round(input_device.value_money * input_device.value_factor);

dlmwrite(fullfile('data', [value_file_name '.txt']), value_factor)

elseif settings.do_fmri  == 0
    if isfile(fullfile('data', [value_file_name '.txt']))
        input_device.value_factor = dlmread(fullfile('data', [value_file_name '.txt']));
        input_device.value_money  = settings.value_money;
        input_device.value_food   = round(input_device.value_money * input_device.value_factor);
    else
        input_device.value_food   = settings.value_food;
        input_device.value_money  = settings.value_money;
        input_device.comp_factor  = nan;
        collectBid                = [];
    end
    
elseif settings.do_val_cal == 0
    
    input_device.value_money = settings.value_money;
    input_device.value_food  = settings.value_food;
    
end

%% End of TRAINING