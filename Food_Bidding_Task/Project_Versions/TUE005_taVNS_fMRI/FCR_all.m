    %%===================Food evaluation paradigm===================
%For a description of the set of images, see Charbonnier (2015) Appetite

%Coded by: Nils Kroemer 
%Coded with: Matlab R2014a using Psychtoolbox 3.0.11
%
% new SubjID format (6-digits) introduced by Monja, 2019-04-01
% Script made compatible with different input devices by Mechteld, 2019
%
%========================================================

clear

subj.version = 2; %Task version
subj.study = 'TUE005';
if strcmp(subj.study, 'TUE002')
    subj.sessionID = '2';
elseif strcmp(subj.study, 'TUE005')
    subj.sessionID = input('Session ID [1/2]: ','s');
end
subj.runID = '1';

%% General settings
% Change flags to customize script
name_file = strcat('FCRsettings_', subj.study, '_S', subj.sessionID, '_R', subj.runID);
load(name_file);

% debug = 0; % set to 1 for tests
% 
% settings.do_fullscreen  = 1; %will show window as fullscreen (default second monitor, if connected)
% settings.do_joystick    = 0;
% settings.do_gamepad     = 0;
% settings.do_GFD         = 0; %will load specific parameters for the use uf the grip force device for bidding (scale)
% settings.do_fmri        = 0; %will include trigger
% settings.lang_de        = 1; %changes display language to German


% Automatic operating information
Screen('Preference', 'SkipSyncTests', 1);

% Get operating system and set OS flags
system_info = Screen('Computer');
    windows = system_info.windows;
        mac = system_info.osx;
      linux = system_info.linux;

% Set up EGG triggers if needed
if settings.do_EGG == 1
    
    % Add path for io64 function
    addpath 'D:\home\sektion\AG_Walter\taVNS'
    % Generate LPT I/O object
    LPT_IO_EGG = io64;
    % Check if status of the port is 0
    status = io64(LPT_IO_EGG);
    if status == 0
        disp('LPT port status for EGG triggers OK, continue task...')
		
		% Write trigger for signaling start of FCR 
		io64(LPT_IO_EGG,settings.EGG.port_address,2);
		
    else
        error('LPT port status ~= 0, please check...')
    end 
    
end
  
%% Get subject info 
     subj.date = datestr(now, 'yyyymmdd-HHMM');

% Get subject info from the MATLAB console    
if settings.debug == 1
    subj.subjectID = '900005'; % debugging
    subj.runID = '1';
else
    subj.subjectID = input('Subject ID: ','s');
%     if strcmp(subj.study, 'TUE005')
%        subj.sessionID = input('Session ID [1/2]: ','s'); 
%     end
    subj.runID = input('Run ID: ','s');
end

if settings.do_VNS == 1
   settings.stim_cond = input('Stimulation condition [1 for sham / 2 for taVNS]: ');
   if settings.stim_cond == 1
      settings.code_stim_cond = 'sham';
   elseif settings.stim_cond == 2
      settings.code_stim_cond = 'taVNS'; 
   end
else
   settings.code_stim_cond = 'no_stim';
end
   
    

% Convert subject info
    %subj.subjectID = pad(subj.subjectID,6,'left','0'); % converts Subject
    %ID to 6 digits, filled with zeros, not working with Matlab2014 at the MR
    subj.subjectID = [repmat('0',1,6-length(subj.subjectID)) subj.subjectID];
    subj.id = str2double(subj.subjectID);   % converts Subject ID to integer
    subj.sess = str2double(subj.sessionID); % converts Session ID to integer
    subj.run = str2double(subj.runID);      % converts Run ID to integer


%%  Set task parameters

% Set image conditions according to run information
% For TUE002 (BEDVAR study)
% Run 1 (=rep 1+2) and Run 2 (=rep 3+4) -> food images only
% Run 3 (=rep 5-8) -> non-food images (NF) only
if settings.do_fmri ~= 1
    
    if (subj.run == 1 || subj.run == 2)
       settings.do_NF = 0;
       start_rep = (subj.run*2 - 1);
       end_rep = (subj.run*2);

    else %subj.run == 3

       settings.do_NF = 1; % 1 loads NF items for the task during taste test
       start_rep = 5;
       end_rep = 8;

    end
    
else
    
       settings.do_NF = 0;
       start_rep = 1;
       end_rep = 1;
end

% Include timing variables for use in MRI environment
if settings.do_fmri == 1
    
    dummy_volumes = 0; % will have to be set according to the sequence
    MR_timings.dummy_volumes = dummy_volumes;
    count_trigger = 0;
    block_length = 5; %will present 5 images in a block
    timing.pic_dur = 3.5; %sets duration for the display of the pictures
    MR_timings.durations.image = timing.pic_dur; % set duration for MR accordingly
    timing.responding_time = 5; %responding time with GFD
    MR_timings.durations.scales.GFD = timing.responding_time; % set duration for MR accordingly
    timing.secs_for_average = 2; %Last X seconds of which the average will be taken
    timing.last_secs_counted = timing.responding_time - timing.secs_for_average; %Time starting point for taking average
    timing.min_ISI = 1.5;
    flip_flag_horizontal = 1;
    flip_flag_vertical = 0;
    
else
    
    timing.pic_dur = 2;
    timing.min_ISI = 0.4;
    
end
   
    timing.feedback_delay = 0.20; %for scales
    timing.max_dur_rating = 2.8; %after the specified seconds, the rating screen will terminate


    
% Display settings
    color_scale_background = [255 255 255]; %white
    color_scale_anchors = [0 0 0]; %black

    screen_offset_y = 0.01; %relative offset; positive values move the screen towards to top, negative towards the bottom
    scale_offset_y = 0.25;
    
do_scales = 1; %will run scale in prob_scales*100% of trials
preset = 1; %will skip separate initialization of scales   
    
    
% Key settings
keyTrigger=KbName('5%');
keyTrigger2=KbName('5');
keyQuit=KbName('q');
keyResp=KbName('1');
keyResp2=KbName('1');


%% Input device settings

% Get PowerMate infos
if linux
    
   PowerMateID = PsychPowerMate('List');
   
   if ~isempty(PowerMateID)
       
       PowerMateHandle = PsychPowerMate('Open', PowerMateID);
       vas_powermate = 1;
       
   else
       
       warning('Although FCR is run on a Linux system, no connected PowerMate could be found as input device for the VAS. Defaulting to mouse input now!')
       vas_powermate = 0;
       
   end
   
else
    
    vas_powermate = 0;
    
end

%load('JoystickSpecification_Genius.mat');
load('JoystickSpecification.mat');


% Screen settings
screens = Screen('Screens'); %Define display screen
screenNumber = max(screens);

if settings.do_fullscreen == 1

    w = Screen(screenNumber,'OpenWindow',[255 255 255]);
    HideCursor()
    
else
    
    w = Screen('OpenWindow', 0, 255, [10 30 810 630]);
    Screen('Preference', 'SkipSyncTests', 1);
    
end

    % Get the center coordinates
    [ww, wh] = Screen('WindowSize', w);

% Image sacling according to screen settings 
% window width: ww, and window height: wh
    scale_x = ww/1024;
    scale_y = wh/768;
    x_cent = ww/2;
    y_cent = wh/2;

    
% Load images information and randomization from condition matrix

if settings.do_fmri == 1
    
    part_file = sprintf(['Order_' subj.study '_fMRI/FCRcond_mat_' subj.study '_fmri.mat']);

else
    
    if settings.do_NF == 0

        part_file = sprintf(['Order_' subj.study '/FCRcond_mat_' subj.study '_%06d.mat',subj.id]);
   
    else
        
        part_file = sprintf(['Order_' subj.study '_NF/FCRcond_mat_' subj.study '_%06d.mat',subj.id]);
  
    end
end

load(part_file)



%RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock))); %resets the seed for the random number generator

if strcmp(subj.study, 'TUE002') || strcmp(subj.study, 'TUE005')
    
        p_trials = length(design.rand.image_mat); % for Behav: 60 images per rep
                                                  % for fMRI: 60 images
                                                  % with 2 reps
        
else %e.g. strcmp(subj.study, 'TUE004')
    
    p_trials = 120; %as used in behavioral tVNS study
    
end

% Initialize output variables
%out_resp = zeros(p_trials,1); %stores the number of button presses

% Initialize output matrix
output.data_mat_hrzntl = [];

if settings.do_fmri == 1 
   output.rel_force = double.empty(0,3); 
end


%initialize VARs
rating = 0;
text_freerating = [];

%% GFD parameters 

if settings.do_GFD == 1
    load('GripForceSpec.mat')
   % Load maximum frequency (always from Session 1, runLABEL==training)
     %main_folder = pwd;
%     if debug == 1
%         effort_folder = 'C:\Users\Monja\Google Drive\TUE_general\Tasks\Effort\Effort_task_scripts16';
%     else
%         effort_folder = 'D:\home\sektion\AG_Walter\BEDVAR\Effort_task_scripts16';
%     end
    %cd Data
    maxeffort_searchname = [[pwd filesep 'Data' filesep 'TrainEAT_' subj.study '_'  subj.subjectID '_S' subj.sessionID '_R1.mat']];
%     maxeffort_searchname = dir(maxeffort_searchname);

    %maxeffort_filename = sprintf('%s\\Data\\%s', pwd, maxeffort_searchname.name);

    load(maxeffort_searchname, 'input_device');
    %cd(main_folder)
    % Drawing parameters for Tube
    Tube.width = round(ww * .20);
    Tube.offset = round((wh - (wh * .95)) * .35);
    Tube.height = round(Tube.offset+wh/4);

    % Drawing parameters for Ball
    Ball.width = round(ww * .06);
    ball_color = [0 0 139];

    % timings
    i_step = 1; %loops through each iteration of the while loop (to place time stamps)
    t_vector = [];

    % Parameters to draw ball movement force using individual max and min Effort

    restforce = input_device.minEffort - 0.05*(input_device.minEffort - input_device.maxEffort); % 5% over min force
    maxpossibleforce = input_device.maxEffort; %upper limit of GFD
    delta_pos_force = input_device.minEffort - maxpossibleforce; 
    clckforce = input_device.minEffort - 0.35*abs(input_device.minEffort - input_device.maxEffort);
    if (settings.debug == 1 && settings.do_fmri == 1) || settings.do_fmri ~= 1
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    else
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    end
    gripforce_value = Joystick.Y;

    ForceMat = restforce; %current force. Starts at restforce to start ball at bottom
    ForceTime = []; %matrix that saves force over time
    LowerBoundBar = wh - Tube.offset - Ball.width; %height at which the bar starts when ForceMat = restforce
    UpperBoundBar = Tube.height; %heighest allowed position of bar
    
else
    input = ['no Grip force input required'];
end



%% Show instructions on screen

Instructions_FCR

Screen('TextSize',w,28);
Screen('TextFont',w,'Arial');
if settings.do_fmri == 1
    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text_p1, 'center', 'center', [0 0 0],150, flip_flag_horizontal, flip_flag_vertical);
else
    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text_p1, 'center', 'center', [0 0 0],150);
end
[ons_resp, starttime] = Screen('Flip', w, []);

if settings.do_fmri ~= 1
    GetClicks;
end

if (~isempty(instruct.text_p2))
Screen('TextSize',w,28);
Screen('TextFont',w,'Arial');
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text_p2, 'center', 'center', [0 0 0],150);
[ons_resp, starttime] = Screen('Flip', w, []);

GetClicks;
end

% =========================
%% start of the experiment
% =========================

% Listen for fmri triggers
if settings.do_fmri == 1
    
    MR_timings.on_trigger_loop = GetSecs;
    
    KbQueueCreate();
    KbQueueFlush(); 
	KbQueueStart(); 
	%[ons_resp, starttime] = Screen('Flip', w, []);
    [b,c] = KbQueueCheck;
    
    % in MR environment: count triggers until start of imgage display
    while c(keyQuit) == 0
        [b,c] = KbQueueCheck;
        if c(keyTrigger) || c(keyTrigger2) > 0
            count_trigger = count_trigger + 1;
            MR_timings.trigger.all(count_trigger,1) = GetSecs;
            if count_trigger > dummy_volumes
                MR_timings.trigger.fin = GetSecs;
                break
            end
        end
    end
    
elseif settings.do_fmri == 0

    MR_timings.trigger.fin = GetSecs;
end
    
KbQueueRelease();

timestamps.exp_on = GetSecs;

% Trigger EGG
if settings.do_EGG == 1
    
    % Write trigger for EGG - start of the experiment 
    io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.exp_on); 
end

%load jitters and initialize jitter counters

if settings.do_fmri == 1 
    load('DelayJitter_mu_2.5_max_12_trials_48.mat');
elseif (settings.do_fmri == 0 && settings.do_NF == 0)
    load('DelayJitter_mu_0.30_max_4_trials_120.mat');
else
    load('DelayJitter_mu_0.30_max_4_trials_40.mat');
end    

% loop through number of repetitions

% 2 repetitions of the images sets for run 1&2
% 4 repetitions of (NF) image set for run 3
for rep = start_rep : end_rep

    
    %initialize settings
    %s = RandStream('mt19937ar','Seed','shuffle'); %reseed for MATLAB2014
    %RandStream.setGlobalStream(s);
    
    % For behavioral version, shuffle jitter, save seed
    % For fMRI version, keep jitter order for all subjects
    if settings.do_fmri == 0
        jitter = Shuffle(DelayJitter);
        timestamps.seed(rep) = rng;
    else %do not shuffle for MR version to keep jitters consistent across participants
        jitter = DelayJitter;
        MR_timings.jitter = jitter;
    end
        count_jitter = 1;
    
    for i_trial = 1 : p_trials
        
        
        % Determine if _trial is start or end of a picture block
        % to save block onset (block_status ==1) or show fixation cross (block_status==5)
        if settings.do_fmri == 1 
            
            block_status = mod(i_trial, block_length);
            
        end
        
        %% Show image
        
        % load image for trial i
        if settings.do_NF == 0

            image_path = sprintf('Stimuli_TUE002/%s', design.rand.image_file{i_trial,rep});

        else 
            NF_clmn_index = rep - 4;
            image_path = sprintf('Stimuli_TUE002/%s', design.rand.image_file{i_trial,NF_clmn_index});
        end

        [Pic, map, alpha] = imread(image_path);

        %Texture_Pic = Screen('MakeTexture', w, Pic);
        %Screen('DrawTexture', w, Texture_Pic, [], [0 0 ww wh]);
        
        Screen('PutImage', w, Pic, [0 0 ww wh]);
        [ons_resp, starttime] = Screen('Flip', w);
        
        % Trigger EGG
        if settings.do_EGG == 1
            % Write trigger for EGG - picture presentation 
            io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.image); 
        end
        
        MR_timings.onsets.image(i_trial,rep) = starttime - MR_timings.trigger.fin;
        timestamps.image(i_trial,rep) = starttime;


   
        WaitSecs(timing.pic_dur);
        
        % Trigger EGG
        if settings.do_EGG == 1
            % Write trigger for EGG - end of picture presentation 
            io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.image_end); 
        end
        
       %% Fixation cross fix1 (for fMRI: not within block)

        if settings.do_fmri == 0 || block_status == 0
        
            %Show fixation cross
            fixation = '+';
            Screen('TextSize',w,64);
            Screen('TextFont',w,'Arial');
            DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);

            [ons_resp, starttime] = Screen('Flip', w);
            
            MR_timings.onsets.fix1(i_trial,rep) = starttime - MR_timings.trigger.fin;
            timestamps.fix1(i_trial,rep) = starttime;
            MR_timings.durations.fix1(i_trial,rep) = timing.min_ISI+jitter(count_jitter);
            
            WaitSecs(timing.min_ISI+jitter(count_jitter));
            count_jitter = count_jitter + 1;

%             timestamps.scale_trigger = GetSecs;
%             MR_timings.onsets.scales.all(i_trial,rep) = timestamps.scale_trigger - MR_timings.trigger.fin;
  
        end
        


        %% Show rating scale
        % For behavioral version: Show rating scale after each picture
        %   (scale type determined by conditions file)
        % For fMRI version: show 5 pictures in a row without scales
        %   Rating via Grip force
        
        if settings.do_fmri == 1 && block_status ~= 0
             show_scale = 0;
        else
            show_scale = 1;
        end
        
      
        if show_scale == 0
            
            call_scale = [];
            
        elseif (show_scale == 1 && settings.do_fmri == 1)
            
            % show GRip force
            call_scale = 'bidding_GFD';
            
        elseif (show_scale == 1 && settings.do_fmri == 0)
            
            % Determine type of rating scale according to conditions file       
            if settings.do_NF == 0
                
                if design.rand.full_flip_coin(i_trial,rep) == 0
                    call_scale = 'LHS';
                else
                    call_scale = 'VAS';
                end

            else %settings.do_NF ==1
                if design.rand.full_flip_coin(i_trial,NF_clmn_index) == 0
                    call_scale = 'LHS';
                else
                    call_scale = 'VAS';
                end
            end
            
        end
        
        
        
            % Call scales for defined input device
            if strcmp(call_scale, 'LHS')
                
                rating_type_num = 0;
                
                output.rating.type_num(i_trial,1) = rating_type_num;
                
                % Trigger EGG
                if settings.do_EGG == 1
                    % Write trigger for EGG - LHS scale 
                    io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.scales.LHS); 
                end
                
                if linux || (settings.do_joystick == 0 && settings.do_gamepad == 0)
                    LHS_vertical_all
                elseif settings.do_joystick == 1
                    LHS_vertical_joystick
                elseif settings.do_gamepad == 1
                    LHS_vertical_gamepad
                end
                
                % Trigger EGG
                if settings.do_EGG == 1
                    % Write trigger for EGG - LHS scale end
                    io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.scales.LHS_end); 
                end
                               
                timestamps.scales.LHS(i_trial,rep) = starttime;
                MR_timings.onsets.scales.LHS(i_trial,rep) = starttime - MR_timings.trigger.fin;
                
                timestamps.RT.scales.LHS(i_trial,1) = GetSecs - timestamps.scales.LHS(i_trial,rep);
                timestamps.RT.scales.all(i_trial,1) = timestamps.RT.scales.LHS(i_trial,1);

            elseif strcmp(call_scale, 'VAS')
                
                rating_type_num = 1;
                
                output.rating.type_num(i_trial,1) = rating_type_num;
                
                % Trigger EGG
                if settings.do_EGG == 1
                    % Write trigger for EGG - VAS scale 
                    io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.scales.VAS); 
                end
                
                if linux ||(settings.do_joystick ==0 && settings.do_gamepad == 0)
                    VAS_horz_all
                elseif settings.do_joystick == 1
                    VAS_horz_joystick
                elseif settings.do_gamepad == 1
                    VAS_horz_gamepad
                elseif do_trackpad == 1
                    VAS_horz_trackpad
                end
                
                % Trigger EGG
                if settings.do_EGG == 1
                    % Write trigger for EGG - VAS scale 
                    io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.scales.VAS_end); 
                end
                
                timestamps.scales.VAS(i_trial,rep) = starttime;
                MR_timings.onsets.scales.VAS(i_trial,rep) = starttime - MR_timings.trigger.fin;
                
                timestamps.RT.scales.VAS(i_trial,rep) = GetSecs - timestamps.scales.VAS(i_trial,rep);
                timestamps.RT.scales.all(i_trial,rep) = timestamps.RT.scales.VAS(i_trial,rep);
                
            elseif  strcmp(call_scale, 'bidding_GFD')
                
                rating_type_num = 2;
                
                output.rating.type_num(i_trial,1) = rating_type_num;
                
                % Trigger EGG
                if settings.do_EGG == 1
                    % Write trigger for EGG - GFD scale 
                    io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.scales.GFD); 
                end

                GFD_tube
                
                % Trigger EGG
                if settings.do_EGG == 1
                    % Write trigger for EGG - end GFD scale 
                    io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.scales.GFD_end); 
                end

                timestamps.scales.GFD(i_trial,rep) = starttime;
                MR_timings.onsets.scales.GFD(i_trial,rep) = starttime - MR_timings.trigger.fin;
                
                timestamps.RT.scales.GFD(i_trial,1) = GetSecs - timestamps.scales.GFD(i_trial,rep);
                timestamps.RT.scales.all(i_trial,1) = timestamps.RT.scales.GFD(i_trial,1);
                
                flag_resp = 0;
        
        end
       
        
        
        
        %% show fixation 2
        if ~isempty(call_scale)
        
            fixation = '+';
            Screen('TextSize',w,64);
            Screen('TextFont',w,'Arial');
            DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);

            [ons_resp, starttime] = Screen('Flip', w);
            MR_timings.onsets.fix2(i_trial,rep) = starttime - MR_timings.trigger.fin;
            timestamps.fix2(i_trial,rep) = starttime;

           if settings.do_fmri == 0
               
                if (show_scale == 1 && flag_resp == 1)

                    WaitSecs((timing.max_dur_rating-timestamps.RT.scales.all(i_trial,1))+jitter(count_jitter));

                elseif (show_scale == 1 && flag_resp == 0) %for MR after block end

                    WaitSecs((0.5-timing.feedback_delay)+jitter(count_jitter));
                    
                    % If no submission was given via inout device, store last
                    % slider position
                    % output.rating.value(i_trial,1) = rating;
                    output.rating.label{i_trial,1} = text_freerating;
                    output.rating.subm(i_trial,1) = 0;
                    output.rating.type_num(i_trial,1) = rating_type_num;
                    
                end
                
           elseif settings.do_fmri == 1
               
               MR_timings.durations.fix2(i_trial,rep) = timing.min_ISI+jitter(count_jitter);
               WaitSecs(timing.min_ISI+jitter(count_jitter));
               
           end
            
            count_jitter = count_jitter + 1;
           
        end 
        
        % for "unrated" trials, put dummy values in output matrix
        if (settings.do_fmri == 1 && show_scale == 0)
            
            rating_type_num = NaN;
            output.rating.value(i_trial,1) = NaN;
            output.rating.subm(i_trial,1) = NaN;
            timestamps.RT.scales.all(i_trial,1) = NaN;
            
        end
        
        if settings.do_NF == 0
             img_ID_col = rep;
        elseif settings.do_NF == 1                       
             img_ID_col = NF_clmn_index;
        end
        
%         if (debug == 1 && settings.do_fmri == 0)
%             
%             design.rand.order_mat(i_trial,1:9) = NaN;
%             
%         end
        
        output.data_mat_hrzntl = [output.data_mat_hrzntl, [subj.id; ...         % subject ID
                                 subj.sess; ...                                 % session 
                                 subj.run; ...                                  % run number
                                 rep; ...                                       % rep number
                                 i_trial; ...                                   % trial number             
                                 design.rand.image_file(i_trial,img_ID_col);... % image ID from design matrix
                                 design.rand.image_mat(i_trial,img_ID_col); ... % image index from design matrix
                                 design.rand.order_mat(i_trial,7); ...         %image factors [food]
                                 design.rand.order_mat(i_trial,8); ...           %image factors [sweet]
                                 design.rand.order_mat(i_trial,9); ...           %image factors [hcal]
                                 rating_type_num; ...                           % scale used (0 = LHS, 1 = VAS, 2 = GFD)
                                 output.rating.value(i_trial,1); ...            % Rating value
                                 output.rating.subm(i_trial,1); ...             % submitted through button press (1), or time ran out (0)
                                 timestamps.RT.scales.all(i_trial,1);]]; % reaction time
      
        
         %Save task version                    
         output.version = subj.version;
        
        % save temporary file
        
        %filename = sprintf('FCR_beh_%04d_%01d_temp',subj.id, subj.sess);
        filename = ['FCRbeh_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_R', subj.runID, '_temp_', subj.date ];
        save(fullfile('Backup', [filename '.mat']),'design','output','subj','timestamps');


       

    end
    
    if rep==6
        
       i_timer = 1;
        
       timer_onset_feedback = GetSecs;
        
        while i_timer <= 60
            
            while i_timer > GetSecs - timer_onset_feedback

               text = ['Sie haben jetzt die Haelfte geschafft. Sie koennen eine kleine Pause machen. \n\n\n' num2str(60 - i_timer) '    Sekunden bis zur naechsten Runde.'];

               % Draw Text
               Screen('TextSize',w,28);
               Screen('TextFont',w,'Arial');
               [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text, 'center', 'center', [0 0 0],150);
               [ons_resp, starttime] = Screen('Flip', w, []);

            end

            i_timer = i_timer + 1;
        end
    end
    
end

%last fixation
fixation = '+';
Screen('TextSize',w,64);
DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);

[ons_resp, starttime] = Screen('Flip', w);
timestamps.fix_fin = starttime;
MR_timings.onsets.fix_fin = starttime - MR_timings.trigger.fin ;

if settings.do_fmri == 1
    MR_timings.durations.fix_fin = 15;
    WaitSecs(15);
else
    WaitSecs(1+jitter(count_jitter-1));
end

% Trigger EGG
if settings.do_EGG == 1
    % Write trigger for EGG - end of the experiment 
    io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.exp_off); 
end

timestamps.exp_end = GetSecs;

% add more preprocessing / output info before saving

output.data_mat = output.data_mat_hrzntl';
output.data_mat_hrzntl = [];

output.data_mat_labels = {1, 'subjID', 'numerical';...
                         2, 'sessID', 'study TUE002: 1)behavioral, 2)imaging';...
                         3, 'runID', 'numerical';...
                         4, 'rep', 'relevant for study TUE002, because images are presented repeatedly'; ...
                         5, 'trialID', 'numerical';...
                         6, 'img_file', 'file name as in folder Stimuli_TUE002';...
                         7, 'img_indx', 'index in reduced stimlulus vector';...
                         8, 'img_food', '1 if food, 0 if NF';...
                         9, 'img_sweet', '1 if sweet, 0 if not sweet';...
                         10, 'img_hcal', '1 if high caloric, 0 if not high caloric';...
                         11, 'rating_type', 'scale used (0 = LHS, 1 = VAS, 2 = GFD)';...
                         12, 'rating_value', 'position of slider [0-100 at scale]/ball[0-100% force]';...
                         13, 'rating_subm', '1 if submitted, 0 if not';...
                         14, 'rating_duration', 'response time'};

                     if settings.do_fmri == 1
                     block_count = 1;                     
                        for i_imgvect = 1 : length(MR_timings.onsets.image)                     
                            if mod(i_imgvect,block_length) == 1
                                MR_timings.onsets.block(block_count,1) = MR_timings.onsets.image(i_imgvect);
                                block_count = block_count + 1;
                            end
                        end
                     
                        % delete 'zero'-elements
                        MR_timings.onsets.fix1 = MR_timings.onsets.fix1(MR_timings.onsets.fix1~=0);
                        MR_timings.onsets.fix2 = MR_timings.onsets.fix2(MR_timings.onsets.fix2~=0);
                        MR_timings.onsets.scales.GFD = MR_timings.onsets.scales.GFD(MR_timings.onsets.scales.GFD~=0);
                     end
                      
% Outcome lotery

output.lottery.effort_winning_trial = [];

if settings.do_fmri == 1
    % Determine "randomly selected" block and exerted effort
    coinflip  = rand;
    if coinflip <= 0.5 % choose block x
        output.lottery.effort_winning_trial = cell2mat(output.data_mat(20, 12));
    else % choose block y
        output.lottery.effort_winning_trial = cell2mat(output.data_mat(35, 12));
    end
    
    % Determine probability of winning based on exerted force
    if output.lottery.effort_winning_trial < 64
        output.lottery.probability_win = 0;
    else
        output.lottery.probability_win = (1 - exp(-0.04*((output.lottery.effort_winning_trial - 63)*100/37))); 
    end
    
    % Determine if lottery won
    output.lottery.randval = rand;
    if output.lottery.randval <= output.lottery.probability_win
        output.lottery.lottery_win = 1;
    else
        output.lottery.lottery_win = 0;
    end
    
    % Show feedback screen
    if settings.do_fmri == 0
        
        [Pic, map, alpha] = imread('BannerWonBlock.JPG');
        shapePic = size(Pic);
        Screen('PutImage', w, Pic, [(ww/2 - shapePic(2)/2) 40 (ww/2 + shapePic(2)/2) (40 + shapePic(1))]);
        Screen('TextSize',w,28);
        Screen('TextFont',w,'Arial');

        if output.lottery.lottery_win == 1
           [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text_lottery1, 'center', 'center', [0 0 0],150);
        else
           [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text_lottery2, 'center', 'center', [0 0 0],150);
        end
        [ons_resp, starttime] = Screen('Flip', w, []);
        
    elseif settings.do_fmri == 1
        
        [Pic, map, alpha] = imread('BannerWonBlockM.JPG');
        shapePic = size(Pic);
        Screen('PutImage', w, Pic, [(ww/2 - shapePic(2)/2) 40 (ww/2 + shapePic(2)/2) (40 + shapePic(1))]);
        Screen('TextSize',w,28);
        Screen('TextFont',w,'Arial');

        if output.lottery.lottery_win == 1
           [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text_lottery1, 'center', 'center', [0 0 0],150, flip_flag_horizontal, flip_flag_vertical);
        else
           [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text_lottery2, 'center', 'center', [0 0 0],150, flip_flag_horizontal, flip_flag_vertical);
        end
        [ons_resp, starttime] = Screen('Flip', w, []);
        
    end
    
    GetClicks;
    
    % Print out values in console
    sprintf(['Effort exerted on winning trial: ' num2str(output.lottery.effort_winning_trial)])
    sprintf(['Allowed to play for reward? 1 = yes, 0 = no : ' num2str(output.lottery.lottery_win)])
end

%filename = sprintf('FCR_beh_TUE002_%04d_%01d',subj.id, subj.sess);
filename = ['FCRbeh_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_R', subj.runID];
if settings.do_fmri == 0
    save(fullfile('Data', [filename '.mat']),'design','output','subj','timestamps');
else
    save(fullfile('Data', [filename '.mat']),'design','output','subj','input_device','timestamps','MR_timings');
end
save(fullfile('Backup', [filename datestr(now,'_yymmdd_HHMM') '.mat']));


ShowCursor();

Screen('CloseAll');
 
