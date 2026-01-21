
%%===================Effort allocation task===================
% Main script for Effort cost paradigm
%
% author: Monja P. Neuser, Mechteld van den Hoek Ostende, Vanessa Teckentrup, Nils B. Kroemer
% Integration WOF: Emily Corwin-Renner
%
% English translation by Wy Ming Lin
%
% Input: fiber optic response grip force device or Xbox360 controller,
%        computer mouse for non-mri settings
%
subj.version = 3;          % Script version: "at the zoo"
%=============================================================
%% Part 0: Preparation

% Clear workspace
close all;
clear all;
sca;

% Automatic operating information
Screen('Preference', 'SkipSyncTests', 1);

% Check for data folders
if 7~=exist('./backup', 'dir')
    mkdir('./backup')
end

if 7~=exist('./data', 'dir')
    mkdir('./data')
end

%% Part 1/2: settings and study information
% load settings .mat file
setting_files = dir('./settings/EAT_Settings_*.mat');

fn = {setting_files.name};
[indx,tf] = listdlg('PromptString',{'Select the settings file corresponding to the current session. Check Study and Session ID!',...
    'Only one file can be selected at a time.',''},...
    'SelectionMode','single','ListString',fn);

load([setting_files(indx).folder,filesep,setting_files(indx).name])

%check if all necessary settings fields are available
if ~isfield(settings,'do_tVNS')
    settings.do_tVNS = 0;
    disp('check settings')
end

if ~isfield(settings,'do_EGG_training')
    settings.do_EGG_training = 0;
    disp('check settings')
end

% Todo: uncomment for tests or comment out after tests
% settings.do_EGG = 0;
% settings.do_EGG_training = 0;
% settings.do_fullscreen = 0;
% settings.debug = 1;
% settings.do_tVNS = 1;
%settings.check_calibration = 1; % Do calibration check with Pinata
%settings.train_trials = 3;
%% Part 3: Input from console

% Console input: entered by experimenter when experiment starts
subj.study = settings.studyID;
subj.subjectID = input('Subject ID: ','s');
subj.sessionID = input('Session ID: ','s');
subj.runLABEL  = input('Studypart ID [1 for Training / 2 for Experiment]: ','s');
subj.date_start      = char(datetime);
subj.runID = input('Run ID: ','s');


if ~strcmp(subj.runLABEL, '1') && settings.do_tVNS == 1
    subj.cond = input('Condition [0 or 1]: ','s'); % active stimulation (1) or sham (0)
end

if settings.do_WOF == 1
    subj.order=input('Version [a or b]: ', 's');
end

subj.lang = input('German? (Otherwise english), [y/n]: ', 's');
if strcmp(subj.lang,'y')
    settings.lang_de = 1;
else
    settings.lang_de = 0;
end

if settings.lang_de == 0
    instr = instr_en;
end

if settings.do_tVNS && ~strcmp(subj.runLABEL, '1')
    if strcmp(subj.cond, '0')
        subj.stim_amplitude = '100';
        subj.stim_length = 1;
        subj.pause_length = 51;
        subj.stim_freq = 1;
    else
        subj.stim_amplitude = input('Stimulation intensity [mA]: ','s');
        subj.stim_length = 22;
        subj.pause_length = 30;
        subj.stim_freq = 25;
    end
end

% Convert labels and IDs
if strcmp(subj.runLABEL, '1')
    subj.runLABEL = 'training';
else
    subj.runLABEL = 'EAT';
end
subj.runL        = str2double(subj.runLABEL);
subj.id         = str2double(subj.subjectID);
subj.sess       = str2double(subj.sessionID);
subj.run        = str2double(subj.runID);



% Add zeros to subjectID's shorter than 6 integers
subj.subjectID  = [repmat('0',1,6-length(subj.subjectID)) subj.subjectID];

% Get operating system and set OS flags
system_info     = Screen('Computer');
windows         = system_info.windows;
mac             = system_info.osx;
linux           = system_info.linux;

if linux
    [grip_force_idx,grip_force_axis] = Initialize_CD_GripForce_linux;
elseif mac
    [grip_force_idx,grip_force_axis] = Initialize_CD_GripForce_mac;
elseif windows && settings.do_fmri == 1
    hndl_found = 0;
    GripForceSpec.Handle = 0;
    while hndl_found == 0
        hndl_found = 1;
        try
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        catch
            GripForceSpec.Handle = GripForceSpec.Handle + 1;
            hndl_found = 0;
        end
    end
end

% file name for saving bidding factor
value_file_name           = sprintf('value_factor_%s', subj.subjectID);

% check if correct value file is present for MR
if settings.use_val_cal == 1
    if exist(fullfile('data', [value_file_name '.txt']), "file") ~= 2

        error('Error: Value file is missing. Add txt file to /data folder.')

    else
        input_device.value_factor = dlmread(fullfile('data', [value_file_name '.txt']));
        input_device.value_money  = settings.value_money;
        input_device.value_food   = round(input_device.value_money * input_device.value_factor);

    end
end

% set up TTL port for EGG triggers if needed
if (settings.do_EGG == 1 && ~strcmp(subj.runLABEL, 'training')) || (settings.do_EGG_training == 1 && strcmp(subj.runLABEL, 'training'))
    % Set all output bits of the selected LPT port to low in case they are
    % high at system boot time
    settings.EGG.trigDur = .05;
    prepareTTL('COM3', 115200, settings.EGG.trigDur); % COM3 for behavioral laptops
end

% prepare variables for communication & init tVNS
if settings.do_tVNS && ~strcmp(subj.runLABEL, 'training')
    throwError = 1; % throw an error in case of failure
    tvnsInfo = initTVNS(throwError);
    setupTVNS(tvnsInfo, subj.stim_amplitude, subj.stim_freq, subj.stim_length, subj.pause_length, throwError)
end

% Hide cursor in all sessions
if subj.sess == 1 || subj.sess == 2 || subj.sess == 4
   HideCursor;
end

%% Part 4: fMRI settings

%KbName('UnifyKeyNames');
Screen('Preference','TextEncodingLocale');

if settings.do_fmri == 1
    dummy_volumes = 0; %will have to be set according to the sequence
    MR_timings.dummy_volumes = dummy_volumes;
    keyTrigger=KbName('5%');
    keyTrigger2=KbName('5');
    keyQuit=KbName('q');
    keyResp=KbName('1');
    keyResp2=KbName('1');
    count_trigger = 0;
    win_phase_counter = 1; % Logs onsets of phases above threshold
    rest_phase_counter = 1; % Logs onsets of phases below threshold
    gf_sr_counter = 1; % Logs each call to MexFile

    flp_flg_hrz = 0;
    flp_flg_vrt = 0;
else
    flp_flg_hrz = 0;
    flp_flg_vrt = 0;
end

%% Part 5: Load required files

%%% Load Conditions

% Prepare loading max Effort
if settings.do_gamepad == 0
    maxeffort_searchname = [[pwd filesep 'data' filesep 'TrainEAT_' ...
        subj.study '_'  subj.subjectID '_S' subj.sessionID '_R2'] '*']; %'_R2' to only get the maxeffort of the second Run (Luisa Kaluza)
elseif settings.do_gamepad == 1
    maxeffort_searchname = [[pwd filesep 'data' filesep 'TrainEAT_' ...
        subj.study '_'  subj.subjectID '_S1' '_R1'] '*']; %only take Training from S1_R1 for inlab Session (Luisa Kaluza)
end
maxeffort_searchdir = dir(maxeffort_searchname);

% File names
if  linux

    if strcmp(subj.runLABEL, 'training')

        cond_filename      = sprintf('%s/conditions/EATTrain_cond_%s_%s_S%s_R1.mat', ...
            pwd, subj.study, subj.subjectID, subj.sessionID);

        if settings.do_val_cal == 1

            bid_filename       = sprintf('%s/conditions/EATBid_cond', pwd);

        end

    elseif strcmp(subj.runLABEL, 'EAT')

        cond_filename      = sprintf('%s/conditions/EATExp_cond_%s_%s_S%s_R%s.mat', ...
            pwd, subj.study, subj.subjectID, subj.sessionID, subj.runID);

        maxeffort_filename = sprintf('%s/data/%s', pwd, maxeffort_searchdir.name);

    end

elseif windows

    if strcmp(subj.runLABEL, 'training')

        cond_filename      = sprintf('%s\\conditions\\EATTrain_cond_%s_%s_S%s_R%s.mat', ...% I changed this on the 17.01.2025 to take not only run 1 conditions (Luisa Kaluza)
            pwd, subj.study, subj.subjectID, subj.sessionID, subj.runID);
        if settings.do_val_cal == 1

            bid_filename       = sprintf('%s\\conditions\\EATBid_cond', pwd);

        end

    elseif strcmp(subj.runLABEL, 'EAT')

        cond_filename      = sprintf('%s\\conditions\\EATExp_cond_%s_%s_S%s_R%s.mat', ...
            pwd, subj.study, subj.subjectID, subj.sessionID, subj.runID);

        maxeffort_filename = sprintf('%s\\data\\%s', pwd, maxeffort_searchdir.name);

    end

end

if settings.do_gamepad == 1

    load(['.' filesep 'input_specs' filesep 'JoystickSpecification.mat']);
    input_type = 1; % variable needed in VAS and LHS scale scripts to index Joystick (vs. Mouse)

    findJoystick

end

% loading of files
load(cond_filename);
if strcmp(subj.runLABEL, 'EAT')
    disp(['Searching for file: ' maxeffort_filename])
    load(maxeffort_filename,'input_device');
end

%%% load jitters
if linux

    ball_jitter_filename = sprintf('%s/jitters/DelayJitter_mu_%s_max_%s_trials_%s.mat', pwd, timings.avrg_jttr_ball, timings.max_jttr_ball, num2str(timings.number_trials));
    fix1_jitter_filename = sprintf('%s/jitters/DelayJitter_mu_%s_max_%s_trials_%s.mat', pwd, timings.avrg_jttr_fix1, timings.max_jttr_fix1, num2str(timings.number_trials));
    fix2_jitter_filename = sprintf('%s/jitters/DelayJitter_mu_%s_max_%s_trials_%s.mat', pwd, timings.avrg_jttr_fix2, timings.max_jttr_fix1, num2str(timings.number_trials));

elseif windows

    ball_jitter_filename = sprintf('%s\\jitters\\DelayJitter_mu_%s_max_%s_trials_%s.mat', pwd, timings.avrg_jttr_ball, timings.max_jttr_ball, num2str(timings.number_trials));
    fix1_jitter_filename = sprintf('%s\\jitters\\DelayJitter_mu_%s_max_%s_trials_%s.mat', pwd, timings.avrg_jttr_fix1, timings.max_jttr_fix1, num2str(timings.number_trials));
    fix2_jitter_filename = sprintf('%s\\jitters\\DelayJitter_mu_%s_max_%s_trials_%s.mat', pwd, timings.avrg_jttr_fix2, timings.max_jttr_fix1, num2str(timings.number_trials));

end

load(ball_jitter_filename);
ball_jitter = Shuffle(DelayJitter);

load(fix1_jitter_filename);
fix1_jitter = Shuffle(DelayJitter);

load(fix2_jitter_filename);
fix2_jitter = Shuffle(DelayJitter);

%%% Load graphics for counter and instruction graphics

% load regular images for behavioral task
if settings.do_fmri == 0
    [img_coin.winCounter, img_coin.map, img_coin.alpha]       = imread('./stimuli/singlecoin.jpg');
    [img_cookie.winCounter, img_cookie.map, img_cookie.alpha] = imread('./stimuli/singlecookie_choc.jpg');

    [img.incentive_coins1, img.map, img.alpha]  = imread('./stimuli/incentive_coins1.jpg');
    [img.incentive_coins10, img.map, img.alpha] = imread('./stimuli/incentive_coins10_2.jpg');

    [img.incentive_cookies1, img.map, img.alpha]  = imread('./stimuli/incentive_cookies_choc1.jpg');
    [img.incentive_cookies10, img.map, img.alpha] = imread('./stimuli/incentive_cookies_choc10_2.jpg');

    if strcmp(subj.runLABEL, 'training') && settings.do_val_cal == 1
        [img.bidding_food_50, img.map, img.alpha]  = imread('./stimuli/snickers_50.png');
        [img.bidding_food_100, img.map, img.alpha] = imread('./stimuli/snickers_100.png');
        [img.bidding_food_200, img.map, img.alpha] = imread('./stimuli/snickers_200.png');

        [img.bidding_money_50, img.map, img.alpha]  = imread('./stimuli/money_50.png');
        [img.bidding_money_100, img.map, img.alpha] = imread('./stimuli/money_100.png');
        [img.bidding_money_200, img.map, img.alpha] = imread('./stimuli/money_200.png');
    end

else % load mirrored images for fmri experiment
    [img_coin.winCounter, img_coin.map, img_coin.alpha]       = imread('./stimuli/singlecoinM.jpg');
    [img_cookie.winCounter, img_cookie.map, img_cookie.alpha] = imread('./stimuli/singlecookie_chocM.jpg');

    [img.incentive_coins1, img.map, img.alpha]  = imread('./stimuli/incentive_coins1M.jpg');
    [img.incentive_coins10, img.map, img.alpha] = imread('./stimuli/incentive_coins10_2M.jpg');

    [img.incentive_cookies1, img.map, img.alpha]  = imread('./stimuli/incentive_cookies_choc1.jpg');
    [img.incentive_cookies10, img.map, img.alpha] = imread('./stimuli/incentive_cookies_choc10_2M.jpg');

    [img.pinata, img.map, img.alpha]  = imread('./stimuli/pinata.jpg'); % TODO: Change for winning pinata and mirror

end

% Create time stamp
timestamps.seed = rng;

%% Part 6: Psychtoolbox and screen

PsychDefaultSetup(1); %unifies key names on all operating systems

% Basic screen setup
setup.screenNum     = max(Screen('Screens')); %secondary monitor if  connected

% Define colors
color.white         = WhiteIndex(setup.screenNum);
color.grey          = color.white / 2;
color.black         = BlackIndex(setup.screenNum);
color.red           = [255 0 0];
color.darkblue      = [0 0 139];
color.royalblue     = [65 105 225]; %light blue, above threshold
color.notpink       = [213 93 93]; %color uncertainty area
color.gold          = [255,215,0];
color.scale_anchors = [205 201 201];
color.light_grey    = [204 204 204];

% Define the keyboard keys that are listened for.
keys.escape = KbName('ESCAPE');
keys.resp   = KbName('Space');
keys.left   = KbName('LeftArrow');
keys.right  = KbName('RightArrow');
keys.down   = KbName('DownArrow');



% Open the screen
if  settings.do_fullscreen ~= 1   %if fullscreen = 0, small window opens
[w,wRect] = Screen('OpenWindow',setup.screenNum,color.white,[0 0 1000 800]);
else
   [w,wRect] = Screen('OpenWindow',setup.screenNum,color.white, []);
end

% Get the center coordinates
[setup.xCen, setup.yCen] = RectCenter(wRect);

% Flip to clear
Screen('Flip', w);

% Query the frame duration
setup.ifi                = Screen('GetFlipInterval', w);

% Query the maximum priority level - optional
setup.topPriorityLevel   = MaxPriority(w);

% Setup overlay screen
effort_scr      = Screen('OpenOffscreenwindow',w,color.white);
setup.ScrWidth  = wRect(3) - wRect(1);
setup.ScrHeight = wRect(4) - wRect(2);

% Text parameters
Screen('TextSize',effort_scr,16);
Screen('TextFont',effort_scr,'Arial');

% Key Press settings
KbQueueCreate();
KbQueueFlush();
KbQueueStart();
[b,c] = KbQueueCheck;

%% Part 7: general image settings

% Prepare incentive textures
stim.incentive_coins1       = Screen('MakeTexture', w, img.incentive_coins1);
stim.incentive_coins10      = Screen('MakeTexture', w, img.incentive_coins10);
stim.incentive_cookies1     = Screen('MakeTexture', w, img.incentive_cookies1);
stim.incentive_cookies10    = Screen('MakeTexture', w, img.incentive_cookies10);
if settings.do_fmri == 1
    stim.pinata                 = Screen('MakeTexture', w, img.pinata);
end

if strcmp(subj.runLABEL, 'training') && settings.do_val_cal == 1
    stim.bidding_food50       = Screen('MakeTexture', w, img.bidding_food_50);
    stim.bidding_food100      = Screen('MakeTexture', w, img.bidding_food_100);
    stim.bidding_food200      = Screen('MakeTexture', w, img.bidding_food_200);
    stim.bidding_money50      = Screen('MakeTexture', w, img.bidding_money_50);
    stim.bidding_money100     = Screen('MakeTexture', w, img.bidding_money_100);
    stim.bidding_money200     = Screen('MakeTexture', w, img.bidding_money_200);
end

% Drawing parameters for Thermometer (Tube)
Tube.width                  = round(setup.ScrWidth * .20);
Tube.offset                 = round((setup.ScrHeight - (setup.ScrHeight * .95)) * .35);
Tube.height                 = round(Tube.offset+setup.ScrHeight/4);
Tube.XCor1                  = setup.xCen-Tube.width/2;
Tube.XCor2                  = setup.xCen+Tube.width/2;
Tube.YBottom                = setup.ScrHeight-Tube.offset;

% Drawing parameters for Ball
Ball.width                  = round(setup.ScrWidth * .06);

% Location of the Incentive Counter
YCorCounter                 = setup.ScrHeight/6;
if settings.do_fmri == 1
    XCorCounter             = setup.xCen*0.45;
else
    XCorCounter             = setup.xCen*1.5;
end

% Drawing parameters for Reward details
Coin.width                  = round(setup.ScrWidth * .15);
% Location of reward incentive
Coin.TopImg                 = setup.ScrHeight/4;
Coin.BottomImg              = Coin.TopImg + Coin.width;

if settings.do_fmri == 0
    Coin.RightImg           = setup.xCen-Tube.width;
    Coin.LeftImg            = Coin.RightImg - Coin.width;
else
    Coin.RightImg           = setup.xCen-Tube.width + setup.xCen;
    Coin.LeftImg            = setup.xCen-Tube.width-Coin.width + setup.xCen;
end

Coin.loc                    = [Coin.LeftImg Coin.TopImg Coin.RightImg Coin.BottomImg];
% Text parameters
Text.height                 = setup.ScrHeight/5;
Text.height_cont            = Text.height * 4.7;
%% Part 8: WOF specific settings

if settings.do_WOF == 1
    %add paths
    addpath('Wheel_of_fortune');        %WOF path
    addpath('Wheel_of_fortune\sounds'); %adding path for soundfiles
    addpath('Wheel_of_fortune\charts'); %adding path for charts

    %load files
    load('Spinner.mat','winloss2spin_end_pos'); % matrix spinning necessary for win/loss value
    load Wheel_of_Fortune_matr_sel.mat          % matrixes info sequence pies & wins/losses

    %versions a and b have different versions of the random walk of wins
    %accross trials
    version                    = sprintf(subj.order);

    %reseed random number generator (important for random selection of
    %variation of the sequence version (version +/-1)
    rng('shuffle');

    %determines base win/loss values
    if version == 'a'
        output.wof.base_win_amnt = wof_data_sel(2:15,18);
    elseif version == 'b'
        output.wof.base_win_amnt = wof_data_sel(2:15,19);
    end

    %determines final win/loss values including adding sequence with +/-1s
    %to get slight variation between versions of same sequence presented
    wof_colvals = 20:29;
    wof_colsel = randsample(wof_colvals,1);
    output.wof.win_amnt = output.wof.base_win_amnt + wof_data_sel(2:15,wof_colsel);


    %creates matrix to store exact win/loss values
    output.wof.wof_outcomes    = zeros(14,3);
    %     output.wof.win_amnt_a      = wof_data_sel(2:15,18);
    %     output.wof.win_amnt_b      = wof_data_sel(2:15,19);
    count_PANAS                = 1;

    %timings
    timings.wof.time_wait                       = 1;
    timings.wof.time_show_pie_feedback_phase    = 5;
    timings.wof.time_show_feedback              = 3;

    %textsizes
    txtsize_for_exclamation = 70;
    txtsize_for_header      = 30;
    txtsize_for_star        = 80;

    % Presentation coordinates
    wdw     = 2*setup.xCen;                 % full width window
    wdh     = 2*setup.yCen;                 % full height window
    xfrac   = .8;                           % fraction of x width to use
    yfrac   = .6;                           % fraction of y height to use
    xl0     = xfrac*wdw;                    % width to use in pixels
    yl0     = yfrac*wdh; 					% height to use in pixels
    x0      = (1-xfrac)*setup.xCen; 		% zero point along width
    y0      = (1-yfrac)*setup.yCen;			% zero point along height


    % THE PIES
    pieh    = yl0;                          %height of a pie
    piew    = yl0;                          %width of a pie
    pie_pos = [setup.xCen-piew/2   setup.yCen-pieh/2 ...
        setup.xCen+piew/2   setup.yCen+pieh/2];
    radius  = yl0/2;

    %Distance in radians between consecutive instances of the asterisk when the
    %wheel is 'spinning'
    step_size_theta = 0.05;

    %Other graphics positions
    tmp             = imread('fixation.jpg');
    fixation        = Screen('MakeTexture',w,tmp);
    circlew         = piew/5;
    circleh         = pieh/5;
    circle_pos      = [setup.xCen-circlew/2 setup.yCen-circleh/2 ...
        setup.xCen+circlew/2 setup.yCen+circleh/2];
    fixation_pos    = [setup.xCen-circlew/5 setup.yCen-circleh/5 ...
        setup.xCen+circlew/5 setup.yCen+circleh/5];

    %correction for fixation sign; same correction used for the little star
    %displayed when the lotterie is played out
    fix_corr_w      = 1/100*xl0;     %how much more to the left
    fix_corr_h      = 1/150*xl0;     %how much higher

    %correction for exclamation sign
    cue_corr_w      = 1/300*xl0;     %how much more to the left
    cue_corr_h      = 0*1/80*xl0;    %how much higher

    %define trials for WOF
    WoFTrials       = [1:6:72];

    if ~strcmp(subj.runLABEL, 'training')
        TempPieIndex = 2; % starts counter
    elseif strcmp(subj.runLABEL, 'training')
        TempPieIndex = 1; %defines practice WoF trial
    end

    %output structures
    output.PANAS.values.rating = [];
    output.PANAS.values.submission = [];
    output.PANAS.values.trialstarttime = [];
    output.PANAS.values.ratingsubmtime = [];
end

%% Part 9: VAS specific settings

if settings.do_VAS == 1
    %  Load VAS-jitters
    if strcmp(subj.runLABEL, 'training')
        if linux
            jitter_filename = sprintf('%s/jitters/DelayJitter_mu_0.70_max_4_trials_%s.mat', pwd, num2str(length(conditionstable.Difficulty)*2));
        elseif windows
            jitter_filename = sprintf('%s\\jitters\\DelayJitter_mu_0.70_max_4_trials_%s.mat', pwd, num2str(length(conditionstable.Difficulty)*2));
        end
    else
        if linux
            jitter_filename = sprintf('%s/jitters/DelayJitter_mu_0.70_max_4_trials_%s.mat', pwd, num2str(length(conditionstable.Difficulty)*2));
        elseif windows
            jitter_filename = sprintf('%s\\jitters\\DelayJitter_mu_0.70_max_4_trials_%s.mat', pwd, num2str(length(conditionstable.Difficulty)*2));
        end
    end

    load(jitter_filename);

    if settings.do_fmri == 0
        jitter = Shuffle(DelayJitter);
    else
        jitter = DelayJitter;
    end

    output.rating.all_VAS = [];

end

%% Part 10: Training

if strcmp(subj.runLABEL, 'training')

    if settings.do_EGG_training
        sendTTL(settings.EGG.trigger.exp_on, 1)
    end

    % load welcome instructions

    if settings.do_fmri == 0

        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.train_welcome_text, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);


        WaitSecs(0.5);
        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.train_welcome_text, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2); %Luisa
        Screen('Flip',w);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

    else % grip force device

        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.train_welcome_text, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);

        WaitSecs(2)
        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.train_welcome_text, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);%Luisa
        Screen('Flip',w);

        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        gripforce_value = max(Joystick.X, Joystick.Y);

        while gripforce_value < 10000
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_value = max(Joystick.X, Joystick.Y);
        end
    end

    TrainEAT_main_v7
    if settings.check_calibration == 1

        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.pinata, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);

        WaitSecs(2)
        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.pinata, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);%Luisa
        Screen('Flip',w);

        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        gripforce_value = max(Joystick.X, Joystick.Y);

        while gripforce_value < 10000
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_value = max(Joystick.X, Joystick.Y);
        end
        Calibration_Pinata

        % Drawing parameters for Reward details
        Coin.width                  = round(setup.ScrWidth * .15);
        % Location of reward incentive
        Coin.TopImg                 = setup.ScrHeight/4;
        Coin.BottomImg              = Coin.TopImg + Coin.width;

        if settings.do_fmri == 0
            Coin.RightImg           = setup.xCen-Tube.width;
            Coin.LeftImg            = Coin.RightImg - Coin.width;
        else
            Coin.RightImg           = setup.xCen-Tube.width + setup.xCen;
            Coin.LeftImg            = setup.xCen-Tube.width-Coin.width + setup.xCen;
        end

        Coin.loc                    = [Coin.LeftImg Coin.TopImg Coin.RightImg Coin.BottomImg];

    end
end

%% Part 11: Input device unrelated values

% Initialise vectors and counting variables
i_break         = 0;
t_vector        = []; % Vector for time references observations
count_breaks    = 1;

% Initialize parameters for payout calculation
flag            = 0;          % 1 if frequency exceeds MaxFrequency
exceed_onset    = 0;          % Time point of ball exceeding threshold
t_payout        = [nan; nan]; % collects all t1/t2 in one trial
i_payout_onset  = 1;

% Display counter visible during trial
win_coins       = nan;
win_cookies     = nan;
payout.diff     = [nan nan]';
payout.counter  = 0;
payout.win      = 0;

% Initialize output structure
output.data_mat         = []; %every 100 ms for fr, every loop for gr
output.win.payout_per_trial = 0;

% vector storing effort measure
effort_vector   = [nan]; %stores effort value

%% Part 12: Input device dependent values

%%% 12.1: frequency
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

    % Initialize drawing factors
    draw_frequency_normalize = maxfreq_estimate/input_device.maxEffort;
    draw_frequency_factor    = Tube.height*0.3 * draw_frequency_normalize; % scale to tube


    % Initialise exponential weighting
    forget_fact         = 0.6;
    i_phantom           = 1;
    prev_weight_fact    = 0;
    prev_movingAvrg     = 0;
    current_input       = 0;
    Avrg_value          = 0;    %!! Remove? seems unused
    frequency_estimate  = 0;
    draw_frequency      = 0;    % used to determine ball height
    freq_interval       = 1;    % Frequency estimation interval 1 sec
    prev_movingAvrg_phantom(1,1) = prev_movingAvrg;
    phantom_current_input       = 0;

    collect_freq.t_button_interval  = [];
    collect_freq.avrg               = []; %!! Remove? seems unused

    % Initialize frEAT specific output structures
    output.freq.track_button             = []; % stores timestamps of every individual button press

    %drawing parameters for uncertainty
    EffortLow  = input_device.maxEffort * 0.64;
    EffortHigh = input_device.maxEffort * 0.95;
    LwrBndUncertain  = Tube.YBottom - EffortLow * draw_frequency_factor;
    UpprBndUncertain = Tube.YBottom - EffortHigh * draw_frequency_factor;

    %%% 12.2: grip force
else % grip force device (EAT)
    % initialize grip force device
    load('./input_specs/GripForceSpec.mat')
    % initialize grip force specific values - only use values of right hand

    % determine the usable range of the force-input-device for each side
    forceRangeR = input_device.maxEffortR - input_device.minEffortR;
    forceRangeL = input_device.maxEffortL - input_device.minEffortL;
    % set the restforce for each side as 5% above minimum per side
    restforceR = input_device.minEffortR + 0.05*forceRangeR;
    restforceL = input_device.minEffortL + 0.05*forceRangeL;

    if (settings.do_fmri == 1) && (settings.debug == 0)
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    else
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec);
    end
    gripforce_valueL = Joystick.X;
    gripforce_valueR = Joystick.Y;
    gripforce_value = max(Joystick.X, Joystick.Y);


    i_step_gr           = 1;  % Enummarate over loops
    % delta_pos_force     = input_device.maxEffortR - input_device.minEffortR; % replaced by forceRangeL & forceRangeR
    clckforce           = input_device.minEffortR + 0.85* ...
        abs(input_device.maxEffortR - input_device.minEffortR);
    ForceMatR           = restforceR;
    ForceMatL           = restforceL;
    effort_vector       = [];
    effort_vectorL       = [];
    effort_vectorR       = [];
    LowerBoundBar       = setup.ScrHeight - Tube.offset; % height at which the bar starts
    UpperBoundBar       = Tube.height + Ball.width; % highest allowed position of bar
    BarBoundAbs         = LowerBoundBar - UpperBoundBar; % the usable Y-range of the tube for a bar, in pixel
    %BarBound2Scale      = BarBoundAbs/delta_pos_force; % a scale-factor between range of tube and force
    BarBound2ScaleR     = BarBoundAbs/forceRangeR; % scale-factor right
    BarBound2ScaleL     = BarBoundAbs/forceRangeL; % scale-factor left

    % drawing parameters for uncertainty
    EffortLow            = input_device.minEffortR + forceRangeR * 0.64; %64 percent of maxEffort, used to draw uncertainty box
    LwrBndUncertain      = LowerBoundBar - (EffortLow - input_device.minEffortR) * BarBound2ScaleR; %bottom y coordinate of uncertainty box
    EffortHigh           = input_device.minEffortR + forceRangeR * 0.95; %95 percent of maxEffort, used to draw uncertainty box
    UpprBndUncertain     = LowerBoundBar - (EffortHigh - input_device.minEffortR) * BarBound2ScaleR; %top y coordinate of uncertainty box

end

%% Part 13: Uncertainty

%drawing parameters for uncertainty
box.position        = [Tube.XCor1, UpprBndUncertain, Tube.XCor2, LwrBndUncertain];

%% Part 14: Text instructions

Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
if strcmp(subj.runLABEL, 'training')
    if settings.do_fmri == 0
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.strt_actual_train2, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);
        WaitSecs(0.5);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.strt_actual_train2, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2); %Luisa
        Screen('Flip',w);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

    elseif settings.do_fmri == 1
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.strt_actual_train, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);
        WaitSecs(3);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.strt_actual_train, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2); %Luisa
        Screen('Flip',w);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        gripforce_value = max(Joystick.X, Joystick.Y);
        while gripforce_value < clckforce
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_valueL = Joystick.X;
            gripforce_valueR = Joystick.Y;
            gripforce_value = max(Joystick.X, Joystick.Y);
        end
    end
else

    if settings.do_fmri == 0
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.intro_exp2, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);
        WaitSecs(0.5);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.intro_exp2, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);%Luisa
        Screen('Flip',w);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

        if settings.do_tVNS == 1

            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.intro_exp3, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
            Screen('Flip',w);

            WaitSecs(0.5);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.intro_exp3, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);%Luisa
            Screen('Flip',w);
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            while Joystick.Button(1) ~= 1
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            end
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

        end

        % elseif settings.do_fmri == 1
        %     [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.intro_exp1, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        %     Screen('Flip',w);
        %     WaitSecs(3);
        %         [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.intro_exp1, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        % [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);%Luisa
        % Screen('Flip',w);
        %     [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        %     gripforce_value = max(Joystick.X, Joystick.Y);
        %     while gripforce_value < clckforce
        %         [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        %         gripforce_valueL = Joystick.X;
        %         gripforce_valueR = Joystick.Y;
        %         gripforce_value = max(Joystick.X, Joystick.Y);
        %     end
    end
end

if settings.do_fmri == 0
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_nr1, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);

    WaitSecs(0.5);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_nr1, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2); %Luisa
    Screen('Flip',w);
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    while Joystick.Button(1) ~= 1
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    end
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);


    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_nr2, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('DrawTexture', w, stim.incentive_coins1,[], [(setup.xCen*0.7) (Text.height*2.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) (Text.height*2.9)])
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_coins1, setup.xCen, ((setup.ScrHeight/5)*3.2-Coin.width/2), color.black,40, [], [], 1.2);
    Screen('DrawTexture', w, stim.incentive_coins10,[], [(setup.xCen*0.7) (Text.height*3.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) (Text.height*3.9)])
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_coins10, setup.xCen, ((setup.ScrHeight/5)*4.2-Coin.width/2), color.black,40, [], [], 1.2);
    Screen('Flip',w);

    WaitSecs(0.5);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_nr2, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2); %Luisa
    Screen('DrawTexture', w, stim.incentive_coins1,[], [(setup.xCen*0.7) (Text.height*2.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) (Text.height*2.9)])
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_coins1, setup.xCen, ((setup.ScrHeight/5)*3.2-Coin.width/2), color.black,40, [], [], 1.2);
    Screen('DrawTexture', w, stim.incentive_coins10,[], [(setup.xCen*0.7) (Text.height*3.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) (Text.height*3.9)])
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_coins10, setup.xCen, ((setup.ScrHeight/5)*4.2-Coin.width/2), color.black,40, [], [], 1.2);
    Screen('Flip',w);
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    while Joystick.Button(1) ~= 1
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    end
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);


    if settings.do_food == 1
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_nr3, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('DrawTexture', w, stim.incentive_cookies1,[], [(setup.xCen*0.7) (Text.height*2.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) (Text.height*2.9)])
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_cookies1, setup.xCen, ((setup.ScrHeight/5)*3.2-Coin.width/2), color.black,40, [], [], 1.2);
        Screen('DrawTexture', w, stim.incentive_cookies10,[], [(setup.xCen*0.7) (Text.height*3.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) (Text.height*3.9)])
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_cookies10, setup.xCen, ((setup.ScrHeight/5)*4.2-Coin.width/2), color.black,40, [], [], 1.2);
        Screen('Flip',w);

        WaitSecs(0.5);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_nr3, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2); %Luisa
        Screen('DrawTexture', w, stim.incentive_cookies1,[], [(setup.xCen*0.7) (Text.height*2.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) (Text.height*2.9)])
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_cookies1, setup.xCen, ((setup.ScrHeight/5)*3.2-Coin.width/2), color.black,40, [], [], 1.2);
        Screen('DrawTexture', w, stim.incentive_cookies10,[], [(setup.xCen*0.7) (Text.height*3.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) (Text.height*3.9)])
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_cookies10, setup.xCen, ((setup.ScrHeight/5)*4.2-Coin.width/2), color.black,40, [], [], 1.2);
        Screen('Flip',w);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

    end

    if settings.lang_de == 1
        if settings.do_food == 1
            instr.reward_nr4         = ['Die Umrechnung der Punkte richtet sich nach folgendem Kurs:  '...
                '\n 100  Geld-Punkte entsprechen ' num2str(input_device.value_money) ' cent.'...
                '\n\n  100  Essens-Punkte entsprechen ' num2str(input_device.value_food) ' kcal.'...
                '\n\nIm Anschluss an die Aufgabe koennen Sie die Geldpunkte in einen entsprechenden Geldbetrag eintauschen'...
                '\nund fuer die Essens-Punkte einen entsprechenden Snack erhalten.'];
        else
            instr.reward_nr4         = ['Die Umrechnung der Punkte richtet sich nach folgendem Kurs:  '...
                '\n 100  Geld-Punkte entsprechen ' num2str(input_device.value_money) ' cent.'...
                '\n\nIm Anschluss an die Aufgabe koennen Sie die Geldpunkte in einen entsprechenden Geldbetrag eintauschen.'];
        end
    else
        if settings.do_food == 1
            instr.reward_nr4         = ['The points will be converted using the following exchange rates:  '...
                '\n 100  Money points correspond to ' num2str(input_device.value_money) ' cents.'...
                '\n\n  100  Snack points correspond to ' num2str(input_device.value_food) ' kcal.'...
                '\n\nFollowing the task, you can exchange the Money points for the corresponding amount of money'...
                ' \nand the Snack points for the corresponding number of snacks.'];
        else
            instr.reward_nr4         = ['The points will be converted using the following exchange rates:  '...
                '\n 100  Money points correspond to ' num2str(input_device.value_money) ' cents.'...
                '\n\nFollowing the task, you can exchange the Money points for the corresponding amount of money.'];
        end
    end

   
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_nr4, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);

        WaitSecs(0.5);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_nr4, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);%Luisa
        Screen('Flip',w);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
  

    if strcmp(subj.runLABEL, 'training')
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.diff_nr1, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);
        WaitSecs(0.5);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.diff_nr1, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2); %Luisa
        Screen('Flip',w);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    else
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.diff_exp, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);
        WaitSecs(0.5);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.diff_exp, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2); %Luisa
        Screen('Flip',w);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    end



    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.vas_nr1, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);

    WaitSecs(0.5);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.vas_nr1, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2); %Luisa
    Screen('Flip',w);
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    while Joystick.Button(1) ~= 1
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    end
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.vas_nr2, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);

    WaitSecs(0.5);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.vas_nr2, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2); %Luisa
    Screen('Flip',w);
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    while Joystick.Button(1) ~= 1
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    end
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);


    if settings.do_WOF == 1 && ~strcmp(subj.runLABEL, 'training')
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.wof_exp, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);

        WaitSecs(0.5);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.wof_exp, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);%Luisa
        Screen('Flip',w);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);


        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.wof_panas, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);

        WaitSecs(0.5);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.wof_panas, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);%Luisa
        Screen('Flip',w);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

    end
else

    if settings.lang_de == 1
        if settings.do_food == 1
            instr.reward_nr4         = ['Die Umrechnung der Punkte richtet sich nach folgendem Kurs:  '...
                '\n 100  Geld-Punkte entsprechen ' num2str(input_device.value_money) ' cent.'...
                '\n\n  100  Essens-Punkte entsprechen ' num2str(input_device.value_food) ' kcal.'...
                '\n\nIm Anschluss an die Aufgabe koennen Sie die Geldpunkte in einen entsprechenden Geldbetrag eintauschen'...
                '\nund fuer die Essens-Punkte einen entsprechenden Snack erhalten.'];
        else
            instr.reward_nr4         = ['Die Umrechnung der Punkte richtet sich nach folgendem Kurs:  '...
                '\n 100  Geld-Punkte entsprechen ' num2str(input_device.value_money) ' cent.'...
                '\n\nIm Anschluss an die Aufgabe koennen Sie die Geldpunkte in einen entsprechenden Geldbetrag eintauschen.'];
        end
    else
        if settings.do_food == 1
            instr.reward_nr4         = ['The points will be converted using the following exchange rates:  '...
                '\n 100  Money points correspond to ' num2str(input_device.value_money) ' cents.'...
                '\n\n  100  Snack points correspond to ' num2str(input_device.value_food) ' kcal.'...
                '\n\nFollowing the task, you can exchange the Money points for the corresponding amount of money'...
                '\nand the Snack points for the corresponding number of snacks.'];
        else
            instr.reward_nr4         = ['The points will be converted using the following exchange rates:  '...
                '\n 100  Money points correspond to ' num2str(input_device.value_money) ' cents.'...
                '\n\nFollowing the task, you can exchange the Money points for the corresponding amount of money.'];
        end
    end

    if strcmp(subj.runLABEL, 'training')
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_nr4, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);
    WaitSecs(7);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_nr4, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);%Luisa
    Screen('Flip',w);
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

if strcmp(subj.runLABEL, 'training') && settings.do_fmri == 0
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.time_train, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);

    WaitSecs(0.5);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.time_train, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);%Luisa
    Screen('Flip',w);
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    while Joystick.Button(1) ~= 1
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    end
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

elseif ~strcmp(subj.runLABEL, 'training')
    if settings.do_fmri == 0
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.time_exp2, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);
        WaitSecs(0.5);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.time_exp2, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text.A, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);%Luisa
        Screen('Flip',w);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end

        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    % elseif settings.do_fmri == 1
    %     [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.time_exp, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    %     Screen('Flip',w);
    %     WaitSecs(5);
    %     [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.time_exp, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    %     [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);%Luisa
    %     Screen('Flip',w);
    % 
    %     [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    %     gripforce_value = max(Joystick.X, Joystick.Y);
    %     while gripforce_value < clckforce
    %         [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    %         gripforce_valueL = Joystick.X;
    %         gripforce_valueR = Joystick.Y;
    %         gripforce_value = max(Joystick.X, Joystick.Y);
    %     end
    end
end

%% Part 15: Start fMRI procedure
%Listen for triggers
if settings.do_fmri == 1  && ~strcmp(subj.runLABEL, 'training') && settings.debug == 0

    % Show waiting screen while waiting for trigger
    Screen('TextSize',w,28);
    Screen('TextFont',w,'Arial');

      [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.intro_exp1, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
      %       Screen('Flip',w);

    % if settings.lang_de
     % [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instr.intro_exp1, 'center', 'center', [0 0 0], 150, flp_flg_hrz, flp_flg_vrt, 1.2);
    % else
    %     [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, 'Wait for MRI', 'center', 'center', [0 0 0], 150, flp_flg_hrz, flp_flg_vrt, 1.2);
    % end

    Screen('Flip', w);

    MR_timings.on_trigger_loop = GetSecs;

    KbQueueCreate();
    KbQueueStart();

    try
        MR_timings.trigger.all = waitForScannerTrigger(dummy_volumes, keyQuit);
        MR_timings.trigger.fin = GetSecs;
    catch ME
        sca;
        rethrow(ME)
    end
    % KbQueueRelease(); $ this deletes the handle to the keyboard, no
    % checking or flushing afterwards!

elseif settings.do_fmri == 1  && strcmp(subj.runLABEL, 'training')
    MR_timings.trigger.fin = GetSecs;
elseif settings.do_fmri == 1  && settings.debug == 1
    MR_timings.trigger.fin = GetSecs;
end

KbQueueFlush();

timestamps.exp_on = GetSecs;

%% Part 16: The actual task

% Trigger EGG
if settings.do_EGG == 1 && ~strcmp(subj.runLABEL, 'training')
    % Write trigger for EGG - start of the experiment
    sendTTL(settings.EGG.trigger.exp_on, 1)
end

%  Loop while entries in the conditions file left

if settings.do_gamepad == 0 && strcmp(subj.runLABEL, 'training')
    condition_length = length(conditions)/2; % Only use half the amount of possible trials for training
else
    condition_length = length(conditions);
end

for i_trial = 1:condition_length %condition file determines repetitions
    %% 16.01 Break

    % Trigger EGG
    if settings.do_EGG == 1 && ~strcmp(subj.runLABEL, 'training')
        sendTTL(settings.EGG.trigger.rest)
    end

    if i_trial == timings.break_trials(count_breaks)
        if count_breaks < timings.number_breaks
            count_breaks = count_breaks + 1;
        end
        i_timer = 1;
        timer_onset_feedback = GetSecs;

        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');

        if settings.do_fmri == 0 && ~strcmp(subj.runLABEL, 'training')
            timestamps.break = timer_onset_feedback;

            while i_timer <= timings.break_length

                while i_timer > GetSecs - timer_onset_feedback

                    % Draw Text
                    if settings.lang_de == 1
                        text = ['Sie koennen jetzt eine kurze Pause machen und sich lockern.'...
                            '\n\n\n' num2str(timings.break_length - i_timer) ...
                            '  Sekunden bis zur naechsten Runde.'];
                    else
                        text = ['You can now take a short break and rest.'...
                            '\n\n\n' num2str(timings.break_length - i_timer) ...
                            '  seconds until the next round.'];
                    end
                    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text, 'center', 'center', [0 0 0],150);
                    Screen('Flip', w, []);

                end
                i_timer = i_timer + 1;

            end

        elseif settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training') && settings.debug == 0

            i_timer = 1;
            i_break = i_break +1;

            timestamps.break(i_break) = timer_onset_feedback;
            MR_timings.onsets.break(i_break) = timestamps.break(i_break) - MR_timings.trigger.fin;
            MR_timings.durations.break(i_break) = timings.break_length;

            while i_timer <= timings.break_length

                while i_timer > GetSecs - timer_onset_feedback

                    % Draw Text
                    if settings.lang_de == 1
                        text = ['Sie koennen jetzt eine kurze Pause machen und sich lockern.'...
                            '\n\n\n' num2str(timings.break_length - i_timer) ...
                            '  Sekunden bis zur naechsten Runde.'];
                    else
                        text = ['You can now take a short break and rest.'...
                            '\n\n\n' num2str(timings.break_length - i_timer) ...
                            '  seconds until the next round.'];
                    end
                    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', setup.ScrHeight/5, color.black,60, flp_flg_hrz, flp_flg_vrt, 1.2);
                    Screen('Flip',w);

                end

                i_timer = i_timer + 1;

            end

        end

    end

    %% 16.02

    if settings.do_WOF == 1
        if ~strcmp(subj.runLABEL, 'training')
            %insert PANAS before start
            if i_trial == 1
                Call_PANAS_VAS
            end
            %inserts Wheel of fortune trial before appropriate runs
            if rem(i_trial,timings.nmbr_trls_to_WOF) == 1
                runtrialwof
                TempPieIndex = TempPieIndex + 1;
            end
        end
    end

    %% 16.03 Update trial settings before trial start

    input_device.incentive      = conditions(i_trial, 2); % 1 = Money, 0 = Food
    input_device.value          = conditions(i_trial, 3); % 1 or 10
    input_device.uncertainty    = conditions(i_trial, 4); % 1 = uncertain, 0 = certain

    %input device specific updates trialwise

    if settings.do_gamepad == 0
        %difficulty of trial
        input_device.percentEffort = input_device.minEffortR + forceRangeR * conditions(i_trial,1) * 0.01;
        %Threshold position for obtaining reward in this trail
        Threshold.yposition        = LowerBoundBar - (input_device.percentEffort - input_device.minEffortR) * BarBound2ScaleR;
    elseif settings.do_gamepad == 1
        input_device.percentEffort  = input_device.maxEffort * conditions(i_trial, 1) * 0.01;
        Threshold.yposition         = Tube.YBottom - input_device.percentEffort * draw_frequency_factor;
    end

    % Prepare graphical display with corresponding reward items
    % load incentive & counter icon
    if input_device.incentive == 1 && input_device.value == 1
        incentive       = stim.incentive_coins1;
        img.winCounter  = img_coin.winCounter;
        img.map         = img_coin.map;
        img.alpha       = img_coin.alpha;
    elseif input_device.incentive == 1 && input_device.value == 10
        incentive       = stim.incentive_coins10;
        img.winCounter  = img_coin.winCounter;
        img.map         = img_coin.map;
        img.alpha       = img_coin.alpha;
    elseif input_device.incentive == 0 && input_device.value == 1
        incentive       = stim.incentive_cookies1;
        img.winCounter  = img_cookie.winCounter;
        img.map         = img_cookie.map;
        img.alpha       = img_cookie.alpha;
    elseif input_device.incentive == 0 && input_device.value == 10
        incentive       = stim.incentive_cookies10;
        img.winCounter  = img_cookie.winCounter;
        img.map         = img_cookie.map;
        img.alpha       = img_cookie.alpha;
    end

    % load single-coin/single-cookie picture for Counter
    stim.winCounter = Screen('MakeTexture', w, img.winCounter);
    % Incentive counter param
    SizeCounterDim1 = size(img.winCounter,2)*0.3;
    SizeCounterDim2 = size(img.winCounter,1)*0.3;
    IncCounter = [(XCorCounter - SizeCounterDim1) (YCorCounter - SizeCounterDim2) XCorCounter YCorCounter];
    
    %calculate trial_legnth (antic= 1 + ball jitter + work + fix 1 + jitter +
    %feedback length + fix2 + jitter
	
    if settings.do_feedback == 1
    trial_length(i_trial) = 1 + ball_jitter(i_trial,1) + timings.trial_length + timings.fix1_length + fix1_jitter(i_trial,1) + timings.feedback_length + timings.fix2_length + fix2_jitter(i_trial,1);
    else
    trial_length(i_trial) = 1 + ball_jitter(i_trial,1) + timings.trial_length + timings.fix2_length + fix2_jitter(i_trial,1);
    end


    %% 16.04 Show incentive before difficulty
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

   

    % now start tVNS treatment
    if settings.do_tVNS && ~strcmp(subj.runLABEL, 'training')
        tvnsInfo = startTVNS(tvnsInfo);
    end

    % Trigger EGG
    if settings.do_EGG == 1 && ~strcmp(subj.runLABEL, 'training')
        if input_device.incentive == 1
            % Write trigger for EGG - cue for money reward
            sendTTL(settings.EGG.trigger.cue_money)

        elseif input_device.incentive == 0
            % Write trigger for EGG - cue for food reward
            sendTTL(settings.EGG.trigger.cue_food)

        end
    end
    
    timestamps.condition_preview_reward(i_trial,1) = starttime;
    if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training') && settings.debug == 0
        MR_timings.onsets.condition_preview_reward(i_trial,1) = starttime - MR_timings.trigger.fin;
    end

    %Show screen for 1s plus jitter value (drawn from exponential distribution with mean of 2 and max = 12)
    
    time_stamp_ball = GetSecs;
    while time_stamp_ball-starttime < 1 + ball_jitter(i_trial,1)
              time_stamp_ball = GetSecs;
    end

    MR_timings.durations.condition_preview_reward(i_trial,1) = GetSecs - starttime;

    %% 16.05 Add difficulty
    % Draw Incentive
    Screen('DrawTexture', w, incentive,[], Coin.loc);
    % Incentive on effort screen
    Screen('DrawTexture', effort_scr, incentive,[], Coin.loc);
    Screen('CopyWindow',effort_scr,w);
    % Draw Tube
    Screen('DrawLine',effort_scr,color.black,Tube.XCor1, Tube.height, Tube.XCor1, Tube.YBottom ,6);
    Screen('DrawLine',effort_scr,color.black,Tube.XCor2, Tube.height, Tube.XCor2, Tube.YBottom ,6);
    Screen('DrawLine',effort_scr,color.black,Tube.XCor1, Tube.YBottom, Tube.XCor2, Tube.YBottom,6);
    if input_device.uncertainty == 0
        % Threshold
        Screen('DrawLine',w,color.red,Tube.XCor1, Threshold.yposition, Tube.XCor2, Threshold.yposition,3);
        [time.img, starttime] = Screen('Flip', w);
    else %uncertainty condition in experiment, draw uncertainty box
        % Uncertainty Box
        Screen('FillRect',w,color.notpink,box.position);
        [time.img, starttime] = Screen('Flip', w);
    end


    %% 16.06 Actual trial start
    t_trial_onset = GetSecs;
    t_buttonN_1   = t_trial_onset;
    onset_start   = 0; %flag for MR_onset

    % Trigger EGG
    if settings.do_EGG == 1 && ~strcmp(subj.runLABEL, 'training')
        % Write trigger for EGG - start of the work block
        sendTTL(settings.EGG.trigger.work_block)
    end

    while (timings.trial_length > (GetSecs - t_trial_onset))
        %% 16.06.1 Draw graphical display

        % Draw Tube
        Screen('DrawLine',effort_scr,color.black,Tube.XCor1, Tube.height, Tube.XCor1, Tube.YBottom ,6);
        Screen('DrawLine',effort_scr,color.black,Tube.XCor2, Tube.height, Tube.XCor2, Tube.YBottom ,6);
        Screen('DrawLine',effort_scr,color.black,Tube.XCor1, Tube.YBottom, Tube.XCor2, Tube.YBottom,6);
        % Incentive
        Screen('DrawTexture', effort_scr, incentive,[], Coin.loc);
        Screen('CopyWindow',effort_scr,w);

        % Draw Max% line or uncertainty box
        if input_device.uncertainty == 0
            Screen('DrawLine',w,color.red,Tube.XCor1, Threshold.yposition, Tube.XCor2, Threshold.yposition,3);
        else
            Screen('FillRect',w,color.notpink,box.position);
        end

        % Show incentive counter if no uncertainty
        if length(unique(conditions(:,4))) == 1 || strcmp(subj.runLABEL, 'training')
            if settings.do_fmri == 1
                Screen('DrawTexture', w, stim.winCounter,[], IncCounter);
                text = [ num2str(payout.win, '%02i') ' x ' ];
            else
                Screen('DrawTexture', w, stim.winCounter,[], IncCounter);
                text = [ ' x ' num2str(payout.win, '%02i') ];
            end
            Screen('TextSize',w,56);
            Screen('TextFont',w,'Arial');
            if settings.do_fmri == 1
                [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, ...
                    setup.xCen*0.5, YCorCounter, color.black, [], flp_flg_hrz, flp_flg_vrt);
            else
                [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text,...
                    XCorCounter, YCorCounter, color.black);
            end
        end

        %% 16.06.2 grEAT specific ball settings
        if settings.do_gamepad == 0
            % Track Ball position and translate into payout
            Ball.DrawFactor = 0;
            % BarBound2ScaleR - scalefactor between range of tube and force
            % ForceMat - the last measured force (right)
            if (ForceMatR > restforceR)
                Ball_ypositionR = LowerBoundBar - BarBound2ScaleR * (ForceMatR - restforceR);
                Ball_ypositionL = LowerBoundBar - BarBound2ScaleL * (ForceMatL - restforceL);
                % the minimum is a "higher" position on screen
                Ball_yposition = Ball_ypositionR; % take value of right grip force device always for trials
            else
                Ball_yposition = Tube.YBottom;
            end
            %% 16.06.3 frEAT specific ball settings
        elseif settings.do_gamepad == 1
            Ball.DrawFactor = draw_frequency * draw_frequency_factor;
            Ball_yposition  = Tube.YBottom;
        end

        Ball.position       = [(setup.xCen-Ball.width/2) (Ball_yposition - Ball.width - Ball.DrawFactor)...
            (setup.xCen+Ball.width/2) (Ball_yposition - Ball.DrawFactor)];

        %% 16.06.4 general reward settings
        % Ball above threshold
        % -> change color, start increasing score
        if Ball.position(1,4) < Threshold.yposition
            if input_device.uncertainty == 0
                Ball.color = color.royalblue;
            else
                Ball.color = color.darkblue;
            end

            if (flag == 0) % Mark "crossing the threshold"
                flag                       = 1;
                exceed_onset               = GetSecs;
                t_payout(1,i_payout_onset) = exceed_onset;

                if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')  && settings.debug == 0
                    timestamps.win_phase(i_trial,win_phase_counter)  = exceed_onset;
                    MR_timings.onsets.win(i_trial,win_phase_counter) = exceed_onset - MR_timings.trigger.fin;
                    win_phase_counter                                = win_phase_counter + 1;
                end
            end

            % Calculate payoff for exceed_Threshold:
            % If ball above threshold, need phantom value to update
            % reward counter
            t_payout(3,i_payout_onset) = GetSecs;
            payout.diff                = t_payout(3,1:end) - t_payout(1,1:end);
            payout.counter             = sum(payout.diff,"omitnan");
            payout.win                 = floor(payout.counter);

            % Ball below threshold:
            % -> change color, stop increasing score
        else
            Ball.color = color.darkblue;
            if flag == 1 % Mark "crossing the threshold"
                flag                       = 0;
                exceed_offset              = GetSecs;
                t_payout(2,i_payout_onset) = exceed_offset;
                i_payout_onset = i_payout_onset + 1;
                if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')  && settings.debug == 0
                    timestamps.rest_phase(i_trial,rest_phase_counter)        = exceed_offset;
                    MR_timings.onsets.rest_phase(i_trial,rest_phase_counter) = exceed_offset - MR_timings.trigger.fin;
                    rest_phase_counter                                       = rest_phase_counter + 1;
                end
            end
        end

        Screen('FillOval',w,Ball.color,Ball.position);
        [time.img, starttime] = Screen('Flip', w);

        % For first flip, track time
        if onset_start == 0 && settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training') && settings.debug == 0
            timestamps.effort(i_trial,1)        = starttime;
            MR_timings.onsets.effort(i_trial,1) = starttime - MR_timings.trigger.fin;
            onset_start = 1;
        end



        %% Part 16.06.5: frEAT
        if settings.do_gamepad == 1
            t_step = GetSecs;
            if (0.1 * i_step_fr) <= (t_step - t_trial_onset)
                t_vector(1,i_step_fr)       = t_step - t_trial_onset;
                effort_vector(1,i_step_fr)  = draw_frequency;
                i_step_fr                   = i_step_fr + 1;
            end

            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);

            %Buffer routine
            for buffer_i = 2:50 %buffer_size

                %continuously log position and time of the button
                joy.pos_Z(count_joy,i_trial) = Joystick.Z;
                joy.time_log(count_joy,i_trial) = GetSecs - t_trial_onset;
                count_joy = count_joy + 1;

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
                    buffer_i = 2;
                    xbox_buffer(1)=xbox_buffer(50);
                end

                %Frequency estimation based on Button Press
                if c(keys.resp) > 0 || count_joystick == 1

                    if (t_button > (t_trial_onset + 0.1)) %Prevents too fast button press at the beginning
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



            %% Part 16.06.6: grEAT specific input query
        elseif settings.do_gamepad == 0
            [b,c] = KbQueueCheck;


            % Continuously log position and time of the button for the right index
            % finger -> Joystick.Z
            if windows
                if settings.do_fmri == 1 && settings.debug == 0
                    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                else
                    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec);
                end
                gripforce_valueL = Joystick.X;
                gripforce_valueR = Joystick.Y;
                gripforce_value = max(Joystick.X, Joystick.Y);

            elseif linux

                axisState       = Gamepad('GetAxis', grip_force_idx, grip_force_axis);
                gripforce_value = axisState;

            end

            % Get timestamps of MexFile call to get accurate sampling rate
            if settings.do_fmri == 1
                timestamps.grip_force_sampling_rate(i_trial,gf_sr_counter) = GetSecs;
                gf_sr_counter                                              = gf_sr_counter + 1;
            end

            % Getting values from Grip Force Device -> maximum of Joystick.X or Joystick.Y
            ForceMatR       = gripforce_valueR;
            ForceMatL       = gripforce_valueL;
            effort_vector           = [effort_vector, gripforce_value];
            effort_vectorL          = [effort_vectorL, gripforce_valueL];
            effort_vectorR          = [effort_vectorR, gripforce_valueR];
            % Store for timestamps and actual frequency every 100ms
            t_step                   = GetSecs;
            t_vector(1,i_step_gr)    = t_step - t_trial_onset;
            i_step_gr                = i_step_gr + 1;
        end

        %% 16.07 End of trial (ATTENTION - THIS IS NOT THE END OF TRIAL; WE ARE
        % STILL INSIDE A WHILE LOOP; THAT IS NOT A PROPER PLACE FOR DOING THINGS
        % THAT NEED TO BE DONE ONLY ONCE - 10.05.2024/Paul Jung)

        count_joy    = 1;
        end_of_trial = GetSecs;

        if flag == 1
            t_payout(2,i_payout_onset) =  end_of_trial;
        end

        % Calculate payoff for exceed_Threshold
        exc_thresh_this_trial = t_payout(2,1:end)-t_payout(1,1:end);
        if settings.do_fmri == 1
            MR_timings.durations.win = [MR_timings.durations.win exc_thresh_this_trial];
        end

        % Calculate win for this trial according to reward at stake
        if input_device.incentive == 1 && input_device.value == 1
            win_coins   = floor(sum((exc_thresh_this_trial),"omitnan"));
        elseif input_device.incentive == 0 && input_device.value == 1
            win_cookies = floor(sum((exc_thresh_this_trial),"omitnan"));
        elseif input_device.incentive == 1 && input_device.value == 10
            win_coins   = floor(sum((exc_thresh_this_trial),"omitnan")) * 10;
        elseif input_device.incentive == 0 && input_device.value == 10
            win_cookies = floor(sum((exc_thresh_this_trial),"omitnan")) * 10;
        end

        % Store reward in output struct
        output.win.payout_per_trial(1,i_trial) = win_coins;
        output.win.payout_per_trial(2,i_trial) = win_cookies;
        output.win.payout_per_trial(3,i_trial) = input_device.incentive;
        output.win.payout_per_trial(4,i_trial) = input_device.value;
        if isnan(output.win.payout_per_trial(1,i_trial))
            output.win.payout_per_trial(5, i_trial) = win_cookies;
        else
            output.win.payout_per_trial(5, i_trial) = win_coins;
        end

    end % end of while loop
    %% end of 16.06.1 Draw graphical display

    if settings.do_EGG == 1 && ~strcmp(subj.runLABEL, 'training')
        sendTTL(settings.EGG.trigger.work_block_end)
    end

    % end tVNS treatment & handle errors
    if settings.do_tVNS && ~strcmp(subj.runLABEL, 'training')
        tvnsInfo = endTVNS(tvnsInfo);

        % here we stop in case the tvns device failed to start/end stimulating
        if tvnsInfo.stimSuccess == 0 || tvnsInfo.endSuccess == 0
            ShowCursor;
            keyContinue = KbName('f12');    % key to continue task-flow
            keyRestartTVNS = KbName('f8');  % key to restart tvns

            fprintf(2, 'Dear experimenter, there is a problem with the tVNS device.\n')
            fprintf(2, 'Please check the tVNS manager console.\n')
            fprintf(2, ['Press ' KbName(keyRestartTVNS) ' to restart the connection.\n'])
            fprintf(2, ['Press ' KbName(keyContinue) ' to continue task-flow.\n'])

            % show an intermediate "please wait" screen
            if settings.lang_de == 1
                txt = 'Bitte warten Sie bis der Versuchsleiter\ndie tVNS Verbindung repariert hat.';
            else
                txt = 'Please wait until\nthe experimenter fixed\nthe tVNS connection';
            end
            DrawFormattedText(w, txt, 'center', 'center', color.black, 80);
            Screen('Flip', w);

            while true % check keyboard
                [~,c] = KbQueueCheck();
                if c(keyRestartTVNS) ~= 0 % restart tVNS connection & setup
                    tvnsInfo = initTVNS();
                    setupTVNS(tvnsInfo, subj.stim_amplitude, subj.stim_freq, subj.stim_length, subj.pause_length)
                end
                if c(keyContinue) ~= 0 % continue task flow
                    break
                end
                WaitSecs(0.1);
            end
            if subj.sess == 1 || subj.sess == 2
                HideCursor;
            end
        end
    end

    %% 16.08 Fixation cross 1
    if timings.fix1_length > 0
        fix = '+';
        Screen('TextSize',w,64);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', color.black,80);
        [time.fix, starttime]                 = Screen('Flip', w);

        timestamps.fix1(i_trial,1)        = starttime;
        %Show screen for fix time plus jitter value
        time_stamp_fix1 = GetSecs;
        while time_stamp_fix1-starttime < timings.fix1_length + fix1_jitter(i_trial,1)
            time_stamp_fix1 = GetSecs;
        end


        if settings.do_fmri == 1

            MR_timings.onsets.fix1(i_trial,1) = starttime - MR_timings.trigger.fin;
            MR_timings.durations.fix1(i_trial,1) = timings.fix1_length + fix1_jitter(i_trial,1);
        end
    end

    %% 16.09 VAS
    if settings.do_VAS == 1
        count_col = 1;
        output.rating.all_VAS(i_trial, 1) = i_trial;
        count_col = count_col + 1;

        if settings.do_EGG && ~strcmp(subj.runLABEL, 'training')
            sendTTL(settings.EGG.trigger.VAS)
        end

        if settings.VAS.exhaustion == 1
            trial.question = 'exhausted';

            Effort_VAS

            output.rating.exhaustion_runstart(1,i_trial) = startTime; %Start time of rating
            output.rating.exhaustion_t_button(1,i_trial) = t_rating_ref; %Time of rating submission
            output.rating.exhaustion(1,i_trial)          = rating;
            output.rating.exhaustion_label{1,i_trial}    = rating_label;
            output.rating.exhaustion_subm(1,i_trial)     = rating_subm;

            output.rating.all_VAS(i_trial, 2) = output.rating.exhaustion(i_trial);
            count_col = count_col + 1;

            %Reset variables
            rating       = nan;
            rating_label = nan;
            rating_subm  = nan;

            %     else
            %         output.rating.exhaustion(1,i_trial)          = nan;
        end

        if settings.VAS.wanting == 1
            trial.question = 'wanted';

            Effort_VAS

            output.rating.wanting_runstart(1,i_trial) = startTime; %Start time of rating
            output.rating.wanting_t_button(1,i_trial) = t_rating_ref; %Time of rating submission
            output.rating.wanting(1,i_trial)          = rating;
            output.rating.wanting_label{1,i_trial}    = text_freerating;
            output.rating.wanting_subm(1,i_trial)     = 1;

            output.rating.all_VAS(i_trial, 3) = output.rating.wanting(i_trial);
            count_col = count_col + 1;


            %Reset variables
            rating       = nan;
            rating_label = nan;
            rating_subm  = nan;

            %     else
            %         output.rating.wanting(1,i_trial)          = nan;
        end

        if settings.VAS.happy1 == 1
            if settings.lang_de == 1
                trial.question = 'gluecklich';
            else
                trial.question = 'happy';
            end

            Effort_VAS

            output.rating.happy1_runstart(1,i_trial) = startTime; %Start time of rating
            output.rating.happy1_t_button(1,i_trial) = t_rating_ref; %Time of rating submission
            output.rating.happy1(1,i_trial)          = rating;
            output.rating.happy1_label{1,i_trial}     = text_freerating;
            output.rating.happy1_subm(1,i_trial)     = 1;

            output.rating.all_VAS(i_trial, 4) = output.rating.happy1(i_trial);
            count_col = count_col + 1;


            %Reset variables
            rating       = nan;
            rating_label = nan;
            rating_subm  = nan;
            %
            %     else
            %         output.rating.happy1(1,i_trial)          = nan;
        end

        if settings.do_EGG && ~strcmp(subj.runLABEL, 'training')
            sendTTL(settings.EGG.trigger.VAS_end)
        end

    end

    %% 16.10 Feedback to trial
    if settings.do_feedback == 1
        timer_onset_feedback = GetSecs;
        onset_start = 0;

        % Trigger EGG
        if settings.do_EGG == 1 && ~strcmp(subj.runLABEL, 'training')
            if conditions(i_trial,4) == 1
                % Write trigger for EGG - feedback uncertain
                sendTTL(settings.EGG.trigger.feedback_uncertain)

            elseif conditions(i_trial,4) == 0
                % Write trigger for EGG - feedback certain
                sendTTL(settings.EGG.trigger.feedback_certain)
            end
        end

        if strcmp(subj.runLABEL, 'EAT')
            if i_trial <= length(conditions)

                if input_device.incentive == 1 % money
                    if settings.lang_de == 1
                        text = ['Durchgang beendet.\n\nGewinn:   ' ...
                            num2str(win_coins) '   Geld-Punkt(e).'];
                    else
                        text = ['Trial complete.\n\nWinnings:   ' ...
                            num2str(win_coins) '   Money point(s).'];
                    end
                elseif input_device.incentive == 0 % food
                    if settings.lang_de == 1
                        text = ['Durchgang beendet.\n\nGewinn:   ' ...
                            num2str(win_cookies) '   Essens-Punkt(e).'];
                    else
                        text = ['Trial complete.\n\nWinnings:   ' ...
                            num2str(win_cookies) '   Snack point(s).'];
                    end
                end
                % Draw Text
                Screen('TextSize',w,32);
                Screen('TextFont',w,'Arial');
                if settings.do_fmri == 1 || settings.do_WOF == 1
                    [~,~,~] = DrawFormattedText(w, text, 'center',(setup.ScrHeight/10), ...
                        color.black,40,flp_flg_hrz,flp_flg_vrt);
                else
                    [~,~,~] = DrawFormattedText(w, text, 'center',(setup.ScrHeight/10), color.black,40);
                    if settings.lang_de == 1
                        counter = ['Naechste Runde: ' num2str(4 - ceil(i_timer))];
                    else
                        counter = ['Next round: ' num2str(4 - ceil(i_timer))];
                    end
                    Screen('TextSize',w,26);
                    Screen('TextFont',w,'Arial');
                    [~,~,~] = DrawFormattedText(w, counter, 8*(setup.ScrWidth/10),9*(setup.ScrHeight/10), ...
                        color.black,40);
                end

                if length(unique(conditions(:,4))) > 1
                    % Draw Tube
                    Screen('DrawLine',w,color.black,Tube.XCor1, Tube.height, Tube.XCor1, Tube.YBottom ,6);
                    Screen('DrawLine',w,color.black,Tube.XCor2, Tube.height, Tube.XCor2, Tube.YBottom ,6);
                    Screen('DrawLine',w,color.black,Tube.XCor1, Tube.YBottom, Tube.XCor2, Tube.YBottom,6);
                    % Draw Threshold line
                    Screen('DrawLine',w,color.red,Tube.XCor1, Threshold.yposition, Tube.XCor2, Threshold.yposition,3);
                end

                % For first flip, track time
                if onset_start == 0
                    [ons_resp, starttime] = Screen('Flip', w);
                    onset_start = 1;
                else
                    Screen('Flip', w);
                end

                time_stamp_feedback = GetSecs;
                while time_stamp_feedback-starttime < timings.feedback_length
                    time_stamp_feedback = GetSecs;
                end

                timestamps.feedback(i_trial,1) = starttime;
                if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')  && settings.debug == 0
                    MR_timings.onsets.feedback(i_trial,1) = starttime - MR_timings.trigger.fin;
                end
            end
        elseif strcmp(subj.runLABEL, 'training')

            if i_trial <= length(conditions)

                if input_device.incentive == 1 % money
                    if settings.lang_de == 1
                        text = ['Durchgang beendet.\n\nGewinn:   ' ...
                            num2str(win_coins) '   Geld-Punkt(e).'];
                    else
                        text = ['Trial complete.\n\nWinnings:   ' ...
                            num2str(win_coins) '   Money point(s).'];
                    end
                elseif input_device.incentive == 0 % food
                    if settings.lang_de == 1
                        text = ['Durchgang beendet.\n\nGewinn:   ' ...
                            num2str(win_cookies) '   Essens-Punkt(e).'];
                    else
                        text = ['Trial complete.\n\nGewinn:   ' ...
                            num2str(win_cookies) '   Snack point(s).'];
                    end
                end

                Screen('TextSize',w,32);
                Screen('TextFont',w,'Arial');
                if settings.do_fmri == 1 || settings.do_WOF == 1
                    [~,~,~] = DrawFormattedText(w, text, 'center', 'center', color.black,40, ...
                        flp_flg_hrz,flp_flg_vrt);
                else
                    [~,~,~] = DrawFormattedText(w, text, 'center', 'center', color.black,40);
                    Screen('TextSize',w,26);
                    Screen('TextFont',w,'Arial');
                    if settings.lang_de == 1
                        counter = ['Naechste Runde: ' num2str(4 - ceil(i_timer))];
                    else
                        counter = ['Next round: ' num2str(4 - ceil(i_timer))];
                    end
                    [~,~,~] = DrawFormattedText(w, counter, 8*(setup.ScrWidth/10), ...
                        9*(setup.ScrHeight/10), color.black,40);
                end

                if length(unique(conditions(:,4))) > 1
                    %Draw Tube
                    Screen('DrawLine',w,color.black,Tube.XCor1, Tube.height, Tube.XCor1, Tube.YBottom ,6);
                    Screen('DrawLine',w,color.black,Tube.XCor2, Tube.height, Tube.XCor2, Tube.YBottom ,6);
                    Screen('DrawLine',w,color.black,Tube.XCor1, Tube.YBottom, Tube.XCor2, Tube.YBottom,6);
                    % Draw Threshold line
                    Screen('DrawLine',w,color.red,Tube.XCor1, Threshold.yposition, Tube.XCor2, Threshold.yposition,3);
                end

                % For first flip, track time
                if onset_start == 0
                    [ons_resp, starttime] = Screen('Flip', w);
                    onset_start = 1;
                else
                    Screen('Flip', w);
                end


                time_stamp_feedback = GetSecs;
                while time_stamp_feedback-starttime < timings.feedback_length
                    time_stamp_feedback = GetSecs;
                end


            end
        end

        % Trigger EGG
        if settings.do_EGG == 1 && ~strcmp(subj.runLABEL, 'training')
            sendTTL(settings.EGG.trigger.feedback_end)
        end

    end

    %% 16.11 VAS after feedback
    if settings.do_VAS == 1
        if settings.VAS.happy2 == 1
            if settings.lang_de == 1
                trial.question = 'gluecklich';
            else
                trial.question = 'happy';
            end

            if settings.do_EGG && ~strcmp(subj.runLABEL, 'training')
                sendTTL(settings.EGG.trigger.VAS2)
            end

            Effort_VAS

            if settings.do_EGG && ~strcmp(subj.runLABEL, 'training')
                sendTTL(settings.EGG.trigger.VAS2_end)
            end

            output.rating.happy2_runstart(1,i_trial) = startTime; %Start time of rating
            output.rating.happy2_t_button(1,i_trial) = t_rating_ref; %Time of rating submission
            output.rating.happy2(1,i_trial)          = rating;
            output.rating.happy2_label{1,i_trial}    = text_freerating;
            output.rating.happy2_subm(1,i_trial)     = 1;

            output.rating.all_VAS(i_trial, 5) = output.rating.happy2(i_trial);
            count_col = count_col + 1;

            %Reset variables
            rating       = nan;
            rating_label = nan;
            rating_subm  = nan;

            %     else
            %         output.rating.happy2(1,i_trial)          = nan;
        end

        %do PANAS
        if settings.do_WOF == 1 && ~strcmp(subj.runLABEL, 'training')
            if i_trial ~= 1
                if i_trial == timings.PANAS_trials(count_PANAS)
                    Call_PANAS_VAS
                end
            end
        end
    end

    %% 16.12 Show inter-trial interval fixation cross

    % Fixation cross 2
    fix = '+';
    Screen('TextSize',w,64);
    Screen('TextFont',w,'Arial');
    [~,~,~]               = DrawFormattedText(w, fix, 'center', 'center', color.black,80);
    [time.fix, starttime] = Screen('Flip', w);


    timestamps.fix2(i_trial,1) = starttime;

    if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')  && settings.debug == 0
        MR_timings.onsets.fix2(i_trial,1)    = starttime - MR_timings.trigger.fin;
        MR_timings.durations.fix2(i_trial,1) = timings.fix1_length + fix2_jitter(i_trial,1);
    end

    %% 16.13 prepare data output

    % %save max effort of training
    % if strcmp(subj.runLABEL, 'training')
    %     if settings.do_gamepad == 0
    %         collectMax.maxEffort(1,i_collectMax) = min(effort_vector);
    %         i_collectMax                         = i_collectMax + 1;
    %     elseif settings.do_gamepad == 1
    %         if isempty(effort_vector)
    %             collectMax.next = nan;
    %         else
    %             collectMax.next = max(effort_vector);
    %         end
    %         collectMax.maxEffort(1,i_collectMax) = collectMax.next;
    %         i_collectMax                         = i_collectMax + 1;
    %     end
    % end

    %Relative effort
    if settings.do_gamepad == 0
        rel_Effort = (((effort_vector - input_device.minEffort) * 100)./(ones(1,length(effort_vector))*input_device.maxEffort - input_device.minEffort));
        rel_EffortL = (((effort_vectorL - input_device.minEffortL) * 100)./(ones(1,length(effort_vectorL))*input_device.maxEffortL - input_device.minEffortL));
        rel_EffortR = (((effort_vectorR - input_device.minEffortR) * 100)./(ones(1,length(effort_vectorR))*input_device.maxEffortR - input_device.minEffortR));
    elseif settings.do_gamepad == 1
        rel_Effort =  effort_vector *100/input_device.maxEffort;
        if exist('t_button_vec')
            %Time reference t_Button to trial_start
            t_button_ref_vec = t_button_vec - t_trial_onset;
        end
    end

    %Copy Output Values into Output Matrix
    if settings.do_gamepad == 0
        output.data_mat = vertcat(output.data_mat, [ones(length(effort_vector),1) * subj.id, ...                       %ID
            ones(length(effort_vector),1) * subj.sess, ...                                               %Sess
            ones(length(effort_vector),1) * subj.run, ...                                               %run
            ones(length(effort_vector),1) * i_trial,  ...                                                %Trial
            ones(length(effort_vector),1) * input_device.maxEffortR, ...                                  %Max_Eff Right
            ones(length(effort_vector),1) * input_device.minEffortR, ...                                  %Min_Eff Right
            t_vector', ...                                                                                %Time_Ref
            effort_vector', ...                                                                           %Effort
            effort_vectorL', ...                                                                          %Effort left (x-axis)
            effort_vectorR', ...                                                                          %Effort right (y-axis)
            rel_Effort', ...                                                                              %relative Effort
            rel_EffortL', ...                                                                              %relative Effort left (x-axis)
            rel_EffortR', ...                                                                              %relative Effort right (y-axis)
            ones(length(effort_vector),1) * conditions(i_trial,1), ...                                   %Diff
            ones(length(effort_vector),1) * conditions(i_trial,2), ...                                   %Money
            ones(length(effort_vector),1) * conditions(i_trial,3), ...                                   %Rew_magn
            ones(length(effort_vector),1) * conditions(i_trial,4), ...                                   %Uncertainty
            ones(length(effort_vector),1) * output.win.payout_per_trial(5,i_trial)/conditions(i_trial,3),... %amount of seconds above threshold
            ones(length(effort_vector),1) * output.win.payout_per_trial(5,i_trial)]);                        %Payout (total amount of points)
    else
        output.data_mat = vertcat(output.data_mat, [ones(length(effort_vector),1) * subj.id, ...                       %ID
            ones(length(effort_vector),1) * subj.sess, ...                                               %Sess
            ones(length(effort_vector),1) * subj.run, ...                                               %run
            ones(length(effort_vector),1) * i_trial,  ...                                                %Trial
            ones(length(effort_vector),1) * input_device.maxEffort, ...                                  %Max_Eff
            ones(length(effort_vector),1) * input_device.minEffort, ...                                  %Min_Eff
            t_vector', ...                                                                                %Time_Ref
            effort_vector', ...                                                                           %Effort
            rel_Effort', ...                                                                              %relative Effort
            ones(length(effort_vector),1) * conditions(i_trial,1), ...                                   %Diff
            ones(length(effort_vector),1) * conditions(i_trial,2), ...                                   %Money
            ones(length(effort_vector),1) * conditions(i_trial,3), ...                                   %Rew_magn
            ones(length(effort_vector),1) * conditions(i_trial,4), ...                                   %Uncertainty
            ones(length(effort_vector),1) * output.win.payout_per_trial(5,i_trial)/conditions(i_trial,3),... %amount of seconds above threshold
            ones(length(effort_vector),1) * output.win.payout_per_trial(5,i_trial)]);                        %Payout (total amount of points)
    end

    if settings.do_gamepad == 1 && exist('t_button_ref_vec')
        output.freq.track_button = [output.freq.track_button, [ones(1,length(t_button_ref_vec)) * i_trial; ...
            t_button_ref_vec]];                                                      %every time stamp of every button press
    end

    if settings.do_WOF == 1 && ~strcmp(subj.runLABEL, 'training') && ...
            (i_trial == timings.PANAS_trials(count_PANAS) || i_trial == 1)
        %creates matrix of PANAS ratings
        output.PANAS.values.rating = [output.PANAS.values.rating, [subj.id ; ...                                   %Subj_ID
            i_trial ;  ...                                                      %Trial_ID
            output.PANAS.archive.rating_active(i_trial,2); ...                  %VAS Rating active
            output.PANAS.archive.rating_interested(i_trial,2); ...              %VAS Rating interested
            output.PANAS.archive.rating_excited(i_trial,2); ...                 %VAS Rating excited
            output.PANAS.archive.rating_strong(i_trial,2); ...                  %VAS Rating strong
            output.PANAS.archive.rating_inspired(i_trial,2); ...                %VAS Rating inspired
            output.PANAS.archive.rating_proud(i_trial,2);  ...                  %VAS Rating proud
            output.PANAS.archive.rating_enthusiastic(i_trial,2); ...            %VAS Rating enthusiastic
            output.PANAS.archive.rating_alert(i_trial,2);  ...                  %VAS Rating alert
            output.PANAS.archive.rating_determined(i_trial,2); ...              %VAS Rating determined
            output.PANAS.archive.rating_attentive(i_trial,2); ...               %VAS Rating attentive
            output.PANAS.archive.rating_distressed(i_trial,2); ...              %VAS Rating distressed
            output.PANAS.archive.rating_upset(i_trial,2); ...                   %VAS Rating upset
            output.PANAS.archive.rating_guilty(i_trial,2);                      %VAS Rating guilty
            output.PANAS.archive.rating_scared(i_trial,2); ...                  %VAS Rating scared
            output.PANAS.archive.rating_hostile(i_trial,2); ...                 %VAS Rating hostile
            output.PANAS.archive.rating_irritible(i_trial,2); ...               %VAS Rating irritible
            output.PANAS.archive.rating_ashamed(i_trial,2); ...                 %VAS Rating ashamed
            output.PANAS.archive.rating_nervous(i_trial,2); ...                 %VAS Rating nervous
            output.PANAS.archive.rating_jittery(i_trial,2); ...                 %VAS Rating jittery
            output.PANAS.archive.rating_afraid(i_trial,2)]];                    %VAS Rating afraid

        %creates matrix of whether panas ratings were submitted
        output.PANAS.values.submission = [output.PANAS.values.submission, [subj.id ; ...                           %Subj_ID
            i_trial ;  ...                                                      %Trial_ID
            output.PANAS.archive.rating_active(i_trial,3); ...                  %Rating submitted? active
            output.PANAS.archive.rating_interested(i_trial,3); ...              %Rating submitted? interested
            output.PANAS.archive.rating_excited(i_trial,3); ...                 %Rating submitted? excited
            output.PANAS.archive.rating_strong(i_trial,3); ...                  %Rating submitted? strong
            output.PANAS.archive.rating_inspired(i_trial,3); ...                %Rating submitted? inspired
            output.PANAS.archive.rating_proud(i_trial,3);  ...                  %Rating submitted? proud
            output.PANAS.archive.rating_enthusiastic(i_trial,3); ...            %Rating submitted? enthusiastic
            output.PANAS.archive.rating_alert(i_trial,3);  ...                  %Rating submitted? alert
            output.PANAS.archive.rating_determined(i_trial,3); ...              %Rating submitted? determined
            output.PANAS.archive.rating_attentive(i_trial,3); ...               %Rating submitted? attentive
            output.PANAS.archive.rating_distressed(i_trial,3); ...              %Rating submitted? distressed
            output.PANAS.archive.rating_upset(i_trial,3); ...                   %Rating submitted? upset
            output.PANAS.archive.rating_guilty(i_trial,3);                      %Rating submitted? guilty
            output.PANAS.archive.rating_scared(i_trial,3); ...                  %Rating submitted? scared
            output.PANAS.archive.rating_hostile(i_trial,3); ...                 %Rating submitted? hostile
            output.PANAS.archive.rating_irritible(i_trial,3); ...               %Rating submitted? irritible
            output.PANAS.archive.rating_ashamed(i_trial,3); ...                 %Rating submitted? ashamed
            output.PANAS.archive.rating_nervous(i_trial,3); ...                 %Rating submitted? nervous
            output.PANAS.archive.rating_jittery(i_trial,3); ...                 %Rating submitted? jittery
            output.PANAS.archive.rating_afraid(i_trial,3)]];                    %Rating submitted? afraid
        %creates matrix of PANAS trial start time
        output.PANAS.values.trialstarttime = [output.PANAS.values.trialstarttime, [subj.id ; ...                   %Subj_ID
            i_trial ;  ...                                                      %Trial_ID
            output.PANAS.archive.rating_active(i_trial,1); ...                  %Trial start time active
            output.PANAS.archive.rating_interested(i_trial,1); ...              %Trial start time interested
            output.PANAS.archive.rating_excited(i_trial,1); ...                 %Trial start time excited
            output.PANAS.archive.rating_strong(i_trial,1); ...                  %Trial start time strong
            output.PANAS.archive.rating_inspired(i_trial,1); ...                %Trial start time inspired
            output.PANAS.archive.rating_proud(i_trial,1);  ...                  %Trial start time proud
            output.PANAS.archive.rating_enthusiastic(i_trial,1); ...            %Trial start time enthusiastic
            output.PANAS.archive.rating_alert(i_trial,1);  ...                  %Trial start time alert
            output.PANAS.archive.rating_determined(i_trial,1); ...              %Trial start time determined
            output.PANAS.archive.rating_attentive(i_trial,1); ...               %Trial start time attentive
            output.PANAS.archive.rating_distressed(i_trial,1); ...              %Trial start time distressed
            output.PANAS.archive.rating_upset(i_trial,1); ...                   %Trial start time upset
            output.PANAS.archive.rating_guilty(i_trial,1);                      %Trial start time guilty
            output.PANAS.archive.rating_scared(i_trial,1); ...                  %Trial start time scared
            output.PANAS.archive.rating_hostile(i_trial,1); ...                 %Trial start time hostile
            output.PANAS.archive.rating_irritible(i_trial,1); ...               %Trial start time irritible
            output.PANAS.archive.rating_ashamed(i_trial,1); ...                 %Trial start time ashamed
            output.PANAS.archive.rating_nervous(i_trial,1); ...                 %Trial start time nervous
            output.PANAS.archive.rating_jittery(i_trial,1); ...                 %Trial start time jittery
            output.PANAS.archive.rating_afraid(i_trial,1)]];                    %Trial start time afraid
        %creates matrix of PANAS submission times
        output.PANAS.values.ratingsubmtime = [output.PANAS.values.ratingsubmtime, [subj.id ; ...                   %Subj_ID
            i_trial ;  ...                                                      %Trial_ID
            output.PANAS.archive.rating_active(i_trial,4); ...                  %Submission time active
            output.PANAS.archive.rating_interested(i_trial,4); ...              %Submission time interested
            output.PANAS.archive.rating_excited(i_trial,4); ...                 %Submission time excited
            output.PANAS.archive.rating_strong(i_trial,4); ...                  %Submission time strong
            output.PANAS.archive.rating_inspired(i_trial,4); ...                %Submission time inspired
            output.PANAS.archive.rating_proud(i_trial,4);  ...                  %Submission time proud
            output.PANAS.archive.rating_enthusiastic(i_trial,4); ...            %Submission time enthusiastic
            output.PANAS.archive.rating_alert(i_trial,4);  ...                  %Submission time alert
            output.PANAS.archive.rating_determined(i_trial,4); ...              %Submission time determined
            output.PANAS.archive.rating_attentive(i_trial,4); ...               %Submission time attentive
            output.PANAS.archive.rating_distressed(i_trial,4); ...              %Submission time distressed
            output.PANAS.archive.rating_upset(i_trial,4); ...                   %Submission time upset
            output.PANAS.archive.rating_guilty(i_trial,4);                      %Submission time guilty
            output.PANAS.archive.rating_scared(i_trial,4); ...                  %Submission time scared
            output.PANAS.archive.rating_hostile(i_trial,4); ...                 %Submission time hostile
            output.PANAS.archive.rating_irritible(i_trial,4); ...               %Submission time irritible
            output.PANAS.archive.rating_ashamed(i_trial,4); ...                 %Submission time ashamed
            output.PANAS.archive.rating_nervous(i_trial,4); ...                 %Submission time nervous
            output.PANAS.archive.rating_jittery(i_trial,4); ...                 %Submission time jittery
            output.PANAS.archive.rating_afraid(i_trial,4)]];                    %Submission time afraid


        if i_trial == timings.PANAS_trials(count_PANAS)
            count_PANAS = count_PANAS + 1;
        end
    end
    % Create & Save temporary output data
    if linux || mac

        output.filename = sprintf('%s/backup/EAT%s_%s_%s_S%s_R%S_temp', ...
            pwd, subj.runLABEL, subj.study, subj.subjectID, subj.sessionID, subj.runID);
    elseif windows

        output.filename = sprintf('%s\\backup\\EAT%s_%s_%s_S%s_R%s_temp', ...
            pwd, subj.runLABEL, subj.study, subj.subjectID, subj.sessionID, subj.runID);
    end

    if  (settings.do_gamepad == 1) && (settings.do_fmri == 0)
        save([output.filename datestr(subj.date_start,'_yymmdd_HHMM') '.mat'], 'output', 'subj', 'input_device', 'joy', 'conditions', 'timestamps')
    elseif (settings.do_gamepad == 1) && (settings.do_fmri == 1)
        save([output.filename datestr(subj.date_start,'_yymmdd_HHMM') '.mat'], 'output', 'subj', 'input_device', 'joy', 'conditions', 'timestamps', 'MR_timings')
    elseif (settings.do_gamepad ~= 1) && (settings.do_fmri == 0)
        save([output.filename datestr(subj.date_start,'_yymmdd_HHMM') '.mat'], 'output', 'subj', 'input_device', 'conditions', 'timestamps')
    else
        save([output.filename datestr(subj.date_start,'_yymmdd_HHMM') '.mat'], 'output', 'subj', 'input_device', 'conditions', 'timestamps', 'MR_timings')
    end

    %% 16.14 Clear Variables to initiate new trial

    t_payout                = [nan; nan];
    i_payout_onset          = 1;
    exc_thresh_this_trial   = 0;
    payout.win              = 0;
    win_coins               = nan;
    win_cookies             = nan;

    i_resp                  = 1;
    flag                    = 0;
    end_of_trial            = 0;
    effort_vector           = [];
    effort_vectorL          = [];
    effort_vectorR          = [];
    t_vector                = [];

    if settings.do_gamepad == 0
        ForceMatR       = restforceR;
        ForceMatL       = restforceL;
        i_step_gr       = 1;
    elseif settings.do_gamepad == 1
        draw_frequency  = 0; %resets Ball position
        current_input   = 0;
        i_step_fr       = 1;
        count_joystick  = 0;
        Avrg_value      = 0;
        t_button_vec    = [];
        i_phantom       = 1;
        t_buttonN_1     = 0;
        t_button        = 0;
        frequency_vector    = [];
        current_weight_fact = 0;
        frequency_estimate  = 0;
        prev_weight_fact    = 0;
        prev_movingAvrg     = 0;
        prev_movingAvrg_phantom(1,1) = prev_movingAvrg;
        phantom_current_input       = 0;

        collect_freq.avrg              = [];
        collect_freq.t_button_interval = [];

        phantom_current_input       = 0;
        Estimate_Avrg_value         = 0;
        phantom.freq                = 0;
        phantom.avrg                = [];
        phantom.t_button_interval   = [];
        phantom.frequency           = [];
    end

    if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')
        win_phase_counter   = 1;
        rest_phase_counter  = 1;
        gf_sr_counter       = 1;
    end

    %show fix cross until trial length (ITI is over)
    %calculate actual trial length includding VAS times
    if settings.do_VAS
        length_curr_trial = trial_length(i_trial) + output.rating.exhaustion_t_button + output.rating.wanting_t_button;
    else
        length_curr_trial = trial_length(i_trial);
    end
    
    length_curr_trial
    
    time_stamp_interval_iti = GetSecs;
    while time_stamp_interval_iti - timestamps.condition_preview_reward(i_trial,1) < length_curr_trial
        time_stamp_interval_iti = GetSecs;
    end
            

end

%% Part 17: After experiment

% % Check how well participants did in the practice trials/ if a minimum was
% % reached or whether max force should be adapted
%
% [a,~,c] = unique(output.data_mat(:,4)); %teile nach Trials auf
%
% out_temp_Diff = [a, accumarray(c,output.data_mat(:,14),[],@mean)];% Get Difficulty
% out_temp_check =  [out_temp_Diff, accumarray(c,output.data_mat(:,18),[],@mean)];  % Get Seconds above threshold
%
% check_avg_LD = mean(out_temp_check(out_temp_check(:,2) == 70,3));
% check_avg_HD = mean(out_temp_check(out_temp_check(:,2) == 85,3));
%
% % Low difficulty trials need to be on average >= 20 seconds above threshold
% if check_avg_LD >= 20
%     success_LD = 1;
% else
%     success_LD = 0;
% end
% % High difficulty trials need to be on average >= 10 seconds above threshold
% if check_avg_HD >= 10
%     success_HD = 1;
% else
%     success_HD = 0;
% end
%
% % As soon as trials were not managed on average, adjust max effort more
% % strongly, else normal adjustment
% if success_LD  == 0 | success_HD == 0
%     adjust_eff = 80;
% elseif success_LD  == 1 & success_HD == 1
%     adjust_eff = 95;
% end

% Update maxEffort based on highest value during practice trials
if strcmp(subj.runLABEL, 'training')
    effort_vals = output.data_mat(:,8);
    if settings.do_gamepad == 0
        effort_valsL = output.data_mat(:,9);
        effort_valsR = output.data_mat(:,10);
        input_device.maxEffort      = max(input_device.maxEffort, prctile(effort_vals, 95)); % I changed this term max(effort_vals));Luisa Kaluza
        input_device.maxEffortL      = max(input_device.maxEffortL, prctile(effort_valsL, 95)); %max(effort_valsL)
        input_device.maxEffortR      = max(input_device.maxEffortR, prctile(effort_valsR,95)); %max(effort_valsR)
    elseif settings.do_gamepad == 1
        if prctile(effort_vals,95) > (1.15*input_device.maxEffort) % max(effort_vals)
            input_device.maxEffort  = 1.15*input_device.maxEffort;
        else
            input_device.maxEffort  = max(input_device.maxEffort, prctile(effort_vals, 95)); %max(effort_vals)
        end
        %input_device.maxEffort      = max(input_device.maxEffort,
        %prctile(effort_vals,95)); %max(effort_vals), deleted by Luisa
        %Kaluza
        % set upper boundary to max effort for button presses
        if input_device.maxEffort > 7.5
            input_device.maxEffort = 7.5;
        end
    end
end

if settings.do_WOF == 1 && strcmp(subj.runLABEL, 'training')
    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.wof_train, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);
    disp('waiting for mouse-click')
    GetClicks(setup.screenNum);
end

% Prepare feedback
% Compute win
output.win.sum_coins    = floor(sum(output.win.payout_per_trial(1,1:end),"omitnan"));
output.win.sum_cookies  = floor(sum(output.win.payout_per_trial(2,1:end),"omitnan"));
output.win.money        = floor(output.win.sum_coins*input_device.value_money/100)/100;
output.win.kcal         = floor(output.win.sum_cookies*input_device.value_food/100);

% Tue007 specific:
output.win.snack_kcal       = floor(output.win.kcal*0.2); %20 Percent in snacks
output.win.musli_kcal        = floor(output.win.kcal*0.8); %80 Percent ad lib consumption

snack_kcal = output.win.snack_kcal;
musli_entities = round(output.win.musli_kcal/30);
if musli_entities > 17
    diff_kal = (output.win.musli_kcal - 17*30);
    snack_kcal = snack_kcal + diff_kal;
    musli_entities = 17;
end

if settings.do_WOF == 1
    % End WOF or familiarizatoin WOF
    if strcmp(subj.runLABEL, 'training')
        TempPieIndex = 1;
        runtrialwof
    else
        TempPieIndex = 14;
        runtrialwof
        %Compute WoF earnings
        Wof_result  = sum(output.wof.wof_outcomes(2:14,2));
        if Wof_result <1
            Wof_win = 1;
        else
            Wof_win = Wof_result;
        end
        %present total winning at end
        if settings.lang_de == 1
            text = ['Sie haben beim Gluecksraddrehspiel \n insgesamt ', num2str(Wof_win) ' Euro gewonnen.'];
        else
            text = ['In the Wheel of Fortune, you won \n a total of ', num2str(Wof_win) ' Euros.'];
        end
        Screen('TextSize', w, txtsize_for_header);
        DrawFormattedText(w, text, 'center', setup.ScrHeight/5, color.black);
        Screen('Flip',w);
        WaitSecs(timings.show_feedback );
        Screen('FillRect', w, color.white);
    end
end

% Show final screen (text)
if strcmp(subj.runLABEL, 'training')

    if settings.lang_de == 1
        text = ['Die Uebung ist nun zu Ende.'...
            '\n\n Im richtigen Spiel haetten Sie ' num2str(output.win.sum_coins) ' Geld-Punkte gewonnen. '...
            '\n Das entspicht ' num2str(output.win.money) ' Euro. '...
            '\n\nIm richtigen Spiel haetten Sie ' num2str(output.win.sum_cookies) ' Essens-Punkte gewonnen. '...
            '\nDas entspricht ' num2str(output.win.kcal) ' Kcal.' ];
    else
        text = ['The practice is now complete.'...
            '\n\n In the actual game, you would have won ' num2str(output.win.sum_coins) ' Money points. '...
            '\n This corresponds to ' num2str(output.win.money) ' Euros. '...
            '\n\nIn the actual game, you would have won ' num2str(output.win.sum_cookies) ' Snack points. '...
            '\nThis corresponds to ' num2str(output.win.kcal) ' Kcal.' ];
    end

elseif strcmp(subj.runLABEL, 'EAT')
    if settings.lang_de == 1
        if settings.do_food == 1
            text = ['Das Spiel ist nun zu Ende.'...
                '\n\n Sie haben ' num2str(output.win.sum_coins) ' Geld-Punkte gewonnen. '...
                '\n Das entspicht ' num2str(output.win.money) ' Euro.'...
                '\n\nSie haben ' num2str(output.win.sum_cookies) ' Punkte fuer Essen gewonnen.'...
                '\n Das entspricht ' num2str(output.win.kcal) ' Kcal.'];
        else
            text = ['Das Spiel ist nun zu Ende.'...
                '\n\n Sie haben ' num2str(output.win.sum_coins) ' Geld-Punkte gewonnen. '...
                '\n Das entspicht ' num2str(output.win.money) ' Euro.'];
        end
    else
        if settings.do_food == 1
            text = ['The game is now complete.'...
                '\n\n You won ' num2str(output.win.sum_coins) ' Money points. '...
                '\n This corresponds to ' num2str(output.win.money) ' Euros.'...
                '\n\nYou won ' num2str(output.win.sum_cookies) ' Snack points.'...
                '\n This corresponds to ' num2str(output.win.kcal) ' Kcal.'];
        else

            text = ['The game is now complete.'...
                '\n\n You won ' num2str(output.win.sum_coins) ' Money points. '...
                '\n This corresponds to ' num2str(output.win.money) ' Euros.'];
        end

    end
    if settings.do_fmri == 1
        if settings.lang_de == 1
            text = [text, '\n Bitte bleiben Sie noch still liegen bis wir zu Ihnen in den Raum kommen.'];
        else
            text = [text, '\n Please keep lying down still until we come into the room to get you.'];
        end
    end

end

Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[~,~,~] = DrawFormattedText(w, text, 'center', setup.ScrHeight/5, color.black,60, flp_flg_hrz, flp_flg_vrt, 1.2);

Screen('Flip',w);
timestamps.exp_end = GetSecs;

   % Trigger EGG
if (settings.do_EGG == 1 && ~strcmp(subj.runLABEL, 'training')) || (settings.do_EGG_training == 1 && strcmp(subj.runLABEL, 'training'))
    % Write trigger for EGG - end of the experiment
    sendTTL(settings.EGG.trigger.exp_off)
end

if settings.do_fmri == 1
    sprintf('Experimenter: Mouse click to close the screen.')
    GetClicks(setup.screenNum);
else
    disp('waiting for mouse-click')
    GetClicks(setup.screenNum);
end

KbQueueRelease();


 
             

%% Part 15: Save data

if settings.do_gamepad == 0
    output.variable_labels = {'ID', 'Session', 'Run', 'Trial', 'Maximum Effort Right', 'Minimum Effort Right', 'Time',...
        'Absolute Effort', 'Absolute Effort Left', 'Absolute Effort Right', 'Relative Effort', 'Relative Effort Left', 'Relative Effort Right', 'Difficulty', ...
        'Money', 'Reward Magnitude', 'Uncertainty', 'Seconds of Winning', 'Points Won'};
else
    output.variable_labels = {'ID', 'Session', 'Run', 'Trial', 'Maximum Effort', 'Minimum Effort', 'Time',...
        'Absolute Effort', 'Relative Effort', 'Difficulty', ...
        'Money', 'Reward Magnitude', 'Uncertainty', 'Seconds of Winning', 'Points Won'};
end

% Store output
output.time = datetime;

%Save time end of experiment
subj.date_end      = datestr(now);
t_start=datevec(datenum(subj.date_start));
t_end=datevec(datenum(subj.date_end ));
subj.length_exp = etime(t_end, t_start)/60; %length exp in min

if strcmp(subj.runLABEL, 'training')
    output.filename = sprintf('TrainEAT_%s_%s_S%s_R%s', subj.study, subj.subjectID, subj.sessionID, subj.runID);
else
    output.filename = sprintf('ExpEAT_%s_%s_S%s_R%s', subj.study, subj.subjectID, subj.sessionID, subj.runID);
end

if  settings.do_gamepad == 1
    if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')  && settings.debug == 0
        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'input_device', 'joy', 'conditions', 'timestamps', 'MR_timings');
    elseif strcmp(subj.runLABEL, 'training') && settings.do_val_cal == 1
        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'input_device', 'joy', 'conditions', 'timestamps', 'collectMax', 'collectBid');
    elseif strcmp(subj.runLABEL, 'training') && settings.do_val_cal == 0
        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'input_device', 'joy', 'conditions', 'timestamps', 'collectMax');
    else
        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'input_device', 'joy', 'conditions', 'timestamps');
    end
    save(fullfile('backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));
else
    if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')  && settings.debug == 0
        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'input_device', 'conditions', 'timestamps','MR_timings');
    elseif settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')  && settings.debug == 1
        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'input_device', 'conditions', 'timestamps');
    elseif strcmp(subj.runLABEL, 'training') && settings.do_val_cal == 1
        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'input_device', 'conditions', 'timestamps', 'collectMax', 'collectBid');
    elseif strcmp(subj.runLABEL, 'training') && settings.do_val_cal == 0
        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'input_device', 'conditions', 'timestamps', 'collectMax');
        EAT_dir = pwd;
    else
        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'input_device', 'conditions', 'timestamps');
    end
    save(fullfile('backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));
end


sprintf(['Wins money = ' num2str(output.win.money)])
try
    sprintf(['Wins kcal = ' num2str(output.win.kcal)])
    sprintf(['Wins kcal for snacks = ' num2str(snack_kcal)])
    sprintf(['Multiplication Factor for Muesli = ' num2str(musli_entities)])
catch
    disp('No food trials')
end

if settings.do_WOF == 1 && ~strcmp(subj.runLABEL, 'training')
    sprintf(['Wins wheel of fortune = ' num2str(Wof_win)])
end

% to do 
% disp(['Geldpunkte:', num2str(output.win.sum_coins) ', Euro:'  num2str(output.win.money), '', ...
% ', Punkte fuer Essen:', num2str(output.win.sum_cookies), '', ...
%       ', Kcal:', num2str(output.win.kcal), ', Snacks in Kcal:', num2str(output.win.snack_kcal), '', ...
%       ', Muesli in Kcal:', num2str(output.win.musli_kcal), ', Muesli Einheiten:', num2str(musli_entities)])


input_device.maxEffort;

%delete([temp.filename '.mat']);

%GetClicks(setup.screenNum);
ShowCursor;
Screen('CloseAll');

if (settings.do_EGG == 1 && ~strcmp(subj.runLABEL, 'training')) || (settings.do_EGG_training == 1 && strcmp(subj.runLABEL, 'training'))
    closeTTL()
end



%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function tvnsInfo = initTVNS(throwError)
% This function inits the connection to the tVNS manager and the device and
% returns some important info needed for furter communication. If the
% parameter "throwError = 1", a failing init throws an error, otherwise
% only a warning.
if nargin == 0
    throwError = 0;
end

tvnsInfo.bAutoSwitch = matlab.net.http.MessageBody('automaticSwitch');
tvnsInfo.bTreatOn = matlab.net.http.MessageBody('startTreatment');
tvnsInfo.bTreatOff = matlab.net.http.MessageBody('stopTreatment');
tvnsInfo.method = matlab.net.http.RequestMethod.POST;
tvnsInfo.reqAutoSwitch = matlab.net.http.RequestMessage(tvnsInfo.method,[],tvnsInfo.bAutoSwitch);
tvnsInfo.reqTreatOn = matlab.net.http.RequestMessage(tvnsInfo.method,[],tvnsInfo.bTreatOn);
tvnsInfo.reqTreatOff = matlab.net.http.RequestMessage(tvnsInfo.method,[],tvnsInfo.bTreatOff);
tvnsInfo.tvnsURL = 'http://localhost:51523/tvnsmanager/';
tvnsInfo.stimSuccess = 1; % flag to indicate errors with stimulation
tvnsInfo.endSuccess = 1; % flag to indicate errors with ending stim.

try
    [r1,~,~] = send(tvnsInfo.reqAutoSwitch, tvnsInfo.tvnsURL); % init tVNS Manager
    if r1.StatusCode ~= matlab.net.http.StatusCode.OK
        error('tVNS setup failed')
    end
catch ME
    if throwError
        sca
        rethrow(ME)
    else
        warning('tVNS setup failed')
    end
end
end %----------------------------------------------------------------------


function setupTVNS(tvnsInfo, stimAmpl, stimFreq, stimDur, pauseDur, throwError)
% This function sends the settings for the tVNS device to the tVNS manager.
% If the parameter "throwError = 1" a failing setup throws an error,
% otherwise only a warning.
if nargin == 4
    throwError = 0;
end

% prepare the general settings
body_settings =  matlab.net.http.MessageBody(...
    ['minIntensity=100&maxIntensity=5000', ...
    '&impulseDuration=250&frequency=',num2str(stimFreq),...
    '&stimulationDuration=',num2str(stimDur),...
    '&pauseDuration=',num2str(pauseDur),]);
request_settings = matlab.net.http.RequestMessage(tvnsInfo.method, ...
    [], body_settings);
try
    [r2,~,~] = send(request_settings, tvnsInfo.tvnsURL);
    if r2.StatusCode ~= matlab.net.http.StatusCode.OK
        error('tVNS init failed')
    end
catch
    if throwError
        sca
        rethrow(ME)
    else
        warning('tVNS init failed')
    end
end

% prepare the intensity setting
bIntensity= matlab.net.http.MessageBody( ['intensity ' num2str(stimAmpl)]);
reqIntensity= matlab.net.http.RequestMessage( tvnsInfo.method, [], bIntensity);
try
    [r3,~,~] = send(reqIntensity, tvnsInfo.tvnsURL);
    if r3.StatusCode ~= matlab.net.http.StatusCode.OK
        error('tVNS intensity setup failed')
    end
catch
    if throwError
        sca
        rethrow(ME)
    else
        warning('tVNS intensity setup failed')
    end
end
end %----------------------------------------------------------------------


function tvnsInfo = startTVNS(tvnsInfo)
% This function starts the tVNS treatment and sets the flag
% tvnsInfo.stimSuccess according to success of stimulation.
try
    [r3,~,~] = send(tvnsInfo.reqTreatOn, tvnsInfo.tvnsURL);
    tvnsInfo.stimSuccess = 1;
    if r3.StatusCode ~= matlab.net.http.StatusCode.OK
        tvnsInfo.stimSuccess = 0;
        warning('tVNS stimulation failed')
    end
catch
    tvnsInfo.stimSuccess = 0;
    warning('tVNS stimulation failed')
end
end %----------------------------------------------------------------------


function tvnsInfo = endTVNS(tvnsInfo)
% This function ends the tVNS treatment and sets the flag
% tvnsInfo.endSuccess according to success of ending stimulation.
try
    [r4,~,~] = send(tvnsInfo.reqTreatOff, tvnsInfo.tvnsURL);
    tvnsInfo.endSuccess = 1;
    if r4.StatusCode ~= matlab.net.http.StatusCode.OK
        tvnsInfo.endSuccess = 0;
        warning('tVNS ending stimulation failed')
    end
catch
    tvnsInfo.endSuccess = 0;
    warning('tVNS ending stimulation failed')
end
end %----------------------------------------------------------------------


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
        sca
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
            sca
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

end %----------------------------------------------------------------------
%------ Wrapper functions for TTL------------------------------------------

function sp = prepareTTL(comX, BaudRate, trigDur)
% Opens the port "comX" with the "BaudRate" and stores "trigDur" as
% duration for triggers in future sendTTL commands.
% It also tests the device and creates & stores the handle.
sp = TTL('prepareTTL', comX, BaudRate, trigDur);
end %----------------------------------------------------------------------

function sendTTL(msg, throwError)
% Sends the message "msg" (a decimal) to the TTL box. If throwErrow
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
target = [255 255]; % expected data, representing a trigger-pulse in L&B
readTimeout = '10';  % how long to wait for a trigger-pulse?
baudRate = '19200';% Choose a high data transmission rate
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

