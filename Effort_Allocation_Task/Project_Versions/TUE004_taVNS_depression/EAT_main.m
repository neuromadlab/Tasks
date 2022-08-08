%%===================Effort allocation task===================
% Main script for Effort cost paradigm 
%
% author: Monja P. Neuser, Mechteld van den Hoek Ostende, Vanessa Teckentrup, Nils B. Kroemer
% Integration WOF: Emily Corwin-Renner 
%
% Input: fiber optic response grip force device or Xbox360 controller, 
%        computer mouse for non-mri settings
%
subj.version = 2.1;          % Script version: "at the zoo"
%=============================================================
%% Part 0: Preparation

% Clear workspace
close all;
clear all; 
sca;

%% Part 1/2: settings and study information
% load settings .mat file
load('TUE004_Settings.mat')

% Path to FCR folder
if settings.debug == 1
    FCR_dir = 'C:\Users\Monja\Google Drive\TUE_general\Tasks\FCR\FCR_beh\';
else
    FCR_dir = 'D:\home\sektion\AG_Walter\BEDVAR\TUE002_FCR_behav\Data';
end

% load instructions
if settings.lang_de == 1
    tVNSGerman
else
    sprintf('English not implemented yet');
end

% % settings
% settings.do_fullscreen = 1;  % default second monitor, if connected
% settings.do_fmri       = 0;  % will include trigger
% settings.debug         = 0;  % input device not required
% settings.do_gamepad    = 1;  % frequency
% settings.do_WOF        = 0;  % include wheel of fortune
% settings.do_VAS        = 1;  % include VAS
% settings.do_val_cal    = 1;  % calibrate value difference between food/money
% settings.use_val_cal   = 0;  % use calibrated value difference for food/money (txt file in data folder)
% settings.do_timelimit  = 1;  % time limit for intermittent VAS questions
% settings.lang_de       = 1;  % german. English when 0
% settings.do_feedback   = 0;  % feedback on (1) or off (0)
% settings.train_trials  = 2;  % amount of training trials to estimate max/min (2 or 3)
% 
% % Study information
% subj.study             = 'TUE004';  % Project number
% subj.runID             = '1';  % Runs per session   
% 
% % Settings VAS
% if settings.do_VAS == 1
%    settings.VAS_input       = 1; % VAS input is 1 for joystick, 0 for mouse
%     settings.VAS.exhaustion = 1;
%     settings.VAS.wanting    = 1;
%     settings.VAS.happy1     = 0;
%     settings.VAS.happy2     = 0;
% end
% 
% settings.value_money   = 32;    % amount of cents earned with 100 points
% settings.value_food    = 32;    % amount of kcal earned with 100 points
% settings.clckforce     = 20000; % only relevant for grip force device set-ups
%     
% 
% %% Part 2: task timings
% 
% % Durations of  
% if settings.do_fmri == 0
%     timings.trial_length        = 30; 
%     timings.break_length        = 15; 
%     timings.feedback_length     = 2.5;
%     timings.fix1_length         = 0;
%     timings.fix2_length         = 1.5;
%     timings.bidding_length      = 5;
%     timings.VAS_rating_duration = 3.2;
%     timings.number_breaks       = 2;
%     timings.number_trials       = 64;
%     timings.avrg_jttr_ball      = '2';
%     timings.avrg_jttr_fix1      = '2';
%     timings.avrg_jttr_fix2      = '2';
%     timings.max_jttr_ball       = '4';
%     timings.max_jttr_fix1       = '12';
%     timings.max_jttr_fix2       = '12';
% elseif settings.do_fmri == 1
%     timings.trial_length        = 22;
%     timings.break_length        = 10;
%     timings.feedback_length     = 2.5;
%     timings.fix1_length         = 0.5;
%     timings.fix2_length         = 1;
%     timings.number_breaks       = 2;
%     timings.number_trials       = 64;
%     timings.avrg_jttr_ball      = '1';
%     timings.avrg_jttr_fix1      = '1.5';
%     timings.avrg_jttr_fix2      = '3';
%     timings.max_jttr_ball       = '4';
%     timings.max_jttr_fix1       = '12';
%     timings.max_jttr_fix2       = '12';
%     %MR specific timings
%     MR_timings.durations.effort     = timings.trial_length;
%     MR_timings.durations.feedback   = timings.feedback_length;
%     MR_timings.durations.win        = [];
%     MR_timings.durations.rest_phase = [];
% end
% 
% % determine before what trial breaks should be inserted
% timings.break_trials = [];
% for brk = 1:timings.number_breaks   
%    breaknumbr           = timings.number_trials/(timings.number_breaks + 1)* brk;
%    timings.break_trials = [timings.break_trials, round(breaknumbr)];
% end
% timings.break_trials = timings.break_trials + 1;
% 
% 
% if settings.do_WOF == 1
%     timings.nmbr_trls_to_WOF    = 6;
%     timings.time_to_start       = 1; %Time to spin WOF from button press
%     timings.show_wheel          = 5;
%     timings.show_feedback       = 5;
%     timings.PANAS_trials        = timings.break_trials - 1;   
%     timings.PANAS_trials        = [timings.PANAS_trials, timings.number_trials];
% end

% % Electrogastrogram related settings
% settings.do_EGG = 1;
% % LPT port address
% settings.EGG.port_address = 888;
% % sampling rate of the amplifier to determine time to wait for the trigger
% % to be registered
% settings.EGG.sampling_rate = 250;
% % set trigger values for events
% settings.EGG.trigger.exp_on = 10;
% settings.EGG.trigger.cue_money = 50;
% settings.EGG.trigger.cue_food = 100;
% settings.EGG.trigger.work_block = 150;
% settings.EGG.trigger.feedback_certain = 200;
% settings.EGG.trigger.feedback_uncertain = 250;
% settings.EGG.trigger.exp_off = 255;

if settings.do_EGG == 1
    
    % Set all output bits of the selected LPT port to low in case they are
    % high at system boot time
    lptwrite(settings.EGG.port_address, 0); 
    
end

%% Part 3: Input from console

% Console input: entrered by experimenter when experiment starts
subj.runLABEL  = input('Study ID [1 fuer Training / 2 fuer Experiment]: ','s');
subj.subjectID = input('Subject ID: ','s');
subj.sessionID = input('Session ID [1/2]: ','s');
subj.date      = datestr(now);
if settings.do_WOF == 1
    subj.order=input('Version [a oder b]: ', 's');
end

% Convert labels and IDs
if strcmp(subj.runLABEL, '1')
    subj.runLABEL = 'training';         
else
    subj.runLABEL = 'EAT'; 
end
subj.run        = str2double(subj.runLABEL); 
subj.id         = str2double(subj.subjectID); 
subj.sess       = str2double(subj.sessionID);

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
    if exist(fullfile('data', [value_file_name '.txt'])) ~= 2
       
        error('Error: Value file is missing. Add txt file to /data folder.')
       
    else
        input_device.value_factor = dlmread(fullfile('data', [value_file_name '.txt']));
        input_device.value_money  = settings.value_money;
        input_device.value_food   = round(input_device.value_money * input_device.value_factor);
        
    end
end

HideCursor;

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
    
    flp_flg_hrz = 1;
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
                            subj.study '_'  subj.subjectID '_S' subj.sessionID] '*'];
elseif settings.do_gamepad == 1
    maxeffort_searchname = [[pwd filesep 'data' filesep 'TrainEAT_' ...
                            subj.study '_'  subj.subjectID '_S1'] '*'];
end
maxeffort_searchdir = dir(maxeffort_searchname);

% File names
if  linux 

    if strcmp(subj.runLABEL, 'training')

        cond_filename      = sprintf('%s/conditions/EATTrain_cond_%s_%s_S%s_R1.mat', ...
                                pwd, subj.study, subj.subjectID, subj.sessionID);                          
        bid_filename       = sprintf('%s/conditions/EATBid_cond', pwd);
    
    elseif strcmp(subj.runLABEL, 'EAT')
        
        cond_filename      = sprintf('%s/conditions/EATExp_cond_%s_%s_S%s_R1.mat', ...
                                pwd, subj.study, subj.subjectID, subj.sessionID);
                    
        maxeffort_filename = sprintf('%s/data/%s', pwd, maxeffort_searchdir.name);
        
    end
    
elseif windows
    
    if strcmp(subj.runLABEL, 'training')

        cond_filename      = sprintf('%s\\conditions\\EATTrain_cond_%s_%s_S%s_R1.mat', ...
                                pwd, subj.study, subj.subjectID, subj.sessionID);
        bid_filename       = sprintf('%s\\conditions\\EATBid_cond', pwd);                    

    elseif strcmp(subj.runLABEL, 'EAT')
        
        cond_filename      = sprintf('%s\\conditions\\EATExp_cond_%s_%s_S%s_R1.mat', ...
                            pwd, subj.study, subj.subjectID, subj.sessionID);
                    
        maxeffort_filename = sprintf('%s\\data\\%s', pwd, maxeffort_searchdir.name);            
        
    end

end

% loading of files
load(cond_filename);
if strcmp(subj.runLABEL, 'EAT')
    load(maxeffort_filename,'input_device'); 
else
    load(bid_filename)
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
    [img_coin.winCounter, img_coin.map, img_coin.alpha]       = imread('singlecoin.jpg');
    [img_cookie.winCounter, img_cookie.map, img_cookie.alpha] = imread('singlecookie_choc.jpg');

    [img.incentive_coins1, img.map, img.alpha]  = imread('incentive_coins1.jpg');
    [img.incentive_coins10, img.map, img.alpha] = imread('incentive_coins10_2.jpg');

    [img.incentive_cookies1, img.map, img.alpha]  = imread('incentive_cookies_choc1.jpg');
    [img.incentive_cookies10, img.map, img.alpha] = imread('incentive_cookies_choc10_2.jpg');
    
    if strcmp(subj.runLABEL, 'training') && settings.do_val_cal == 1
        [img.bidding_food_50, img.map, img.alpha]  = imread('snickers_50.png');
        [img.bidding_food_100, img.map, img.alpha] = imread('snickers_100.png');
        [img.bidding_food_200, img.map, img.alpha] = imread('snickers_200.png');
        
        [img.bidding_money_50, img.map, img.alpha]  = imread('money_50.png');
        [img.bidding_money_100, img.map, img.alpha] = imread('money_100.png');
        [img.bidding_money_200, img.map, img.alpha] = imread('money_200.png');
    end
    
else % load mirrored images for fmri experiment
    [img_coin.winCounter, img_coin.map, img_coin.alpha]       = imread('singlecoinM.jpg');
    [img_cookie.winCounter, img_cookie.map, img_cookie.alpha] = imread('singlecookie_chocM.jpg');

    [img.incentive_coins1, img.map, img.alpha]  = imread('incentive_coins1M.jpg');
    [img.incentive_coins10, img.map, img.alpha] = imread('incentive_coins10_2M.jpg');

    [img.incentive_cookies1, img.map, img.alpha]  = imread('incentive_cookies_choc1.jpg');
    [img.incentive_cookies10, img.map, img.alpha] = imread('incentive_cookies_choc10_2M.jpg');
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
    [w,wRect] = Screen('OpenWindow',setup.screenNum,color.white,[0 0 800 600]);
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
    wof_colsel = randsample(wof_colvals,1)
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
            jitter_filename = sprintf('%s/jitters/DelayJitter_mu_0.70_max_4_trials_16.mat', pwd);       
        elseif windows
            jitter_filename = sprintf('%s\\jitters\\DelayJitter_mu_0.70_max_4_trials_16.mat', pwd);
        end    
    else  
        if linux       
            jitter_filename = sprintf('%s/jitters/DelayJitter_mu_0.70_max_4_trials_96.mat', pwd);       
        elseif windows   
            jitter_filename = sprintf('%s\\jitters\\DelayJitter_mu_0.70_max_4_trials_96.mat', pwd);       
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
    
    if settings.do_fmri == 0
        % load welcome instructions
        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.train_welcome_text, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);

        GetClicks(setup.screenNum);
    end
    
    TrainEAT_main
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
    load('JoystickSpecification.mat')
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
    load('GripForceSpec.mat')
    % initialize grip force specific values    
    if windows

        restforce = input_device.minEffort - 0.05* ...
                        (input_device.minEffort - input_device.maxEffort); % 5% over min force
        if (settings.do_fmri == 1) && (settings.debug == 0)
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        else
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec);
        end
        gripforce_value = Joystick.Y;

     elseif linux
         
        restforce       = input_device.minEffort; %normal holding force
        axisState       = Gamepad('GetAxis', grip_force_idx, grip_force_axis);
        gripforce_value = axisState;

    end
    
    i_step_gr           = 1;  % Enummarate over loops
    delta_pos_force     = input_device.minEffort - input_device.maxEffort; 
    clckforce           = input_device.minEffort - 0.85* ...
                            abs(input_device.minEffort - input_device.maxEffort);
    ForceMat            = restforce;
    effort_vector       = []; 
    LowerBoundBar       = setup.ScrHeight - Tube.offset;
    UpperBoundBar       = Tube.height + Ball.width;
    BarBoundAbs         = LowerBoundBar - UpperBoundBar;
    BarBound2Scale      = BarBoundAbs/delta_pos_force;
    
    %drawing parameters for uncertainty
    EffortLow            = input_device.minEffort - delta_pos_force * 0.64; %64 percent of maxEffort, used to draw uncertainty box
    LwrBndUncertain      = BarBound2Scale * EffortLow + UpperBoundBar - ...
                           input_device.maxEffort * BarBound2Scale; %bottom y coordinate of uncertainty box
    EffortHigh           = input_device.minEffort - delta_pos_force * 0.95; %95 percent of maxEffort, used to draw uncertainty box
    UpprBndUncertain     = BarBound2Scale * EffortHigh + UpperBoundBar - ...
                           input_device.maxEffort * BarBound2Scale; %top y coordinate of uncertainty box
    
end

%% Part 13: Uncertainty

%drawing parameters for uncertainty
box.position        = [Tube.XCor1, UpprBndUncertain, Tube.XCor2, LwrBndUncertain];

%% Part 14: Text instructions

Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
if strcmp(subj.runLABEL, 'training')
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.strt_actual_train, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
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
else 
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.intro_exp1, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);
    if settings.do_fmri == 0
        GetClicks(setup.screenNum);
        
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.intro_exp2, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);
        GetClicks(setup.screenNum);
    elseif settings.do_fmri == 1
        WaitSecs(3);        
        while gripforce_value > clckforce
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_value = Joystick.Y;
        end
    end
end

if settings.do_fmri == 0
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_nr1, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum);

    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_nr2, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('DrawTexture', w, stim.incentive_coins1,[], [(setup.xCen*0.7) (Text.height*2.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) (Text.height*2.9)])
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_coins1, setup.xCen, ((setup.ScrHeight/5)*3.2-Coin.width/2), color.black,40, [], [], 1.2);        
    Screen('DrawTexture', w, stim.incentive_coins10,[], [(setup.xCen*0.7) (Text.height*3.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) (Text.height*3.9)])
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_coins10, setup.xCen, ((setup.ScrHeight/5)*4.2-Coin.width/2), color.black,40, [], [], 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum);

    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_nr3, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('DrawTexture', w, stim.incentive_cookies1,[], [(setup.xCen*0.7) (Text.height*2.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) (Text.height*2.9)])
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_cookies1, setup.xCen, ((setup.ScrHeight/5)*3.2-Coin.width/2), color.black,40, [], [], 1.2);     
    Screen('DrawTexture', w, stim.incentive_cookies10,[], [(setup.xCen*0.7) (Text.height*3.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) (Text.height*3.9)])
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_cookies10, setup.xCen, ((setup.ScrHeight/5)*4.2-Coin.width/2), color.black,40, [], [], 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum);

    instr.reward_nr4         = ['Die Umrechnung der Punkte richtet sich nach folgendem Kurs:  '...
                                '\n 100  Geld-Punkte entsprechen ' num2str(input_device.value_money) ' cent.'...
                                '\n\n  100  Essens-Punkte entsprechen ' num2str(input_device.value_food) ' kcal.'...
                                '\n\nIm Anschluss an die Aufgabe koennen Sie die Geldpunkte in einen entsprechenden Geldbetrag eintauschen'...
                                'und fuer die Essens-Punkte einen entsprechenden Snack erhalten.'];

    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_nr4, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum);

    if strcmp(subj.runLABEL, 'training') 
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.diff_nr1, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    else
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.diff_exp, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    end
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum);

    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.vas_nr1, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum);
    
    if settings.do_WOF == 1 && ~strcmp(subj.runLABEL, 'training')
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.wof_exp, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);
        GetClicks(setup.screenNum);
        
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.wof_panas, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
        Screen('Flip',w);
        GetClicks(setup.screenNum);
    end
else
    instr.reward_nr4         = ['Die Umrechnung der Punkte richtet sich nach folgendem Kurs:  '...
                                '\n 100  Geld-Punkte entsprechen ' num2str(input_device.value_money) ' cent.'...
                                '\n\n  100  Essens-Punkte entsprechen ' num2str(input_device.value_food) ' kcal.'...
                                '\n\nIm Anschluss an die Aufgabe koennen Sie die Geldpunkte in einen entsprechenden Geldbetrag eintauschen'...
                                'und fuer die Essens-Punkte einen entsprechenden Snack erhalten.'];

    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_nr4, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);
    WaitSecs(7);        
    while gripforce_value > clckforce
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        gripforce_value = Joystick.Y;
    end
end

if strcmp(subj.runLABEL, 'training') && settings.do_fmri == 0
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.time_train, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum);
elseif ~strcmp(subj.runLABEL, 'training')
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.time_exp, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);

    if settings.do_fmri == 0
        GetClicks(setup.screenNum);
    elseif settings.do_fmri == 1
        WaitSecs(5);             
        while gripforce_value > clckforce
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_value = Joystick.Y;
        end
    end
end

%% Part 15: Start fMRI procedure
%Listen for triggers
if (settings.do_fmri == 1)  && ~strcmp(subj.runLABEL, 'training')
    
    % Show empty screen while waiting for trigger
    Screen('FillRect',w);
    Screen('Flip',w);
    
    MR_timings.on_trigger_loop = GetSecs;
    
    KbQueueFlush(); 
	KbQueueStart(); 
    [b,c] = KbQueueCheck;
    
    while c(keyQuit) == 0
        [b,c] = KbQueueCheck;
        if c(keyTrigger) || c(keyTrigger2) > 0
            count_trigger                           = count_trigger + 1;
            MR_timings.trigger.all(count_trigger,1) = GetSecs;            
            if count_trigger > dummy_volumes
                MR_timings.trigger.fin = GetSecs;
                break
            end
        end
    end

elseif (settings.do_fmri == 1)  && strcmp(subj.runLABEL, 'training')
    MR_timings.trigger.fin = GetSecs;
end
    
KbQueueFlush();
timestamps.exp_on = GetSecs;

%% Part 16: The actual task

% Trigger EGG
if settings.do_EGG == 1 && ~strcmp(subj.runLABEL, 'training')
    % Write trigger for EGG - start of the experiment
    lptwrite(settings.EGG.port_address, settings.EGG.trigger.exp_on); 
    WaitSecs(1/settings.EGG.sampling_rate);
    lptwrite(settings.EGG.port_address, 0); 
end

%  Loop while entries in the conditions file left
for i_trial = 1:length(conditions) %condition file determines repetitions
    %% 16.01 Break
        
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
                       text = ['Sie koennen jetzt eine kurze Pause machen und sich lockern.'...
                                '\n\n\n' num2str(timings.break_length - i_timer) ...
                                '  Sekunden bis zur naechsten Runde.'];
                       [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text, 'center', 'center', [0 0 0],150);
                       Screen('Flip', w, []);

                end              
                i_timer = i_timer + 1;
                
             end
        
          elseif settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')
              
              i_timer = 1;
              i_break = i_break +1;
              
              timestamps.break(i_break) = timer_onset_feedback;
              MR_timings.onsets.break(i_break) = timestamps.break(i_break) - MR_timings.trigger.fin;
              MR_timings.durations.break(i_break) = timings.break_length;
             
              while i_timer <= timings.break_length    
                 
                 while i_timer > GetSecs - timer_onset_feedback         

                     % Draw Text
                     text = ['Sie koennen jetzt eine kurze Pause machen und sich lockern.'...
                              '\n\n\n' num2str(timings.break_length - i_timer) ...
                              'Sekunden bis zur naechsten Runde.'];
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
        input_device.percentEffort = input_device.minEffort - delta_pos_force *...
                                     conditions(i_trial,1) * 0.01;
        %Threshold position for obtaining reward in this trail
        Threshold.yposition        = BarBound2Scale * input_device.percentEffort + ...
                                     UpperBoundBar - input_device.maxEffort * BarBound2Scale;
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
    
    timestamps.condition_preview_reward(i_trial,1) = starttime;
    
    % Trigger EGG
    if settings.do_EGG == 1 && ~strcmp(subj.runLABEL, 'training')
        if input_device.incentive == 1
            % Write trigger for EGG - cue for money reward
            lptwrite(settings.EGG.port_address, settings.EGG.trigger.cue_money); 
            WaitSecs(1/settings.EGG.sampling_rate);
            lptwrite(settings.EGG.port_address, 0); 
        elseif input_device.incentive == 0
            % Write trigger for EGG - cue for food reward
            lptwrite(settings.EGG.port_address, settings.EGG.trigger.cue_food); 
            WaitSecs(1/settings.EGG.sampling_rate);
            lptwrite(settings.EGG.port_address, 0); 
        end
    end
    
    if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')                
        MR_timings.onsets.condition_preview_reward(i_trial,1) = starttime - MR_timings.trigger.fin;
    end
    
    %Show screen for 1s plus jitter value (drawn from exponential distribution with mean of 2 and max = 12)
    if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')             
        WaitSecs(1 + ball_jitter(i_trial,1)); 
    end

    MR_timings.durations.condition_preview_reward(i_trial,1) = 1 + ball_jitter(i_trial,1);
    
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
        lptwrite(settings.EGG.port_address, settings.EGG.trigger.work_block); 
        WaitSecs(1/settings.EGG.sampling_rate);
        lptwrite(settings.EGG.port_address, 0); 
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
         if ForceMat < restforce
            Ball_yposition  = BarBound2Scale * ForceMat + UpperBoundBar ...
                                - input_device.maxEffort * BarBound2Scale;    
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

              if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')
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
            payout.counter             = nansum(payout.diff);
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
                 if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')
                    timestamps.rest_phase(i_trial,rest_phase_counter)        = exceed_offset;
                    MR_timings.onsets.rest_phase(i_trial,rest_phase_counter) = exceed_offset - MR_timings.trigger.fin;
                    rest_phase_counter                                       = rest_phase_counter + 1;
                 end
             end  
      end  

      Screen('FillOval',w,Ball.color,Ball.position);
      [time.img, starttime] = Screen('Flip', w);

      % For first flip, track time
      if onset_start == 0 && settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')
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
        
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
                 
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
                end


                 %if no button press happened: Frequency should decrease slowly based on phantom estimates   
             elseif (GetSecs - t_buttonN_1) > (1.5 * Avrg_value) && (i_resp > 1)

                    phantom_current_input   = GetSecs - t_buttonN_1;
                    current_weight_fact     = forget_fact * prev_weight_fact + 1;
                    Estimate_Avrg_value     = (1-(1/current_weight_fact)) * prev_movingAvrg + ((1/current_weight_fact) * phantom_current_input);
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
            if (settings.do_fmri == 1) && (settings.debug == 0)
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            else
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec);
            end
            gripforce_value = Joystick.Y;

        elseif linux
            
            axisState       = Gamepad('GetAxis', grip_force_idx, grip_force_axis);
            gripforce_value = axisState;
            
        end

        % Get timestamps of MexFile call to get accurate sampling rate
        if settings.do_fmri == 1
            timestamps.grip_force_sampling_rate(i_trial,gf_sr_counter) = GetSecs;
            gf_sr_counter                                              = gf_sr_counter + 1;
        end

        % Getting values from Grip Force Device -> Joystick.Y
            ForceMat        = gripforce_value;
            effort_vector   = [effort_vector, gripforce_value];
        % Store for timestamps and actual frequency every 100ms
            t_step                   = GetSecs;
            t_vector(1,i_step_gr)    = t_step - t_trial_onset;
            i_step_gr                = i_step_gr + 1;           
    end
    
%% 16.07 End of trial
    
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
        win_coins   = floor(nansum(exc_thresh_this_trial));        
    elseif input_device.incentive == 0 && input_device.value == 1        
        win_cookies = floor(nansum(exc_thresh_this_trial));            
    elseif input_device.incentive == 1 && input_device.value == 10        
        win_coins   = floor(nansum(exc_thresh_this_trial)) * 10;        
    elseif input_device.incentive == 0 && input_device.value == 10        
        win_cookies = floor(nansum(exc_thresh_this_trial)) * 10;       
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
    WaitSecs(timings.fix1_length + fix1_jitter(i_trial,1)); 
    
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
        trial.question = 'gluecklich';
        
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
    
end

%% 16.10 Feedback to trial
if settings.do_feedback == 1
timer_onset_feedback = GetSecs;
onset_start = 0;

if strcmp(subj.runLABEL, 'EAT')        
    if i_trial < length(conditions)
        i_timer = 0.8;        
        while i_timer <= timings.feedback_length
            
            while i_timer > GetSecs - timer_onset_feedback

                if input_device.incentive == 1 % money
                    text = ['Durchgang beendet.\n\nGewinn:   ' ...
                        num2str(win_coins) '   Geld-Punkt(e).'];
                elseif input_device.incentive == 0 % food
                    text = ['Durchgang beendet\n\nGewinn:   ' ...
                        num2str(win_cookies) '   Essens-Punkt(e).'];
                end
                % Draw Text
                Screen('TextSize',w,32);
                Screen('TextFont',w,'Arial');
                if settings.do_fmri == 1 || settings.do_WOF == 1
                    [~,~,~] = DrawFormattedText(w, text, 'center',(setup.ScrHeight/10), ...
                                                color.black,40,flp_flg_hrz,flp_flg_vrt);
                else
                    [~,~,~] = DrawFormattedText(w, text, 'center',(setup.ScrHeight/10), color.black,40);
                    counter = ['Naechste Runde: ' num2str(4 - ceil(i_timer))];

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
            end

            i_timer = i_timer + 0.8;
        end

    end
elseif strcmp(subj.runLABEL, 'training')
    
    if i_trial < length(conditions)

        i_timer = 0.8;

        while i_timer <= timings.feedback_length

            while i_timer > GetSecs - timer_onset_feedback

                if input_device.incentive == 1 % money
                    text = ['Durchgang beendet.\n\nGewinn:   ' ...
                        num2str(win_coins) '   Geld-Punkt(e).'];
                elseif input_device.incentive == 0 % food
                    text = ['Durchgang beendet.\n\nGewinn:   ' ...
                        num2str(win_cookies) '   Essens-Punkt(e).'];
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
                        counter = ['Naechste Runde: ' num2str(4 - ceil(i_timer))];
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
            end

            i_timer = i_timer + 0.8;
        end

    end    
end

timestamps.feedback(i_trial,1) = starttime;
if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')
    MR_timings.onsets.feedback(i_trial,1) = starttime - MR_timings.trigger.fin;
end

% Trigger EGG
if settings.do_EGG == 1 && ~strcmp(subj.runLABEL, 'training')
    if conditions(i_trial,4) == 1
        % Write trigger for EGG - feedback uncertain
        lptwrite(settings.EGG.port_address, settings.EGG.trigger.feedback_uncertain); 
        WaitSecs(1/settings.EGG.sampling_rate);
        lptwrite(settings.EGG.port_address, 0);
    elseif conditions(i_trial,4) == 0
        % Write trigger for EGG - feedback certain
        lptwrite(settings.EGG.port_address, settings.EGG.trigger.feedback_certain); 
        WaitSecs(1/settings.EGG.sampling_rate);
        lptwrite(settings.EGG.port_address, 0); 
    end
end

end

%% 16.11 VAS after feedback
if settings.do_VAS == 1
    if settings.VAS.happy2 == 1
        trial.question = 'gluecklich';

        Effort_VAS

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

%Show screen for 1s plus jitter value (drawn from exponential distribution with mean of 3 and max = 12)
WaitSecs(timings.fix2_length + fix2_jitter(i_trial,1));

timestamps.fix2(i_trial,1) = starttime;

if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')
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
    rel_Effort = (((input_device.minEffort - effort_vector) * 100)./(input_device.minEffort - ones(1,length(effort_vector))*input_device.maxEffort));
elseif settings.do_gamepad == 1
    rel_Effort =  effort_vector *100/input_device.maxEffort;
    if exist('t_button_vec')
        %Time reference t_Button to trial_start 
        t_button_ref_vec = t_button_vec - t_trial_onset;
    end
end

%Copy Output Values into Output Matrix
output.data_mat = vertcat(output.data_mat, [ones(length(effort_vector),1) * subj.id, ...                       %ID
                           ones(length(effort_vector),1) * subj.sess, ...                                               %Sess
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
    
    output.filename = sprintf('%s\\backup\\EAT%s_%s_%s_S%s_R%S_temp', ...
                                pwd, subj.runLABEL, subj.study, subj.subjectID, subj.sessionID, subj.runID);   
end

if  (settings.do_gamepad == 1) && (settings.do_fmri == 0)
    save([output.filename datestr(subj.date,'_yymmdd_HHMM') '.mat'], 'output', 'subj', 'input_device', 'joy', 'conditions', 'timestamps')
elseif (settings.do_gamepad == 1) && (settings.do_fmri == 1)
    save([output.filename datestr(subj.date,'_yymmdd_HHMM') '.mat'], 'output', 'subj', 'input_device', 'joy', 'conditions', 'timestamps', 'MR_timings')
elseif (settings.do_gamepad ~= 1) && (settings.do_fmri == 0)
    save([output.filename datestr(subj.date,'_yymmdd_HHMM') '.mat'], 'output', 'subj', 'input_device', 'conditions', 'timestamps')
else
    save([output.filename datestr(subj.date,'_yymmdd_HHMM') '.mat'], 'output', 'subj', 'input_device', 'conditions', 'timestamps', 'MR_timings')
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
t_vector                = [];

if settings.do_gamepad == 0
    ForceMat                        = restforce;
    i_step_gr                       = 1;
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

end

%% Part 17: After experiment

% Update maxEffort based on highest value during practice trials
if strcmp(subj.runLABEL, 'training') 
    effort_vals = output.data_mat(:,7);
    if settings.do_gamepad == 0
        input_device.maxEffort      = min(input_device.maxEffort, min(effort_vals));
    elseif settings.do_gamepad == 1
        input_device.maxEffort      = max(input_device.maxEffort, max(effort_vals));
        % set upper boundary to max effort for button presses
        if input_device.maxEffort > 8
           input_device.maxEffort = 8; 
        end
    end    
end

if settings.do_WOF == 1 && strcmp(subj.runLABEL, 'training')
    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.wof_train, 'center', Text.height, color.black, 60, flp_flg_hrz, flp_flg_vrt, 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.text_Cont, 'center', Text.height_cont, color.black, 50, flp_flg_hrz, flp_flg_vrt, 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum);
end

% Prepare feedback
% Compute win
output.win.sum_coins    = floor(nansum(output.win.payout_per_trial(1,3:end)));
output.win.sum_cookies  = floor(nansum(output.win.payout_per_trial(2,3:end)));
output.win.money        = floor(output.win.sum_coins*input_device.value_money/100)/100;
output.win.kcal         = floor(output.win.sum_cookies*input_device.value_food/100);
output.win.snacks       = floor(output.win.kcal/100);

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
        text = ['Sie haben beim Gluecksraddrehspiel \n insgesamt ', num2str(Wof_win) ' Euro gewonnen.'];
        Screen('TextSize', w, txtsize_for_header);
        DrawFormattedText(w, text, 'center', setup.ScrHeight/5, color.black);
        Screen('Flip',w);
        WaitSecs(timings.show_feedback );
        Screen('FillRect', w, color.white);
    end   
end

% Show final screen (text)
if strcmp(subj.runLABEL, 'training') 
    
    text = ['Die Uebung ist nun zu Ende.'...
        '\n\n Im richtigen Spiel haetten Sie ' num2str(output.win.sum_coins) ' Geld-Punkte gewonnen. '...
        '\n Das entspicht ' num2str(output.win.money) ' Euro. '...
        '\n\nIm richtigen Spiel haetten Sie ' num2str(output.win.sum_cookies) ' Essens-Punkte gewonnen. '...
        '\nDas entspricht ' num2str(output.win.kcal) ' Kcal.' ];
    
elseif strcmp(subj.runLABEL, 'EAT')
    
     text = ['Das Spiel ist nun zu Ende.'...
        '\n\n Sie haben ' num2str(output.win.sum_coins) ' Geld-Punkte gewonnen. '...
        '\n Das entspicht ' num2str(output.win.money) ' Euro.'...
        '\n\nSie haben ' num2str(output.win.sum_cookies) ' Punkte fuer Essen gewonnen.'...
        '\n Das entspricht ' num2str(output.win.kcal) ' Kcal.'];
   if settings.do_fmri == 1
     text = [text, '\n Bitte bleiben Sie noch still liegen bis wir zu Ihnen in den Raum kommen.'];
   end
   
end

Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[~,~,~] = DrawFormattedText(w, text, 'center', setup.ScrHeight/5, color.black,60, flp_flg_hrz, flp_flg_vrt, 1.2);

Screen('Flip',w);
timestamps.exp_end = GetSecs;

% Trigger EGG
if settings.do_EGG == 1 && ~strcmp(subj.runLABEL, 'training')
    % Write trigger for EGG - end of the experiment
    lptwrite(settings.EGG.port_address, settings.EGG.trigger.exp_off); 
    WaitSecs(1/settings.EGG.sampling_rate);
    lptwrite(settings.EGG.port_address, 0);
end

if settings.do_fmri == 1
       sprintf('Experimenter: Mouse click to close the screen.')
       GetClicks(setup.screenNum);
else
       GetClicks(setup.screenNum);
end

KbQueueRelease();

%% Part 15: Save data

output.variable_labels = {'ID', 'Session', 'Trial', 'Maximum Effort', 'Minimum Effort', 'Time', 'Absolute Effort', 'Relative Effort', 'Difficulty', ...
                 'Money', 'Reward Magnitude', 'Uncertainty', 'Seconds of Winning', 'Points Won'};

% Store output
output.time = datetime;

if strcmp(subj.runLABEL, 'training')
    output.filename = sprintf('TrainEAT_%s_%s_S%s_R%s', subj.study, subj.subjectID, subj.sessionID, subj.runID);
else
    output.filename = sprintf('ExpEAT_%s_%s_S%s_R%s', subj.study, subj.subjectID, subj.sessionID, subj.runID);
end

if  settings.do_gamepad == 1
    if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')
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
   if settings.do_fmri == 1 && ~strcmp(subj.runLABEL, 'training')
       save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'input_device', 'conditions', 'timestamps','MR_timings');
   elseif strcmp(subj.runLABEL, 'training') && settings.do_val_cal == 1
       save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'input_device', 'conditions', 'timestamps', 'collectMax', 'collectBid');
   elseif strcmp(subj.runLABEL, 'training') && settings.do_val_cal == 0
       save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'input_device', 'conditions', 'timestamps', 'collectMax');
       EAT_dir = pwd;
       cd(FCR_dir)
       save(fullfile([output.filename '.mat']), 'output', 'subj', 'input_device', 'conditions', 'timestamps', 'collectMax');
       cd(EAT_dir)
   else
       save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'input_device', 'conditions', 'timestamps');
   end
   save(fullfile('backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));
end


sprintf(['Wins money = ' num2str(output.win.money)])
sprintf(['Wins kcal = ' num2str(output.win.kcal)])
sprintf(['Wins snacks = ' num2str(output.win.snacks)])

if settings.do_WOF == 1 && ~strcmp(subj.runLABEL, 'training')
    sprintf(['Wins wheel of fortune = ' num2str(Wof_win)])
end



input_device.maxEffort;

%delete([temp.filename '.mat']);

%GetClicks(setup.screenNum);
ShowCursor;
Screen('CloseAll');