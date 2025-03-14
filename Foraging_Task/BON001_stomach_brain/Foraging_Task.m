function Foraging_Task5
try
study   = 'BON001';
task    = 'Foraging';
version = '1.0.1.5';

% Author: Paul Jung
% Mail  : jung.science@web.de
% Author: Jana Lieberz
% Date  : 11.07.2024
%
% This script implements the foraging task
%--------------------------------------------------------------------------

% set some preferences:
doDebug     = 0;    % 1 for debugging - smaller window etc., 0 else
doJoystick  = 0;    % 1 for yes we use a joystick, 0 else
doGFD       = 1;    % 1 for yes we use a GFD, 0 else
doMRITrigger = 1;   % 1 for yes we wait for MRI trigger
doTTL       = 1;    % 1 for yes we send trigger pulses to Biopac
doTVNS      = 1;    % 1 for yes we stimulate with tVNS
doAttentionCheck = 0; % 1 for yes we present attention checks with asteriks
[~] = Screen('Preference', 'SkipSyncTests', 1); % 1 if encountering errors

%%% general preparations
ptb = [];       % for script-wide variable handling
con = [];       % "shortcut" for condition-file data
output = [];    % the common output structure
subj = [];      % the common subj structure
generalPreparations();  % init variables, etc.
dispPrefs();            % disp the preferences to the experimenter
subjQuery();    % get infos about subject & session and load condition file

%%% start the session
startPsychtoolbox()
if output.doTraining
    showInstruction('intro')
else
    showReady2Start()   % includes wait for mri-trigger if flagged
end

%%% begin block & trial loop
for block_i = 1:length(con.block)
    announceBlock(block_i); % and give instructions in case of training

    blockStart = GetSecs;
    while (GetSecs - blockStart) < ptb.env.duration

        ptb.trialC = ptb.trialC+1;  % set global trial counter
        showTrial();
        showISI();

        saveTempFile()
    end % of trial loop

end % of block loop
ptb.trialC = 0; % reset global trial counter

%%% end of session
showGlobalOutcome()
if output.doTraining
    showInstruction('outro')
end
saveNclean()

catch ME % in case of error, copy all vars to base workspace for inspection
    VARS = who;
    for iV = 1:length(VARS)
        assignin('base', VARS{iV}, eval(VARS{iV}) ) % copy one var to base
    end
    warning('variables send to base workspace!')
    saveNclean() % ! throws an error itself if subjQuery() not finished
    rethrow(ME)
end

%--------------------------------------------------------------------------
% end of main code, start of nested helperfunctions
%--------------------------------------------------------------------------
    
function generalPreparations
% This function prepares variables (ptb), recopies vars (output), prepares
% folder for data storage and prepares devices.
rng('shuffle'); % take care for real random numbers

ptb.gReward = 0;% global reward
ptb.trialC = 0; % global trial counter
ptb.blockC = 0; % global block counter
ptb.fc.failCounter = 0;  % structure to handle the Forced-Choice

KbName('UnifyKeyNames')
keys.escape = KbName('ESCAPE'); % also used for abortCheck()
keys.left = KbName('c');
keys.right = KbName(',<');
keys.left2 = KbName('LeftControl');
keys.right2 = KbName('RightControl');
ptb.keys = keys;

output.log = [];    % for logging all events with time-entry
output.dataMat = [];% for logging row-wise
output.forceTraject = []; % for logging joystick / gripforce trajectories
output.dateStart = char(datetime('now', 'Format','yyMMdd_HHmm'));
output.dateStartSec = GetSecs;
output.system = Screen('Computer');   % pc-specs
output.studyID = study;
output.task = task;
output.version = version;
output.doDebug = doDebug;
output.doJoystick = doJoystick;
output.doGFD = doGFD;
output.doMRITrigger = doMRITrigger;
output.doTraining = -1; % unvalid init value

output.savePath = '.\Data'; % to store the collected data in
if 7~=exist(output.savePath,'dir')
	mkdir(output.savePath)
end

output.backupPath = '.\Backup'; % to backup the collected data in
if 7~=exist(output.backupPath,'dir')
	mkdir(output.backupPath)
end

ptb.supplPath = '.\supplementaryFiles\';
addpath(ptb.supplPath);

if doJoystick
    addpath([ptb.supplPath 'Joystick\'])
    load('JoystickSpecification.mat', 'JoystickSpecification');
    ptb.joySpec = JoystickSpecification;    % for easier use
    ptb.joySpec = findJoystick(ptb.joySpec);% update handle
    output.joySpec = ptb.joySpec;           % for later evaluation

    % add info about the trajectories table to output
    output.forceTrajectLabels = ['trialNumber', 'onset', 'mapping'];
end

if doGFD % add info about the trajectories table to output
    output.forceTrajectLabels = ['trialNumber', 'onset', 'left', 'right'];
end

if doTTL
    addpath([ptb.supplPath 'TTL\'])
    comX = 'COM7';  % COM-7 for L&B, COM3 for behavioural testing laptop
    trigDur = 0.005;% duration for sending triggers in seconds
    prepareTTL(comX, 115200, trigDur);
end
end % ---------------------------------------------------------------------


function dispPrefs
% This function displays the preferences on the command window to inform
% the experimenter
disp(' ')
disp(['Study ID        : ' study])
disp(['Task            : ' task])
disp(['Sofware version : ' version])
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

if doGFD
    disp('We use a Gripforce-Device')
else
    disp('We do NOT use a Gripforce-Device')
end

if doGFD && ~doMRITrigger
    % provide warning and ask again for MRI trigger
    doMRITrigger = input(['We use a GFD but are NOT' ...
        ' waiting for MRI trigger. Should we wait for trigger' ...
        ' [1] or not [0]?: ']); 
    output.doMRITrigger = doMRITrigger; % update output

elseif ~doGFD && doMRITrigger
    % provide warning and ignore wait for MRI trigger
    disp(['We do NOT use a GFD but are waiting for MRI' ...
        ' trigger. Waiting for MRI trigger is IGNORED!']); 
    doMRITrigger = 0;
    output.doMRITrigger = doMRITrigger; % recopy
end

if doMRITrigger
    disp('We are waiting for MRI trigger')
else
    disp('We are NOT waiting for MRI trigger')
end

if doTTL
    disp('We are sending trigger to Biopac')
else
    disp('We are NOT sending trigger to Biopac')
end

disp(' ')
% give a litthe hint of the keys in the command window
disp(['Abortkey: ' KbName(ptb.keys.escape)])
if ~doGFD && ~doJoystick
    disp(['Key for high-force left: ' KbName(ptb.keys.left2)])
    disp(['Key for high-force right: ' KbName(ptb.keys.right2)])
    disp(['Key for low-force left: ' KbName(ptb.keys.left)])
    disp(['Key for low-force right: ' KbName(ptb.keys.right)])
end

disp(' ')
end % ---------------------------------------------------------------------


function subjQuery
% This function collects some infos about the subject & session and loads
% the individual condition file or the training condition file

disp('Now the experimenter shall input some infos!')

subj.id = input('Subject ID [6 digits]: ');
subj.ids = pad( num2str(subj.id), 6,"left",'0'); % add leading zeros

% query and check the Session ID
subj.sess = input('Session ID [1 or 2]: ');
% % ensure that the correct session ID was provided
% correct_sess = 0;
% while correct_sess ~= 1
%     if subj.sess == 1
%         correct_sess = input(['The specified session is ' ...
%             num2str(subj.sess) ', indicating the first MRI session.' ...
%             ' Is this correct (1) or not (0)?: ']);
%     elseif subj.sess == 2
%         correct_sess = input(['The specified session is ' ...
%             num2str(subj.sess) ', indicating the second MRI session.' ...
%             ' Is this correct (1) or not (0)?: ']);
%     elseif ~ismember(subj.sess, 1:2)
%         fprintf(['\nThe specified session is not a valid session' ...
%             ' for BON001! ']);
%     end
%     if correct_sess ~= 1
%         subj.sess = input(['Please enter the correct' ...
%             ' session ID [1 or 2]: ']);
%     end
% end

% ask if it is a training run
isTrain = input('Is this a training run? yes (1) or no (0) : ');
if isTrain
    output.doTraining = 1;
    subj.cond = NaN;

    output.doLongTraining = input('Long (1) or short (0) training? : ');
    % prepare to load training condition file
    if output.doLongTraining
        path = [ptb.supplPath 'ConditionFiles\Foraging_longTraining_cond_' study];
    else
        path = [ptb.supplPath 'ConditionFiles\Foraging_shortTraining_cond_' study];
    end

else % no training, this is the actual main run
    output.doTraining = 0;
    
    % query and check the Condition ID
    subj.cond = input('Condition ID, [0/1]: ');
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

    % prepare to load individual condition file
    path = [ptb.supplPath 'ConditionFiles\Foraging_cond_BON001_'...
        subj.ids '_S' num2str(subj.sess) '.mat'];
end

if output.doTraining
    subj.run = input(['Run [1 = first training of session/2 = training' ...
        ' at MRI]: ']);
else
    subj.run = 1;
end
subj.date = char(datetime('now', 'Format','yyMMdd_HHm'));
subj.study = study;
subj.version = version;

% asks for the desired language during the experiment
isGerman = input('Present task in German (1) or english (0)? : ');
if isGerman % german option
    lang = 'de';
else % here we determine the fallback language
    lang = 'eng';
end
subj.language = lang;


load(path, 'cond');
output.cond = cond; % the condition file
con = cond;         % for easier in-script access

% This if-branch restarts the tVNS stimulation
% and gives the experimenter the opportunity to check & repair the
% bluetooth connection between device and manager, if necessary.
if doTVNS
    subj.tVNS_manager = input('Use tVNS manager [1] or start stimulation manually [0]?: ');
    if subj.tVNS_manager
        subj.stim_amplitude = input('Stimulation intensity [muA]: ');
        subj.stim_length = 30;
        subj.pause_length = 30;
        subj.stim_freq = 25;
        subj.stim_impDur = 250;

        % stop and re-start stimulation
        ptb.tvnsInfo = setupTVNS(subj.stim_amplitude,subj.stim_impDur,subj.stim_freq,subj.stim_length, subj.pause_length);
        [~,~,~] = send(ptb.tvnsInfo.reqTreatOff, ptb.tvnsInfo.tvnsURL);
        [~,~,~] = send(ptb.tvnsInfo.reqTreatOn, ptb.tvnsInfo.tvnsURL);
        output.timestamps.time_stim_on = GetSecs;
        if doTTL
            sendTTL(con.trigger.tvns_on)
        end

        % now the experimenter needs to check if manager & device still work
        disp('Please check the tVNS manager window if the stimulation is still running.')
        allOk = input('Please enter 1 if everything is ok, enter 0 if we need to restart the stimulation : [0/1] ');
        while ~allOk
            disp('Please re-establish the bluetooth connection between device and tVNS manager before restarting!')
            doRestart = input('Shall we restart stimulation now? : [0/1] ');
            % restart of normal stimulation
            if doRestart
                ptb.tvnsInfo = setupTVNS(subj.stim_amplitude,subj.stim_impDur,subj.stim_freq,subj.stim_length, subj.pause_length);
                [~,~,~] = send(ptb.tvnsInfo.reqTreatOn, ptb.tvnsInfo.tvnsURL);
                output.timestamps.time_stim_on = GetSecs;
                if doTTL
                    sendTTL(con.trigger.tvns_on)
                end
            end
            allOk = input('Please enter 1 if everything is ok, enter 0 if we need to restart the stimulation : [0/1] ');
        end
        
    end
end

if doGFD % prepare the proper GFD specification
    addpath([ptb.supplPath 'Gripforce\'])
%     load('GripforceSpec.mat', 'GripFSpec' ) % local GFD specifications

    % load GFD specs from EAT paradigm
%     load(['X:\Tasks\Effort\Projects_Versions\BON001\data\' ...
%         'TrainEAT_BON001_990021_S1_R1.mat'], 'input_device') % test path
%     load(['C:\Users\Studies\Desktop\BON001\NIMG\Effort\data\TrainEAT_' ...
%         subj.study '_'  subj.ids '_S' num2str(subj.sess) ...
%         '_R1.mat'], 'input_device') % path BON001 laptop
    load(['C:\Users\mrt\Desktop\BON001\NIMG\EAT\data\TrainEAT_' ...
        subj.study '_'  subj.ids '_S' num2str(subj.sess) ...
        '_R1.mat'], 'input_device') % path L&B
    % get needed variables out of input_device
    GripFSpec.Handle = 0;
    GripFSpec.MinL = input_device.minEffortL;
    GripFSpec.MaxL = input_device.maxEffortL;
    GripFSpec.MinR = input_device.minEffortR;
    GripFSpec.MaxR = input_device.maxEffortR;
    
    output.GripFSpec = GripFSpec;              % for easier access
    output.GripFSpec = findJoystick(GripFSpec);% updated handle
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
color.yellow = [255 255 0];
color.blue = [0 0 255];
% colors for backgrounds
color.lightblue = [153 204 255];
color.lightbrown = [255 204 153];
color.lightpink = [255 204 255];
color.lightgreen = [204 255 204];
ptb.color = color;

% show the first screen
if doDebug
   [w,wRect] = Screen('OpenWindow',screenNumber,color.grey,[0 0 1280 720]);
else
    [w,wRect] = Screen('OpenWindow',screenNumber,color.grey, []);
    HideCursor()
end
ptb.w = w; % the handle of the window to paint to
ptb.wRect = wRect;
ptb.ifi = Screen('GetFlipInterval', w);
output.system.ifi = ptb.ifi;

% prepare background image (texture)
im = imread([ptb.supplPath 'Images\background.png']);
ptb.bckgrndTex = Screen('MakeTexture', ptb.w, im);

% prepare rocket image (texture)
[img, ~, alpha] = imread([ptb.supplPath 'Images\rocket2.png']);
img(:,:,4) = alpha;                     % add the alpha channel
ptb.rocketTex = Screen('MakeTexture', ptb.w, img);

KbQueueCreate()
KbQueueStart(); 

abortCheck();
end % ---------------------------------------------------------------------


function showInstruction(inOrOut)
% This function shows the instruction for the participant & waits for a
% response
% inOrOut - 'intro' for instructions in advance, 'outro' for afterwards
Screen('Textsize', ptb.w, 40);  % textsize during instructions
txtCol = ptb.color.white;       % textcolor during instructions
y = ptb.wRect(4)-15;            % y-position of "press to proceed" text

% determine the variant of instruction and the number of its slides
if strcmpi(inOrOut, 'intro')
    if output.doLongTraining
        variant = 'instr';  % the long instruction text
        last = 9;           % the number of slides
    else
        variant = 'instrS'; % the short instruction text
        last = 6;
    end

elseif strcmpi(inOrOut, 'outro')
    if doGFD % after the training inside MRI
        return % no interruption any more

    else % after the training outside MRI
        variant = 'mriProsp';   % the prospect of the MRI run
        last = 1;               % the number of slides
    end
end

for i = 1:last     % show the selected instructions
    Screen('DrawTexture', ptb.w, ptb.bckgrndTex) % draw background image
    text = txt([variant num2str(i)]);
    DrawFormattedText(ptb.w, text, 'center','center', txtCol, 60, ...
        [],[], 1.3);
    DrawFormattedText(ptb.w, txt('proceed'), 'center', y, txtCol);
    instructionOnset = Screen('Flip', ptb.w);
    Log(instructionOnset, ['Instruction ' num2str(i)])
    waitUntilResponse(); % wait until participant responses
end
end % ---------------------------------------------------------------------


function showReady2Start
% This function shows the ready to start screen & waits for MRI trigger
% if flagged
Screen('Textsize', ptb.w, 40);
txtCol = ptb.color.black;       % textcolor during instructions
DrawFormattedText(ptb.w, txt('ready'), 'center', 'center',...
    ptb.color.black, 40, [],[], 1.3);
instructionOnset = Screen('Flip', ptb.w);
Log(instructionOnset, 'Ready2Start')
waitUntilResponse(); % wait until participant responses

if doMRITrigger && ~output.doTraining  % wait for some MRI-trigger
    DrawFormattedText(ptb.w, txt('waitMRI'), 'center', 'center', txtCol);
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


function announceBlock(block_i)
% This function announces the next block, changes the background-color and
% stores data about the current environment in ptb.env.
% For training it gives additional training instructions.
disp(['Block ' num2str(block_i) ' is running.']) % info for experimenter
ptb.blockC = block_i; % recopy for easier access for smoothLogging

ptb.env = con.block{block_i}; % get the environment for this block
% set the new background-color for this environment
Screen('FillRect', ptb.w, ptb.color.( ptb.env.backColor ));

if doTTL
    sendTTL(ptb.env.trigger);
end

% prepare announcement of the next block
textColor = ptb.color.black;

if output.doTraining % show a selfpaced instruction for this training block
    if output.doLongTraining
        variant = 'train';  % the long block instruction text
        last = [1, 4, 4];   % the number of slides in each block
    else
        variant = 'trainS'; % the short block instruction text
        last = [1, 1, 1];   % the number of slides
    end

    Screen('Textsize', ptb.w, 40);  % textsize during instructions
    y = ptb.wRect(4)-15;            % y-position of "press to proceed" text
    slideCount = last(block_i);     % number of slides for current block
    for i = 1:slideCount
        text = txt(  [variant num2str(block_i) '_' num2str(i)]  );

        DrawFormattedText(ptb.w, text, 'center','center', textColor,...
            40, [],[], 1.3);
        DrawFormattedText(ptb.w, txt('proceed'), 'center', y, textColor);

        instructionOnset = Screen('Flip', ptb.w);
        Log(instructionOnset, ['Training ' num2str(block_i)])
        waitUntilResponse(); % wait until participant responses
    end

else % show a short block announcement
    Screen('Textsize', ptb.w, 50);
    text = txt(['newBlock' num2str(block_i)]);
    DrawFormattedText(ptb.w, text, 'center','center', textColor,...
            40, [],[], 1.3);
    
    announceOnset = Screen('Flip', ptb.w);        % start of block announce
    Log(announceOnset, 'Block announce start')
    
    offset = announceOnset + con.announceDur;
    announceOffset = Screen('Flip', ptb.w, offset); % end of block announce
    Log(announceOffset, 'Block anounce end')
end

abortCheck();
end % ---------------------------------------------------------------------


function showTrial
% This function shows one trial

% determine a sample option out of the environment of the current block...
prepareSampleOption(); % one of: HDLR HDHR LDHR LDLR, store in ptb.option

% Set up alpha-blending for smooth (anti-aliased) lines & use of alpha
Screen('BlendFunction', ptb.w, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

prepareForcedChoice()
[cx, cy] = RectCenter(ptb.wRect);   % get center of the screen
% determine drawing positions
positions.option = [cx, cy/3];      % starting position for option
positions.targetL = [cx-300, cy];   % centerpoint of left target
positions.targetR = [cx+300, cy];
positions.forceBarL = [cx-100 cy];  % center of left force-indicator-bar
positions.forceBarR = [cx+100 cy];
positions.fuelBar = [cx, cy * 5/3]; % center of fuel bar (overall reward)

% during response-window, show approach of option to target & monitor for 
% a response, until a response or the response-window expires.
hasResponded = 0;       % flags if the participant has responded at all
hasAccepted = 0;        % flags if the participant has accepted the option
leftFlag = randi([0 1]);% choose randomly a target for the option
checkForResponse('restart');
startApproach = GetSecs;% start-time of response-window
elapsed = 0;            % elapsed time since start of response-window
LogData('showApproach', GetSecs)
LogData('leftApproached', leftFlag)
while (elapsed < con.respWin) && ~hasResponded
    % monitor for response
    force = checkForResponse();

    elapsed = showApproach(startApproach, positions, leftFlag, force);

    % if rejecting, a low effort is always sufficient
    if force.released
        leftRejecting = leftFlag && force.right >= con.forceLow;
        rightRejecting = ~leftFlag && force.left >= con.forceLow;
        if leftRejecting || rightRejecting
            hasResponded = 1;
            ptb.respOnset = Screen('Flip', ptb.w);
            LogData('Response', ptb.respOnset)
            LogData('RT', ptb.respOnset-startApproach)
        end
    end

    % if accepting & a high effort is wanted, a low effort response would
    % be a miss/incomplete. Evaluate response - was option accepted?
    if force.released
        leftAccept = leftFlag && (force.left >= ptb.option.effort);
        rightAccept = ~leftFlag && (force.right >= ptb.option.effort);
        if leftAccept || rightAccept
            hasAccepted = 1;
            hasResponded = 1;
            ptb.respOnset = Screen('Flip', ptb.w);
            LogData('Response', ptb.respOnset)
            LogData('RT', ptb.respOnset-startApproach)
        end
    end
end

if ~hasResponded
    LogData('Response', [])
    LogData('RT', [])
end
LogData('hasAccepted', hasAccepted)

% check if the participant accepted the option and keeps responding
hasCompleted = 0;   % flags if responded with needed power long enough
approachLogged = 0; % flags if (low-effort) option was catched
releaseLogged = 0;  % flags if (for low-effort) the release was logged
if hasAccepted
    hasCompleted = 1; % assume it stays in state completed, change it else

    % monitor the continuing response
    startDelay = GetSecs;       % start-time of delay-window   
    elapsed = 0;                % elapsed time since start of delay-window
    while elapsed < con.expanseDur % while inside the response-window
        % enlarge the option
        elapsed = showExpanse(startDelay, positions, leftFlag, force);
        
        % check if still holding strong enough
        force = checkForResponse();
        leftAccept = leftFlag && (force.left >= ptb.option.effort);
        rightAccept = ~leftFlag && (force.right >= ptb.option.effort);

        % if released too early / before delay-window expired
        if  elapsed < ptb.option.delay && ~(leftAccept || rightAccept)
            hasCompleted = 0;
            LogData('FailOnset', GetSecs)
            LogData('approachFinished', [])
            break
        end

        % for low force-effort options: when the option.delay expires we 
        % log this timepoint because the option will be shown for the rest
        % of the duration "expanseDur"
        if ~approachLogged && elapsed >= ptb.option.delay
            LogData('FailOnset', [])
            LogData('approachFinished', GetSecs)
            approachLogged = 1;
        end
        % for low force-effort options: we log the timepoint when the
        % force-device was released
        if approachLogged && ~releaseLogged && ~(leftAccept || rightAccept)
            LogData('forceReleased', GetSecs)
            releaseLogged = 1;
        end
    end
end
LogData('hasCompleted', hasCompleted)

LogData('resultOnset', GetSecs) % of interest if option was not rejected
% if the participant accepted the option and kept responding, reward it
if hasAccepted && hasCompleted
    showReward(positions, leftFlag)
    ptb.gReward = ptb.gReward + ptb.option.reward;
end

% if not responded or not completed, punish with a timeout
if ~hasResponded || hasAccepted && ~hasCompleted
    force = checkForResponse();
    showTimeout(positions, leftFlag, force);
end
LogData('resultOffset', GetSecs)

if doAttentionCheck
    % evaluate the participants response to the forced choice...
    % part. chose left if option approached left & part. accepted:
    left1 = leftFlag && hasAccepted && hasCompleted; % accepted left
    % part. chose left if option approached right & part. rejected:
    left2 = ~leftFlag && hasResponded && ~hasAccepted; % rejected right
    % part. chose right if option approached right & part. accepted:
    right1 = ~leftFlag && hasAccepted && hasCompleted; % accepted right
    % part. chose right if option approached left & part. rejected:
    right2 = leftFlag && hasResponded && ~hasAccepted; % rejected left
    if ptb.fc.left && ~(left1 || left2) % forced choice left & not chosen
        ptb.fc.failCounter = ptb.fc.failCounter+1;
    end
    if ptb.fc.right && ~(right1 || right2) % fc right & not chosen
        ptb.fc.failCounter = ptb.fc.failCounter+1;
    end
    LogData('failCounter', ptb.fc.failCounter)
end

abortCheck();
end % ---------------------------------------------------------------------


function prepareSampleOption
% This function prepares a randomly sampled option of the environment and
% stores it data in ptb.option, resp. its texture in ptb.imgTexture.
% 
% The option is sampled out of shuffled option-pools with size of the 
% population. When a pool is depleted, an new one is created - this 
% balances the randomization.
% For training runs it avoids 3 repetitions
persistent lastBlock optionPool lastSamples si;
if isempty(lastSamples)
    lastSamples = {'foo' , 'bar'}; % to memory the last samples in training
    lastBlock = 0;  % to memory the block/environment of the current pool
    optionPool = [];% the current pool of options to draw samples from
    si = 1;         % the index of the used element of the optionPool
end

% Test if we need to renew the pool of options (new block, depleted pool)
if (lastBlock ~= ptb.blockC) || (si > length(optionPool))
    % First, get the population of options for the current environment
    population = ptb.env.population;
    optionPool = shuffle(population, 2);% second, shuffle it
    si = 1;                             % and reset index
    lastBlock = ptb.blockC;             % and update block-memory
end
sample = optionPool{si}; % Third, draw a random sample (pool was shuffled)
si = si+1;               % proceed to next option of pool

ptb.option = con.options.(sample); % recopy the option
ptb.option.name = sample;

if doTTL
    sendTTL(ptb.option.trigger)
end

% load the image-file corresponding to the option
file = [con.imgPath ptb.option.img];    % path of current option file
[img, ~, alpha] = imread(file);         % read in image data
img(:,:,4) = alpha;                     % add the alpha channel
ptb.imgTexture = Screen('MakeTexture', ptb.w, img); % create texture
end % ---------------------------------------------------------------------


function showTimeout(pos, leftFlag, force)
% This function shows the full timeout-display.
% pos       -   the positions of option & targets & bars
% leftFlag  -   1 if the left target will be approached, 0 else
% force     -   the force-values to draw the force-indicator-bars
if leftFlag
    drawOption(pos.targetL) % option at left target
else
    drawOption(pos.targetR) % option at right target
end
drawTarget(pos.targetL, ptb.color.green)
drawTarget(pos.targetR, ptb.color.green)
drawForceBar(pos.forceBarL, force, leftFlag, 'left')
drawForceBar(pos.forceBarR, force, leftFlag, 'right')
drawFuelBar(pos.fuelBar)
timeoutOnset = Screen('Flip', ptb.w);
Screen('Flip', ptb.w, timeoutOnset + con.timeoutDur);
end % ---------------------------------------------------------------------


function showReward(pos, leftFlag)
% This function shows the full reward-display.
% pos       -   the positions of option & targets
% leftFlag  -   1 if the left target will be approached, 0 else
scale = 2.0;
if leftFlag
    drawOption(pos.targetL, scale)
    drawTarget(pos.targetL, ptb.color.yellow, 0, ptb.option.reward)
    drawTarget(pos.targetR, ptb.color.green)
else
    drawOption(pos.targetR, scale)
    drawTarget(pos.targetL, ptb.color.green)
    drawTarget(pos.targetR, ptb.color.yellow, 0, ptb.option.reward)
end
drawFuelBar(pos.fuelBar, ptb.option.reward)

rewardOnset = Screen('Flip', ptb.w);
Screen('Flip', ptb.w, rewardOnset + con.rewardDur);
end % ---------------------------------------------------------------------


function elapsed = showExpanse(startTime, pos, leftFlag, force)
% This function shows a scaled option inside one of the targets (for the
% duration of one screen-flip).
% startTime -   marks the start-time
% pos       -   the positions of option & targets & bars
% leftFlag  -   1 if the left target will be approached, 0 else
% force     -   the force-values to draw the force-indicator-bars

% compute the scale for the option during the delay
elapsed = GetSecs - startTime;  % total elapsed time
p = elapsed / ptb.option.delay; % percentage of elapsed time for option
p = min(p, 1);                  % don't scale too much
scale = 1.0 + 1.0*p;            % enlarge option up too 200%

% draw & show option and targets and bars
if leftFlag
    drawOption(pos.targetL, scale)
else
    drawOption(pos.targetR, scale)
end
drawTarget(pos.targetL, ptb.color.green)
drawTarget(pos.targetR, ptb.color.green)
drawForceBar(pos.forceBarL, force, leftFlag, 'left')
drawForceBar(pos.forceBarR, force, leftFlag, 'right')
drawFuelBar(pos.fuelBar)
Screen('Flip', ptb.w);
end % ---------------------------------------------------------------------


function elapsed = showApproach(startTime, pos, leftFlag, force)
% This function shows the approach of the option towards a randomly choosen
% target (for the duration of one screen-flip). 
% startTime -   marks the start-time
% pos       -   the starting positions of option & targets & bars
% leftFlag  -   1 if the left target will be approached, 0 else
% force     -   the force-values to draw the force-indicator-bars
optionXY = pos.option;
targetL = pos.targetL;
targetR = pos.targetR;

% compute the position of the option during approach
elapsed = GetSecs - startTime;      % total elapsed time
p = elapsed / con.respWin;  % percentage of elapsed time of response-window
p = min(p, 1);                      % don't move too far
if leftFlag     % approach the left target
    newX = optionXY(1) - (optionXY(1) - targetL(1)) *p;
    newY = optionXY(2) + (targetL(2) - optionXY(2)) *p;
else            % approach the right target
    newX = optionXY(1) + (targetR(1) - optionXY(1)) *p;
    newY = optionXY(2) + (targetR(2) - optionXY(2)) *p;
end

% draw & show option and targets and bars
drawOption([newX newY])
drawTarget(targetL, ptb.color.green, ptb.fc.left)
drawTarget(targetR, ptb.color.green, ptb.fc.right)
drawForceBar(pos.forceBarL, force, leftFlag, 'left')
drawForceBar(pos.forceBarR, force, leftFlag, 'right')
drawFuelBar(pos.fuelBar)
Screen('Flip', ptb.w);
end % ---------------------------------------------------------------------


function drawOption(point, scale)
% This function draws the option at the given point, with given scale.
if nargin == 1
    scale = 1.0; % standard-scale
end

dim = 100;
scaRec = [0, 0, dim, dim]*scale; % scaled rectangle to scale the image
rect = CenterRectOnPointd(scaRec, point(1), point(2));  % shift rectangle
Screen('DrawTexture', ptb.w, ptb.imgTexture, [], rect); % draw the option
end % ---------------------------------------------------------------------


function drawTarget(point, color, forcedChoice, reward)
% This function draws a target at the given point with given color. In case
% a reward is given, an correspondig reward bar is drawn. "forcedChoice" is
% a flag that indicates if this target is the forced choice, then it will
% be indicated.
penWidth = 5;
dim = 300;
p.x = point(1);
p.y = point(2);

basisRect = [0 0 dim dim]; % determine a rectangle and...
rect = CenterRectOnPointd(basisRect, p.x, p.y); % ...shift it
Screen('FrameRect', ptb.w, color, rect, penWidth); % draw the rectangle

Screen('Textsize', ptb.w, 50); % draw a fixation cross inside the rectangle
% DrawFormattedText(ptb.w, '+', p.x-15, p.y+20, ptb.color.black);
DrawFormattedText(ptb.w, '+', 'center', 'center', ptb.color.black, ...
    [],[],[],[],[], rect);

if nargin == 3 && forcedChoice % indicate forced choice with red asterisk
    Screen('Textsize', ptb.w, 100);
    DrawFormattedText(ptb.w, '*', p.x-15, p.y+20-dim/2, ptb.color.red);
end

if nargin == 4 % draw reward-bar/points
    rewardRect = [0, 0, dim, dim/3];
    shiftUp = 220; % shift the reward-rectangle upwards above target
    
    rewardSpace = CenterRectOnPointd(rewardRect, p.x, p.y - shiftUp);
    DrawFormattedText(ptb.w, ['+ ' num2str(reward)], 'center',...
        'center', ptb.color.blue, [], [], [], [], [], rewardSpace);
end
end %----------------------------------------------------------------------


function drawFuelBar(pos, newFuel)
% This function draws a global fuel-bar at position pos and an additional
% bar for newFuel, if given.
penWidth = 3;
dim.x = 900;
dim.y = 50;
goal = 11000; % the maximal points that are displayed by the bar
fuelRect = [0, 0, dim.x, dim.y];
fuelSpace = CenterRectOnPointd(fuelRect, pos(1), pos(2));

% draw bar for so far collected fuel
percentage = ptb.gReward / goal; % reward vs. goal
fuelBar = [0, 0, dim.x* percentage, dim.y];
fuelBar = AlignRect(fuelBar, fuelSpace, 'left', 'top');
Screen('FillRect', ptb.w, ptb.color.blue, fuelBar);

if nargin == 2 % draw bar for newly collected fuel
    percentage = newFuel / goal; % new fuel as % of goal
    % use a temporary bar to compute the alignment-spot for the fuel-bar
    tempBar = fuelBar + [0, 0, dim.x * percentage, 0];
    newBar = [0, 0, dim.x* percentage, dim.y];
    newBar = AlignRect(newBar, tempBar, 'right', 'top');
    Screen('FillRect', ptb.w, ptb.color.yellow, newBar);
end

% draw empty frame
fuelRect = [0, 0, dim.x+4, dim.y+4]; % enlarge it 
fuelSpace = CenterRectOnPointd(fuelRect, pos(1), pos(2));
Screen('FrameRect',  ptb.w, ptb.color.black, fuelSpace, penWidth);
% draw rocket
rocketRect = [0, 0, 60, 60];
rocketRect = CenterRectOnPointd(rocketRect, pos(1)-500, pos(2));
Screen('DrawTexture', ptb.w, ptb.rocketTex, [], rocketRect);
end %----------------------------------------------------------------------


function drawForceBar(point, force, leftFlag, side)
% This function draws a force-indicator-bar at point, indicating the
% applied force, given by force.(side)
% point     -   struct with different points
% force     -   the force-values to draw the force-indicator-bars
% leftFlag  -   1 if the left target will be approached, 0 else
% side      -   the side of this forcebar
penWidth = 5;

% to avoid crash due to negative/minimum force, set force to 1 in such
% cases
if force.(side) <= 0
    force.(side) = 1;
end

% to avoid the force bar exceeding the rectangle, set forces > 100% to 100
if force.(side) >= 100
    force.(side) = 100;
end

p.x = point(1); % centerpoint of bar
p.y = point(2);
xDim = 25;      % dimension on x-axis
yDim = 300;     % dimension on y-axis

% determine a general drawing rectangle for all parts of the bar
basisRect = [0 0 xDim yDim]; % determine a drawing rectangle and...
forceRect = CenterRectOnPointd(basisRect, p.x, p.y); % ...shift it

% determine the actual force-bar rectangle
forceBar = [0, 0, xDim, yDim * force.(side) / 100]; % compute rect and...
forceBar = AlignRect(forceBar, forceRect, 'left', 'bottom'); % ...shift it

% determine the threshold-lines (0,0 is on left-top)
yB = p.y + yDim/2; % the bottom y-position of the bar
yO = yB - yDim * ptb.option.effort / 100; % threshold of current option
yL = yB - yDim * con.forceLow / 100;    % threshold of low-force

% draw a threshold-line according to the necessary force on this side
if leftFlag && strcmpi('left', side) || ~leftFlag && strcmpi('right', side)
    lines = [forceBar(1) yO; forceBar(3) yO]'; % only option threshold

else % for the rejection side draw threshold of low-force only
    lines = [forceBar(1) yL; forceBar(3) yL]';
end

% draw the force-bar in red if the device still needs to be released
if force.released
    barColor = ptb.color.green;
else
    barColor = ptb.color.red;
end

% draw everything (the bar at first, to place it in the background)
Screen('FillRect', ptb.w, barColor, forceBar); % bar
Screen('FrameRect', ptb.w, ptb.color.yellow, forceRect, penWidth); % frame
Screen('DrawLines', ptb.w, lines, penWidth, ptb.color.black); % thresholds
end % ---------------------------------------------------------------------


function prepareForcedChoice
% This function determines if the upcoming trial will be a forced choice
% and chooses the side.
ptb.fc.left = 0;    % flag for forced-choice left
ptb.fc.right = 0;   % flag for forced-choice right

if doAttentionCheck % else, both flags are false anyway
    pop = shuffle({0 0 0 1}, 2);
    doFC = pop{1}; % 25% chance for 1 := do forced choice
    
    if doFC % if we do forced choice, decide which side it will be
        leftFlag = randi([0 1]);% choose randomly a target
        ptb.fc.left = leftFlag;     % 1, if leftFlag = 1
        ptb.fc.right = ~leftFlag;   % 0, if leftFlag = 1
    end
    LogData('ForcedChoiceLeft', ptb.fc.left)
    LogData('ForcedChoiceRight', ptb.fc.right)
end
end %----------------------------------------------------------------------


function forceData = checkForResponse(restart)
% This function checks if there is a response for one side and returns the
% force of this response, values mapped to the range [0 100].
% force.left & force.right give the force of the respective side,
% force.released flags if the device was released.
% ATTENTION - it has to be initialized with the 'restart' parameter and
% then be used without the parameter. The flag force.released indicates if
% the device was released once since restart, so you can prevent unwanted
% votings by an unintentional holding.
% For key-control, keys got a fixed force-value assigned.
persistent keys force sampleTime mappings;

if nargin == 1 && strcmp(restart, 'restart') || isempty(sampleTime)
    force.left = 0;
    force.right = 0;
    force.released = 0; % 1 if released, 0 otherwise
    mappings.left = 0; % for smoothing the GFD mappings
    mappings.right = 0;

    % For key-control, we need to monitor & memorize the key-states, 
    % because firstPress and firstRelease are only flagged in moment of
    % key-press/-release and reset for the next check. You don't get a 
    % display of current state.
    keys.left = 0; % memory for key-states
    keys.right = 0;
    keys.left2 = 0;
    keys.right2 = 0;

    % We want to poll the GFD/Joystick for its state only as often as the 
    % display refreshes, to ensure a constant data rate.
    sampleTime = GetSecs; % to keep track of the last poll

    forceData = force;
    return
end

if doJoystick   % joystick controlled
    if GetSecs > sampleTime % poll the next value
        sampleTime = sampleTime + ptb.ifi;

        % get current joystick mapping
        Joystick.X = WinJoystickMex(ptb.joySpec.Handle);
        joyMap = MapJoystickPosition(Joystick, ptb.joySpec, [-100 100]);

        % determine the force
        force.left = max(0, -joyMap);
        force.right = max(0, joyMap);

        % log joystick mapping
        output.forceTraject = [output.forceTraject; 
            ptb.trialC, GetSecs, joyMap]; 
    
        % check if device was released once since restart 
        if ~force.released
            if abs(joyMap) < con.forceRelease
                force.released = 1;
            end
        end
        abortCheck();
    end

elseif doGFD    % GripForce-Device controlled
    if GetSecs > sampleTime % poll the next value
        sampleTime = sampleTime + ptb.ifi;
    
        [GripFDev.X, GripFDev.Y] = WinJoystickMex(output.GripFSpec.Handle);
        [mapL, mapR] = MapGripforcePosition( ...
            GripFDev, output.GripFSpec, [0 100]);

%         % smooth the GFD mappings
%         alpha = 0.1;
%         mappings.left = [mappings.left; mapL];
%         mappings.right = [mappings.right; mapR];
%         smoothL = filter(alpha, [1 alpha-1], mappings.left);
%         smoothR = filter(alpha, [1 alpha-1], mappings.right);
%         % use the smoothed values as feedback values
%         force.left = smoothL(end);
%         force.right = smoothR(end);
% 
%         % log GFD mappings etc.
%         output.forceTraject = [output.forceTraject;
%             ptb.trialC, GetSecs, mapL, mapR, smoothL(end), smoothR(end)];

        % use the raw mappings as feedback
        force.left = mapL;
        force.right = mapR;

        % log GFD mappings etc.
        output.forceTraject = [output.forceTraject;
            ptb.trialC, GetSecs, mapL, mapR];
    
        % check if device was released once since restart
        if ~force.released 
            if mapL < con.forceRelease && mapR < con.forceRelease
                force.released = 1;
            end
        end
        abortCheck();
    end

else % key controlled
    % Monitor and memorize the key-states, because firstPress and
    % firstRelease are only flagged in moment of key-press/-release and
    % reset for the next check. You don't get a display of current state.
    [~, firstPress, firstRelease] = abortCheck();

    % check for a key press
    if firstPress(ptb.keys.left2)
        keys.left2 = 1;
    elseif firstPress(ptb.keys.right2)
        keys.right2 = 1;
    elseif firstPress(ptb.keys.left)
        keys.left = 1;
    elseif firstPress(ptb.keys.right)
        keys.right = 1;
    end

    % check for release of keys
    if firstRelease(ptb.keys.left2)
        keys.left2 = 0;
    elseif firstRelease(ptb.keys.right2)
        keys.right2 = 0;
    elseif firstRelease(ptb.keys.left)
        keys.left = 0;
    elseif firstRelease(ptb.keys.right)
        keys.right = 0;
    end

    % update force.released-flag
    if keys.left + keys.left2 + keys.right + keys.right2 == 0
        force.released = 1;
    end

    % set force-values according to current key-states
    if keys.left2
        force.left = con.forceHigh;
    elseif keys.left
        force.left = con.forceLow;
    else
        force.left = 0;
    end
    if keys.right2
        force.right = con.forceHigh;
    elseif keys.right
        force.right = con.forceLow;
    else
        force.right = 0;
    end
end
forceData = force;
end % ---------------------------------------------------------------------


function showISI
% This function shows an fixation cross after the selected cues
Screen('Textsize', ptb.w, 100);
DrawFormattedText(ptb.w, '+', 'center', 'center', ptb.color.black);
isiOnset = Screen('Flip', ptb.w);
LogData('ISIonset', isiOnset)

% show isi until here
isiOffset = Screen('Flip', ptb.w, isiOnset + con.isiDur);
LogData('ISIoffset', isiOffset)

abortCheck();
end % ---------------------------------------------------------------------


function showGlobalOutcome
% This function shows the global reward of the participant & halfs the
% total reward in case of more than 5 incorrect forced choices.
if ptb.fc.failCounter > 5
    ptb.gReward = ptb.gReward/2;
end

text = txt('gReward');
Screen('Textsize', ptb.w, 50);
DrawFormattedText(ptb.w, text, 'center', 'center', ptb.color.black);
gRewardOnset = Screen('Flip', ptb.w);
Log(gRewardOnset, 'GlobalOutcome:', ptb.gReward)

% show global result until here/now
lastOnset = Screen('Flip', ptb.w, gRewardOnset + con.gRewardDur);
Log(lastOnset, 'End')

if doTTL
    sendTTL(con.trigger.end);
end

abortCheck();
end % ---------------------------------------------------------------------


function LogData(fieldName, value)
% This function logs a value for a fieldname during the trial-loop. Not
% outside of it! Use it only after the current option is set.
tc = ptb.trialC; % use the global trial counter

% collect some standard-data, available at start of each trial
output.dataMat(tc).ID = subj.id;
output.dataMat(tc).session = subj.sess;
output.dataMat(tc).run = subj.run;
output.dataMat(tc).cond = subj.cond;
output.dataMat(tc).block = ptb.blockC;      % current block number
output.dataMat(tc).trialID = ptb.trialC;    % current trial (global count)
output.dataMat(tc).environment = ptb.env.name;  % current environment
output.dataMat(tc).option = ptb.option.name;    % current option
output.dataMat(tc).gReward = ptb.gReward;       % current reward account

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
% This function saves all the data & cleans up
if output.doTraining
    subId = [output.task 'Train_' output.studyID '_' subj.ids...
            '_S' num2str(subj.sess) '_R' num2str(subj.run)];
else
    subId = [output.task '_' output.studyID '_' subj.ids...
        '_S' num2str(subj.sess) '_R' num2str(subj.run) ];
end
save([output.savePath '\' subId], 'output', 'subj'); % save important data
save([output.backupPath '\' subId '_backup_' output.dateStart]);% save all

KbQueueRelease();   % release keyboard logging
sca                 % close all PTB Screens

if doTVNS
    if subj.tVNS_manager % restart stimulation
        [~,~,~] = send(ptb.tvnsInfo.reqTreatOff, ptb.tvnsInfo.tvnsURL);
        [~,~,~] = send(ptb.tvnsInfo.reqTreatOn, ptb.tvnsInfo.tvnsURL);
        if doTTL
            sendTTL(con.trigger.tvns_off);
        end
    end
end

if doTTL
    closeTTL();
end
end % ---------------------------------------------------------------------


function saveTempFile
% This function saves the current workspace as temporal backup

if output.doTraining
    subId = [output.task 'Train_' output.studyID '_' subj.ids...
            '_S' num2str(subj.sess) '_R' num2str(subj.run)];
else
    subId = [output.task '_' output.studyID '_' subj.ids...
        '_S' num2str(subj.sess) '_R' num2str(subj.run) ];
end
save([output.backupPath '\' subId '_temp_' output.dateStart]);
end % ---------------------------------------------------------------------


function [pressed,firstPress,firstRelease,lastPress,lastRelease]=abortCheck
% This function uses KbQueueCheck to monitor if the escapeKey was pressed
% If so, it trhows an error. Else, it behaves like KbQueueCheck, for
% return-values refer to help of KbQueueCheck. In both cases it logs the 
% response.

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


function waitUntilResponse
% This function waits until any key response and continues then, except the
% abort-key was pressed. In case of doJoystick=1 it alternatively looks if
% the joystick response exceeds the joystick-response-threshold. (similar
% for gripforce-device & doGFD=1
Log(GetSecs, 'waitUntilResponse')

checkForResponse('restart'); % demand a release of the device
while 1
    force = checkForResponse();
    if force.released % check if device was released once since restart
        % check for any valid response above threshold
        if force.left >= con.forceLow || force.right >= con.forceLow
            break;
        end
    end
    WaitSecs(0.01);
end
Log(GetSecs, 'continueAfterResponse')
end % ---------------------------------------------------------------------


function lText = txt(field)
% This function returns the textstring specified by 'field', according to
% the sessions language.

% distinguish between input options
if doJoystick
    device = ' den Joystick nach ';
    input = ' the joystick to the ';
elseif doGFD
    device = ' den Griff ';
    input = ' the handle ';
else
    device = ' die strg-Taste ';
    input = ' the ctrl-key ';
end

% distinguish between effort variants (setting in condition file)
if con.delayDiff % high & low effort differ in delay
    effort = 'time';
    effortD = 'Zeit';
    
else % high & low effort differ in force
    if doGFD
        effort = 'force';
        effortD = 'Kraft';
    else
        % without GFD there is no real difference, should only apply to 
        % training, preceeding the full task conducted in MRI with GFD
        effort = 'effort';
        effortD = 'Aufwand';
    end
end

% text at bottom of instructions, to hint howto proceed
lt.proceed.de = ['Drücken Sie' device 'links oder rechts für "Weiter"'];
lt.proceed.eng = ['Press' input 'left or right to proceed'];

% text in advance to the main task
lt.ready.de = ['Das eigentliche Spiel beginnt jetzt. Denken Sie daran, dass es Ihr Ziel ist, in der vorgegebenen Zeit so viel Treibstoff wie möglich zu bekommen.' ...
    ' Um dieses Ziel zu erreichen, kann es von Vorteil sein, Ihre Wahl an die Galaxie anzupassen. Der Treibstoff wird nach dem Spiel in eine Bonuszahlung für Sie umgewandelt.' ...
    ' ' num2str(con.moneyExample) ' Liter sind ' num2str(con.moneyFactor*con.moneyExample) ' Cent wert.' ...
    '\n\nWenn Sie bereit sind zu beginnen, drücken Sie' device 'links oder rechts!'];
lt.ready.eng = ['The real game is starting now. Remember that your goal is to get as much fuel in the given time as possible.' ...
    ' To achieve this goal it might be beneficial to adapt your choice to the galaxy. The fuel will be translated into bonus payment for you after the game.' ...
    ' ' num2str(con.moneyExample) ' liters are worth ' num2str(con.moneyFactor*con.moneyExample) ' cents.' ...
    ' \n\nWhen you are ready, press' input 'left or right!'];

% here begins the long variant of the instructions
lt.instr1.de = ['Im Folgenden haben Sie die Möglichkeit, eine der Aufgaben kennenzulernen und zu üben, die Sie später im MRT durchführen werden.' ...
    ' Bitte lesen Sie alle folgenden Anweisungen sorgfältig durch. Es braucht etwas Zeit, aber sonst wissen Sie nicht, was Sie tun sollen!'];
lt.instr1.eng = ['In the following, you will have the opportunity to get to know and practice one of the tasks that you will later perform in the MRI scanner.' ...
    ' Please read all of the following instructions carefully. It takes some time, but otherwise you will not know what to do!'];

lt.instr2.de = ['In diesem Spiel haben Sie das Kommando über ein Raumschiff, das durch den Weltraum reist. Leider gibt es ein Problem: Ihr Treibstoffvorrat geht gefährlich zu Neige ... \n' ...
    ' Zufällig sind Sie in einen Bereich des Weltraums gelangt, in dem eine Gemeinschaft hilfreicher Aliens zuhause ist.'];
lt.instr2.eng = ['In this game, you are the captain of a spaceship travelling through space. Unfortunately, there is a problem: you are running dangerously low on fuel... \n' ...
    'By chance, you have entered an area of space which is home to a community of helpful space aliens.'];

lt.instr3.de = ['Wenn Sie diese Aliens fangen, erhalten Sie unterschiedliche Mengen an Treibstoff. Jedoch braucht das Fangen auch unterschiedlich viel ' effortD '.' ...
    ' Sie müssen also entscheiden, welche Aliens Sie fangen wollen, um während Ihrer Zeit hier so viel Treibstoff wie möglich zu bekommen.'];
lt.instr3.eng = ['If you catch these aliens, they will provide you with different amounts of fuel. But they also take different amounts of ' effort ' to catch.' ...
    ' You need to decide which aliens you want to catch in order to get as much fuel as you can from your time here.'];

lt.instr4.de = ['Die Aliens befinden sich in drei verschiedenen Galaxien, durch die Sie alle reisen werden.' ...
    ' Einige Arten von Aliens sind in einer Galaxie häufiger zu finden als in der anderen. Daher könnte es von Vorteil sein, Ihre Wahl der Galaxie anzupassen.'];
lt.instr4.eng = ['The aliens can be found in three different galaxies, all of which you will journey through.' ...
    ' Some types of aliens are more commonly found in one galaxy than the other. Therefore it might be beneficial to adapt your choice to the galaxy.'];

lt.instr5.de = ['Während des Spiels erscheinen auf Ihrer Reise zwei Ziele auf dem Bildschirm, eines auf der linken und eines auf der rechten Seite.' ...
    ' Verschiedene Aliens werden sich schnell einem dieser beiden Ziele nähern. Wenn Sie ein sich näherndes Alien fangen wollen, müssen Sie zwei Dinge tun: '];
lt.instr5.eng = ['During the game, two targets will appear on the screen as you travel; one on the left and one on the right.' ...
    ' Different aliens will quickly approach either one of these targets. If you want to catch an approaching alien you need to do two things: '];

lt.instr6.de = ['1) Wählen Sie das Ziel, dem es sich nähert - wenn Sie warten, bis das Alien tatsächlich im Ziel ist, ist es zu spät!' ...
    ' Wählen Sie das linke Ziel indem Sie' device 'links drücken und das rechte Ziel indem Sie' device 'rechts drücken.' ...
    ' Das Alien wird in die Zielscheibe springen, um anzuzeigen, dass es ausgewählt ist.' ...
    ' Für unterschiedliche Aliens benötigen sie unterschiedlich viel ' effortD '.'];
lt.instr6.eng = ['1) Select the target it approaches - if you wait until the alien is actually inside the target this is too late!' ...
    ' Select the left target by pressing' input 'left and the right target by pressing' input 'right.' ...
    ' The alien will jump into the target to indicate it is selected.' ...
    ' For different alien you will need different amount of ' effort '.'];

lt.instr7.de = ['2) Halten Sie' device 'links bzw. rechts gedrückt und das Alien wird größer.\nWenn Sie das Alien erfolgreich gefangen haben, wird es aufhören größer zu werden und Sie sehen, wie' ...
    ' viel Treibstoff das Alien Ihnen zur Verfügung gestellt hat. Dann können Sie loslassen. Beachten Sie auch, dass die Aliens schnell erscheinen - entscheiden Sie schnell!'];
lt.instr7.eng = ['2) Keep the' input 'left or right pressed and the alien will get bigger.\n\nWhen you have successfully captured the alien, the alien will stop getting bigger and you' ...
    ' will see how much fuel the alien has provided you with. Then you can release. Also note that aliens appear quickly - you need to be fast to make a choice!'];

lt.instr8.de = ['Falls sie ein Alien nicht fangen wollen und es durch Auswählen der anderen Seite ablehnen, bekommen Sie schneller die Möglichkeit ein anderes, womöglich besseres Alien zu fangen.' ...
    ' Ihre Aufenthaltszeit in dieser Galaxie ändert sich nicht!'];
lt.instr8.eng = ['If you do not want to catch an alien and reject it by selecting the other side, you will be given the opportunity to catch another, possibly better alien more quickly.' ...
    ' Your stay time in this galaxy will not change!'];

lt.instr9.de = ['OK. Versuchen wir es mit einem Training, um Sie mit der Aufgabe vertraut zu machen.' ...
    ' Der Treibstoff, den Sie bei diesem Training erhalten, wird nicht auf Ihre Bonuszahlung angerechnet - dies ist nur zur Uebung.'];
lt.instr9.eng = ['OK. Let us try some training to familiarize you with the task.' ...
    ' The fuel you get during this training will not count towards your bonus payment - this is just for practice.'];

% here begins the short variant of the instructions
lt.instrS1.de = 'In der nun folgenden Uebung haben Sie das Kommando über ein Raumschiff und müssen durch das Sammeln von Aliens Treibstoff beschaffen.';
lt.instrS2.de = ['Wenn Sie das richtige Spiel beginnen, gibt es 4 verschiedene Arten von Aliens, zur Uebung aber nur 2. Zum Fangen braucht es bei einigen dieser Aliens mehr ' effortD ' als bei anderen' ...
    ' und einige dieser Aliens liefern mehr Treibstoff als andere. Denken Sie daran, dass Ihr Ziel darin besteht, so viel Treibstoff wie möglich in der zur Verfügung stehenden Zeit zu bekommen.'];
lt.instrS3.de = ['Dazu muss man entscheiden, welche Aliens man zu fangen versucht, und welche nicht.' ...
    ' Zudem gibt es drei verschiedene Galaxien im Spiel; sie haben alle unterschiedliche Hintergrundfarben. Sie werden während des Spiels in jede dieser Galaxien reisen.'];
lt.instrS4.de = ['Die Gesamtzeit, die Sie in den drei Galaxien reisen, um so viel Treibstoff wie möglich zu sammeln, beträgt 30 Minuten.' ...
    ' In jeder dieser Galaxien treffen Sie auf die gleichen Arten von Aliens, aber die Häufigkeit der Alienbegegnungen kann variieren.' ...
    ' Daher könnte es von Vorteil sein, Ihre Auswahl an die Galaxie anzupassen.'];
lt.instrS5.de = ['Das Prinzip der Aufgabe kennen Sie schon. Zur Erinnerung: drücken Sie zum Einfangen oder Ausweichen der Aliens' device 'links oder rechts. ' ...
    'Denken Sie daran: sobald die gewonnene Menge Treibstoff angezeigt wird, können Sie loslassen.'];
lt.instrS6.de = ['Das bedeutet, dass Sie' device 'rechts drücken können, wenn Sie ein Alien auf der rechten Seite fangen wollen und' device 'links, wenn Sie ein Alien auf der linken einfangen wollen.' ...
    ' Beim Ausweichen eines Aliens drücken Sie die entgegengesetzte Seite.'];

lt.instrS1.eng = 'During the following practice you are the captain of a spaceship and need to collect aliens in order to obtain fuel';
lt.instrS2.eng = ['When you start the game for real there will be 4 different types of aliens, but only 2 during this practice. To catch, some of these types will need more ' effort ' than others.' ...
    ' And some of these types will provide more fuel than others. Remember that your goal is to try and get as much fuel as you can in the time you have available.'];
lt.instrS3.eng = ['This requires deciding which aliens you should and should not try to catch. ' ...
    'Finally, there are three different galaxies in the game; they all have different background colours. You will travel in each of these galaxies during the game.'];
lt.instrS4.eng = ['The total time you have to travel in the three galaxies to collect as much fuel as possible will be 30 minutes.' ...
    ' You will encounter the same types of aliens in each of these galaxies. But the frequency of alien encounters can vary.' ...
    ' Therefore it might be beneficial to adapt your choice to the galaxy.'];
lt.instrS5.eng = ['You already know the principle of the task. Remember: to catch or avoid the aliens, press' device 'left or right.' ...
    ' As soon as the amount of fuel you have gained is displayed, you can let go.'];
lt.instrS6.eng = ['This means that you can press' device 'right when you want to capture an alien on the right side and press' device 'left when capturing an alien on the left side.' ...
    ' When avoiding an alien you use the opposite side.'];

% text to introduce the long training blocks (for outside MRI training)
% catch
if strcmpi(effort, 'effort') % neither delay-effort nor using GFD
    lt.train1_1.de = 'Lassen Sie uns anfangen. Versuchen Sie in diesem Block alle Aliens zu fangen.';
    lt.train1_1.eng = 'Let us start. Try to catch all aliens in this run.';
else
    lt.train1_1.de = ['Lassen Sie uns anfangen. Versuchen Sie in diesem Block alle Aliens zu fangen. Für unterschiedliche Aliens brauchen sie unterschiedlich viel ' effortD '!'];
    lt.train1_1.eng = ['Let us start. Try to catch all aliens in this run. For different alien, you will need different amount of ' effort '!'];
end
% avoid
lt.train2_1.de = ['Manche Arten von Aliens sind besser als andere. Im letzten Training, das Sie gemacht haben, haben Sie vielleicht bemerkt, dass es zwei Aliens gab.' ...
    ' Eins von ihnen gab Ihnen viel Treibstoff, das andere Alien lieferte wenig Treibstoff. Später im MRT werden die Aliens auch unterschiedlich schwer zu fangen sein!'];
lt.train2_1.eng = ['Some types of aliens are better than others. In the training you did, you may have noticed that there were two aliens.' ...
    ' One of these gave you a lot of fuel. The other alien did not provide you with much fuel. Later in MRI, the aliens will also vary in difficulty to catch!'];

lt.train2_2.de = ['Um ein Alien passieren zu lassen, anstatt es zu fangen, müssen Sie das Ziel auswählen, dem sich das Alien nicht nähert.' ...
    ' Es ist nicht nötig,' device 'links/rechts gedrückt zu halten. Drücken Sie einfach einmal kurz, um das Ziel auszuwählen, und lassen Sie dann los.'];
lt.train2_2.eng = ['To let an alien pass rather than catch it you need to: Select the target that the alien is not approaching.' ...
    ' There is no need to keep' input 'left or right pressed. Simply press once briefly to select the target and then release.'];

lt.train2_3.de = [' Das Alien wird dann sicher durch das gegenüberliegende Ziel fliegen, ohne gefangen zu werden und das Spiel geht weiter.' ...
    ' Sie werden keinen Treibstoff sammeln, aber Sie werden auch keine Zeit für das Fangen verlieren und das Spiel wird fortgesetzt.' ...
    ' Sobald Sie sich entschieden haben, einem Alien auszuweichen, können Sie Ihre Meinung nicht mehr ändern.'];
lt.train2_3.eng = ['The alien will then safely pass through the opposite target without being caught and the game will continue.' ...
    ' You will not collect any fuel but you will not use up any time trying to capture it and the game will continue.' ...
    ' Once you have decided to avoid an alien, you cannot change your mind.'];

lt.train2_4.de = 'Lassen Sie uns üben! Versuchen Sie nun allen Aliens auszuweichen, indem Sie das dem Alien gegenüberliegende Ziel wählen.';
lt.train2_4.eng = 'Lets practice! Now try to avoid all aliens by choosing the opposite target.';
% maximize
lt.train3_1.de = ['Am Ende der Aufgabe wird die Menge an Treibstoff, die Sie gesammelt haben, in eine Bonuszahlung umgewandelt.' ...
    ' Je mehr Treibstoff Sie in Ihrer Zeit sammeln, desto höher wird Ihre Bonuszahlung sein! ' num2str(con.moneyExample) ' Liter sind dabei ' num2str(con.moneyFactor*con.moneyExample) ' Cent wert.' ...
    ' Wie Sie vielleicht schon bemerkt haben, können Sie ein Alien auch verpassen. Wenn das passiert, reduziert sich die Größe des Alien wieder und es passiert nichts mehr.'];
lt.train3_1.eng = ['At the end of the task, the amount of fuel you collected will be converted into a bonus payment.' ...
    ' The more fuel you get during your time, the higher your bonus payment will be! ' num2str(con.moneyExample) ' liters are worth ' num2str(con.moneyFactor*con.moneyExample) ' cents.' ...
    ' As you might have noticed, missed responses can occur. When this happens the size of the alien reduces again and nothing is happening anymore.'];

lt.train3_2.de = ['In diesem Fall bekommen Sie keinen Treibstoff und müssen warten, bis das Alien verschwindet, was einige Zeit dauert.' ...
    ' Eine verpasste Chance kann aus folgenden Gründen auftreten:'];
lt.train3_2.eng = ['In that case you are not getting any fuel and you have to wait until the alien disappears which takes time.' ...
    ' A missed response will occur for the following reasons:'];

lt.train3_3.de = ['(1) Wenn Sie es versäumen, eines der beiden Ziele zu wählen, sobald sich ein Alien nähert' ...
    ' (denken Sie daran, dass es in Ordnung ist, wenn Sie es vorziehen, ein Alien nicht zu fangen, aber dazu müssen Sie das Ziel wählen, dem sich das Alien nicht nähert).'...
    ' (2) Wenn Sie versuchen, ein Alien zu fangen, aber das Ziel auswählen, nachdem das Alien das Ziel erreicht hat.'];
lt.train3_3.eng = ['(1) If you fail to select either one of the two targets when an alien is approaching' ...
    ' (remember it is fine if you prefer not to catch an alien, but to do this you need to select the target it is not approaching).'...
    ' (2) If you try to catch an alien but select the target after the alien has reached the target.'];

lt.train3_4.de = ['(3) Wenn Sie versuchen, ein Alien zu fangen, aber zu früh loslassen (d.h. bevor es erfolgreich gefangen wurde).' ...
    ' \nVersuchen wir nun, Ihren Treibstoff so schnell wie möglich in der gegebenen Zeit zu maximieren.'];
lt.train3_4.eng = ['(3) If you start trying to catch an alien but release too early (i.e. before it is successfully captured).' ...
    ' \nOK. Now let us try to maximize your fuel as fast as possible in the given time.'];

% text to introduce the short training blocks (for inside MRI training)
% catch
if strcmpi(effort, 'effort') % neither delay-effort nor using GFD
    lt.trainS1_1.de = 'Lassen Sie uns das üben. Versuchen Sie, alle Aliens zu fangen.';
    lt.trainS1_1.eng = 'Let us practice this. Try to catch all aliens.';
else
    lt.trainS1_1.de = ['Lassen Sie uns das üben. Versuchen Sie, alle Aliens zu fangen. Für unterschiedliche Aliens brauchen sie unterschiedlich viel ' effortD '!'];
    lt.trainS1_1.eng = ['Let us start. Try to catch all aliens in this run. For different alien, you will need different amount of ' effort '!'];
end
% avoid
lt.trainS2_1.de = 'Versuchen Sie nun allen Aliens auszuweichen, indem Sie das dem Alien gegenüberliegende Ziel wählen.';
lt.trainS2_1.eng = 'Now try to avoid all aliens by choosing the opposite target.';
% maximize
lt.trainS3_1.de = ['Nun versuchen Sie Ihren Treibstoff so schnell wie möglich zu maximieren.'...
    ' Der Treibstoff, den Sie bei diesem Training erhalten, wird nicht auf Ihre Bonuszahlung angerechnet - dies ist nur zur Uebung.'];
lt.trainS3_1.eng = ['Now try to maximize your fuel as fast as possible.'...
    ' The fuel you get during this training will not count towards your bonus payment - this is just for practice.'];

% text to announce the blocks of the main task
lt.newBlock1.de = 'Sie haben die erste Galaxie erreicht!';
lt.newBlock1.eng = 'You have reached the first galaxy!';

lt.newBlock2.de = 'Sie haben die erste Galaxie geschafft und erreichen jetzt die zweite Galaxie!';
lt.newBlock2.eng = 'You completed the first galaxy and you are now reaching the second galaxy!';

lt.newBlock3.de = 'Sie haben die zweite Galaxie geschafft und erreichen jetzt die dritte Galaxie!';
lt.newBlock3.eng = 'You completed the second galaxy and you are now reaching the third galaxy!';

% text to give an outlook for the MRI run, after the outside MRI training
lt.mriProsp1.de = ['Die Aufgabe, die Sie hier kennengelernt haben, werden Sie später im MRT in drei Durchgängen durchführen. Dort werden Sie Ihre Auswahl über Handgriffe treffen können.' ...
    ' Sie werden die Aufgabe im MRT mit den Handgriffen noch einmal üben können, bevor die tatsächliche Aufgabe startet. Später wird Ihr gesammelter Treibstoff in eine Belohnung umgewandelt!'];
lt.mriProsp1.eng = ['You will perform the task you have learned here later in the MRI in three passes. Instead of buttons, you will be able to make your selection using handles.' ...
    ' You will be able to practice the task in the MRI using the hand grips again before the actual task starts. All the fuel you will collect will be later translated into money for you to win!'];

% some other texts
lt.waitMRI.de = 'Wir warten kurz auf das MRT.';
lt.waitMRI.eng = 'We wait a moment for the MRI.';

lt.gReward.de = ['Gesamt-Gewinn: ' num2str(ptb.gReward)...
    ' \n\n'...
    ' Das entspricht ' num2str(ceil(ptb.gReward*con.moneyFactor)/100) ' Euro.']; % 1 point corresponds to 0.05 cent (divided by 100 to get money in euros)
lt.gReward.eng = ['Overall reward: ' num2str(ptb.gReward)...
    ' \n\n'...
    ' This corresponds to ' num2str(ceil(ptb.gReward*con.moneyFactor)/100) ' euros.']; % 1 point corresponds to 0.05 cent (divided by 100 to get money in euros)

lText = lt.(field).(subj.language);
end % ---------------------------------------------------------------------


function ret = shuffle(inp, dim)
% This function shuffles a matrix "inp" in the dimension "dim"
% inp - the data to shuffle
% dim - the dimension to shuffle
if nargin < 2
    dim = 2;
end
s = size(inp);
p = randperm( s(dim) );

if dim == 1
    ret(p,:) = inp;
else
    ret(:,p) = inp;
end
end %----------------------------------------------------------------------


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
