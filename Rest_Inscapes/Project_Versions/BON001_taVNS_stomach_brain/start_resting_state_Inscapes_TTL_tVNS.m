%%===================Resting-state with Inscapes===================
%For a description of Inscapes, see Vanderwal (2015) NIMG

%Coded by: Vanessa Teckentrup
%Coded with: Matlab R2017b using Psychtoolbox 3
% Changes by Paul Jung, 25.08.2023 - added functions to send EGG trigger
% through the TTL box from "The Black Box Toolkit" - added function to
% wait for scanner triggers from serial port

%========================================================

clear
close all
AssertOpenGL;

keyQuit = KbName('q');
disp(['Abort-key is : ' KbName(keyQuit)])

% subject information
subj.studyID='BON001';
subj.subjectID=input('Subject ID: ','s');

subj.sessionID=input('Session ID: ','s');
subj.cond = input('Condition [0 or 1]: ','s'); % active stimulation (1) or sham (0)

% ensure that the correct condition was provided
    correct_cond = 0;
    while correct_cond ~= 1
        % test if condition input was correct
        if strcmp(subj.cond, '0') || strcmp(subj.cond, '1')
            correct_cond = input(['The specified condition is '...
                num2str(subj.cond) '. Is this correct (1) or not (0)?: ']);
        elseif ~ismember(subj.cond, 0:1)
            fprintf(['\nThe specified condition is not a valid' ...
                ' condition for BON001! ']);
        end
        if correct_cond ~= 1
            subj.cond = input(['Please enter the correct condition' ...
                ' [0 or 1]: '],'s');
        end
    end
    
subj.runID=input('Run ID [1 or 2]: ','s'); % baseline + stimulation (run 1) or stimulation only (run 2)
subj.tVNS_manager = input('Use tVNS manager [1] or start stimulation manually [0]?: ');

% settings for tVNS manager (regular stimulation/sham stimulation)
subj.stim_amplitude = input('Stimulation intensity [muA]: ');
subj.stim_length = 30;
subj.pause_length = 30;
subj.stim_freq = 25;
subj.stim_impDur = 250;

% settings for tVNS manager during baseline (low intensity stimulation)
if subj.tVNS_manager
    subj.low_stim_amplitude = 100;
    subj.low_stim_length = 1;
    subj.low_pause_length = 30;
    subj.low_stim_freq = 1;
    subj.low_stim_impDur = 250;
end

% subj.lang_de = input ('Language German [1/0]: ','s'); %changes display language to German
% lang_de = str2double (subj.lang_de);
lang_de = 1;

subj.sess = str2double(subj.sessionID); %converts Session ID to integer
subj.run = str2double(subj.runID); %converts run ID to integer
subj.num = str2double(subj.subjectID); %converts Subject ID to integer
subj.subjectID = [repmat('0',1,6-length(subj.subjectID)) subj.subjectID];


%paradigm settings
%path_inscapes = 'E:\neuroMADLAB\Inscapes';
path_inscapes = pwd;
filename_inscapes = 'Inscapes_10_minutes_version3.mp4';
do_fullscreen = 1; %will show window as fullscreen (default second monitor, if connected)
do_fmri_flag = 1; %will include trigger
flip_flag_horizontal = 0; % Flip screen left/right for one-sided mirror at Radiology
flip_flag_vertical = 0;
dummy_volumes = 0; %will have to be set according to the sequence
scan_duration = 600; % scan duration in seconds
% scan_duration = 180; % scan duration in seconds

% settings for TTL box
settings.do_EGG = 1;
trigDur = 0.005; % duration for sending triggers in seconds
settings.EGG.trigger.exp_on = 1; % trigger code for experiment start
settings.EGG.trigger.movie_on_baseline = 10; % trigger code for Baseline movie on
settings.EGG.trigger.tvns_on_baseline = 11;
settings.EGG.trigger.movie_end_baseline = 20; % trigger code for Baseline movie off
settings.EGG.trigger.tvns_end_baseline = 21;
settings.EGG.trigger.movie_on_stimulation = 100; % trigger code for Stimulation movie on
settings.EGG.trigger.tvns_on_stimulation = 101;
settings.EGG.trigger.movie_end_stimulation = 200; % trigger code for Stimulation movie off
settings.EGG.trigger.tvns_end_stimulation = 201;
settings.EGG.trigger.exp_off = 255; % trigger code for experiment end

if settings.do_EGG % then prepare TTL box from "The Black Box Toolkit"
        prepareTTL('COM7', 115200, trigDur); % COM-7 for L&B, COM3 for behavioural testing laptop
    % prepareTTL('COM3', 115200, trigDur);
end

count_trigger = 0;


% Create output folders if non-existent
if ~exist([pwd filesep 'Data'], 'dir')
    mkdir('Data')
end

if ~exist([pwd filesep 'Backup'], 'dir')
    mkdir('Backup')
end


% This if-branch restarts the tVNS stimulation at the beginning of the 2nd
% run and gives the experimenter the opportunity to check & repair the
% bluetooth connection between device and manager, if necessary.
if subj.run == 2 && subj.tVNS_manager 
% Developer note: this if-branch would fit very nice into the if branch of
% the 2nd run (~line 460), but we need this here, before the first PTB 
% screen gets the focus!

    % stop and re-start stimulation
    tvnsInfo = setupTVNS(subj.stim_amplitude,subj.stim_impDur,subj.stim_freq,subj.stim_length, subj.pause_length);
    [~,~,~] = send(tvnsInfo.reqTreatOff, tvnsInfo.tvnsURL);
    [~,~,~] = send(tvnsInfo.reqTreatOn, tvnsInfo.tvnsURL);
    timestamps.time_stim_on = GetSecs;
    if settings.do_EGG
        sendTTL(settings.EGG.trigger.tvns_on_stimulation)
    end

    % now the experimenter needs to check if manager & device still work
    disp('Please check the tVNS manager window if the stimulation is still running.')
    allOk = input('Please enter 1 if everything is ok, enter 0 if we need to restart the stimulation : [0/1] ');
    while ~allOk
        disp('Please re-establish the bluetooth connection between device and tVNS manager before restarting!')
        doRestart = input('Shall we restart stimulation now? : [0/1] ');
        % restart of normal stimulation, 2. run
        if doRestart
            tvnsInfo = setupTVNS(subj.stim_amplitude,subj.stim_impDur,subj.stim_freq,subj.stim_length, subj.pause_length);
            [~,~,~] = send(tvnsInfo.reqTreatOn, tvnsInfo.tvnsURL);
            timestamps.time_stim_on = GetSecs;
            if settings.do_EGG
                sendTTL(settings.EGG.trigger.tvns_on_stimulation)
            end
        end
        allOk = input('Please enter 1 if everything is ok, enter 0 if we need to restart the stimulation : [0/1] ');
    end
end

%% ========================================================================
% ================== start of the experiment ==============================
% =========================================================================

Screen('Preference', 'SkipSyncTests', 2);
screens = Screen('Screens'); %Define display screen
screenNumber = max(screens);

if do_fullscreen == 1
    w = Screen(screenNumber,'OpenWindow',[0 0 0]);
    HideCursor();
else
    w = Screen('OpenWindow', 0, 0, [10 30 810 630]);
    Screen('Preference', 'SkipSyncTests', 1);
end
[ww, wh]=Screen('WindowSize', w);


%scale images according to screen settings window width, ww, and window
%height, wh
scale_x = ww/1024;
scale_y = wh/768;
x_cent = ww/2;
y_cent = wh/2;

% Load Inscapes movie
%[Inscapes, inscapes_duration] = Screen('OpenMovie', w, [path_inscapes '01_Inscapes_NoScannerSound_h264.mov']);
[Inscapes, inscapes_duration] = Screen('OpenMovie', w, [path_inscapes filesep filename_inscapes]);
% Check if duration of video is long enough for scan duration, if not --> loop
subj.inscapes.duration = inscapes_duration;
if inscapes_duration < scan_duration+1 % loop if duration of video is less than scan duration plus 1 second
    subj.inscapes.looped = 1;
else
    subj.inscapes.looped = 0;
end

%instructions while subject is waiting for the trigger
if lang_de == 1
    instruct.text = ['Sie werden nun in den kommenden ' num2str(scan_duration/60) ' Minuten ein Video sehen.' ...
        '\n\n Während Sie dieses Video sehen, müssen Sie nichts tun.' ...
        '\n\n Bleiben Sie bitte ruhig liegen und denken Sie an nichts Spezielles.' ...
        '\n\n Achten Sie bitte darauf, trotzdem wach zu bleiben während der Messung.'];

else
    instruct.text = ['In the following ' num2str(scan_duration/60) ' minutes, you will watch a video.' ...
        '\n\n While watching this video, you don´t have to do anything.'...
        '\n\n Please keep lying still and think of nothing in particular. ' ...
        '\n\n It is important, however, that you stay awake during this measurement.'];
end

Screen('TextSize',w,28);
Screen('TextFont',w,'Arial');
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text, 'center', 'center', [255 255 255],150, flip_flag_horizontal, flip_flag_vertical);


%GetClicks;
%WaitSecs(10)
KbQueueCreate();
KbQueueStart();

%%%%%%%start of the experiment
MR_timings.on_trigger_loop = GetSecs;

if do_fmri_flag == 1
    % Flip instruction screen (participant indicates via phone if
    % instruction is understood, MR triggers start and flip the Inscapes)
    [ons_resp, starttime] = Screen('Flip', w, []);

    try
        MR_timings.trigger.all = waitForScannerTrigger(dummy_volumes, keyQuit);
    catch ME
        sca;
        rethrow(ME)
    end
end
MR_timings.trigger.fin = GetSecs;

%% Include baseline & stimulation for first run
if subj.run == 1
    timestamps.exp_inscapes_on_baseline = GetSecs;

    %%% send trigger through TTL box, indicating experiment start
    if settings.do_EGG
        sendTTL(settings.EGG.trigger.exp_on, 1) % throws error if fails
    end

    % start low frequency stimulation
    if subj.tVNS_manager
        tvnsInfo = setupTVNS(subj.low_stim_amplitude,subj.low_stim_impDur,subj.low_stim_freq,subj.low_stim_length, subj.low_pause_length);
        [~,~,~] = send(tvnsInfo.reqTreatOn, tvnsInfo.tvnsURL);
        if settings.do_EGG
            sendTTL(settings.EGG.trigger.tvns_on_baseline)
        end
    end

    %% Experiment loop
    % Start playback engine
    if  subj.inscapes.looped == 1
        Screen('PlayMovie', Inscapes, 1, 1);
    else
        Screen('PlayMovie', Inscapes, 1);
    end


    % Write trigger for EGG - start of the movie
    if settings.do_EGG
        sendTTL(settings.EGG.trigger.movie_on_baseline)
    end

    MR_timings.onsets.movie_start_baseline = GetSecs - MR_timings.trigger.fin;

    [~,c] = KbQueueCheck();
    while GetSecs - timestamps.exp_inscapes_on_baseline < scan_duration
        [~,c] = KbQueueCheck();
        if c(keyQuit) ~= 0
            sca
            if settings.do_EGG
                closeTTL()
            end
            error('Abort key was pressed!')
        end

        % Play Inscapes in a loop until scan is finished
        tex = Screen('GetMovieImage', w, Inscapes);

        if tex<=0
            % We're done, break out of loop:
            break;
        end

        % Draw the new texture immediately to screen:
        Screen('DrawTexture', w, tex);

        % Update display:
        Screen('Flip', w);

        % Release texture:
        Screen('Close', tex);

    end

    % Get timestamp for end of Inscapes video
    timestamps.exp_inscapes_off_baseline = GetSecs;

    % Write trigger for EGG - end of the movie
    if settings.do_EGG
        sendTTL(settings.EGG.trigger.movie_end_baseline)
    end

     % stop stimulation, end of low stim, 1. run
    if subj.tVNS_manager
        [~,~,~] = send(tvnsInfo.reqTreatOff, tvnsInfo.tvnsURL);
        if settings.do_EGG
            sendTTL(settings.EGG.trigger.tvns_end_baseline)
        end
    end

    MR_timings.onsets.movie_end_baseline = timestamps.exp_inscapes_off_baseline - MR_timings.trigger.fin;


    % Stop playback:
    Screen('PlayMovie', Inscapes, 0);

    % Close movie:
    Screen('CloseMovie', Inscapes);

    % %last fixation
    % fixation = '+';
    % Screen('TextSize',w,48);
    % [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, fixation, 'center', 'center', [255 255 255],150);
    % [ons_resp, starttime] = Screen('Flip', w, []);
    %
    % MR_timings.onsets.fix_start = starttime - MR_timings.trigger.fin;
    %
    %
    % if do_fmri_flag == 1
    %     WaitSecs(5);
    % else
    %     WaitSecs(5);
    % end
    %
    % MR_timings.onsets.fix_end = GetSecs - MR_timings.trigger.fin;

    %instructions while subject is waiting for the trigger
    if lang_de == 1
        instruct.text = ['Die Stimulation wird nun angeschaltet.'];

    else
        instruct.text = ['The stimulation will now be activated.'];
    end

    Screen('TextSize',w,50);
    Screen('TextFont',w,'Arial');
    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text, 'center', 'center', [255 255 255],150, flip_flag_horizontal, flip_flag_vertical);
    Screen('Flip', w, []);

    % start stimulation, start of normal stim, 1. run
    if ~subj.tVNS_manager
        GetClicks;
    else
        WaitSecs(5)
        tvnsInfo = setupTVNS(subj.stim_amplitude,subj.stim_impDur,subj.stim_freq,subj.stim_length, subj.pause_length);
        [~,~,~] = send(tvnsInfo.reqTreatOn, tvnsInfo.tvnsURL);
        if settings.do_EGG
            sendTTL(settings.EGG.trigger.tvns_on_stimulation)
        end
    end

    timestamps.time_stim_on = GetSecs;

    % Open movie again
    [Inscapes, inscapes_duration] = Screen('OpenMovie', w, [path_inscapes filesep filename_inscapes]);

    timestamps.exp_inscapes_on_stimulation = GetSecs;

    %% Start Inscapes for second time --> Stimulation
    if  subj.inscapes.looped == 1
        Screen('PlayMovie', Inscapes, 1, 1);
    else
        Screen('PlayMovie', Inscapes, 1);
    end

    % Trigger EGG
    % Write trigger for EGG - start of the movie
    if settings.do_EGG
        sendTTL(settings.EGG.trigger.movie_on_stimulation)
    end

    MR_timings.onsets.movie_start_stimulation = GetSecs - MR_timings.trigger.fin;

    while GetSecs - timestamps.exp_inscapes_on_stimulation < scan_duration

        % Play Inscapes in a loop until scan is finished
        tex = Screen('GetMovieImage', w, Inscapes);

        % Draw the new texture immediately to screen:
        Screen('DrawTexture', w, tex);

        % Update display:
        Screen('Flip', w);

        % Release texture:
        Screen('Close', tex);

    end

    % Get timestamp for end of Inscapes video
    timestamps.exp_inscapes_off_stimulation = GetSecs;

    % Trigger EGG
    % Write trigger for EGG - end of the movie
    if settings.do_EGG
        sendTTL(settings.EGG.trigger.movie_end_stimulation)
    end

    MR_timings.onsets.movie_end_stimulation = timestamps.exp_inscapes_off_stimulation - MR_timings.trigger.fin;

    % try
    % Stop playback:
    Screen('PlayMovie', Inscapes, 0);

    % Close movie:
    Screen('CloseMovie', Inscapes);
    % catch exception
    %         msgText = getReport(exception, 'extended','hyperlinks','off');
    %         fprintf('Error occured: %s\r\n', msgText);
    % end

    % end of 1. run, restart stimulation
    if subj.tVNS_manager
        [~,~,~] = send(tvnsInfo.reqTreatOff, tvnsInfo.tvnsURL);
        [~,~,~] = send(tvnsInfo.reqTreatOn, tvnsInfo.tvnsURL);
        if settings.do_EGG
            sendTTL(settings.EGG.trigger.tvns_end_stimulation)
        end
    end


% Include stimulation only but no baseline for second run
elseif subj.run == 2

    timestamps.exp_inscapes_on_stimulation = GetSecs;

    tvnsInfo = getTVNSinfo(); % needed for treatment off

    %%% send trigger through TTL box, indicating experiment start
    if settings.do_EGG
        sendTTL(settings.EGG.trigger.exp_on, 1) % throws error if fails
    end


    %% Experiment loop
    % Start playback engine
    if  subj.inscapes.looped == 1
        Screen('PlayMovie', Inscapes, 1, 1);
    else
        Screen('PlayMovie', Inscapes, 1);
    end

    % Write trigger for EGG - start of the movie
    if settings.do_EGG
        sendTTL(settings.EGG.trigger.movie_on_stimulation)
    end

    MR_timings.onsets.movie_start_stimulation = GetSecs - MR_timings.trigger.fin;

    [~,c] = KbQueueCheck();
    while GetSecs - timestamps.exp_inscapes_on_stimulation < scan_duration
        [~,c] = KbQueueCheck();
        if c(keyQuit) ~= 0
            sca
            if settings.do_EGG
                closeTTL()
            end
            error('Abort key was pressed!')
        end

        % Play Inscapes in a loop until scan is finished
        tex = Screen('GetMovieImage', w, Inscapes);

        if tex<=0
            % We're done, break out of loop:
            break;
        end

        % Draw the new texture immediately to screen:
        Screen('DrawTexture', w, tex);

        % Update display:
        Screen('Flip', w);

        % Release texture:
        Screen('Close', tex);

    end

    % Get timestamp for end of Inscapes video
    timestamps.exp_inscapes_off_stimulation = GetSecs;

    % Write trigger for EGG - end of the movie
    if settings.do_EGG
        sendTTL(settings.EGG.trigger.movie_end_stimulation)
    end

    MR_timings.onsets.movie_end_stimulation = timestamps.exp_inscapes_off_stimulation - MR_timings.trigger.fin;


    % Stop playback:
    Screen('PlayMovie', Inscapes, 0);

    % Close movie:
    Screen('CloseMovie', Inscapes);

    % stop stimulation, end of normal stim, 2. run
    if subj.tVNS_manager
        [~,~,~] = send(tvnsInfo.reqTreatOff, tvnsInfo.tvnsURL);
        if settings.do_EGG
            sendTTL(settings.EGG.trigger.tvns_end_stimulation)
        end
    end

end

% Get timestamp for end of rest measurement
timestamps.exp_inscapes_off = GetSecs;


% Save output
filename = sprintf('Inscapes-Rest_%s_%s_S%s_R%s', subj.studyID, subj.subjectID, subj.sessionID, subj.runID);
if do_fmri_flag == 0
    save(fullfile('Data', [filename '.mat']),'subj','timestamps');
else
    save(fullfile('Data', [filename '.mat']),'subj','timestamps','MR_timings');
end
jetze = char(datetime('now', 'Format','_yyMMdd_HHmm'));
save(fullfile('Backup', [filename jetze '.mat']));

KbQueueRelease();
Screen('CloseAll');

%%% send trigger through TTL box for experiment end, then reset port
if settings.do_EGG
    sendTTL(settings.EGG.trigger.exp_off)
    closeTTL()
end

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

end %----------------------------------------------------------------------
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


function tvnsInfo = getTVNSinfo()
% This function returns some important info needed for communication with
% tVNS.
tvnsInfo.bAutoSwitch = matlab.net.http.MessageBody('automaticSwitch');
tvnsInfo.bTreatOn = matlab.net.http.MessageBody('startTreatment');
tvnsInfo.bTreatOff = matlab.net.http.MessageBody('stopTreatment');
tvnsInfo.method = matlab.net.http.RequestMethod.POST;
tvnsInfo.reqAutoSwitch = matlab.net.http.RequestMessage(tvnsInfo.method,[],tvnsInfo.bAutoSwitch);
tvnsInfo.reqTreatOn = matlab.net.http.RequestMessage(tvnsInfo.method,[],tvnsInfo.bTreatOn);
tvnsInfo.reqTreatOff = matlab.net.http.RequestMessage(tvnsInfo.method,[],tvnsInfo.bTreatOff);
tvnsInfo.tvnsURL = 'http://localhost:51523/tvnsmanager/';
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