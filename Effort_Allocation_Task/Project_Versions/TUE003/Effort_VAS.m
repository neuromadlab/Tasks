%%===================VAS horizontal===================
%customized visual analogue scales (0-100)
%Answer with Joystick (USB Xbox-360 Controller)
%
%Modified by Monja Neuser + ww replaced by setup.ScrWidth (not sure if
%correct, wh replaced bz ScrHeight)
%   to be used in effort allocation task
%Coded by: Nils Kroemer modified from mood_VAS (coded by Ying Lee) and BDM task (coded by Jean Liu)

%Update coded with: Matlab R2014a using Psychtoolbox 3.0.11
%========================================================

ScreenType = 1; %Set 1 for For LG Screen in testing room 225
                %Set 0 for previous settings

%% Start rating:
feedback_delay = 0.2; % specifies the duration that the confirmed rating will be displayed on the screen
max_dur_rating = timings.VAS_rating_duration;
if settings.VAS_input == 0

    fix = ['+'];
    Screen('TextSize',w,64);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', color.black,80);
    time.fix = Screen('Flip', w);

    WaitSecs(1);
    
else
    % Fixation cross
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    x_mid = JoystickSpecification.Max / 2;
    
    loop_start = GetSecs;
    while (Joystick.X < x_mid * 0.85) || (Joystick.X > x_mid * 1.15)

        fix_color = color.red;

        fix = ['+'];
        Screen('TextSize',w,64);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', color.black,80);
        time.fix = Screen('Flip', w);

        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

    end
   
    loop_duration = GetSecs - loop_start;
    fix_time = max(1 - loop_duration, 0);
    
    fix = ['+'];
    Screen('TextSize',w,64);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', color.black,80);
    time.fix = Screen('Flip', w);
    
    WaitSecs(fix_time);
end

%% Start trial
t_scale_trigger = GetSecs; 
trial.runstart = GetSecs; %Time run starts

%--- Prepare off-screen windows---

%rating window (4s)
rating_scr      = Screen('OpenOffscreenwindow',w,color.white);
text_freerating = [trial.question]; %free rating

Screen('TextSize',effort_scr,14);
Screen('TextFont',effort_scr,'Arial');

if strcmp(trial.question,'pain')
   if strcmp(settings.lang_de,'1')
       scale.anchor_NoSensation         = 'keine Empfindung';
       scale.anchor_LightSensation      = 'leichtes\nPulsieren';
       scale.anchor_LightTingling       = 'leichtes\nKribbeln';
       scale.anchor_ModerateTingling    = 'deutlich\nspuerbares\nKribbeln';
       scale.anchor_StrongTingling      = 'deutlich\nspuerbares\nPrickeln';
       scale.anchor_LightPricking       = 'leichtes\nStechen';
       scale.anchor_ModeratePricking    = 'deutlich\nspuerbares\nStechen';    
       scale.anchor_Pricking            = 'schmerzhaftes\nStechen';
       scale.anchor_Pain                = 'starker\nSchmerz';
       scale.anchor_UnbearablePain      = 'unertraeglicher\nSchmerz';  
       scale.anchor_StrongestSensation  = 'staerkste vorstellbare Empfindung';
   elseif strcmp(settings.lang_de,'2')
       scale.anchor_NoSensation         = 'No sensation';
       scale.anchor_LightSensation      = 'Light\npulsation';
       scale.anchor_LightTingling       = 'Light\ntingling';
       scale.anchor_ModerateTingling    = 'Noticeable\ntingling';
       scale.anchor_StrongTingling      = 'Noticeable\nprickling';
       scale.anchor_LightPricking       = 'Light\nstinging';
       scale.anchor_ModeratePricking    = 'Noticeable\nstinging';    
       scale.anchor_Pricking            = 'Painful\nstinging';
       scale.anchor_Pain                = 'Strong\npain';
       scale.anchor_UnbearablePain      = 'Unbearable\npain';  
       scale.anchor_StrongestSensation  = 'Strongest imaginable sensation';
   end
   scale.anchor_0  = '0';
   scale.anchor_1  = '1';
   scale.anchor_2  = '2';
   scale.anchor_3  = '3';      
   scale.anchor_4  = '4';
   scale.anchor_5  = '5';
   scale.anchor_6  = '6';
   scale.anchor_7  = '7';
   scale.anchor_8  = '8';
   scale.anchor_9  = '9';
   scale.anchor_10 = '10'; 
else    
    if strcmp(settings.lang_de,'1')
        scale.anchor_1 = 'ueberhaupt nicht';
        %scale.anchor_4 = ['Neutral'];
        scale.anchor_7 = 'sehr';
    elseif strcmp(settings.lang_de,'2')
        scale.anchor_1 = 'not at all';
        %scale.anchor_4 = ['Neutral'];
        scale.anchor_7 = 'very';
    end
end
    
%% Questions   
if  strcmp(trial.question,'wanted')
    if strcmp(settings.lang_de,'1')
        text_question = ['Wie sehr wollten Sie die Belohnung in diesem Durchgang erhalten?'];
    elseif strcmp(settings.lang_de,'2')
        text_question = ['How much did you want the reward presented in this trial?'];
    end
elseif strcmp(trial.question,'exhausted')
    if strcmp(settings.lang_de,'1')
        text_question = ['Wie stark haben Sie sich in diesem Durchgang verausgabt?'];    
    elseif strcmp(settings.lang_de,'2')
        text_question = ['How much did you exert yourself in this trial?'];    
    end
%elseif strcmp(trial.question,'pain')
%    text_question = ['Wie stark empfinden Sie Schmerz durch die Stimulation?']
else %e.g. strcmp(trial.question,'hungry')
    if strcmp(settings.lang_de,'1')
        text_question = ['Wie ' trial.question  ' fuehlen Sie sich im Moment?'];
    elseif strcmp(settings.lang_de,'2')
        text_question = ['How ' trial.question  ' do you feel at the moment?'];
    end
end
    
%rescale wh to scale_height
Scale_width = round(setup.ScrWidth * .50);
Scale_offset = round((setup.ScrHeight - (setup.ScrHeight * .95)) * .75);

DrawFormattedText(rating_scr, text_question, 'center', (Scale_offset+setup.ScrHeight/2 - 150), color.black,40,[],[],2);
    
%% Different scale labels for pain VAS
if strcmp(trial.question,'pain')
    Screen('TextSize',w,10);
    xcorbase1 = setup.ScrWidth/2-Scale_width/2 - 6;
    xcorbase2 = setup.ScrWidth/2+Scale_width/2 - 6;
    ycorbase  = Scale_offset+setup.ScrHeight/2 + 40;

    if ScreenType == 1
        DrawFormattedText(rating_scr, [scale.anchor_0], (xcorbase1), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_NoSensation], (xcorbase1 - 110), (ycorbase + 35), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_1], (xcorbase1 + 96), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_LightSensation], (xcorbase1 + 52), (ycorbase + 110), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_2], (xcorbase1 + 192), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_LightTingling], (xcorbase1 + 136), (ycorbase + 35), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_3], (xcorbase1 + 288), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_ModerateTingling], (xcorbase1 + 234), (ycorbase + 110), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_4], (xcorbase1 + 384), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_StrongTingling], (xcorbase1 + 328), (ycorbase + 35), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_5], (setup.ScrWidth/2 - 6), (ycorbase), [205 201 201],80);
        DrawFormattedText(rating_scr, [scale.anchor_LightPricking], (setup.ScrWidth/2 - 40), (ycorbase + 110), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_6], (xcorbase2 - 384), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_ModeratePricking], (xcorbase2 - 406), (ycorbase + 35), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_7], (xcorbase2 - 288), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_Pricking], (xcorbase2 - 308), (ycorbase + 110), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_8], (xcorbase2 - 192), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_Pain],(xcorbase2 - 210), (ycorbase + 35), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_9], (xcorbase2 - 96), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_UnbearablePain], (xcorbase2 - 122), (ycorbase + 110), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_10], (xcorbase2 - 4), (ycorbase), color.black,80); 
        DrawFormattedText(rating_scr, [scale.anchor_StrongestSensation], (xcorbase2 - 49), (ycorbase + 35), color.black,40); 

    else 

        DrawFormattedText(rating_scr, [scale.anchor_0], (xcorbase1), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_NoSensation], (xcorbase1 - 104), (ycorbase + 35), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_1], (xcorbase1 + 84), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_LightSensation], (xcorbase1 + 50), (ycorbase + 110), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_2], (xcorbase1 + 168), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_LightTingling], (xcorbase1 + 126), (ycorbase + 35), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_3], (xcorbase1 + 252), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_ModerateTingling], (xcorbase1 + 216), (ycorbase + 110), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_4], (xcorbase1 + 336), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_StrongTingling], (xcorbase1 + 296), (ycorbase + 35), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_5], (setup.ScrWidth/2 -6), (ycorbase), [205 201 201],80);
        DrawFormattedText(rating_scr, [scale.anchor_LightPricking], (setup.ScrWidth/2 - 40), (ycorbase + 110), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_6], (xcorbase2 - 336), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_ModeratePricking], (xcorbase2 - 374), (ycorbase + 35), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_7], (xcorbase2 - 252), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_Pricking], (xcorbase2 - 284), (ycorbase + 110), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_8], (xcorbase2 - 168), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_Pain], (xcorbase2 - 194), (ycorbase + 35), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_9], (xcorbase2 - 84), (ycorbase), color.black,80);
        DrawFormattedText(rating_scr, [scale.anchor_UnbearablePain], (xcorbase2 - 114), (ycorbase + 110), color.black,40);

        DrawFormattedText(rating_scr, [scale.anchor_10], (xcorbase2 - 4), (ycorbase), color.black,80); 
        DrawFormattedText(rating_scr, [scale.anchor_StrongestSensation], (xcorbase2 - 49), (ycorbase + 35), color.black,40); 
        
        xcorbase1 = setup.ScrWidth/2-Scale_width/2;
        xcorbase2 = setup.ScrWidth/2+Scale_width/2;
        ycorbase  = Scale_offset+setup.ScrHeight/2;
    end

else % Draw regular VAS scale 
    xcorbase1 = setup.ScrWidth/2-Scale_width/2;
    xcorbase2 = setup.ScrWidth/2+Scale_width/2;
    ycorbase  = Scale_offset+setup.ScrHeight/2;
    DrawFormattedText(rating_scr, [scale.anchor_1], (xcorbase1 - 65), (ycorbase + 40), color.black,80);
    %DrawFormattedText(rating_scr, [scale.anchor_4], 'center', (Scale_offset+wh/2 + 30), [205 201 201],80);
    DrawFormattedText(rating_scr, [scale.anchor_7], (xcorbase2 - 35), (ycorbase + 40), color.black,80);
end

% horizontal scale element
Screen('DrawLine',rating_scr,color.black,(xcorbase1), (ycorbase), (xcorbase2), (ycorbase),3)

% vertical scale elements
Screen('DrawLine',rating_scr,color.black,(xcorbase1), (ycorbase - 20), (xcorbase1), (ycorbase + 20),3)
Screen('DrawLine',rating_scr,color.black,(xcorbase2), (ycorbase - 20), (xcorbase2), (ycorbase + 20),3)

%% Start display for trial

%rating window
Screen('CopyWindow',rating_scr,w);
Screen('Flip',w);

%coordinates
X            = round(setup.ScrWidth/2);
Y            = round(Scale_offset + setup.ScrHeight/2); %Fix y coordinate
Slider_x_pos = X;

%Put slider on the screen
Screen('CopyWindow',rating_scr,w)
Screen('DrawLine',w,[250 0 0],Slider_x_pos, (ycorbase - 10), Slider_x_pos, (ycorbase + 10),5)
Screen('Flip',w);

%Loop and track input such that rating slider moves according to mouse position (edited from MouseTraceDemo)
sampleTime  = 0.01;
startTime   = GetSecs;
nextTime    = startTime+sampleTime;
flag_resp   = 0;

if settings.VAS_input == 0  
%% Mouse response

%Move cursor to mean position
SetMouse(X,Y);

if settings.do_timelimit == 1    
   [mouseX, mouseY, mousebuttons] = GetMouse(0); %Find out coordinates of current mouse position 
   while (GetSecs - startTime) < max_dur_rating && flag_resp == 0 %mousebuttons(1)~=1 
        
        if (GetSecs > nextTime) %Sample every 0.01 seconds
            [mouseX, mouseY, mousebuttons] = GetMouse(0); %Find out coordinates of current mouse position
            
            if mousebuttons(1)==1 || mousebuttons(3)==1%Terminate and record rating on left mouseclick
                output.rating.value(i_trial,1)    = ((Slider_x_pos - xcorbase1)/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
                output.rating.label{i_trial,1}    = text_freerating;
                output.rating.subm(i_trial,1)     = 1;
                output.rating.type_num(i_trial,1) = 0;
                t_rating = GetSecs;
              %  subj.onsets.scales.button(i,1) = t_rating - subj.trigger.fin;
                flag_resp                         = 1;
                
            elseif (mouseX ~= Slider_x_pos) %Update screen if participant has scrolled up or down
                Screen('CopyWindow',rating_scr,w);
                Slider_x_pos    = (mouseX);
                rating          = ((Slider_x_pos - xcorbase1)/ Scale_width)*100;
                rating_type_num = 0;
                
                %restrict range of slider to defined scale
                if Slider_x_pos < (xcorbase1)
                    Slider_x_pos = (xcorbase1);
                elseif Slider_x_pos > (xcorbase2)
                    Slider_x_pos = (xcorbase2);
                end
                
                Screen('DrawLine',w,[250 0 0],Slider_x_pos, (ycorbase - 10), Slider_x_pos, (ycorbase + 10),5)
                
                Screen('Flip',w);
            end

            nextTime = nextTime+sampleTime;
        end
    
   end
elseif  settings.do_timelimit == 0
    [mouseX, mouseY, mousebuttons] = GetMouse(0); %Find out coordinates of current mouse position
        while flag_resp == 0 %mousebuttons(1)~=1 
        
        if (GetSecs > nextTime) %Sample every 0.01 seconds
            [mouseX, mouseY, mousebuttons] = GetMouse(0); %Find out coordinates of current mouse position
            
            if mousebuttons(1)==1 || mousebuttons(3)==1 %Terminate and record rating on left mouseclick
                output.rating.value(i_trial,1)    = ((Slider_x_pos - xcorbase1)/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
                output.rating.label{i_trial,1}    = text_freerating;
                output.rating.subm(i_trial,1)     = 1;
                output.rating.type_num(i_trial,1) = 0;
                t_rating = GetSecs;
              %  subj.onsets.scales.button(i,1) = t_rating - subj.trigger.fin;
                flag_resp                         = 1;
                %out_ind = out_ind + 1;
                
            elseif (mouseX ~= Slider_x_pos) %Update screen if participant has scrolled up or down
                Screen('CopyWindow',rating_scr,w);
                Slider_x_pos    = (mouseX);
                rating          = ((Slider_x_pos - xcorbase1)/ Scale_width)*100;
                rating_type_num = 0;
                
                %restrict range of slider to defined scale
                if Slider_x_pos < (xcorbase1)
                    Slider_x_pos = (xcorbase1);
                elseif Slider_x_pos > (xcorbase2)
                    Slider_x_pos = (xcorbase2);
                end
                
                Screen('DrawLine',w,[250 0 0],Slider_x_pos, (ycorbase - 10), Slider_x_pos, (ycorbase + 10),5)
                
                Screen('Flip',w);
            end

            nextTime = nextTime+sampleTime;
        end
        end 
    
end
elseif settings.VAS_input == 1
%% Joystick response    

%Move cursor to mean position
scale_joy_x = setup.ScrWidth*0.7/JoystickSpecification.Max;
scale_joy_y = setup.ScrHeight*0.7/JoystickSpecification.Max;

if settings.do_timelimit == 1
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
offset_x    = X - round(Joystick.X * scale_joy_x);
proj_x      = round(Joystick.X * scale_joy_x) + offset_x;    
    while (GetSecs - t_scale_trigger) < max_dur_rating && flag_resp == 0 %mousebuttons(1)~=1 
        
        if (GetSecs > nextTime) %Sample every 0.01 seconds
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            proj_x = round(Joystick.X * scale_joy_x) + offset_x;
            
            if Joystick.Button(1) == 1
                flag_resp = 1;
                t_button = GetSecs;
            end
            
                if flag_resp==1 %Terminate and record rating on left mouseclick
                    
                    t_rating_ref    = t_button - startTime;                                        
                    rating          = ((Slider_x_pos - xcorbase1)/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
                    rating_label    = text_freerating;
                    rating_subm     = 1;
                    

                elseif (proj_x ~= Slider_x_pos) %Update screen if participant has scrolled up or down
                    Screen('CopyWindow',rating_scr,w);
                    Slider_x_pos = (proj_x);

                    %restrict range of slider to defined scale
                    if Slider_x_pos < xcorbase1
                        Slider_x_pos = xcorbase1;
                    elseif Slider_x_pos > xcorbase2
                        Slider_x_pos = xcorbase2;
                    end

                    Screen('DrawLine',w,[250 0 0],Slider_x_pos, Y - 10, Slider_x_pos, Y + 10,5)
                    Screen('Flip',w);
                    
                end
            nextTime = nextTime+sampleTime;
        end
    end
elseif settings.do_timelimit == 0
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
offset_x    = X - round(Joystick.X * scale_joy_x);
proj_x      = round(Joystick.X * scale_joy_x) + offset_x;    
    while flag_resp == 0 %mousebuttons(1)~=1 
        
        if (GetSecs > nextTime) %Sample every 0.01 seconds
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            proj_x = round(Joystick.X * scale_joy_x) + offset_x;
            
            if Joystick.Button(1) == 1
                flag_resp = 1;
                t_button = GetSecs;
            end
            
                if flag_resp==1 %Terminate and record rating on left mouseclick
                    
                    t_rating_ref    = t_button - startTime;                                        
                    rating          = ((Slider_x_pos - xcorbase1)/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
                    rating_label    = text_freerating;
                    rating_subm     = 1;
                    

                elseif (proj_x ~= Slider_x_pos) %Update screen if participant has scrolled up or down
                    Screen('CopyWindow',rating_scr,w);
                    Slider_x_pos = (proj_x);

                    %restrict range of slider to defined scale
                    if Slider_x_pos < xcorbase1
                        Slider_x_pos = xcorbase1;
                    elseif Slider_x_pos > xcorbase2
                        Slider_x_pos = xcorbase2;
                    end

                    Screen('DrawLine',w,[250 0 0],Slider_x_pos, Y - 10, Slider_x_pos, Y + 10,5)
                    Screen('Flip',w);
                    
                end
            nextTime = nextTime+sampleTime;
        end
    end
end
end
    
button = 0;
rating = ((Slider_x_pos - (xcorbase1))/ Scale_width)*100;

WaitSecs(feedback_delay); %Show screen for 1.5s post-mouseclick


 if flag_resp==0 %Terminate without click

        rating       = ((Slider_x_pos - (xcorbase1))/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
        rating_label = text_freerating;
        rating_subm  = 0;      
        t_rating_ref = GetSecs - startTime;

 else

        rating_label = text_freerating;
        rating_subm  = 1;
        t_rating_ref = GetSecs - startTime;

 end

WaitSecs(feedback_delay); %Show screen for 1s post-mouseclick

