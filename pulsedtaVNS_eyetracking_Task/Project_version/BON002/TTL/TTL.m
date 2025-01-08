function sp = TTL(mode, comX, BaudRate, trigDur, msg, throwError)
% This function is the main-hub for handling the TTL box from 
% "The Black Box Toolkit". For easy usage, the handle for the serial port 
% and the trigger-duration are stored as persistent settings & there exist
% wrapper functions.
% Thus, we don't need to give the handle for each single "send".
% First you need to prepare the TTL box, then you can send data throughout
% your experiment, at the end you need to close the TTL box.
% See the docu of the wrapper functions for more detailed info.
persistent settings
if isempty(settings)
    settings.sp = -1;       % handle to serial port
    settings.trigDur = 0.05;% pulse-duration for sending triggers
end

if strcmp(mode, 'prepareTTL')
    try
        sp = IOPort('OpenSerialPort', comX, ...
            ['BaudRate=' num2str(BaudRate)]);
        IOPort('Write', sp, 'RR'); % reset lines

        % check the choosen port
        IOPort('Write', sp, '##');      % check/ping
        data = IOPort('Read', sp, 1, 2);% receive answer
        if strcmp(char(data), 'XX')     % compare answer with expectation
            disp('TTL box ready')
            settings.sp = sp;           % save handle
            settings.trigDur = trigDur; % save trigger duration
        else
            disp(' ')
            disp('Check comX settings.')
            IOPort('Close', sp) % release port
            error('TTL box not ready, wrong port?')
        end
    catch ME
        warning('preparation of trigger port failed')
        rethrow(ME)
    end

elseif strcmp(mode, 'sendTTL')
    try
        IOPort('Write', settings.sp, dec2hex(msg, 2));
        pause(settings.trigDur)
        IOPort('Write', settings.sp, dec2hex(0, 2));
    catch ME
        warning(['sending trigger failed : ' msg])
        if throwError
            IOPort('Close', settings.sp) % release port
            rethrow(ME)
        end
    end
    
elseif strcmp(mode, 'closeTTL')
    try
        IOPort('Write', settings.sp,'RR');   % reset lines
        IOPort('Close', settings.sp)         % release port
    catch ME
        warning('Closing port failed!')
        IOPort('Close', settings.sp) % release port, simply try again
        rethrow(ME)
    end
end

end %----------------------------------------------------------------------