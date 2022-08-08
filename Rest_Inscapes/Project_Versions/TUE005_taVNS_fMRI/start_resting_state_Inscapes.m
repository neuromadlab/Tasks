%%===================Resting-state with Inscapes===================
%For a description of Inscapes, see Vanderwal (2015) NIMG

%Coded by: Vanessa Teckentrup
%Coded with: Matlab R2017b using Psychtoolbox 3

%========================================================
clear
AssertOpenGL;

% subject information
subj.studyID='TUE005';
subj.subjectID=input('Subject ID: ','s');

if strcmp(subj.studyID,'TUE002')
    
    subj.sessionID = '2';
    subj.runID = '1';
    
elseif strcmp(subj.studyID,'TUE005')
    
    subj.sessionID=input('Session ID: ','s'); % enter session number
    subj.runID = '1'; % baseline
    %subj.code_stim_cond = 'baseline';
    
end

% subj.lang_de = input ('Language German [1/0]: ','s'); %changes display language to German
% lang_de = str2double (subj.lang_de);
lang_de = 1;

subj.sess = str2double(subj.sessionID); %converts Session ID to integer
subj.run = str2double(subj.runID); %converts run ID to integer
subj.num = str2double(subj.subjectID); %converts Subject ID to integer
subj.subjectID = [repmat('0',1,6-length(subj.subjectID)) subj.subjectID];

% Set up EGG
% Add path for io64 function
addpath 'D:\home\sektion\AG_Walter\taVNS'
% Generate LPT I/O object
LPT_IO_EGG = io64;
% Check if status of the port is 0
status = io64(LPT_IO_EGG);
if status == 0
    disp('LPT port status for EGG triggers OK, continue task...')
else
    error('LPT port status ~= 0, please check...')
end 

% EGG settings
settings.EGG.port_address = 888;
settings.EGG.trigger.movie_on_baseline = 10; % trigger code for Baseline movie on
settings.EGG.trigger.movie_end_baseline = 20; % trigger code for Baseline movie off
settings.EGG.trigger.movie_on_stimulation = 100; % trigger code for Stimulation movie on
settings.EGG.trigger.movie_end_stimulation = 200; % trigger code for Stimulation movie off

% Trigger EGG
% Write trigger for signaling start of Rest Inscapes 
io64(LPT_IO_EGG,settings.EGG.port_address,1);

%paradigm settings
%path_inscapes = 'E:\neuroMADLAB\Inscapes';
path_inscapes = pwd;
filename_inscapes = 'Inscapes_10_minutes_version3.mp4';
do_fullscreen = 1; %will show window as fullscreen (default second monitor, if connected)
do_fmri_flag = 1; %will include trigger
flip_flag_horizontal = 1; % Flip screen left/right for one-sided mirror at Radiology
flip_flag_vertical = 0;
dummy_volumes = 0; %will have to be set according to the sequence
scan_duration = 600; % scan duration in seconds
%scan_duration = 10; % scan duration in seconds (debug)

keyTrigger=KbName('5%');
keyTrigger2=KbName('5');
keyQuit=KbName('q');
keyResp=KbName('1');
keyResp2=KbName('1!');
count_trigger = 0;


% Create output folders if non-existent
if ~exist([pwd filesep 'Data'], 'dir')
   mkdir('Data')
end

if ~exist([pwd filesep 'Backup'], 'dir')
   mkdir('Backup')
end


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
if inscapes_duration < scan_duration
    
    subj.inscapes.looped = 1;
    
else
    
    subj.inscapes.looped = 0;
    
end

%instructions while subject is waiting for the trigger
if lang_de == 1
    instruct.text = ['Sie werden nun zweimal nacheinander ein Video sehen. \n' ...
        'Der erste Durchlauf des Videos erfolgt ohne Stimulation. \n' ...
        'Beim zweiten Durchlauf wird die Stimulation angeschaltet. \n' ...
        'Während Sie das Video sehen, müssen Sie nichts tun. \n' ...
        'Bleiben Sie bitte ruhig liegen und denken Sie an nichts Spezielles. \n' ...
        'Achten Sie bitte darauf, trotzdem wach zu bleiben während der Messung.'];
    
else
    instruct.text = ['In the following ' num2str(scan_duration/60) ' minutes, you will watch a video.' ...
        '\n\n While watching this video, you don´t have to do anything.'...
        '\n\n Please keep lying still and think of nothing in particular. ' ...
        '\n\n It is important, however, that you stay awake during this measurement.'];
end

Screen('TextSize',w,50);
Screen('TextFont',w,'Arial');
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text, 'center', 'center', [255 255 255],150, flip_flag_horizontal, flip_flag_vertical);


%GetClicks;
%WaitSecs(10)

%%%%%%%start of the experiment
MR_timings.on_trigger_loop = GetSecs;

if do_fmri_flag == 1
    KbQueueCreate();
    KbQueueFlush();
    KbQueueStart();
    
    % Flip instruction screen (participant indicates via phone if
    % instruction is understood, MR triggers start and flip the Inscapes)
    [ons_resp, starttime] = Screen('Flip', w, []);
    
    [b,c] = KbQueueCheck;
    
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
end

if do_fmri_flag == 0
    
    MR_timings.trigger.fin = GetSecs;
end

KbQueueRelease();
timestamps.exp_on_baseline = GetSecs;


%% Experiment loop
% Start playback engine
if  subj.inscapes.looped == 1
    Screen('PlayMovie', Inscapes, 1, 1);
else
    Screen('PlayMovie', Inscapes, 1);
end

% Trigger EGG
% Write trigger for EGG - start of the movie 
io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.movie_on_baseline);

MR_timings.onsets.movie_start_baseline = GetSecs - MR_timings.trigger.fin;

while GetSecs - timestamps.exp_on_baseline < scan_duration
    
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
timestamps.exp_inscapes_off_baseline = GetSecs;

% Trigger EGG
% Write trigger for EGG - end of the movie 
io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.movie_end_baseline);

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

GetClicks;

% Open movie again
[Inscapes, inscapes_duration] = Screen('OpenMovie', w, [path_inscapes filesep filename_inscapes]);

timestamps.exp_on_stimulation = GetSecs;

%% Start Inscapes for second time --> Stimulation
if  subj.inscapes.looped == 1
    Screen('PlayMovie', Inscapes, 1, 1);
else
    Screen('PlayMovie', Inscapes, 1);
end

% Trigger EGG
% Write trigger for EGG - start of the movie 
io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.movie_on_stimulation);

MR_timings.onsets.movie_start_stimulation = GetSecs - MR_timings.trigger.fin;

while GetSecs - timestamps.exp_on_stimulation < scan_duration
    
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
io64(LPT_IO_EGG,settings.EGG.port_address,settings.EGG.trigger.movie_end_stimulation);

MR_timings.onsets.movie_end_stimulation = timestamps.exp_inscapes_off_stimulation - MR_timings.trigger.fin;


% Stop playback:
Screen('PlayMovie', Inscapes, 0);
    
% Close movie:
Screen('CloseMovie', Inscapes);


% Get timestamp for end of rest measurement
timestamps.exp_off = GetSecs;

% Save output
filename = sprintf('Inscapes-Rest_%s_%s_S%s_R%s', subj.studyID, subj.subjectID, subj.sessionID, subj.runID);
if do_fmri_flag == 0
    save(fullfile('Data', [filename '.mat']),'subj','timestamps');
else
    save(fullfile('Data', [filename '.mat']),'subj','timestamps','MR_timings','settings');
end
save(fullfile('Backup', [filename datestr(now,'_yymmdd_HHMM') '.mat']));


Screen('CloseAll');
