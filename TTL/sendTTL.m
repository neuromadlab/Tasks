function sendTTL(msg, throwError)
% Sends the message "msg" (mandatory 2 chars) to the TTL box. If throwErrow
% is not == 1, then there will be no error if the device fails; the
% experiment proceeds, possibly after a timeout.
if nargin == 1
    throwError = 0;
end
TTL('sendTTL', [],[],[], msg, throwError);
end %----------------------------------------------------------------------