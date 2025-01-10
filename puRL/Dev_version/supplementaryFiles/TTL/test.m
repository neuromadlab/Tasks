clear
clc

trigDur = 1.5; % duration for sending triggers in seconds
settings.EGG.trigger.movie_on_baseline = 10; % trigger code for Baseline movie on
settings.EGG.trigger.movie_end_baseline = 20; % trigger code for Baseline movie off
expStartCode    = 1;
expEndCode      = 255;

prepareTTL('COM5', 115200, trigDur);

pause(5)
sendTTL(expStartCode, 1) % throws error if fails
pause(2)
sendTTL(settings.EGG.trigger.movie_on_baseline)
pause(2)
sendTTL(settings.EGG.trigger.movie_end_baseline)
pause(2)
sendTTL(expEndCode)

closeTTL()