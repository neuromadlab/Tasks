%%===================LHS vertical===================
%Labeled Hedonic Scale (Lim, Wood, & Green)
%

%Coded by: Nils Kroemer modified from mood_VAS (coded by Ying Lee) and BDM task (coded by Jean Liu)

%Update coded with: Matlab R2014a using Psychtoolbox 3.0.11

%========================================================

%% Preparation
if preset ~= 1;
    clc; clear all; close all;

    % Setup

    timing.feedback_delay = 1.5; % specifies the duration that the confirmed rating will be display on the screen

    %Screen('Preference', 'SkipSyncTests', 1);
    % Input subject ID
    studyID=input('StudyID: ','s');
    subjectID=input('SubjectID: ','s');
    sessionID=input('SessionID: ','s');

    % Preparation: Set paths
    filepath=pwd;
    sensationsfile=[pwd,'/sensationslist.txt'];
    fid=fopen(sensationsfile);
    sensationslist = textscan(fid,'%s','Delimiter','\n');

    fclose(fid);

    % Preparation: General Psychtoolbox
    screens = Screen('Screens'); %Define display screen
    screenNumber = max(screens);
    oldResolution=Screen('Resolution', screenNumber);
    screenRes=[0 0 oldResolution.width oldResolution.height];
    Screen('Preference', 'VisualDebugLevel', 3); % Remove blue screen flash and minimize extraneous warnings.
    Screen('Preference', 'SuppressAllWarnings', 1);
    AssertOpenGL;
    HideCursor; %Hide cursor

    %% Instructions for mood task
    %[window,screenrect] = Screen('OpenWindow',screenNumber,[0 0 0],[0 0 1024 768]);
    [window,screenrect] = Screen('OpenWindow',screenNumber,[0 0 0], screenRes);
    text = ['INSTRUCTIONS:' ...
        '\n\n You will be asked a series of questions.'...
        '\n\n\n\n For every question,' ... 
        '\n\n please indicate your rating by using the mouse to indicate on the bar.' ...
        '\n\n\n\n Should you have any questions, please approach the experimenter.' ...
        '\n\n\n\nClick once to continue.'];
    Screen('TextSize',window,20);
    Screen('TextFont',window,'Arial');
    [positionx,positiony,bbox] = DrawFormattedText(window, text, 'center', 'center', [250 250 250],80);
    Screen('Flip',window);
    GetClicks(screenNumber);
    ww = screenrect(3)-screenrect(1);
    wh = screenrect(4)-screenrect(2);
    
    output.rating(i) = NaN;
    trial_i = 1;
end


%% Start experiment:

%--- Start trial---
%while (GetSecs - t_scale_trigger) < timing.max_dur_rating; %number of questions within the loop
 
    trial.question = 'liking';
    %trial.runstart = GetSecs; %Time run starts
    onset_start = 0;

        
    %--- Prepare off-screen windows---
    
    %rating window (4s)
    rating_scr = Screen('OpenOffscreenwindow',w,color_scale_background);
    text_freerating = [trial.question]; %free rating
    
    Screen('TextSize',rating_scr,12);
    Screen('TextFont',rating_scr,'Arial');
    anchor_1 = ['most liked sensation imaginable'];
    anchor_2 = ['like extremely'];
    anchor_3 = ['like very much'];
    anchor_4 = ['like moderately'];
    anchor_5 = ['like slightly'];
    anchor_6 = ['neutral'];
    anchor_7 = ['most disliked sensation imaginable'];
    instruction = ['Please rate the food in the context \nof he full range of sensations that \nyou have experienced in your life'];
     
    %rescale wh to scale_height
    Scale_height = round(wh * .50);
    Scale_offset = round(wh * scale_offset_y);
    %Scale_height = round(wh * .75);
    %Scale_offset = round((wh - Scale_height) * .75);
    
    DrawFormattedText(rating_scr, anchor_1, (ww/2+20), (Scale_offset - 10) + Scale_height * 0.000, color_scale_anchors,80);
    %DrawFormattedText(rating_scr, [text_freerating ' sensation'], (ww/2+20), (Scale_offset - 10) + 20, [250 0 0],80);
    DrawFormattedText(rating_scr, anchor_2, (ww/2+20), (Scale_offset - 10) + Scale_height * 0.171, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor_3, (ww/2+20), (Scale_offset - 10) + Scale_height * 0.278, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor_4, (ww/2+20), (Scale_offset - 10) + Scale_height * 0.411, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor_5, (ww/2+20), (Scale_offset - 10) + Scale_height * 0.469, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor_6, (ww/2-80), (Scale_offset - 10) + Scale_height * 0.500, color_scale_anchors,80);
    DrawFormattedText(rating_scr, ['dis' anchor_5], (ww/2+20), (Scale_offset - 10) + Scale_height * 0.530, color_scale_anchors,80);
    DrawFormattedText(rating_scr, ['dis' anchor_4], (ww/2+20), (Scale_offset - 10) + Scale_height * 0.588, color_scale_anchors,80);
    DrawFormattedText(rating_scr, ['dis' anchor_3], (ww/2+20), (Scale_offset - 10) + Scale_height * 0.708, color_scale_anchors,80);
    DrawFormattedText(rating_scr, ['dis' anchor_2], (ww/2+20), (Scale_offset - 10) + Scale_height * 0.814, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor_7, (ww/2+20), (Scale_offset - 10) + Scale_height * 1.000, color_scale_anchors,80);
    DrawFormattedText(rating_scr, instruction, (ww/10), 'center', [200 0 0],80,[],[],2);
    
    % horizontal scale elements
    Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * 0.000, (ww / 2 + 15), Scale_offset + Scale_height * 0.000,3)
    Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * 0.171, (ww / 2 + 15), Scale_offset + Scale_height * 0.171,3)
    Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * 0.278, (ww / 2 + 15), Scale_offset + Scale_height * 0.278,3)
    Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * 0.411, (ww / 2 + 15), Scale_offset + Scale_height * 0.411,3)
    Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * 0.469, (ww / 2 + 15), Scale_offset + Scale_height * 0.469,3)
    Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 20), Scale_offset + Scale_height * 0.500, (ww / 2 + 20), Scale_offset + Scale_height * 0.500,3)
    Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * 0.530, (ww / 2 + 15), Scale_offset + Scale_height * 0.530,3)
    Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * 0.588, (ww / 2 + 15), Scale_offset + Scale_height * 0.588,3)
    Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * 0.708, (ww / 2 + 15), Scale_offset + Scale_height * 0.708,3)
    Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * 0.814, (ww / 2 + 15), Scale_offset + Scale_height * 0.814,3)
    Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * 1.000, (ww / 2 + 15), Scale_offset + Scale_height * 1.000,3)
    
    % vertical scale element
    Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2), Scale_offset, (ww / 2), Scale_offset + Scale_height,3)

    %--- Start display for trial---
    
    %rating window
    Screen('CopyWindow',rating_scr,w);
    Screen('Flip',w);      
    
    %----Mouse response----
    
    %Move cursor to anchor_6 (center position of sclae)
    X = round(ww/2);
    Y = round(Scale_offset + Scale_height * 0.50); %Fix y coordinate
    Slider_y_pos = Y;
    %SetMouse(X,Y);
    %scale_joy_x = ww*1.1/JoystickSpecification.Max;
    %scale_joy_y = wh*1.1/JoystickSpecification.Max;
    scale_joy_x = ww*0.7/JoystickSpecification.Max;
    scale_joy_y = wh*0.7/JoystickSpecification.Max;

    %Put slider on the screen
    Screen('CopyWindow',rating_scr,w)
    
    Screen('DrawLine',w,[250 0 0],(ww / 2 - 10), Slider_y_pos, (ww / 2 + 10), Slider_y_pos,5)
                
    % For first flip, track time
    if onset_start == 0 
       [ons_resp, starttime] = Screen('Flip', w);
       onset_start = 1;
    else
        Screen('Flip',w);
    end
    
    %Loop and track mouse such that rating slider moves according to mouse position (edited from MouseTraceDemo)
    sampleTime = 0.01;
    nextTime = starttime+sampleTime;
    flag_resp = 0;
    
    %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
    offset_y = Y - round(Joystick.Y * scale_joy_y);
    proj_y = round(Joystick.Y * scale_joy_y) + offset_y;
    
    while (GetSecs - starttime) < timing.max_dur_rating && flag_resp == 0; %mousebuttons(1)~=1 
        
        if (GetSecs > nextTime) %Sample every 0.01 seconds
            %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
            proj_y = round(Joystick.Y * scale_joy_y) + offset_y;
            
            if Joystick.Button(1) == 1
                flag_resp = 1;
                t_button = GetSecs;
            end
            
            if flag_resp==1 %Terminate and record rating on left mouseclick
                output.rating.value(i,1) = 100-((Slider_y_pos - Scale_offset)/Scale_height)*200; %rescaling of scale_height independent of screen resolution [0-100]
                output.rating.label{i,1} = text_freerating;
                output.rating.subm(i,1) = 1;
                subj.onsets.scales.button(i,1) = t_button - subj.trigger.fin;
                %out_ind = out_ind + 1;
                
            elseif (proj_y ~= Slider_y_pos) %Update screen if participant has scrolled up or down
                Screen('CopyWindow',rating_scr,w);
                Slider_y_pos = (proj_y);
                
                %restrict range of slider to defined scale
                if Slider_y_pos < Scale_offset
                    Slider_y_pos = Scale_offset;
                elseif Slider_y_pos > (Scale_offset + Scale_height)
                    Slider_y_pos = (Scale_offset + Scale_height);
                end
                
                Screen('DrawLine',w,[250 0 0],(ww / 2 - 10), Slider_y_pos, (ww / 2 + 10), Slider_y_pos,5)
                
                Screen('Flip',w);
            end

            nextTime = nextTime+sampleTime;
        end
    end

    rating = 100-((Slider_y_pos - Scale_offset)/Scale_height)*200;
    WaitSecs(timing.feedback_delay); %Show screen for 1.5s post-mouseclick

%end

if preset ~= 1;
    Screen('CloseAll');

save_filename=[studyID,'_',subjectID,'_',sessionID,'_LHS_',datestr(now,'yymmdd_HHMM'),'.mat'];
save(save_filename, 'output','studyID','subjectID','sessionID');

end
