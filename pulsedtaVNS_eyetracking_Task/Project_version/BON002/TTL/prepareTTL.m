function sp = prepareTTL(comX, BaudRate, trigDur)
% Opens the port "comX" with the "BaudRate" and stores "trigDur" as
% duration for triggers in future sendTTL commands.
% It also tests the device and creates & stores the handle.
sp = TTL('prepareTTL', comX, BaudRate, trigDur);
end %----------------------------------------------------------------------