%% Grip Force Device Input for the Bidding Phase
% Code taken from TUE005 FCR GDF_tube and adapted for the IMT: Corinna
% Schulz, June 2022

% This script: 
% Collects continuous force values during the bidding phase. 
% The bidding phase is anounces with a short beep tone. Area under the Curve is calculated. 
% This is done for just before Beep (full length) and for just after beep
% (this is ultimatively used for calculation of win points) 

% Record Start Time of effort
t_collectMax_onset = GetSecs;
onset_start = 0;

timestamps.IMT.start_effort(i_trial,1) = t_collectMax_onset; 
timestamps_relative.IMT.start_effort(i_trial,1) = t_collectMax_onset - timestamps.IMT.exp_on; 

%% Bidding Phase (lasts 3 seconds + very short Beep at start )
while (timings.effort_length + beepLengthSecs  > (GetSecs - (t_collectMax_onset)) )
    
    % Conditional input
    % Log Force Input

    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    gripforce_value = Joystick.Y;

    % Getting values from Grip Force Device -> Joystick.Y
    ForceMat = gripforce_value;

    % Saving force over time by adding the current ForceMat to ForceTime at every
    % step
    ForceTime = [ForceTime, gripforce_value];

    if strcmp(subj.runINDEX, '2') % Draw graphical display
        % Draw Tube
        Screen('DrawLine',w,color.black,(setup.xCen-Tube.width/2), Tube.height, (setup.xCen-Tube.width/2), (setup.ScrHeight -Tube.offset),6);
        Screen('DrawLine',w,color.black,(setup.xCen+Tube.width/2), Tube.height, (setup.xCen+Tube.width/2), (setup.ScrHeight-Tube.offset),6);
        Screen('DrawLine',w,color.black,(setup.xCen-Tube.width/2), (setup.ScrHeight-Tube.offset), (setup.xCen+Tube.width/2), (setup.ScrHeight-Tube.offset),6);

        Ball.DrawFactor = 0;
         if ForceMat < restforce
            Ball_yposition  = BarBound2Scale * ForceMat + UpperBoundBar ...
                                - input_device.maxEffort * BarBound2Scale;    
         else
             Ball_yposition = Tube.YBottom;              
         end

         Ball.position       = [(setup.xCen-Ball.width/2) (Ball_yposition - Ball.width - Ball.DrawFactor)...
                            (setup.xCen+Ball.width/2) (Ball_yposition - Ball.DrawFactor)];
        
        Screen('FillOval',w,Ball.color,Ball.position);
        Screen('Flip', w);

    end 
    

    if i_step == 1 
        %% Signal Start of Bidding Phase to Participant
        % Very short deep sound (almost vibration)
        myBeep = MakeBeep(400, beepLengthSecs, freq);
    
        % Fill the audio playback buffer with the audio data, doubled for stereo presentation
        PsychPortAudio('FillBuffer', pahandle, [myBeep; myBeep]);
    
        % Start audio playback
        start_beep = PsychPortAudio('Start', pahandle, repetitions, 0, waitForDeviceStart);
    
        timestamps.IMT.start_effort_beep(i_trial,1) = start_beep;
        timestamps_relative.IMT.start_effort_beep(i_trial,1) = start_beep - timestamps.IMT.exp_on;
    end 

    % Store for timestamps and actual force every 100ms
    t_step = GetSecs;
    t_vector(1,i_step) = t_step;
    i_step = i_step + 1;

    % Test whether beep should be over
    if GetSecs >= start_beep + beepLengthSecs && i_step_aftBeep == 0
        [startTime, endPositionSecs, xruns, estStopTime] = PsychPortAudio('Stop', pahandle);
        timestamps.IMT.end_effort_beep(i_trial,1) = estStopTime;
        timestamps_relative.IMT.end_effort_beep(i_trial,1) = estStopTime - timestamps.IMT.exp_on;
        i_step_aftBeep = i_step; % Only first time stop beep and take hold of time 
    end

end

timestamps.IMT.end_effort(i_trial,1) = GetSecs; 
timestamps_relative.IMT.end_effort(i_trial,1) = timestamps.IMT.end_effort(i_trial,1) - timestamps.IMT.exp_on; 

if settings.do_fmri == 1
    % Whole duration (From Before beep to End of Effort)
    MR_timings.onsets.effort(i_trial,1) = timestamps.IMT.start_effort(i_trial,1) - MR_timings.trigger.fin;
    MR_timings.durations.effort(i_trial,1) = timestamps.IMT.end_effort(i_trial,1) - timestamps.IMT.start_effort(i_trial,1) ;
    % During beep (Start Beep - End Beep)
    MR_timings.onsets.effort_Beep(i_trial,1) = timestamps.IMT.start_effort_beep(i_trial,1) - MR_timings.trigger.fin;
    MR_timings.durations.effort_Beep(i_trial,1) = timestamps.IMT.end_effort_beep(i_trial,1) - timestamps.IMT.start_effort_beep(i_trial,1) ;
    % After Beep (From After Beep - End Effort Phase)
    MR_timings.onsets.effort_aftBeep(i_trial,1) = timestamps.IMT.end_effort_beep(i_trial,1) - MR_timings.trigger.fin;
    MR_timings.durations.effort_aftBeep(i_trial,1) = timestamps.IMT.end_effort(i_trial,1) - timestamps.IMT.end_effort_beep(i_trial,1) ;
end

% %% Signal End of Bidding Phase to Participant 
% % Very short deep sound (almost vibration)
% myBeep = MakeBeep(400, beepLengthSecs, freq);
% 
% % Fill the audio playback buffer with the audio data, doubled for stereo presentation
% PsychPortAudio('FillBuffer', pahandle, [myBeep; myBeep]);
% 
% % Start audio playback
% start_beep = PsychPortAudio('Start', pahandle, repetitions, 0, waitForDeviceStart);
% while 1 
%     if GetSecs >= start_beep + beepLengthSecs
%         [startTime, endPositionSecs, xruns, estStopTime] = PsychPortAudio('Stop', pahandle);
%         break 
%     end 
% end 

%% Determine Relative Force over trial
% Seperate before and after end of Beep 
t_vector_befBeep = t_vector(1,1:i_step_aftBeep-1); 
t_vector_aftBeep = t_vector(1,i_step_aftBeep:end); 

% Time vecotr (subtracted start time of effort phase)
t_ref_vector = t_vector - t_collectMax_onset; % Start of effort phase just before BEEP 
t_ref_vector_befBeep = t_vector_befBeep - t_collectMax_onset; % Start of effort phase just before BEEP but only until end of BEEP
t_ref_vector_aftBeep = t_vector_aftBeep - estStopTime; % Start of effort phase just after BEEP

% Relative effort (Total: Before Beep to End of Effort phase)
rel_Force = (((input_device.minEffort - ForceTime) * 100)./(input_device.minEffort - ones(1,length(ForceTime))*input_device.maxEffort));

% Relative Effort Before Beep (From Before Beep to End of Beep)
ForceTime_befBeep = ForceTime(1,1:i_step_aftBeep-1); 
rel_Force_befBeep = (((input_device.minEffort - ForceTime_befBeep) * 100)./(input_device.minEffort - ones(1,length(ForceTime_befBeep))*input_device.maxEffort));

% Relative Effort After Beep (From End of Beep to End of Effort phase)
ForceTime_aftBeep = ForceTime(1,i_step_aftBeep:end); 
rel_Force_aftBeep = (((input_device.minEffort - ForceTime_aftBeep) * 100)./(input_device.minEffort - ones(1,length(ForceTime_aftBeep))*input_device.maxEffort));

%% Check Before and After Beep Force Tracking 
% buffer = zeros(1,length(ForceTime(1,1:i_step_aftBeep-1))); % Add Offset for plotting 

% plot(ForceTime)
% hold on 
% plot([buffer,ForceTime_aftBeep],'r')
% xline(i_step_aftBeep)
% legend('Force','Force after Beep')

% plot(t_ref_vector)
% hold on 
% plot([buffer, t_ref_vector_aftBeep],'r')
% xline(i_step_aftBeep)
% legend('time','time after Beep')
 
% plot(rel_Force)
% hold on 
% plot([buffer,rel_Force_aftBeep],'r')
% xline(i_step_aftBeep)
% legend('Rel Force','Rel Force after Beep')

%% Win calculation: normalized area under the curve
% Just during Beep (this is only for training to determine validity of trial) 
Force_max_befBeep = repmat(100,length(t_ref_vector_befBeep),1) ;
AUC_max_befBeep = trapz(Force_max_befBeep); % Get Area under the Curve (AUC) for max Force
AUC_trial_befBeep = trapz(rel_Force_befBeep'); % Get Area under the Curve (AUC) for Force on this trial

norm_by_max_area_befBeep = AUC_trial_befBeep/AUC_max_befBeep;

% With Beep (full lenght) 
Force_max = repmat(100,length(t_ref_vector),1) ;
AUC_max = trapz(Force_max); % Get Area under the Curve (AUC) for max Force
AUC_trial = trapz(rel_Force'); % Get Area under the Curve (AUC) for Force on this trial

norm_by_max_area = AUC_trial/AUC_max;

% Only After Beep (This is used for final calculation!)
Force_max_aftBeep = repmat(100,length(t_ref_vector_aftBeep),1) ;
AUC_max_aftBeep = trapz(Force_max_aftBeep); % Get Area under the Curve (AUC) for max Force
AUC_trial_aftBeep = trapz(rel_Force_aftBeep'); % Get Area under the Curve (AUC) for Force on this trial

norm_by_max_area_aftBeep = AUC_trial_aftBeep/AUC_max_aftBeep;

% area(rel_Force')
% hold on 
% area([buffer';rel_Force_aftBeep'])
% legend('Relative Force','Relative Force after Beep')

% AUC = trapz(t_ref_vector,rel_Force);        % Get Area under the Curve (AUC)
% norm_by_area = rel_Force/AUC;               % normalize by AUC
% proof = trapz(t_ref_vector, norm_by_area);  % Check that normalized AUC is indeed 1


%% Plot Area under the Curve
% subplot(3,1,1)
% plot(ForceTime)
% yline(input_device.minEffort)
% yline(input_device.maxEffort)
% grid on
% title('Force')
% legend('Force','MinEffortVal','MaxEffortVal')
% 
% subplot(3,1,2)
% plot(rel_Force)
% grid on
% title('Relative Effort')
% legend('area:' + string(norm_by_max_area))
% subplot(3,1,3)
% plot(norm_by_area)
% grid on
% legend('area:' + string(proof))
% title('Normalized Relative Effort by Area under the curve')

%% Determine Output
% Save for whole effort phase (incl. Beep) and pure 
buffer = NaN(1,length(ForceTime(1,1:i_step_aftBeep-1))); % Add Offset for same length Vector 

output.effort = [output.effort; ...
            repelem(subj.id,length(t_ref_vector))' , ...            	   % Subject ID
            repelem(subj.sess,length(t_ref_vector))', ...                  % Session Number
            repelem(str2double(subj.runINDEX),length(t_ref_vector))', ...  % Run Identifier        
            repelem(i_trial,length(t_ref_vector))', ...                    % Trial Number
            t_vector', ...                                                 % Time absolute 
            ForceTime', ...                                                % Force absolute 
            t_ref_vector', ...                                             % Time relative to trial start 
            rel_Force', ...                                                % Relative Force (to max and min Force) 
            repelem(AUC_trial,length(t_ref_vector))', ...                  % Area under the Curve (AUC) for Force on this trial
            repelem(norm_by_max_area,length(t_ref_vector))',...            % AUC normalized by max Force
            [buffer'; t_vector_aftBeep'], ...                              % Time absolute (after Beep)
            [buffer'; ForceTime_aftBeep'], ...                             % Force absolute (after Beep)
            [buffer'; t_ref_vector_aftBeep'], ...                          % Time relative to beep end thus bidding start 
            [buffer'; rel_Force_aftBeep'], ...                             % Relative Force after Beep (to max and min Force) 
            repelem(AUC_trial_aftBeep,length(t_ref_vector))', ...          % Area under the Curve (AUC) for Force on this trial after Beep
            repelem(norm_by_max_area_aftBeep,length(t_ref_vector))'];       % AUC normalized by max Force after Beep           

output.variable_labels_effort = {'ID', 'Session', 'Run','Trial', 'Time_Abs','Force_abs','Time_rel_trial','Force_rel','AUC','AUC_normalized','Time_Abs_AftBeep','Force_abs_AftBeep','Time_rel_trial_AftBeep','Force_rel_AftBeep','AUC_AftBeep','AUC_normalized_AftBeep'};

% Clear Variables
i_step = 1;
i_step_aftBeep = 0; %Reset 
t_vector = [];
t_ref_vector = [];
ForceTime = [];
rel_Force = [];
t_vector_aftBeep = []; 
t_vector_befBeep = []; 
t_ref_vector_befBeep = []; 
t_ref_vector_aftBeep = []; 
ForceTime_aftBeep = []; 
Force_max_befBeep = []; 
rel_Force_aftBeep = []; 
rel_Force_befBeep = []; 

