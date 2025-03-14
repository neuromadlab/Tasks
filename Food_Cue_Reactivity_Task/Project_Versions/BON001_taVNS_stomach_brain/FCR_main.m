% ================== Food evaluation paradigm =============================
% For a description of the set of images, see Charbonnier (2015) Appetite
% Coded by: Nils Kroemer
% Coded 1
% with: Matlab R2014a using Psychtoolbox 3.0.11

% currently Matlab R2021b, Psychtoolbox 3.0.16
% Current Version: 3 (last adapted for TUE008, December 2021, Corinna Schulz
% Current Version: 4 (last adapted for BON, September 2023, Anne Kühnel, TTL Triggers)
% =========================================================================
clear
sca

% Check for data folders
if 7~=exist('./Backup','dir')
    mkdir('./Backup')
end

if 7~=exist('./Data','dir')
    mkdir('./Data')
end

%% General settings:
subj.version = 4; %Task version
output.version = subj.version;
subj.study = 'BON001'; % Enter here current study name
subj.subjectID = input('Subject ID: ','s');
subj.sessionID = input('Session ID: ','s');
subj.lang_de = input('German (1) or English (0): ');
subj.runID = input('Run ID [1 (behavior), 2 (fMRI) or 3 (lottery)]: ','s'); %
subj.date_start      = datestr(now);
if strcmp(subj.runID,'2')
    subj.cond = input('Condition [0 or 1]: '); % active stimulation (1) or sham (0)

    % ensure that the correct condition was provided
    correct_cond = 0;
    while correct_cond ~= 1
        if subj.cond == 0 || subj.cond == 1
            correct_cond = input(['The specified condition is '...
                num2str(subj.cond) '. Is this correct (1) or not (0)?: ']);
        elseif ~ismember(subj.cond, 0:1)
            fprintf(['\nThe specified condition is not a valid' ...
                ' condition for BON001! ']);
        end
        if correct_cond ~= 1
            subj.cond = input(['Please enter the correct condition' ...
                ' [0 or 1]: ']);
        end
    end
end


% Jitter files used for the current study
path_delay_jitter_fMRI = fullfile(pwd,filesep,'DelayJitter_mu_0.7_max_4_trials_160.mat');
path_delay_jitter = fullfile(pwd,filesep,'DelayJitter_mu_0.7_max_4_trials_160.mat');


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
settings.lang_de = subj.lang_de;
if strcmp(subj.runID, '1')
    subj.runLABEL = 'FCR';
elseif strcmp(subj.runID, '2')
    subj.runLABEL = 'Foodbidding';
elseif strcmp(subj.runID, '3')
    subj.runLABEL = 'bidding_trial';
end

% settings.do_EGG = 0;
% settings.do_fmri = 0;
% settings.debug = 1;
% settings.do_fullscreen = 0;

% Set up EGG triggers if needed
if settings.do_EGG == 1
    prepareTTL('COM7', 115200, settings.EGG.trigDur); % COM7 for L&B
    sendTTL(0,1) % just for testing, throws error if fails
end

% This if-branch restarts the tVNS stimulation at the beginning of the 2nd
% run and gives the experimenter the opportunity to check & repair the
% bluetooth connection between device and manager, if necessary.
if strcmp(subj.runID,'2')
    subj.tVNS_manager = input('Use tVNS manager [1] or start stimulation manually [0]?: ');
    if subj.tVNS_manager
        subj.stim_amplitude = input('Stimulation intensity [muA]: ');
        subj.stim_length = 30;
        subj.pause_length = 30;
        subj.stim_freq = 25;
        subj.stim_impDur = 250;

        % stop and re-start stimulation
        tvnsInfo = setupTVNS(subj.stim_amplitude,subj.stim_impDur,subj.stim_freq,subj.stim_length, subj.pause_length);
        [~,~,~] = send(tvnsInfo.reqTreatOff, tvnsInfo.tvnsURL);
        [~,~,~] = send(tvnsInfo.reqTreatOn, tvnsInfo.tvnsURL);
        timestamps.time_stim_on = GetSecs;
        if settings.do_EGG
            sendTTL(settings.EGG.trigger.tvns_on)
        end

        % now the experimenter needs to check if manager & device still work
        disp('Please check the tVNS manager window if the stimulation is still running.')
        allOk = input('Please enter 1 if everything is ok, enter 0 if we need to restart the stimulation : [0/1] ');
        while ~allOk
            disp('Please re-establish the bluetooth connection between device and tVNS manager before restarting!')
            doRestart = input('Shall we restart stimulation now? : [0/1] ');
            % restart of normal stimulation
            if doRestart
                tvnsInfo = setupTVNS(subj.stim_amplitude,subj.stim_impDur,subj.stim_freq,subj.stim_length, subj.pause_length);
                [~,~,~] = send(tvnsInfo.reqTreatOn, tvnsInfo.tvnsURL);
                timestamps.time_stim_on = GetSecs;
                if settings.do_EGG
                    sendTTL(settings.EGG.trigger.tvns_on)
                end
            end
            allOk = input('Please enter 1 if everything is ok, enter 0 if we need to restart the stimulation : [0/1] ');
        end
        
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
    flip_flag_horizontal = 0;
    flip_flag_vertical = 0;
elseif strcmp(subj.runLABEL, 'bidding_trial')
    timing.responding_time = 30;
    timing.secs_for_average = 2; %Last X seconds of which the average will be taken
    timing.last_secs_counted = timing.responding_time - timing.secs_for_average; %Time starting point for taking average
    flip_flag_horizontal = 0;
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

% Load images information and randomization from condition matrix (not for
% lottery)
if ~strcmp(subj.runLABEL, 'bidding_trial')
    if settings.do_fmri == 1
        part_file = ['Order_' subj.study '_fMRI' filesep 'FCRcond_mat_' subj.study '_fmri.mat'];
    else
        part_file = ['Order_' subj.study filesep 'FCRcond_mat_' subj.study '_' subj.subjectID '.mat'];
    end

    load(part_file)
end

%% Create output.data
% index trials for current session
if ~strcmp(subj.runLABEL, 'bidding_trial')

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

    if settings.do_fmri == 0
        % Add empty columns for Anwers to FCR
        output.data(:,end+1) = NaN;
        output.data_labels(end+1) = 'rating_RT';
    end

    output.data(:,end+1) = (NaN);
    output.data_labels(end+1) = 'rating_value';

    if settings.do_GFD
        output.data(:,end+1) = (NaN);
        output.data_labels(end+1) = 'rating_value_left';
        output.data(:,end+1) = (NaN);
        output.data_labels(end+1) = 'rating_value_right';
    end

    output.data(:,end+1) = (NaN);
    output.data_labels(end+1) = 'rating_submitted';



    % adapt this if you use fMRI!
    if settings.do_GFD == 1
        output.rel_force = double.empty(0,3);
        output.rel_forceL = double.empty(0,3);
        output.rel_forceR = double.empty(0,3);
        output.raw_forceL = [];
        output.raw_forceR = [];
    end
    
    %% get filenames of image stimuli shown for current session
    image_ind = find(strcmp('img_index',design.rand.order_mat_labels(:,1)));
    image_file_names = reshape(design.rand.image_file,[],1); %create longformat of filenames
    image_file_names = string(image_file_names(ismember(design.rand.order_mat(:,block_ind), start_rep:end_rep))); %reduce to filenames of current session

elseif strcmp(subj.runLABEL, 'bidding_trial')
    % prepare output for lottery trial
    if subj.sess == 1 % office block (block type = 5, block_id = 11, food = no, high_cal = no, rating type = 2 (GFD), empty entries for rating values)
        output.data = [1, 5, 11, 0, 0, 2, NaN, NaN, NaN];
    elseif subj.sess == 2 % food block (block type = 4, block_id = 10, food = yes, high_cal = yes, rating type = 2 (GFD), empty entries for rating values)
        output.data = [1, 4, 10, 1, 1, 2, NaN, NaN, NaN];
    end
    output.data_labels = ["row_index"; "block_type"; "block_id"; "food"; "high_cal"; "rating_type"; "rating_value"; "rating_value_left"; "rating_value_right"];
end

%% input device settings
if settings.do_GFD == 1

    %     load('GripForceSpec.mat')

    %     maxeffort_searchname = [[pwd filesep 'Data' filesep 'TrainEAT_' subj.study '_'  subj.subjectID '_S' subj.sessionID '_R1.mat'];
        maxeffort_searchname = ['..' filesep 'EAT' filesep 'data' filesep 'TrainEAT_' subj.study '_' subj.subjectID '_S' subj.sessionID '_R1.mat']; % path for L&B
%           maxeffort_searchname = ['..' filesep '..' filesep '..' filesep 'Effort' filesep 'Projects_Versions' filesep 'BON001' filesep 'data' filesep 'TrainEAT_' subj.study '_'  subj.subjectID '_S' subj.sessionID '_R1.mat']; % path for testing
          load(maxeffort_searchname, 'input_device');
    %     load('X:\Tasks\Effort\Projects_Versions\BON003\data\TrainEAT_BON003_900001_S1_R1.mat','input_device');

    input_device = rmfield(input_device,{'value_money','value_food','incentive','value','uncertainty','percentEffort'}); % delete unnecessary information of input device from EAT training

    % Parameters to draw ball movement force using individual max and min Effort
    restforce = input_device.minEffort; %+ 0.05*(input_device.maxEffort - input_device.minEffort); % 5% over min force
    restforceL = input_device.minEffortL;
    restforceR = input_device.minEffortR;
    maxpossibleforce = input_device.maxEffort; %upper limit of GFD
    delta_pos_force = input_device.maxEffort - input_device.minEffort; % the usable range of effort
    delta_pos_forceR = input_device.maxEffortR - input_device.minEffortR;
    delta_pos_forceL = input_device.maxEffortL - input_device.minEffortL;
    clckforce = input_device.minEffort + 0.35*abs(input_device.maxEffort - input_device.minEffort);
    %     clckforce = 50000;

    % Drawing parameters for Ball
    Ball.width = round(ww * .06);
    ball_color = [0 0 139];

    % Drawing parameters for Tube
    Tube.width = round(ww * .20);
    Tube.offset = round((wh - (wh * .95)) * .35);
    Tube.height = round(Tube.offset+wh/4);
    if strcmp(subj.runLABEL, 'Foodbidding')
        LowerBoundBar = wh - Tube.offset - Ball.width; % height at which the bar starts when ForceMat = restforce
    elseif strcmp(subj.runLABEL, 'bidding_trial')
        LowerBoundBar = wh - Tube.offset; % height at which the bar starts when ForceMat = restforce
    end
    UpperBoundBar = Tube.height + Ball.width; % highest allowed position of bar
    BarBoundAbs         = LowerBoundBar - UpperBoundBar; % the usable Y-range of the tube for a bar, in pixel
    BarBound2Scale      = BarBoundAbs/delta_pos_force; % a scale-factor between range of tube and force
    BarBound2ScaleR      = BarBoundAbs/delta_pos_forceR;
    BarBound2ScaleL      = BarBoundAbs/delta_pos_forceL;

    color_threshold = [255 0 0];

    % Get parameters for difficulty threshold for final bidding trial based
    % on original bid of subject
    if strcmp(subj.runLABEL, 'bidding_trial')

        % load original bid of subject
        Foodbidding_output = load([pwd filesep 'Data' filesep 'FCRbeh_' subj.study '_' subj.subjectID, '_S', subj.sessionID, '_R2'], 'output');
        subj.difficulty = Foodbidding_output.output.lottery.effort_winning_trial;

        % Use difficulty for drawing parameters for threshold
        restforceR = input_device.minEffortR;
        restforceL = input_device.minEffortL;
        delta_pos_forceR = input_device.maxEffortR - input_device.minEffortR;
        delta_pos_forceL = input_device.maxEffortL - input_device.minEffortL;
        BarBound2ScaleR      = BarBoundAbs/delta_pos_forceR; % a scale-factor between range of tube and force.right
        BarBound2ScaleL      = BarBoundAbs/delta_pos_forceL;
        input_device.thresholdEffort = input_device.minEffortR + delta_pos_forceR * subj.difficulty * 0.01;
        input_device.thresholdEffort_percent = subj.difficulty;
        %Threshold position for obtaining reward in this trial
        Threshold_yposition        = LowerBoundBar -  BarBound2ScaleR*(input_device.thresholdEffort - input_device.minEffortR);
    end

    % timings
    i_step = 1; %loops through each iteration of the while loop (to place time stamps)
    t_vector = [];


    % add loop to automatically check
    GripForceSpec.Handle = 0;
    if settings.do_GFD ~= 1
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    else
        disp('redundant condition branch 1!')
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    end
    gripforce_valueL = Joystick.X;
    gripforce_valueR = Joystick.Y;
    gripforce_value = max(Joystick.X, Joystick.Y);

    ForceMat = restforce; %current force. Starts at restforce to start ball at bottom
    ForceTime = []; %matrix that saves force over time
    ForceTimeL = [];
    ForceTimeR = [];


    % Initialize output for GFD force
    output.rel_force = [];
    output.rel_forceL = [];
    output.rel_forceR = [];
    output.raw_forceL = [];
    output.raw_forceR = [];

elseif settings.do_gamepad == 1

    load('JoystickSpecification.mat');
    input_type = 1; % variable needed in VAS and LHS scale scripts to index Joystick (vs. Mouse)

    findJoystick

else 
    input_type = 0;

end


if settings.do_fmri == 0 && settings.lang_de == 0 && settings.do_gamepad == 1 && strcmp(subj.runLABEL, 'FCR')
    instruct.text_p1 = ['In the following task, you will be presented with images '...
        ' \nof food and office supplies in a random order. '...
        ' \nFollowing each trial, you will be shown one of two scales '...
        ' \nand will be asked to indicate either:'...
        ' \n\n 1. How much you want to receive the presented object at that moment \n'...
        ' \n2. How much you like the presented object at that moment. \n '...
        ' \n\nPlease use the horizontal scale to specify how much you want to receive the presented reward '...
        ' \nat the moment and use the vertical scale specify how much you like the presented reward at that moment. '...
        ' \nWhich scale appears after each image is randomly selected. \n'...
        ' \nTo answer, please use the joystick to navigate the slider. '...
        ' \nIf you do not eat meat or fish, pretend that you are seeing vegeterian or vegan substitue products. '...
        ' \nConfirm your answer with the button A.\n '...
        ' \n\nContinue by pressing button A.'];
elseif settings.do_fmri == 0 && settings.lang_de == 0 && settings.do_gamepad == 0 && strcmp(subj.runLABEL, 'FCR')
    instruct.text_p1 = ['In the following task, you will be presented with images '...
        ' \nof food and office supplies in a random order. '...
        ' \nFollowing each trial, you will be shown one of two scales '...
        ' \nand will be asked to indicate either:'...
        ' \n\n 1. How much you want to receive the presented object at that moment \n'...
        ' \n2. How much you like the presented object at that moment. \n '...
        ' \n\nPlease use the horizontal scale to specify how much you want to receive the presented reward '...
        ' \nat the moment and use the vertical scale specify how much you like the presented reward at that moment. '...
        ' \nWhich scale appears after each image is randomly selected. \n'...
        ' \nTo answer, please use the mouse to navigate the slider. '...
        ' \nIf you do not eat meat or fish, pretend that you are seeing vegeterian or vegan substitue products. '...
        ' \nConfirm your answer with a mouse click.\n ' ...
        ' \n\nContinue with a mouse click.'];
elseif settings.do_fmri == 1 && settings.lang_de == 0 && strcmp(subj.runLABEL, 'Foodbidding')
    instruct.text_p1 = ['In the following task, you will be presented with images '...
        '\nof food and office supplies in blocks of five. '...
        '\nFor each block, imagine that the shown options'...
        '\nare available, similar to a buffet.'...
        '\nIf you do not eat meat or fish, pretend that you are seeing vegeterian '...
        '\nor vegan substitue products. '...
        '\nIn the following bidding phase, indicate how much effort '...
        '\nyou are willing to invest to gain access to the buffet. '...
        '\nTo this end, please press the grip force device'...
        '\nwith the corresponding force. '...
        '\nThe bidding phase will last for approximately 5 seconds. '...
        '\nTry to hold the ball at the height correspoding to the force level '...
        '\nyou are willing to offer.\n '...
        '\nContinue by pressing the device.'];
    instruct.text_p2 = ['After finishing the task, one block will be chosen randomly. '...
        '\nYour bid is then compared with the bids of other players '...
        '\nto decide whether you win. So the more you "bid" '...
        '\nthe more likely it is that you will win the block. '...
        '\nIf you bid is sufficient, you can earn the reward '...
        '\nat the end of this session by making an effort. '...
        '\nYou are free to decide which hand you want to use for your bid in each block.\n '...
        '\nContinue by pressing the device. The task will then start automatically.'];
    instruct.text_lottery1 = ['The lottery has revealed that the options shown above can be won.\n\n\n '...
        '\nAt the end of this session, you can play one more round\n ' ...
        '\nand win points that you can then exchange for rewards.'];
    instruct.text_lottery2 = ['The lottery has revealed that the options shown above can be won.\n\n\n '...
        '\nUnfortunately, your bid is not enough. '...
        '\nYou cannot win anything this time.'];
elseif settings.lang_de == 0 && strcmp(subj.runLABEL, 'bidding_trial')
    instruct.text_p1 = ['You now have the opportunity to earn one of the options shown below. '...
        '\nTo do this, move the ball over the threshold shown by pressing the device in your RIGHT hand. '...
        '\nIf you manage to keep the ball above the threshold until the end, '...
        '\nyou will receive one of the rewards shown at the end of this session.'...
        '\nThe round lasts approx. 30 seconds. Please use the device in your RIGHT hand. \n '...
        '\nContinue by pressing the device. The task will then start automatically.'];
    instruct.bidding_win = ['Congratulations! '...
        '\nYou have won one of the options shown above!'];
    instruct.bidding_lost = ['Unfortunately, you did not apply enough pressure. '...
        '\nAs a result, you have not won anything today!'];
end

%% Show instructions on screen
Screen('TextSize',w,28);
Screen('TextFont',w,'Arial');

if settings.do_fmri == 1
    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text_p1, 'center', 'center', [0 0 0], 150, flip_flag_horizontal, flip_flag_vertical);
elseif strcmp(subj.runLABEL,'bidding_trial')

    % Show potential rewards (office supplies in session 1, food in session
    % 2)
    if subj.sess == 1
        [Pic, map, alpha] = imread('BannerWonBlock.JPG');
    elseif subj.sess == 2
        [Pic, map, alpha] = imread('BannerWonBlock_food.JPG');
    end
    shapePic = size(Pic);
    Screen('PutImage', w, Pic, [(ww/2 - shapePic(2)/2) wh-40- shapePic(1) (ww/2 + shapePic(2)/2) (wh - 40 )]);
    Screen('TextSize',w,28);
    Screen('TextFont',w,'Arial');

    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text_p1, 'center', 'center', [0 0 0], 150, flip_flag_horizontal, flip_flag_vertical);

else
    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text_p1, 'center', 'center', [0 0 0], 150);
end

[ons_resp, starttime] = Screen('Flip', w, []);

if settings.do_gamepad == 1
    while Joystick.Button(1) ~= 1
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    end
    WaitSecs(0.5);
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

elseif settings.do_GFD == 1
    WaitSecs(3);
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    gripforce_value = max(Joystick.X, Joystick.Y);
    while gripforce_value < clckforce
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        gripforce_valueL = Joystick.X;
        gripforce_valueR = Joystick.Y;
        gripforce_value = max(Joystick.X, Joystick.Y);
    end
else % mouse response
    WaitSecs(0.5)
    flag_resp = 0;

    while flag_resp == 0
        [mouseX, mouseY, mousebuttons] = GetMouse(screenNumber);
        if mousebuttons(1)==1 || mousebuttons(3) == 1 %Terminate on left mouseclick
            flag_resp = 1;
        end
    end
end

if (~isempty(instruct.text_p2))
    Screen('TextSize',w,28);
    Screen('TextFont',w,'Arial');
    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text_p2, 'center', 'center', [0 0 0],150);
    [ons_resp, starttime] = Screen('Flip', w, []);
    if settings.do_GFD ~= 1
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        WaitSecs(0.5);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    elseif settings.do_GFD == 1
        WaitSecs(2);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        gripforce_value = max(Joystick.X, Joystick.Y);
        while gripforce_value < clckforce
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_valueL = Joystick.X;
            gripforce_valueR = Joystick.Y;
            gripforce_value = max(Joystick.X, Joystick.Y);
        end

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

MR_timings.on_trigger_loop = GetSecs;
if settings.do_fmri == 1

    if settings.debug == 0

        Screen('TextSize',w,28);
        Screen('TextFont',w,'Arial');

        if subj.lang_de
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, 'Warten auf MRT', 'center', 'center', [0 0 0], 150, flip_flag_horizontal, flip_flag_vertical);
        else
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, 'Wait for MRI', 'center', 'center', [0 0 0], 150, flip_flag_horizontal, flip_flag_vertical);
        end

        Screen('Flip', w);

        %[ons_resp, starttime] = Screen('Flip', w, []);
        KbQueueCreate();
        KbQueueStart();



        try
            MR_timings.trigger.all = waitForScannerTrigger(dummy_volumes, keyQuit);
        catch ME
            sca;
            rethrow(ME)
        end
        KbQueueRelease();

    end
end
MR_timings.trigger.fin = GetSecs;




timestamps.exp_on = GetSecs;

% Trigger EGG
if settings.do_EGG == 1

    % Write trigger for EGG - start of the experiment
    sendTTL(settings.EGG.trigger.exp_on)

end

count_jitter = 1;
% loop through trials
for i_trial = 1:size(output.data,1)
    if ~strcmp(subj.runLABEL, 'bidding_trial') % if it's a regular run (not lottery) load pictures


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
            sendTTL(settings.EGG.trigger.image)
        end

        MR_timings.onsets.image(i_trial) = starttime - MR_timings.trigger.fin;
        timestamps.image(i_trial) = starttime;


        time_stamp_img = GetSecs;
        while time_stamp_img-timestamps.image(i_trial) < timing.pic_dur
            time_stamp_img = GetSecs;
        end

        % Trigger EGG
        if settings.do_EGG == 1
            % Write trigger for EGG - end of picture presentation
            sendTTL(settings.EGG.trigger.image)
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

    end % from now on, go on for bidding trial/lottery as well to show scale



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

    elseif (show_scale == 1 && settings.do_fmri == 1) || (show_scale == 1 && strcmp(subj.runLABEL, 'bidding_trial'))

        % show GRip force
        call_scale = 'bidding_GFD';

    elseif (show_scale == 1 && settings.do_fmri == 0 && ~strcmp(subj.runLABEL, 'bidding_trial'))

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
            sendTTL(settings.EGG.trigger.scales.LHS);
        end

        FCR_LHS_vertical

        % Trigger EGG
        if settings.do_EGG == 1
            % Write trigger for EGG - LHS scale end
            sendTTL(settings.EGG.trigger.scales.LHS_end)
        end

    elseif strcmp(call_scale, 'VAS')

        % Trigger EGG
        if settings.do_EGG == 1
            % Write trigger for EGG - VAS scale
            sendTTL(settings.EGG.trigger.scales.VAS)
        end

        FCR_VAS_horz

        % Trigger EGG
        if settings.do_EGG == 1
            % Write trigger for EGG - VAS scale
            sendTTL(settings.EGG.trigger.scales.VAS_end)
        end

    elseif  strcmp(call_scale, 'bidding_GFD')

        % Trigger EGG
        if settings.do_EGG == 1
            % Write trigger for EGG - GFD scale
            sendTTL(settings.EGG.trigger.scales.GFD)
        end

        if strcmp(subj.runLABEL, 'Foodbidding')
            GFD_tube % For regular foodbidding load tube without threshold
        elseif strcmp(subj.runLABEL, 'bidding_trial')
            GFD_tube_thresholded % for final bidding trial after lottery load tube with threshold
        end

        % Trigger EGG
        if settings.do_EGG == 1
            % Write trigger for EGG - end GFD scale
            sendTTL(settings.EGG.trigger.scales.GFD_end)
        end

    end

    if show_scale == 1 && settings.do_fmri == 1

        timestamps.scales(i_trial) = starttime ;
        MR_timings.onsets.scales(i_trial) = starttime  - MR_timings.trigger.fin;

        %
        % if  strcmp(call_scale, 'bidding_GFD')
        %
        %     output.GFD_rel_force = [output.GFD_rel_force; [ones(length(values),1)*i_trial,values]];
        %
        % end

    end




    %% show fixation 2
    % after ratings (i.e., not within a block if settings.do_fmri == 1)
    if ~isempty(call_scale) && ~strcmp(subj.runLABEL, 'bidding_trial')

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
            %if output.data(i_trial,submission_column) == 1 % rating submitted
            %    jitter_duration = (timing.max_dur_rating-output.data(i_trial,RT_column))+timing.min_ISI + jitter(count_jitter) ;
            %elseif output.data(i_trial,submission_column) == 0 % no rating submitted
            jitter_duration = timing.min_ISI + jitter(count_jitter);
            %end

            WaitSecs(jitter_duration);

        else %for MR after block end

            jitter_duration = timing.min_ISI+jitter(count_jitter);
            WaitSecs(jitter_duration);
            disp('redundant condition branch 2!')
        end

        % Write duration information to output
        timestamps.jitter_fix2(i_trial) = jitter_duration;

    end

    % save temporary file
    filename = ['FCRbeh_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_R', subj.runID, '_temp_', subj.date ];
    if strcmp(subj.runLABEL,'bidding_trial')
        save(fullfile('Backup', [filename '.mat']),'output','subj','timestamps');
    else
        save(fullfile('Backup', [filename '.mat']),'design','output','subj','timestamps');
    end

end

%last fixation (only if it's not a bidding trial/lottery, i.e. only for
%regular runs(
if ~strcmp(subj.runLABEL, 'bidding_trial')
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

end

% Trigger EGG
if settings.do_EGG == 1
    % Write trigger for EGG - end of the experiment
    sendTTL(settings.EGG.trigger.exp_off)
    closeTTL();
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

if settings.do_fmri == 1 && strcmp(subj.runLABEL, 'Foodbidding')
    % Determine "randomly selected" block and exerted effort
    coinflip  = rand;
    if coinflip <= 0.5 % choose block x
        output.lottery.effort_winning_trial = output.data(10, find(strcmp('rating_value',output.data_labels(:))));
    else % choose block y
        output.lottery.effort_winning_trial = output.data(105, find(strcmp('rating_value',output.data_labels(:))));
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

    % Show feedback screen (office supplies in session 1, food in session
    % 2)
    if subj.sess == 1
        [Pic, map, alpha] = imread('BannerWonBlock.JPG');
    elseif subj.sess == 2
        [Pic, map, alpha] = imread('BannerWonBlock_food.JPG');
    end
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

    disp('waiting for mouse click')
    GetClicks;

    % Print out values in console
    sprintf(['Effort exerted on winning trial: ' num2str(output.lottery.effort_winning_trial)])
    sprintf(['Allowed to play for reward? 1 = yes, 0 = no : ' num2str(output.lottery.lottery_win)])

elseif strcmp(subj.runLABEL, 'bidding_trial')
    % Determine if participant won the reward
    if average_force_end >= subj.difficulty
        output.bidding.bidding_win = 1;
    else
        output.bidding.bidding_win = 0;
    end

    % Show feedback screen (office supplies in session 1, food in session
    % 2)
    if subj.sess == 1
        [Pic, map, alpha] = imread('BannerWonBlock.JPG');
    elseif subj.sess == 2
        [Pic, map, alpha] = imread('BannerWonBlock_food.JPG');
    end
    shapePic = size(Pic);
    Screen('PutImage', w, Pic, [(ww/2 - shapePic(2)/2) 40 (ww/2 + shapePic(2)/2) (40 + shapePic(1))]);
    Screen('TextSize',w,28);
    Screen('TextFont',w,'Arial');

    if output.bidding.bidding_win == 1
        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.bidding_win, 'center', 'center', [0 0 0],150);
    else
        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.bidding_lost, 'center', 'center', [0 0 0],150);
    end
    [ons_resp, starttime] = Screen('Flip', w, []);

    disp('waiting for mouse click')
    GetClicks;

end
%Save time end of experiment
subj.date_end      = datestr(now);
t_start=datevec(datenum(subj.date_start));
t_end=datevec(datenum(subj.date_end ));
subj.length_exp = etime(t_end, t_start)/60; %length exp in min

% Save output
filename = ['FCRbeh_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_R', subj.runID];
if settings.do_fmri == 0 && settings.do_GFD ~= 1
    save(fullfile('Data', [filename '.mat']),'output','subj','timestamps');
elseif settings.do_fmri
    save(fullfile('Data', [filename '.mat']),'output','subj','input_device','timestamps','MR_timings');
elseif settings.do_fmri == 0 && settings.do_GFD == 1
    save(fullfile('Data', [filename '.mat']),'output','subj','input_device');
end
save(fullfile('Backup', [filename datestr(now,'_yymmdd_HHMM') '.mat']));

ShowCursor();

Screen('CloseAll');
% restart stimulation
if subj.tVNS_manager
    [~,~,~] = send(tvnsInfo.reqTreatOff, tvnsInfo.tvnsURL);
    [~,~,~] = send(tvnsInfo.reqTreatOn, tvnsInfo.tvnsURL);
end
disp('done')

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function sp = TTL(mode, comX, BaudRate, trigDur, msg, throwError)
% This function is the main-hub for handling the TTL box from
% "The Black Box Toolkit". For easy usage, the handle for the serial port
% and the trigger-duration are stored as persistent settings & there exist
% wrapper functions.
% Thus, we don't need to give the handle for each single "send".
% First you need to prepare the TTL box, then you can send data throughout
% your experiment, at the end you need to close the TTL box.
% See the docu of the wrapper functions for more detailed info.
persistent settings
if isempty(settings)
    settings.sp = -1;       % handle to serial port
    settings.trigDur = 0.05;% pulse-duration for sending triggers
end

if strcmp(mode, 'prepareTTL')
    try
        sp = IOPort('OpenSerialPort', comX, ...
            ['BaudRate=' num2str(BaudRate)]);
        IOPort('Write', sp, 'RR'); % reset lines

        % check the choosen port
        IOPort('Write', sp, '##');      % check/ping
        data = IOPort('Read', sp, 1, 2);% receive answer
        if strcmp(char(data), 'XX')     % compare answer with expectation
            disp('TTL box ready')
            settings.sp = sp;           % save handle
            settings.trigDur = trigDur; % save trigger duration
        else
            disp(' ')
            disp('Check comX settings.')
            IOPort('Close', sp) % release port
            error('TTL box not ready, wrong port?')
        end
    catch ME
        warning('preparation of trigger port failed')
        rethrow(ME)
    end

elseif strcmp(mode, 'sendTTL')
    try
        IOPort('Write', settings.sp, dec2hex(msg, 2));
        pause(settings.trigDur)
        IOPort('Write', settings.sp, dec2hex(0, 2));
    catch ME
        warning(['sending trigger failed : ' msg])
        if throwError
            IOPort('Close', settings.sp) % release port
            rethrow(ME)
        end
    end

elseif strcmp(mode, 'closeTTL')
    try
        IOPort('Write', settings.sp,'RR');   % reset lines
        IOPort('Close', settings.sp)         % release port
    catch ME
        warning('Closing port failed!')
        IOPort('Close', settings.sp) % release port, simply try again
        rethrow(ME)
    end
end

end

%----------------------------------------------------------------------
%------ Wrapper functions--------------------------------------------------

function sp = prepareTTL(comX, BaudRate, trigDur)
% Opens the port "comX" with the "BaudRate" and stores "trigDur" as
% duration for triggers in future sendTTL commands.
% It also tests the device and creates & stores the handle.
sp = TTL('prepareTTL', comX, BaudRate, trigDur);
end %----------------------------------------------------------------------

function sendTTL(msg, throwError)
% Sends the message "msg" (mandatory 2 chars) to the TTL box. If throwErrow
% is not == 1, then there will be no error if the device fails; the
% experiment proceeds, possibly after a timeout.
if nargin == 1
    throwError = 0;
end
TTL('sendTTL', [],[],[], msg, throwError);
end %----------------------------------------------------------------------

function closeTTL
% Resets the lines of the TTL device and closes the port.
TTL('closeTTL');
end %----------------------------------------------------------------------


function trigTime = waitForScannerTrigger(dummys, keyQuit)
% This function waits/blocks until the amount of "dummys"+1 triggers have
% been received. Their timepoints are returned in trigTime.
% If keyQuit is given, we assume that KbQueueCreate() & KbQueueStart() have
% been called already, then this function aborts with an error after the
% key was pressed and the readTimeout expired.
% After it receives data, this data is compared with the expectation and
% in case of unequality the function continues waiting.
%
port = 'COM3';      % L&B -> 'COM3'
target = [254 134]; % expected data, representing a trigger-pulse in L&B
readTimeout = '10';  % how long to wait for a trigger-pulse?
baudRate = '115200';% Choose a high data transmission rate
counter = 0;                % counter for received triggers inside loop
trigTime = nan(dummys+1,1); % to log the point in time for the triggers

% Open port
configStr = ['BaudRate=' baudRate ' ReceiveTimeout=' readTimeout];
myport = IOPort('OpenSerialPort', port, configStr);
disp(['Start waiting for ' num2str(dummys+1) ' scanner triggers'])

while counter <= dummys
    counter = counter+1;

    if nargin == 2 % check if abortkey was pressed
        [~,c] = KbQueueCheck();
        if c(keyQuit) ~= 0
            error('Abort key was pressed!')
        end
    end

    % Wait blocking for a new data packet of 2 trigger byte.
    % Return the GetSecs receive timestamp of the start of each packet:
    [data, trigTime(counter)] = IOPort('Read', myport, 1, 2);

    if isequal(data, target) % check the received data
        disp(['trigger : ' num2str(counter)])

    else % if no valid trigger was received, continue loop longer
        disp(['unexpected trigger data received (or timeout)! Data : ' ...
            num2str(data)])
        counter = counter-1; % set counter back to continue loop
    end
end

IOPort('Close', myport);
end %----------------------------------------------------------------------


function tvnsInfo = setupTVNS(stimAmpl,impDur,freq,stimDur,pauseDur)
% This function initializes the tVNS device

% prepare several variables for communication with tVNS
bAutoSwitch = matlab.net.http.MessageBody('automaticSwitch');
bTreatOn = matlab.net.http.MessageBody('startTreatment');
bTreatOff = matlab.net.http.MessageBody('stopTreatment');
method = matlab.net.http.RequestMethod.POST;
reqAutoSwitch = matlab.net.http.RequestMessage(method,[],bAutoSwitch);
tvnsInfo.reqTreatOn = matlab.net.http.RequestMessage(method,[],bTreatOn);
tvnsInfo.reqTreatOff = matlab.net.http.RequestMessage(method,[],bTreatOff);
tvnsInfo.tvnsURL = 'http://localhost:51523/tvnsmanager/';

% prepare the stimulation settings for setting with tVNS Manager
bSettings =  matlab.net.http.MessageBody(...
    ['minIntensity=100&maxIntensity=5000', ...
    '&impulseDuration=',num2str(impDur), ...
    '&frequency=',num2str(freq),...
    '&stimulationDuration=',num2str(stimDur),...
    '&pauseDuration=',num2str(pauseDur)]);
reqSettings = matlab.net.http.RequestMessage(method,[],bSettings);

[r1,~,~] = send(reqAutoSwitch, tvnsInfo.tvnsURL); % init tVNS Manager
[r2,~,~] = send(reqSettings, tvnsInfo.tvnsURL);% set stimulation parameters
if r1.StatusCode ~= matlab.net.http.StatusCode.OK ||...
        r2.StatusCode ~= matlab.net.http.StatusCode.OK
    error('tVNS settings setup failed')
end

% prepare the intensity setting
body_intensity = matlab.net.http.MessageBody( ['intensity ' num2str(stimAmpl)] );
request_intensity= matlab.net.http.RequestMessage( method, [], body_intensity);
[r3,~,~] = send(request_intensity, tvnsInfo.tvnsURL);
if r3.StatusCode ~= matlab.net.http.StatusCode.OK
    error('tVNS intensity setup failed')
end
end % end of setupTVNS
