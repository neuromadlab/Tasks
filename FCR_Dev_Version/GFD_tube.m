% Actual traing trial star (recortstart time)
t_collectMax_onset = GetSecs;
onset_start = 0;

ForceTime = []; %matrix that saves force over time
gripforce_value = restforce;
t_vector = [];
t_ref_vector = [];
rel_Force = [];
    
while (timing.responding_time  > (GetSecs - t_collectMax_onset))   
    
        % Draw graphical display (reduced version without threshold)

        % Draw Tube
        Screen('DrawLine',w,color_scale_anchors,(x_cent-Tube.width/2), Tube.height, (x_cent-Tube.width/2), (wh-Tube.offset),6);
        Screen('DrawLine',w,color_scale_anchors,(x_cent+Tube.width/2), Tube.height, (x_cent+Tube.width/2), (wh-Tube.offset),6);
        Screen('DrawLine',w,color_scale_anchors,(x_cent-Tube.width/2), (wh-Tube.offset), (x_cent+Tube.width/2), (wh-Tube.offset),6);

         % Draw upper bound blue line
         if gripforce_value < restforce

             Boundary_yposition = ((LowerBoundBar - UpperBoundBar)/delta_pos_force) * gripforce_value + UpperBoundBar - (maxpossibleforce * (LowerBoundBar - UpperBoundBar)/delta_pos_force);

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

        % Saving force over time by adding the current ForceMat to ForceTime at every
        % step
        ForceTime = [ForceTime, gripforce_value]; 

        % Store for timestamps and actual force every 100ms
        t_vector = [t_vector, GetSecs];

end

t_ref_vector = t_vector - t_collectMax_onset; 
%Relative effort
rel_Force = (((input_device.minForce - ForceTime) * 100)./(input_device.minForce - ones(1,length(ForceTime))*input_device.maxForce));

% determine output
rating.GFD = [t_ref_vector ; ...              %time referenced to 10 second trial start
          rel_Force]';                     %Maximum Force in 10seconds-trial

% determine output
% Bidding offer: Last entry in force vector
rating.value = rel_Force(end);
rating.subm = NaN;
rating.RT = NaN;
     