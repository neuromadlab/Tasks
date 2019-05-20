    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   Determine maximum Frequency (2x10secs)    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
frequency_vector = [nan];
t_button_vec = [nan];

i_step = 1;
t_100_vector = [];
frequency_t100_vector = [];

collectMax.freq=0;
collectMax.t_button = []; % stores clicks: timestamp
collectMax.t_button_referenced = []; %referenced to t_trial_onset
collectMax.frequency_button = [];

collectMax.t_button_interval = []; %stores current_input (t2-t1)
collectMax.avrg = []; %stores weighted interval value of a click
collectMax.frequency = []; %stores weighted interval value of a click
i_resp = 1; %Index for response arrays
i_phantom = 1;
i_collectMax = 1;
collectMax.maxFreq = nan(1,2); %stores maxFreq of 2 practice trials
collectMax.values_per_trial = [];
collectMax.values_per_trial_t100 = []; %Matrix of output values / timepoint referenced (every 100ms)
collectMax.t_100 = []; %Timestamp every 100ms
collectMax.frequency_t100 = []; %Frequency every 100 ms



%Initialise exponential weighting
forget_fact = 0.6;
prev_weight_fact = 0;
prev_movingAvrg = 0;
t_button = 0;
current_input = 0; 
Avrg_value = 0;
draw_frequency = 0; %Ball position dependent on output/phantom frequency, initially ball at bottom
 
max_Boundary_yposition = ((setup.ScrHeight-Tube.offset-Ball.width)-(draw_frequency * draw_frequency_factor));

%%Starting Protocol

text = ['Auf dem Bildschirm werden Sie gleich ein nach oben geöffnetes Gefäß sehen mit einem blauen Ball darin. Wenn Sie den rechten Taster am Controller mit Ihrem Zeigefinger drücken, bewegt sich der Ball nach oben. Je schneller Sie drücken, desto höher steigt der Ball. \nSie haben jetzt zweimal 10 Sekunden Zeit, um den Ball so hoch wie möglich steigen zu lassen.\nDie höchste erreichte Position wird mit einer blauen Linie angezeigt.'];
    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum);


%wait for a mouse click to continue
GetClicks(setup.screenNum);


for i_collectMax = 1:2 %2 trials of 10secs to collect valid maxFreq
    
    
    if (i_collectMax == 1)
        text = ['Bitte verändern Sie während des Versuchs Ihre Handhaltung nicht. \n\nVersuchen Sie in den nächsten 10 Sekunden den Ball so hoch steigen zu lassen, wie Sie können.'];
            Screen('TextSize',w,32);
            Screen('TextFont',w,'Arial');
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
            Screen('Flip',w);
            GetClicks(setup.screenNum);
    
    elseif (i_collectMax == 2)
        text = ['Das war schon sehr gut. Versuchen Sie jetzt, den Ball noch höher steigen zu lassen.'];
            Screen('TextSize',w,32);
            Screen('TextFont',w,'Arial');
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
            Screen('Flip',w);
            GetClicks(setup.screenNum);
    end

    fix = ['+'];
    Screen('TextSize',w,64);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', color.black,80);
    time.fix = Screen('Flip', w);

    WaitSecs(1); %Show screen for 1s
    

    
    t_collectMax_onset = GetSecs;
    t_buttonN_1 = t_collectMax_onset;

    
    %while ((10 * i_collectMax) > (GetSecs - t_collectMax_onset))       %Trial-length 10sec
    while (10  > (GetSecs - t_collectMax_onset))       %Trial-length 10sec    
    
        %routine for timestamps every 100ms
         t_step = GetSecs;
         
         if ((0.1 * i_step) <= (t_step - t_collectMax_onset))
            
            t_100_vector(1,i_step) = t_step;
            frequency_t100_vector(1,i_step) = draw_frequency;
            
            i_step = i_step + 1;
         end
        
        
        % Draw Tube
            Screen('DrawLine',effort_scr,color.black,(setup.xCen-Tube.width/2), Tube.height, (setup.xCen-Tube.width/2), (setup.ScrHeight-Tube.offset),6);
            Screen('DrawLine',effort_scr,color.black,(setup.xCen+Tube.width/2), Tube.height, (setup.xCen+Tube.width/2), (setup.ScrHeight-Tube.offset),6);
            Screen('DrawLine',effort_scr,color.black,(setup.xCen-Tube.width/2), (setup.ScrHeight-Tube.offset), (setup.xCen+Tube.width/2), (setup.ScrHeight-Tube.offset),6);
            Screen('CopyWindow',effort_scr,w);
          
            %Draw upper bound blue line
            Boundary_yposition = ((setup.ScrHeight-Tube.offset-Ball.width)-(draw_frequency * draw_frequency_factor));
            max_Boundary_yposition = min(max_Boundary_yposition, Boundary_yposition);
            
            Screen('DrawLine',w,color.darkblue,(setup.xCen-Tube.width/2), max_Boundary_yposition, (setup.xCen+Tube.width/2), max_Boundary_yposition,3);

          % Draw Ball
            Ball.position = [(setup.xCen-Ball.width/2) ((setup.ScrHeight-Tube.offset-Ball.width)-(draw_frequency * draw_frequency_factor)) (setup.xCen+Ball.width/2) ((setup.ScrHeight-Tube.offset)-(draw_frequency * draw_frequency_factor))];
            Ball.color = color.darkblue;
            Screen('FillOval',w,Ball.color,Ball.position);
            Screen('Flip', w);

            
            
            [b,c] = KbQueueCheck;      


 
            %If experiment is run with GamePad
            if do_gamepad == 1
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
                
                %Buffer routine
                for buffer_i = 2:50 %buffer_size
                joy.pos_Z(count_joy,i_collectMax) = Joystick.Z;
                joy.time_log(count_joy,i_collectMax) = GetSecs - t_collectMax_onset;
                count_joy = count_joy + 1;
                    
                    
                    if Joystick.Z < 200
                        Joystick.RI_button = 1;
                    else
                        Joystick.RI_button = 0;
                    end
                    xbox_buffer(buffer_i) = Joystick.RI_button; %Joystick.Button(1);
                    if xbox_buffer(buffer_i)==1 && xbox_buffer(buffer_i-1)==0
                        count_joystick = 1;
                        %Stores time stamp of BP
                        t_button = GetSecs; 
                    else
                        count_joystick = 0;
                    end
                    if buffer_i == 50
                        buffer_i = 2;
                        xbox_buffer(1)=xbox_buffer(50);
                    end
 
 
        %Frequency estimation based on Button Press            
        if c(keys.resp) > 0 || count_joystick == 1
            % resp=resp+1;
%              if c(keys.resp) > 0
%                  
%                 t_button = c(keys.resp);
                     
                     if (t_button > (t_collectMax_onset + 0.1)); %if keypress starts during fixation phase, the initial interval might be too short. Frequency estimation the n becomes skewed
                         
                         t_button_vec(1,i_resp) = t_button;
                         
                         %Exponential weightended Average of RT for frequency estimation
                         current_input = t_button - t_buttonN_1;                    
                         current_weight_fact = forget_fact * prev_weight_fact + 1;
                         Avrg_value = (1-(1/current_weight_fact)) * prev_movingAvrg + ((1/current_weight_fact) * current_input);
                         frequency_estimate = freq_interval/Avrg_value;
                         

                         %update Ball height and store frequency for output
                         draw_frequency = frequency_estimate;
                         frequency_vector(1,i_resp) = frequency_estimate;
                         
                        %Refresh values
                        prev_weight_fact = current_weight_fact; 
                        prev_movingAvrg = Avrg_value;
                        t_buttonN_1 = t_button;
                        
                        collectMax.avrg(1,i_resp) = Avrg_value;
                        collectMax.t_button_interval(1,i_resp) = current_input;
                                                  
                        i_resp = i_resp + 1;
                        count_joystick = 0;
                        
                     end
                     
                     
            %if no button press happened: Frequency should decrease slowly based on phantom estimates 
            elseif (GetSecs - t_buttonN_1) > (1.5 * Avrg_value) && (i_resp > 1);
                
                    phantom_current_input = GetSecs - t_buttonN_1;
                    current_weight_fact = forget_fact * prev_weight_fact + 1;
                    Estimate_Avrg_value = (1-(1/current_weight_fact)) * prev_movingAvrg + ((1/current_weight_fact) * phantom_current_input);
                    phantom.freq = freq_interval/Estimate_Avrg_value;  
                
                   %update Ball height
                    draw_frequency = phantom.freq; 
                                        
                    %Refresh values in phantom output vector
                    prev_weight_fact = current_weight_fact; 
                    prev_movingAvrg = Estimate_Avrg_value;
                    %NOT% t_buttonN_1 = t_button; Last key press remains unchanged 
                    %output.t_button(1,output_index) = t_button;
                    phantom.avrg(1,i_phantom) = Avrg_value;
                    phantom.t_button_interval(1,i_phantom) = current_input;
                    phantom.frequency(1,i_phantom) = phantom.freq; 
                    
                    i_phantom = i_phantom + 1;
                    
        end
        
                end
                
            end        
    
    end

    count_joy = 1;
%%=========Prepare Output==============  
if length(frequency_vector) == 0
    
    frequency_vector = [nan];
    
end

if length(t_button_vec) == 0
    
    t_button_vec = [nan];
    
end

%Store MaxFrequency for each training trial
  
collectMax.maxFreq(1,i_collectMax) = max(frequency_vector);

%Reference t_Button to collectMax_onset 
t_button_ref_vec = t_button_vec - t_collectMax_onset; 

%Copy Output Values into Output Matrix
collectMax.values_per_trial = [collectMax.values_per_trial, [ones(1,length(frequency_vector)) * subj.num; ... %Subj_ID
                               ones(1,length(frequency_vector)) * i_collectMax ; ...                         %Trial_ID
                               (1:length(frequency_vector)) ; ...                                            %t_Button ID
                               t_button_ref_vec ; ...                                                       %t_Button referenced to 10sec-trial start
                               frequency_vector ; ...                                                   %Frequency at t_Button
                               ones(1,length(frequency_vector)) * collectMax.maxFreq(1,i_collectMax)]];       %Maximum Frequency in 10seconds-trial

t_100_ReftoTrialStart = t_100_vector - t_collectMax_onset;                            
collectMax.values_per_trial_t100 = [collectMax.values_per_trial_t100, [ones(1,length(t_100_vector)) * subj.num; ... %Subj_ID
                               ones(1,length(t_100_vector)) * i_collectMax ; ...                         %Trial_ID
                               (1:length(t_100_vector)) ; ...                                            %t_Button ID
                               t_100_vector; ...                                                       %t_Button referenced to 10sec-trial start
                               t_100_ReftoTrialStart; ...
                               frequency_t100_vector ; ...                                                   %Frequency at t_Button
                               ones(1,length(t_100_vector)) * collectMax.maxFreq(1,i_collectMax)]];       %Maximum Frequency in 10seconds-trial
       

collectMax.t_button = [collectMax.t_button, t_button_vec];
    button_vec = [];

collectMax.frequency_button = [collectMax.frequency_button, frequency_vector];
    frequency_vector = [];

collectMax.t_button_referenced = [collectMax.t_button_referenced, t_button_ref_vec];
    t_button_ref_vec = [nan];

collectMax.t_100 = [collectMax.t_100, t_100_vector];
    t_100_vector = [];

collectMax.frequency_t100 = [collectMax.frequency_t100, frequency_t100_vector];
    frequency_t100_vector = [];

%create temporary storage
collectMax.filename = sprintf('%s\\data\\%s_%s_%s_S%s_%s_temp', pwd, subj.tasklabel, subj.studyID, subj.subjectID, subj.sessionID, subj.runID);
save([collectMax.filename '.mat'], 'collectMax', 'subj', 'input', 'joy')
  

%%=========Clear Variables
t_collectMax_onset = nan;
t_buttonN_1 = 0;
t_button = 0;  

draw_frequency = 0; %resets Ball position
current_input = 0;
current_weight_fact = 0;
Avrg_value = 0;
frequency_estimate = 0;
prev_weight_fact = 0; 
prev_movingAvrg = 0;

collectMax.avrg(1,i_resp) = Avrg_value;
collectMax.t_button_interval(1,i_resp) = current_input;   

phantom_current_input = 0;
Estimate_Avrg_value = 0;
phantom.freq = 0;
phantom.avrg = [];
phantom.t_button_interval = [];
phantom.frequency = []; 

frequency_vector = [];
t_button_vec = [];
i_phantom = 1;
i_resp = 1;

i_step = 1;
count_joystick = 0;

    WaitSecs(1.5);
    
end


% Individual MaxFrequency for experiment

input.maxFrequency = max(collectMax.maxFreq);



%CONTROL PRINT
% text = ['Sehr gut! Die Maximal-Frequenz bisher ist: ' num2str(input.maxFrequency)];
%         Screen('TextSize',w,32);
%         Screen('TextFont',w,'Arial');
%         [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
%         [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
%         Screen('Flip',w);
%         GetClicks(setup.screenNum);

        
%%======================
%%End of TRAINING
%%======================