
%%===================VAS horizontal===================
%customized visual analogue scales (0-100)
%Answer with Joystick (USB Xbox-360 Controller)
%
%Modified by Sophie Mueller & Alessandro Petrella (26-11-2020)
%
%Modified by Monja Neuser
%   to be used in effort allocation task
%Coded by: Nils Kroemer modified from mood_VAS (coded by Ying Lee) and BDM task (coded by Jean Liu)

%Update coded with: Matlab R2020a using Psychtoolbox 3.0.11
%========================================================

ScreenType = 2; %Set 2 for 4:3 Screen in sleep laboratory in the CIN
                %Set 0 for previous settings


% Define colors
color.white = WhiteIndex(setup.screenNum); %with intensity value for white on second screen
color.grey = color.white / 2;
color.black = BlackIndex(setup.screenNum);
color.red = [255 0 0];
color.scale_anchors = color.black;


%% Start rating:
feedback_delay = 0.2; % specifies the duration that the confirmed rating will be displayed on the screen
%max_dur_rating = 4; %Previously fixed, variable for State ratings and
%Experiment
max_dur_rating = VAS_rating_duration;
%VAS_time_limit = 1; %set 0 f�r state ratings, 1 for experiment
wait_rest = 0;

%and initialize jitter counter
count_jitter = 1;


% Fixation cross
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
x_mid = JoystickSpecification.Max / 2;


loop_start = GetSecs;
while (Joystick.X < x_mid * 0.85) || (Joystick.X > x_mid * 1.15)
   
    fix_color = color.red;
    
    fix = ['+'];
    Screen('TextSize',w,64);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', fix_color,80);
    time.fix = Screen('Flip', w);
    
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

end
    loop_duration = GetSecs - loop_start;
    wait_rest = wait_rest - loop_duration;
    
    fix_color = color.black;

    fix = ['+'];
    Screen('TextSize',w,64);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', fix_color,80);
    time.fix = Screen('Flip', w);
   
    iti_jitter = 0.3+jitter(count_jitter);
    
    if  (VAS_time_limit == 1) && (wait_rest > 0)
        
        iti_jitter = iti_jitter+wait_rest;
    end
    
    WaitSecs(iti_jitter);

count_jitter = count_jitter + 1;

%--- Start trial---
%for i=1:length(questionlist{1,1}); %number of questions
t_scale_trigger = GetSecs; 

trial.runstart = GetSecs; %Time run starts

%--- Prepare off-screen windows---

%rating window (4s)
rating_scr = Screen('OpenOffscreenwindow',w,color.white);
% Screen('Flip',rating_scr)
Screen('TextSize',rating_scr,32);
Screen('TextFont',rating_scr,'Arial');

if settings.lang_de == 1
    if strcmp(trial.question,'pain')
       scale.anchor_NoSensation = 'keine \nEmpfindung';
       scale.anchor_LightSensation = 'leichtes\nPulsieren';
       scale.anchor_LightTingling = 'leichtes\nKribbeln';
       scale.anchor_ModerateTingling = 'deutlich\nspuerbares\nKribbeln';
       scale.anchor_StrongTingling = 'deutlich\nspuerbares\nPrickeln';
       scale.anchor_LightPricking = 'leichtes\nStechen';
       scale.anchor_ModeratePricking = 'deutlich\nspuerbares\nStechen';    
       scale.anchor_Pricking = 'schmerzhaftes\nStechen';
       scale.anchor_Pain = 'starker\nSchmerz';
       scale.anchor_UnbearablePain = 'unertraeglicher\nSchmerz';  
       scale.anchor_StrongestSensation = ['staerkste \nvorstellbare \nEmpfindung'];
       scale.anchor_0 = '0';
       scale.anchor_1 = '1';
       scale.anchor_2 = '2';
       scale.anchor_3 = '3';      
       scale.anchor_4 = '4';
       scale.anchor_5 = '5';
       scale.anchor_6 = '6';
       scale.anchor_7 = '7';
       scale.anchor_8 = '8';
       scale.anchor_9 = '9';
       scale.anchor_10 = '10';

    elseif strcmp(trial.type,'fcqtr_1')
        scale.anchor_1 = ['Ueberhaupt nicht'];
        scale.anchor_7 = ['Extrem gut'];

    elseif strcmp(trial.type,'fcqtr_2')
        scale.anchor_1 = ['Nie'];
        scale.anchor_7 = ['Immer'];

    elseif strcmp(scale_type,'load')
        scale.anchor_1 =['Trifft gar nicht zu'];
        scale.anchor_7 =['Trifft voellig zu'];

    elseif strcmp(scale_type,'willingnesspay')
        scale.anchor_1 =['0 Euro'];
        scale.anchor_7 =['2 Euro'];

    else    
        scale.anchor_1 = ['Ueberhaupt nicht'];
        %scale.anchor_4 = ['Neutral'];
        scale.anchor_7 = ['Sehr stark'];
    end
else
    if strcmp(trial.question,'pain') % english translation
       scale.anchor_NoSensation = 'No \nsensation';
       scale.anchor_LightSensation = 'light\npulsation';
       scale.anchor_LightTingling = 'light\ntingling';
       scale.anchor_ModerateTingling = 'clearly\noticeable\ntingling';
       scale.anchor_StrongTingling = 'strongly\nnoticeable\ntingling';
       scale.anchor_LightPricking = 'light\nprickling';
       scale.anchor_ModeratePricking = 'clearly\nnoticeable\nprickling';    
       scale.anchor_Pricking = 'strongly\nnoticeable\nprickling';
       scale.anchor_Pain = 'strong\npain';
       scale.anchor_UnbearablePain = 'unbearable\npain';  
       scale.anchor_StrongestSensation = ['strongest \nimaginable \nsensation'];
       scale.anchor_0 = '0';
       scale.anchor_1 = '1';
       scale.anchor_2 = '2';
       scale.anchor_3 = '3';      
       scale.anchor_4 = '4';
       scale.anchor_5 = '5';
       scale.anchor_6 = '6';
       scale.anchor_7 = '7';
       scale.anchor_8 = '8';
       scale.anchor_9 = '9';
       scale.anchor_10 = '10';

    elseif strcmp(scale_type,'load_1')
        scale.anchor_1 = ['absolutely not'];
        scale.anchor_7 = ['extremely good'];

    elseif strcmp(scale_type,'load_2')
        scale.anchor_1 = ['never'];
        scale.anchor_7 = ['always'];

    elseif strcmp(scale_type,'fcqtr')
        scale.anchor_1 =['does not apply at all'];
        scale.anchor_7 =['definitely applies'];

    elseif strcmp(scale_type,'willingnesspay')
        scale.anchor_1 =['0 Euros'];
        scale.anchor_7 =['2 Euros'];

    else    
        scale.anchor_1 = ['not at all'];
        %scale.anchor_4 = ['Neutral'];
        scale.anchor_7 = ['a lot'];
    end
end

%%Questions   
if  strcmp(trial.question,'wanted')
    if settings.lang_de == 1
        text_question = ['Wie sehr wollen Sie den Milchshake erhalten?'];
    else
        text_question = ['How much did you want to receive the milkshake?']; %english translation
    end
elseif  strcmp(trial.question, 'liking')
    if settings.lang_de == 1
        text_question = ['Bitte bewerten Sie den Milchshake im Vergleich zu allen bisher in Ihrem Leben erfahrenen Empfindungen.'];
        anchor.a1 = ['am allerstaerksten gemochte \nEmpfindung, die vorstellbar ist'];
        anchor.a2 = ['extrem gern'];
        anchor.a3 = ['sehr gern'];
        anchor.a4 = ['gern'];
        anchor.a5 = ['ein bisschen gern'];
        anchor.a6 = ['neutral'];
        anchor.a7 = ['ein bisschen ungern'];
        anchor.a8 = ['ungern'];
        anchor.a9 = ['sehr ungern'];
        anchor.a10 = ['extrem ungern'];
        anchor.a11 = ['am allerstaerksten zuwidere \nEmpfindung, die vorstellbar ist'];
    else
        text_question = ['Please rate the milkshake in comparison with all of the sensations you have experienced in your life.']; %english translation
        anchor.a1 = ['most liked sensation imaginable'];
        anchor.a2 = ['like extremely'];
        anchor.a3 = ['like very much'];
        anchor.a4 = ['like moderately'];
        anchor.a5 = ['like slightly'];
        anchor.a6 = ['neutral'];
        anchor.a7 = ['slightly dislike' ];
        anchor.a8 = ['moderately dislike' ];
        anchor.a9 = ['dislike very much' ];
        anchor.a10 = ['extremely dislike' ];
        anchor.a11 = ['most disliked sensation imaginable'];
    end 
elseif strcmp(trial.question,'exhausted')
    if settings.lang_de == 1
        text_question = ['Wie stark haben Sie sich in diesem Durchgang verausgabt?'];
    else
        text_question = ['How much did you exert yourself in this trial?']; %english translation
    end
elseif strcmp(trial.question,'pain')
    if settings.lang_de == 1
        text_question = ['Wie stark empfinden Sie Schmerz durch die Stimulation?'];
    else
        text_question = ['How strong did you feel pain from the stimulation?']; %english translation
    end
elseif strcmp(question_type,'fcqtr')
    text_question =[trial.question];
elseif strcmp(question_type,'load') && subj.t == 2
    if settings.lang_de == 1
        text_question = ['Wie ' trial.question ' fanden Sie den Shake?'];
    else
        text_question = ['How ' trial.question ' did you find the milkshake?']; %english translation -- not sure how to translate this?
    end
elseif strcmp(question_type,'load') && subj.t == 3
    if settings.lang_de == 1
        text_question = ['Wie ' trial.question ' fanden Sie das Muesli?'];
    else
        text_question = ['How ' trial.question ' did you find the muesli?']; %english translation -- not sure how to translate this?
    end
elseif strcmp(question_type,'tvns')
    if settings.lang_de == 1
        text_question = ['Wie ' trial.question ' fanden Sie die Stimulation?']; 
    else
        text_question = ['How ' trial.question ' did you find the stimulation?'];
    end
elseif strcmp(question_type,'willingnesspay')
    %text_question = trial.question;
else %e.g. strcmp(trial.question,'hungry')
    %text_question = strcat({'Wie '}, trial.question,  ' fuehlen Sie sich im Moment?');
    if settings.lang_de == 1
        text_question = ['Wie ' trial.question  ' fuehlen Sie sich im Moment?'];  
    else
        text_question = ['How ' trial.question ' do you feel in this moment?']; %english translation
    end
end




if strcmp(trial.question, 'liking') % vertical scale

    %rescale wh to scale_height
    %Scale_height = round(setup.ScrHeight * .50);
    Scale_height = round(setup.ScrHeight * .66);
    %Scale_offset = round(setup.ScrHeight * scale_offset_y);
    Scale_offset = round((setup.ScrHeight - (setup.ScrHeight * .85)) * .75);

    DrawFormattedText(rating_scr, anchor.a1, (setup.ScrWidth/2+20), (Scale_offset + 5) + Scale_height * 0.000, color.scale_anchors,80);
    %DrawFormattedText(rating_scr, [text_freerating ' sensation'], (setup.ScrWidth/2+20), (Scale_offset - 10) + 20, [250 0 0],80);
    DrawFormattedText(rating_scr, anchor.a2, (setup.ScrWidth/2+20), (Scale_offset + 5) + Scale_height * 0.171, color.scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a3, (setup.ScrWidth/2+20), (Scale_offset + 5) + Scale_height * 0.278, color.scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a4, (setup.ScrWidth/2+20), (Scale_offset + 5) + Scale_height * 0.411, color.scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a5, (setup.ScrWidth/2+20), (Scale_offset + 5) + Scale_height * 0.469, color.scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a6, (setup.ScrWidth/2-120), (Scale_offset + 5) + Scale_height * 0.500, color.scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a7, (setup.ScrWidth/2+20), (Scale_offset + 5) + Scale_height * 0.530, color.scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a8, (setup.ScrWidth/2+20), (Scale_offset + 5) + Scale_height * 0.588, color.scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a9, (setup.ScrWidth/2+20), (Scale_offset + 5) + Scale_height * 0.708, color.scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a10, (setup.ScrWidth/2+20), (Scale_offset + 5) + Scale_height * 0.814, color.scale_anchors,80);
    DrawFormattedText(rating_scr, anchor.a11, (setup.ScrWidth/2+20), (Scale_offset + 5) + Scale_height * 1.000, color.scale_anchors,80);
    DrawFormattedText(rating_scr, text_question, (setup.ScrWidth/30), 'center', [200 0 0],30,[],[],2);

    % horizontal scale elements
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth / 2 - 2), Scale_offset + Scale_height * 0.000, (setup.ScrWidth / 2 + 15), Scale_offset + Scale_height * 0.000,3)
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth / 2 - 2), Scale_offset + Scale_height * 0.171, (setup.ScrWidth / 2 + 15), Scale_offset + Scale_height * 0.171,3)
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth / 2 - 2), Scale_offset + Scale_height * 0.278, (setup.ScrWidth / 2 + 15), Scale_offset + Scale_height * 0.278,3)
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth / 2 - 2), Scale_offset + Scale_height * 0.411, (setup.ScrWidth / 2 + 15), Scale_offset + Scale_height * 0.411,3)
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth / 2 - 2), Scale_offset + Scale_height * 0.469, (setup.ScrWidth / 2 + 15), Scale_offset + Scale_height * 0.469,3)
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth / 2 - 20), Scale_offset + Scale_height * 0.500, (setup.ScrWidth / 2 + 20), Scale_offset + Scale_height * 0.500,3)
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth / 2 - 2), Scale_offset + Scale_height * 0.530, (setup.ScrWidth / 2 + 15), Scale_offset + Scale_height * 0.530,3)
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth / 2 - 2), Scale_offset + Scale_height * 0.588, (setup.ScrWidth / 2 + 15), Scale_offset + Scale_height * 0.588,3)
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth / 2 - 2), Scale_offset + Scale_height * 0.708, (setup.ScrWidth / 2 + 15), Scale_offset + Scale_height * 0.708,3)
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth / 2 - 2), Scale_offset + Scale_height * 0.814, (setup.ScrWidth / 2 + 15), Scale_offset + Scale_height * 0.814,3)
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth / 2 - 2), Scale_offset + Scale_height * 1.000, (setup.ScrWidth / 2 + 15), Scale_offset + Scale_height * 1.000,3)

    % vertical scale element
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth / 2), Scale_offset, (setup.ScrWidth / 2), Scale_offset + Scale_height,3)

    %--- Start display for trial---

    %rating window
    Screen('CopyWindow',rating_scr,w);
    Screen('Flip',w);

    %----Mouse response----

    %Move cursor to anchor_6 (center position of sclae)
    X = round(setup.ScrWidth/2);
    Y = round(Scale_offset + Scale_height * 0.50); %Fix y coordinate
    Slider_y_pos = Y;
    %SetMouse(X,Y);
    %scale_joy_x = setup.ScrWidth*1.1/JoystickSpecification.Max;
    %scale_joy_y = wh*1.1/JoystickSpecification.Max;
    scale_joy_x = setup.ScrWidth*0.7/JoystickSpecification.Max;
    scale_joy_y = setup.ScrHeight*0.7/JoystickSpecification.Max;

    %Put slider on the screen
    Screen('CopyWindow',rating_scr,w)

    Screen('DrawLine',w,[250 0 0],(setup.ScrWidth / 2 - 10), Slider_y_pos, (setup.ScrWidth / 2 + 10), Slider_y_pos,5)

    Screen('Flip',w);
        
    %Loop and track mouse such that rating slider moves according to mouse position (edited from MouseTraceDemo)
    sampleTime = 0.01;
    startTime = GetSecs;
    nextTime = startTime+sampleTime;
    flag_resp = 0;

    %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    offset_y = Y - round(Joystick.Y * scale_joy_y);
    proj_y = round(Joystick.Y * scale_joy_y) + offset_y;

    while (GetSecs - t_scale_trigger) < max_dur_rating && flag_resp == 0 %mousebuttons(1)~=1 

        if (GetSecs > nextTime) %Sample every 0.01 seconds
            %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            proj_y = round(Joystick.Y * scale_joy_y) + offset_y;

            if Joystick.Button(1) == 1
                flag_resp = 1;
                t_button = GetSecs;
                Joystick.Button(1) = 0;
            end

            if flag_resp==1 %Terminate and record rating on left mouseclick
                t_rating_ref = t_button - startTime;
                rating = 100-((Slider_y_pos - Scale_offset)/Scale_height)*200; %rescaling of scale_height independent of screen resolution [0-100]
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

                Screen('DrawLine',w,[250 0 0],(setup.ScrWidth / 2 - 10), Slider_y_pos, (setup.ScrWidth / 2 + 10), Slider_y_pos,5)

                Screen('Flip',w);
            end

            nextTime = nextTime+sampleTime;
        end
    end

    if flag_resp==0
        
            rating = 100-((Slider_y_pos - Scale_offset)/Scale_height)*200;
            rating_subm = 0;
            t_rating_ref = GetSecs - startTime;
            
    end
    
    wait_rest = max_dur_rating - t_rating_ref;
    WaitSecs(feedback_delay); %Show screen for feedback_delay past click

elseif strcmp(trial.question, 'willingnesspay') % horizontal scale with image for willingness to pay

    %rescale wh to scale_height
    Scale_width = round(setup.ScrWidth * .50);
    %Scale_width = round(ww * .75);
    Scale_offset = round((setup.ScrHeight - (setup.ScrHeight * .60)) * .75);
    %Scale_offset = round((wh - (wh * .95)) * .75);
    DrawFormattedText(rating_scr, text_question, 'center', (Scale_offset+setup.ScrHeight/2 - 600), color.scale_anchors,80,[],[],2);
    
    DrawFormattedText(rating_scr, [scale.anchor_1], (setup.ScrWidth/2-Scale_width/2 - 65), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
    DrawFormattedText(rating_scr, [scale.anchor_7], (setup.ScrWidth/2+Scale_width/2 - 35), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
    
    % horizontal scale element
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth/2-Scale_width/2), (Scale_offset+setup.ScrHeight/2), (setup.ScrWidth/2+Scale_width/2), (Scale_offset+setup.ScrHeight/2),3)

    % vertical scale elements
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth/2-Scale_width/2), (Scale_offset+setup.ScrHeight/2 - 20), (setup.ScrWidth/2-Scale_width/2), (Scale_offset+setup.ScrHeight/2 + 20),3)
    %Screen('DrawLine',rating_scr,[250 250 250],(ww/2), (Scale_offset+wh/2 - 15), (ww/2), (Scale_offset+wh/2 + 15),3)
    Screen('DrawLine',rating_scr,color.scale_anchors,(setup.ScrWidth/2+Scale_width/2), (Scale_offset+setup.ScrHeight/2 - 20), (setup.ScrWidth/2+Scale_width/2), (Scale_offset+setup.ScrHeight/2 + 20),3)

    % Place image
%     Screen('PutImage', rating_scr, Pic, [(setup.ScrWidth/2-Scale_width/2) (Scale_offset+setup.ScrHeight/2 - 500) (setup.ScrWidth/2+Scale_width/2) (setup.ScrHeight-setup.ScrHeight/3)]);
    Screen('DrawTexture',rating_scr, texture.wtpt{pic_index},[],[(setup.ScrWidth/2-Scale_width/2) (Scale_offset+setup.ScrHeight/2 - 500) (setup.ScrWidth/2+Scale_width/2) (setup.ScrHeight-setup.ScrHeight/3)]);
    %--- Start display for trial---

    %rating window
    Screen('CopyWindow',rating_scr,w);
    Screen('Flip',w);


    %----Response----

    %Move cursor to starting position at 0 Euros
    X = round(setup.ScrWidth/2);
    Y = round(Scale_offset + setup.ScrHeight/2); %Fix y coordinate
    Slider_x_pos = X;
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

    %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    offset_x = X - round(Joystick.X * scale_joy_x);
    proj_x = round(Joystick.X * scale_joy_x) + offset_x;
    controller_positions = NaN(200,1); %store controller positions of first 2 seconds
    pos_index = 1;

    while (GetSecs - t_scale_trigger) < max_dur_rating && flag_resp == 0 %mousebuttons(1)~=1 

        if (GetSecs > nextTime) %Sample every 0.01 seconds
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            proj_x = round(Joystick.X * scale_joy_x) + offset_x;
            if pos_index <= 200
                controller_positions(pos_index,1) = proj_x;
                pos_index = pos_index+1;
            end

            if Joystick.Button(1) == 1
                flag_resp = 1;
                t_button = GetSecs;
                Joystick.Button(1) = 0;
            end

                if flag_resp==1 %Terminate and record rating on left mouseclick

                    t_rating_ref = t_button - startTime;

                    rating = round(((Slider_x_pos - (setup.ScrWidth/2-Scale_width/2))/ Scale_width)*200); %rescaling of scale_width independent of screen resolution [0-200]
                    rating_subm = 1;
                    break


                elseif (proj_x ~= Slider_x_pos) %Update screen if participant has scrolled up or down
                    Screen('CopyWindow',rating_scr,w);
                    Slider_x_pos = (proj_x);

                    %restrict range of slider to defined scale
                    if Slider_x_pos < (setup.ScrWidth/2 - Scale_width/2)
                        Slider_x_pos = (setup.ScrWidth/2 - Scale_width/2);
                    elseif Slider_x_pos > (setup.ScrWidth/2 + Scale_width/2)
                        Slider_x_pos = (setup.ScrWidth/2 + Scale_width/2);
                    end
                    
                    % Display currently chosen value
                    value = round(((Slider_x_pos - (setup.ScrWidth/2-Scale_width/2))/ Scale_width)*200);
                    if settings.lang_de == 1
                        if value == 0
                            value_text = 'Ihr Gebot: 0 Euro';
                        elseif value < 100
                            value_text = ['Ihr Gebot: 0,' num2str(value,'%02d') ' Euro'];
                        elseif value == 100
                            value_text = 'Ihr Gebot: 1 Euro';
                        elseif value < 200
                            value_text = ['Ihr Gebot: 1,' num2str((value-100),'%02d') ' Euro'];
                        elseif value == 200
                            value_text = 'Ihr Gebot: 2 Euro';
                        end
                    else
                        if value == 0
                            value_text = 'Your offer: 0 Euros'; %english translation
                        elseif value < 100
                            value_text = ['Your offer: 0,' num2str(value,'%02d') ' Euros']; %english translation
                        elseif value == 100
                            value_text = 'Your offer: 1 Euro';%english translation
                        elseif value < 200
                            value_text = ['Your offer: 1,' num2str((value-100),'%02d') ' Euros'];%english translation
                        elseif value == 200
                            value_text = 'Your offer: 2 Euros';%english translation
                        end
                    end
                    Screen('TextSize',w,32);
                    DrawFormattedText(w, value_text, 'center', (Scale_offset+setup.ScrHeight/2 + 40), [200 0 0],40,[],[],2);

                    Screen('DrawLine',w,[250 0 0],Slider_x_pos, Y - 10, Slider_x_pos, Y + 10,5)

                    Screen('Flip',w);
                end
            %end
            nextTime = nextTime+sampleTime;
        end
    end

     if flag_resp==0 %Terminate without click

            rating = round(((Slider_x_pos - (setup.ScrWidth/2-Scale_width/2))/ Scale_width)*200); %rescaling of scale_width independent of screen resolution [0-200]
            rating_subm = 0;

            t_rating_ref = GetSecs - startTime;
     end
     
     wait_rest = max_dur_rating - t_rating_ref;
     WaitSecs(feedback_delay); %Show screen for 1s post-mouseclick
    
else % default horizontal scale

    %rescale wh to scale_height
    Scale_width = round(setup.ScrWidth * .80);
    %Scale_width = round(ww * .75);
    Scale_offset = round((setup.ScrHeight - (setup.ScrHeight * .95)) * .75);
    %Scale_offset = round((wh - (wh * .95)) * .75);
    DrawFormattedText(rating_scr, text_question, 'center', (Scale_offset+setup.ScrHeight/2 - 350), color.scale_anchors,70,[],[],2);

    %Different scale labels for pain VAS
    if strcmp(trial.question,'pain')

        Screen('TextSize',w,10);

            if ScreenType == 1
                DrawFormattedText(rating_scr, [scale.anchor_0], (setup.ScrWidth/2-Scale_width/2 - 6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_NoSensation], (setup.ScrWidth/2-Scale_width/2 - 110), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_1], (setup.ScrWidth/2-Scale_width/2 + 96 - 6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_LightSensation], (setup.ScrWidth/2-Scale_width/2 + 52), (Scale_offset+setup.ScrHeight/2 + 150), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_2], (setup.ScrWidth/2-Scale_width/2 + 192 - 6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_LightTingling], (setup.ScrWidth/2-Scale_width/2 + 136), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_3], (setup.ScrWidth/2-Scale_width/2 + 288 - 6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_ModerateTingling], (setup.ScrWidth/2-Scale_width/2 + 234), (Scale_offset+setup.ScrHeight/2 + 150), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_4], (setup.ScrWidth/2-Scale_width/2 + 384 - 6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_StrongTingling], (setup.ScrWidth/2 - Scale_width/2 + 322), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_5], (setup.ScrWidth/2 -6), (Scale_offset+setup.ScrHeight/2 + 40), [205 201 201],80);
                DrawFormattedText(rating_scr, [scale.anchor_LightPricking], (setup.ScrWidth/2 - 40), (Scale_offset+setup.ScrHeight/2 + 150), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_6], (setup.ScrWidth/2+Scale_width/2 - 384 -6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_ModeratePricking], (setup.ScrWidth/2 + Scale_width/2 - 412), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_7], (setup.ScrWidth/2+Scale_width/2 - 288 -6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_Pricking], (setup.ScrWidth/2 + Scale_width/2 - 314), (Scale_offset+setup.ScrHeight/2 + 150), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_8], (setup.ScrWidth/2+Scale_width/2 - 192 -6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_Pain], (setup.ScrWidth/2 + Scale_width/2 - 216), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_9], (setup.ScrWidth/2+Scale_width/2 - 96 -6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_UnbearablePain], (setup.ScrWidth/2 + Scale_width/2 - 128), (Scale_offset+setup.ScrHeight/2 + 150), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_10], (setup.ScrWidth/2+Scale_width/2 -10), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80); 
                DrawFormattedText(rating_scr, [scale.anchor_StrongestSensation], (setup.ScrWidth/2+Scale_width/2 - 55), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40); 

            elseif ScreenType == 2
                
                DrawFormattedText(rating_scr, [scale.anchor_0], (setup.ScrWidth/2-Scale_width/2 - 6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_NoSensation], (setup.ScrWidth/2-Scale_width/2 - 110), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_1], (setup.ScrWidth/2-Scale_width/2 + 96 - 6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_LightSensation], (setup.ScrWidth/2-Scale_width/2 + 52), (Scale_offset+setup.ScrHeight/2 + 180), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_2], (setup.ScrWidth/2-Scale_width/2 + 192 - 6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_LightTingling], (setup.ScrWidth/2-Scale_width/2 + 136), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_3], (setup.ScrWidth/2-Scale_width/2 + 288 - 6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_ModerateTingling], (setup.ScrWidth/2-Scale_width/2 + 234), (Scale_offset+setup.ScrHeight/2 + 180), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_4], (setup.ScrWidth/2-Scale_width/2 + 384 - 6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_StrongTingling], (setup.ScrWidth/2 - Scale_width/2 + 322), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_5], (setup.ScrWidth/2 -6), (Scale_offset+setup.ScrHeight/2 + 40), [205 201 201],80);
                DrawFormattedText(rating_scr, [scale.anchor_LightPricking], (setup.ScrWidth/2 - 40), (Scale_offset+setup.ScrHeight/2 + 180), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_6], (setup.ScrWidth/2+Scale_width/2 - 384 -6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_ModeratePricking], (setup.ScrWidth/2 + Scale_width/2 - 412), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_7], (setup.ScrWidth/2+Scale_width/2 - 288 -6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_Pricking], (setup.ScrWidth/2 + Scale_width/2 - 354), (Scale_offset+setup.ScrHeight/2 + 180), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_8], (setup.ScrWidth/2+Scale_width/2 - 192 -6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_Pain], (setup.ScrWidth/2 + Scale_width/2 - 216), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_9], (setup.ScrWidth/2+Scale_width/2 - 96 -6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_UnbearablePain], (setup.ScrWidth/2 + Scale_width/2 - 128), (Scale_offset+setup.ScrHeight/2 + 180), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_10], (setup.ScrWidth/2+Scale_width/2 -10), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80); 
                DrawFormattedText(rating_scr, [scale.anchor_StrongestSensation], (setup.ScrWidth/2+Scale_width/2 - 55), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40); 
                
            else 

                DrawFormattedText(rating_scr, [scale.anchor_0], (setup.ScrWidth/2-Scale_width/2 - 6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_NoSensation], (setup.ScrWidth/2-Scale_width/2 - 110), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_1], (setup.ScrWidth/2-Scale_width/2 + 84 - 6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_LightSensation], (setup.ScrWidth/2-Scale_width/2 + 44), (Scale_offset+setup.ScrHeight/2 + 150), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_2], (setup.ScrWidth/2-Scale_width/2 + 168 - 6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_LightTingling], (setup.ScrWidth/2-Scale_width/2 + 120), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_3], (setup.ScrWidth/2-Scale_width/2 + 252 - 6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_ModerateTingling], (setup.ScrWidth/2-Scale_width/2 + 210), (Scale_offset+setup.ScrHeight/2 + 150), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_4], (setup.ScrWidth/2-Scale_width/2 + 336 - 6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_StrongTingling], (setup.ScrWidth/2 - Scale_width/2 + 290), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_5], (setup.ScrWidth/2 -6), (Scale_offset+setup.ScrHeight/2 + 40), [205 201 201],80);
                DrawFormattedText(rating_scr, [scale.anchor_LightPricking], (setup.ScrWidth/2 - 40), (Scale_offset+setup.ScrHeight/2 + 150), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_6], (setup.ScrWidth/2+Scale_width/2 - 336 -6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_ModeratePricking], (setup.ScrWidth/2 + Scale_width/2 - 380), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_7], (setup.ScrWidth/2+Scale_width/2 - 252 -6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_Pricking], (setup.ScrWidth/2 + Scale_width/2 - 290), (Scale_offset+setup.ScrHeight/2 + 150), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_8], (setup.ScrWidth/2+Scale_width/2 - 168 -6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_Pain], (setup.ScrWidth/2 + Scale_width/2 - 200), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_9], (setup.ScrWidth/2+Scale_width/2 - 84 -6), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80);
                DrawFormattedText(rating_scr, [scale.anchor_UnbearablePain], (setup.ScrWidth/2 + Scale_width/2 - 120), (Scale_offset+setup.ScrHeight/2 + 150), color.scale_anchors,40);

                DrawFormattedText(rating_scr, [scale.anchor_10], (setup.ScrWidth/2+Scale_width/2 -10), (Scale_offset+setup.ScrHeight/2 + 40), color.scale_anchors,80); 
                DrawFormattedText(rating_scr, [scale.anchor_StrongestSensation], (setup.ScrWidth/2+Scale_width/2 - 55), (Scale_offset+setup.ScrHeight/2 + 75), color.scale_anchors,40); 


            end

    elseif strcmp(trial.type,'load')
        
        DrawFormattedText(rating_scr, [scale.anchor_1], (setup.ScrWidth/2-Scale_width/2 - 65), (Scale_offset+setup.ScrHeight/2 + 70), color.scale_anchors,20);
        DrawFormattedText(rating_scr, [scale.anchor_7], (setup.ScrWidth/2+Scale_width/2 - 100), (Scale_offset+setup.ScrHeight/2 + 70), color.scale_anchors,20);

    else

        DrawFormattedText(rating_scr, [scale.anchor_1], (setup.ScrWidth/2-Scale_width/2 - 65), (Scale_offset+setup.ScrHeight/2 + 70), color.scale_anchors,80);
        %DrawFormattedText(rating_scr, [scale.anchor_4], 'center', (Scale_offset+wh/2 + 30), [205 201 201],80);
        DrawFormattedText(rating_scr, [scale.anchor_7], (setup.ScrWidth/2+Scale_width/2 - 35), (Scale_offset+setup.ScrHeight/2 + 70), color.scale_anchors,80);

    end


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
    scale_joy_x = setup.ScrWidth*0.8/JoystickSpecification.Max;
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

    %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    offset_x = X - round(Joystick.X * scale_joy_x);
    proj_x = round(Joystick.X * scale_joy_x) + offset_x;

    while (GetSecs - t_scale_trigger) < max_dur_rating && flag_resp == 0 %mousebuttons(1)~=1 

        if (GetSecs > nextTime) %Sample every 0.01 seconds
            %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            proj_x = round(Joystick.X * scale_joy_x) + offset_x;

            if Joystick.Button(1) == 1
                flag_resp = 1;
                t_button = GetSecs;
                Joystick.Button(1) = 0;
            end

                if flag_resp==1 %Terminate and record rating on left mouseclick

                    t_rating_ref = t_button - startTime;

                    rating = ((Slider_x_pos - (setup.ScrWidth/2-Scale_width/2))/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
                    rating_subm = 1;
                    break


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
            %end
            nextTime = nextTime+sampleTime;
        end
    end

     if flag_resp==0 %Terminate without click

            rating = ((Slider_x_pos - (setup.ScrWidth/2-Scale_width/2))/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
            rating_subm = 0;

            t_rating_ref = GetSecs - startTime;
     end
     
     wait_rest = max_dur_rating - t_rating_ref;
     WaitSecs(feedback_delay); %Show screen for 1s post-mouseclick

end

Screen('Close',rating_scr)