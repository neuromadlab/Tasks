clear
AssertOpenGL;

path_inscapes = pwd;
filename_inscapes = 'Inscapes_10_minutes_version3.mp4';
do_fullscreen = 1; %will show window as fullscreen (default second monitor, if connected)
scan_duration = 600; % scan duration in seconds
keyQuit=KbName('q');

Screen('Preference', 'SkipSyncTests', 2);
screens = Screen('Screens'); %Define display screen
screenNumber = max(screens);

if do_fullscreen == 1
    w = Screen(screenNumber,'OpenWindow',[0 0 0]);
else
    w = Screen('OpenWindow', 0, 0, [10 30 810 630]);
    Screen('Preference', 'SkipSyncTests', 1);
end
[ww, wh]=Screen('WindowSize', w);

% Load Inscapes movie
[Inscapes, inscapes_duration] = Screen('OpenMovie', w, [path_inscapes filesep filename_inscapes]);

%GetClicks;
%WaitSecs(10)

%%%%%%%start of the experiment
KbQueueCreate()
KbQueueStart()
% Start playback engine
Screen('PlayMovie', Inscapes, 1);

timestamps.exp_on = GetSecs;
[~,c] = KbQueueCheck;
tic
while (GetSecs - timestamps.exp_on < scan_duration) && (c(keyQuit) == 0)
    [~,c] = KbQueueCheck;
    
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
toc

% Stop playback:
Screen('PlayMovie', Inscapes, 0);
    
% Close movie:
Screen('CloseMovie', Inscapes);
Screen('CloseAll');
