function [Response ResponseTime] = GetJoystickButton(JoystickSpecification, Delay)

if((nargin < 2) || (Delay == 99))
    Delay = Inf;
end

[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
while(any(Joystick.Button))
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
%     WaitSecs(0.05);
end

TempTimeBegin = GetSecs;
while(GetSecs - TempTimeBegin < Delay)
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
    
    if(any(Joystick.Button))
        break;
    end
end

Response = Joystick.Button;
ResponseTime = GetSecs - TempTimeBegin;

while(any(Joystick.Button))
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
%     WaitSecs(0.05);
end
