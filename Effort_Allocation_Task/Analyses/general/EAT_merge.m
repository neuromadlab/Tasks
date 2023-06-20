%%=========================================================================
%
% Script to merge EAT outputs
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
% Take a look at the README for data processing before working with this 
% script the first time or if questions arises!
%
%%=========================================================================

%% preparation

% change directory
cd(files.effort_dir);

% Define Output: Merged Data of all subjects
data.MergedTraining = [];
data.MergedExp = [];

% create array for number of trials with default vals
% 1st value for training
% 2nd value for experiment
experiment.trialnums = [0 0];

%% start of merging process

% different processes for
% 1 = Training
% 2 = Experiment
for runLabel = runLabel_start:2
    
    for i_subj = 1:experiment.N
        
        % print to console for observation
        if verbose
            if runLabel == 1
                sprintf(['MERGE - TRAINING - Subject: ', num2str(i_subj)])
            else
                sprintf(['MERGE - EXP - Subject: ', num2str(i_subj)])
            end
        end
        
        if experiment.data_present(i_subj) == 1
            
            for i_sess = 1 : experiment.N_sessions
                
                % check if for different sessions different settings exist
                % (elsewise always take settins of session 1)
                sess_field = ['S' num2str(i_sess) '_R1'];
                experiment.curr_settings = experiment.S1_R1;
                
                if isfield(experiment, sess_field)
                    experiment.curr_settings = experiment.(sess_field);
                end
                
                
                %% read raw data
                
                if experiment.coding_scheme == 0
                    % creates a string from i_subj in the neuroMADLAB subj coding scheme
                    experiment.subjectID = num2str(i_subj,'%06d');
                    
                elseif experiment.coding_scheme == 9
                    % creates a string from i_subj in the neuroMADLAB subj coding
                    % scheme (with 9 in front)
                    experiment.subjectID = [num2str(9) num2str(i_subj,'%05d')];
                else
                    error('Incorrect coding scheme was chosen. Please rerun EAT_processing.m')
                end
                
                if runLabel == 1

                    cd(files.data_dir);
                    files.searchname = fullfile(files.data_dir, ['TrainEAT_' experiment.paradigm_number '_' experiment.subjectID '*']);
                    files.file = dir(['TrainEAT_' experiment.paradigm_number '_' experiment.subjectID '_S' num2str(i_sess) '*']);
                    
                    % it can happen that less training files than expected
                    % exist
                    if ~isempty(files.file)
                        files.csv_filename = files.file.name;
                    elseif isempty(files.file)
                        continue
                    end
                       
                else
                    
                    cd(files.data_dir);
                    files.searchname = fullfile(files.data_dir, ['ExpEAT_' experiment.paradigm_number '_' experiment.subjectID '*']);
                    files.file = dir(['ExpEAT_' experiment.paradigm_number '_' experiment.subjectID '_S' num2str(i_sess) '*']);
                    
                    % if experimental file is missing, print to console
                    if isempty(files.file)
                        disp(['EXP - The file for subject ' num2str(i_subj) ' and session ' num2str(i_sess) ' was not found!'])
                        continue
                    elseif ~isempty(files.file)
                        files.csv_filename = files.file.name;
                    end
                    
                end

                load(files.csv_filename, 'output');
                cd(files.effort_dir); % needed for unix code
                
                %% output file
                
                % create a table to make code easier to read
                output.values_per_trial_table = array2table(output.data_mat, 'VariableNames', ...
                    {'Subj_ID', ...    % 1
                    'Sess_ID', ...     % 2
                    'Trial_ID', ...    % 3
                    'MaxEffort', ...   % 4
                    'MinEffort',...    % 5
                    'Time_ref', ...    % 6
                    'Effort', ...      % 7
                    'RelEffort', ...   % 8
                    'Diff', ...        % 9
                    'Rew_type', ...    % 10
                    'Rew_mag', ...     % 11
                    'Uncertn', ...     % 12
                    'Win_secs', ...    % 13
                    'Win_points'});    % 14
                
                if runLabel == 1
                    experiment.trialnums(i_sess,runLabel) = max(output.values_per_trial_table.Trial_ID);
                else
                    experiment.trialnums(i_sess,runLabel) = max(output.values_per_trial_table.Trial_ID);
                end
                
                %% RelForce (for old pilot data of TUE003)
                
                if ~ismember('RelEffort',output.values_per_trial_table.Properties.VariableNames)
                    % property of force grip
                    % in resting state, the grip force has this maximum value
                    % the more force is exerted, the smaller the force value gets
                    experiment.restforce = 34000;
                    
                    % relate Force to individual max_Force
                    output.rel_Force = (((experiment.restforce - output.values_per_trial_table.Effort) * 100)./(experiment.restforce - output.values_per_trial_table.MaxEffort));
                    output.rel_Force(output.rel_Force<0) = 0; % fix values where force value was 'larger' than restforce, which make the result come out negative
                    
                    output.values_per_trial_table = addvars(output.values_per_trial_table, output.rel_Force, 'NewVariableNames', 'RelEffort');
                end
                
                %% group and stimulus condition
                
                output.cond_file = [files.groupcond_dir experiment.paradigm_number '_StimCond.mat'];
                
                if exist(output.cond_file, 'file') == 2
                    
                    load(output.cond_file)
                    
                    output.default = ones(height(output.values_per_trial_table),1);
                    
                    if exist('group_vec','var') || exist('cond_table','var')
                        
                        
                        if istable(cond_table) %longformat datatable one row per session with columns for all within (_cond) factors and between (_group) factors
                            
                            
                            %test wether there are also variables for group
                            %assignments (e.g., MDD)
                            
                            conditions = strfind(string(cond_table.Properties.VariableNames),'_group');
                            idx_cond = find(~cellfun(@isempty,conditions));
                            
                            if ~isempty(idx_cond)
                                
                                for i_cond = 1:length(idx_cond)
                                    
                                    group_name = strsplit(cond_table.Properties.VariableNames{idx_cond(i_cond)},'_');
                                    
                                    output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', {[group_name{1},'Group']});
                                    
                                    %value of the current condition column for
                                    %the current ID and session number
                                    output.StimCond_var = cond_table{cond_table.ID==output.values_per_trial_table.Subj_ID(1)&cond_table.Session==output.values_per_trial_table.Sess_ID(1),idx_cond(i_cond)};
                                    
                                    output.values_per_trial_table{:,end} = output.values_per_trial_table{:,end} * output.StimCond_var;
                              
                                    
                                end
                                
                                
                            end
                        
                        elseif isvector(group_vec)
                        output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'Group');
                        
                        % map the subject ID from the group vector onto the subject ID from the output data
                        output.group_var = group_vec((group_vec(:,1) == output.values_per_trial_table.Subj_ID(1)),2);
                        output.values_per_trial_table.Group = output.values_per_trial_table.Group * output.group_var;
                    
                        end
                    end
                    
                    if exist('cond','var')
                        
                        if istable(cond_table) %longformat datatable one row per session with columns for all within (_cond) factors and between (_group) factors
                            
                            %find number and names fo conditions (e.g., stim, caloric etc. Variable ending on _cond)
                            conditions = strfind(string(cond_table.Properties.VariableNames),'_cond');
                            idx_cond = find(~cellfun(@isempty,conditions));
                            
                            %loop through within participant conditions
                            for i_cond = 1:length(idx_cond)
                                
                                cond_name = strsplit(cond_table.Properties.VariableNames{idx_cond(i_cond)},'_'); 
                                
                                output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', {[cond_name{1},'Cond']});
                                
                                %value of the current condition column for
                                %the current ID and session number
                                output.StimCond_var = cond_table{cond_table.ID==output.values_per_trial_table.Subj_ID(1)&cond_table.Session==output.values_per_trial_table.Sess_ID(1),idx_cond(i_cond)};
                                
                                output.values_per_trial_table{:,end} = output.values_per_trial_table{:,end} * output.StimCond_var;
                                
                                
                            end
                            
                            %test wether there are also variables for group
                            %assignments (e.g., MDD)
                            
%                             conditions = strfind(string(cond_table.Properties.VariableNames),'_group');
%                             idx_cond = find(~cellfun(@isempty,conditions));
%                             
%                             if ~isempty(idx_cond)
%                                 
%                                 for i_cond = 1:length(idx_cond)
%                                     
%                                     group_name = strsplit(cond_table.Properties.VariableNames{idx_cond(i_cond)},'_');
%                                     
%                                     output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', {[cond_name{1},'Group']});
%                                     
%                                     %value of the current condition column for
%                                     %the current ID and session number
%                                     output.StimCond_var = cond_table{cond_table.ID==output.values_per_trial_table.Subj_ID(1)&cond_table.Session==output.values_per_trial_table.Sess_ID(1),idx_cond(i_cond)};
%                                     
%                                     output.values_per_trial_table.StimCond = output.values_per_trial_table.StimCond * output.StimCond_var;
%                                     
%                                     
%                                 end
%                                 
%                                 
%                             end
                                                       
                        elseif ismatrix('cond')
                            
                            output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'StimCond');
                            
                            % 2nd column: condition in 1st session
                            % 3rd column: condition in 2nd session
                            output.StimCond_var = cond((cond(:,1) == output.values_per_trial_table.Subj_ID(1)), ...    % row (subject)
                                output.values_per_trial_table.Sess_ID(1) + 1);                                              % column (session)
                            
                            output.values_per_trial_table.StimCond = output.values_per_trial_table.StimCond * output.StimCond_var;
                            
                        end
                        
                    else
                        disp('No stimulus conditions found. Is that correct?')
                        disp('')
                        disp(['If the file is missing mistakenly, please add as' files.groupcond_dir experiment.paradigm_number '_StimCond.mat'])
                    end
                else
                    disp('No stimulus conditions found. Is that correct?')
                    disp('')
                    disp(['If the file is missing mistakenly, please add as' files.groupcond_dir experiment.paradigm_number '_StimCond.mat'])
                end
                
                %% VAS ratings
                if experiment.curr_settings.settings.do_VAS
                    % if existent, then:
                    % 1st column -  subject ID
                    % 2nd column -  Rating exhaustion
                    % 3rd column -  Rating wanting
                    % 4th column -  Rating happy 1
                    % 5th column -  Rating happy 2
                    
                    % default values
                    output.r_exh = false;
                    output.r_want = false;
                    output.r_hap1 = false;
                    output.r_hap2 = false;
                    output.default = ones(height(output.values_per_trial_table),1);
                    
                    % this is messy due to different output structures for
                    % different TUE studies.. probably it can be shortened
                    if isfield(output, 'VAS_per_trial')
                        % NaN if question not asked
                        
                        output.VAS = output.VAS_per_trial;
                        output.VAS = output.VAS';
                        
                        % R_Exh
                        if ~isnan(output.VAS(1,2))
                            output.r_exh = true;
                            output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'R_Exh');
                        end
                        
                        % R_Want
                        if ~isnan(output.VAS(1,3))
                            output.r_want = true;
                            output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'R_Want');
                        end
                        
                        % R_hap1
                        if ~isnan(output.VAS(1,4))
                            output.r_hap1 = true;
                            output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'R_Hap1');
                        end
                        
                        % R_hap2
                        if ~isnan(output.VAS(1,5))
                            output.r_hap2 = true;
                            output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'R_Hap2');
                        end
                        
                    elseif isfield(output, 'rating')
                        
                        if isfield(output.rating, 'all_VAS')
                            % non-existent column if question not asked
                            
                            output.VAS = output.rating.all_VAS;
                            
                            if length(output.rating.all_VAS(1,:)) > 1
                                output.r_exh = true;
                                output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'R_Exh');
                            end
                            
                            if length(output.rating.all_VAS(1,:)) > 2
                                output.r_want = true;
                                output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'R_Want');
                            end
                            
                            if length(output.rating.all_VAS(1,:)) > 3
                                output.r_hap1 = true;
                                output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'R_Hap1');
                            end
                            
                            if length(output.rating.all_VAS(1,:)) > 4
                                output.r_hap2 = true;
                                output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'R_Hap2');
                            end
                        end
                    else
                        
                        if isfield(output, 'rating_exhaustion')
                            output.r_exh = true;
                            output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'R_Exh');
                            
                            output.VAS(:,1) = [1:experiment.trialnums(i_sess,runLabel)];
                            output.VAS(:,2) = transpose(output.rating_exhaustion);
                        end
                        
                        if isfield(output, 'rating_wanting')
                            output.r_want = true;
                            output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'R_Want');
                            
                            output.VAS(:,1) = [1:experiment.trialnums(i_sess,runLabel)];
                            output.VAS(:,3) = transpose(output.rating_wanting);
                        end
                        
                        if isfield(output, 'rating_happy')
                            output.r_hap1 = true;
                            output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'R_Hap1');
                            
                            output.VAS(:,1) = [1:experiment.trialnums(i_sess,runLabel)];
                            output.VAS(:,4) = transpose(output.rating_happy);
                        end
                        
                        if isfield(output, 'rating_happy2')
                            output.r_hap2 = true;
                            output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'R_Hap2');
                            
                            output.VAS(:,1) = [1:experiment.trialnums(i_sess,runLabel)];
                            output.VAS(:,5) = transpose(output.rating_happy2);
                        end                        
                    end
                    
                    if isfield(output, 'VAS')
                        for i_trial = 1:experiment.trialnums(i_sess,runLabel)
                            
                            % read out VAS per trial
                            output.VAS_trial = output.VAS(output.VAS(:,1) == i_trial,:);
                            
                            % save answers depending on trial
                            %
                            if output.r_exh
                                output.r_exh_trial = output.VAS_trial(:,2);
                                output.values_per_trial_table.R_Exh(output.values_per_trial_table.Trial_ID == i_trial) = ...
                                    output.values_per_trial_table.R_Exh(output.values_per_trial_table.Trial_ID == i_trial) * output.r_exh_trial;
                            end
                            
                            if output.r_want
                                output.r_want_trial = output.VAS_trial(:,3);
                                output.values_per_trial_table.R_Want(output.values_per_trial_table.Trial_ID == i_trial) = ...
                                    output.values_per_trial_table.R_Want(output.values_per_trial_table.Trial_ID == i_trial) * output.r_want_trial;
                            end
                            
                            if output.r_hap1
                                output.r_hap1_trial = output.VAS_trial(:,4);
                                output.values_per_trial_table.R_Hap1(output.values_per_trial_table.Trial_ID == i_trial) = ...
                                    output.values_per_trial_table.R_Hap1(output.values_per_trial_table.Trial_ID == i_trial) * output.r_hap1_trial;
                            end
                            
                            if output.r_hap2
                                output.r_hap2_trial = output.VAS_trial(:,5);
                                output.values_per_trial_table.R_Hap2(output.values_per_trial_table.Trial_ID == i_trial) = ...
                                    output.values_per_trial_table.R_Hap2(output.values_per_trial_table.Trial_ID == i_trial) * output.r_hap2_trial;
                            end
                        end
                    end
                end
                
                %% WoF winnings
                
                if experiment.curr_settings.settings.do_WOF
                    
                    output.default = zeros(height(output.values_per_trial_table),1);
                    output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'WoF_win');
                    output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'WoF_dist');
                    
                    % check for different naming
                    if isfield(output.wof, 'win_amnt')
                        
                        % 1st row is WoF of training
                        % WoF was displayed 12 times during + 1 time directly after
                        % the experiment = 13 WoF values
                        % => 14 rows
                        
                        if runLabel == 1
                            
                            % make a new matrix with all information needed
                            output.wof.raw(1,2) = output.wof.win_amnt(1,1);
                            
                            % WoF is shown after all training trials
                            output.wof.raw(1,1) = 8;
                            
                        elseif runLabel == 2
                            
                            % make a new matrix with all information needed
                            output.wof.raw(:,2) = output.wof.win_amnt(2:end,1);
                            
                            % saving the respective trial numbers to the WoF win
                            output.wof.raw(:,1) = [1, 7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 72];
                        end
                    
                    elseif isfield(output.wof, 'scores')
                        
                        % in the 2nd column the final win is saved
                        % WoF was displayed 12 times during + 1 time directly after
                        % the experiment = 13 WoF values
                        output.wof.raw(:,2) = transpose(output.wof.scores(5,:));
                
                        % saving the respective trial numbers to the WoF win
                        output.wof.raw(:,1) = transpose(output.wof.scores(2,:));
                        
                    end
                    
                    % for training, no distance to last WoF can be saved,
                    % but the WoF_win after all training trials is saved
                    if runLabel == 1
                        
                        output.values_per_trial_table.WoF_win = repmat(output.wof.raw(1,2), height(output.values_per_trial_table),1);
                        output.values_per_trial_table.WoF_dist = NaN(height(output.values_per_trial_table),1);
                        
                    elseif runLabel == 2
                        % t saves the idx in output.wof.raw of the next WoF win
                        t = 2;
                        
                        % run through trials and save WoF win
                        % WoF win is saved in trial data as long as no new WoF
                        % was shown, example: win before trial 1 is shown in
                        % trial 1, 2, ..., 6
                        for i_trial = 1:experiment.trialnums(runLabel)
                            
                            if i_trial == output.wof.raw(t,1)
                                
                                t = t + 1;
                                
                            end
                            
                            % save WoF win
                            output.values_per_trial_table.WoF_win(output.values_per_trial_table.Trial_ID == i_trial) ...
                                = repelem(output.wof.raw(t - 1,2), length(output.values_per_trial_table.WoF_win(output.values_per_trial_table.Trial_ID == i_trial)));
                            
                            % save distance to last WoF win
                            d = i_trial - output.wof.raw(t-1,1);
                            output.values_per_trial_table.WoF_dist(output.values_per_trial_table.Trial_ID == i_trial) ...
                                = repelem(d, length(output.values_per_trial_table.WoF_win(output.values_per_trial_table.Trial_ID == i_trial)));
                        end
                        
                    end
                end
                
                clearvars t
                
                %% derivations over time
                
                % for absolute and then relative Effort at timepoint
                
                % first add columns which save the results
                output.default = zeros(height(output.values_per_trial_table),1);
                output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'Rel_Dev1');
                output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'Rel_Dev2');
                output.values_per_trial_table = addvars(output.values_per_trial_table, output.default, 'NewVariableNames', 'Rel_Int');
                
                % extract data per subject and compute diff over time series
                % compare to current Dev1
                output.values_per_trial_table.Rel_Dev1 = [0; diff(output.values_per_trial_table.RelEffort)];
                output.values_per_trial_table.Rel_Dev2 = [0; 0; diff(output.values_per_trial_table.RelEffort,2)];
                output.values_per_trial_table.Rel_Int = cumtrapz(output.values_per_trial_table.Time_ref, output.values_per_trial_table.RelEffort);
                
                % concatenate subject data to output file
                if runLabel == 1
                    % correct for missing columns
                    output.values_per_trial_table = add_missing_columns(output.values_per_trial_table, data.MergedTraining);
                    
                    % concatenate
                    data.MergedTraining = vertcat(data.MergedTraining, output.values_per_trial_table);
                else
                    
                    % correct for missing columns
                    output.values_per_trial_table = add_missing_columns(output.values_per_trial_table, data.MergedExp);
                    
                    % concatenate
                    data.MergedExp = vertcat(data.MergedExp, output.values_per_trial_table);
                end
                
                clearvars input output subj conditions cond group_vex add_before default_clmn curr_idx missing_columns
            end
        end
    end
end

% save the minimum difficulty for segmentation
experiment.min_diff = min(data.MergedExp.Diff);

%% end and saving of merging process

cd(files.file_dir)
if process_training
    if experiment.coding_scheme == 9
        data.MergedTraining.Subj_ID = mod(data.MergedTraining.Subj_ID,900000);
    end

    if ~isempty(data.MergedTraining)
        savedata(['EAT_' experiment.paradigm_number '_Train_Merg'], data.MergedTraining, files.data_dir) 
    end
    cd(files.file_dir)
end

if experiment.coding_scheme == 9
    data.MergedExp.Subj_ID = mod(data.MergedExp.Subj_ID,900000);
end

savedata(['EAT_' experiment.paradigm_number '_Exp_Merg'], data.MergedExp, files.data_dir);

cd(files.effort_dir)

%% helper functions
%
function t = add_missing_columns(t, t_comp)

% TUE002: in some sessions VAS was not filled out,
% correct for that (tables need to have same amount of
% columns!)
if ~isempty(t_comp)
    if length(t_comp.Properties.VariableNames) ~= length(t.Properties.VariableNames)
        
        % check which columns are missing in table
        missing_columns = setdiff(t_comp.Properties.VariableNames, t.Properties.VariableNames, 'stable');
        
        % add missing columns at the correct place
        for i = 1:length(missing_columns)
            
            % find out index where column has to be added
            curr_idx = find(cellfun(@(x) strcmp(x, missing_columns{i}), t_comp.Properties.VariableNames));
            
            % table can't add by index, find out how the
            % column is named which has to be shifted
            add_before = t.Properties.VariableNames{curr_idx};
            
            % create NaN column for the missing column
            default_clmn = NaN(size(t,1),1);
            
            % add column with correct name at correct place
            t = addvars(t,default_clmn,...
                'Before',add_before,...
                'NewVariableNames',t_comp.Properties.VariableNames{curr_idx});
        end
    end
end
end