function [Result, UpdatedMin, UpdatedMax] = MapJoystickPosition(JoystickPosition, JoystickSpecification, TargetRange)

% Axis    1: foward, backward
%         2: left, right
% TargetRange: [min max]

if(nargin < 2)
	JoystickSpecification.Min    = 0;
	JoystickSpecification.Max    = 65535;
end
if(nargin < 3)
	TargetRange = [0 100];
end

if(JoystickSpecification.Axis == 1)
	TempPosition = JoystickPosition.X;
else
	TempPosition = JoystickPosition.Y;
end

% JoystickSpecification.Centre = mean([JoystickSpecification.Min, JoystickSpecification.Max]);
% 
% % tweak joystick position, imitate MRI joystick:
% % if (0) 
% %     relpos = -(JoystickPosition - 32767);
% %     if (relpos > 0) 
% %        fac = relpos/(65535 - 32767);
% %        newpos = 33500 + fac * (45000 - 33500);
% %     else
% %        fac = -relpos/32767;
% %         newpos = 33500 - fac * (33500 - 20000);
% %     end
% % 
% %     fprintf('%f -> %f\n', JoystickPosition, newpos);
% %     JoystickPosition = newpos;
% % end
% 
% % FlagMRI = 0; %%% for tweak joystick FlagMRI = 0 and if(0) in line 7
% 
% %non-fMRI Compatible Joystick
% 
% % if(FlagMRI == 0)
% %     if(Axis == 1)
% %         JoystickSpecification.Centre = 32767;
% %         JoystickSpecification.Max    = 65535;
% %         JoystickSpecification.Min    = 0;
% %     else
% %         JoystickSpecification.Centre = 32767;
% %         JoystickSpecification.Max    = 65535;
% %         JoystickSpecification.Min    = 0;
% %     end
% % else
%     
%     % % % fMRI Compatible Joystick
%     
% %     if Axis == 1; %X Axis is push pull
% %         JoystickSpecification.Max    = 41100; %41100%43500 DIFF max-centre =11500 IS MINIMUM actually!!!
% %         JoystickSpecification.Centre = 36800; %36800%33500
% %         JoystickSpecification.Min    = 32500; %31900%23500
% %         
% %     else %Y Axis, for rating
% %         JoystickSpecification.Centre = 32500;
% %         JoystickSpecification.Max    = 46000;
% %         JoystickSpecification.Min    = 19000;
% %     end
% end
% 
% posDist = JoystickSpecification.Max - JoystickSpecification.Centre;
% negDist = JoystickSpecification.Centre - JoystickSpecification.Min;
% % JoystickSpecification.Centre = 0;
% 
% position = (JoystickPosition - JoystickSpecification.Centre);
% if(position > 0)
%     position = 100 * (position / posDist);
% else
%     position = 100 * (position / negDist);
% end
% 
% % if FlagMRI == 1
% %     %position = -1 * position;
% %     position = 1 * position;
% % end
% 
% Result = position;

Result = TempPosition;

Result = (Result - JoystickSpecification.Min) / (JoystickSpecification.Max - JoystickSpecification.Min);
Result = Result * (TargetRange(2) - TargetRange(1)) + TargetRange(1);


UpdatedMin = JoystickSpecification.Min;
UpdatedMax = JoystickSpecification.Max;

if(JoystickSpecification.Min > TempPosition) 
	UpdatedMin = TempPosition;
end
if(JoystickSpecification.Max < TempPosition) 
	UpdatedMax = TempPosition;
end
