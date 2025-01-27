%% Reminder Tone-Reward Association before Start of the Task 

% Get Tone-Reward Pairing of this participant 
reward_conditions = {'1-fach Essen','10-fach Essen','1-fach Geld','10-fach Geld'};

Tone_Food_Low = cue_conditionstable.Tone(cue_conditionstable.Money == 0 & cue_conditionstable.Rew_magn == 1); 
Tone_Food_High = cue_conditionstable.Tone(cue_conditionstable.Money == 0 & cue_conditionstable.Rew_magn == 10); 
Tone_Money_Low = cue_conditionstable.Tone(cue_conditionstable.Money == 1 & cue_conditionstable.Rew_magn == 1); 
Tone_Money_High = cue_conditionstable.Tone(cue_conditionstable.Money == 1 & cue_conditionstable.Rew_magn == 10);

% Remind participant twice of each tone-reward pairing
reminder_tone = [Tone_Food_Low(1:2), Tone_Food_High(1:2), Tone_Money_Low(1:2), Tone_Money_High(1:2)];
reminder_tone = [reminder_tone(1,:), reminder_tone(2,:)];
reminder_condition = [reward_conditions, reward_conditions];

index_perm = randperm(8); 
reminder_tone_shuffled = reminder_tone(index_perm); 
reminder_condition_shuffled = reminder_condition(index_perm);

% Loop through reminders 
for remind = 1:length(reminder_tone)
    
    % Prepare  reward tone (get wavedata)
    if reminder_tone_shuffled(remind) == 1
        wavedata = stimuli.tone.one.y';
    elseif reminder_tone_shuffled(remind) == 2
        wavedata = stimuli.tone.two.y';
    elseif reminder_tone_shuffled(remind) == 3
        wavedata = stimuli.tone.three.y';
    elseif reminder_tone_shuffled(remind) == 4
        wavedata = stimuli.tone.four.y';
    end
    
    % Get current condition 
    current_cond = reminder_condition_shuffled(remind); 

    % Prepare Tone 
    nrchannels = size(wavedata,1); % Number of rows == number of channels.
    if nrchannels < 2
        wavedata = [wavedata ; wavedata];
        nrchannels = 2;
    end

    % Fill the audio playback buffer with the audio data 'wavedata':
    PsychPortAudio('FillBuffer', pahandle, wavedata);

    % Start audio playback indicating the Reward Type (Money/Food) and Reward Magnitude (1/10)
    starttime_audio = PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart);

    timestamps.IMT.recap.start_CS(remind) = starttime_audio;
    timestamps_relative.recap.start_CS(remind) = starttime_audio - timestamps.IMT.recap.exp_on;

    % Let the CS (tone) be 3 seconds
    while 1 
        if GetSecs >= timestamps.IMT.recap.start_CS(remind) + timings.cue_length
            % Stop Playback
            [startTime, endPositionSecs, xruns, estStopTime] = PsychPortAudio('Stop', pahandle);
            timestamps.IMT.recap.end_CS(remind) = GetSecs;
            timestamps_relative.IMT.recap.end_CS(remind) = timestamps.IMT.recap.start_CS(remind) - timestamps.IMT.recap.exp_on;
            break
        end 
    end 

    % Read out Condition that belongs to reward 
    Speak(obj, string(current_cond));
    WaitSecs(1)

end 

