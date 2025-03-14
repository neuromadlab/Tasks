% Actual traing trial star (recortstart time)
value_column = find(strcmp('rating_value',output.data_labels(:,1)));
valueL_column = find(strcmp('rating_value_left',output.data_labels(:,1)));
valueR_column = find(strcmp('rating_value_right',output.data_labels(:,1)));
submission_column = find(strcmp('rating_submitted',output.data_labels(:,1)));

t_collectMax_onset = GetSecs;
onset_start = 0; % flag to indicate if time of first flip was logged

% Start trial at rest force
% ForceMat = restforce;
ForceMatR = restforceR;
ForceMatL = restforceL;

while (timing.responding_time  > (GetSecs - t_collectMax_onset))
    % Draw graphical display (reduced version without threshold)

    % Draw Tube
    Screen('DrawLine',w,color_scale_anchors,(x_cent-Tube.width/2), Tube.height, (x_cent-Tube.width/2), (wh-Tube.offset),6);
    Screen('DrawLine',w,color_scale_anchors,(x_cent+Tube.width/2), Tube.height, (x_cent+Tube.width/2), (wh-Tube.offset),6);
    Screen('DrawLine',w,color_scale_anchors,(x_cent-Tube.width/2), (wh-Tube.offset), (x_cent+Tube.width/2), (wh-Tube.offset),6);
    %Screen('CopyWindow',w,w);

    % Draw upper bound blue line
    % LowerBoundBar - height at which the bar starts when ForceMat = restforce
    % BarBound2ScaleR -  a scale-factor between range of tube and force.right
    % ForceMat - the last measured force (maximum of left & right)
    if (ForceMatR > restforceR) || (ForceMatL > restforceL)
%         Boundary_yposition = LowerBoundBar - BarBound2ScaleR*(ForceMat - restforceR);
        Boundary_ypositionR = LowerBoundBar - BarBound2ScaleR*(ForceMatR - restforceR);
        Boundary_ypositionL = LowerBoundBar - BarBound2ScaleL*(ForceMatL - restforceL);
        Boundary_yposition = min(Boundary_ypositionR, Boundary_ypositionL); % the minimum is a "higher" position on screen
    else
        Boundary_yposition = LowerBoundBar;
    end

    Screen('DrawLine',w,ball_color,(x_cent-Tube.width/2),Boundary_yposition, (x_cent+Tube.width/2), Boundary_yposition,3);

    % Draw Ball
    Ball.position = [(x_cent-Ball.width/2) (Boundary_yposition) (x_cent+Ball.width/2) (Boundary_yposition + Ball.width)];
    Ball.color = ball_color;
    Screen('FillOval',w,Ball.color,Ball.position);

    % For first flip, track time
    if onset_start == 0
        [ons_resp, starttime] = Screen('Flip', w);
        onset_start = 1;
    else
        Screen('Flip', w);
    end

    % Conditional input

    % Log Force

    if settings.do_fmri ~= 1
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    else
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec);
    end
    gripforce_valueL = Joystick.X;
    gripforce_valueR = Joystick.Y;
    gripforce_value = max(Joystick.X, Joystick.Y);

    % Getting values from Grip Force Device -> Joystick.Y
%     ForceMat = gripforce_value;
    ForceMatR = gripforce_valueR;
    ForceMatL = gripforce_valueL;

    % Saving force over time by adding the current ForceMat to ForceTime at every
    % step

    ForceTime = [ForceTime, gripforce_value];
    ForceTimeL = [ForceTimeL, gripforce_valueL];
    ForceTimeR = [ForceTimeR, gripforce_valueR];

    % Store for timestamps and actual force every 100ms
    t_step = GetSecs;
    t_vector(1,i_step) = t_step;
    i_step = i_step + 1;

end

t_ref_vector = t_vector - t_collectMax_onset;
%Relative effort
%     rel_Force = (((input_device.minEffort - ForceTime) * 100)./(input_device.minEffort - ones(1,length(ForceTime))*input_device.maxEffort));
rel_ForceL = (((ForceTimeL - input_device.minEffortL) * 100)./(ones(1,length(ForceTimeL))*input_device.maxEffortL - input_device.minEffortL));
rel_ForceR = (((ForceTimeR - input_device.minEffortR) * 100)./(ones(1,length(ForceTimeR))*input_device.maxEffortR - input_device.minEffortR));
rel_Force = max(rel_ForceL, rel_ForceR);

% determine output
values = [t_ref_vector ; ...              %time referenced to 10 second trial start
    rel_Force]';                    %Maximum Force in 10seconds-trial

valuesL = [t_ref_vector ; ...              %time referenced to 10 second trial start
    rel_ForceL]';                   %Maximum Force in 10seconds-trial left

valuesR = [t_ref_vector ; ...              %time referenced to 10 second trial start
    rel_ForceR]';                   %Maximum Force in 10seconds-trial right


% determine output

% Bidding offer: Variant 1) averaging force across last 2 seconds
%     indexes_last_x_sec = values(1,:) >= timing.last_secs_counted;
%     force_last_x_sec = values(2,indexes_last_x_sec);
%     average_force_end = mean(force_last_x_sec);

% Bidding offer: Variant 2) Last entry in force vector
average_force_end = values(end,2); % these are average values [0-100](%) of the applied force (last entry)
average_forceL_end = valuesL(end,2);
average_forceR_end = valuesR(end,2);

output.data(i_trial,value_column)  = average_force_end;
output.data(i_trial,valueL_column)  = average_forceL_end;
output.data(i_trial,valueR_column)  = average_forceR_end;
output.data(i_trial,submission_column)  = NaN;
% timestamps.durations.scales.all(i_trial,1) = NaN;

% add to data of possible previous trials a column with the current
% trial-number, a column with timestamps and a column with relative
% force-values
output.rel_force = [output.rel_force;...
    [ones(length(values),1)*i_trial,values]];
output.rel_forceL = [output.rel_forceL;...
    [ones(length(valuesL),1)*i_trial,valuesL]];
output.rel_forceR = [output.rel_forceR;...
    [ones(length(valuesR),1)*i_trial,valuesR]];
% do the same for the raw force-values
output.raw_forceL = [output.raw_forceL;
    [ones(length(values),1)*i_trial, t_ref_vector', ForceTimeL' ]];
output.raw_forceR = [output.raw_forceR;
    [ones(length(values),1)*i_trial, t_ref_vector', ForceTimeR' ]];

% clear variables
i_step = 1;
t_vector = [];
t_ref_vector = [];
values = [];
valuesL = [];
valuesR = [];
ForceTime = [];
ForceTimeL = [];
ForceTimeR = [];
rel_Force = [];
rel_ForceL = [];
rel_ForceR = [];