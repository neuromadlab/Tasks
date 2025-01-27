%% ================== Instrumental Motivation Task ========================
% Coded by: Corinna Schulz, 2022
% Coded with: Matlab R2021b using Psychtoolbox '3.0.16' on Windows 10
% Current Version: V1 (Released: August 2022)
%
% The Instrumental Motivation Task (IMT) has a training phase where sounds
% are associated with reward types and magnitudes and the experimental
% phase, where effort has to be exterted to
% gain those rewards - as indicated by auditory cues. 
%
% Input device: Grip Force Device (GFD)
%
% Requirements: "text2speech 1.0.6", "Psychtoolbox '3.0.16'",
% "SoundVolume - set or get the system speaker sound volume  1.2.0.0"
% =========================================================================

%% Part O: Clear the workspace and prepare system
clear;
close all;
sca;

% Set working directory
home_path = pwd; 

% Check for data folders
if 7~=exist('./Backup','dir')
	mkdir('./Backup')
end

if 7~=exist('./Data','dir')
	mkdir('./Data')
end

%% Part 1:  Input from console

% load settings .mat file
load('./IMT_Settings_TUE008.mat')

% Make sure keyboard input is printed to console 
ListenChar(0); 

% Create subject structure with all relevant session information
subj.study = 'TUE008'; % Study Identifier

validInput = false;
while ~validInput
    subj.subjectID = input('Subject ID : ','s'); % Subject ID
    if strlength(subj.subjectID) == 6 %Check that Input is 6 Digits long otherwise end script
        validInput = true;
    else 
        warning('Check Subject ID (6 digit long)! Please try again.');
    end
end
validInput = false;
while ~validInput
    subj.sessionID = input('Session ID [1/2]: ','s'); % Session Number
    if subj.sessionID == '1' || subj.sessionID == '2' 
        validInput = true;
    else 
        warning('Check Session ID! Please try again.');
    end
end

subj.date_start = datestr(now); % Start Date
subj.date = datestr(now, 'yyyymmdd-HHMM');
subj.version = 1; % Task version

% Training includes: 1. Calibration GFD 2. Cue Learning 3. Full Trials Training
% Experiment includes: Full Trials, MRI settings 
subj.runINDEX = input('Run INDEX [1: Training, 2: Experiment]: ','s');

if subj.runINDEX == '1' 
    settings.do_fmri = 0; 
else 
    settings.do_fmri = 1; % will include trigger and MR.timings 
end 

validInput = false;
while ~validInput
    i_rep = input('Language [1: German, 2: English]: ','s');
    if strcmp(i_rep,'1')
        settings.lang_de = 1;
        validInput = true;
    elseif strcmp(i_rep,'2')
        settings.lang_de = 0;
        validInput = true;
    else
        warning('Not a valid answer! Please try again.');
    end
end

% Initialize Instructions in German or English and initialize Voice reader
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100; 

if settings.lang_de
    instructions_german 
    obj.SelectVoice('Microsoft Hedda Desktop') % German Pronounciation
else 
    instructions_english
    obj.SelectVoice('Microsoft Zira Desktop') % English Pronounciation
end 

% Convert subj/sess IDs to integers
subj.id = str2double(subj.subjectID); 
subj.sess = str2double(subj.sessionID);

% Convert labels 
if strcmp(subj.runINDEX, '1')
    subj.runLABEL = 'training';         
elseif strcmp(subj.runINDEX, '2')
    subj.runLABEL = 'IMT'; 
end

%% Part 2: fMRI settings

%KbName('UnifyKeyNames');
Screen('Preference','TextEncodingLocale');

% TO DO: Eval those settings
if settings.do_fmri == 1
    dummy_volumes = 0; %will have to be set according to the sequence
    MR_timings.dummy_volumes = dummy_volumes;
    keyTrigger=KbName('5%'); % Trigger Code
    keyTrigger2=KbName('5'); % Alternative Trigger Code
    keyQuit=KbName('q'); % Quit Trigger Search
    keyResp=KbName('1'); % TO DO ??
    keyResp2=KbName('1'); % TO DO ??
    count_trigger = 0;
end

%% Part 3: Psychtoolbox and screen

% Close Sound channels left open before start of the experiment
PsychPortAudio('Close') 

PsychDefaultSetup(2);
%PsychDefaultSetup(1); %unifies key names on all operating systems

screens = Screen('Screens');
setup.screenNum = max(screens);  %secondary monitor if  connected

% Define colors
color.white         = WhiteIndex(setup.screenNum);
color.grey          = color.white / 2;
color.black         = BlackIndex(setup.screenNum);
color.red           = [255 0 0];
color.darkblue      = [0 0 139];
color.gold          = [255,215,0];
color.scale_anchors = [205 201 201];
color.light_grey    = [204 204 204];

screen_offset_y = 0.01; %relative offset; positive values move the screen towards to top, negative towards the bottom
scale_offset_y = 0.25;

% Define the keyboard keys that are listened for. 
% Define the keyboard keys used for cue association learning 

keys.escape = KbName('ESCAPE');
keys.resp   = KbName('Space');
keys.left   = KbName('LeftArrow'); %Cue learning
keys.right  = KbName('RightArrow'); %Cue learning
keys.up     = KbName('UpArrow'); %Cue learning
keys.down   = KbName('DownArrow');


% Open the screen and set white background
if  settings.do_fullscreen ~= 1   %if fullscreen = 0, small window opens
    %[window,windowRect] = Screen('OpenWindow',setup.screenNum,color.white,[0 0 800 600]);
    [window,windowRect] =  PsychImaging('OpenWindow',setup.screenNum,color.white,[10 30 810 630]);
    %[window,windowRect] = Screen('OpenWindow', setup.screenNum, 255, [10 30 810 630]);
    Screen('Preference', 'SkipSyncTests', 1);
else
    % When in the scanner, actually do not use fullscreen! Just experimenter
    % sees screen! 
    if strcmp(subj.runINDEX, '2') 
        [window,windowRect] =  PsychImaging('OpenWindow',setup.screenNum,color.white,[10 30 1200 1000]);
    else  
        % Open Fullscreen
        %[window,windowRect] =  Screen('OpenWindow',setup.screenNum,[255 255 255]);
        [window,windowRect] =  PsychImaging('OpenWindow',setup.screenNum,[255 255 255]);
        HideCursor; 
    end 
end

% rename for simplicity
w = window; 
wRect = windowRect; 

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

%% Specific Set up for the Sound in Psychtoolbox 

% Number of channels and Frequency of the sound
nrchannels = 2;

% How many times to we wish to play the sound
repetitions = 1; 

AssertOpenGL;
device = [];

% Start immediately (0 = immediately)
startCue = 1;

% Should we wait for the device to really start (1 = yes)
% INFO: See help PsychPortAudio
waitForDeviceStart = 1;

% Frequency of the sound (this is for beep at end of bidding)
freq = 48000;

% Length of the beep (this is for beep at start and end of bidding)
beepLengthSecs = timings.signaltone_length;

% Prepare Sound stimuli 
% Initialize Sounddriver
InitializePsychSound(1);

% Open Psych-Audio port, with the follow arguements
% (1) [] = default sound device
% (2) 1 = sound playback only
% (3) 1 = default level of latency
% (4) Requested frequency in samples per second
% (5) 2 = stereo putput
pahandle = PsychPortAudio('Open', [], [], [], [], nrchannels);

% Set the volume 
PsychPortAudio('Volume', pahandle, 1);

%% Part 4: General Stimuli Settings 
% Pictures and Tone Stimuli are defined in the settings.mat structure that
% is loaded in the beginning of the script 

% Prepare incentive textures
stim.incentive_coins1       = Screen('MakeTexture', w, stimuli.img.incentive_coins1);
stim.incentive_coins10      = Screen('MakeTexture', w, stimuli.img.incentive_coins10);
stim.incentive_cookies1     = Screen('MakeTexture', w, stimuli.img.incentive_cookies1);
stim.incentive_cookies10    = Screen('MakeTexture', w, stimuli.img.incentive_cookies10);

% Drawing parameters for Thermometer (Tube)
Tube.width                  = round(setup.ScrWidth * .20);
Tube.offset                 = round((setup.ScrHeight - (setup.ScrHeight * .95)) * .35);
Tube.height                 = round(Tube.offset+setup.ScrHeight/4);
Tube.XCor1                  = setup.xCen-Tube.width/2;
Tube.XCor2                  = setup.xCen+Tube.width/2;
Tube.YBottom                = setup.ScrHeight-Tube.offset;

% Drawing parameters for Ball
Ball.width                  = round(setup.ScrWidth * .06);
Ball.color                  = color.darkblue; 

% Drawing parameters for Reward details
Coin.width                  = round(setup.ScrWidth * .15);
% Location of reward incentive
Coin.TopImg                 = setup.ScrHeight/4;
Coin.BottomImg              = Coin.TopImg + Coin.width;
            
Coin.RightImg           = setup.xCen-Tube.width;
Coin.LeftImg            = Coin.RightImg - Coin.width;

Coin.loc                    = [Coin.LeftImg Coin.TopImg Coin.RightImg Coin.BottomImg];

% Text parameters
Text.height                 = setup.ScrHeight/5;
Text.height_cont            = Text.height * 4.7;

%% Part 6: Load required Files 

% Load Condition files for subject and current phase (Cue Conditioning, 
% training, or, exp) 
% Cond file specifies Reward Type (Money vs. Food), Reward Magnitude (Low
% vs. High), Cue Condition Trials Query (No, Yes) and Query Type (Reward Type
% or Reward Magnitude), and lastly, Reward Tone for specific combination of Type and
% Magnitude.  

if strcmp(subj.runLABEL, 'training')

    cond_filename      = sprintf('%s\\conditions\\Train_IMT_cond_%s_%s_S%s.mat', ...
        pwd, subj.study, subj.subjectID, subj.sessionID);

elseif strcmp(subj.runLABEL, 'IMT')

    cond_filename      = sprintf('%s\\conditions\\Exp_IMG_cond_%s_%s_S%s.mat', ...
        pwd, subj.study, subj.subjectID, subj.sessionID);

    % Load Training file for max Effort (Always from S1!)
    maxeffort_searchname = [pwd filesep 'Data' filesep 'effort_' ...
        subj.study '_'  subj.subjectID '_s1.mat'];
    load(maxeffort_searchname)

end

load(cond_filename);

% Load Jitters
number_trials = size(conditions,1);  % get number of trials (training Vs. experiment)

feedback_jitter_filename = sprintf('%s\\jitters\\DelayJitter_mu_%s_max_%s_trials_%s.mat', pwd, timings.avrg_jttr_feedback, timings.max_jttr_feedback, num2str(number_trials));
itt_jitter_filename = sprintf('%s\\jitters\\DelayJitter_mu_%s_max_%s_trials_%s.mat', pwd, timings.avrg_jttr_itt, timings.max_jttr_itt, num2str(number_trials));

load(feedback_jitter_filename);
feedback_jitter = Shuffle(DelayJitter);

timestamps.IMT.shuffled_feedback_jitter = feedback_jitter; % Save this particular shuffle of feedback jitters

load(itt_jitter_filename);
itt_jitter = Shuffle(DelayJitter);

timestamps.IMT.shuffled_itt_jitter = itt_jitter; % Save this particular shuffle of inter trial time  jitters

% Calculate the trial-time based on experimental settings and jitters 
% This is important to ensure proper timing during the experiment and
% buffer hardware dependent timing issues

duration_trial = NaN(number_trials,1); 
for each_trial = 1:number_trials
    % Add all timing setting and jitters together, jitter have an additional 1 second
    duration_trial(each_trial) = timings.cue_length + beepLengthSecs + timings.effort_length + 1 + feedback_jitter(each_trial) + timings.feedback_length + 1 + itt_jitter(each_trial) ; 
end 

timestamps.IMT.duration_trial_theoretical = duration_trial; % Save calculated (ideal) trial durations



%% Part 7: Training (Estimation Max and Min Effort)

if strcmp(subj.runLABEL, 'training')
    % Call the Training Main Script for Max and Min Force Estimation
    timestamps.calibration.exp_on = GetSecs; 
    TrainIMT_main
    timestamps.calibration.exp_off = GetSecs; 
    timestamps_relative.calibration.exp_off = timestamps.calibration.exp_off - timestamps.calibration.exp_on ; 

    % If not Session 1 anymore, the Force estimation is repeated (and
    % logged!) but the Force from the 1st Session is used for the task
    % nonetheless for comparability
    if ~strcmp(subj.sessionID, '1') == 1
        % Load Training file from S1 for max Effort
        maxeffort_searchname = [pwd filesep 'Data' filesep 'effort_' subj.study '_'  subj.subjectID '_s1.mat'];
        load(maxeffort_searchname)
    end

end

%% Part 8: Initialize Input device unrelated values and Output structure 

% Get operating system and set OS flags
system_info     = Screen('Computer');
windows         = system_info.windows;

% Initialise vectors and counting variables
i_break         = 0;  
t_vector        = []; % Vector for time references observations
count_breaks    = 1;
% Timings
i_step = 1; %loops through each iteration of the while loop (to place time stamps)
i_step_aftBeep = 0; %needed for Beep at beginning of bidding phase 

% Initialize output structure
output.data_mat         = []; % Save later during every loop 
output.cue_conditioning = []; % Save later during every loop conditioning
output.win.payout_per_trial = 0;
output.effort           = []; % Save later during full exp loop 

% vector storing effort measure
effort_vector   = NaN; %stores effort value 

%% Part 9: Input device dependent values
% Load GFC settings .mat
load('./GripForceSpec.mat')

% initialize grip force specific values    

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

% The minEffort and maxEffort are determined during the 
% training estimation phase (Part 7) 

% input_device.minEffort
% input_device.maxEffort

% Determine resting Force (a bit lower (i.e. stronger force) than minimum)
restforce = input_device.minEffort - 0.05* ...
    (input_device.minEffort - input_device.maxEffort); % 5% over min force

% Get current gripforce value
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
gripforce_value = Joystick.Y;

% Other GFD variables 
i_step_gr           = 1;  % Enummarate over loops
delta_pos_force     = input_device.minEffort - input_device.maxEffort;

% Use adapted clickforce after training calibration 
% clckforce           = settings.clckforce; % default setting for clickforce
clckforce           = input_device.minEffort - 0.85* ...
                         abs(input_device.minEffort - input_device.maxEffort);
ForceMat            = restforce;
ForceTime           = []; %matrix that saves force over time

% Other drawing settings
LowerBoundBar       = setup.ScrHeight - Tube.offset;
UpperBoundBar       = Tube.height + Ball.width;
BarBoundAbs         = LowerBoundBar - UpperBoundBar;
BarBound2Scale      = BarBoundAbs/delta_pos_force;

%% Part 10: Start Cue Conditioning and Test of Conditioning 
if strcmp(subj.runLABEL, 'training')
    
    % Load Conditions for Cue Learning 
    cue_cond_filename      = sprintf('%s\\conditions\\Conditioning_IMT_cond_%s_%s_S%s.mat', ...
    pwd, subj.study, subj.subjectID, subj.sessionID);
    load(cue_cond_filename)
    
    % Call the Cue Conditioning Main Script 
    timestamps.conditioning.exp_on = GetSecs; 
    CueCond_IMT
    timestamps.conditioning.exp_off = GetSecs; 
    timestamps_relative.conditioning.exp_off = timestamps.conditioning.exp_off - timestamps.conditioning.exp_on ; 

end 

%% Prepare Start of Experiment: Show instructions on screen

Screen('Flip',w); 
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');

% Bunch of sequential instructions, continues by Grip Force Device pressing
if strcmp(subj.runLABEL, 'training') % Remind with instructions what the full experiment now entails
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.train_bidding, 'center', Text.height, color.black, 60);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.continue_GFD, 'center', Text.height_cont, color.black, 50);
    Screen('Flip',w);
    WaitSecs(1.5)

    % Get Press-to-continue
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    gripforce_value = Joystick.Y;

    while gripforce_value > clckforce
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        gripforce_value = Joystick.Y;
    end

    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.train_bidding_recap, 'center', Text.height, color.black);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.continue_GFD, 'center', Text.height_cont, color.black, 50);
    Screen('Flip',w);
    WaitSecs(2)

    % Get Press-to-continue
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    gripforce_value = Joystick.Y;

    while gripforce_value > clckforce
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        gripforce_value = Joystick.Y;
    end

    % Explain Point to Final Payoff Relationship 
    if settings.lang_de == 1
        instr.reward               = ['Die Umrechnung der Punkte richtet sich nach folgendem Kurs:  '...
                                    '\n\n 100  Geld-Punkte entsprechen ' num2str(settings.value_money) ' cent.'...
                                    '\n\n  100  Essens-Punkte entsprechen ' num2str(settings.value_food) ' kcal.'...
                                    '\n\nIm Anschluss an die Aufgabe können Sie die Geldpunkte in einen entsprechenden Geldbetrag eintauschen'...
                                    '\nund für die Essens-Punkte einen entsprechenden Snack erhalten.'];
    else                       
        instr.reward              = ['The points will be converted using the following exchange rates:  '...
                                    '\n\n 100  Money points correspond to ' num2str(settings.value_money) ' cents.'...
                                    '\n\n  100  Snack points correspond to ' num2str(settings.value_food) ' kcal.'...
                                    '\n\nFollowing the task, you can exchange the Money points for the corresponding amount of money'...
                                    '\nand the Snack points for the corresponding number of snacks.'];
    end
    
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward, 'center', Text.height, color.black);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.continue_GFD, 'center', Text.height_cont, color.black, 50);
    Screen('Flip',w);
    WaitSecs(2)

    % Get Press-to-continue
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    gripforce_value = Joystick.Y;

    while gripforce_value > clckforce
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        gripforce_value = Joystick.Y;
    end
    
    % Explain Strategy of making breaks during experiment 
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.time_strategy, 'center', Text.height, color.black);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.continue_GFD, 'center', Text.height_cont, color.black, 50);
    Screen('Flip',w);
    WaitSecs(2)

    % Get Press-to-continue
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    gripforce_value = Joystick.Y;

    while gripforce_value > clckforce
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        gripforce_value = Joystick.Y;
    end
end 

% Flip to clear
Screen('Flip', w);
WaitSecs(1)

Speak(obj, instr.intro);
WaitSecs(1)

%% Introduce the signal sound/ Remind of the Signal Sound 
Speak(obj, instr.signal_tone); % Remind to Only press after Signal Tone
Speak(obj, instr.signal_example); % Remind to Only press after Signal Tone
myBeep = MakeBeep(400, beepLengthSecs, freq);
% Fill the audio playback buffer with the audio data, doubled for stereo presentation
PsychPortAudio('FillBuffer', pahandle, [myBeep; myBeep]);
% Start and stop audio playback
start_beep = PsychPortAudio('Start', pahandle, repetitions, 0, waitForDeviceStart);
while 1 
    if GetSecs >= start_beep + beepLengthSecs 
       [startTime, endPositionSecs, xruns, estStopTime] = PsychPortAudio('Stop', pahandle);
       break; 
    end 
end 

if strcmp(subj.runINDEX,'2')

    % Load Conditions for Tone Association
    cue_cond_filename      = sprintf('%s\\conditions\\Conditioning_IMT_cond_%s_%s_S%s.mat', ...
                    pwd, subj.study, subj.subjectID, subj.sessionID);
    load(cue_cond_filename)

    Recap = 'Recap';
    Screen('TextSize',w,64);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, Recap, 'center', 'center', color.black,80);
    Screen('Flip', w);

    Speak(obj, instr.intro_scanner);
    WaitSecs(1)

    % Give participant reminder of the tone-reward association before the start
    % of the experiment
    timestamps.IMT.recap.exp_on = GetSecs;
    cuecond_reminder
    timestamps.IMT.recap.exp_off = GetSecs;
end

Speak(obj, instr.intro_scanner_start);
WaitSecs(1); 

% Flip to clear
Screen('Flip', w);

% ===========================================================================
%% Part 11: Start of the Experiment
% ===========================================================================
% IMT Main Part 
% For each trial a sound is presented (anticipation phase), followed by a
% 3s period to indicate willingness to obtain the reward via the GFC 
% (effort phase) and, ultimately, a feedback phase. 
% ===========================================================================

%% Start fMRI procedure
if settings.do_fmri == 1
    % Listen for triggers    
    waiting_tigger = 'Waiting for Trigger'; 
    % Show Screen while waiting for trigger
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, waiting_tigger, 'center', Text.height, color.black);
    Screen('Flip',w);
    MR_timings.trigger.on_trigger_loop = GetSecs;
    KbQueueFlush(); 
	KbQueueStart(); 
    [b,c] = KbQueueCheck;
    sprintf(waiting_tigger)
    while ~c(keyQuit) 
        [b,c] = KbQueueCheck;
        sprintf(waiting_tigger)
        if c(keyTrigger) || c(keyTrigger2) > 0
            count_trigger                           = count_trigger + 1;
            MR_timings.trigger.all(count_trigger,1) = GetSecs;            
            if count_trigger > dummy_volumes
                MR_timings.trigger.fin = GetSecs;
                sprintf('Trigger found. Start Experiment')
                break
            end
        end
    end
    KbQueueFlush();
    Screen('Flip',w);
end

timestamps.IMT.exp_on = GetSecs;

%  Loop through trials 
for i_trial = 1:size(conditions,1) % condition file determines repetitions
    
    %% 11.1 Breakpoints during experiment
    if i_trial == timings.break_trials(count_breaks)

        if count_breaks < timings.number_breaks
            count_breaks = count_breaks + 1;
        end
        i_timer = 1;
        timer_onset_break = GetSecs;

        i_break = i_break +1;

        timestamps.IMT.start_break(i_break) = timer_onset_break;
        timestamps_relative.IMT.break(i_break) = timer_onset_break - timestamps.IMT.exp_on ;
        
        if settings.lang_de
            Break = char("Kurze Pause");
        else 
            Break = char("Short Break");
        end 
        Speak(obj, Break);

        while 1
            Pause = 'Break';
            Screen('TextSize',w,64);
            Screen('TextFont',w,'Arial');
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, Pause, 'center', 'center', color.black,80);
            Screen('Flip', w);
            if GetSecs >= timer_onset_break + timings.break_length
                break
            end
        end

        if settings.lang_de
            Break = char("Es geht weiter!");
        else 
            Break = char("Task continues!");
        end 
        Speak(obj, Break);

        timestamps.IMT.end_break(i_break) = GetSecs;
        timestamps_relative.IMT.end_break(i_break) = timestamps.IMT.end_break(i_break) - timestamps.IMT.exp_on ;
        
        if settings.do_fmri == 1 
            MR_timings.onsets.break(i_break) = timestamps.IMT.start_break(i_break) - MR_timings.trigger.fin;
            MR_timings.durations.break(i_break) = timestamps.IMT.end_break(i_break) - timestamps.IMT.start_break(i_break); 
        end 
    end

    %% 11.2 Update trial settings before trial start

    % Get current Reward (Food Vs. Money, High Vs. Low), and Tone 
    Reward_Type         = conditions(i_trial,1);  % 1 = Money, 0 = Food
    Reward_Mag          = conditions(i_trial,2);  % 1 or 10
    Reward_Tone         = table2array(conditionstable(i_trial,3));  % Tone

    % Prepare graphical display with corresponding reward items    
    % determine Reward Image (incentive) 
    if Reward_Type == 0 && Reward_Mag == 1 % Food, Low
        Reward_Img = stim.incentive_cookies1; 
    elseif Reward_Type == 0 && Reward_Mag == 10 % Food, High
        Reward_Img = stim.incentive_cookies10; 
    elseif Reward_Type == 1 && Reward_Mag == 1 % Money, Low
        Reward_Img = stim.incentive_coins1; 
    elseif Reward_Type == 1 && Reward_Mag == 10 % Money, High
        Reward_Img = stim.incentive_coins10; 
    end 
   
    % Prepare current reward tone (get wavedata, previously (during
    % Create_Settings.m read in using psychwavread function 
    if Reward_Tone == 1 
         wavedata = stimuli.tone.one.y'; 
    elseif Reward_Tone == 2 
         wavedata = stimuli.tone.two.y'; 
    elseif Reward_Tone == 3 
         wavedata = stimuli.tone.three.y'; 
    elseif Reward_Tone == 4
         wavedata = stimuli.tone.four.y'; 
    end 

    %% 11.3 CUE PHASE: Sounds (+ Image)

    % Make sure we have always 2 channels stereo output.
    % Why? Because some low-end and embedded soundcards
    % only support 2 channels, not 1 channel, and we want
    % to be robust in our demos.
    nrchannels = size(wavedata,1); % Number of rows == number of channels.
    if nrchannels < 2
        wavedata = [wavedata ; wavedata];
        nrchannels = 2;
    end

    % Fill the audio playback buffer with the audio data 'wavedata':
    PsychPortAudio('FillBuffer', pahandle, wavedata);
    
    % Start audio playback indicating the Reward Type (Money/Food) and Reward Magnitude (1/10) 
    starttime_audio = PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart);
    timestamps.IMT.start_CS(i_trial,1) = starttime_audio;
    timestamps_relative.IMT.start_CS(i_trial,1) = starttime_audio - timestamps.IMT.exp_on; 

    % Let the Cue phase (audio cue) be 3 seconds, during this time show
    % image for experimenter about reward type and magnitude
    while (GetSecs-starttime_audio) < timings.cue_length  
 
        if strcmp(subj.runINDEX,'2') 
            % Draw Image that is associated with the Tone for EXPERIMENTER ONLY
            Screen('DrawTexture', w,  Reward_Img,[], Coin.loc);
        
            % Draw Tube 
            Screen('DrawLine',effort_scr,color.black,Tube.XCor1, Tube.height, Tube.XCor1, Tube.YBottom ,6);
            Screen('DrawLine',effort_scr,color.black,Tube.XCor2, Tube.height, Tube.XCor2, Tube.YBottom ,6);
            Screen('DrawLine',effort_scr,color.black,Tube.XCor1, Tube.YBottom, Tube.XCor2, Tube.YBottom,6);
        
            % Incentive
            Screen('DrawTexture', effort_scr,  Reward_Img,[], Coin.loc);
            Screen('CopyWindow',effort_scr,w);
            Screen('Flip', w);
        end 
        
    end
    
    % Stop Playback 
    [startTime, endPositionSecs, xruns, estStopTime] = PsychPortAudio('Stop', pahandle);
    timestamps.IMT.stop_CS(i_trial,1) = estStopTime; 
    timestamps_relative.IMT.stop_CS(i_trial,1) = estStopTime - timestamps.IMT.exp_on; 

    if settings.do_fmri == 1 
        MR_timings.onsets.condition_preview_reward(i_trial,1) = timestamps.IMT.start_CS(i_trial,1) - MR_timings.trigger.fin;
        MR_timings.durations.condition_preview_reward(i_trial,1) = timestamps.IMT.stop_CS(i_trial,1) - timestamps.IMT.start_CS(i_trial,1); 
    end


    %% 11.4 Bidding Phase 
    % Save Bidding Type, here GFD used
    output.rating.type = {'bidding_GFD'};

    % Call GFD script for bidding
    GFD_tube

    % 1s plus jitter value (drawn from exponential distribution)
    timestamps.IMT.start_jitter_effort(i_trial,1) = GetSecs; 
    timestamps_relative.IMT.start_jitter_effort(i_trial,1) = timestamps.IMT.start_jitter_effort(i_trial,1)  - timestamps.IMT.exp_on; 

    while 1
        if GetSecs >= (timestamps.IMT.stop_CS(i_trial,1) + 1 + feedback_jitter(i_trial,1))
            timestamps.IMT.end_jitter_effort(i_trial,1) = GetSecs; 
            timestamps_relative.IMT.end_jitter_effort(i_trial,1) = timestamps.IMT.end_jitter_effort(i_trial,1)  - timestamps.IMT.exp_on; 

            if settings.do_fmri == 1 
                MR_timings.onsets.jitter_effort(i_trial,1) =  timestamps.IMT.start_jitter_effort(i_trial,1) - MR_timings.trigger.fin;
                MR_timings.durations.jitter_effort(i_trial,1) = timestamps.IMT.end_jitter_effort(i_trial,1) -  timestamps.IMT.start_jitter_effort(i_trial,1); 
            end

            break;
        else
            if strcmp(subj.runINDEX,'2')
                fix = '+';
                Screen('TextSize',w,64);
                Screen('TextFont',w,'Arial');
                [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', color.black,80);
                Screen('Flip', w);
            end
        end
    end

    %% 11.5 Feedback Preparation: Win Calculation 
    % Area under the Curve of Relative Force is used 
    % to calculate win for this trial according to reward at stake
    
    % Get AUC Normalized for this trial from interim output 
    AUC_norm_vec = output.effort(output.effort(:,4) == i_trial,16);  % Get Effort related output of this trial After Beep

    if Reward_Type == 1 && Reward_Mag == 1      % Money, Low
        win_coins   = round(AUC_norm_vec(1),2) * 10;        
    elseif Reward_Type == 0 && Reward_Mag == 1  % Food, Low
        win_cookies = round(AUC_norm_vec(1),2) * 10;                   
    elseif Reward_Type == 1 && Reward_Mag == 10 % Money, High        
        win_coins   = round(AUC_norm_vec(1),2) * 100;        
    elseif Reward_Type == 0 && Reward_Mag == 10 % Food, High        
        win_cookies = round(AUC_norm_vec(1),2) * 100;       
    end

    %% 11.6 Feedback Phase
    if  Reward_Type == 0 %Food 
        points = win_cookies; 
        Feedback_type = 'kcal Punkte'; 
    elseif Reward_Type== 1 %Money 
        points = win_coins; 
        Feedback_type = 'cent Punkte'; 
    end 
    
    Feedback = char(string(round(points)) + Feedback_type); 

    if strcmp(subj.runINDEX,'2')
        Screen('TextSize',w,64);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, Feedback, 'center', 'center', color.black,80);
        Screen('Flip', w);
    end

    timestamps.IMT.start_feedback(i_trial,1) = GetSecs; 
    timestamps_relative.IMT.start_feedback(i_trial,1) = timestamps.IMT.start_feedback(i_trial,1) - timestamps.IMT.exp_on; 
   
    % Read out feedback points 
    Speak(obj, Feedback); 
    
    timestamps.IMT.endvoice_feedback(i_trial,1) = GetSecs; 
    timestamps_relative.IMT.endvoice_feedback(i_trial,1) = timestamps.IMT.endvoice_feedback(i_trial,1)  - timestamps.IMT.exp_on; 
    
    % During the Training let participants know whether they pressed too early
    % (i.e., during signal tone), if they exceed a force threshold during
    % signal tone declare the trial as invalid! For actual experiment still
    % save information but do not communicate
    
    if any(output.effort(output.effort(:,4) == i_trial & isnan(output.effort(:,12)),8) >= settings.invalid_effort)
        too_early_effort(i_trial,1) = 1;
        if settings.lang_de == 1
            info_validity = "Ungültig";
        else
            info_validity = "Invalid";
        end
    else
        too_early_effort(i_trial,1) = 0;
        if settings.lang_de == 1
            info_validity = "Gültig";
        else
            info_validity = "Valid";
        end
    end
    if strcmp(subj.runINDEX,'1')
        Speak(obj, info_validity);
    end

    % Ensure that feedback has minimum length 
    while 1
        if timings.feedback_length >= (timestamps.IMT.endvoice_feedback(i_trial,1) - timestamps.IMT.start_feedback(i_trial,1))
            break;
        end 
    end 

    timestamps.IMT.end_feedback(i_trial,1) = GetSecs;
    timestamps_relative.IMT.end_feedback(i_trial,1) = timestamps.IMT.end_feedback(i_trial,1) - timestamps.IMT.exp_on; 

    if settings.do_fmri == 1
        MR_timings.onsets.feedback(i_trial,1) = timestamps.IMT.start_feedback(i_trial,1) - MR_timings.trigger.fin;
        MR_timings.durations.feedback_voice(i_trial,1) = timestamps.IMT.endvoice_feedback(i_trial,1) - timestamps.IMT.start_feedback(i_trial,1);
        MR_timings.durations.feedback_end(i_trial,1) = timestamps_relative.IMT.end_feedback(i_trial,1) - timestamps.IMT.start_feedback(i_trial,1);
    end

    % Store Points in output struct
    output.win.payout_per_trial(1,i_trial) = points;
    output.win.payout_per_trial(2,i_trial) = Reward_Type;
    output.win.payout_per_trial(3,i_trial) = Reward_Mag;

    % Inter-Trial Time 
    if strcmp(subj.runINDEX,'2')
        fix = '+';
        Screen('TextSize',w,64);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', color.black,80);
        Screen('Flip', w);
    end

    timestamps.IMT.start_itt(i_trial,1) = GetSecs;
    timestamps_relative.IMT.start_iit(i_trial,1) = timestamps.IMT.start_itt(i_trial,1) - timestamps.IMT.exp_on; 
        
    % Ensure that trials have expected length from start of CS to end of itt
    % the duration_trial includes the (1+jitter) for inter-trial time. 
    while 1 
        if GetSecs >= timestamps.IMT.start_CS(i_trial,1) + duration_trial(i_trial) 
            break; 
        end 
    end 
    timestamps.IMT.end_itt(i_trial,1) = GetSecs;
    timestamps_relative.IMT.end_itt(i_trial,1) = timestamps.IMT.end_itt(i_trial,1) - timestamps.IMT.exp_on; 

    if settings.do_fmri == 1
        MR_timings.onsets.itt(i_trial,1) = timestamps.IMT.start_itt(i_trial,1) - MR_timings.trigger.fin;
        MR_timings.durations.itt(i_trial,1) = timestamps.IMT.end_itt(i_trial,1) - timestamps.IMT.start_itt(i_trial,1); 
    end
        
    %% 11.7 Save Data Backup at end of every trial
    effort_vec = output.effort(output.effort(:,4) == i_trial,:);  % Get Effort related output of this trial

    output.data_mat = [output.data_mat;
        [double(ones(length(effort_vec),1) * subj.id), ...                   % subject ID
        double(ones(length(effort_vec),1) * subj.sess), ...                  % session
        double(ones(length(effort_vec),1) * str2double(subj.runINDEX)), ...  % run number
        double(effort_vec(:,4)),...                                          % trial number
        ones(length(effort_vec),1) * Reward_Type, ...                        % condition: Reward Type
        ones(length(effort_vec),1) * Reward_Mag, ...                         % condition: Reward Magnitude
        ones(length(effort_vec),1) * input_device.maxEffort,...              % Max Effort 
        ones(length(effort_vec),1) * input_device.minEffort,...              % Min Effort 
        double(effort_vec(:,5)),...                                          % Time absolute 
        double(effort_vec(:,6)),...                                          % Force absolute 
        double(effort_vec(:,7)),...                                          % Time relative to trial start (before Beep)
        double(effort_vec(:,8)),...                                          % Relative Force (to max and min Force) (with before beep)
        double(effort_vec(:,9)),...                                          % Time relative to bidding start after Beep!
        double(effort_vec(:,10)),...                                         % Relative Force after beep!
        double(effort_vec(:,11)),...                                         % Area under the Curve (AUC) for Force on this trial (just after beep)
        double(effort_vec(:,12)),...                                         % AUC normalized by max Force after Beep! 
        ones(length(effort_vec),1) * output.win.payout_per_trial(1,i_trial),... % Points won per trial   
        repelem(too_early_effort(i_trial,1), length(effort_vec))']];          % Trial counted as invalid due to too early effort start

    %Save task version
    output.version = subj.version;

    if strcmp(subj.runINDEX,'1')
        temp_filename = ['Train_IMT_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_R', '_temp' ];
        save(fullfile('Backup', [temp_filename '.mat']),'conditions','output','subj','timestamps','timestamps_relative');
    else 
        temp_filename = ['IMT_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_R', '_temp' ];
        save(fullfile('Backup', [temp_filename '.mat']),'conditions','output','subj','timestamps','timestamps_relative','MR_timings');
    end 
end

%% Prepare Final Feedback 
% Compute win
output.win.sum_coins    = floor(nansum(output.win.payout_per_trial(1,output.win.payout_per_trial(2,:)==1))); % select money trials
output.win.sum_cookies  = floor(nansum(output.win.payout_per_trial(1,output.win.payout_per_trial(2,:)==0))); % select food trials
output.win.money        = floor(output.win.sum_coins*settings.value_money/100)/100;
output.win.kcal         = floor(output.win.sum_cookies*settings.value_food/100); 

%% Part 15: Save data 
output.variable_labels_data_mat = {'ID', 'Session', 'RunINDEX','Trial','Reward_Money','Reward_Magnitude' 'Maximum_Effort', 'Minimum_Effort', 'Time_Abs','Force_Abs','Time_Trial','Force_rel','Time_Trial_aftBeep','Force_rel_aftBeep','AUC','AUC_normed','Points_won','Invalid_effort'};

% Save time end of experiment
output.time             = datetime;

% Save time end of experiment
subj.date_end           = datestr(now);
t_start                 = datevec(datenum(subj.date_start));
t_end                   = datevec(datenum(subj.date_end ));
subj.length_exp         = etime(t_end, t_start)/60; %length exp in min

timestamps.IMT.exp_end = GetSecs;
timestamps_relative.exp_end = timestamps.IMT.exp_end- timestamps.IMT.exp_on; 

% Create filenames and save final data
if strcmp(subj.runLABEL, 'training')
    output.filename = sprintf('Train_IMT_%s_%s_S%s', subj.study, subj.subjectID, subj.sessionID);
    save(fullfile('Data', [output.filename '.mat']),'conditions', 'cue_conditionstable', 'output','subj', 'input_device', 'timestamps','timestamps_relative');
else % save also MRI timestamps
    output.filename = sprintf('Exp_IMT_%s_%s_S%s', subj.study, subj.subjectID, subj.sessionID);
    save(fullfile('Data', [output.filename '.mat']),'conditions','output','subj','input_device','timestamps','timestamps_relative','MR_timings');
end

% Save backup 
save(fullfile('Backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));

% Delete excess backup files (interim)
delete(fullfile('Backup', [temp_filename '.mat']));

%% Print Wins to Console and participant 

% Show final output for the training, read out during experiment 
if strcmp(subj.runLABEL, 'training') 
    
    if settings.lang_de == 1
        final_feedback = ['Die Übung ist nun zu Ende.'...
            '\n\n Im richtigen Spiel haetten Sie ' num2str(output.win.sum_coins) ' Geld-Punkte gewonnen. '...
            '\n Das entspicht ' num2str(output.win.money) ' Euro. '...
            '\n\nIm richtigen Spiel haetten Sie ' num2str(output.win.sum_cookies) ' Essens-Punkte gewonnen. '...
            '\nDas entspricht ' num2str(output.win.kcal) ' Kcal.' ];
    else
        final_feedback = ['The practice is now complete.'...
            '\n\n In the actual game, you would have won ' num2str(output.win.sum_coins) ' Money points. '...
            '\n This corresponds to ' num2str(output.win.money) ' Euros. '...
            '\n\nIn the actual game, you would have won ' num2str(output.win.sum_cookies) ' Snack points. '...
            '\nThis corresponds to ' num2str(output.win.kcal) ' Kcal.' ];
    end
    
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, final_feedback, 'center', 'center', color.black,80);

    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');
    Screen('Flip',w);

elseif strcmp(subj.runLABEL, 'IMT') 

    End_exp = instr.end_exp;
    Speak(obj, End_exp);

end

sprintf('Experimenter: Mouse click to close the screen.')


if settings.do_fmri == 1
       sprintf('Experimenter: Mouse click to close the screen.')
       GetClicks(setup.screenNum);
else
       GetClicks(setup.screenNum);
end

KbQueueRelease();

sprintf(['Money Points = ' num2str(output.win.sum_coins) ...
    '\nFood Points = ' num2str(output.win.sum_cookies)...
    '\nWins money in Euro = ' num2str(output.win.money)...
    '\nWins kcal = ' num2str(output.win.kcal)])

%% Close everything 
ShowCursor;
PsychPortAudio('Close') 
Screen('CloseAll');

