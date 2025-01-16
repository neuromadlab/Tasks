%%===================PTB collection===================
%Machine Slot Task Frame Rate Estimation - Sara Parnell
%contact: sara.parnell@student.uni-tuebingen.de
%========================================================
%
% Instructions:
% Simpy run the entire file.
% Make sure cilps and Conditions files are in same directory as this m-file.
% NOTE: attempted to use jitter, however some durations are still way to short!
%
%% STAND : 14.10.21

function flip_interval = test_for_flipinterval (n, screensize)
close all;

sca;


PsychDefaultSetup(1); %unifies key names on all operating systems

for repeats = 1:n
   
    Screen('Preference', 'SkipSyncTests', 1);
    
    setup.screenNum = max(Screen('Screens'));
     % Define colors
    color.white = WhiteIndex(setup.screenNum); %color.white = [255 255 255]; define a color in the common RGB scheme
    color.grey = color.white / 2;
    color.black = BlackIndex(setup.screenNum);
    color.red = [255 0 0];
    color.green = [0 255 0];
    color.blue = [0 0 255];
    
    [w,wRect] = Screen('OpenWindow',setup.screenNum,color.white, [screensize]);
    %create arrays representing the codings for the options
    setup.mouse_response = [1,3];
    setup.option_codes = [0,1];% blue and red
    setup.option_colours = {color.blue,color.red};
    setup.option_names = {'blue', 'red'};
    %setup.exitkey = keys.escape;
    
    % Page Setup
    start_frame = imread('clips\empty_sm_new.jpeg');
    [height, width, ~] = size(start_frame);
    width = width/1000;
    height = height/1000;
    r = [0 0 width height];
    r = ScaleRect(r,wRect(3)/4, wRect(3)/4);
    r = CenterRect(r, wRect);
    wr = RectWidth(r) ;
    setup.r_options{1} = OffsetRect(r, -wRect(3)/4, 0); % r1 = OffsetRect(r, (-wr/2*1.5), 0);
    setup.r_options{2} = OffsetRect(r, +wRect(3)/4, 0); %  r2 = OffsetRect(r, (+wr/2*1.5), 0);
    
    
    % let user know wtf is happening rn
    instr_txt = ['Frame Rate Estimation'];
    Screen('TextSize',w,30); Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr_txt, 'center', 'center', color.black,80);
    %time_lastFlip = Screen('Flip',w);
    Screen('Flip',w);
    WaitSecs(1);
    
    wSM = Screen('OpenOffscreenwindow',w,color.white);
    
    
    num = 1;
    choice = 1; % left 0 or right 1
    filename_spin_vid = sprintf('food_%d_%d_cropped.mp4', 1, num);
    filename_spin_vid = ['clips\' filename_spin_vid];
    spin_vid = VideoReader(filename_spin_vid);
   
    % play selected video
    %[actual_hz] = test_play_spin_vid(w, wSM, spin_vid, 1, setup.r_options, setup.option_colours, time_lastFlip);
    [actual_hz] = test_play_spin_vid(w, wSM, spin_vid, 1, setup.r_options, setup.option_colours); %time_lastFlip);
    %timeLag(nblock,ntrial) = actualTime - interval_duration(ntrial)
   
    WaitSecs(1);
    clear spin_vid
    Screen('Close');
    sca;

    mean_flipinterval(repeats) = mean(actual_hz(2:end));
end
%return average of all flip intervals
flip_interval = mean(mean_flipinterval);
end



function [actual_hz] = test_play_spin_vid(w, wSM, spin_vid, choice, r_options, option_colours) %, time_lastFlip)

priorityLevel = MaxPriority(w); Priority(priorityLevel); % to ensure smooth video playing


iframe = 1;
while hasFrame(spin_vid)
    
    frame = readFrame(spin_vid);
    % Change Color depending on the selection
    isBlack = all(frame >= 0 & frame<=5, 3);
    g = frame(:, :, 2);
    g(isBlack) = 0;
    if choice == 1 %black to red
        r = frame(:, :, 1);
        r(isBlack) = 255;
        b = frame(:, :, 3);
        b(isBlack) = 0;
    elseif choice == 0 %black to blue
        r = frame(:, :, 1);
        r(isBlack) = 0;
        b = frame(:, :, 3);
        b(isBlack) = 255;
    end
    frame = cat(3, r, g, b);
    %display each frame and flip
    frame_texture=Screen('MakeTexture', w, frame);
    Screen('DrawTexture', wSM, frame_texture,  [],  [r_options{choice+1}]);% was w
    Screen ('FrameRect', wSM, option_colours{choice+1}, r_options{choice+1}, 10); %was w
    Screen('CopyWindow',wSM,w);
    %actual_hz(iframe) = GetSecs - time_lastFlip;
    [~, ~, time_lastFlip(iframe)] = Screen('Flip',w);
    
    Screen('Close', frame_texture);
    %time_lastFlip2 - time_lastFlip
    %Screen('GetFlipInterval', w)
    %Screen('GetFlipInfo', w) -> only linux
    iframe = iframe + 1;
    
end
Priority(0);
actual_hz = time_lastFlip(2:end) - time_lastFlip(1:end-1);
%actualTime = tstop - start_time_interval; % measure time

end
