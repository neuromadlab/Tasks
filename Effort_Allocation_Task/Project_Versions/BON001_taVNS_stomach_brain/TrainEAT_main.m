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
    %         if (settings.do_fmri == 1) && (settings.debug == 0)
    initrestforce    = getfield(GripForceSpec, 'restforce'); %normal holding force
    initmaxforce     = getfield(GripForceSpec, 'maxpossibleforce'); %upper limit of GFD
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    clckforce = 10000;
    %         else
    %             initrestforce    = getfield(GripForceSpec, 'restforce'); %normal holding force
    %             initmaxforce     = getfield(GripForceSpec, 'maxpossibleforce'); %upper limit of GFD
    %             [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec);
    %             clckforce = 25000;
    %         end
    gripforce_valueL = Joystick.X;
    gripforce_valueR = Joystick.Y;
    gripforce_value = max(Joystick.X, Joystick.Y);


    i_step_gr           = 1;  % Enummarate over loops
    delta_pos_force     = initmaxforce - initrestforce;
    ForceMat            = initrestforce;
    effort_vector       = [];
    effort_vectorL       = [];
    effort_vectorR       = [];
    LowerBoundBar       = setup.ScrHeight - Tube.offset - Ball.width;
    UpperBoundBar       = Tube.height + Ball.width;
    BarBoundAbs         = LowerBoundBar - UpperBoundBar;
    BarBound2Scale      = BarBoundAbs/delta_pos_force;

    max_Boundary_yposition  = LowerBoundBar;

end

%% Prepare output structures to determine max effort across training
collectMax.values_per_trial = [];

%% start training
% basic instructions
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
if settings.do_fmri == 0
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.train_instr, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
else
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.train_instr_left, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
end
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
Screen('Flip',w);

if settings.do_fmri == 0
    while Joystick.Button(1) ~= 1
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    end
    WaitSecs(0.5);
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);


    % first round instructions
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.first_round_train, 'center', Text.height, color.black, 60, [], [], 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);
    while Joystick.Button(1) ~= 1
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    end
    WaitSecs(0.5);
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

elseif settings.do_fmri == 1
    WaitSecs(4);
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    gripforce_value = max(Joystick.X, Joystick.Y);
    while gripforce_value < clckforce
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        gripforce_valueL = Joystick.X;
        gripforce_valueR = Joystick.Y;
        gripforce_value = max(Joystick.X, Joystick.Y);
    end
end

for i_collectMax = 1:settings.train_trials
    %% instructions
    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');
    if settings.do_fmri == 1
        if i_collectMax == 2
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.second_round_train_left, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
            Screen('Flip',w);
            WaitSecs(3);
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_value = max(Joystick.X, Joystick.Y);
            while gripforce_value < clckforce
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                gripforce_valueL = Joystick.X;
                gripforce_valueR = Joystick.Y;
                gripforce_value = max(Joystick.X, Joystick.Y);
            end
        elseif i_collectMax == 3
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.middle_round_train, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
            Screen('Flip',w);
            WaitSecs(3);
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_value = max(Joystick.X, Joystick.Y);
            while gripforce_value < clckforce
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                gripforce_valueL = Joystick.X;
                gripforce_valueR = Joystick.Y;
                gripforce_value = max(Joystick.X, Joystick.Y);
            end
        elseif i_collectMax == 4
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.first_round_train_right, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
            Screen('Flip',w);
            WaitSecs(3);
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_value = max(Joystick.X, Joystick.Y);
            while gripforce_value < clckforce
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                gripforce_valueL = Joystick.X;
                gripforce_valueR = Joystick.Y;
                gripforce_value = max(Joystick.X, Joystick.Y);
            end
        elseif i_collectMax == 5
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.second_round_train_right, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
            Screen('Flip',w);
            WaitSecs(3);
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_value = max(Joystick.X, Joystick.Y);
            while gripforce_value < clckforce
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                gripforce_valueL = Joystick.X;
                gripforce_valueR = Joystick.Y;
                gripforce_value = max(Joystick.X, Joystick.Y);
            end
        end

    elseif settings.do_fmri == 0
        if i_collectMax == 2 && settings.train_trials == 3
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.middle_round_train, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
            Screen('Flip',w);
            while Joystick.Button(1) ~= 1
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            end
            WaitSecs(0.5);
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        elseif i_collectMax ~= 1
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.last_round_train, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
            Screen('Flip',w);
            while Joystick.Button(1) ~= 1
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            end
            WaitSecs(0.5);
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
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
            if ForceMat > initrestforce
                %                  Boundary_yposition = BarBound2Scale*ForceMat + UpperBoundBar + initmaxforce * BarBound2Scale;
                Boundary_yposition = LowerBoundBar - BarBound2Scale*(ForceMat - initrestforce);
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

        if settings.do_fmri == 1
            max_Boundary_yposition = min(max_Boundary_yposition, Boundary_yposition);
            Screen('DrawLine',w,color.darkblue,Tube.XCor1, max_Boundary_yposition, Tube.XCor2, max_Boundary_yposition,3);
        end


        % Draw Ball
        Ball.position = [(setup.xCen-Ball.width/2) (Boundary_yposition) (setup.xCen+Ball.width/2) (Boundary_yposition + Ball.width)];
        Ball.color = color.darkblue;
        Screen('FillOval',w,Ball.color,Ball.position);
        Screen('Flip', w);

        if settings.do_gamepad == 0
            [b,c] = KbQueueCheck;
            % Continuously log position and time of the button for the right index
            % finger -> Joystick.Z
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_valueL = Joystick.X;
            gripforce_valueR = Joystick.Y;
            gripforce_value = max(Joystick.X, Joystick.Y);
            % Getting values from Grip Force Device -> maximum value of
            % Joystick.X and Joystick.Y
            ForceMat                = gripforce_value;

            % Saving force over time
            effort_vector           = [effort_vector, gripforce_value];
            effort_vectorL          = [effort_vectorL, gripforce_valueL];
            effort_vectorR          = [effort_vectorR, gripforce_valueR];

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
        t_ref_vector          = t_vector - t_collectMax_onset;
    elseif settings.do_gamepad == 1
        t_ref_vector         = t_100_vector - t_collectMax_onset;
    end

    % Copy Output Values into Output Matrix
    % Name of struct = collectMax; to disentangle from practice trials (!different array size)
    if settings.do_gamepad == 0
        collectMax.values_per_trial = [collectMax.values_per_trial, [ones(1,length(effort_vector)) * subj.id; ... %Subj_ID
            %                               ones(1,length(effort_vector)) * i_collectMax ; ...                         %Trial_ID
            (1:length(effort_vector)) ; ...                                            %t_Button ID
            t_ref_vector ; ...                                                         %time referenced to 10 second trial start
            effort_vector ; ...                                                        %Force at t_Button
            effort_vectorL; ...                                                        %Force left (x-axis)
            effort_vectorR; ]];                                                        %Force right (y-axis)
    else
        collectMax.values_per_trial = [collectMax.values_per_trial, [ones(1,length(effort_vector)) * subj.id; ... %Subj_ID
            %                               ones(1,length(effort_vector)) * i_collectMax ; ...                         %Trial_ID
            (1:length(effort_vector)) ; ...                                            %t_Button ID
            t_ref_vector ; ...                                                         %time referenced to 10 second trial start
            effort_vector ;]];                                                        %Force at t_Button

    end

    % Create & Save temporary output data
    collectMax.filename = sprintf('%s\\data\\effort_%s_%s_s%s_temp', pwd, subj.study, subj.subjectID, subj.sessionID);
    save([collectMax.filename '.mat'], 'collectMax', 'subj')

    %% Clear Variables to initiate new trial

    i_resp          = 1;
    t_vector        = [];
    effort_vector   = [];
    if settings.do_gamepad == 0 && windows
        effort_vectorL       = [];
        effort_vectorR       = [];
    end

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
    effort_valsL = collectMax.values_per_trial(5,:);
    effort_valsR = collectMax.values_per_trial(6,:);
%     input_device.maxEffort = max(effort_vals);
    input_device.maxEffort = prctile(effort_vals,95);
    input_device.minEffort = min(min(effort_valsL, effort_valsR));
%     input_device.maxEffortL = max(effort_valsL);
input_device.maxEffortL = prctile(effort_valsL,95);
    input_device.minEffortL = min(effort_valsL);
%     input_device.maxEffortR = max(effort_valsR);
input_device.maxEffortR = prctile(effort_valsR,95);
    input_device.minEffortR = min(effort_valsR);
elseif settings.do_gamepad == 1
    if prctile(effort_vals,95) <= 7.5
        input_device.maxEffort = prctile(effort_vals,95);
    else
        input_device.maxEffort = 7.5;
    end
    input_device.minEffort = nan;
end



input_device.value_money = settings.value_money;
input_device.value_food  = settings.value_food;


%% End of TRAINING