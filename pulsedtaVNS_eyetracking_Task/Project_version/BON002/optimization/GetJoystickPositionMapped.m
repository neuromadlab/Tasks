function TempPosition = GetJoystickPositionMapped(JoystickSpecification, TargetRange)

[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
TempPosition = MapJoystickPosition(Joystick, JoystickSpecification, TargetRange);
