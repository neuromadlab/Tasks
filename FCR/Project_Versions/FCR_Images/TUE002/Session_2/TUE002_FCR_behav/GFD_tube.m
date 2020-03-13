% Actual traing trial star (recortstart time)
        t_collectMax_onset = GetSecs;
        onset_start = 0;

        while (timing.responding_time  > (GetSecs - t_collectMax_onset))   
             % Draw graphical display (reduced version without threshold)

            % Draw Tube
            Screen('DrawLine',w,color_scale_anchors,(x_cent-Tube.width/2), Tube.height, (x_cent-Tube.width/2), (wh-Tube.offset),6);
            Screen('DrawLine',w,color_scale_anchors,(x_cent+Tube.width/2), Tube.height, (x_cent+Tube.width/2), (wh-Tube.offset),6);
            Screen('DrawLine',w,color_scale_anchors,(x_cent-Tube.width/2), (wh-Tube.offset), (x_cent+Tube.width/2), (wh-Tube.offset),6);
            %Screen('CopyWindow',w,w);

             % Draw upper bound blue line

             if ForceMat < restforce

                 Boundary_yposition = ((LowerBoundBar - UpperBoundBar)/delta_pos_force) * ForceMat + UpperBoundBar - (maxpossibleforce * (LowerBoundBar - UpperBoundBar)/delta_pos_force);

             else

                 Boundary_yposition = (wh-Tube.offset-Ball.width);

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

            if (debug == 1 && settings.do_fmri == 1) || settings.do_fmri ~= 1
               [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec);
            else
               [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            end
            gripforce_value = Joystick.Y;

            % Getting values from Grip Force Device -> Joystick.Y
            ForceMat = gripforce_value;

            % Saving force over time by adding the current ForceMat to ForceTime at every
            % step

            ForceTime = [ForceTime, gripforce_value]; 

            % Store for timestamps and actual force every 100ms
            t_step = GetSecs;
            t_vector(1,i_step) = t_step;
            i_step = i_step + 1;

    end

    t_ref_vector = t_vector - t_collectMax_onset; 
    %Relative effort
    rel_Force = (((input_device.minEffort - ForceTime) * 100)./(input_device.minEffort - ones(1,length(ForceTime))*input_device.maxEffort));

    % determine output
    values = [t_ref_vector ; ...              %time referenced to 10 second trial start
              rel_Force]';                     %Maximum Force in 10seconds-trial

% determine output
    
% Bidding offer: Variant 1) averaging force across last 2 seconds
%     indexes_last_x_sec = values(1,:) >= timing.last_secs_counted;                     
%     force_last_x_sec = values(2,indexes_last_x_sec);
%     average_force_end = mean(force_last_x_sec);

% Bidding offer: Variant 2) Last entry in force vector
 average_force_end = values(end,2);

 output.rating.value(i_trial,1) = average_force_end;
 output.rating.subm(i_trial,1) = NaN;
% timestamps.durations.scales.all(i_trial,1) = NaN;
 
 output.rel_force = [output.rel_force;...
                    [ones(length(values),1)*i_trial,values]];

    % clear variables
    i_step = 1; 
    t_vector = [];
    t_ref_vector = [];
    values = [];
    ForceTime = [];
    rel_Force = [];