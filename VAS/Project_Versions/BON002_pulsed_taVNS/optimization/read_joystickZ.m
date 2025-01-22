count = 1;
onset = GetSecs;
while (GetSecs - onset) < 10
    
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    posZ(count) = Joystick.Z;
    count = count +1;
end