%%===================VAS horizontal===================
%customized visual analogue scales (0-100)
%

%Coded by: Nils Kroemer modified from mood_VAS (coded by Ying Lee) and BDM task (coded by Jean Liu)

%Update coded with: Matlab R2014a using Psychtoolbox 3.0.11

%========================================================

%% Start experiment:

%--- Start trial---
if settings.lang_de == 1
    trial.question = 'wollen';
else
    trial.question = 'wanting';
end

    onset_start = 0;
    trial.runstart = GetSecs; %Time run starts
    
    %--- Prepare off-screen windows---
    
    %rating window (4s)
    rating_scr = Screen('OpenOffscreenwindow',w,color_scale_background);
    text_freerating = [trial.question]; %free rating
    
    Screen('TextSize',rating_scr,24);
    Screen('TextFont',rating_scr,'Arial');
    
if settings.lang_de == 1    
    anchor.a1 = ['Ueberhaupt nicht'];
    %anchor_4 = ['Neutral'];
    anchor.a7 = ['Sehr stark'];
else
    anchor.a1 = ['Not at all '];
    %anchor_4 = ['Neutral'];
    anchor.a7 = ['Extremely '];
end
    
if  settings.lang_de == 1
    text_question = 'Wie sehr wollten Sie die Belohnung in diesem Durchgang erhalten?';
else
    text_question = 'How much did you want to obtain the reward?';
end
    
    %rescale wh to scale_height
    Scale_width = round(ww * .50);
    %Scale_width = round(ww * .75);
    Scale_offset = round(wh * -(0.25 - scale_offset_y));
    %Scale_offset = round((wh - (wh * .95)) * .75);
    
    DrawFormattedText(rating_scr, text_question, 'center', (Scale_offset+wh/2 - 100), color_scale_anchors,40,[],[],2);

% if settings.lang_de == 1
%     
%     DrawFormattedText(rating_scr, [text_freerating anchor.a1], (ww/2-Scale_width/2 - 65), (Scale_offset+wh/2 + 40), color_scale_anchors,80);
%     DrawFormattedText(rating_scr, [text_freerating anchor.a7], (ww/2+Scale_width/2 - 75), (Scale_offset+wh/2 + 40), color_scale_anchors,80);
%   
% else
%     DrawFormattedText(rating_scr, [anchor.a1 text_freerating], (ww/2-Scale_width/2 - 65), (Scale_offset+wh/2 + 30), color_scale_anchors,80);
%     DrawFormattedText(rating_scr, [anchor.a7 text_freerating], (ww/2+Scale_width/2 - 75), (Scale_offset+wh/2 + 30), color_scale_anchors,80); 
% end

    if settings.lang_de == 1

        DrawFormattedText(rating_scr, [anchor.a1], (ww/2-Scale_width/2 - 65), (Scale_offset+wh/2 + 40), color_scale_anchors,80);
        DrawFormattedText(rating_scr, [anchor.a7], (ww/2+Scale_width/2 - 75), (Scale_offset+wh/2 + 40), color_scale_anchors,80);

    else
        DrawFormattedText(rating_scr, [anchor.a1], (ww/2-Scale_width/2 - 65), (Scale_offset+wh/2 + 30), color_scale_anchors,80);
        DrawFormattedText(rating_scr, [anchor.a7], (ww/2+Scale_width/2 - 75), (Scale_offset+wh/2 + 30), color_scale_anchors,80); 
    end

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
if settings.do_gamepad == 0    
    %Move cursor to mean position
    X = round(ww/2);
    Y = round(Scale_offset + wh/2); %Fix y coordinate
    Slider_x_pos = X;
    SetMouse(X,Y);    
    
    %Put slider on the screen
    Screen('CopyWindow',rating_scr,w)
    
    Screen('DrawLine',w,[250 0 0],Slider_x_pos, (Scale_offset + wh / 2 - 10), Slider_x_pos, (Scale_offset + wh / 2 + 10),5)
                
    % For first flip, track time
    if onset_start == 0 
       [ons_resp, rating.starttime] = Screen('Flip', w);
       onset_start = 1;
    else
        Screen('Flip',w);
    end
    
    %Loop and track mouse such that rating slider moves according to mouse position (edited from MouseTraceDemo)
    sampleTime = 0.01;
    nextTime = rating.starttime+sampleTime;
    flag_resp = 0;
    
    [mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
    
    while (GetSecs - rating.starttime) < timing.max_dur_rating && flag_resp == 0 %mousebuttons(1)~=1 
        
        if (GetSecs > nextTime) %Sample every 0.01 seconds
            [mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
            
            if mousebuttons(1)==1 || mousebuttons(3) == 1 %Terminate and record rating on left mouseclick
                rating.RT = GetSecs - rating.starttime;
                rating.value = ((Slider_x_pos - (ww/2-Scale_width/2))/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
                rating.subm = 1;
                flag_resp = 1;
                
            elseif (mouseX ~= Slider_x_pos) %Update screen if participant has scrolled up or down
                Screen('CopyWindow',rating_scr,w);
                Slider_x_pos = (mouseX);
                
                %restrict range of slider to defined scale
                if Slider_x_pos < (ww/2 - Scale_width/2)
                    Slider_x_pos = (ww/2 - Scale_width/2);
                elseif Slider_x_pos > (ww/2 + Scale_width/2)
                    Slider_x_pos = (ww/2 + Scale_width/2);
                end
                
                Screen('DrawLine',w,[250 0 0],Slider_x_pos, (Scale_offset + wh / 2 - 10), Slider_x_pos, (Scale_offset + wh / 2 + 10),5)
                Screen('Flip',w);
            end

            nextTime = nextTime+sampleTime;
        end
    end
    
    WaitSecs(timing.feedback_delay); %Show screen for 1.5s post-mouseclick
    
elseif settings.do_gamepad == 1
    
    %Move cursor to mean position
    X = round(ww/2);
    Y = round(Scale_offset + wh/2); %Fix y coordinate
    Slider_x_pos = X;
    scale_joy_x = ww*0.7/JoystickSpecification.Max;
    scale_joy_y = wh*0.7/JoystickSpecification.Max;
    
    %Put slider on the screen
    Screen('CopyWindow',rating_scr,w)
    
    Screen('DrawLine',w,[250 0 0],Slider_x_pos, (Scale_offset + wh / 2 - 10), Slider_x_pos, (Scale_offset + wh / 2 + 10),5)
                
        % For first flip, track time
    if onset_start == 0 
       [ons_resp, rating.starttime] = Screen('Flip', w);
       onset_start = 1;
    else
        Screen('Flip',w);
    end
    %Loop and track mouse such that rating slider moves according to mouse position (edited from MouseTraceDemo)
    sampleTime = 0.01;
    nextTime = rating.starttime+sampleTime;
    flag_resp = 0;
    
    %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    offset_x = X - round(Joystick.X * scale_joy_x);
    proj_x = round(Joystick.X * scale_joy_x) + offset_x;
    
    while (GetSecs - rating.starttime) < timing.max_dur_rating && flag_resp == 0 %mousebuttons(1)~=1 
        
        if (GetSecs > nextTime) %Sample every 0.01 seconds
            %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            proj_x = round(Joystick.X * scale_joy_x) + offset_x;
            
            if Joystick.Button(1) == 1
                rating.RT = GetSecs - rating.starttime;
                rating.value = ((Slider_x_pos - (ww/2-Scale_width/2))/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
                rating.subm = 1;
                flag_resp = 1;
                
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
   
            nextTime = nextTime+sampleTime;
        end
    end
        
    WaitSecs(timing.feedback_delay); %Show screen for feedback_delay past click
    
end

if flag_resp==0
    rating.value = ((Slider_x_pos - (ww/2-Scale_width/2))/ Scale_width)*100;
    rating.subm = 0;
    rating.RT = timing.max_dur_rating;
end
