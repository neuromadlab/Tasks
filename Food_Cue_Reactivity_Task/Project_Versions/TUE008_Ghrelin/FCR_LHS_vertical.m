%%===================LHS vertical===================
%Labeled Hedonic Scale (Lim, Wood, & Green)

%Coded by: Nils Kroemer modified from mood_VAS (coded by Ying Lee) and BDM task (coded by Jean Liu)
%Update coded with: Matlab R2014a using Psychtoolbox 3.0.11

%Update July 2021, Corinna Schulz: 
%removed powermate, incorporated joystick as input option 
%========================================================

%% Start experiment:
% determine in which columns to save FCR data 
RT_column = find(strcmp('rating_RT',output.data_labels(:,1)));
value_column = find(strcmp('rating_value',output.data_labels(:,1)));
submission_column = find(strcmp('rating_submitted',output.data_labels(:,1)));

%--- Start trial---
 
    trial.question = 'liking';
    onset_start = 0;
    
    %--- Prepare off-screen windows---
    
    %rating window (4s)
    rating_scr = Screen('OpenOffscreenwindow',w,color_scale_background);
    text_freerating = [trial.question]; %free rating
    
    %Screen('TextSize',rating_scr,12);  %Commented out so that the text
    %size of the main script is used
    Screen('TextFont',rating_scr,'Arial');
    anchor_1 = ['am allerstaerksten gemochten Empfindung, die vorstellbar ist'];
    anchor_2 = ['extrem gern'];
    anchor_3 = ['sehr gern'];
    anchor_4 = ['gern'];
    anchor_5 = ['ein bisschen gern'];
    anchor_6 = ['neutral'];
    anchor_8 = 'ein bisschen ungern';
    anchor_9 = 'ungern';
    anchor_10 = 'sehr ungern';
    anchor_11 = 'extrem ungern';
    anchor_7 = ['am allerstaerksten zuwidere Empfindung, die vorstellbar ist'];
    instruction = ['Bitte bewerten Sie die Belohnung \nim Vergleich zu allen bisher in \nIhrem Leben erfahrenen Empfindungen.'];
     
    %rescale wh to scale_height
    Scale_height = round(wh * .50);
    Scale_offset = round(wh * .25); %round((wh - Scale_height) * .95);
    
    %improve scale:
    
    imsc = wh/60;
    
    DrawFormattedText(rating_scr, anchor_1, (ww/2+20), (Scale_offset - 10) + Scale_height * 0.000 + imsc, color_scale_anchors,80);
    %DrawFormattedText(rating_scr, [text_freerating ' sensation'], (ww/2+20), (Scale_offset - 10) + 20, [250 0 0],80);
    DrawFormattedText(rating_scr, anchor_2, (ww/2+20), (Scale_offset - 10) + Scale_height * 0.171 + imsc, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor_3, (ww/2+20), (Scale_offset - 10) + Scale_height * 0.278 + imsc, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor_4, (ww/2+20), (Scale_offset - 10) + Scale_height * 0.411 + imsc, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor_5, (ww/2+20), (Scale_offset - 10) + Scale_height * 0.469 + imsc, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor_6, (ww/2-100), (Scale_offset - 10) + Scale_height * 0.500 + imsc, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor_8, (ww/2+20), (Scale_offset - 10) + Scale_height * 0.530 + imsc, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor_9, (ww/2+20), (Scale_offset - 10) + Scale_height * 0.588 + imsc, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor_10, (ww/2+20), (Scale_offset - 10) + Scale_height * 0.708 + imsc, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor_11, (ww/2+20), (Scale_offset - 10) + Scale_height * 0.814 + imsc, color_scale_anchors,80);
    DrawFormattedText(rating_scr, anchor_7, (ww/2+20), (Scale_offset - 10) + Scale_height * 1.000 + imsc, color_scale_anchors,80);
    DrawFormattedText(rating_scr, instruction, (ww/10), 'center', color_scale_anchors,80,[],[],2);
    
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
 if input_type == 0   
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
                output.data(i_trial,value_column) = 100-((Slider_y_pos - Scale_offset)/Scale_height)*200; %rescaling of scale_height independent of screen resolution [0-100]
                output.data(i_trial,submission_column)= 1;
                output.rating.type_num(i_trial,1) = 1;
                t_rating = GetSecs;
                %subj.onsets.scales.button(i_trial,1) = t_rating - subj.trigger.fin;
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
                
                output.data(i_trial,value_column) = 100-((Slider_y_pos - Scale_offset)/Scale_height)*200;
                
                Screen('DrawLine',w,[250 0 0],(ww / 2 - 10), Slider_y_pos, (ww / 2 + 10), Slider_y_pos,5)
                
                Screen('Flip',w);
            end

            nextTime = nextTime+sampleTime;
        end
    end
    
    WaitSecs(timing.feedback_delay); %Show screen for 1.5s post-mouseclick
    
% ------ Joystick Response --------
 elseif input_type == 1 
     
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
    
    while (GetSecs - starttime) < timing.max_dur_rating && flag_resp == 0  
        
        if (GetSecs > nextTime) %Sample every 0.01 seconds
            %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
            proj_y = round(Joystick.Y * scale_joy_y) + offset_y;
            
            if Joystick.Button(1) == 1
                flag_resp = 1;
                Time_button = GetSecs; %record time when button was pressed
            end
            
            if flag_resp==1 %Terminate and record rating on left mouseclick
                output.data(i_trial,value_column) = 100-((Slider_y_pos - Scale_offset)/Scale_height)*200; %rescaling of scale_height independent of screen resolution [0-100]
                output.data(i_trial,submission_column) = 1; % answer was submitted
                output.data(i_trial,RT_column)  = Time_button - starttime; % Reaction Time
                
                %subj.onsets.scales.button(i_trial,1) = t_button - subj.trigger.fin;
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
    % If no submission occured, still save current value
    if flag_resp == 0
        output.data(i_trial,value_column) =  100-((Slider_y_pos - Scale_offset)/Scale_height)*200;
        output.data(i_trial,submission_column)  = 0; % no submission
        output.data(i_trial,RT_column) = NaN; % no RT
    end
    WaitSecs(timing.feedback_delay); %Show screen for 1.5s post-mouseclick
 end

 

