%%===================LHS vertical===================
%Labeled Hedonic Scale (Lim, Wood, & Green)
%

%Coded by: Nils Kroemer modified from mood_VAS (coded by Ying Lee) and BDM task (coded by Jean Liu)

%Update coded with: Matlab R2014a using Psychtoolbox 3.0.11

%========================================================

%% Preparation

% set anchor texts for scale depending on language
if lang_de
    anchor_1 = 'am allerstärksten gemochte Empfindung, die vorstellbar ist';
    anchor_2 = 'extrem gern';
    anchor_3 = 'sehr gern';
    anchor_4 = 'gern';
    anchor_5 = 'ein bisschen gern';
    anchor_6 = 'neutral';
    anchor_7 = 'ein bisschen ungern';
    anchor_8 = 'ungern';
    anchor_9 = 'sehr ungern';
    anchor_10 = 'extrem ungern';
    anchor_11 = 'am allerstärksten zuwidere Empfindung, die vorstellbar ist';
else
    anchor_1 = 'most liked sensation imaginable';
    anchor_2 = 'like extremely';
    anchor_3 = 'like very much';
    anchor_4 = 'like moderately';
    anchor_5 = 'like slightly';
    anchor_6 = 'neutral';
    anchor_7 = 'dislike slightly';
    anchor_8 = 'dislike moderately';
    anchor_9 = 'dislike very much';
    anchor_10 = 'dislike extremely';
    anchor_11 = 'most disliked sensation imaginable';
      
end

%% rating window

% prepare off-screen window = rating texture (4s)
rating_scr = Screen('OpenOffscreenwindow',w,color_scale_background);
text_freerating = Snacks{i_snack,4}; %store snack type for output

% rescale wh to scale_height
Scale_height = round(wh * .50);
Scale_offset = round(wh * .25); %round((wh - Scale_height) * .95);

% snack and task
Screen('TextSize',rating_scr,large_text_size);
Screen('TextFont',rating_scr,'Arial');
DrawFormattedText(rating_scr, text.task, position_task_x, position_task_y, color_scale_anchors,60,[],[],2);
Screen('FrameRect', rating_scr, highlighter_colour, rating_scr_rect,3);
imTexture = Screen('MakeTexture', w,trial.image);
Screen('DrawTexture',rating_scr,imTexture,[], [(rating_scr_rect_x2 - desired_img_width) rating_scr_rect_y1 rating_scr_rect_x2 rating_scr_rect_y2]);


% y-values of scale intersections
% y_1 is top of scale, y_11 is bottom of scale, y_6 is the middle
y_1 = 0.000;
y_2 = 0.171;
y_3 = 0.278;
y_4 = 0.411;
y_5 = 0.469;
y_6 = 0.500;
y_7 = 0.530;
y_8 = 0.588;
y_9 = 0.708;
y_10 = 0.814;
y_11 = 1.000;

% question and scale
Screen('TextSize',rating_scr,normal_text_size);
Screen('TextFont',rating_scr,'Arial');
DrawFormattedText(rating_scr, text.question, (ww/10), 'center', color_scale_anchors,30,[],[],2);

Screen('TextSize',rating_scr,small_text_size);
Screen('TextFont',rating_scr,'Arial');
DrawFormattedText(rating_scr, anchor_1, (ww/2+20), (Scale_offset + 5) + Scale_height * y_1, color_scale_anchors,80);
%DrawFormattedText(rating_scr, [text_freerating ' sensation'], (ww/2+20), (Scale_offset - 10) + 20, [250 0 0],80);
DrawFormattedText(rating_scr, anchor_2, (ww/2+20), (Scale_offset + 5) + Scale_height * y_2, color_scale_anchors,80);
DrawFormattedText(rating_scr, anchor_3, (ww/2+20), (Scale_offset + 5) + Scale_height * y_3, color_scale_anchors,80);
DrawFormattedText(rating_scr, anchor_4, (ww/2+20), (Scale_offset + 5) + Scale_height * y_4, color_scale_anchors,80);
DrawFormattedText(rating_scr, anchor_5, (ww/2+20), (Scale_offset + 5) + Scale_height * y_5, color_scale_anchors,80);
DrawFormattedText(rating_scr, anchor_6, (ww/2-100), (Scale_offset + 5) + Scale_height * y_6, color_scale_anchors,80);
DrawFormattedText(rating_scr, anchor_7, (ww/2+20), (Scale_offset + 5) + Scale_height * y_7, color_scale_anchors,80);
DrawFormattedText(rating_scr, anchor_8, (ww/2+20), (Scale_offset + 5) + Scale_height * y_8, color_scale_anchors,80);
DrawFormattedText(rating_scr, anchor_9, (ww/2+20), (Scale_offset + 5) + Scale_height * y_9, color_scale_anchors,80);
DrawFormattedText(rating_scr, anchor_10, (ww/2+20), (Scale_offset + 5) + Scale_height * y_10, color_scale_anchors,80);
DrawFormattedText(rating_scr, anchor_11, (ww/2+20), (Scale_offset + 5) + Scale_height * y_11, color_scale_anchors,80);


% horizontal scale elements
Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * y_1, (ww / 2 + 15), Scale_offset + Scale_height * y_1,3)
Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * y_2, (ww / 2 + 15), Scale_offset + Scale_height * y_2,3)
Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * y_3, (ww / 2 + 15), Scale_offset + Scale_height * y_3,3)
Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * y_4, (ww / 2 + 15), Scale_offset + Scale_height * y_4,3)
Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * y_5, (ww / 2 + 15), Scale_offset + Scale_height * y_5,3)
Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 20), Scale_offset + Scale_height * y_6, (ww / 2 + 20), Scale_offset + Scale_height * y_6,3)
Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * y_7, (ww / 2 + 15), Scale_offset + Scale_height * y_7,3)
Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * y_8, (ww / 2 + 15), Scale_offset + Scale_height * y_8,3)
Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * y_9, (ww / 2 + 15), Scale_offset + Scale_height * y_9,3)
Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * y_10, (ww / 2 + 15), Scale_offset + Scale_height * y_10,3)
Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2 - 2), Scale_offset + Scale_height * y_11, (ww / 2 + 15), Scale_offset + Scale_height * y_11,3)

% vertical scale element
Screen('DrawLine',rating_scr,color_scale_anchors,(ww / 2), Scale_offset, (ww / 2), Scale_offset + Scale_height,3)

% display rating window
Screen('CopyWindow',rating_scr,w);
Screen('Flip',w);

% start timer for trial
subj.time.trial.runstart(output_index,1) = GetSecs;

%% cursor handling

% Move cursor to anchor_6 (center position of sclae)
X = round(ww/2);
Y = round(Scale_offset + Scale_height * 0.50); %Fix y coordinate
Slider_y_pos = Y;
SetMouse(X,Y);

% Put slider on the screen
Screen('CopyWindow',rating_scr,w)
Screen('DrawLine',w,[250 0 0],(ww / 2 - 10), Slider_y_pos, (ww / 2 + 10), Slider_y_pos,5)
Screen('Flip',w);

% Loop and track mouse such that rating slider moves according to mouse position (edited from MouseTraceDemo)
sampleTime = 0.01;
startTime = GetSecs;
nextTime = startTime+sampleTime;
flag_resp = 0;

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
                rating_mousePos = 100-((Slider_y_pos - Scale_offset)/Scale_height)*200;
                if rating_mousePos > 100
                    rating = 100;
                elseif rating_mousePos < -100
                    rating = -100;
                else
                    rating = rating_mousePos;
                end
                
                % save in output cell
                output.rating.value(output_index,1) = rating; %rescaling of scale_height independent of screen resolution [0-100]
                output.rating.label{output_index,1} = text_freerating;
                output.rating.subm(output_index,1) = 1;
                t_rating = GetSecs;
                subj.onsets.scales.button(output_index,1) = t_rating - subj.trigger.fin;
                flag_resp = 1;
                
            elseif (mouseY ~= Slider_y_pos) %Update screen if participant has scrolled up or down
                Screen('CopyWindow',rating_scr,w);
                Slider_y_pos = (mouseY);
                rating_mousePos = 100-((Slider_y_pos - Scale_offset)/Scale_height)*200;
                if rating_mousePos > 100
                    rating = 100;
                elseif rating_mousePos < -100
                    rating = -100;
                else
                    rating = rating_mousePos;
                end
                
                % restrict range of slider to defined scale
                if Slider_y_pos < Scale_offset
                    Slider_y_pos = Scale_offset;
                elseif Slider_y_pos > (Scale_offset + Scale_height)
                    Slider_y_pos = (Scale_offset + Scale_height);
                end
                
                Screen('DrawLine',w,[250 0 0],(ww / 2 - 10), Slider_y_pos, (ww / 2 + 10), Slider_y_pos,5)
                
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

% Show screen for 1.5s post-mouseclick
WaitSecs(feedback_delay);
