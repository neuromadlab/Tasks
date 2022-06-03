%% =================== VAS horizontal ===================
% customized visual analogue scales (0-100)
%
%
% Coded by: Nils Kroemer modified from mood_VAS (coded by Ying Lee) and BDM task (coded by Jean Liu)
%
% Update coded with: Matlab R2014a using Psychtoolbox 3.0.11
%
% ========================================================


%% preparation
% set anchor texts for scale 
    anchor_1 = '0 Euros';
    anchor_4 = '1 Euro';
    anchor_7 = '2 Euros';

%% rating window

% prepare off-screen window = rating texture (4s)
rating_scr = Screen('OpenOffscreenwindow',w,color_scale_background);
text_freerating = Snacks{i_snack,4}; %store snack type for output

% rescale wh to scale_height
Scale_width = round(ww * .50);
Scale_offset = round((wh - (wh * .95)) * .75);

% create textures with specified positions

% picture and task
Screen('TextSize',rating_scr,large_text_size);
Screen('TextFont',rating_scr,'Arial');
DrawFormattedText(rating_scr, text.task, position_task_x, position_task_y, color_scale_anchors,60,[],[],2);
Screen('FrameRect', rating_scr, highlighter_colour, rating_scr_rect,3);
% imTexture = Screen('MakeTexture', w,trial.image);
Screen('DrawTexture',rating_scr,texture_i,[], [(rating_scr_rect_x2 - desired_img_width) rating_scr_rect_y1 rating_scr_rect_x2 rating_scr_rect_y2]);
% question and scale 
Screen('TextSize',rating_scr,normal_text_size);
Screen('TextFont',rating_scr,'Arial');
if lang_de == 1
    bidding_question = 'Welchen Betrag zwischen 0 Euro und 2 Euro bieten Sie fuer den folgenden Artikel:';
else
    bidding_question = 'How much between 0 and 2 Euros would you offer for the following item:'; 
end
DrawFormattedText(rating_scr, bidding_question, 'center', (Scale_offset+wh/2 - 100), color_scale_anchors,40,[],[],2);

Screen('TextSize',rating_scr,small_text_size);
Screen('TextFont',rating_scr,'Arial');
DrawFormattedText(rating_scr, [anchor_1], (ww/2-Scale_width/2 - 60), (Scale_offset+wh/2 + 40), color_scale_anchors,80);
% DrawFormattedText(rating_scr, [anchor_4], 'center', (Scale_offset+wh/2 + 40), color_scale_anchors,80);
DrawFormattedText(rating_scr, [anchor_7], (ww/2+Scale_width/2 - 15), (Scale_offset+wh/2 + 40), color_scale_anchors,80);
% DrawFormattedText(rating_scr, [anchor_7 text_freerating], (ww/2+Scale_width/2 - 75), (Scale_offset+wh/2 + 30), color_scale_anchors,80);

% horizontal scale element
Screen('DrawLine',rating_scr,color_scale_anchors,(ww/2-Scale_width/2), (Scale_offset+wh/2), (ww/2+Scale_width/2), (Scale_offset+wh/2),3)

% vertical scale elements
Screen('DrawLine',rating_scr,color_scale_anchors,(ww/2-Scale_width/2), (Scale_offset+wh/2 - 20), (ww/2-Scale_width/2), (Scale_offset+wh/2 + 20),3)

% Screen('DrawLine',rating_scr,[250 250 250],(ww/2), (Scale_offset+wh/2 - 15), (ww/2), (Scale_offset+wh/2 + 15),3)
Screen('DrawLine',rating_scr,color_scale_anchors,(ww/2+Scale_width/2), (Scale_offset+wh/2 - 20), (ww/2+Scale_width/2), (Scale_offset+wh/2 + 20),3)

% display rating window
Screen('CopyWindow',rating_scr,w);
Screen('Flip',w);

% start timer for trial
subj.time.trial.runstart(output_index,1) = GetSecs;

%% cursor handling
% Move cursor to mean position
X = round(ww/2);
Y = round(Scale_offset + wh/2); % Fix y coordinate
Slider_x_pos = X;
if control_joystick == 1
    scale_joy_x = ww*0.7/JoystickSpecification.Max;
    scale_joy_y = wh*0.7/JoystickSpecification.Max;
else
    SetMouse(X,Y); 
end

% Put slider on the screen
Screen('CopyWindow',rating_scr,w)
Screen('DrawLine',w,[250 0 0],Slider_x_pos, (Scale_offset + wh / 2 - 10), Slider_x_pos, (Scale_offset + wh / 2 + 10),5)
Screen('Flip',w);

% Loop and track mouse such that rating slider moves according to mouse position (edited from MouseTraceDemo)
sampleTime = 0.01;
startTime = GetSecs;
nextTime = startTime+sampleTime;
flag_resp = 0;

if control_joystick == 1
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    offset_x = X - round(Joystick.X * scale_joy_x);
    proj_x = round(Joystick.X * scale_joy_x) + offset_x;
    controller_positions = NaN(200,1); %store controller positions of first 2 seconds
    pos_index = 1;

    while flag_resp == 0 %mousebuttons(1)~=1 
    
        tic
        while toc <= max_waiting_rating
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

                if flag_resp == 1 %Terminate and record rating on left mouseclick

                    t_rating_ref = t_button - startTime;

                    rating = round(((Slider_x_pos - (ww/2-Scale_width/2))/ Scale_width)*200); %rescaling of scale_width independent of screen resolution [0-200]
                    rating_subm = 1;
                    break


                elseif (proj_x ~= Slider_x_pos) %Update screen if participant has scrolled up or down
                    Screen('CopyWindow',rating_scr,w);
                    Slider_x_pos = (proj_x);

                    %restrict range of slider to defined scale
                    if Slider_x_pos < (ww/2 - Scale_width/2)
                        Slider_x_pos = (ww/2 - Scale_width/2);
                    elseif Slider_x_pos > (ww/2 + Scale_width/2)
                        Slider_x_pos = (ww/2 + Scale_width/2);
                    end

                    % Display currently chosen value
                    value = round(((Slider_x_pos - (ww/2-Scale_width/2))/ Scale_width)*200);
                    if lang_de == 1
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
                    DrawFormattedText(w, value_text, 'center', (Scale_offset+wh/2 + 100), [200 0 0],40,[],[],2);

                    Screen('DrawLine',w,[250 0 0],Slider_x_pos, Y - 10, Slider_x_pos, Y + 10,5)

                    Screen('Flip',w);
                end
                %end
                nextTime = nextTime+sampleTime;
            end
                if flag_resp == 0
                    % summon to go to ratings
                    Screen('CopyWindow', rating_scr, w);
                    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, rating_summoning, 'center', wh-50, [250 0 0],40);
                    Screen('Flip',w);
                    WaitSecs(1);
            end
        end
    end
else
        [mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
        while flag_resp == 0

            tic
            while toc <= max_waiting_rating
                if (GetSecs > nextTime) %Sample every 0.01 seconds
                    [mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position

                    if mousebuttons(1)==1 %Terminate and record rating on left mouseclick

                        % in case the mouse position is above/below scale, rating could
                        % get >100 or <0! for this case, additional computations needed
                        % >100 relates for this scale to value = 0
                        % <0 relates for this scale to value = 100
                        rating_mousePos = ((Slider_x_pos - (ww/2-Scale_width/2))/ Scale_width)*100;
                        if rating_mousePos > 100
                            rating = 100;
                        elseif rating_mousePos < 0
                            rating = 0;
                        else
                            rating = rating_mousePos;
                        end

                        % save in output cell
                        output.bidding.value(output_index,1) = rating*0.02; %rescaling of scale_width independent of screen resolution [0-100]
                        output.bidding.label{output_index,1} = text_freerating;
                        output.bidding.subm(output_index,1) = 1;
                        t_rating = GetSecs;
                        subj.bidding.onsets.scales.button(output_index,1) = t_rating - subj.trigger.fin;
                        flag_resp = 1;

                    elseif (mouseX ~= Slider_x_pos) %Update screen if participant has scrolled up or down
                        Screen('CopyWindow',rating_scr,w);
                        Slider_x_pos = (mouseX);
                        rating_mousePos = ((Slider_x_pos - (ww/2-Scale_width/2))/ Scale_width)*100;

                        if rating_mousePos > 100
                            rating = 100;
                        elseif rating_mousePos < 0
                            rating = 0;
                        else
                            rating = rating_mousePos;
                        end

                        %restrict range of slider to defined scale
                        if Slider_x_pos < (ww/2 - Scale_width/2)
                            Slider_x_pos = (ww/2 - Scale_width/2);
                        elseif Slider_x_pos > (ww/2 + Scale_width/2)
                            Slider_x_pos = (ww/2 + Scale_width/2);
                        end

                        Screen('DrawLine',w,[250 0 0],Slider_x_pos, (Scale_offset + wh / 2 - 10), Slider_x_pos, (Scale_offset + wh / 2 + 10),5)

                        Screen('Flip',w);
                    end

                    % to test online the mapping from mouse pos to rating value, use this:
                    % disp(rating);
                    nextTime = nextTime+sampleTime;
                end

                if flag_resp == 1
                    break;
                end
            end

            if flag_resp == 0
                % summon to go to ratings
                Screen('CopyWindow', rating_scr, w);
                [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, rating_summoning, 'center', wh-50, [250 0 0],40);
                Screen('Flip',w);
                WaitSecs(1);
            end
    end
end

% Show screen for 1.5s post-mouseclick
WaitSecs(feedback_delay);