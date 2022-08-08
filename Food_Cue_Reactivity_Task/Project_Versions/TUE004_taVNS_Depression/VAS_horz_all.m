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
    [w,screenrect] = Screen('OpenWindow',screenNumber,[0 0 0],[0 0 800 600]);
    %[window,screenrect] = Screen('OpenWindow',screenNumber,[0 0 0], screenRes);
    text = ['INSTRUCTIONS:' ...
        '\n\n You will be asked a series of questions.'...
        '\n\n\n\n For every question,' ... 
        '\n\n please indicate your rating by moving the mouse to indicate your rating on the scale.' ...
        '\n\n\n\n Should you have any questions, please approach the experimenter.' ...
        '\n\n\n\nClick once to continue.'];
    Screen('TextSize',w,20);
    Screen('TextFont',w,'Arial');
    [positionx,positiony,bbox] = DrawFormattedText(w, text, 'center', 'center', [250 250 250],80);
    Screen('Flip',w);
    GetClicks(screenNumber);
    ww = screenrect(3)-screenrect(1);
    wh = screenrect(4)-screenrect(2);
    
    output.rating(i_trial) = NaN;
    i_trial = 1;
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
    
    % Screen('TextSize',rating_scr,14); %Commented out so that the text
    %size of the main script is used
    Screen('TextFont',rating_scr,'Arial');
    anchor_1 = ['Wollte ueberhaupt nicht'];
    %anchor_4 = ['Neutral'];
    anchor_7 = ['Wollte sehr stark '];
    
    if  strcmp(trial.question,'wanted')
        text_question = 'Wie sehr wollen Sie diese Belohnung in diesem Durchgang erhalten?';
    else
        text_question = ['How ' text_freerating ' is the flavor?'];
    end
    
    %rescale wh to scale_height
    Scale_width = round(ww * .50);
    Scale_offset = round((wh - (wh * .95)) * .75);
    
    DrawFormattedText(rating_scr, text_question, 'center', (Scale_offset+wh/2 - 100), color_scale_anchors,40,[],[],2);
    DrawFormattedText(rating_scr, [anchor_1 ], (ww/2-Scale_width/2 - 65), (Scale_offset+wh/2 + 30), color_scale_anchors,80);
    %DrawFormattedText(rating_scr, [anchor_4], 'center', (Scale_offset+wh/2 + 30), [205 201 201],80);
    DrawFormattedText(rating_scr, [anchor_7 ], (ww/2+Scale_width/2 - 75), (Scale_offset+wh/2 + 30), color_scale_anchors,80);
    
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
if vas_powermate == 0    
    %Move cursor to mean position
    X = round(ww/2);
    Y = round(Scale_offset + wh/2); %Fix y coordinate
    Slider_x_pos = X;
    SetMouse(X,Y);
    output.rating.value(i_trial,1) = ((Slider_x_pos - (ww/2-Scale_width/2))/ Scale_width)*100;
    
    
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
    
    [mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
    
    while (GetSecs - starttime) < timing.max_dur_rating && flag_resp == 0 %mousebuttons(1)~=1 
        
        if (GetSecs > nextTime) %Sample every 0.01 seconds
            [mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
            
            if mousebuttons(1)==1 || mousebuttons(3) == 1 %Terminate and record rating on left mouseclick
                output.rating.value(i_trial,1) = ((Slider_x_pos - (ww/2-Scale_width/2))/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
                output.rating.label{i_trial,1} = text_freerating;
                output.rating.subm(i_trial,1) = 1;
                output.rating.type_num(i_trial,1) = 0;
                t_rating = GetSecs;
                %subj.onsets.scales.button(i_trial,1) = t_rating - subj.trigger.fin;
                flag_resp = 1;
                %out_ind = out_ind + 1;
                
            elseif (mouseX ~= Slider_x_pos) %Update screen if participant has scrolled up or down
                Screen('CopyWindow',rating_scr,w);
                Slider_x_pos = (mouseX);
                
                %restrict range of slider to defined scale
                if Slider_x_pos < (ww/2 - Scale_width/2)
                    Slider_x_pos = (ww/2 - Scale_width/2);
                elseif Slider_x_pos > (ww/2 + Scale_width/2)
                    Slider_x_pos = (ww/2 + Scale_width/2);
                end
                
                output.rating.value(i_trial,1) = ((Slider_x_pos - (ww/2-Scale_width/2))/ Scale_width)*100;
                
                Screen('DrawLine',w,[250 0 0],Slider_x_pos, (Scale_offset + wh / 2 - 10), Slider_x_pos, (Scale_offset + wh / 2 + 10),5)
                Screen('Flip',w);
            end

            nextTime = nextTime+sampleTime;
        end
    end
    
    WaitSecs(timing.feedback_delay); %Show screen for 1.5s post-mouseclick
elseif vas_powermate == 1
    
    PowerMateID = PsychPowerMate('List');
    PsychPowerMate('Close', PowerMateHandle);
    PowerMateHandle = PsychPowerMate('Open', PowerMateID);
    [button, dialPos] = PsychPowerMate('Get', PowerMateHandle);

     %Move cursor to mean position
    X = round(ww/2);
    Y = round(Scale_offset + wh/2); %Fix y coordinate
    HandleMiddlePos = dialPos;
    Slider_x_pos = X;
%     SetMouse(X,Y);
    
    
    %Put slider on the screen
    Screen('CopyWindow',rating_scr,w)
    
    Screen('DrawLine',w,[250 0 0],Slider_x_pos, (Scale_offset + wh / 2 - 10), Slider_x_pos, (Scale_offset + wh / 2 + 10),5)
                
    [ons_resp, starttime] = Screen('Flip',w);
    
    %Loop and track mouse such that rating slider moves according to mouse position (edited from MouseTraceDemo)
    sampleTime = 0.01;
    nextTime = starttime+sampleTime;
    flag_resp = 0;
    
    while (GetSecs - starttime) < timing.max_dur_rating && flag_resp == 0 %mousebuttons(1)~=1 
    [button, dialPos] = PsychPowerMate('Get', PowerMateHandle); %Find out coordinates of current PM turning position
             
        if (GetSecs > nextTime) %Sample every 0.01 seconds
            
            if  button==1 %Terminate and record rating on powermate click
                output.rating.value(i_trial,1) = ((Slider_x_pos - (ww/2-Scale_width/2))/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
                output.rating.label{i_trial,1} = text_freerating;
                output.rating.subm(i_trial,1) = 1;
                output.rating.type_num(i_trial,1) = 0;
                t_rating = GetSecs;
                subj.onsets.scales.button(i_trial,1) = t_rating - subj.trigger.fin;
                flag_resp = 1;
                %out_ind = out_ind + 1;
                
            else
                Screen('CopyWindow',rating_scr,w);
                Slider_x_pos = X + (Scale_width/100)*(dialPos - HandleMiddlePos);
                
                %restrict range of slider to defined scale
                if Slider_x_pos < (ww/2 - Scale_width/2)
                    Slider_x_pos = (ww/2 - Scale_width/2);
                elseif Slider_x_pos > (ww/2 + Scale_width/2)
                    Slider_x_pos = (ww/2 + Scale_width/2);
                end
                
                output.rating.value(i_trial,1) = ((Slider_x_pos - (ww/2-Scale_width/2))/ Scale_width)*100;
                
                Screen('DrawLine',w,[250 0 0],Slider_x_pos, (Scale_offset + wh / 2 - 10), Slider_x_pos, (Scale_offset + wh / 2 + 10),5)
                
                Screen('Flip',w);
            end

            nextTime = nextTime+sampleTime;
        end
    end
    
    WaitSecs(timing.feedback_delay); %Show screen for 1.5s post-mouseclick
    
end

%end
button = 0;

if preset ~= 1
    Screen('CloseAll');

save_filename=[studyID,'_',subjectID,'_',sessionID,'_VAS_',datestr(now,'yymmdd_HHMM'),'.mat'];
save(save_filename, 'output','studyID','subjectID','sessionID');
end
