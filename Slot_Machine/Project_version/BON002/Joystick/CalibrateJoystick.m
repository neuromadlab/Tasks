TempAxis	= input('Axis (1/2): ');
TempHandle	= input('Port [0..4]: ');

ListenChar(2);
KbName('UnifyKeyNames'); % need this for KbName to behave

JoystickSpecification.Min			= 0;
JoystickSpecification.Max			= 0;
JoystickSpecification.Axis			= TempAxis;		% X and Y axices of the Joystick. 
JoystickSpecification.Handle		= TempHandle;	% In some cases (e.g. two joysticks are connected) this value must be set to 1. 

fprintf('\n');
while(KbCheck); end

fprintf('Please move the joystick to both extreme positions and then \npay attention to the Mapped value.\nThis value must change between -100 and +100!\n');
fprintf('You can also check the buttons!\n');
fprintf('Press Esc key to end the calibration!\n');

fprintf('\n');
fprintf('X: %5d, Y: %5d, Mapped: %+4d, Key Pressed: %d', 0, 0, 0, 0);
while(1)
	[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification.Handle);
	
	if(KbCheck)
		[FlagKeyDown, secs, KeyCode] = KbCheck;
		if(strcmpi(KbName(KeyCode), 'Escape'))
			break;
		end
		if(strcmpi(KbName(KeyCode), 'Return'))
			while(KbCheck); end
			
			fprintf('\n');
			fprintf('X: %5d, Y: %5d, Mapped: %+4d, Key Pressed: %d', 0, 0, 0, 0);
		end
	end
	
	[TempMappedPosition, JoystickSpecification.Min, JoystickSpecification.Max] = ...
		MapJoystickPosition(Joystick, JoystickSpecification, [-100 100]);

	TempString = sprintf('X: %5d, Y: %5d, Mapped: %+4d, Key Pressed: %d', Joystick.X, Joystick.Y, round(TempMappedPosition), any(Joystick.Button));
	for CountBackspace = 1:length(TempString)
		fprintf('\b');
	end
	fprintf('%s', TempString);
	WaitSecs(0.1);

end

fprintf('\n');
fprintf('\n');

ListenChar(0);

disp('Calibration is finished!');
FlagSave = input('Would you like to save (y/n): ', 's');
if(strcmpi(FlagSave, 'y'))
	save JoystickSpecification JoystickSpecification
	disp('Calibration data SAVED!');
else
	disp('Calibration data IGNORED!');
end
