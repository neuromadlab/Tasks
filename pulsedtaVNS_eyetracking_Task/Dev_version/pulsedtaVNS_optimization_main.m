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

if 7~=exist('./Data','dir')
	mkdir('./Data')
end

%% General settings:
subj.version = 1; %Task version
output.version = subj.version;
subj.study = 'BON002'; % Enter here current study name
subj.subjectID = input('Subject ID: ','s');
subj.subjectID = pad(subj.subjectID,6,"left",'0');
subj.sessionID = input('Session ID: ','s');
subj.stim_amplitude = input('Stimulation intensity [mA]: ','s');


subj.runID = input('Run ID: ','s');

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
    first_block = input('Which block do you want to start? [1-12] ','s');
    start_block = str2double(first_block);
    while start_block < 1 || start_block > 12
        first_block = input('Which block do you want to start? [1-12] ','s');
        start_block = str2double(first_block);
    end
    %load previous backup data (latest backup file)
    Backups = dir(['Backup\OpttaVNS*',subj.subjectID,'_S',subj.sessionID,'_R',subj.runID,'*']);
    name_file = [Backups(end).folder,filesep,Backups(end).name];
    load(name_file,'output')
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

randomization_run = setup.randomization(setup.randomization.run_id==subj.run,:);

disp(['For the first block, set the frequency to: ' num2str(randomization_run.frequency(1)) ' then start the taVNS manager and connect the device']);

subj.date_start      = datestr(now);
subj.date      = datestr(now, 'yyyymmdd-HHMM');

% Get operating system and set OS flags
system_info = Screen('Computer');
windows = system_info.windows;
mac = system_info.osx;
linux = system_info.linux;   



% Screen settings
screens = Screen('Screens'); %Define display screen
screenNumber = max(screens);

% Automatic operating information
Screen('Preference', 'SkipSyncTests', 1);



do_eyetracking = setup.do_eyetracking;

if do_eyetracking == 1
% Set up Eyetracking Toby (or eyelink)
DEBUGlevel              = 0;
fixClrs                 = [0 255];
bgClr                   = 127;
useAnimatedCalibration  = true;
doBimonocularCalibration= false;

    % get setup struct (can edit that of course):
    settings = Titta.getDefaults('Tobii Pro Spectrum');
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
        tobii.calVal{1}         = EThndl.calibrate(wpnt);
    end
    ListenChar(0);
    
    %end setup
end    

%%  Set task parameters

   
timing.feedback_delay = 0.20; %for scales
timing.max_dur_rating = 30; %after the specified seconds, the rating screen will terminate

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



if setup.do_fullscreen == 1
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


%% Create output.data
% What should be in it: 
% trial wise ID, session, stim, stim_length, stim_freq, rating,
% (Amplitude?)
output.data_mat = array2table(zeros(0,14));

output.data_mat.Properties.VariableNames = {'ID','session','run','block', ...
           'stim','stim_on','stim_off','stim_length_empirical', 'stim_length_theoretical', 'stim_freq','stim_amplitude','rating','rating_subm', 'RT'};
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
  Screen('TextSize',w,64);
  DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);

  [ons_resp, starttime] = Screen('Flip', w);


if setup.do_eyetracking == 1
% Start eyetracking
EThndl.buffer.start('gaze');
WaitSecs(.8);   % wait for eye tracker to start and gaze to be picked up

% send message into ET data file
timestamps.exp_on = GetSecs;
EThndl.sendMessage('Start of experiment',timestamps.exp_on);
end
     
%setup some of the http requests

body_initialise = matlab.net.http.MessageBody('initialise');

body_treatmenton = matlab.net.http.MessageBody('startTreatment');
body_treatmentoff = matlab.net.http.MessageBody('stopTreatment');
body_stimulationon = matlab.net.http.MessageBody('startStimulation');
body_stimulationoff = matlab.net.http.MessageBody('stopStimulation');

method = matlab.net.http.RequestMethod.POST;

request_initialise = matlab.net.http.RequestMessage(method,[],body_initialise);
request_treatmenton = matlab.net.http.RequestMessage(method,[],body_treatmenton);
request_treatmentoff = matlab.net.http.RequestMessage(method,[],body_treatmentoff);
request_stimulationon = matlab.net.http.RequestMessage(method,[],body_stimulationon);
request_stimulationoff = matlab.net.http.RequestMessage(method,[],body_stimulationoff);



% loop through stimulation blocks (only necessary if we can let it run
% through the experiment and restart the taVNS manager



count_trial = 1;
for i_block = start_block:length(setup.randomization.block_id(setup.randomization.run_id==subj.run))
    
  %read out stimulation length for this block
  stim_length = randomization_run.Stim_length(i_block) - .21; %substract average time bluetooth signal needs (if nothing else is running in the background!!)

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

  [r,~,~] = send(request_initialise,'http://localhost:51523/tvnsmanager/');    
  [r,~,~] = send(request_treatmenton,'http://localhost:51523/tvnsmanager/');
  %stop stimulation
  [r,~,~] = send(request_stimulationoff,'http://localhost:51523/tvnsmanager/');
  WaitSecs(20) %because there is a very short stimulation when treatment is turned on

  time_treatment = GetSecs;
  if do_eyetracking == 1
  EThndl.sendMessage('Start Treatment',time_treatment);
  end
  


  fixation = '+';
  Screen('TextSize',w,64);
  DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);

  [ons_resp, starttime] = Screen('Flip', w);

  for i_trials = 1:setup.n_repetions
        
        %% Start stimulation
        %taVNS Start Stim
        [r,~,~] = send(request_stimulationon,'http://localhost:51523/tvnsmanager/');

        time_stim_on = GetSecs;
        
        if setup.do_eyetracking ==1
            EThndl.sendMessage(['StimON_block-',num2str(i_block),'_trial-',num2str(i_trial)],time_stim_on);
        end
        
        time_stim_off = GetSecs;
        while time_stim_off - time_stim_on < stim_length
                time_stim_off = GetSecs;
        end
        
        test_time1(count_trial) = GetSecs;
        %taVNS Manager End Stim
        [r,~,~] = send(request_stimulationoff,'http://localhost:51523/tvnsmanager/');
        test_time2(count_trial) = GetSecs;
        time_stim_off = GetSecs; %get actual time stimulation was off

        if setup.do_eyetracking ==1
            EThndl.sendMessage(['StimOFF_block-',num2str(i_block),'_trial-',num2str(i_trial)],time_now);
        end
        
        time_now = GetSecs;
        
        %add info to output
        output.data_mat.ID(count_trial) = str2double(subj.subjectID);
        output.data_mat.session(count_trial) = str2double(subj.sessionID);
        output.data_mat.block(count_trial) = i_block;
        output.data_mat.stim(count_trial) = str2double(subj.stim);
        output.data_mat.stim_on(count_trial) = time_stim_on;
        output.data_mat.stim_off(count_trial) = time_stim_off;
        output.data_mat.stim_length_empirical(count_trial) = time_stim_off - time_stim_on; %measured not theoretical ;-)
        output.data_mat.stim_length_theoretical(count_trial) = stim_length;
        output.data_mat.stim_freq(count_trial) = setup.randomization.frequency(i_block);
        output.data_mat.stim_amplitude(count_trial) = str2double(subj.stim_amplitude);
        output.data_mat.run(count_trial) = subj.run;

        while time_now - time_stim_on < setup.trial_length %might be stim_length + trial_length
                time_now = GetSecs;
        end

        count_trial = count_trial + 1;
       
  end
  %stop treatment
  [r,~,~] = send(request_treatmentoff,'http://localhost:51523/tvnsmanager/');
  disp(['End Block: ',num2str(i_block)])
  
  %% Show rating scale
  %Intensity for the last block (all trials with the same 

  call_scale = 'VAS';

  % Call scales for defined input device
  VAS_horz

  fixation = '+';
  Screen('TextSize',w,64);
  DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);

  [ons_resp, starttime] = Screen('Flip', w);

    
  ShowCursor(); 
  if i_block < length(randomization_run.Stim_length)
  disp(['Change stimulation frequency to: ',num2str(randomization_run.frequency(i_block+1)),' Confirm only when done and taVNS manager reconnected by pressing 5'])
  end

  filename = ['OpttaVNS_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_R', subj.runID, '_temp_', subj.date ];
  save(fullfile('Backup', [filename '.mat']),'output','subj');

end

%last fixation
fixation = '+';
Screen('TextSize',w,64);
DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);

[ons_resp, starttime] = Screen('Flip', w);
timestamps.fix_fin = starttime;


if setup.do_eyetracking == 1
    % stop recording
    if EThndl.buffer.hasStream('eyeImage')
        EThndl.buffer.stop('eyeImage');
    end
    EThndl.buffer.stop('gaze');

    % save data to mat file, adding info about the experiment
    dat = EThndl.collectSessionData();
    dat.expt.winRect = winRect;
    dat.expt.stimDir = stimDir;
    save(EThndl.getFileName(fullfile(cd,'t'), true),'-struct','dat');
    % NB: if you don't want to add anything to the saved data, you can use
    % EThndl.saveData directly

    % shut down
    EThndl.deInit();

end

%Save time end of experiment
subj.date_end      = datestr(now);
t_start=datevec(datenum(subj.date_start));
t_end=datevec(datenum(subj.date_end ));
subj.length_exp = etime(t_end, t_start)/60; %length exp in min

% Save output
filename = ['OpttaVNS_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_R', subj.runID];
if settings.do_fmri == 0
    save(fullfile('Data', [filename '.mat']),'output','subj','timestamps');
else
    save(fullfile('Data', [filename '.mat']),'output','subj','input_device','timestamps','MR_timings');
end

save(fullfile('Backup', [filename datestr(now,'_yymmdd_HHMM') '.mat']));

ShowCursor();

Screen('CloseAll');
 
