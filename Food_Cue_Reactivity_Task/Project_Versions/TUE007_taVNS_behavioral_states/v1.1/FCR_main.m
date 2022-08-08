% ================== Food evaluation paradigm =============================
% For a description of the set of images, see Charbonnier (2015) Appetite
% Coded by: Nils Kroemer 
% Coded 1
% with: Matlab R2014a using Psychtoolbox 3.0.11
%
% Current Version: 3 (July 2021), Corinna Schulz 
% =========================================================================
clear
sca

%% General settings:
subj.version = 3; %Task version
output.version = subj.version;
subj.study = 'TUE007'; % Enter here current study name
subj.subjectID = input('Subject ID: ','s');
subj.sessionID = input('Session ID: ','s');
subj.runID = '1';
subj.date_start      = datestr(now);

% Jitter files used for the current study
path_delay_jitter_fMRI = fullfile(pwd,filesep,'DelayJitter_mu_0.7_max_4_trials_160.mat'); 
path_delay_jitter = fullfile(pwd,filesep,'DelayJitter_mu_0.7_max_4_trials_160.mat'); 

% set up folder for backups and final data
backup_folder = 'Backup';
data_folder = 'Data';

if ~exist([pwd, filesep,backup_folder], 'dir')
    mkdir([pwd, filesep,backup_folder])
end
if ~exist([pwd, filesep,data_folder], 'dir')
    mkdir([pwd, filesep,data_folder])
end

% Change flags to customize script
name_file = strcat('FCRsettings_', subj.study, '_S', subj.sessionID, '_R', subj.runID);
load(name_file);

subj.date      = datestr(now, 'yyyymmdd-HHMM');

% Automatic operating information
Screen('Preference', 'SkipSyncTests', 1);

% Get operating system and set OS flags
system_info = Screen('Computer');
windows = system_info.windows;
mac = system_info.osx;
linux = system_info.linux;   

% Convert subject info
subj.subjectID = [repmat('0',1,6-length(subj.subjectID)) subj.subjectID];
subj.id = str2double(subj.subjectID);   % converts Subject ID to integer
subj.sess = str2double(subj.sessionID); % converts Session ID to integer
subj.run = str2double(subj.runID);      % converts Run ID to integer

% Set up EGG triggers if needed
if settings.do_EGG == 1
    
    % Add path for io64 function
    addpath(settings.EGG.io64_path);
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


%%  Set task parameters

% Set run conditions
if settings.do_fmri == 1

    start_rep = 1;
    end_rep = 1;
       
else % per session we need to index two runs from randomization script (start and end rep) 
    
    start_rep = (subj.sess*2 - 1);                            
    end_rep = (subj.sess*2);       
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
    timing.min_ISI = 0.3;
end
   
timing.feedback_delay = 0.20; %for scales
timing.max_dur_rating = 2.8; %after the specified seconds, the rating screen will terminate

% Display settings
color_scale_background = [255 255 255]; %white
color_scale_anchors = [0 0 0]; %black

screen_offset_y = 0.01; %relative offset; positive values move the screen towards to top, negative towards the bottom
scale_offset_y = 0.25;
    
do_scales = 1; %will run scale in prob_scales*100% of trials
preset = 1; % needs to be 1 to skip screen initialization, thus use scales as part of experiment    
    
% Key settings
keyTrigger=KbName('5%');
keyTrigger2=KbName('5');
keyQuit=KbName('q');
keyResp=KbName('1');
keyResp2=KbName('1');

% Screen settings
screens = Screen('Screens'); %Define display screen
screenNumber = max(screens);

if settings.do_fullscreen == 1
    [w,wRect] = Screen(screenNumber,'OpenWindow',[255 255 255]);
    HideCursor()
else
    [w,wRect] = Screen('OpenWindow', 0, 255, [10 30 810 630]);
    Screen('Preference', 'SkipSyncTests', 1);
end

% Get the center coordinates
[ww, wh] = Screen('WindowSize', w);
Scr_Width = wRect(3) - wRect(1); 
% Image sacling according to screen settings 
% window width: ww, and window height: wh
scale_x = ww/1024;
scale_y = wh/768;
x_cent = ww/2;
y_cent = wh/2;

% Load images information and randomization from condition matrix
if settings.do_fmri == 1
    part_file = sprintf(['Order_' subj.study '_fMRI' filesep 'FCRcond_mat_' subj.study '_fmri.mat']);
else
    part_file = ['Order_' subj.study filesep 'FCRcond_mat_' subj.study '_' subj.subjectID '.mat'];
end

load(part_file)

%% Create output.data
% index trials for current session (each session has 2 runs: Liking & Wanting)
block_ind = find(strcmp('repetition',design.rand.order_mat_labels(:,1)));
output.data = design.rand.order_mat(ismember(design.rand.order_mat(:,block_ind), start_rep:end_rep),:);
output.data_labels = design.rand.order_mat_labels(:,1);

% output, save whether liking or wanting scale was assessed (rating type)
if settings.do_fmri == 0
    scale_order = reshape(design.rand.full_flip_coin,[],1);
    output.data(:,end+1) = (scale_order(ismember(design.rand.order_mat(:,block_ind), start_rep:end_rep),:));
else
    output.data(:,end+1) = (2); % only GFD_bidding is used in fMRI version
end
output.data_labels(end+1) = 'rating_type';

% Add empty columns for Anwers to FCR
output.data(:,end+1) = NaN;
output.data_labels(end+1) = 'rating_RT';

output.data(:,end+1) = (NaN);
output.data_labels(end+1) = 'rating_value';

output.data(:,end+1) = (NaN);
output.data_labels(end+1) = 'rating_submitted';

% adapt this if you use fMRI!       
if settings.do_fmri == 1 
   output.rel_force = double.empty(0,3); 
end

%% get filenames of image stimuli shown for current session
image_ind = find(strcmp('img_index',design.rand.order_mat_labels(:,1)));
image_file_names = reshape(design.rand.image_file,[],1); %create longformat of filenames
image_file_names = string(image_file_names(ismember(design.rand.order_mat(:,block_ind), start_rep:end_rep))); %reduce to filenames of current session

%% input device settings
if settings.do_GFD == 1
    
    load('GripForceSpec.mat')
    
    maxeffort_searchname = [[pwd filesep 'Data' filesep 'TrainEAT_' subj.study '_'  subj.subjectID '_S' subj.sessionID '_R1.mat']];
    load(maxeffort_searchname, 'input_device');

    % Parameters to draw ball movement force using individual max and min Effort
    restforce = input_device.minEffort - 0.05*(input_device.minEffort - input_device.maxEffort); % 5% over min force
    maxpossibleforce = input_device.maxEffort; %upper limit of GFD
    delta_pos_force = input_device.minEffort - maxpossibleforce; 
    clckforce = input_device.minEffort - 0.35*abs(input_device.minEffort - input_device.maxEffort);
    
    % Drawing parameters for Tube
    Tube.width = round(ww * .20);
    Tube.offset = round((wh - (wh * .95)) * .35);
    Tube.height = round(Tube.offset+wh/4);
    LowerBoundBar = wh - Tube.offset - Ball.width; %height at which the bar starts when ForceMat = restforce
    UpperBoundBar = Tube.height; %heighest allowed position of bar
    
    % Drawing parameters for Ball
    Ball.width = round(ww * .06);
    ball_color = [0 0 139];
    
    % Initialize output for GFD relative force
    output.GFD_rel_force = [];
    
elseif settings.do_gamepad == 1 || settings.do_joystick == 1
    
    load('JoystickSpecification.mat');
    input_type = 1; % variable needed in VAS and LHS scale scripts to index Joystick (vs. Mouse)
    if strcmp(subj.study,'TUE007')
        findJoystick
    end
end


%% Show instructions on screen
Screen('TextSize',w,28);
Screen('TextFont',w,'Arial');

if settings.do_fmri == 1
    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text_p1, 'center', 'center', [0 0 0], 150, flip_flag_horizontal, flip_flag_vertical);
else
    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text_p1, 'center', 'center', [0 0 0], 150);
end

[ons_resp, starttime] = Screen('Flip', w, []);

if settings.do_fmri ~= 1
        GetClicks;
elseif settings.do_fmri == 1
    WaitSecs(3);        
    while gripforce_value > clckforce
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        gripforce_value = Joystick.Y;
    end
end

if (~isempty(instruct.text_p2))
    Screen('TextSize',w,28);
    Screen('TextFont',w,'Arial');
    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text_p2, 'center', 'center', [0 0 0],150);
    [ons_resp, starttime] = Screen('Flip', w, []);
    if settings.do_fmri ~= 1
            GetClicks;
    end
end

%load jitters and initialize jitter counters
if settings.do_fmri  == 0 
    load(path_delay_jitter); 
    jitter = Shuffle(DelayJitter);
    timestamps.seed = rng;
elseif settings.do_fmri  == 1 
    load(path_delay_jitter_fMRI);
    %do not shuffle for MR version to keep jitters consistent across participants
    jitter = DelayJitter;
    MR_timings.jitter = jitter;
end 

%% ========================================================================
% ================== start of the experiment ==============================
% =========================================================================

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

count_jitter = 1;
% loop through trials
for i_trial = 1:length(output.data)
    
    % For behavioral version, shuffle jitter, save seed
    % For fMRI version, keep jitter order for all subjects
       
        % Determine if _trial is start or end of a picture block
        % to save block onset (block_status ==1 (start of a block)) or show fixation cross (block_status==0 (end of a block))
        if settings.do_fmri == 1 
            block_status = mod(i_trial, block_length); 
        end
        
        %% Show image
        
        % load image for trial i
        image_path = sprintf('Stimuli/%s', image_file_names(i_trial,1));

        [Pic, map, alpha] = imread(image_path);
        
        Screen('PutImage', w, Pic, [0 0 ww wh]);
        [ons_resp, starttime] = Screen('Flip', w);
        
        % Trigger EGG
        if settings.do_EGG == 1
            % Write trigger for EGG - picture presentation 
            io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.image); 
        end
        
        MR_timings.onsets.image(i_trial) = starttime - MR_timings.trigger.fin;
        timestamps.image(i_trial) = starttime;

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
            
            MR_timings.onsets.fix1(i_trial) = starttime - MR_timings.trigger.fin;
            timestamps.fix1(i_trial) = starttime;
            MR_timings.durations.fix1(i_trial) = timing.min_ISI+jitter(count_jitter);
            
            WaitSecs(timing.min_ISI+jitter(count_jitter));
            timestamps.jitter_fix1(i_trial) = timing.min_ISI + jitter(count_jitter);
            count_jitter = count_jitter + 1;
  
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
            if (output.data(i_trial,find(strcmp('rating_type',output.data_labels(:))))) == 0
                call_scale = 'LHS';
            else
                call_scale = 'VAS';
            end
            
        end
        
        % Call scales for defined input device
        if strcmp(call_scale, 'LHS')
            
            % Trigger EGG
            if settings.do_EGG == 1
                % Write trigger for EGG - LHS scale 
                io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.scales.LHS); 
            end
                
            FCR_LHS_vertical
            
            % Trigger EGG
            if settings.do_EGG == 1
                % Write trigger for EGG - LHS scale end
                io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.scales.LHS_end); 
            end

        elseif strcmp(call_scale, 'VAS')
            
             % Trigger EGG
            if settings.do_EGG == 1
                % Write trigger for EGG - VAS scale 
                io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.scales.VAS); 
            end

            FCR_VAS_horz
            
            % Trigger EGG
            if settings.do_EGG == 1
                % Write trigger for EGG - VAS scale 
                io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.scales.VAS_end); 
            end

        elseif  strcmp(call_scale, 'bidding_GFD')
            
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
        
        end
        
        if show_scale == 1
            
            timestamps.scales(i_trial) = starttime ; 
            %MR_timings.onsets.scales(i_trial) = rating  - MR_timings.trigger.fin;

            
            if  strcmp(call_scale, 'bidding_GFD')
            
                %output.GFD_rel_force = [output.GFD_rel_force; [ones(length(values),1)*i_trial,rating.GFD]];
                
            end
            
        end
       
        
        
        
        %% show fixation 2
        % after ratings (i.e., not within a block if settings.do_fmri == 1)
        if ~isempty(call_scale)
        
            fixation = '+';
            Screen('TextSize',w,64);
            Screen('TextFont',w,'Arial');
            DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);

            [ons_resp, starttime] = Screen('Flip', w);
            
            % Write timestamps to output
            MR_timings.onsets.fix2(i_trial) = starttime - MR_timings.trigger.fin;
            timestamps.fix2(i_trial) = starttime;

            % Determine duration of fix 2
           if settings.do_fmri == 0
               
               % Depending on submission time of rating(answer) by participant, 
               % prolong the jitter time to ensure equal task lengths
                if output.data(i_trial,submission_column) == 1 % rating submitted
                    jitter_duration = (timing.min_ISI-output.data(i_trial,RT_column))+timing.min_ISI + jitter(count_jitter) ; 
                elseif output.data(i_trial,submission_column) == 0 % no rating submitted
                    jitter_duration = timing.min_ISI + jitter(count_jitter);
                end
                
                WaitSecs(jitter_duration);
                
           else %for MR after block end
               
               jitter_duration = timing.min_ISI+jitter(count_jitter); 
               WaitSecs(jitter_duration);
               
           end
           
           % Write duration information to output
           timestamps.jitter_fix2(i_trial) = jitter_duration; 
                      
        end 
        
        % save temporary file
        filename = ['FCRbeh_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_R', subj.runID, '_temp_', subj.date ];
        save(fullfile('Backup', [filename '.mat']),'design','output','subj','timestamps');
        
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

timestamps.exp_end = GetSecs;

% Trigger EGG
if settings.do_EGG == 1
    % Write trigger for EGG - end of the experiment 
    io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.exp_off); 
end


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
    MR_timings.onsets.scales = MR_timings.onsets.scales(MR_timings.onsets.scales~=0);
    
 end

% Outcome lottery
% output.lottery.effort_winning_trial = [];

if settings.do_fmri == 1
    % Determine "randomly selected" block and exerted effort
    coinflip  = rand;
    if coinflip <= 0.5 % choose block x
        output.lottery.effort_winning_trial = output.data{20, find(strcmp('rating_value',output.data_labels(:)))};
    else % choose block y
        output.lottery.effort_winning_trial = output.data{35, find(strcmp('rating_value',output.data_labels(:)))};
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
    
    GetClicks;
    
    % Print out values in console
    sprintf(['Effort exerted on winning trial: ' num2str(output.lottery.effort_winning_trial)])
    sprintf(['Allowed to play for reward? 1 = yes, 0 = no : ' num2str(output.lottery.lottery_win)])
    
end
%Save time end of experiment
subj.date_end      = datestr(now);
t_start=datevec(datenum(subj.date_start));
t_end=datevec(datenum(subj.date_end ));
subj.length_exp = etime(t_end, t_start)/60; %length exp in min

% Save output
filename = ['FCRbeh_', subj.study, '_', subj.subjectID, '_S', subj.sessionID];
if settings.do_fmri == 0
    save(fullfile('Data', [filename '.mat']),'output','subj','timestamps');
else
    save(fullfile('Data', [filename '.mat']),'output','subj','input_device','timestamps','MR_timings');
end
save(fullfile('Backup', [filename datestr(now,'_yymmdd_HHMM') '.mat']));

ShowCursor();

Screen('CloseAll');
 
