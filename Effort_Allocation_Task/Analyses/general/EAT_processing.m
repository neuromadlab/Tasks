%%=========================================================================
%
% Script to process EAT outputs
%
% for force and frequency data
% data will be merged, smoothed, and segmented
%
% Written by Monja Neuser, Nov 2017,
% adapted by Mechteld, Jan 2019,
% adapted by Wiebke Ringels, September 2020
%
% the workspace contains different struct with different information:
%
% output        raw data (output) from the experiment
% data          processed data that is the output from this file
% files         everything that is needed to save the data to files
% plotting      everything that is needed to plot the data
% smoothing     everything that is needed to smooth force data
% segmentation  everything that is needed to segment the data
%
% If something is unclear, there exists a README for this data processing
% script
%
%%=========================================================================

% clearing workspace except for the loaded settings
clearvars -except keepVariables experiment files process_training runLabel_start save_settings verbose

%% user-specific pathes
%
% OS-specific settings
files.dir_sep = char((isunix)*'/'+(ispc)*'\');

% effort directory (two directories up)
cd ..; cd ..;
files.effort_dir = pwd;

% creating user-specific pathes
files.file_dir = [files.effort_dir feval(files.file_suffix)];
files.data_dir = [files.effort_dir feval(files.data_suffix)];
files.project_dir = [files.effort_dir feval(files.project_suffix)];
files.groupcond_dir = [files.effort_dir feval(files.groupcond_suffix)];

%% automized settings (user-specific)
%
% get study identifier
experiment.study_id = str2double(strrep(experiment.paradigm_number,'TUE',''));

% depending on data type (exp vs pilot), coding scheme of files is chosen
if experiment.exp_data == 1
    
   experiment.coding_scheme = 0;
   experiment.pilot_data = 0;
   
elseif experiment.exp_data == 0
    
    experiment.coding_scheme = 9;
    experiment.pilot_data = 1;
    
    % pilot data is in a subfolder, i.e. updata data path
    files.data_dir = [files.data_dir files.dir_sep 'pilot' files.dir_sep];
end

% if training data is processed, set variable for segmentation script
if process_training
    runLabel_start = 1;
else
    runLabel_start = 2;
end

%% read out from data directory (user-specific)
%
cd(files.data_dir)
exp_files = struct2table(dir(['ExpEAT_' experiment.paradigm_number '_*']));

% read out number of runs
run_files = exp_files;

% the 26th character in the string is the number of the run
run_files.name = cellfun(@(x) str2num(x(26)), run_files.name);

% save number of runs
experiment.N_runs = max(run_files.name);



% read out number of sessions
sess_files = exp_files;

% the 23th character in the string is the number of the session
sess_files.name = cellfun(@(x) str2num(x(23)), sess_files.name);

% save number of sessions
experiment.N_sessions = max(sess_files.name);



% read out number of participants
participant_files = exp_files;

% the 15-20th characters in the string define the participant number
participant_files.name = cellfun(@(x) str2num(x(15:20)), participant_files.name);

% check for pilot data
if experiment.exp_data == 0
    participant_files.name = participant_files.name - 900000;
end

% save number of participants
experiment.N = max(participant_files.name);



% define which participants' data are not existent
experiment.data_present = ones(1,experiment.N);
participants = unique(participant_files.name,'rows');

for i = 1:experiment.N
   
    if ~ismember(i,participants)
        
        experiment.data_present(i) = 0;
        
    end 
end

%% manual data exclusion
%
% specify in the beginning which participants must be excluded
experiment.data_present(experiment.excluded_id)=0;

%% settings file for specific project (user-specific)
%
if experiment.study_id == 1
    
    error('Condition files for study TUE001 unknown');
    
elseif experiment.study_id == 2
    
    experiment.S1_R1 = load([files.project_dir files.dir_sep 'Session1' files.dir_sep 'EATmain' files.dir_sep 'TUE002_S1_Settings.mat']);
    experiment.S2_R1 = load([files.project_dir files.dir_sep 'Session2' files.dir_sep 'EATsettings_TUE002_S2_R1.mat']);
   
elseif experiment.study_id == 4
    
    experiment.S1_R1 = load([files.project_dir files.dir_sep 'TUE004_Settings.mat']);
    
% for newest study, the generic name is (should be) used
elseif experiment.study_id == 3 || experiment.study_id >= 5
    
    for i = 1:experiment.N_sessions
        for j = 1:experiment.N_runs
            
            sess_field = ['S' num2str(i) '_R' num2str(j)];
            experiment.(sess_field) = load([files.project_dir files.dir_sep 'EATsettings_' experiment.paradigm_number '_S' num2str(i) '_R' num2str(j) '.mat']);
        end
    end
end

%% Merge and Segment
%
disp('')
disp('START')
cd(files.file_dir);

% frequency data
if experiment.S1_R1.settings.do_gamepad
    
    % for frequency data, merge and segment
    disp('')
    disp('Merging...')
    EAT_merge
    
    disp('')
    disp('Segmenting...')
    cd(files.file_dir)
    EAT_segmentation_frequency
    
% force data
elseif ~experiment.S1_R1.settings.do_gamepad
    
    % for force data, merge, smooth, and segment
    disp('')
    disp('Merging...')
    EAT_merge
    
    disp('')
    disp('Smoothing...')
    cd(files.file_dir)
    EAT_smoothing_force_data
    
    disp('')
    disp('Segmenting...')
    cd(files.file_dir)
    EAT_segmentation_force
    
else
    error('You chose an incorrect data type.');
end

disp('')
disp('')
disp('DONE')
    