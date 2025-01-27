% ================== Instrumental Motivation Task ========================
% Script needed for IMT_main.m
% Input: fiber optic response grip force device 
%
% Current adaptions for TUE008, Corinna Schulz, 2022, Matlab R2021b using Psychtoolbox 3.0.16
% ========================================================================

%% Training Part II: Cue conditioning phase
% outside of the scanner (requires visuals and tone) but already with
% GFD. Here the tones are learned to be associated with the reward. 

% Initialise variables for cue conditioning 
performance = 0; 
counter_conditioning = 1; 
correct_cue_trial = []; 

% Set Drawing parameters for Visual Cue (US)
Cue.width                  = round(setup.ScrWidth * .35);
% Location of reward Cue
Cue.TopImg                 = setup.ScrHeight/2 -  Cue.width/2;
Cue.BottomImg              = setup.ScrHeight/2 +  Cue.width/2;
Cue.RightImg           = setup.xCen+(Cue.width/2);
Cue.LeftImg            = setup.xCen-(Cue.width/2);
% Location of reward incentive
Cue.loc = [Cue.LeftImg Cue.TopImg Cue.RightImg Cue.BottomImg];

%%  Loop through conditioning trials
% Loops through conditioning (Repeat) and test conditioning (Query) Sets until performance
% on test conditioning trials is reached. Minimum of 3 Repeats. Performance
% over last 2 Query Sets.

% As i_trial will count from 1 to end of one Set, we need to add an offset each loop 
% to go through the full condition list 
offset = settings.cue_conditioning_trials + settings.cue_conditioning_test_trials; 

while performance < settings.cond_performance  % While cue conditioning performance below set performance repeat cue conditioning 
    
    % One Cue Count: One Repeat Set followed by one Query Set 
    for i_trial = 1:(settings.cue_conditioning_trials + settings.cue_conditioning_test_trials)  
        
        % Add offset to i_trial such that we can index the conditionstable
        i_cond_index = i_trial + ((counter_conditioning-1) * offset); 

        %% Update trial settings before trial start
        % Get current Reward (Food Vs. Money, High Vs. Low), and Tone 
        Reward_Type         = cue_conditionstable.Money(i_cond_index);  % 1 = Money, 0 = Food
        Reward_Mag          = cue_conditionstable.Rew_magn(i_cond_index);  % 1 or 10
        Trial_Type          = cue_conditionstable.Query(i_cond_index);  % 0 (Repeat Cue Learning), 1 (Query)
        Query_Type          = cue_conditionstable.Query_Mag(i_cond_index);  % 0 (Query Reward Type), 1 (Query Reward Magnitude)

        % Get Reward Tone Pairing 
        Reward_Tone         = cue_conditionstable.Tone(i_cond_index); 

        % Prepare current reward tone (get wavedata, previously (during
        % Create_Settings.m read in using psychwavread function
        if Reward_Tone == 1
            wavedata = stimuli.tone.one.y';
        elseif Reward_Tone == 2
            wavedata = stimuli.tone.two.y';
        elseif Reward_Tone == 3
            wavedata = stimuli.tone.three.y';
        elseif Reward_Tone == 4
            wavedata = stimuli.tone.four.y';
        end

       
        %% CUE Conditioning 
        % <forward Conditioning is used> 
        % Present CS (tone), in end of CS present US (image)
        % current implementation: no delay conditioning
        
        %% Instructions for Conditioning Phase 
        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        
        if i_trial == 1 && counter_conditioning == 1 % Instructions for the Cue conditioning 
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.intro_reward, 'center', Text.height, color.black, 60);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.continue_GFD, 'center', Text.height_cont, color.black, 50);
            Screen('Flip',w);
            WaitSecs(2) 
            
            % Get Press-to-continue
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_value = Joystick.Y;
    
            while gripforce_value > clckforce
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                gripforce_value = Joystick.Y;
            end
    
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_money, 'center', Text.height, color.black);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.continue_GFD, 'center', Text.height_cont, color.black, 50);
            Screen('Flip',w);
            WaitSecs(3)
    
            % Get Press-to-continue
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_value = Joystick.Y;
    
            while gripforce_value > clckforce
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                gripforce_value = Joystick.Y;
            end
    
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.reward_kcal, 'center', Text.height, color.black);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.continue_GFD, 'center', Text.height_cont, color.black, 50);
            Screen('Flip',w);
            WaitSecs(3)
    
            % Get Press-to-continue
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_value = Joystick.Y;
    
            while gripforce_value > clckforce
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                gripforce_value = Joystick.Y;
            end
    
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.tones, 'center', Text.height, color.black);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.continue_GFD, 'center', Text.height_cont, color.black, 50);
            Screen('Flip',w);
            WaitSecs(3)
    
            % Get Press-to-continue
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_value = Joystick.Y;
    
            while gripforce_value > clckforce
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                gripforce_value = Joystick.Y;
            end
    
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.start_conditioning, 'center', Text.height, color.black);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.continue_GFD, 'center', Text.height_cont, color.black, 50);
            Screen('Flip',w);
            WaitSecs(2)
    
            % Get Press-to-continue
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_value = Joystick.Y;
    
            while gripforce_value > clckforce
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                gripforce_value = Joystick.Y;
            end
    
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.start_practice_conditioning, 'center', Text.height, color.black);
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.press_GFD, 'center', Text.height_cont, color.black, 50);
            Screen('Flip',w);
            WaitSecs(3)
    
            % Get Press-to-continue
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_value = Joystick.Y;
    
            while gripforce_value > clckforce
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                gripforce_value = Joystick.Y;
            end
    
        end 

        fix = '+';
        Screen('TextSize',w,64);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', color.black,80);
        Screen('Flip', w);

        WaitSecs(0.5); 
        
        %% Get Conditions for Cue Conditioning Trials
        % Prepare graphical display with corresponding reward items
        % determine Reward Image (incentive)
        if Reward_Type == 0 && Reward_Mag == 1 % Food, Low
            Reward_Img = stim.incentive_cookies1;
        elseif Reward_Type == 0 && Reward_Mag == 10 % Food, High
            Reward_Img = stim.incentive_cookies10;
        elseif Reward_Type == 1 && Reward_Mag == 1 % Money, Low
            Reward_Img = stim.incentive_coins1;
        elseif Reward_Type == 1 && Reward_Mag == 10 % Money, High
            Reward_Img = stim.incentive_coins10;
        end

        % Create variables 
        RT(i_trial,counter_conditioning) = NaN; % If RT measured later overwritten, otherwise keeps NaN 
        key_pressed(i_trial,counter_conditioning) = 0;  % If Key pressed during Query in time will change to 1 

        %% START WITH CUE CONDITIONING
        if Trial_Type == 0 % Repeat Trial (Cue Learning)
            
            nrchannels = size(wavedata,1); % Number of rows == number of channels.
            % Make sure we have always 2 channels stereo output.
            % Why? Because some low-end and embedded soundcards
            % only support 2 channels, not 1 channel, and we want
            % to be robust in our demos.
            if nrchannels < 2
                wavedata = [wavedata ; wavedata];
                nrchannels = 2;
            end

            % Fill the audio playback buffer with the audio data 'wavedata':
            PsychPortAudio('FillBuffer', pahandle, wavedata);

            % Start audio playback indicating the Reward Type (Money/Food) and Reward Magnitude (1/10)
            starttime_audio = PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart);
            
            timestamps.conditioning.learning.start_CS(i_trial,counter_conditioning) = starttime_audio;
            timestamps_relative.conditioning.learning.start_CS(i_trial,counter_conditioning) = starttime_audio - timestamps.conditioning.exp_on; 

            % Let the CS (tone) be 3 seconds, after 1.5s show als US (visual)
            while 1
                if GetSecs >= (starttime_audio + (timings.cue_length/2))
                    break
                end
            end

            while (GetSecs-starttime_audio) < timings.cue_length 
                Screen('DrawTexture', w,  Reward_Img,[],  Cue.loc);
                [time.img, starttime] = Screen('Flip', w);
                timestamps.conditioning.learning.start_US(i_trial,counter_conditioning) = starttime;
                timestamps_relative.conditioning.learning.start_US(i_trial,counter_conditioning) = starttime - timestamps.conditioning.exp_on;
            end
    
            % Stop Playback
            [startTime, endPositionSecs, xruns, estStopTime] = PsychPortAudio('Stop', pahandle);
            timestamps.conditioning.learning.end_CS_US(i_trial,counter_conditioning) = estStopTime;
            timestamps_relative.conditioning.learning.end_CS_US(i_trial,counter_conditioning) = estStopTime - timestamps.conditioning.exp_on; 
            
            % Show fixation cross between each conditioning trial
            fix = '+';
            Screen('TextSize',w,64);
            Screen('TextFont',w,'Arial');
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', color.black,80);
            timings.cue_cond.fix(i_trial, counter_conditioning) = Screen('Flip', w);
        
            correct_cue_trial(i_trial, counter_conditioning) = NaN; % TO DO???

            WaitSecs(1); %Show screen for 1s

        %% Testing Performance: Cue-Reward Association
        elseif Trial_Type == 1 % Query Trial
            
            % Deduce Learning trials to have count for query trials 
            i_trial_query = i_trial - (settings.cue_conditioning_trials); 

            %% Prepare Participant for Incoming Query Trials 
            % Prepare participant that Query Set is about to start 
            if i_trial_query == 1
                Test_Start = instr.start_queries; 
                [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, Test_Start, 'center', 'center', color.black,80);
                Screen('Flip', w);
                WaitSecs(1.5)
            end 

            %% Prepare Query Trial  
            test = instr.test; % Screen during tone display showing that a Test is about to start 

            if Query_Type == 0 %Query Reward Type (Left vs. Right Key)
                Response = instr.query_reward; % Reminder of keys
            elseif Query_Type == 1 % Query Reward Magnitude (Down vs. Up Key) 
                Response = instr.query_magnitude; % Reminder of keys
            end 

            % Determine correct key response for this query trial 
            if Query_Type == 0          % Food versus Money
                if Reward_Type == 0     % Food
                    correct_key = keys.left;
                elseif Reward_Type == 1  % Money
                    correct_key = keys.right;
                end 
            elseif Query_Type == 1      % High versus Low Magnitude
                if Reward_Mag == 1      % Low Magnitude
                    correct_key = keys.down;
                elseif Reward_Mag == 10  % High Magnitude
                    correct_key = keys.up;
                end
            end

            %% Prepare Test Tone
            nrchannels = size(wavedata,1); % Number of rows == number of channels.

            % Make sure we have always 2 channels stereo output.
            % Why? Because some low-end and embedded soundcards
            % only support 2 channels, not 1 channel, and we want
            % to be robust in our demos.
            if nrchannels < 2
                wavedata = [wavedata ; wavedata];
                nrchannels = 2;
            end
            
            % Fill the audio playback buffer with the audio data 'wavedata':
            PsychPortAudio('FillBuffer', pahandle, wavedata);

            % Start audio playback indicating the Reward Type (Money/Food) and Reward Magnitude (1/10)
            starttime_audio = PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart);
            
            timestamps.conditioning.query.start_CS(i_trial_query,counter_conditioning) = starttime_audio;
            timestamps_relative.conditioning.query.start_CS(i_trial_query,counter_conditioning) = starttime_audio - timestamps.conditioning.exp_on; 

            % Let the CS (tone) be 3 seconds, after 1.5s show als US (visual)
            while (GetSecs-starttime_audio) <= timings.cue_length
                Screen('TextSize',w,50);
                Screen('TextFont',w,'Arial');
                [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, test, 'center', 'center', color.black,80);
                Screen('Flip', w);
            end

            % Stop Playback
            [startTime, endPositionSecs, xruns, estStopTime] = PsychPortAudio('Stop', pahandle);
            timestamps.conditioning.query.end_CS(i_trial_query,counter_conditioning) = estStopTime;
            timestamps_relative.conditioning.query.end_CS(i_trial_query,counter_conditioning) = estStopTime - timestamps.conditioning.exp_on; 

            %% Get Response
                    
            % Initialise Query 
            KbQueueCreate();
            KbQueueFlush();
            KbQueueStart();
            %ListenChar(2); %Suppress keyboard input to code when debugging
            

            % Get onset time
            Screen('TextSize',w,50);
            Screen('TextFont',w,'Arial');
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, Response, 'center', 'center', color.black,80);
            timestamps.conditioning.query.start_response(i_trial_query,counter_conditioning) = Screen('Flip', w);
            timestamps_relative.conditioning.query.start_response(i_trial_query,counter_conditioning) = timestamps.conditioning.query.start_response(i_trial_query,counter_conditioning) - timestamps.conditioning.exp_on ;

            
            [pressed, firstkey_pressed] = KbQueueCheck(0);

            while (timings.cue_response_wait > (GetSecs - timestamps.conditioning.query.start_response(i_trial_query,counter_conditioning)) )
                [pressed, firstkey_pressed] = KbQueueCheck(0);
             
                % Get time when key was pressed, calculate RT key press
                if any(firstkey_pressed)
                    timestamps.conditioning.query.response(i_trial_query,counter_conditioning) = GetSecs;
                    timestamps_relative.conditioning.query.response(i_trial_query,counter_conditioning) = timestamps.conditioning.query.response(i_trial_query,counter_conditioning) - timestamps.conditioning.exp_on;

                    RT(i_trial,counter_conditioning) = timestamps.conditioning.query.response(i_trial_query,counter_conditioning) - timestamps.conditioning.query.start_response(i_trial_query,counter_conditioning);
                    key_pressed(i_trial,counter_conditioning)  = 1; % Key was pressed
                    break; 
                end
            end
            
            KbQueueRelease();     
           timestamps.conditioning.query.end_response(i_trial_query,counter_conditioning) = GetSecs;
           timestamps_relative.conditioning.query.end_response(i_trial_query,counter_conditioning) = timestamps.conditioning.query.end_response(i_trial_query,counter_conditioning) - timestamps.conditioning.exp_on;

            % Evaluate Performance on this query trial 
            
            if any(firstkey_pressed) %Check whether key was pressed
                answer = find(firstkey_pressed>0); % Get Name of key pressed

                % Log Performance on each trial
                if answer == correct_key
                    correct_cue_trial(i_trial, counter_conditioning) = 1;
                    cue_feedback = instr.cue_feedback_correct ;
                else 
                    correct_cue_trial(i_trial, counter_conditioning) = 0;
                    cue_feedback = instr.cue_feedback_wrong;
                end
            else
                correct_cue_trial(i_trial, counter_conditioning) = 0;
                cue_feedback = instr.cue_feedback_wrong;
            end

            %% 11.6 Feedback Phase
            Screen('TextSize',w,64);
            Screen('TextFont',w,'Arial');
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, cue_feedback, 'center', 'center', color.black,80);
            timestamps.conditioning.query.start_feedback(i_trial_query,counter_conditioning)= Screen('Flip', w);
            timestamps_relative.conditioning.query.start_feedback(i_trial_query,counter_conditioning)= timestamps.conditioning.query.start_feedback(i_trial_query,counter_conditioning) - timestamps.conditioning.exp_on ;
           
            WaitSecs(1.5)

            timestamps.conditioning.query.end_feedback(i_trial_query,counter_conditioning)= GetSecs; 
            timestamps.conditioning.query.end_feedback(i_trial_query,counter_conditioning)= timestamps.conditioning.query.end_feedback(i_trial_query,counter_conditioning) - timestamps.conditioning.exp_on; 

        end
   
        % Wait before next trial starts
        WaitSecs(1.5);

        %% Save Data Backup at end of every trial
        output.cue_conditioning = [output.cue_conditioning; ...
            [subj.id, ...               % subject ID
            subj.sess, ...              % session
            str2double(subj.runINDEX), ... % run number
            i_trial, ...                % trial number
            counter_conditioning, ...   % Cue conditioning repeat number 
            Reward_Type, ...            % condition: Reward Type
            Reward_Mag, ...             % condition: Reward Magnitude
            Trial_Type,...              % condition cue phase: learning vs. query 
            Query_Type,...              % condition query: reward type vs. reward magnitude  
            correct_cue_trial(i_trial, counter_conditioning),... % test conditioning result
            RT(i_trial, counter_conditioning),...                % test conditioning RT
            key_pressed(i_trial, counter_conditioning)] ];       % test conditioning key pressed in time
            

            % Create & Save temporary output data
            outputcue.filename_temp = sprintf('%s\\backup\\conditioning_%s_%s_s%s_temp', pwd, subj.study, subj.subjectID, subj.sessionID);
            save([outputcue.filename_temp '.mat'], 'output')
             
    end

    output.variable_labels_cue_conditioning = {'ID', 'Session', 'Run','Trial','CueCond_Repeat','Reward_Money','Reward_Magnitude','Trial_Query','Query_Mag','Test_Correct','RT','key_pressed'};
    
    % Minimum of 3 Cue Learning rounds before performance is updated!
    if counter_conditioning > 3 
        % Update Performance
        sum_2_rounds = nansum([correct_cue_trial(:,counter_conditioning); correct_cue_trial(:,counter_conditioning-1)]); 
        performance = sum_2_rounds/(settings.cue_conditioning_test_trials*2);
    end 

    % Count Cue Conditioning Sets 
    counter_conditioning = counter_conditioning + 1;

    % If performance is below benchmark repeat conditioning set!
    if performance < settings.cond_performance
        Screen('TextSize',w,50);
        Screen('TextFont',w,'Arial')
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.not_yet_there, 'center', Text.height, color.black);
        Screen('Flip',w);
        WaitSecs(3)
    end 

end

% Finished cue conditioning! Bravo!
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.done_conditioning, 'center', Text.height, color.black);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.continue_GFD, 'center', Text.height_cont, color.black, 50);
Screen('Flip',w);
WaitSecs(3)

% Create & Save output data
outputcue.filename = sprintf('%s\\backup\\conditioning_%s_%s_s%s', pwd, subj.study, subj.subjectID, subj.sessionID);
save([outputcue.filename '.mat'], 'output','timestamps')
delete([outputcue.filename_temp '.mat'])

% Get Press-to-continue
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
gripforce_value = Joystick.Y;

while gripforce_value > clckforce
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    gripforce_value = Joystick.Y;
end
