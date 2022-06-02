function [grip_force_idx,grip_force_axis] = Initialize_CD_GripForce

    % Find indices of devices registered as Current Designs 932
    count = 1;
    for gp_idx = 1:Gamepad('GetNumGamepads')

       if strcmp(Gamepad('GetGamepadNamesFromIndices', gp_idx),'Current Designs, Inc. 932')

          gamepad_num_options(count) = gp_idx;
          count = count + 1;

       end

    end

    % Find index of device with 5 axis -> contains axis of interest
    for gp_idx = 1:length(gamepad_num_options)

       if Gamepad('GetNumAxes', gamepad_num_options(gp_idx)) == 5

          grip_force_idx =  gamepad_num_options(gp_idx);

       end

    end

    % Set grip force axis to 4
    grip_force_axis = 4;

end