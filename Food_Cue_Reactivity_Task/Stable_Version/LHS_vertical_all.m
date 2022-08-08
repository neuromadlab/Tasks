%%===================LHS vertical===================
%Labeled Hedonic Scale (Lim, Wood, & Green)
%

%Coded by: Nils Kroemer modified from mood_VAS (coded by Ying Lee) and BDM task (coded by Jean Liu)

%Update coded with: Matlab R2014a using Psychtoolbox 3.0.11

%========================================================

%% Start experiment:

%--- Start trial---
if settings.lang_de == 1
    trial.question = 'moegen';
else
    trial.question = 'liking';
end

    onset_start = 0;
    trial.runstart = GetSecs; %Time run starts
    
    %--- Prepare off-screen windows---
    
    %rating window (4s)
    rating_scr = Screen('OpenOffscreenwindow',w,color_scale_background);
   
    
    Screen('TextSize',rating_scr,18);
    Screen('TextFont',rating_scr,'Arial');
    
if settings.lang_de == 1
    anchor.a1 = ['am allerstaerksten gemochte Empfindung, die vorstellbar ist'];
    anchor.a2 = ['extrem gern'];
    anchor.a3 = ['sehr gern'];
    anchor.a4 = ['gern'];
    anchor.a5 = ['ein bisschen gern'];
    anchor.a6 = ['neutral'];
    anchor.a7 = ['ein bisschen ungern'];
    anchor.a8 = ['ungern'];
    anchor.a9 = ['sehr ungern'];
    anchor.a10 = ['extrem ungern'];
    anchor.a11 = ['am allerstaerksten zuwidere Empfindung, die vorstellbar ist'];
    instruction = ['Bitte bewerten Sie die Belohnung \nim Vergleich zu allen bisher in Ihrem Leben \nerfahrenen Empfindungen'];
else
    anchor.a1 = ['most liked sensation imaginable'];
    anchor.a2 = ['like extremely'];
    anchor.a3 = ['like very much'];
    anchor.a4 = ['like moderately'];
    anchor.a5 = ['like slightly'];
    anchor.a6 = ['neutral'];
    anchor.a7 = ['dis' anchor.a5];
    anchor.a8 = ['dis' anchor.a4];
    anchor.a9 = ['dis' anchor.a3];
    anchor.a10 = ['dis' anchor.a2];
    anchor.a11 = ['most disliked sensation imaginable'];
    instruction = ['Please rate the reward in the context \nof he full range of sensations that \nyou have experienced in your life'];
end  
    %rescale wh to scale_height
    Scale_height = round(wh * .50);
    Scale_offset = round(wh * scale_offset_y);
    %Scale_height = round(wh * .75);
    %Scale_offset = round((wh - Scale_height) * .75);
    
    DrawFormattedText(rating_scr, anchor.a1, (ww/2+20), (Scale_offset + 5) + Scale_height * 0.000, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a2, (ww/2+20), (Scale_offset + 5) + Scale_height * 0.171, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a3, (ww/2+20), (Scale_offset + 5) + Scale_height * 0.278, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a4, (ww/2+20), (Scale_offset + 5) + Scale_height * 0.411, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a5, (ww/2+20), (Scale_offset + 5) + Scale_height * 0.469, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a6, (ww/2-80), (Scale_offset + 5) + Scale_height * 0.500, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a7, (ww/2+20), (Scale_offset + 5) + Scale_height * 0.530, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a8, (ww/2+20), (Scale_offset + 5) + Scale_height * 0.588, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a9, (ww/2+20), (Scale_offset + 5) + Scale_height * 0.708, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a10, (ww/2+20), (Scale_offset + 5) + Scale_height * 0.814, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a11, (ww/2+20), (Scale_offset + 5) + Scale_height * 1.000, color_scale_anchors,80);
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
 if settings.do_gamepad == 0   
    %Move cursor to anchor_6 (center position of sclae)
    X = round(ww/2);
    Y = round(Scale_offset + Scale_height * 0.50); %Fix y coordinate
    Slider_y_pos = Y;
    SetMouse(X,Y);

    %Put slider on the screen
    Screen('CopyWindow',rating_scr,w)
    
    Screen('DrawLine',w,[250 0 0],(ww / 2 - 10), Slider_y_pos, (ww / 2 + 10), Slider_y_pos,5)
                
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
                rating.value = 100-((Slider_y_pos - Scale_offset)/Scale_height)*200; %rescaling of scale_height independent of screen resolution [0-100]
                rating.subm = 1;
                flag_resp = 1;
                
            elseif (mouseY ~= Slider_y_pos) %Update screen if participant has scrolled up or down
                Screen('CopyWindow',rating_scr,w);
                Slider_y_pos = (mouseY);
                
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
    
    WaitSecs(timing.feedback_delay); %Show screen for 1.5s post-mouseclick
    
 elseif settings.do_gamepad == 1
    
    %Move cursor to anchor_6 (center position of sclae)
    X = round(ww/2);
    Y = round(Scale_offset + Scale_height * 0.50); %Fix y coordinate
    Slider_y_pos = Y;
    scale_joy_x = ww*0.7/JoystickSpecification.Max;
    scale_joy_y = wh*0.7/JoystickSpecification.Max;

    %Put slider on the screen
    Screen('CopyWindow',rating_scr,w)
    
    Screen('DrawLine',w,[250 0 0],(ww / 2 - 10), Slider_y_pos, (ww / 2 + 10), Slider_y_pos,5)
                
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
    offset_y = Y - round(Joystick.Y * scale_joy_y);
    proj_y = round(Joystick.Y * scale_joy_y) + offset_y;
    
    while ((GetSecs - rating.starttime) < timing.max_dur_rating) && flag_resp == 0 %mousebuttons(1)~=1 
        
        if (GetSecs > nextTime) %Sample every 0.01 seconds
            %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            proj_y = round(Joystick.Y * scale_joy_y) + offset_y;
            
            if Joystick.Button(1) == 1
                rating.RT = GetSecs - rating.starttime;
                flag_resp = 1;
                rating.value = 100-((Slider_y_pos - Scale_offset)/Scale_height)*200; %rescaling of scale_height independent of screen resolution [0-100]
                rating.subm = 1;
                
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
    
    WaitSecs(timing.feedback_delay); %Show screen for feedback_delay past click
    
 end
 
 if flag_resp==0
     
    rating.value = 100-((Slider_y_pos - Scale_offset)/Scale_height)*200;
    rating.subm = 0;
    rating.RT = timing.max_dur_rating; %+ timing.feedback_delay
    
 end
