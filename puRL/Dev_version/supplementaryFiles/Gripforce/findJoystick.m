function JoystickSpecification = findJoystick(JoystickSpecification)
% test if specified handle is valid and correct if possible

JoystickMarker = 0;
while JoystickMarker == 0 
    
    if JoystickSpecification.Handle > 50
         error("No controller found.")
    end
    
    try
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] =...
            WinJoystickMex(JoystickSpecification.Handle);
        JoystickMarker =1;
    catch
        JoystickSpecification.Handle = JoystickSpecification.Handle +1;
    end
end

end % end of function findJoystick