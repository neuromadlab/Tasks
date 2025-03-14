%% This script has to be run at the beginning of the S3 experiment!
% We have 2 sessions consisting of a EAT training and an EAT experiment 
% each but both S2 Experiment and S3 Experiment use the S2 Training data
% for max effort input. Thus this script is necessary to check of the S2
% training data is locally available on the current laptop. If npt, the
% script extracts the S2 training data from NAS. Of course only if NAS has
% succesfully updated.

% RUN ONLY BEFORE S3

clear

subjID = input("Subject ID: ", 's');

% Find path of local data
path_data = [pwd filesep 'data'];

% Find path of training EAT data in NAS
path_NAS_TrainEAT = [extractBefore(pwd, 'Desktop') 'SynologyDrive' filesep ...
    'Tasks' filesep 'Effort' filesep 'Data' filesep 'TUE008_updated' filesep ...
    'Training'];

% If training data from S2 is NOT there, copy it from NAS into the data local folder 
if ~isfile([path_data filesep 'TrainEAT_TUE008_' subjID '_S2_R1.mat'])
    copyfile([path_NAS_TrainEAT filesep 'TrainEAT_TUE008_' subjID '_S2_R1.mat'], path_data) 
end

    
