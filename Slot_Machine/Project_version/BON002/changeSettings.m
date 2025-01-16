% Author: Paul Jung
% Mail  : jung.science@web.de
% Date  : 14.03.2024
% 
% this script lets you change some of the settings in the setup-file
% "BON002_setup.mat".

function changeSettings % start independent workspace

load('BON002_setup.mat') %#ok<LOAD> 

% general settings
settings.debug          = 0;
settings.do_fullscreen  = 0; % 0 for a smaller debug screen
settings.lang_de        = 1;
settings.do_food        = 0;
settings.do_fmri        = 0; % 1 if testing inside MRI

SMsettings.settings = settings; %#ok<STRNU> 
clear settings trigger

save('BON002_setup.mat')

end %----------------------------------------------------------------------
