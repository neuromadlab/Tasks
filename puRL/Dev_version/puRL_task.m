function puRL_task
try
study   = 'BON002';
task    = 'puRL'; % pulsed Reward Learning
version = '1.2.0';

% Author: Paul Jung
% Mail  : jung.science@web.de
% Author: Anne Kühnel
% Date  : 08.08.2024
%
% This script presents cues while the participant is stimulated with tVNS
% Refer to .\Docs for further information
%--------------------------------------------------------------------------

% set some preferences:
doDebug     = 1;    % 1 for debugging - smaller window etc., 0 else
doJoystick  = 0;    % 1 for yes we are using a joystick, 0 else
doScanner   = 0;    % 1 for yes we are inside the scanner, 0 else
doTVNS      = 0;    % 1 for yes we use tVNS, 0 else
doTTL       = 0;    % 1 for yes we send trigger pulses to Biopac
doEyelink   = 0;    % 1 for yes we eyetrack with Eyelink 100
[~] = Screen('Preference', 'SkipSyncTests', 1); % 1 if encountering errors

%%% general preparations
ptb = [];       % for script-wide variable handling
con = [];       % alias for condition-file data
output = [];    % the common output structure
subj = [];      % the common subj structure
generalPreparations();      % init variables, etc.
dispPrefs();                % disp the preferences to the experimenter
subjQuery();                % get infos about subject & session
fileNdevicePreparations();  % use subj-info to prepare files & devices

%%% start the session
startPsychtoolbox()
showInstruction()

%%% begin block & trial loop
for block_i = 1:length(con.blocks)
    announceBlock(block_i);

    for trial_i = 1:length(con.blocks(block_i).trials)
        ptb.trialC = ptb.trialC+1;              % set global trial counter
        ptb.trial = ptb.block.trials(trial_i);  % recopy trial
        disp(['Trial ' num2str(trial_i)])       % info for experimenter
    
        showFixation()
        showCue()
        showResponse()
        showISI()
        showResult()

        saveTempfile()
    end % of trial loop

    showIBI(block_i);
end % of block loop
ptb.trialC = 0; % reset global trial counter

%%% end of session
showGlobalOutcome()
saveNclean();

catch ME % in case of error, copy all vars to base workspace for inspection
    VARS = who;
    for iV = 1:length(VARS)
        assignin('base', VARS{iV}, eval(VARS{iV}) ) % copy one var to base
    end
    warning('variables send to base workspace!')
    saveNclean(); % ! throws an error itself if subjQuery() not finished
    rethrow(ME)
end

%--------------------------------------------------------------------------
% end of main code, start of nested helperfunctions
%--------------------------------------------------------------------------

function generalPreparations
% This function prepares variables (ptb), recopies vars (output), prepares
% folder for data storage and prepares devices.
initVarsNfolders();

if doScanner    % add info about the trajectories table to output
    output.forceTrajectLabels = ['trialNumber', 'onset', 'left', 'right'];
end

if doJoystick % load specification for joystick
    addpath([ptb.supplPath 'Joystick\'])
    load('JoystickSpecification.mat', 'JoystickSpecification');
    
    ptb.joySpec = JoystickSpecification;    % for easier access
    ptb.joySpec = findJoystick(ptb.joySpec);% update handle
    output.joySpec = ptb.joySpec;           % for later evaluation

    % add info about the trajectories table to output
    output.forceTrajectLabels = ['trialNumber', 'onset', 'mapping'];
end

if doTVNS   % prepare several variables for communication with tVNS
    bAutoSwitch = matlab.net.http.MessageBody('automaticSwitch');
    bTreatOn = matlab.net.http.MessageBody('startTreatment');
    bTreatOff = matlab.net.http.MessageBody('stopTreatment');
    method = matlab.net.http.RequestMethod.POST;
    ptb.reqAutoSwitch = matlab.net.http.RequestMessage(method,[],bAutoSwitch);
    ptb.reqTreatOn = matlab.net.http.RequestMessage(method,[],bTreatOn);
    ptb.reqTreatOff = matlab.net.http.RequestMessage(method,[],bTreatOff);
    ptb.tvnsURL = 'http://localhost:51523/tvnsmanager/';
end

if doTTL    % init TTL box
    addpath([ptb.supplPath 'TTL\'])
    comX = 'COM7';  % COM-7 for L&B, COM3 for behavioural testing laptop
    trigDur = 0.005;% duration for sending triggers in seconds
    prepareTTL(comX, 115200, trigDur);
end

if doEyelink
    initEyetracker();
end
end % ---------------------------------------------------------------------


function initVarsNfolders
rng('shuffle'); % take care for real random numbers

ptb.gReward = 0;    % global reward
ptb.trialC = 0;     % global trial counter
ptb.blockC = 0;     % global block counter
ptb.doTraining = -1; % flag to indicate a training(1) or normal(0) run

output.log = [];            % for logging events outside the trial loop
output.dataMat = [];        % for logging row-wise inside the trial loop
output.forceTraject = [];   % for logging joystick / GFD trajectories
output.dateStart = char(datetime('now', 'Format','yyMMdd_HHmm'));
output.dateStartSec = GetSecs;
output.system = Screen('Computer');   % pc-specs
output.studyID = study;
output.task = task;
output.version = version;
output.doDebug = doDebug;
output.doJoystick = doJoystick;
output.doScanner = doScanner;
output.doTVNS = doTVNS;
output.doTTL = doTTL;
output.doEyelink = doEyelink;

% prepare key settings
KbName('UnifyKeyNames');
keys.escape = KbName('ESCAPE');     % used for abortCheck()
keys.left = KbName('LeftArrow');    % for fallback control, if nothing...
keys.right = KbName('RightArrow');  % ... else is used
ptb.keys = keys;

output.savePath = '.\data'; % to store the collected data in
if 7 ~= exist(output.savePath,'dir')
	mkdir(output.savePath)
end

output.backupPath = '.\backup'; % to backup the collected data in
if 7 ~= exist(output.backupPath,'dir')
	mkdir(output.backupPath)
end

ptb.supplPath = '.\supplementaryFiles\';
addpath(ptb.supplPath);
jitterPath = [ptb.supplPath 'jitters\'];

% load jitters for Fixation, global trial counter will be used as counter
jitterFilename = [pwd jitterPath 'DelayJitter_mu_3_max_12_trials_96.mat'];
load( jitterFilename, 'DelayJitter');
ptb.jitterFix = Shuffle(DelayJitter);

% load jitters for ISI, global trial counter will be used as counter
jitterFilename = [pwd jitterPath 'DelayJitter_mu_2_max_4_trials_96.mat'];
load( jitterFilename, 'DelayJitter');
ptb.jitterISI = Shuffle(DelayJitter);
end % ---------------------------------------------------------------------


function initEyetracker
%%% Step 1: init eyelink connection, get eyelink version data

ptb.dummymode = 0; % 0: with Eyelink connection, 1: without connection
EyelinkInit(ptb.dummymode); % Initialize EyeLink connection
status = Eyelink('IsConnected');
output.elStatus = status;
if status < 1       % If EyeLink not connected...
    ptb.dummymode = 1;  % ... use the dummy mode
    fprintf(2, 'Attention, status of eyetracker not ok, using dummy mode!')
end

% Get EyeLink tracker and software version
% <ver> returns 0 if not connected
% <versionstring> returns 'EYELINK I', 'EYELINK II x.xx', 
% 'EYELINK CL x.xx' where 'x.xx' is the software version
output.ELsoftwareVersion = 0; % Default EyeLink version in dummy mode
[ver, versionstring] = Eyelink('GetTrackerVersion');

if ptb.dummymode == 0 % If connected to EyeLink extract software version
    % Extract EL version before decimal point
    [~,vnumcell]=regexp(versionstring, '.*?(\d)\.\d*?', 'Match','Tokens');

    % Returns 1 for EyeLink I, 2 for EyeLink II, 3/4 for EyeLink 1K, 
    % 5 for EyeLink 1KPlus, 6 for Portable Duo
    output.ELsoftwareVersion = str2double(vnumcell{1}{1});

    % Print some text in Matlab's Command Window
    fprintf('Running experiment on %s version %d\n', versionstring, ver );
end

% Add a line of text in the EDF file to identify the current experimemt
% name and session. This is optional. If your text starts with
% "RECORDED BY " it will be available in DataViewer's Inspector window
% by clicking the EDF session node in the top panel and looking for the
% "Recorded By:" field in the bottom panel of the Inspector.
preambleText = sprintf(['RECORDED BY Psychtoolbox' study]);
Eyelink('Command', 'add_file_preamble_text "%s"', preambleText);

%%% Step 2: Select available sample/event data
% See EyeLinkProgrammers Guide manual > Useful EyeLink Commands >
% File Data Control & Link Data Control
% We opt in for every option, just in case.

% Select which events are saved in the EDF file.
Eyelink('Command', ['file_event_filter = LEFT,RIGHT,FIXATION,SACCADE,' ...
    'BLINK,MESSAGE,BUTTON,INPUT']);
% Select which events are available online for gaze-contingent experiments.
% I guess the online one is what we could write directly into the .mat
% file (event or sample data)
Eyelink('Command', ['link_event_filter = LEFT,RIGHT,FIXATION,SACCADE,' ...
    'BLINK,BUTTON,FIXUPDATE,INPUT']);
% Select which sample data is saved in EDF file or available online.
Eyelink('Command', ['file_sample_data  = LEFT,RIGHT,GAZE,HREF,RAW,' ...
    'AREA,GAZERES,BUTTON,STATUS,INPUT']);
Eyelink('Command', ['link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA' ...
    ',STATUS,INPUT']);
end % ---------------------------------------------------------------------


function dispPrefs
% This function displays the preferences on the command window to inform
% the experimenter
disp(' ')
disp(['Study ID        : ' study])
disp(['Task            : ' task])
disp(['Sofware version : ' version])
disp(' ')

disp(['The task flow can be aborted with: ' KbName(ptb.keys.escape)])
disp(' ')

disp('Script assumes :')
if doDebug
    disp('----------------------------------------------------------')
    disp('!! DEBUG MODE !! DEBUG MODE !! DEBUG MODE !! DEBUG MODE !!')
    disp('----------------------------------------------------------')
end
if doJoystick
    disp('We use an joystick')
else
    disp('We do NOT use an joystick')
end
if doScanner
    disp('We are in the scanner')
else
    disp('We are NOT in the scanner')
end
if doTVNS
    disp('We are stimulating with tVNS (excluding training)')
else
    disp('We are NOT stimulating with tVNS')
end
if doTTL
    disp('We are sending trigger to Biopac')
else
    disp('We are NOT sending trigger to Biopac')
end
if doEyelink
    disp('We are using an eyetracker')
else
    disp('We are NOT using an eyetracker')
end
disp(' ')
end % ---------------------------------------------------------------------


function subjQuery
% This function collects some infos about the subject & session
subj.date = char(datetime('now', 'Format','yyMMdd_HHm'));
subj.study = study;
subj.version = version;

disp('Now the experimenter shall input some infos!')
subj.id = input('Subject ID: ');
subj.ids = pad( num2str(subj.id), 6,"left",'0'); % add leading zeros
subj.sess = input('Session ID: ');

% ask for the desired language during the experiment
isGerman = input('Present task in german(1) or english(0)? [1/0]: ');
if isGerman == 1 % german option
    subj.language = 'de';
else % here we determine the fallback language
    subj.language = 'eng';
end

% ask if it is a training run & ask for affected settings
ptb.doTraining = input('Is this a training run(1), or not(0)? [1/0]: ');
if ptb.doTraining
    subj.run = 0; % necessary for logging but not in training
else % no training, real run
    subj.run = input('Run ID    : ');
end

if doTVNS && ~ptb.doTraining    % query tVNS related settings for main task
    subj.stimCond = input('Condition ID, [0=sham / 1=tVNS]: ');
    subj.stimHighAmp = input('High Stimulation intensity [mA]: ', 's');
end
end % ---------------------------------------------------------------------

    
function fileNdevicePreparations
% This function loads the condition file and optionally: loads 
% GripForceDevice specifications, prepares eyetracking file, inits tVNS.

% load condition file for participant todo: do all these files still exist?
% is it still documented correctly?
if ptb.doTraining
    if doScanner    % load condition file for calibration & temp GFD spec
        try
            path = [ptb.supplPath ...
                'ConditionFiles\puRLCal_cond_BON002_' subj.ids '.mat'];
        catch 
            path = [ptb.supplPath 'ConditionFiles\cond_calibration.mat'];
        end
    else            % load condition file for training
        try
            path = [ptb.supplPath ...
                'ConditionFiles\puRLTrain_cond_BON002_' subj.ids '.mat'];
        catch
            path = [ptb.supplPath 'ConditionFiles\cond_training.mat'];
        end
    end

else % no training, real run - path to individual condition file
    path = [ptb.supplPath 'ConditionFiles\puRL_cond_BON002_'...
        subj.ids '_S' num2str(subj.sess) '.mat'];
end

load(path, 'cond'); % load the condition file
output.cond = cond; % recopy it
con = cond;


if doScanner    % load GripForceDevice specifications
    if ptb.doTraining
        path = [ptb.supplPath 'Gripforce\GripforceSpec.mat'];
    else
        path = [ptb.supplPath 'Gripforce\GripforceSpec_' subj.ids ...
            '_S' num2str(subj.sess) '.mat']; 
    end
    load(path, 'GripFSpec' )
    addpath([ptb.supplPath 'Gripforce\'])
    ptb.GripFSpec = GripFSpec;              % for easier access
    ptb.GripFSpec = findJoystick(GripFSpec);% updated handle
    output.GripFSpec = ptb.GripFSpec;       % for later evaluation
end

if doEyelink    % prepare a *.edf file for eyetracking data
    ptb.edfFile = ['P' num2str(subj.id) 'S' num2str(subj.sess)...
        'R' num2str(subj.run)];
        
    % Warn and abort if file name is longer than 8 characters
    if length(ptb.edfFile) > 8
        warndlg('YOU LOOSE');
        warnmsg = ['Filename needs to be no more than 8 characters'
            ' long (letters, numbers and underscores only)\n'];
        error(warnmsg);
    end
    
    % Open an EDF file and name it
    failOpen = Eyelink('OpenFile', ptb.edfFile);
    disp('test')
    if failOpen ~= 0 % Abort if it fails to open
        error('Cannot create EDF file %s', edfFile);
    end
end

if doTVNS && ~ptb.doTraining    % prepare tVNS stimulation for main task
    % init tVNS Manager
    [r1,~,~] = send(ptb.reqAutoSwitch, ptb.tvnsURL);
    if r1.StatusCode ~= matlab.net.http.StatusCode.OK
        error('tVNS init failed')
    end

    % prepare stimulation settings according to condition-file
    method = matlab.net.http.RequestMethod.POST;
    bSettings =  matlab.net.http.MessageBody(...
        ['minIntensity=100&maxIntensity=5000', ...
        '&impulseDuration=400&frequency=',num2str(con.stimFreq),...
        '&stimulationDuration=',num2str(con.stimDur),...
        '&pauseDuration=59']); % pause needs to be longer than trial
    reqSettings = matlab.net.http.RequestMessage( method, [], bSettings);

    [r2,~,~] = send(reqSettings, ptb.tvnsURL);% set stimulation parameters
    if r2.StatusCode ~= matlab.net.http.StatusCode.OK
        Log(GetSecs, 'tVNS setup failed')
        error('tVNS setup failed')
    else
        Log(GetSecs, 'tVNS setup success')
    end
end
end % ---------------------------------------------------------------------


function startPsychtoolbox
% This function makes some preparations & starts psychtoolbox
PsychDefaultSetup(1); % AssertOpenGL, unifies key names
screens = Screen('Screens');    % query the number of available screens,
screenNumber = max(screens);    % the number of the participants screen

color.white = WhiteIndex(screenNumber);
color.grey = color.white / 2;
color.black = BlackIndex(screenNumber);
color.red = [255 0 0];
color.green = [0 255 0];
ptb.color = color;

% show the first screen
if doDebug
   [w,wRect] = Screen('OpenWindow',screenNumber,color.grey,[0 0 1280 720]);
else
    [w,wRect] = Screen('OpenWindow',screenNumber,color.grey, []);
end
ptb.w = w; % the handle of the window to paint to
ptb.wRect = wRect;
ptb.ifi = Screen('GetFlipInterval', w);
output.system.ifi = ptb.ifi;

% load a pic to determine the drawing rectangles
im1 = imread([con.cues.path con.cues.trainingFiles{1}]); % read image data
[cx, cy] = RectCenter(ptb.wRect);   % get center of the screen
x1 = cx-300;                        % shift to the left for left rect
x2 = cx+300;                        % shift to the right for right rect
[s1, s2, ~] = size(im1);            % assume all images have same size
scaRec = [0,0, s2, s1]*0.8;         % scale cues & circles
% shifted & scaled rectangles left & right
ptb.rectL = CenterRectOnPointd(scaRec, x1, cy);
ptb.rectR = CenterRectOnPointd(scaRec, x2, cy);

% prepare background image (texture)
path = [ptb.supplPath 'Pics\background.png'];
im = imread(path);
ptb.bckgrndTex = Screen('MakeTexture', ptb.w, im);

KbQueueCreate()
KbQueueStart(); 

if doEyelink
    setupEyetracker();
end

abortCheck();
end % ---------------------------------------------------------------------


function setupEyetracker
%%% Step 4: setup & calibration

% Provide EyeLink with some defaults in the structure "el".
el = EyelinkInitDefaults(ptb.w);

% set calibration/validation/drift-check(or drift-correct) size as well
% as background and target colors. It is important that this background
% colour is similar to that of the stimuli to prevent large luminance-based
% pupil size changes (which can cause a drift in the eye movement data)
el.calibrationtargetsize = 3; % Outer target size as % of the screen
el.calibrationtargetwidth = 0.7; % Inner target size as % of the screen
el.backgroundcolour = ptb.color.grey; % RGB grey
el.calibrationtargetcolour = ptb.color.black; % RGB black
% set "Camera Setup" instructions text color to differ from background
el.msgfontcolour = ptb.color.black; % RGB black

% Use an image file instead of the default calibration bull's eye targets.
% Commenting out the following two lines will use default targets:
el.calTargetType = 'image';
el.calImageTargetFilename = [ptb.supplPath 'Pics\fixTarget.jpg'];

% apply the changes made to the el structure above
EyelinkUpdateDefaults(el);

width = ptb.wRect(3);   % width of display screen
height = ptb.wRect(4);  % height of display screen
% Set display coordinates for EyeLink data by entering left, top, right
% and bottom coordinates in screen pixels
Eyelink('Command','screen_pixel_coords = %ld %ld %ld %ld', ...
    0, 0, width-1, height-1);
% Write DISPLAY_COORDS message to EDF file: sets display coordinates in 
% DataViewer. See DataViewer manual section: Protocol for EyeLink Data to
% Viewer Integration > Pre-trial Message Commands
Eyelink('Message', 'DISPLAY_COORDS %ld %ld %ld %ld', ...
    0, 0, width-1, height-1);
% Set number of calibration/validation dots and spread: horizontal-only(H)
% or horizontal-vertical(HV) as H3, HV3, HV5, HV9 or HV13
Eyelink('Command', 'calibration_type = HV9');% horizontal-vertical 9-points
% Allow a supported EyeLink Host PC button box to accept calibration or
% drift-check/correction targets via button 5
Eyelink('Command', 'button_function 5 "accept_target_fixation"');
% Start listening for keyboard input. Suppress keypresses to Matlab windows
ListenChar(-1);
% Clear Host PC display from any previus drawing
Eyelink('Command', 'clear_screen 0'); 
% Put EyeLink Host PC in Camera setupmode for participant setup/calibration
EyelinkDoTrackerSetup(el);
ptb.el = el; % as part of the global ptb variable, el is available globaly
end % ---------------------------------------------------------------------


function showInstruction
% This function shows the instructions for the participants (selfpaced) if
% it is a training run, does the GFD calibration & waits for 
% scanner-trigger, if flagged.

if ptb.doTraining % show full instruction before training
    if doScanner

        path = [ptb.supplPath 'Pics\slide_1_MRI_' subj.language '.png'];
        im = imread(path);                          % read in image data
        imTex = Screen('MakeTexture', ptb.w, im);   % create texture
        Screen('DrawTexture', ptb.w, imTex, [], ptb.wRect);

        % show the instruction
        instructionOnset = Screen('Flip', ptb.w, 0, 1);
        Log(instructionOnset, 'Instruction 1 MRI')

        % show until a response, but at least for con.instrDur
        checkForResponse('restart'); % demand a release of the device
        while 1 
            % after instrDur expires, check for a response to proceed
            if GetSecs - instructionOnset > con.instrDur
                [leftSelecting, rightSelecting] = checkForResponse();
                if leftSelecting || rightSelecting % "recognize" selection
                    break;
                end
                WaitSecs(ptb.ifi); % a check at each display refresh
            end
        end
        doCalibration() % of GFD
    end
    
    if ~doScanner
        for i = 1:6
            % load & prepare instruction-pic
            path = [ptb.supplPath 'Pics\slide_' num2str(i) '_'...
                subj.language '.png'];
            im = imread(path);                      % read in image data
            imTex = Screen('MakeTexture', ptb.w, im);   % create texture
            Screen('DrawTexture', ptb.w, imTex, [], ptb.wRect);

            % show the instruction
            instructionOnset = Screen('Flip', ptb.w, 0, 1);
            Log(instructionOnset, ['Instruction ' num2str(i)])

            % show until a response, but at least for con.instrDur
            checkForResponse('restart'); % demand a release of the device
            while 1
                % after instrDur expires, check for a response to proceed
                if GetSecs - instructionOnset > con.instrDur
                    [leftSelecting, rightSelecting] = checkForResponse();
                    if leftSelecting || rightSelecting
                        break;
                    end
                    WaitSecs(ptb.ifi); % a check at each display refresh
                end
            end
        end
   end

else % show just an announcement before main-task
    % load & prepare instruction-pic
    path = [ptb.supplPath 'Pics\slide_2_MRI_' subj.language '.png'];
    im = imread(path);                          % read in image data
    imTex = Screen('MakeTexture', ptb.w, im);   % create texture
    Screen('DrawTexture', ptb.w, imTex, [], ptb.wRect);

    % show the instruction
    instructionOnset = Screen('Flip', ptb.w, 0, 1);
    Log(instructionOnset, 'Instruction 2 MRI')

    % show until a response, but at least for con.instrDur
    checkForResponse('restart'); % demand a release of the device
    while 1
        % after instrDur expires, check for a response to proceed
        if GetSecs - instructionOnset > con.instrDur
            [leftSelecting, rightSelecting] = checkForResponse();
            if leftSelecting || rightSelecting
                break;
            end
            WaitSecs(ptb.ifi); % a check at each display refresh
        end
    end
end

% Send a TTL-signal after first trigger (or just immediately)
if doScanner && ~ptb.doTraining % wait for some MRI-trigger
    Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
    Screen('Textsize', ptb.w, 50);
    DrawFormattedText(ptb.w, txt('waitMRI'), 'center', 'center', ...
        ptb.color.white);
    Screen('Flip', ptb.w);

    MR_timings.on_trigger_loop = GetSecs;
    num = con.dummyVolumes; % number of trigger to wait for
    MR_timings.trigger.all = waitForScannerTrigger( num, ptb.keys.escape);
    MR_timings.trigger.fin = GetSecs;
    output.MR_timings = MR_timings;
elseif doTTL
    sendTTL(con.trigger.start);
end
end % ---------------------------------------------------------------------


function doCalibration
% This function does the calibration for the GFD (Grip-Force-Device) and
% saves the personalized specification.
arcCol = ptb.color.red; % color for arcs and circles
txtCol = ptb.color.white; % color for text
psA = 3;    % PenSize for drawing Arcs
calibDur = 10;   % duration for pressing/calibrating one side
waitDur = 3;    % duration between single calibration steps
Screen('Textsize', ptb.w, 50); % textsize during whole calibration

% the initial Grip-Force-Device specification
GripFSpec.Handle	= 0;
GripFSpec.MinL		= 10000; % minimum value of the left gripforce device
GripFSpec.MaxL		= 0;
GripFSpec.MinR      = 10000; % minimum value of the right gripforce device
GripFSpec.MaxR      = 0;
% GripFDev.X = left; GripFDev.Y = right

% give instruction for next calibration step
Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
DrawFormattedText(ptb.w, txt('pressLeft'), 'center', 'center', txtCol);
Screen('Flip', ptb.w);
WaitSecs(waitDur);

% Calibrate left, first try
localMax = 65535; % a unreachable high max-value
start = GetSecs;
while GetSecs - start < calibDur
    [GripFDev.X, GripFDev.Y] = WinJoystickMex(GripFSpec.Handle);
    Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
    DrawFormattedText(ptb.w, txt('left'), 'center', 'center', txtCol, ...
        [],[],[],[],[], ptb.rectL);
    angle = 360 * GripFDev.X / localMax; % compute angle
    Screen('FrameArc', ptb.w, arcCol, ptb.rectL, 0, angle, psA, psA);
    Screen('Flip', ptb.w);

    if(GripFSpec.MaxL < GripFDev.X) % update the maximum value
	    GripFSpec.MaxL = GripFDev.X;
    end
end
abortCheck();

% give instruction for next calibration step
Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
DrawFormattedText(ptb.w, txt('pressLeft2'), 'center', 'center', txtCol);
Screen('Flip', ptb.w);
WaitSecs(waitDur);

% Calibrate left, second try
localMax = GripFSpec.MaxL * 1.1;
start = GetSecs;
while GetSecs - start < calibDur
    [GripFDev.X, GripFDev.Y] = WinJoystickMex(GripFSpec.Handle);
    Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
    DrawFormattedText(ptb.w, txt('left'), 'center', 'center', txtCol, ...
        [],[],[],[],[], ptb.rectL);
    angle = 360 * GripFDev.X / localMax; % compute angle
    Screen('FrameArc', ptb.w, arcCol, ptb.rectL, 0, angle, psA, psA);
    Screen('Flip', ptb.w);

    if(GripFSpec.MaxL < GripFDev.X) % update the maximum value
	    GripFSpec.MaxL = GripFDev.X;
    end
end
abortCheck();

% give instruction for next calibration step
Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
DrawFormattedText(ptb.w, txt('holdLeft'), 'center', 'center', txtCol, 50);
Screen('Flip', ptb.w);
WaitSecs(waitDur);

% Calibrate min force left
localMax = GripFSpec.MaxL * 1.1;
start = GetSecs;
while GetSecs - start < calibDur
    [GripFDev.X, GripFDev.Y] = WinJoystickMex(GripFSpec.Handle);
    Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
    DrawFormattedText(ptb.w, txt('left'), 'center', 'center', txtCol, ...
        [],[],[],[],[], ptb.rectL);
    angle = 360 * GripFDev.X / localMax; % compute angle
    Screen('FrameArc', ptb.w, arcCol, ptb.rectL, 0, angle, psA, psA);
    Screen('Flip', ptb.w);

    if(GripFSpec.MinL > GripFDev.X) % update the minimum value
	    GripFSpec.MinL = GripFDev.X;
    end
end
abortCheck();

% give instruction for next calibration step
Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
DrawFormattedText(ptb.w, txt('pressRight'), 'center', 'center', txtCol);
Screen('Flip', ptb.w);
WaitSecs(waitDur);

% Calibrate right, first try
localMax = 65535; % a unreachable high max-value
start = GetSecs;
while GetSecs - start < calibDur
    [GripFDev.X, GripFDev.Y] = WinJoystickMex(GripFSpec.Handle);
    Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
    DrawFormattedText(ptb.w, txt('right'), 'center', 'center', txtCol, ...
        [],[],[],[],[], ptb.rectR);
    angle = 360 * GripFDev.Y / localMax; % compute angle
    Screen('FrameArc', ptb.w, arcCol, ptb.rectR, 0, angle, psA, psA);
    Screen('Flip', ptb.w);

    if(GripFSpec.MaxR < GripFDev.Y) % update the maximum value
	    GripFSpec.MaxR = GripFDev.Y;
    end
end
abortCheck();

% give instruction for next calibration step
Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
DrawFormattedText(ptb.w, txt('pressRight2'), 'center', 'center', txtCol);
Screen('Flip', ptb.w);
WaitSecs(waitDur);

% Calibrate right, second try
localMax = GripFSpec.MaxR * 1.1;
start = GetSecs;
while GetSecs - start < calibDur
    [GripFDev.X, GripFDev.Y] = WinJoystickMex(GripFSpec.Handle);
    Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
    DrawFormattedText(ptb.w, txt('right'), 'center', 'center', txtCol, ...
        [],[],[],[],[], ptb.rectR);
    angle = 360 * GripFDev.Y / localMax; % compute angle
    Screen('FrameArc', ptb.w, arcCol, ptb.rectR, 0, angle, psA, psA);
    Screen('Flip', ptb.w);

    if(GripFSpec.MaxR < GripFDev.Y) % update the maximum value
	    GripFSpec.MaxR = GripFDev.Y;
    end
end
abortCheck();

% give instruction for next calibration step
Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
DrawFormattedText(ptb.w, txt('holdRight'), 'center', 'center', txtCol, 50);
Screen('Flip', ptb.w);
WaitSecs(waitDur);

% Calibrate min force right
localMax = GripFSpec.MaxR * 1.1;
start = GetSecs;
while GetSecs - start < calibDur
    [GripFDev.X, GripFDev.Y] = WinJoystickMex(GripFSpec.Handle);
    Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
    DrawFormattedText(ptb.w, txt('right'), 'center', 'center', txtCol, ...
        [],[],[],[],[], ptb.rectR);
    angle = 360 * GripFDev.Y / localMax; % compute angle
    Screen('FrameArc', ptb.w, arcCol, ptb.rectR, 0, angle, psA, psA);
    Screen('Flip', ptb.w);

    if(GripFSpec.MinR > GripFDev.Y) % update the minimum value
	    GripFSpec.MinR = GripFDev.Y;
    end
end

ptb.GripFSpec = GripFSpec;
path = [ptb.supplPath 'Gripforce\GripforceSpec_' subj.ids ...
    '_S',num2str(subj.sess),'.mat'];
save(path, 'GripFSpec')

abortCheck();
end % ---------------------------------------------------------------------


function announceBlock(block_i)
% This function announces the next block and optionally starts eyetracking
disp(['Block ' num2str(block_i) ' is running.']) % info for experimenter
ptb.blockC = block_i; % recopy for easier access for datalogging
ptb.block = con.blocks(block_i);% recopy block for easier use

Screen('Textsize', ptb.w, 50); % prepare announce-text
textColor = ptb.color.white;
Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
DrawFormattedText(ptb.w, txt('newBlock'), 'center','center', textColor);

announceOnset = Screen('Flip', ptb.w);          % start of block announce
Log(announceOnset, 'BlockAnnounceOnset')

if doEyelink 
    % We record eyetracking for every block separately, in case we have
    % to restart the experiment
    startEyetracking(); % could add some extra delay!
end

offset = announceOnset + con.announceDur;
Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
announceOffset = Screen('Flip', ptb.w, offset); % end of block announce
Log(announceOffset, 'BlockAnnounceOffset')

abortCheck();
end % ---------------------------------------------------------------------


function startEyetracking
%%% Step 5 - start recording

width = ptb.wRect(3);   % width of display screen
height = ptb.wRect(4);  % height of display screen
% Put tracker in idle/offline mode before recording. 
% Eyelink('SetOfflineMode') is recommended, however if 
% Eyelink('Command', 'set_idle_mode') is used allow 50ms before 
% recording as shown in the commented code below:
Eyelink('SetOfflineMode');
EyelinkDoDriftCorrection(ptb.el, round(width/2), round(height/2));
% Eyelink('Command', 'set_idle_mode'); 
% WaitSecs(0.05); % Allow some time for transition     

Eyelink('SetOfflineMode')
Eyelink('StartRecording'); % Start tracker recording
% Allow some time to record a few samples prior presenting 1st stimulus
WaitSecs(2.5); % announceDur should be enough

Eyelink('Message', ['Start block-',num2str(block_i)] );
WaitSecs(0.01); % give the eyetracker time to write the message
end % ---------------------------------------------------------------------


function showFixation
% This function shows the fixation prior to the cues

textISI = '+';
Screen('Textsize', ptb.w, 100);
Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
DrawFormattedText(ptb.w, textISI, 'center', 'center', ptb.color.white);
ptb.fixOnset = Screen('Flip', ptb.w); % show text & get a time stamp
LogData('FixationCross', ptb.fixOnset)

abortCheck();
end % ---------------------------------------------------------------------


function showCue()
% This function shows just the cues, before response

% load & prepare pics
path1 = [con.cues.path ptb.trial.cueL]; % composite path
path2 = [con.cues.path ptb.trial.cueR];
[im1, ~, alpha1] = imread(path1);       % read in image data
im1(:,:,4) = alpha1;                    % add the alpha channel
imTex1 = Screen('MakeTexture', ptb.w, im1); % create texture
[im2, ~, alpha2] = imread(path2);
im2(:,:,4) = alpha2;
imTex2 = Screen('MakeTexture', ptb.w, im2);

% Set up alpha-blending for smooth (anti-aliased) lines & use of alpha
Screen('BlendFunction', ptb.w, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
% draw the cues to the backbuffer
Screen('DrawTexture', ptb.w, imTex1, [], ptb.rectL);
Screen('DrawTexture', ptb.w, imTex2, [], ptb.rectR);

% show the prepared cues
cOnset = ptb.fixOnset + con.fixDur + ptb.jitterFix(ptb.trialC);
ptb.cueOnset = Screen('Flip', ptb.w, cOnset, 1); % don't clear framebuffer
LogData('Cue', ptb.cueOnset)

abortCheck();
end % ---------------------------------------------------------------------


function showResponse()
% This function monitors for participants response and acts accordingly.
% In case of response it draws an arc around the selected cue, depending
% on the continuing response. Otherwise it chooses a random side for
% confirmation. In any case, a cue will be surrounded by a confirmation
% circle at the end.

arcCol = ptb.color.red; % color for arcs and circles
psA = 3;    % PenSize for drawing Aarcs (for selection process)
psC = 6;    % PenSize for drawing Circles (for selection confirmation)
angleL = 0; % angle of the left selection arc
angleR = 0; % angle of the right selection arc
incr = 360 * ptb.ifi / con.respDur; % increase of angle
decr = incr;                                % decrease of angle
minSelectionAngle = 270;    % required angle for a valid selection

% create a copy of the cues-display to draw on repeatedly
wCues = Screen('OpenOffscreenwindow', ptb.w);
Screen('CopyWindow', ptb.w, wCues); % wCues holds a fresh copy of the cues

% monitor the response window until it expires or a single response occured
ptb.hasResponded = 0;
checkForResponse('restart');
while (GetSecs - ptb.cueOnset) < con.respWin && ~ptb.hasResponded
    [leftSelecting, rightSelecting] = checkForResponse();

    % prepare the first half of the selection arc
    if leftSelecting
        angleL = 180;
        Screen('FrameArc', ptb.w, arcCol, ptb.rectL, 0, angleL, psA, psA);
    elseif rightSelecting
        angleR = 180;
        Screen('FrameArc', ptb.w, arcCol, ptb.rectR, 0, angleR, psA, psA);
    end 

    if leftSelecting || rightSelecting % "recognize" the selection
        ptb.respOnset = Screen('Flip', ptb.w);
        ptb.hasResponded = 1;
        LogData('Response', ptb.respOnset)
        LogData('RT', ptb.respOnset-ptb.cueOnset)
    end
% end
end

% if response window expired without response
if ~ptb.hasResponded
    LogData('Response', nan)
    LogData('RT', nan)
    LogData('FirstChoiceLeft', nan)
    LogData('FinalChoiceLeft', nan)
    ptb.selectedSide = 'none';
    ptb.confirmSide = chooseRandomSide();
    ptb.respOnset = GetSecs;    % virtual time, to compute later timings
end

tVNSoption('action', leftSelecting, rightSelecting);
WaitSecs('UntilTime', ptb.respOnset + 1.5); % equalize for tVNS setup delay
% todo: the delay of the new commands of tVNS manager v2.1 is much lesser,
% around 0.4 secs! Check and improve

% in case of a response in time, draw selection arc
if ptb.hasResponded
    LogData('FirstChoiceLeft', leftSelecting)

    % during the expected response period, show a growing arc for the
    % selected side, depending on the continuing response
    while (GetSecs - ptb.respOnset) < con.respDur
        % compute the angles for the selection arcs
        [leftSelecting, rightSelecting] = checkForResponse();
        if leftSelecting                    % if still selecting left...
            angleL = min(angleL + incr, 360);   %...increase left arc
        elseif ~leftSelecting               % otherwise....
            angleL = max(angleL - decr, 0); % ...decrease left arc
        end
        if rightSelecting
            angleR = min(angleR + incr, 360);
        elseif ~rightSelecting
            angleR = max(angleR - decr, 0);
        end
        
        % show the arcs
        Screen('CopyWindow', wCues, ptb.w); % get untouched cues-display
        Screen('FrameArc', ptb.w, arcCol, ptb.rectL, 0, angleL, psA, psA);
        Screen('FrameArc', ptb.w, arcCol, ptb.rectR, 0, angleR, psA, psA);
        Screen('Flip', ptb.w);
    end

    % evaluate the response (selection arc needs to exceed the minimum)
    if angleL > minSelectionAngle
        LogData('FinalChoiceLeft', 1)
        ptb.selectedSide = 'left';
        ptb.confirmSide = 'left';

    elseif angleR > minSelectionAngle
        LogData('FinalChoiceLeft', 0)
        ptb.selectedSide = 'right';
        ptb.confirmSide = 'right';

    else % if response is invalid, choose side randomly
        LogData('FinalChoiceLeft', 'invalid')
        ptb.selectedSide = 'invalid';
        ptb.confirmSide = chooseRandomSide();
    end
end

Screen('CopyWindow', wCues, ptb.w); % get untouched cues-display

% prepare a reminder text if there was no valid response
if strcmp(ptb.selectedSide, 'invalid') || strcmp(ptb.selectedSide, 'none')
    Screen('Textsize', ptb.w, 40);
    y = round(ptb.wRect(4) * 5/6); % y-position of text
    DrawFormattedText(ptb.w, txt('miss'), 'center', y, ptb.color.red);
    ptb.respOnset = Screen('Flip', ptb.w, [], 1); % don't clear framebuffer
end

% in any case draw confirmation circle (also for random choosen side)
if strcmp(ptb.confirmSide, 'left')
    Screen('FrameOval', ptb.w, arcCol, ptb.rectL, psC, psC);
elseif strcmp(ptb.confirmSide, 'right')
    Screen('FrameOval', ptb.w, arcCol, ptb.rectR, psC, psC);
end

ptb.selOnset = Screen('Flip', ptb.w); % show the cue-choice window
LogData('ConfirmOnset', ptb.selOnset)
LogData('Selection', ptb.selectedSide)
LogData('Confirmation', ptb.confirmSide)
Screen('Close', wCues); % close offscreen window!

abortCheck();
end % ---------------------------------------------------------------------


function [leftSelecting, rightSelecting] = checkForResponse(restart)
% This function checks if there is a continuing response for one side. 
% ATTENTION - it has to be initialized with the 'restart' parameter and
% then be used without the parameter (see Developer notes)
persistent left right forceReleased sampleTime;
if nargin == 1 && strcmp(restart, 'restart')
    % for key-control, store if one side was choosen.
    left = 0;
    right = 0;

    % for force-control, check if device was released and is ready to be 
    % used. Otherwise it still has to be released
    forceReleased = 0; % 1 if released, 0 otherwise

    % we want to poll the GFD/Joystick for its state only as often as the 
    % display refreshes, to ensure a constant data rate.
    sampleTime = GetSecs; % to keep track of the last poll
    return
end

if doJoystick   % joystick controlled
    if GetSecs > sampleTime % poll the next value
        sampleTime = sampleTime + ptb.ifi;

        Joystick.X = WinJoystickMex(ptb.joySpec.Handle);
        joyMap = MapJoystickPosition(Joystick, ptb.joySpec, [-100 100]);
        % log the mapping of the Joystick-position
        output.forceTraject = [output.forceTraject;
            ptb.trialC, GetSecs, joyMap]; % log joystick mapping
    
        % check if device was released once since restart and is ready to 
        % be used. Otherwise stay with initial no-votum (left=0, right=0)
        if ~forceReleased 
            if abs(joyMap) < con.forceRelease
                forceReleased = 1;
            end
        else
            % check if value is above threshold
            if joyMap > con.forceThresh
                right = 1;
            else
                right = 0;
            end
            if -joyMap > con.forceThresh
                left = 1;
            else
                left = 0;
            end
        end
        abortCheck();
    end

elseif doScanner    % gripforce device controlled
    if GetSecs > sampleTime % poll the next value
        sampleTime = sampleTime + ptb.ifi;

        [GripFDev.X, GripFDev.Y] = WinJoystickMex(ptb.GripFSpec.Handle);
        [ResultL, ResultR] = MapGripforcePosition( ...
            GripFDev, ptb.GripFSpec, [0 100]);
        % log the mapping of the GFD
        output.forceTraject = [output.forceTraject; 
            ptb.trialC, GetSecs, ResultL, ResultR]; % log GFD mappings
    
        % check if device was released once since restart and is ready to 
        % be used. Otherwise stay with initial no-votum (left=0, right=0)
        if ~forceReleased 
            if ResultL < con.forceRelease && ResultR < con.forceRelease
                forceReleased = 1;
            end
        else
            if ResultR > con.forceThresh
                right = 1;
            else
                right = 0;
            end
            if ResultL > con.forceThresh
                left = 1;
            else
                left = 0;
            end
        end
        abortCheck();
    end

else % key controlled
    [~, firstPress, firstRelease] = abortCheck();
    if firstPress(ptb.keys.left)
        left = 1;
    elseif firstPress(ptb.keys.right)
        right = 1;
    end
    if firstRelease(ptb.keys.left)
        left = 0;
    elseif firstRelease(ptb.keys.right)
        right = 0;
    end
end
leftSelecting = left;
rightSelecting = right;
end % ---------------------------------------------------------------------


function confirmSide = chooseRandomSide
% This function chooses randomly a side, 'left' or 'right'
coinFlip = randi([0;1]); % random decision between 0 & 1
confirmSide = 'left';
if coinFlip % wether keep left or change to right.
    confirmSide = 'right';
end
end % ---------------------------------------------------------------------


function showISI
% This function shows an fixation cross after the selected cues
textISI = '+';
Screen('Textsize', ptb.w, 100);
Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
DrawFormattedText(ptb.w, textISI, 'center', 'center', ptb.color.white);
ptb.isiOnset = Screen('Flip', ptb.w, ptb.cueOnset + con.cueDur);
LogData('ISIonset', ptb.isiOnset)

abortCheck();
end % ---------------------------------------------------------------------


function showResult()
% This function shows the result of the participants response and updates
% the global reward.

% evaluate the selection of the participant
step = con.rewardStep;
target = ptb.trial.winSide;
if strcmp(target, ptb.selectedSide) % the participant selected correct!
    LogData('FeedbackWin', 1)
    ptb.gReward = ptb.gReward + step;
    textResult = ['+ ' num2str(step) ' ' txt('points')];
    color = ptb.color.green;
else % the participant looses!
    LogData('FeedbackWin', 0)
    textResult = ['+ 0 ' txt('points')];

    % confirmSide = selectedSide if responded,
    % else selectedSide = invalid/none & confirmside is random, then mark a
    % correct random selection with green, and incorrect with red color
    if strcmp(ptb.confirmSide, target)
        color = ptb.color.green;
    else
        color = ptb.color.red;
    end
end
LogData('GlobalReward', ptb.gReward)

% prepare showing the result of this trial
Screen('Textsize', ptb.w, 100);
% draw total account
y = ptb.wRect(4)/2 - 100; % y-position of global reward text
gRewardText = [txt('gReward') num2str(ptb.gReward)];
DrawFormattedText(ptb.w, gRewardText, 'center', y, ptb.color.black);

Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
% draw reward
DrawFormattedText(ptb.w, textResult, 'center', 'center', color);
% show the result of this trial
rOnset = ptb.isiOnset + con.isiDur + ptb.jitterISI(ptb.trialC);
ptb.resultOnset = Screen('Flip', ptb.w, rOnset);
LogData('ResultOnset', ptb.resultOnset)

tVNSoption('outcome');

% stop showing result
Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
resultOffset = Screen('Flip', ptb.w, ptb.resultOnset + con.resDur);
LogData('ResultOffset', resultOffset)

if doTVNS && ~ptb.doTraining % end of tVNS treatment
    [~,~,~] = send(ptb.reqTreatOff, ptb.tvnsURL);
    Log(GetSecs, 'tVNS stimulation ends')
    LogData('StimulationOff', GetSecs)
end

abortCheck();
end % ---------------------------------------------------------------------


function showIBI(block_i)
% This function shows an fixation cross after each block
textISI = '+';
Screen('Textsize', ptb.w, 100);
Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
DrawFormattedText(ptb.w, textISI, 'center', 'center', ptb.color.white);
ibiOnset = Screen('Flip', ptb.w);
LogData('IBIonset', ibiOnset)

if doEyelink
    Eyelink('Message', ['End block',num2str(block_i)] );
    WaitSecs(0.1); % Add 100ms of data to catch final events prior stopping
    Eyelink('StopRecording');
end

% show IBIuntil here
Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
ibiOffset = Screen('Flip', ptb.w, ibiOnset + con.ibiDur);
LogData('IBIoffset', ibiOffset)

abortCheck();
end % ---------------------------------------------------------------------


function showGlobalOutcome
% This function shows the global reward of the participant

text = [txt('gReward') num2str(ptb.gReward)];
Screen('Textsize', ptb.w, 50);
Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
DrawFormattedText(ptb.w, text, 'center', 'center', ptb.color.white);
gRewardOnset = Screen('Flip', ptb.w);
Log(gRewardOnset, 'GlobalOutcome:', ptb.gReward)

% show global result until here
lastOnset = Screen('Flip', ptb.w, gRewardOnset + con.gResDur);
Log(lastOnset, 'End')

if doTTL
    sendTTL(con.trigger.end);
end

abortCheck();
end % ---------------------------------------------------------------------


function tVNSoption(stimTime, leftSelecting, rightSelecting)
% This function prepares the tVNS stimulation and applies it. 
% For 'action' blocks applies: high amplitude if participant chooses the 
% good-option side, low amplitude else.
% For 'outcome' blocks applies: high amplitude if participant chosses the
% winning side, low amlitude else.
% stimTime - determines the position in the taskflow: 'action' vs 'outcome'
% leftSelecting & rightSelecting are needed to determine the selection of
% the participant at the beginning of the selection process ('action').

% if we do tVNS at all & at this time ('action' vs 'outcome')
if doTVNS && ~ptb.doTraining && strcmp(stimTime, ptb.block.stimTime)

    % determine selection of participant
    if nargin == 1 % at stimTime 'outcome' we know the result...
        choice = ptb.selectedSide;
    else % ...but during 'action' the selection process just started, so...
        if leftSelecting    % ...use the first response, if any
            choice = 'left';
        elseif rightSelecting
            choice = 'right';
        else
            choice = 'none';
        end
    end

    % determine target depending on stimulation-time
    if strcmp(stimTime, 'action')
        target = ptb.trial.goodOption;  % side with more wins in general    
    else
        target = ptb.trial.winSide;     % the current winning side
    end

    % evaluate selection of participant, if correct -> high amplitude
    if strcmp(target, choice)   % correct, use individual high amplitude
        LogData('StimulationIntensity', 'high')
        amplitude = subj.stimHighAmp;
    else
        LogData('StimulationIntensity', 'low')
        amplitude = con.stimLowAmp;  % fail, use common low amplit.
    end

    % prepare the stimulation intensity for setting with tVNS Manager
    Log(GetSecs, 'tVNS setup start')
    method = matlab.net.http.RequestMethod.POST;
    bIntensity = matlab.net.http.MessageBody( ['intensity ' ...
        num2str(amplitude)] );
    reqIntensity = matlab.net.http.RequestMessage(method, [], bIntensity);

    [r2,~,~] = send(reqIntensity, ptb.tvnsURL);% set stimulation intensity
    if r2.StatusCode ~= matlab.net.http.StatusCode.OK
        warning('tVNS setup failed')
        Log(GetSecs, 'tVNS setup failed')
    else
        Log(GetSecs, 'tVNS setup success')
    end

    % now apply stimulation
    [r3,~,~] = send(ptb.reqTreatOn, ptb.tvnsURL);
    if r3.StatusCode ~= matlab.net.http.StatusCode.OK
        warning('tVNS stimulation failed')
        Log(GetSecs, 'tVNS stimulation failed')
        LogData('StimOnset', nan)
    else
        Log(GetSecs, 'tVNS stimulation begins')
        LogData('StimOnset', GetSecs)
    end
end
end % ---------------------------------------------------------------------


function LogData(fieldName, value)
% This function logs a value for a fieldname during the trial-loop. Not
% outside of it!
tc = ptb.trialC; % use the global trial counter

% collect some standard-data, available at start of each trial
output.dataMat(tc).ID = subj.id;
output.dataMat(tc).session = subj.sess;
output.dataMat(tc).run = subj.run;
if doTVNS && ~ptb.doTraining
    output.dataMat(tc).stimCond = subj.stimCond;
end
output.dataMat(tc).block = ptb.blockC;      % current block number
output.dataMat(tc).trialID = ptb.trialC;    % current trial (global count)
output.dataMat(tc).stimulationTime = ptb.block.stimTime;
output.dataMat(tc).winProb = ptb.trial.winProb; % high or low win-probabil.
output.dataMat(tc).difficulty = ptb.trial.difficulty;
output.dataMat(tc).goodOption = ptb.trial.goodOption; % side of more wins
output.dataMat(tc).leftCue = ptb.trial.cueL;    % filename of left cue
output.dataMat(tc).rightCue = ptb.trial.cueR;   % filename of right cue
output.dataMat(tc).winProbabilityLeftCue = ptb.trial.winProbLeft;
output.dataMat(tc).winSide = ptb.trial.winSide; % probalistic winning side

output.dataMat(tc).(fieldName) = value;
end %----------------------------------------------------------------------


function Log(onset, event, varargin)
% This function logs the onset of the event and possible other infos.

if ~isfield(output, 'log')
    ni = 1; % next index (row-index for log)
else
    ni = length(output.log) +1;
end
output.log(ni).trial = ptb.trialC;% log the trial counter
output.log(ni).onset = onset;     % log mandatory info
output.log(ni).event = event;     % log mandatory info


for var_i = 3:nargin            % log any other info
    output.log(ni).(['var_' num2str(var_i)]) = varargin{var_i-2};
end
end % ---------------------------------------------------------------------


function saveNclean
% This function saves the data & cleans up
if doTVNS && ~ptb.doTraining % end of tVNS treatment
    [~,~,~] = send(ptb.reqTreatOff, ptb.tvnsURL);   
end

% compose the filepath for general data
if ptb.doTraining && ~doScanner
    subId = [output.task '_Training_' output.studyID '_' subj.ids...
        '_S' num2str(subj.sess)];
elseif ptb.doTraining && doScanner
    subId = [output.task '_Calibration_' output.studyID '_' subj.ids...
        '_S' num2str(subj.sess)];
else
    subId = [output.task '_' output.studyID '_' subj.ids...
        '_S' num2str(subj.sess) '_R' num2str(subj.run) ];
end
save([output.savePath '\' subId], 'output', 'subj'); % save important data
save([output.backupPath '\' subId '_' output.dateStart]); % save backup

if doEyelink
    %%% STEP 6 - END OF EXPERIMENT, CLEAN UP
    Eyelink('SetOfflineMode'); % Put tracker in idle/offline mode
    % Clear Host PC backdrop graphics at the end of the experiment
    Eyelink('Command', 'clear_screen 0'); 
    WaitSecs(0.5); % Allow some time before closing and transferring file
    Eyelink('CloseFile'); % Close EDF file on Host PC

    % Transfer a copy of the EDF file to Display PC
    transferFile( [output.savePath '\' subId] );
end

KbQueueRelease();   % release keyboard logging
sca                 % close all PTB Screens

if doTTL
    closeTTL();
end
end % ---------------------------------------------------------------------


function transferFile(filename)
    try
        if ptb.dummymode == 0 % If connected to EyeLink
            % Show 'Receiving data file...' text during transfer
            [~, height] = Screen('WindowSize', ptb.w);
            Screen('FillRect', ptb.w, [125,125,125]); % Prepare background
            Screen('DrawText', ptb.w, 'Receiving data file...', ...
                5, height-35, 0); % Prepare text
            Screen('Flip', ptb.w); % Present text
            % Print some text in Matlab's Command Window
            fprintf('Receiving data file ''%s.edf''\n', ptb.edfFile); 
            
            % Transfer EDF file to Host PC
            % status=Eyelink('ReceiveFile',['src'],['dest'],['destIsPath'])
            now = datetime('now', 'Format','yyMMdd_HHmm');
            destination = [pwd, filesep, filename, '_', char(now) '.edf'];
            status = Eyelink('ReceiveFile', [], destination, 0);
            % If <src> is omitted, tracker will send last opened data file.
            % If <dest> is omitted, creates local file with source file
            % name. Else, creates file using <dest> as name.  
            % If <dest_is_path> is supplied and non-zero uses source file
            % name but adds <dest> as directory path.
            
            % Check if EDF file has been transferred successfully and
            % print file size in Matlab's Command Window
            if status > 0
                fprintf('EDF file size: %.1f KB\n', status/1024); % B to KB
            end
            % Print transferred EDF file path in Matlab's Command Window
            fprintf('Data file ''%s.edf'' can be found in ''%s''\n', ...
                ptb.edfFile, pwd);
        else
            fprintf(2, 'No EDF file saved in Dummy mode\n');
        end
    catch ME % Catch a file-transfer error
        fprintf(2, 'Problem receiving data file ''%s''\n', ptb.edfFile);
        rethrow(ME)
    end
end % ---------------------------------------------------------------------


function saveTempfile
% This function saves the current workspace as temporal backup

if ptb.doTraining && ~doScanner
    subId = [output.task '_Training_' output.studyID '_' subj.ids...
        '_S' num2str(subj.sess)];
elseif ptb.doTraining && doScanner
    subId = [output.task '_Calibration_' output.studyID '_' subj.ids...
       '_S' num2str(subj.sess)];
else
    subId = [output.task '_' output.studyID '_' subj.ids...
        '_S' num2str(subj.sess) '_R' num2str(subj.run) ];
end
save([output.backupPath '\' subId '_temp' output.dateStart]);
end % ---------------------------------------------------------------------


function [pressed,firstPress,firstRelease,lastPress,lastRelease]=abortCheck
% This function uses KbQueueCheck to monitor if the escapeKey was
% pressed. If so, it throws an error. Else, it behaves
% like KbQueueCheck, for return-values refer to help of KbQueueCheck. In
% both cases it logs the response.

[pressed, firstPress, firstRelease, lastPress, lastRelease] =...
    KbQueueCheck();
if pressed == 1 % Check the keyboard for presses
    keyCode = find(firstPress, 1); % only check first pressed key
    Log(GetSecs, 'Keypress', KbName(keyCode));

    if keyCode == ptb.keys.escape
        Log(GetSecs, 'AbortKeyPressed');
        error('Abort key pressed!')
    end
end
end % ---------------------------------------------------------------------


function waitUntilResponse(expireDuration)
% This function waits until any response or the expireDuration expired
% (if any), and continues then, except the abort-key was pressed.
if nargin == 0
    expireDuration = inf; % wait endless if no expireDuration given
end
Log(GetSecs, 'waitUntilResponse')

checkForResponse('restart'); % demand a release of the device
start = GetSecs;
while GetSecs - start < expireDuration
    [leftSelecting, rightSelecting] = checkForResponse();
    if leftSelecting || rightSelecting % "recognize" the selection
        break;
    end
    WaitSecs(0.01);
end
Log(GetSecs, 'continueAfterResponse')
end % ---------------------------------------------------------------------


function lText = txt(field)
% This function returns the textstring specified by 'field', according to
% the sessions language.

lt.proceedHint.de = 'Zum Fortfahren bitte das Geraet druecken.';
lt.proceedHint.eng = 'Please press to proceed.';

lt.pressLeft.de = 'Bitte druecken sie links so fest sie koennen!';
lt.pressLeft.eng = 'Please press left as strong as you can!';

lt.pressLeft2.de = 'Bitte druecken sie nochmal links!';
lt.pressLeft2.eng = 'Please press again left!';

lt.holdLeft.de = ['Bitte halten Sie das linke Geraet in den folgenden' ...
    ' 10 Sekunden einfach nur locker in der Hand ohne zuzudruecken.'];
lt.holdLeft.eng = ['Please hold the left device in loosely\n in your' ...
    ' hand for next 10 seconds.'];

lt.pressRight.de = 'Bitte druecken sie rechts so fest sie koennen!';
lt.pressRight.eng = 'Please press right as strong as you can!';

lt.pressRight2.de = 'Bitte druecken sie nochmal rechts!';
lt.pressRight2.eng = 'Please press again right!';

lt.holdRight.de = ['Bitte halten Sie das rechte Geraet in den folgenden'...
    ' 10 Sekunden einfach nur locker in der Hand ohne zuzudruecken.'];
lt.holdRight.eng = ['Please hold the right device in loosely\n in your' ...
    ' hand for next 10 seconds.'];

lt.left.de = 'links';
lt.left.eng = 'left';

lt.right.de = 'rechts';
lt.right.eng = 'right';

lt.waitMRI.de = 'Wir warten kurz auf das MRT';
lt.waitMRI.eng = 'We wait a moment for the MRI';

lt.newBlock.de = 'Ein neuer Block beginnt';
lt.newBlock.eng = 'A new block starts';

lt.miss.de = 'Bitte schneller entscheiden';
lt.miss.eng = 'Please decide faster';

lt.points.de = 'Punkte!';
lt.points.eng = 'Points!';

lt.gReward.de = 'Gesamtgewinn : ';
lt.gReward.eng = 'Overall reward : ';

lText = lt.(field).(subj.language);
end % ---------------------------------------------------------------------


function screenShot
% This function creates a screenshot and stores it as jpg
persistent counter;
if isempty(counter)
    counter = 1;
end
            
screenShot = Screen('GetImage', ptb.w);
imwrite(screenShot, ['screenShot' num2str(counter) '.jpg'])
counter = counter+1;
end %----------------------------------------------------------------------


function trigTime = waitForScannerTrigger(dummys, keyQuit)
% This function waits/blocks until the amount of "dummys"+1 triggers have
% been received. Their timepoints are returned in trigTime.
% If keyQuit is given, we assume that KbQueueCreate() & KbQueueStart() have
% been called already, then this function aborts with an error after the 
% key was pressed and the readTimeout expired.
% After it receives data, this data is compared with the expectation and
% in case of unequality the function continues waiting.
% Additionally if doTTL is flagged, it sends a (start-)trigger
% 
port = 'COM3';      % L&B -> 'COM3'
target = [254 134]; % expected data, representing a trigger-pulse in L&B
readTimeout = '10'; % how long to wait for a trigger-pulse?
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

        if doTTL && counter == 1 % send an EGG trigger at first scan
            sendTTL(con.trigger.start);
        end

    else % if no valid trigger was received, continue loop longer
        disp(['unexpected trigger data received (or timeout)! Data : ' ...
            num2str(data)])
        counter = counter-1; % set counter back to continue loop
    end
end

IOPort('Close', myport);
end %----------------------------------------------------------------------

%--------------------------------------------------------------------------
end % of nested helperfunctions, end of task.
%--------------------------------------------------------------------------
