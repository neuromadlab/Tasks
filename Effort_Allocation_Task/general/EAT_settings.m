%%=========================================================================
%
% Script to create settings for EAT data processing
%
% for force and frequency data
%
% Written by Wiebke Ringels, November 2020
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

%% SET THESE VARIABLES DUE TO YOUR NEEDS
%
% these variables can either be set manually here or set by interacting
% with the console

% if experimental data (i.e. no pilot data) set to 1, if pilot data set to 0
experiment.exp_data = 1;

% if you want to process training data as well, set to 1
process_training = 0;

% save paradigm name as string
experiment.paradigm_number = 'TUE003';

% participants where just some parts of data exist because data collection
% is ongoing must be excluded manually
experiment.excluded_id = [];
%experiment.excluded_id = 55:60;

%% THE FOLLOWING SETTINGS WILL BE SET AUTOMATICALLY
% 
%

%% default variables
%
verbose = 1;
save_settings = 1;

%% interaction with console (if wished)
%
console = -1;
while ~(console == 0 || console == 1)
    console = input('Do you want to set the settings by interacting with the console? [0 = no, 1 = yes] ');    
    
    if ~(console == 0 || console == 1)
        error('Please choose one of the valid options');
    end
end

if console
    
    experiment.exp_data = -1;
    while ~(experiment.exp_data == 0 || experiment.exp_data == 1)
        experiment.exp_data = input('Experimental or pilot data?  [0 = pilot, 1 = experimental] ');
        
        if ~(experiment.exp_data == 0 || experiment.exp_data == 1)
            error('Please choose one of the valid options');
        end
        
    end
    
    % process training data? 0 = no, 1 = yes
    process_training = -1;
    while ~(process_training == 0 || process_training == 1)
        process_training = input('Process training data?  [0 = no, 1 = yes] ');
        
        if ~(process_training == 0 || process_training == 1)
            error('Please choose one of the valid options');
        end
        
    end
    
    % define paradigm number
    experiment.paradigm_number = -1;
    while ~(ischar(experiment.paradigm_number) && startsWith(experiment.paradigm_number, 'TUE'))
        experiment.paradigm_number = input('Please enter the paradigm number. [example: TUE004] ', 's');
        
        if ~(ischar(experiment.paradigm_number) && startsWith(experiment.paradigm_number, 'TUE'))
            error('Please enter a correct paradigm number.');
        end
    end
end

%% project and non-userspecific data pathes
%
% create functions for each path suffix so that in user-specific part the
% correct file separator is chosen automatically

% where to find this script
files.file_suffix = @()([char((isunix)*'/'+(ispc)*'\')...
                         'Analyses' ...
                         char((isunix)*'/'+(ispc)*'\')...
                         'general'...
                         char((isunix)*'/'+(ispc)*'\')]);

% directory with raw data
files.data_suffix = @()([char((isunix)*'/'+(ispc)*'\')...
                         'Data'... 
                         char((isunix)*'/'+(ispc)*'\')... 
                         experiment.paradigm_number... 
                         char((isunix)*'/'+(ispc)*'\')]);

% project directory (with project specific settings file)
files.project_suffix = @()([char((isunix)*'/'+(ispc)*'\')...
                            'Project_Versions'...
                            char((isunix)*'/'+(ispc)*'\')...
                            experiment.paradigm_number...
                            char((isunix)*'/'+(ispc)*'\')]);

% directory with group condition files (not every study has a group condition file!)
files.groupcond_suffix = @()([char((isunix)*'/'+(ispc)*'\')...
                         'Analyses' ...
                         char((isunix)*'/'+(ispc)*'\')...
                         experiment.paradigm_number...
                         char((isunix)*'/'+(ispc)*'\')]);

%% participant exclusion
%
if console
    
    % check which participants should be excluded from processing
    experiment.exclusion_ongoing = input('Do you want to exclude participants from processing? [0 = no, 1 = yes] ');
    
    while experiment.exclusion_ongoing
        
        experiment.excluded_id = input('Which participant do you want to exclude? (Format: [id1,id2,...,idn])');
        
        for i = 1:length(experiment.excluded_id)
            
            if i > experiment.N
                error('You entered a participant number that was larger than the total number of participants. This input was skipped.')
            else
                experiment.data_present(1,experiment.excluded_id(i)) = 0;
                disp(['Participant ' num2str(experiment.excluded_id(i)) ' successfully excluded']);
            end
        end
        
        experiment.exclusion_ongoing = input('Do you want to exclude further participants from analysis? [0 = no, 1 = yes] ');
    end
end

%% save to file
%
clearvars participants participant_files sess_files run_files i j console exp_files sess_field


cd ..;
cd(experiment.paradigm_number);
if save_settings
    save([experiment.paradigm_number '_processing_settings_' datestr(now, 'yyyymmdd') '.mat'])
    
    disp('')
    disp('Settings saved')
end