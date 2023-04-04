%%===================VAS horizontal===================
%customized visual analogue scales (0-100)

%Coded by: Nils Kroemer modified from mood_VAS (coded by Ying Lee) and BDM task (coded by Jean Liu)

%Update coded with: Matlab R2014a using Psychtoolbox 3.0.11
%Update July 2021, Corinna Schulz: 
%removed powermate, incorporated joystick as input option 
%========================================================

%% Start experiment:
% determine in which columns to save FCR data 


%--- Start trial---
 
    trial.question = 'intensity';
    
    %trial.runstart = GetSecs; %Time run starts
    onset_start = 0;
    
    %--- Prepare off-screen windows---
    
    %rating window (4s)
    rating_scr = Screen('OpenOffscreenwindow',w,color_scale_background);
    text_freerating = [trial.question]; %free rating
    
    % Screen('TextSize',rating_scr,14); %Commented out so that the text
    %size of the main script is used
    Screen('TextFont',rating_scr,'Arial');
    if strcmp(setup.lang,'de')
        anchor_1 = ['Sehr geringe Intensitaet'];
        %anchor_4 = ['Neutral'];
        anchor_7 = ['Sehr starke Intensitaet '];
    else
        anchor_1 = ['Very low intensity'];
        %anchor_4 = ['Neutral'];
        anchor_7 = ['Very high intensity'];
    end
    
    if  strcmp(setup.lang,'de')
        text_question = 'Wie haben sie die Stimulation waehrend der letzten Durchgaenge empfunden?';
    else
        text_question = 'How did you experience the stimulation during the last trials';
    end
    
    %rescale wh to scale_height
    Scale_width = round(Scr_Width * .50);
    Scale_offset = round((wh - (wh * .95)) * .75);
    
    DrawFormattedText(rating_scr, text_question, 'center', (Scale_offset+wh/2 - 100), color_scale_anchors,40,[],[],2);
    DrawFormattedText(rating_scr, [anchor_1 ], (Scr_Width/2-Scale_width/2 - 65), (Scale_offset+wh/2 + 40), color_scale_anchors,80);
    %DrawFormattedText(rating_scr, [anchor_4], 'center', (Scale_offset+wh/2 + 30), [205 201 201],80);
    DrawFormattedText(rating_scr, [anchor_7 ], (Scr_Width/2+Scale_width/2 - 75), (Scale_offset+wh/2 + 40), color_scale_anchors,80);
    
    % horizontal scale element
    Screen('DrawLine',rating_scr,color_scale_anchors,(Scr_Width/2-Scale_width/2), (Scale_offset+wh/2), (Scr_Width/2+Scale_width/2), (Scale_offset+wh/2),3)
  
   
    % vertical scale elements
    Screen('DrawLine',rating_scr,color_scale_anchors,(Scr_Width/2-Scale_width/2), (Scale_offset+wh/2 - 20), (Scr_Width/2-Scale_width/2), (Scale_offset+wh/2 + 20),3)
    %Screen('DrawLine',rating_scr,[250 250 250],(ww/2), (Scale_offset+wh/2 - 15), (ww/2), (Scale_offset+wh/2 + 15),3)
    Screen('DrawLine',rating_scr,color_scale_anchors,(Scr_Width/2+Scale_width/2), (Scale_offset+wh/2 - 20), (Scr_Width/2+Scale_width/2), (Scale_offset+wh/2 + 20),3)
    
    %--- Start display for trial---
    
    %rating window
    Screen('CopyWindow',rating_scr,w);
    Screen('Flip',w);

    
    %----Mouse response----
if input_type == 0    
    %Move cursor to mean position
    X = round(Scr_Width/2);
    Y = round(Scale_offset + wh/2); %Fix y coordinate
    Slider_x_pos = X;
    SetMouse(X,Y);
    output.rating.value(i_trial,1) = ((Slider_x_pos - (Scr_Width/2-Scale_width/2))/ Scale_width)*100;
    
    
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
                output.data_mat.rating(output.data_mat.block == i_block) = ((Slider_x_pos - (Scr_Width/2-Scale_width/2))/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
                output.data_mat.rating_subm(output.data_mat.block == i_block) = 1;
                output.rating.type_num(i_trial,1) = 0;
                t_rating = GetSecs;
                %subj.onsets.scales.button(i_trial,1) = t_rating - subj.trigger.fin;
                flag_resp = 1;
                %out_ind = out_ind + 1;
                
            elseif (mouseX ~= Slider_x_pos) %Update screen if participant has scrolled up or down
                Screen('CopyWindow',rating_scr,w);
                Slider_x_pos = (mouseX);
                
                %restrict range of slider to defined scale
                if Slider_x_pos < (Scr_Width/2 - Scale_width/2)
                    Slider_x_pos = (Scr_Width/2 - Scale_width/2);
                elseif Slider_x_pos > (Scr_Width/2 + Scale_width/2)
                    Slider_x_pos = (Scr_Width/2 + Scale_width/2);
                end
                
                output.data_mat.rating(output.data_mat.block == i_block)= ((Slider_x_pos - (Scr_Width/2-Scale_width/2))/ Scale_width)*100;
                output.data_mat.rating_subm(output.data_mat.block == i_block) = 0; %Coco
                Screen('DrawLine',w,[250 0 0],Slider_x_pos, (Scale_offset + wh / 2 - 10), Slider_x_pos, (Scale_offset + wh / 2 + 10),5)
                Screen('Flip',w);
            else 
                output.data_mat.rating_subm(output.data_mat.block == i_block) = 0; %Coco
            end

            nextTime = nextTime+sampleTime;
        end
    end
    
    WaitSecs(timing.feedback_delay); %Show screen for 1.5s post-mouseclick

% ------ Joystick Response --------
elseif input_type == 1
    
    %Move cursor to mean position
    X = round(Scr_Width/2);
    Y = round(Scale_offset + wh/2); %Fix y coordinate
    Slider_x_pos = X;
    %SetMouse(X,Y);
    %scale_joy_x = Scr_Width*1.1/JoystickSpecification.Max;
    %scale_joy_y = wh*1.1/JoystickSpecification.Max;
    scale_joy_x = Scr_Width*0.7/JoystickSpecification.Max;
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
    
   while (GetSecs - starttime) < timing.max_dur_rating && flag_resp == 0 %mousebuttons(1)~=1 
        
        if (GetSecs > nextTime) %Sample every 0.01 seconds
            %[mouseX, mouseY, mousebuttons] = GetMouse(screenNumber); %Find out coordinates of current mouse position
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            proj_x = round(Joystick.X * scale_joy_x) + offset_x;
            
            if Joystick.Button(1) == 1
                flag_resp = 1;
                Time_button = GetSecs;  %record time when button was pressed
            end
            
            if flag_resp==1 %Terminate and record rating and RT
               output.data_mat.rating(output.data_mat.block == i_block) = ((Slider_x_pos - (Scr_Width/2-Scale_width/2))/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
               output.data_mat.rating_subm(output.data_mat.block == i_block)  = 1; %answer was submitted
               output.data_mat.RT(output.data_mat.block == i_block)  = Time_button - starttime; % Reaction Time

            elseif (proj_x ~= Slider_x_pos) %Update screen if participant has scrolled up or down
                    Screen('CopyWindow',rating_scr,w);
                    Slider_x_pos = (proj_x);

                    %restrict range of slider to defined scale
                    if Slider_x_pos < (Scr_Width/2 - Scale_width/2)
                       Slider_x_pos = (Scr_Width/2 - Scale_width/2);
                    elseif Slider_x_pos > (Scr_Width/2 + Scale_width/2)
                       Slider_x_pos = (Scr_Width/2 + Scale_width/2);
                    end
                    
                   Screen('DrawLine',w,[250 0 0],Slider_x_pos, (Scale_offset + wh / 2 - 10), Slider_x_pos, (Scale_offset + wh / 2 + 10),5)

                   Screen('Flip',w);
            end
                    
            nextTime = nextTime+sampleTime;
        end
   end
   % If no submission occured, still save current value
   if flag_resp == 0
       output.data_mat.rating(output.data_mat.block == i_block) = ((Slider_x_pos - (Scr_Width/2-Scale_width/2))/ Scale_width)*100; %changed
       output.data_mat.rating_subm(output.data_mat.block == i_block)  = 0; % no submission 
       output.data_mat.RT(output.data_mat.block == i_block) = NaN; % no RT 
   end 
   WaitSecs(timing.feedback_delay); %Show screen for 1.5s post-mouseclick
end     

