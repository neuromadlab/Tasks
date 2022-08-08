%%===================Caloric Load Questions================================
%Labeled Hedonic Scale (Lim, Wood, & Green) and
%customized visual analogue scales (0-100)

%Author: Corinna Schulz (adapted from LHS_vertical and Effort_VAS)
%coded with: Matlab R2020b using Psychtoolbox 3.0.17

%Update July 2021, Corinna Schulz
%========================================================

%% Start experiment
ScreenType = 1;

% Define colors
color.white = WhiteIndex(setup.screenNum); %with intensity value for white on second screen
color.grey = color.white / 2;
color.black = BlackIndex(setup.screenNum);
color.red = [255 0 0];
color.scale_anchors = color.black;

%% Start rating:
feedback_delay = 0.2; % specifies the duration that the confirmed rating will be displayed on the screen
%Experiment
max_dur_rating = VAS_rating_duration;
%VAS_time_limit = 1; %set 0 für state ratings, 1 for experiment
wait_rest = 0;


% ---- Start trial --------------------------------------------------------
%%Questions: Scale anchors depending on State or Caloric Items
if  strcmp(trial.type,'Caloric_wanting')
    text_question = ['Wie sehr wollen Sie das Getränk jetzt gerade erhalten?'];
    scale.a1 = ['Überhaupt nicht'];
    scale.a7 = ['Sehr stark'];
    
    % Fixation cross
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
    x_mid = JoystickSpecification.Max / 2;
    
    loop_start = GetSecs;
    
    while (Joystick.X < x_mid * 0.85) || (Joystick.X > x_mid * 1.15)
        
        fix_color = color.red;
        
        fix = ['+'];
        Screen('TextSize',w,64);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', fix_color,80);
        time.fix = Screen('Flip', w);
        
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
        
    end
    loop_duration = GetSecs - loop_start;
    wait_rest = wait_rest - loop_duration;
    
    fix_color = color.black;
    
    fix = ['+'];
    Screen('TextSize',w,64);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', fix_color,80);
    time.fix = Screen('Flip', w);
    
    WaitSecs(waiting_duration);
    
    %%
    t_scale_trigger = GetSecs;
    
    %--- Prepare off-screen windows---
    
    %rating window (4s)
    rating_scr = Screen('OpenOffscreenwindow',w,color.white);
    text_freerating = [trial.question]; %free rating
    
    Screen('TextSize',effort_scr,14);
    Screen('TextFont',effort_scr,'Arial');
    
    onset_start = 0;
    
    %%
    %rescale wh to scale_height
    Scale_width = round(setup.ScrWidth * .50);
    %Scale_width = round(ww * .75);
    Scale_offset = round((setup.ScrHeight - (setup.ScrHeight * .95)) * .75);
    %Scale_offset = round((wh - (wh * .95)) * .75);
    
    DrawFormattedText(rating_scr, text_question, 'center', (Scale_offset+setup.ScrHeight/2 - 150), color.scale_anchors,40,[],[],2);
    
    
    DrawFormattedText(rating_scr, [scale.a1], (setup.ScrWidth/2-Scale_width/2 - 65), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
    %DrawFormattedText(rating_scr, [scale.a3], (setup.ScrWidth/2-Scale_width/2 - 55), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
    %DrawFormattedText(rating_scr, [scale.a5], (setup.ScrWidth/2-Scale_width/2 - 40), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
    DrawFormattedText(rating_scr, [scale.a7], (setup.ScrWidth/2+Scale_width/2 - 35), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
    
    
    
    % horizontal scale element
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth/2-Scale_width/2), (Scale_offset+setup.ScrHeight/2), (setup.ScrWidth/2+Scale_width/2), (Scale_offset+setup.ScrHeight/2),3)
    
    % vertical scale elements
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth/2-Scale_width/2), (Scale_offset+setup.ScrHeight/2 - 20), (setup.ScrWidth/2-Scale_width/2), (Scale_offset+setup.ScrHeight/2 + 20),3)
    %Screen('DrawLine',rating_scr,[250 250 250],(ww/2), (Scale_offset+wh/2 - 15), (ww/2), (Scale_offset+wh/2 + 15),3)
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth/2+Scale_width/2), (Scale_offset+setup.ScrHeight/2 - 20), (setup.ScrWidth/2+Scale_width/2), (Scale_offset+setup.ScrHeight/2 + 20),3)
    
    %--- Start display for trial---
    
    %rating window
    Screen('CopyWindow',rating_scr,w);
    Screen('Flip',w);
    
    
    %----Mouse response----
    
    %Move cursor to mean position
    X = round(setup.ScrWidth/2);
    Y = round(Scale_offset + setup.ScrHeight/2); %Fix y coordinate
    Slider_x_pos = X;
    %SetMouse(X,Y);
    %scale_joy_x = ww*1.1/JoystickSpecification.Max;
    %scale_joy_y = wh*1.1/JoystickSpecification.Max;
    scale_joy_x = setup.ScrWidth*0.7/JoystickSpecification.Max;
    scale_joy_y = setup.ScrHeight*0.7/JoystickSpecification.Max;
    
    %Put slider on the screen
    Screen('CopyWindow',rating_scr,w)
    
    Screen('DrawLine',w,[250 0 0], Slider_x_pos, Y-10, Slider_x_pos, Y+ 10, 5)
    
    Screen('Flip',w);
    
    %Loop and track mouse such that rating slider moves according to mouse position (edited from MouseTraceDemo)
    sampleTime = 0.01;
    startTime = GetSecs;
    nextTime = startTime+sampleTime;
    flag_resp = 0;
    
    output.timestamps.trial_start(i_state) = startTime; %Time run starts
    
    %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
    offset_x = X - round(Joystick.X * scale_joy_x);
    proj_x = round(Joystick.X * scale_joy_x) + offset_x;
    
    while (GetSecs - t_scale_trigger) < max_dur_rating && flag_resp == 0 %mousebuttons(1)~=1
        
        if (GetSecs > nextTime) %Sample every 0.01 seconds
            %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
            proj_x = round(Joystick.X * scale_joy_x) + offset_x;
            
            if Joystick.Button(1) == 1
                flag_resp = 1;
                t_button = GetSecs;
                output.timestamps.trial_response(i_state) = t_button; %Time run starts
                
            end
            
            if flag_resp==1 %Terminate and record rating on left mouseclick
                
                t_rating_ref = t_button - startTime;
                
                rating = ((Slider_x_pos - (setup.ScrWidth/2-Scale_width/2))/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
                rating_label = text_freerating;
                rating_subm = 1;
                
                
            elseif (proj_x ~= Slider_x_pos) %Update screen if participant has scrolled up or down
                Screen('CopyWindow',rating_scr,w);
                Slider_x_pos = (proj_x);
                
                %restrict range of slider to defined scale
                if Slider_x_pos < (setup.ScrWidth/2 - Scale_width/2)
                    Slider_x_pos = (setup.ScrWidth/2 - Scale_width/2);
                elseif Slider_x_pos > (setup.ScrWidth/2 + Scale_width/2)
                    Slider_x_pos = (setup.ScrWidth/2 + Scale_width/2);
                end
                
                Screen('DrawLine',w,[250 0 0],Slider_x_pos, Y - 10, Slider_x_pos, Y + 10,5)
                
                Screen('Flip',w);
            end
            nextTime = nextTime+sampleTime;
        end
    end
    
    if flag_resp==0 %Terminate without click
        
        rating = ((Slider_x_pos - (setup.ScrWidth/2-Scale_width/2))/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
        rating_label = text_freerating;
        rating_subm = 0;
        
        t_rating_ref = GetSecs - startTime;
    end
    wait_rest = max_dur_rating - t_rating_ref;
    WaitSecs(feedback_delay); %Show screen for 1s post-mouseclick
    
elseif  strcmp(trial.type,'Caloric_liking')
    text_question = ['Bitte bewerten Sie das Getränk jetzt gerade im Vergleich zu allen bisher in Ihrem Leben erfahrenen Empfindungen.'];
    scale.a7 = ['am allerstaerksten gemochte \n Empfindung, die vorstellbar ist'];
    scale.a1 = ['am allerstaerksten zuwidere \n Empfindung, die vorstellbar ist'];
    
    timing.feedback_delay = 0.20; %for scales
    
    % Display settings
    color_scale_background = [255 255 255]; %white
    color_scale_anchors = [0 0 0]; %black
    
    screen_offset_y = 0.01; %relative offset; positive values move the screen towards to top, negative towards the bottom
    scale_offset_y = 0.25;

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
    
    
    % ------ Joystick Response --------
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
    
    
    Screen('Flip',w);
    
    
    %Loop and track mouse such that rating slider moves according to mouse position (edited from MouseTraceDemo)
    sampleTime = 0.01;
    startTime = GetSecs;
    nextTime = startTime+sampleTime;
    flag_resp = 0;
    
    output.timestamps.trial_start(i_state) = startTime; %Time run starts
    
    
    %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
    offset_y = Y - round(Joystick.Y * scale_joy_y);
    proj_y = round(Joystick.Y * scale_joy_y) + offset_y;
    
    while (GetSecs - startTime) < max_dur_rating && flag_resp == 0
        
        if (GetSecs > nextTime) %Sample every 0.01 seconds
            %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
            proj_y = round(Joystick.Y * scale_joy_y) + offset_y;
            
            if Joystick.Button(1) == 1
                flag_resp = 1;
                t_button = GetSecs; %record time when button was pressed
                output.timestamps.trial_response(i_state) = t_button; %Time run starts
            end
            
            if flag_resp==1 %Terminate and record rating on left mouseclick
                
                t_rating_ref = t_button - startTime;
                
                rating = 100-((Slider_y_pos - Scale_offset)/Scale_height)*200; %rescaling of scale_height independent of screen resolution [0-100]
                rating_label = text_freerating;
                rating_subm = 1;
                
                
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
        rating =  100-((Slider_y_pos - Scale_offset)/Scale_height)*200;
        rating_label  = text_freerating;
        rating_subm = 0;
    end
    wait_rest = max_dur_rating - t_rating_ref;
    WaitSecs(feedback_delay); %Show screen for 1.5s post-mouseclick
    
end

    
    
   


    
    