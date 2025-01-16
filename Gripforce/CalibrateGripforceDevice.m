% This script calibrates a two-handed gripforce device for MRI
TempHandle	= input('Port [0..4]: ');

ListenChar(2);
KbName('UnifyKeyNames'); % need this for KbName to behave

GripFSpec.Handle	= TempHandle;
GripFSpec.MinL		= 0; % minimum value of the left gripforce device
GripFSpec.MaxL		= 0;
GripFSpec.MinR      = 0; % minimum value of the right gripforce device
GripFSpec.MaxR      = 0;
targetRange         = [0 100];


fprintf('\n');
while(KbCheck); end

fprintf([ ...
    'Please press the left & right gripforce device alternating and \n' ...
    'pay attention to the Mapped values.\n' ...
    'These values must change between 0 and +100!\n']);
fprintf('Press Esc key to end the calibration!\n');

fprintf('\n');
formatString = 'X: %5d, Y: %5d, MappedLeft: %+4d, MappedRight: %+4d';
fprintf(formatString, 0, 0, 0, 0);
while(1)
    % poll the current state of the gripforce devices:
	[GripFDev.X, GripFDev.Y] = WinJoystickMex(GripFSpec.Handle);
	
	if(KbCheck) % check if an abort of the print-queue is requested
		[FlagKeyDown, secs, KeyCode] = KbCheck;
		if(strcmpi(KbName(KeyCode), 'Escape')) % abort the print-queue
			break;
		end
		if(strcmpi(KbName(KeyCode), 'Return')) % create a new line
			while(KbCheck); end
			fprintf('\n');
			fprintf(formatString, 0, 0, 0, 0);
		end
	end
	
    [ResultL, ResultR, GripFSpec] = MapGripforcePosition( ...
        GripFDev, GripFSpec, targetRange); % map values to target-range

	TempString = sprintf(formatString, ...
        GripFDev.X, GripFDev.Y, round(ResultL), round(ResultR));

	for CountBackspace = 1:length(TempString)
		fprintf('\b'); % delete the last printed line...
	end
	fprintf('%s', TempString); %... to replace it with a new
	WaitSecs(0.1);

end

fprintf('\n');
fprintf('\n');

ListenChar(0);

disp('Calibration is finished!');
FlagSave = input('Would you like to save (y/n): ', 's');
if(strcmpi(FlagSave, 'y'))
	save GripforceSpec GripFSpec
	disp('Calibration data SAVED!');
else
	disp('Calibration data IGNORED!');
end
%--------------------------------------------------------------------------
