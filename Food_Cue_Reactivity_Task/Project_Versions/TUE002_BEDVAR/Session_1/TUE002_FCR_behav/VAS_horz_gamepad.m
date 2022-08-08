%%===================VAS horizontal===================
%customized visual analogue scales (0-100)
%

%Coded by: Nils Kroemer modified from mood_VAS (coded by Ying Lee) and BDM task (coded by Jean Liu)

%Update coded with: Matlab R2014a using Psychtoolbox 3.0.11

%========================================================

%% Preparation
if preset ~= 1
    clc; clear all; close all;

    % Setup
    timing.feedback_delay = 1.5; % specifies the duration that the confirmed rating will be displayed on the screen

    %Screen('Preference', 'SkipSyncTests', 1);
    % Input subject ID
    studyID=input('StudyID: ','s');
    subjectID=input('SubjectID: ','s');
    sessionID=input('SessionID: ','s');

    % Preparation: Set paths
    filepath=pwd;
    questionfile=[pwd,'/questionlist.txt'];
    fid=fopen(questionfile);
    questionlist = textscan(fid,'%s','Delimiter','\n');

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
    [window,screenrect] = Screen('OpenWindow',screenNumber,[0 0 0],[0 0 800 600]);
    %[window,screenrect] = Screen('OpenWindow',screenNumber,[0 0 0], screenRes);
    text = ['INSTRUCTIONS:' ...
        '\n\n You will be asked a series of questions.'...
        '\n\n\n\n For every question,' ... 
        '\n\n please indicate your rating by moving the mouse to indicate your rating on the scale.' ...
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
%for i=1:length(questionlist{1,1}); %number of questions
 
    trial.question = 'wanted';
    %trial.runstart = GetSecs; %Time run starts
    onset_start = 0;
    
    %--- Prepare off-screen windows---
    
    %rating window (4s)
    rating_scr = Screen('OpenOffscreenwindow',w,color_scale_background);
    text_freerating = [trial.question]; %free rating
    
    Screen('TextSize',rating_scr,14);
    Screen('TextFont',rating_scr,'Arial');
    anchor_1 = ['Not at all '];
    %anchor_4 = ['Neutral'];
    anchor_7 = ['Extremely '];
    
    if  strcmp(trial.question,'wanted')
        text_question = 'How much did you want to obtain the reward?';
    else
        text_question = ['How ' text_freerating ' is the flavor?'];
    end
    
    %rescale wh to scale_height
    Scale_width = round(ww * .50);
    %Scale_width = round(ww * .75);
    Scale_offset = round(wh * -(0.25 - scale_offset_y));
    %Scale_offset = round((wh - (wh * .95)) * .75);
    
    DrawFormattedText(rating_scr, text_question, 'center', (Scale_offset+wh/2 - 100), color_scale_anchors,40,[],[],2);
    DrawFormattedText(rating_scr, [anchor_1 text_freerating], (ww/2-Scale_width/2 - 65), (Scale_offset+wh/2 + 30), color_scale_anchors,80);
    %DrawFormattedText(rating_scr, [anchor_4], 'center', (Scale_offset+wh/2 + 30), [205 201 201],80);
    DrawFormattedText(rating_scr, [anchor_7 text_freerating], (ww/2+Scale_width/2 - 75), (Scale_offset+wh/2 + 30), color_scale_anchors,80);
    
    % horizontal scale element
    Screen('DrawLine',rating_scr,color_scale_anchors,(ww/2-Scale_width/2), (Scale_offset+wh/2), (ww/2+Scale_width/2), (Scale_offset+wh/2),3)
  
   
    % vertical scale elements
    Screen('DrawLine',rating_scr,color_scale_anchors,(ww/2-Scale_width/2), (Scale_offset+wh/2 - 20), (ww/2-Scale_width/2), (Scale_offset+wh/2 + 20),3)
    %Screen('DrawLine',rating_scr,[250 250 250],(ww/2), (Scale_offset+wh/2 - 15), (ww/2), (Scale_offset+wh/2 + 15),3)
    Screen('DrawLine',rating_scr,color_scale_anchors,(ww/2+Scale_width/2), (Scale_offset+wh/2 - 20), (ww/2+Scale_width/2), (Scale_offset+wh/2 + 20),3)
    
    %--- Start display for trial---
    
    %rating window
    Screen('CopyWindow',rating_scr,w);
    Screen('Flip',w);
    
    
    %----Mouse response----
    
    %Move cursor to mean position
    X = round(ww/2);
    Y = round(Scale_offset + wh/2); %Fix y coordinate
    Slider_x_pos = X;
    %SetMouse(X,Y);
    %scale_joy_x = ww*1.1/JoystickSpecification.Max;
    %scale_joy_y = wh*1.1/JoystickSpecification.Max;
    scale_joy_x = ww*0.7/JoystickSpecification.Max;
    scale_joy_y = wh*0.7/JoystickSpecification.Max;
    
    %Put slider on the screen
    Screen('CopyWindow',rating_scr,w)
    
    Screen('DrawLine',w,[250 0 0],Slider_x_pos, (Scale_offset + wh / 2 - 10), Slider_x_pos, (Scale_offset + wh / 2 + 10),5)
                
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
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    offset_x = X - round(Joystick.X * scale_joy_x);
    proj_x = round(Joystick.X * scale_joy_x) + offset_x;
    
    while (GetSecs - starttime) < max_dur_rating && flag_resp == 0 %mousebuttons(1)~=1 
        
        if (GetSecs > nextTime) %Sample every 0.01 seconds
            %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            proj_x = round(Joystick.X * scale_joy_x) + offset_x;
            
            if Joystick.Button(1) == 1
                flag_resp = 1;
                t_button = GetSecs;
            end
            
%             for buffer_i = 2:250 %buffer_size
%                 xbox_buffer(buffer_i) = Joystick.Button(1);
%                 if xbox_buffer(buffer_i)==1 && xbox_buffer(buffer_i-1)==0
%                     flag_resp = 1;
%                     t_button = GetSecs;
%                 else
%                     flag_resp = 0;
%                 end
%                 if buffer_i == 50
%                     buffer_i = 2;
%                     xbox_buffer(1)=xbox_buffer(250);
%                 end
            
                if flag_resp==1 %Terminate and record rating on left mouseclick
                    output.rating(i,1) = ((Slider_x_pos - (ww/2-Scale_width/2))/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
                    output.rating_label{i,1} = text_freerating;
                    output.rating_subm(i,1) = 1;
                    %out_ind = out_ind + 1;

                elseif (proj_x ~= Slider_x_pos) %Update screen if participant has scrolled up or down
                    Screen('CopyWindow',rating_scr,w);
                    Slider_x_pos = (proj_x);

                    %restrict range of slider to defined scale
                    if Slider_x_pos < (ww/2 - Scale_width/2)
                        Slider_x_pos = (ww/2 - Scale_width/2);
                    elseif Slider_x_pos > (ww/2 + Scale_width/2)
                        Slider_x_pos = (ww/2 + Scale_width/2);
                    end

                    Screen('DrawLine',w,[250 0 0],Slider_x_pos, (Scale_offset + wh / 2 - 10), Slider_x_pos, (Scale_offset + wh / 2 + 10),5)

                    Screen('Flip',w);
                end
            %end
            nextTime = nextTime+sampleTime;
        end
    end
    
    WaitSecs(timing.feedback_delay); %Show screen for 1.5s post-mouseclick

%end

if preset ~= 1;
    Screen('CloseAll');

save_filename=[studyID,'_',subjectID,'_',sessionID,'_VAS_',datestr(now,'yymmdd_HHMM'),'.mat'];
save(save_filename, 'output','studyID','subjectID','sessionID');
end;
