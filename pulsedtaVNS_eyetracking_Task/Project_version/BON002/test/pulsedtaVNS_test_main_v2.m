% ================== Paradigm to test different stimulation parameters between  =============================
% For a description of the set of images, see Charbonnier (2015) Appetite
% Coded by: Anne Kühnel 
% Coded 1
% with: Matlab R2022a using Psychtoolbox 3.0.16

% 1 (February 2022, Corinna Schulz) 
% =========================================================================
clear
sca

% Check for data folders
if 7~=exist('./Backup','dir')
	mkdir('./Backup')
end

if 7~=exist('./data','dir')
	mkdir('./data')
end

if 7~=exist('./data_eyelink','dir')
	mkdir('./data_eyelink')
end

%% General settings:
subj.version = 1; %Task version
output.version = subj.version;
subj.study = 'BON002'; % Enter here current study name
subj.subjectID = input('Subject ID: ','s');
subj.subjectID = pad(subj.subjectID,6,"left",'0');
subj.sessionID = input('Session ID: ','s');
subj.stim_amplitude = input('Stimulation intensity [mA]: ','s');


subj.runID = '1';

%load individual randomization file
name_file = strcat('settings/taVNSoptimize_', subj.study,'_' , subj.subjectID, '_S', subj.sessionID);
load(name_file);


subj.lang = input('German? (Otherwise english), [y/n]: ', 's');
if strcmp(subj.lang,'y')
    setup.lang = 'de';
elseif strcmp(subj.lang,'n')
    setup.lang = 'en';
else 
    return
end

start_part = input('Do you want to start from the beginning? [y/n] ','s');
if strcmp(start_part,'y')
    start_block = 1;
elseif strcmp(start_part,'n')
    if subj.runID == '2'
        first_block = input('Which block do you want to start? [1-3] ','s');
    else
        first_block = input('Which block do you want to start? [1-3] ','s');
    end
    start_block = str2double(first_block);
    while start_block < 1 || start_block > 5
    if subj.runID == '2'
        first_block = input('Which block do you want to start? [1-3] ','s');
    else
        first_block = input('Which block do you want to start? [1-3] ','s');
    end
        start_block = str2double(first_block);
    end
    %load previous backup data (latest backup file)
    try
    Backups = dir(['Backup\OpttaVNS*',subj.subjectID,'_S',subj.sessionID,'_R',subj.runID,'*']);
    name_file = [Backups(end).folder,filesep,Backups(end).name];
    load(name_file,'output')
    catch
    disp('No data from previous blocks available, maybe better to start from the beginning?')
    return
    end
else 
    return
end

subj.stim = input('Stimulation [active yes = 1, no = 0]: ','s');

if setup.stim_cond ~= str2double(subj.stim)
    disp('Conditions not congruent')
    return
end
% Convert subject info
subj.subjectID = [repmat('0',1,6-length(subj.subjectID)) subj.subjectID];
subj.id = str2double(subj.subjectID);   % converts Subject ID to integer
subj.sess = str2double(subj.sessionID); % converts Session ID to integer
subj.run = str2double(subj.runID);      % converts Run ID to integer

randomization_run = setup.randomization(setup.randomization.run_id == subj.run,:);

disp(['For the first block, set the frequency to: ' num2str(randomization_run.frequency(1)) ' then start the taVNS manager and connect the device']);

subj.date_start      = datestr(now);
subj.date      = datestr(now, 'yyyymmdd-HHMM');

% Get operating system and set OS flags
system_info = Screen('Computer');
windows = system_info.windows;
mac = system_info.osx;
linux = system_info.linux;   

%taVNS mode

manual = setup.taVNS_mode;


% Screen settings
screens = Screen('Screens'); %Define display screen
screenNumber = max(screens);

% Automatic operating information
Screen('Preference', 'SkipSyncTests', 1);

%setup.do_eyetracking = 0;

do_eyetracking = setup.do_eyetracking;
do_eyelink = setup.do_eyelink;

color.white = WhiteIndex(screenNumber);
color.grey = color.white / 2;


if do_eyetracking == 1
    if do_eyelink == 0
        % Set up Eyetracking Toby (or eyelink)
        DEBUGlevel              = 0;
        fixClrs                 = [0 255];
        scr                     = max(Screen('Screens'));
        bgClr                   = 127;
        useAnimatedCalibration  = true;
        doBimonocularCalibration= false;

        % get setup struct (can edit that of course):
        settings = Titta.getDefaults('Tobii Pro Fusion');
        % request some debug output to command window, can skip for normal use
        settings.debugMode      = true;
        % customize colors of setup and calibration interface (colors of
        % everything can be set, so there is a lot here).
        % 1. setup screen
        settings.UI.setup.bgColor       = bgClr;
        settings.UI.setup.instruct.color= fixClrs(1);
        settings.UI.setup.fixBackColor  = fixClrs(1);
        settings.UI.setup.fixFrontColor = fixClrs(2);
        % 2. validation result screen
        settings.UI.val.bgColor                 = bgClr;
        settings.UI.val.avg.text.color          = fixClrs(1);
        settings.UI.val.fixBackColor            = fixClrs(1);
        settings.UI.val.fixFrontColor           = fixClrs(2);
        settings.UI.val.onlineGaze.fixBackColor = fixClrs(1);
        settings.UI.val.onlineGaze.fixFrontColor= fixClrs(2);
        % calibration display
        if useAnimatedCalibration
            % custom calibration drawer
            calViz                      = AnimatedCalibrationDisplay();
            settings.cal.drawFunction   = @calViz.doDraw;
            calViz.bgColor              = bgClr;
            calViz.fixBackColor         = fixClrs(1);
            calViz.fixFrontColor        = fixClrs(2);
        else
            % set color of built-in fixation points
            settings.cal.bgColor        = bgClr;
            settings.cal.fixBackColor   = fixClrs(1);
            settings.cal.fixFrontColor  = fixClrs(2);
        end
        % callback function for completion of each calibration point
        settings.cal.pointNotifyFunction = @demoCalCompletionFun;

        % init
        EThndl          = Titta(settings);
        % EThndl          = EThndl.setDummyMode();    % just for internal testing, enabling dummy mode for this readme makes little sense as a demo
        EThndl.init();

        if DEBUGlevel>1
            % make screen partially transparent on OSX and windows vista or
            % higher, so we can debug.
            PsychDebugWindowConfiguration;
        end
        if DEBUGlevel
            % Be pretty verbose about information and hints to optimize your code and system.
            Screen('Preference', 'Verbosity', 4);
        else
            % Only output critical errors and warnings.
            Screen('Preference', 'Verbosity', 2);
        end
        Screen('Preference', 'SyncTestSettings', 0.002);    % the systems are a little noisy, give the test a little more leeway
        [wpnt,winRect] = PsychImaging('OpenWindow', scr, bgClr, [], [], [], [], 4);
        hz=Screen('NominalFrameRate', wpnt);
        Priority(1);
        Screen('BlendFunction', wpnt, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        Screen('Preference', 'TextAlphaBlending', 1);
        Screen('Preference', 'TextAntiAliasing', 2);
        % This preference setting selects the high quality text renderer on
        % each operating system: It is not really needed, as the high quality
        % renderer is the default on all operating systems, so this is more of
        % a "better safe than sorry" setting.
        Screen('Preference', 'TextRenderer', 1);
        KbName('UnifyKeyNames');    % for correct operation of the setup/calibration interface, calling this is required

        % do calibration
        try
            ListenChar(-1);
        catch ME
            % old PTBs don't have mode -1, use 2 instead which also supresses
            % keypresses from leaking through to matlab
            ListenChar(2);
        end
        if doBimonocularCalibration
            % do sequential monocular calibrations for the two eyes
            settings                = EThndl.getOptions();
            settings.calibrateEye   = 'left';
            settings.UI.button.setup.cal.string = 'calibrate left eye (<i>spacebar<i>)';
            str = settings.UI.button.val.continue.string;
            settings.UI.button.val.continue.string = 'calibrate other eye (<i>spacebar<i>)';
            EThndl.setOptions(settings);
            tobii.calVal{1}         = EThndl.calibrate(wpnt,1);
            if ~tobii.calVal{1}.wasSkipped
                settings.calibrateEye   = 'right';
                settings.UI.button.setup.cal.string = 'calibrate right eye (<i>spacebar<i>)';
                settings.UI.button.val.continue.string = str;
                EThndl.setOptions(settings);
                tobii.calVal{2}         = EThndl.calibrate(wpnt,2);
            end
        else
            % do binocular calibration
            disp('Calibration starts, press space bar in about 10 seconds/ask participant to let you know when they are done')
            tobii.calVal{1}         = EThndl.calibrate(wpnt);
        end
        ListenChar(0);

        %end setup
    elseif do_eyelink == 1

        %% STEP 1: INITIALIZE EYELINK CONNECTION; OPEN EDF FILE; GET EYELINK TRACKER VERSION

        % Initialize EyeLink connection (dummymode = 0) or run in "Dummy Mode" without an EyeLink connection (dummymode = 1);
        dummymode = 0;

        % Optional: Set IP address of eyelink tracker computer to connect to.
        % Call this before initializing an EyeLink connection if you want to use a non-default IP address for the Host PC.
        %Eyelink('SetAddress', '10.10.10.240');

        EyelinkInit(dummymode); % Initialize EyeLink connection
        status = Eyelink('IsConnected');
        if status < 1 % If EyeLink not connected
            dummymode = 1;
        end

        % Open dialog box for EyeLink Data file name entry. File name up to 8 characters
        if subj.id < 100
            edfFile = ['P',num2str(subj.id),'S',num2str(subj.sess),'B',num2str(randomization_run.block_id(start_block))]; % Save file name to a variable
        else
            edfFile = ['P9',num2str(subj.subjectID(end-1:end)),'S',num2str(subj.sess),'B',num2str(randomization_run.block_id(start_block))]; % Save file name to a variable
        end
        % Print some text in Matlab's Command Window if file name is longer than 8 characters
        if length(edfFile) > 8
            fprintf('Filename needs to be no more than 8 characters long (letters, numbers and underscores only)\n');
            error('Filename needs to be no more than 8 characters long (letters, numbers and underscores only)');
        end

        % Open an EDF file and name it
        failOpen = Eyelink('OpenFile', edfFile);
        if failOpen ~= 0 % Abort if it fails to open
            fprintf('Cannot create EDF file %s', edfFile); % Print some text in Matlab's Command Window
            error('Cannot create EDF file %s', edfFile); % Print some text in Matlab's Command Window
        end

        % Get EyeLink tracker and software version
        % <ver> returns 0 if not connected
        % <versionstring> returns 'EYELINK I', 'EYELINK II x.xx', 'EYELINK CL x.xx' where 'x.xx' is the software version
        ELsoftwareVersion = 0; % Default EyeLink version in dummy mode
        [ver, versionstring] = Eyelink('GetTrackerVersion');
        if dummymode == 0 % If connected to EyeLink
            % Extract software version number.
            [r1 vnumcell] = regexp(versionstring,'.*?(\d)\.\d*?','Match','Tokens'); % Extract EL version before decimal point
            ELsoftwareVersion = str2double(vnumcell{1}{1}); % Returns 1 for EyeLink I, 2 for EyeLink II, 3/4 for EyeLink 1K, 5 for EyeLink 1KPlus, 6 for Portable Duo
            % Print some text in Matlab's Command Window
            fprintf('Running experiment on %s version %d\n', versionstring, ver );
        end

        % Add a line of text in the EDF file to identify the current experimemt name and session. This is optional.
        % If your text starts with "RECORDED BY " it will be available in DataViewer's Inspector window by clicking
        % the EDF session node in the top panel and looking for the "Recorded By:" field in the bottom panel of the Inspector.
        preambleText = sprintf('RECORDED BY Psychtoolbox taVNS optimization %s session name: %s', subj.id, subj.sess);
        Eyelink('Command', 'add_file_preamble_text "%s"', preambleText);


        %% STEP 2: SELECT AVAILABLE SAMPLE/EVENT DATA
        % See EyeLinkProgrammers Guide manual > Useful EyeLink Commands > File Data Control & Link Data Control


        % Select which events are saved in the EDF file. Include everything just in case
        Eyelink('Command', 'file_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT');
        % Select which events are available online for gaze-contingent experiments. Include everything just in case
        % I guess the online one is what we could write directly into the .mat
        % file (event or sample data)
        Eyelink('Command', 'link_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,BUTTON,FIXUPDATE,INPUT');
        % Select which sample data is saved in EDF file or available online. Include everything just in case
        Eyelink('Command', 'file_sample_data  = LEFT,RIGHT,GAZE,HREF,RAW,AREA,GAZERES,BUTTON,STATUS,INPUT');
        Eyelink('Command', 'link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,STATUS,INPUT');

        %% STEP 3: OPEN GRAPHICS WINDOW

        % Open experiment graphics on the specified screen
        if isempty(screenNumber)
            screenNumber = max(Screen('Screens')); % Use default screen if none specified
        end
        window = Screen('OpenWindow', screenNumber, [128 128 128]); % Open graphics window
        Screen('Flip', window);
        % Return width and height of the graphics window/screen in pixels
        [width, height] = Screen('WindowSize', window);


        %% STEP 4: SET CALIBRATION SCREEN COLOURS/SOUNDS; PROVIDE WINDOW SIZE TO EYELINK HOST & DATAVIEWER; SET CALIBRATION PARAMETERS; CALIBRATE

        % Provide EyeLink with some defaults, which are returned in the structure "el".
        el = EyelinkInitDefaults(window);
        % set calibration/validation/drift-check(or drift-correct) size as well as background and target colors.
        % It is important that this background colour is similar to that of the stimuli to prevent large luminance-based
        % pupil size changes (which can cause a drift in the eye movement data)
        el.calibrationtargetsize = 3;% Outer target size as percentage of the screen
        el.calibrationtargetwidth = 0.7;% Inner target size as percentage of the screen
        el.backgroundcolour = [128 128 128];% RGB grey
        el.calibrationtargetcolour = [0 0 0];% RGB black
        % set "Camera Setup" instructions text colour so it is different from background colour
        el.msgfontcolour = [0 0 0];% RGB black

        % Use an image file instead of the default calibration bull's eye targets.
        % Commenting out the following two lines will use default targets:
        el.calTargetType = 'image';
        el.calImageTargetFilename = [pwd '/' 'fixTarget.jpg'];

        % Set calibration beeps (0 = sound off, 1 = sound on)
        el.targetbeep = 0;  % sound a beep when a target is presented
        el.feedbackbeep = 0;  % sound a beep after calibration or drift check/correction

        % You must call this function to apply the changes made to the el structure above
        EyelinkUpdateDefaults(el);

        % Set display coordinates for EyeLink data by entering left, top, right and bottom coordinates in screen pixels
        Eyelink('Command','screen_pixel_coords = %ld %ld %ld %ld', 0, 0, width-1, height-1);
        % Write DISPLAY_COORDS message to EDF file: sets display coordinates in DataViewer
        % See DataViewer manual section: Protocol for EyeLink Data to Viewer Integration > Pre-trial Message Commands
        Eyelink('Message', 'DISPLAY_COORDS %ld %ld %ld %ld', 0, 0, width-1, height-1);
        % Set number of calibration/validation dots and spread: horizontal-only(H) or horizontal-vertical(HV) as H3, HV3, HV5, HV9 or HV13
        Eyelink('Command', 'calibration_type = HV9'); % horizontal-vertical 9-points
        % Allow a supported EyeLink Host PC button box to accept calibration or drift-check/correction targets via button 5
        Eyelink('Command', 'button_function 5 "accept_target_fixation"');
        % Hide mouse cursor
        HideCursor(screenNumber);
        % Start listening for keyboard input. Suppress keypresses to Matlab windows.
        ListenChar(-1);
        Eyelink('Command', 'clear_screen 0'); % Clear Host PC display from any previus drawing
        % Put EyeLink Host PC in Camera Setup mode for participant setup/calibration
        EyelinkDoTrackerSetup(el);


    end
end



%%  Set task parameters

   
timing.feedback_delay = 0.20; %for scales
timing.max_dur_rating = 30; %after the specified seconds, the rating screen will terminate

% Display settings
color_scale_background = color.white; %white
color_scale_background_grey = color.grey; %gray
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



if setup.do_fullscreen == 1
    [w,wRect] = Screen(screenNumber,'OpenWindow',color_scale_background_grey);
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


%% Create output.data
% What should be in it: 
% trial wise ID, session, stim, stim_length, stim_freq, rating,
% (Amplitude?)
if start_block ==1
output.data_mat = array2table(zeros(0,14));

output.data_mat.Properties.VariableNames = {'ID','session','run','block', ...
           'stim','stim_on','stim_off','stim_length_empirical', 'stim_length_theoretical', 'stim_freq','stim_amplitude','rating','rating_subm', 'RT'};
end

%load input device

load('JoystickSpecification.mat');
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
input_type = 1; % variable needed in VAS and LHS scale scripts to index Joystick (vs. Mouse)
findJoystick



%% Show instructions on screen
Screen('TextSize',w,28);
Screen('TextFont',w,'Arial');


[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, setup.instruction.text_p1.(setup.lang), 'center', 'center', [0 0 0], 150);


[~, ~] = Screen('Flip', w, []);

while Joystick.Button(1) ~= 1
    [Joystick.X,Joystick.Y,Joystick.Z,Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(3)

%% ========================================================================
% ================== start of the experiment ==============================
% =========================================================================

 



  fixation = '+';
  Screen('TextSize',w,96);
  DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);

  [ons_resp, starttime] = Screen('Flip', w);


     
%setup some of the http requests

body_automaticSwitch = matlab.net.http.MessageBody('automaticSwitch');
body_manualSwitch = matlab.net.http.MessageBody('manualSwitch');


body_treatmenton = matlab.net.http.MessageBody('startTreatment');
body_treatmentoff = matlab.net.http.MessageBody('stopTreatment');
body_stimulationon = matlab.net.http.MessageBody('startStimulation');
body_stimulationoff = matlab.net.http.MessageBody('stopStimulation');

method = matlab.net.http.RequestMethod.POST;

request_automaticSwitch = matlab.net.http.RequestMessage(method,[],body_automaticSwitch);
request_manualSwitch = matlab.net.http.RequestMessage(method,[],body_manualSwitch);
request_treatmenton = matlab.net.http.RequestMessage(method,[],body_treatmenton);
request_treatmentoff = matlab.net.http.RequestMessage(method,[],body_treatmentoff);
request_stimulationon = matlab.net.http.RequestMessage(method,[],body_stimulationon);
request_stimulationoff = matlab.net.http.RequestMessage(method,[],body_stimulationoff);



% loop through stimulation blocks (only necessary if we can let it run
% through the experiment and restart the taVNS manager

amplitude=str2double(subj.stim_amplitude);


% the other code also has drift correction
if start_block == 1
    count_trial = 1;
else
    count_trial = length(output.data_mat.ID) +1;
end
for i_block = start_block:length(setup.randomization.block_id(setup.randomization.run_id==subj.run)) 


    if i_block == 1

        if do_eyetracking == 1
            if do_eyelink == 0
                % Start eyetracking
                EThndl.buffer.start('gaze');
                WaitSecs(2.8);   % wait for eye tracker to start and gaze to be picked up

                % send message into ET data file
                timestamps.exp_on = GetSecs;
                EThndl.sendMessage('Start of experiment',timestamps.exp_on);
            else

                % Put tracker in idle/offline mode before recording. Eyelink('SetOfflineMode') is recommended
                % however if Eyelink('Command', 'set_idle_mode') is used allow 50ms before recording as shown in the commented code:
                % Eyelink('Command', 'set_idle_mode');% Put tracker in idle/offline mode before recording
                % WaitSecs(0.05); % Allow some time for transition
                Eyelink('SetOfflineMode');% Put tracker in idle/offline mode before recording
                EyelinkDoDriftCorrection(el, round(width/2), round(height/2));

                Eyelink('SetOfflineMode')
                Eyelink('StartRecording'); % Start tracker recording
                WaitSecs(2.5); % Allow some time to record a few samples before presenting first stimulus
            end
        end


        for i_trial = 1:15

            fixation = '+';
            Screen('TextSize',w,96);
            Screen('FillRect',w,color_scale_anchors);
            Screen('TextColor',w,color_scale_background_grey);
            DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), color_scale_background_grey,80);
            [ons_resp, starttime] = Screen('Flip', w);
            if do_eyetracking == 1
                if do_eyelink == 0
                    EThndl.sendMessage(['Start black-',num2str(i_trial)],time_treatment);
                else
                    Eyelink('Message', ['Start black-',num2str(i_trial)] );
                    WaitSecs(0.01);
                end
            end
            WaitSecs(5)


            fixation = '+';
            Screen('TextSize',w,96);
            Screen('FillRect',w,color_scale_background_grey);
            Screen('TextColor',w,color_scale_anchors);
            DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);
            [ons_resp, starttime] = Screen('Flip', w);
            if do_eyetracking == 1
                if do_eyelink == 0
                    EThndl.sendMessage(['Start light-',num2str(i_trial)] ,time_treatment);
                else
                    Eyelink('Message', ['Start light-',num2str(i_trial)] );
                    WaitSecs(0.01);
                end
            end
            WaitSecs(7)

        end

        if do_eyetracking == 1 && do_eyelink ==1
            Eyelink('Message', ['End light test']);
            WaitSecs(0.1); % Add 100 msec of data to catch final events before stopping
            Eyelink('StopRecording');
        end
    end



    %read out settings for this block
    if manual == 1
        stim_length = randomization_run.Stim_length(i_block) - .21; %substract average time bluetooth signal needs (if nothing else is running in the background!!)
    else
        stim_length = randomization_run.Stim_length(i_block);
    end
    freq = randomization_run.frequency(i_block);

    if manual == 1
        body_settings =  matlab.net.http.MessageBody(['minIntensity=100&maxIntensity=5000&impulseDuration=400&frequency=',num2str(freq),'&stimulationDuration=',num2str(20),'&pauseDuration=',num2str(25)]);
    else
        body_settings =  matlab.net.http.MessageBody(['minIntensity=100&maxIntensity=5000&impulseDuration=400&frequency=',num2str(freq),'&stimulationDuration=',num2str(stim_length),'&pauseDuration=',num2str(25-stim_length)]);
    
    end
    request_settings = matlab.net.http.RequestMessage(method,[],body_settings);
    
    body_stimamplitude = matlab.net.http.MessageBody(['intensity ',num2str(amplitude)]); 
    request_stimamplitude = matlab.net.http.RequestMessage(method,[],body_stimamplitude);
   




  % Still show fixation cross while waiting for manual trigger (taVNS settings
  % completed taVNS manager startet


  MR_timings.on_trigger_loop = GetSecs;
  KbQueueCreate();
  KbQueueFlush();
  KbQueueStart();
  [b,c] = KbQueueCheck;
  count_trigger = 0;
  disp(['Make sure that the frequency settings are set to ',num2str(randomization_run.frequency(i_block)),'and taVNS manager reconnected?\n Press 5'])

  while c(keyQuit) == 0
      [b,c] = KbQueueCheck;
      if c(keyTrigger) || c(keyTrigger2) > 0
          count_trigger                           = count_trigger + 1;
          MR_timings.trigger.all(count_trigger,1) = GetSecs;
          if count_trigger == 1
              disp(['Are sure that the frequency settings are set to ',num2str(randomization_run.frequency(i_block)),'and taVNS manager reconnected?\n Press 5 again'])
          end
          if count_trigger == 2
              timings.startblock(i_block) = GetSecs;
              break
          end
      end
  end
  HideCursor()
  disp(['Start Block: ',num2str(i_block)])
  %start Treament with the tVNS manager
  if manual == 1
      [r,~,~] = send(request_manualSwitch,'http://localhost:51523/tvnsmanager/');
  else
      [r,~,~] = send(request_automaticSwitch,'http://localhost:51523/tvnsmanager/');
  end
  [r,~,~] = send(request_settings,'http://localhost:51523/tvnsmanager/');
  [r,~,~] = send(request_stimamplitude,'http://localhost:51523/tvnsmanager/');  
  
  if manual == 1 %in the manual condition treatment has to be started and turned off before each individual stimulation can be started. In the automatic only the treatment has to be started an length is set there
      [r,~,~] = send(request_treatmenton,'http://localhost:51523/tvnsmanager/');
      %stop stimulation
      [r,~,~] = send(request_stimulationoff,'http://localhost:51523/tvnsmanager/');
      WaitSecs(16) %because there is a very short stimulation when treatment is turned on


  

      time_treatment = GetSecs;

  end

   %Record eyetracking for every block separately, in case we have to
    %restart the experiment
    if do_eyetracking == 1 
        if do_eyelink == 0
        % Start eyetracking
        EThndl.buffer.start('gaze');
        WaitSecs(2.8);   % wait for eye tracker to start and gaze to be picked up

        % send message into ET data file
        timestamps.exp_on = GetSecs;
        EThndl.sendMessage('Start of experiment',timestamps.exp_on);
        else

        % Put tracker in idle/offline mode before recording. Eyelink('SetOfflineMode') is recommended 
        % however if Eyelink('Command', 'set_idle_mode') is used allow 50ms before recording as shown in the commented code:        
        % Eyelink('Command', 'set_idle_mode');% Put tracker in idle/offline mode before recording
        % WaitSecs(0.05); % Allow some time for transition        
        if i_block > 1
            Eyelink('SetOfflineMode');% Put tracker in idle/offline mode before recording
            EyelinkDoDriftCorrection(el, round(width/2), round(height/2));
        end
    
        Eyelink('SetOfflineMode')
        Eyelink('StartRecording'); % Start tracker recording
        WaitSecs(2.5); % Allow some time to record a few samples before presenting first stimulus
        end 
    end
    
  if do_eyetracking == 1
      if do_eyelink == 0
          EThndl.sendMessage('Start Treatment',time_treatment);
      else
          Eyelink('Message', ['Start Stim block-',num2str(i_block)] );
          WaitSecs(0.01);

      end
  end
  
  % do 12 trials 5s dark followed by 7s light 


  fixation = '+';
  Screen('TextSize',w,96);
  Screen('FillRect',w,color_scale_background_grey);
  DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);

  [ons_resp, starttime] = Screen('Flip', w);

   if setup.n_repetions == 45
        setup.n_repetions = 15;
   end

  for i_trials = 1:setup.n_repetions
        
        %% Start stimulation
        %taVNS Start Stim
        if manual ~=1
            [r,~,~] = send(request_treatmenton,'http://localhost:51523/tvnsmanager/');
        else
            [r,~,~] = send(request_stimulationon,'http://localhost:51523/tvnsmanager/');
        end
        time_stim_on = GetSecs;
        
        if do_eyetracking ==1
            if do_eyelink == 0
                EThndl.sendMessage(['StimON_block-',num2str(i_block),'_trial-',num2str(i_trials)],time_stim_on);
            else
                Eyelink('Message', ['StimON_block-',num2str(i_block),'_trial-',num2str(i_trials)] );
                WaitSecs(0.01);

            end
        end
        
        time_stim_off = GetSecs;
        if manual == 1
            wait_time = stim_length;
        else
            wait_time = stim_length + 2; %Stimulation ends automatically, end treatment a few seconds after
        end

        while time_stim_off - time_stim_on < wait_time
                time_stim_off = GetSecs;
        end

        %taVNS Manager End Stim
        if manual ~= 1 %automatic end treatment directly to make sure that it does not run longer / break
            [r,~,~] = send(request_treatmentoff,'http://localhost:51523/tvnsmanager/');
            %       else
        end

        if manual == 1
            [r,~,~] = send(request_stimulationoff,'http://localhost:51523/tvnsmanager/');
            time_stim_off = GetSecs; %get actual time stimulation was off

            if setup.do_eyetracking ==1
                if do_eyelink == 0
                EThndl.sendMessage(['StimOFF_block-',num2str(i_block),'_trial-',num2str(i_trials)],time_stim_off);
                else
                    Eyelink('Message', ['StimOFF_block-',num2str(i_block),'_trial-',num2str(i_trials)] );
                    WaitSecs(0.01);

                end
            end 
        end
        time_now = GetSecs;
        
        %add info to output
        output.data_mat.ID(count_trial) = str2double(subj.subjectID);
        output.data_mat.session(count_trial) = str2double(subj.sessionID);
        output.data_mat.block(count_trial) = i_block;
        output.data_mat.stim(count_trial) = str2double(subj.stim);
        output.data_mat.stim_on(count_trial) = time_stim_on;
        if manual == 1
            output.data_mat.stim_off(count_trial) = time_stim_off;
            output.data_mat.stim_length_empirical(count_trial) = time_stim_off - time_stim_on; %measured not theoretical ;-)
        end
        output.data_mat.stim_length_theoretical(count_trial) = stim_length;
        output.data_mat.stim_freq(count_trial) = freq;
        output.data_mat.stim_amplitude(count_trial) = str2double(subj.stim_amplitude);
        output.data_mat.run(count_trial) = subj.run;

        while time_now - time_stim_on < setup.trial_length %might be stim_length + trial_length
                time_now = GetSecs;
        end

        count_trial = count_trial + 1;
       
  end
  if manual == 1
      %stop treatment
      [r,~,~] = send(request_treatmentoff,'http://localhost:51523/tvnsmanager/');
  end
  if do_eyetracking == 1 && do_eyelink ==1
      Eyelink('Message', ['End block',num2str(i_block)] );
      WaitSecs(0.1); % Add 100 msec of data to catch final events before stopping
      Eyelink('StopRecording'); 
  end
  disp(['End Block: ',num2str(i_block)])
  disp('Click on the screen / matlab window so that the participant can answer')
  
  %% Show rating scale
  %Intensity for the last block (all trials with the same 

  call_scale = 'VAS';

  % Call scales for defined input device
  VAS_horz

  fixation = '+';
  Screen('TextSize',w,96);
  DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);

  [ons_resp, starttime] = Screen('Flip', w);

    
  ShowCursor(); 
  if i_block < length(randomization_run.Stim_length)
  disp(['Change stimulation frequency to: ',num2str(randomization_run.frequency(i_block+1)),' Confirm only when done and taVNS manager reconnected by pressing 5'])
  end
  
  if do_eyetracking == 1
      if do_eyelink == 0
      % stop recording
      if EThndl.buffer.hasStream('eyeImage')
          EThndl.buffer.stop('eyeImage');
      end
      EThndl.buffer.stop('gaze');

      % save data to mat file, adding info about the experiment
      dat = EThndl.collectSessionData();
      dat.expt.winRect = winRect;
      filename = ['Pupil_OpttaVNS_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_R', subj.runID,'_B',num2str(i_block)];
      %    dat.expt.stimDir = stimDir;
      save(EThndl.getFileName(fullfile('data', [filename '.mat']), true),'-struct','dat');
      % NB: if you don't want to add anything to the saved data, you can use
      % EThndl.saveData directly
       else
      Eyelink('Message', ['End rating block',num2str(i_block)] );
      WaitSecs(0.01);
      end

  end

  filename = ['OpttaVNS_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_R', subj.runID, '_temp_', subj.date ];
  save(fullfile('Backup', [filename '.mat']),'output','subj');

end

%last fixation
fixation = '+';
Screen('TextSize',w,96);
DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);

[ons_resp, starttime] = Screen('Flip', w);
timestamps.fix_fin = starttime;
filename = ['OpttaVNS_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_R', subj.runID];




%Save time end of experiment
subj.date_end      = datestr(now);
t_start=datevec(datenum(subj.date_start));
t_end=datevec(datenum(subj.date_end ));
subj.length_exp = etime(t_end, t_start)/60; %length exp in min

% Save output
save(fullfile('data', [filename '.mat']),'output','subj','timestamps');


save(fullfile('Backup', [filename datestr(now,'_yymmdd_HHMM') '.mat']));
 
if do_eyelink && do_eyetracking
    Eyelink('SetOfflineMode'); % Put tracker in idle/offline mode
    Eyelink('Command', 'clear_screen 0'); % Clear Host PC backdrop graphics at the end of the experiment
    WaitSecs(0.5); % Allow some time before closing and transferring file
    Eyelink('CloseFile'); % Close EDF file on Host PC
    % Transfer a copy of the EDF file to Display PC
    transferFile(edfFile,filename, dummymode, el, window, height);
end

ShowCursor();
ListenChar(0);


Screen('CloseAll');
 

function transferFile(edfFile, filename, dummymode,el, window, height)
        try
            if dummymode == 0 % If connected to EyeLink
                % Show 'Receiving data file...' text until file transfer is complete
                Screen('FillRect', window, el.backgroundcolour); % Prepare background on backbuffer
                Screen('DrawText', window, 'Receiving data file...', 5, height-35, 0); % Prepare text
                Screen('Flip', window); % Present text
                fprintf('Receiving data file ''%s.edf''\n', edfFile); % Print some text in Matlab's Command Window
                
                % Transfer EDF file to Host PC
                % [status =] Eyelink('ReceiveFile',['src'], ['dest'], ['dest_is_path'])
                status = Eyelink('ReceiveFile',[],[pwd,filesep,'data_eyelink',filesep,filename,'_',datestr(now,'_yymmdd_HHMM'),'.edf'],0);
                % Optionally uncomment below to change edf file name when a copy is transferred to the Display PC
                % % If <src> is omitted, tracker will send last opened data file.
                % % If <dest> is omitted, creates local file with source file name.
                % % Else, creates file using <dest> as name.  If <dest_is_path> is supplied and non-zero
                % % uses source file name but adds <dest> as directory path.
                % newName = ['Test_',char(datetime('now','TimeZone','local','Format','y_M_d_HH_mm')),'.edf'];                
                % status = Eyelink('ReceiveFile', [], newName, 0);
                
                % Check if EDF file has been transferred successfully and print file size in Matlab's Command Window
                if status > 0
                    fprintf('EDF file size: %.1f KB\n', status/1024); % Divide file size by 1024 to convert bytes to KB
                end
                % Print transferred EDF file path in Matlab's Command Window
                fprintf('Data file ''%s.edf'' can be found in ''%s''\n', edfFile, pwd);
            else
                fprintf('No EDF file saved in Dummy mode\n');
            end
        catch % Catch a file-transfer error and print some text in Matlab's Command Window
            fprintf('Problem receiving data file ''%s''\n', edfFile);
            psychrethrow(psychlasterror);
        end
    end
