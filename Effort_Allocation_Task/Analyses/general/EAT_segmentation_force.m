%%=========================================================================
%
% Segmentation of EAT force data
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
% A lot of steps are described there very detailed
%
%%=========================================================================

%% preparation

% property of force grip
% in resting state, the grip force has this maximum value
% the more force is exerted, the smaller the force value gets
experiment.restforce = 34000;

% Define Output: Merged Data of all subjects
data.MergedTraining_time_seg = array2table([]);
data.MergedExp_time_seg = array2table([]);

% save invigorations slope during segmentation for faster plotting
plotting.Inv_Slope = cell2table(cell(0,7), 'VariableNames', {'Subj_ID', 'Sess_ID', 'Trial_ID', 'X1', 'X2', 'Y1', 'Y2'});

% compute standard deviation
if process_training
    % compute standard deviation of relative force derivative (needed for segmentation)
    segmentation.std_train = std(data.MergedTraining.Rel_Dev1);
    if any(cellfun(@(x) isequal(x,'STD'), data.MergedTraining.Properties.VariableNames))
        data.MergedTraining.STD = repmat(segmentation.std_train, height(data.MergedTraining),1);
    else
        data.MergedTraining = addvars(data.MergedTraining, repmat(segmentation.std_train, height(data.MergedTraining),1), 'NewVariableNames', 'STD');
    end
end

segmentation.std = std(data.MergedExp.Rel_Dev1);
if any(cellfun(@(x) isequal(x,'STD'), data.MergedExp.Properties.VariableNames))
    data.MergedExp.STD = repmat(segmentation.std, height(data.MergedExp),1);
else
    data.MergedExp = addvars(data.MergedExp, repmat(segmentation.std, height(data.MergedExp),1), 'NewVariableNames', 'STD');
end

%% settings segmentation
% number of entries in window (including current row, i.e. size is 18)
% this window is used to see into the future how the slope changes
segmentation.changeinterval.Windowsize = 17;

% the change in the window must be at least multiplicator * std to detect
% changes from work to rest
segmentation.changeinterval.multiplicator = 5;

%% start segmentation process

for runLabel = runLabel_start:2

    %% read data
    
    if runLabel == 1

        segmentation.data = data.MergedTraining;
    else

        segmentation.data = data.MergedExp;
    end

    for i_subj = 1:experiment.N
        
        % print to console for observation
        if verbose
            if runLabel == 1
                sprintf(['SEGMENT - TRAINING - Subject: ', num2str(i_subj)])
            else
                sprintf(['SEGMENT - EXP - Subject: ', num2str(i_subj)])
            end
        end
        
        if experiment.data_present(i_subj) == 1
         
            % extract data from only one subject, all trials both sessions
            segmentation.subj_data = segmentation.data(segmentation.data.Subj_ID == i_subj,:);
            
            for i_sess = 1 : experiment.N_sessions
                
                if runLabel == 1
                    experiment.trialnum = experiment.trialnums(i_sess,1);
                else
                    experiment.trialnum = experiment.trialnums(i_sess,2);
                end

                
                % extract data from only one session
                segmentation.sess_data = segmentation.subj_data(segmentation.subj_data.Sess_ID == i_sess,:);
                
                % it happens that training data is missing
                if runLabel == 1 && isempty(segmentation.sess_data)
                    continue
                elseif runLabel == 2 && isempty(segmentation.sess_data)
                    disp(['EXP - Session ' i_sess ' for subject ' i_subj ' not processed!'])
                    continue
                end                
            
                %% trial-wise segmentation
                
                % initialize variables that store information about segments
                segmentation.work_flag = zeros(height(segmentation.sess_data),1);
                segmentation.i_segment = ones(height(segmentation.sess_data),1);
                segmentation.i_vline = zeros(height(segmentation.sess_data),1);
                segmentation.comingk_D_Freq = zeros(height(segmentation.sess_data),1);
                segmentation.comingk_rf = repmat(zeros(1,segmentation.changeinterval.Windowsize + 1),height(segmentation.sess_data),1);
                
                % add default columns to table
                segmentation.sess_data = addvars(segmentation.sess_data, segmentation.work_flag, 'NewVariableNames', 'Work');
                segmentation.sess_data = addvars(segmentation.sess_data, segmentation.i_segment, 'NewVariableNames', 'Seg');
                segmentation.sess_data = addvars(segmentation.sess_data, segmentation.i_vline, 'NewVariableNames', 'V_line');
                segmentation.sess_data = addvars(segmentation.sess_data, segmentation.comingk_D_Freq, 'NewVariableNames', 'Com10D1F');
                segmentation.sess_data = addvars(segmentation.sess_data, segmentation.i_segment, 'NewVariableNames', 'T_Work');
                segmentation.sess_data = addvars(segmentation.sess_data, segmentation.i_segment, 'NewVariableNames', 'T_Rest');
                segmentation.sess_data = addvars(segmentation.sess_data, segmentation.work_flag, 'NewVariableNames', 'Work_Prog');
                segmentation.sess_data = addvars(segmentation.sess_data, segmentation.work_flag, 'NewVariableNames', 'Rest_Prog');
                segmentation.sess_data = addvars(segmentation.sess_data, segmentation.work_flag, 'NewVariableNames', 'Work_Ons');
                segmentation.sess_data = addvars(segmentation.sess_data, segmentation.work_flag, 'NewVariableNames', 'Rest_Ons');
                segmentation.sess_data = addvars(segmentation.sess_data, segmentation.work_flag, 'NewVariableNames', 'T_Lat');

                for i_trial = 1: experiment.trialnum
                    
                    % latency is a trial measure, i.e. saving whether
                    % latency was already found in this trial
                    segmentation.found_latency = false;
                    
                    % extract data from one trial
                    segmentation.trial_data = segmentation.sess_data(segmentation.sess_data.Trial_ID == i_trial,:);
                    
                    % routine for one Trial: fill trial_data with info about segments
                    for i_row = 1 : height(segmentation.trial_data)
                        
                        % checking latency until minimul difficulty to get a reward is reached
                        if (i_row > 1 && segmentation.trial_data.RelEffort(i_row) > experiment.min_diff && segmentation.trial_data.RelEffort(i_row - 1) < experiment.min_diff && ~segmentation.found_latency) ...
                            || (i_row == 1 && segmentation.trial_data.RelEffort(i_row) > experiment.min_diff && ~segmentation.found_latency)
                            segmentation.trial_data.T_Lat(i_row) = 1;
                            segmentation.found_latency = true;
                        end

                        % determine current state of sliding window
                        % for coming work segment
                        if i_row + segmentation.changeinterval.Windowsize <= height(segmentation.trial_data)
                            i_movesum = [i_row, i_row + segmentation.changeinterval.Windowsize];
                        else
                            i_movesum = [i_row, height(segmentation.trial_data)];
                        end
                        
                        % sum up values from coming timepoints (-> changeinterval.Windowsize)
                        % including current cell
                        segmentation.comingk = (segmentation.trial_data.Rel_Dev1(i_movesum(1):i_movesum(2)));
                        segmentation.trial_data.Com10D1F(i_row) =  sum(segmentation.comingk);
                        
                        % save from coming timepoints the RelEffort
                        segmentation.comingk_rf = (segmentation.trial_data.RelEffort(i_movesum(1):i_movesum(2)));
                        
                        if i_row > 1
                            
                            % in case the change from rest to work did not directly
                            % happen, check it now (look below for computational
                            % details)
                            if segmentation.trial_data.Work_Ons(i_row - 1)
                                
                                % continue the search
                                segmentation.trial_data.Work_Prog(i_row) = 1;
                                segmentation.trial_data.Work_Ons(i_row) = 1;
                                
                                % in case the change happens due to the other
                                % conditions
                                if segmentation.trial_data.Work(i_row - 1) == 1
                                    segmentation.trial_data.T_Work(i_row) = 1;
                                    segmentation.trial_data.Work_Prog(i_row) = 0;
                                    segmentation.trial_data.Work_Ons(i_row) = 0;
                                end
                                
                                % in case a work onset was already found
                                if segmentation.trial_data.T_Work (i_row - 1) ~= 1
                                    
                                    % remember the time point of work onset
                                    segmentation.trial_data.T_Work(i_row) = segmentation.trial_data.T_Work(i_row - 1);
                                    
                                    segmentation.trial_data.T_Work(i_row) = 1;
                                    segmentation.trial_data.Work_Prog(i_row) = 0;
                                    segmentation.trial_data.Work_Ons(i_row) = 0;
                                end
                                
                                % if still a change should be done
                                if segmentation.trial_data.Work_Ons(i_row)
                                    
                                    % all of the next segments must be larger to
                                    % save this timepoint as beginning of the next
                                    % work segment
                                    if ~any(segmentation.comingk_rf < segmentation.trial_data.RelEffort(i_row))
                                        
                                        segmentation.trial_data.Work_Ons(i_row) = 0;
                                        segmentation.trial_data.T_Work(i_row) = i_row;
                                        
                                    else
                                        
                                        % if no change happens here, continue segment
                                        segmentation.trial_data.Work(i_row) = segmentation.trial_data.Work(i_row - 1);
                                    end
                                end
                                
                                % in case the change from work to rest did not directly
                                % happen, check it now
                            elseif segmentation.trial_data.Rest_Ons(i_row - 1)
                                
                                % continue the search
                                segmentation.trial_data.Rest_Ons(i_row) = 1;
                                segmentation.trial_data.Rest_Prog(i_row) = 1;
                                
                                % in case the change happens due to the other
                                % conditions
                                if segmentation.trial_data.Work(i_row - 1) == 0
                                    segmentation.trial_data.T_Rest(i_row) = 1;
                                    segmentation.trial_data.Rest_Prog(i_row) = 0;
                                    segmentation.trial_data.Rest_Ons(i_row) = 0;
                                end
                                
                                % in case a rest onset was already found
                                if segmentation.trial_data.T_Rest (i_row - 1) ~= 1
                                    
                                    % remember the time point of work onset
                                    segmentation.trial_data.T_Rest(i_row) = segmentation.trial_data.T_Rest(i_row - 1);
                                    
                                    segmentation.trial_data.T_Rest(i_row) = 1;
                                    segmentation.trial_data.Rest_Prog(i_row) = 0;
                                    segmentation.trial_data.Rest_Ons(i_row) = 0;
                                end
                                
                                % if still a change should be done
                                if segmentation.trial_data.Rest_Ons(i_row)
                                    
                                    % all of the next segments must be smaller to
                                    % change this time point as beginning of next
                                    % rest segment
                                    if ~any(segmentation.comingk_rf > segmentation.trial_data.RelEffort(i_row))
                                        
                                        segmentation.trial_data.Rest_Ons(i_row) = 0;
                                        segmentation.trial_data.T_Rest(i_row) = i_row;
                                        
                                    else
                                        
                                        % if no change happens here, continue segment
                                        segmentation.trial_data.Work(i_row) = segmentation.trial_data.Work(i_row - 1);
                                    end
                                    
                                end
                                
                            elseif segmentation.trial_data.Work_Prog(i_row - 1)
                                
                                % remember the time point of work onset
                                segmentation.trial_data.T_Work(i_row) = segmentation.trial_data.T_Work(i_row - 1);
                                
                                % continue search
                                segmentation.trial_data.Work_Prog(i_row) = 1;
                                
                                if segmentation.trial_data.RelEffort(i_row) >= 50
                                    
                                    % if the work segment really reaches the 50%
                                    % threshold, then the change is fulfilled
                                    idc_onset = segmentation.trial_data.T_Work(i_row);
                                    segmentation.trial_data.Work(idc_onset:i_row,:) = 1;
                                    
                                    % overwrite segment number as well
                                    if segmentation.trial_data.Work(idc_onset - 1) == 1
                                        segmentation.trial_data.Seg(idc_onset:i_row,:) = segmentation.trial_data.Seg(idc_onset - 1);
                                    else
                                        segmentation.trial_data.Seg(idc_onset:i_row,:) = segmentation.trial_data.Seg(idc_onset - 1) + 1;
                                    end
                                    
                                    % reset everything
                                    segmentation.trial_data.T_Work(i_row) = 1;
                                    segmentation.trial_data.Work_Prog(i_row) = 0;
                                    segmentation.trial_data.Work_Ons(i_row) = 0;
                                    
                                    % if nearly no change occurs in the next time
                                    % steps, i.e. a plateau below the threshold was
                                    % reached, stop searching
                                elseif abs(segmentation.trial_data.Com10D1F(i_row)) < 1
                                    
                                    segmentation.trial_data.Work(i_row) = segmentation.trial_data.Work(i_row - 1);
                                    segmentation.trial_data.T_Work(i_row) = 1;
                                    segmentation.trial_data.Work_Prog(i_row) = 0;
                                    segmentation.trial_data.Work_Ons(i_row) = 0;
                                    
                                else
                                    % if no change happens here, continue segment
                                    segmentation.trial_data.Work(i_row) = segmentation.trial_data.Work(i_row - 1);
                                end
                                
                            elseif segmentation.trial_data.Rest_Prog(i_row -1)
                                
                                % remember the time point of rest onset
                                segmentation.trial_data.T_Rest(i_row) = segmentation.trial_data.T_Rest(i_row - 1);
                                
                                % continue search
                                segmentation.trial_data.Rest_Prog(i_row) = 1;
                                
                                if segmentation.trial_data.RelEffort(i_row) < 50
                                    
                                    % if the rest segment really reaches the 50%
                                    % threshold, then the change is fulfilled
                                    idc_onset = segmentation.trial_data.T_Rest(i_row);
                                    segmentation.trial_data.Work(idc_onset:i_row,:) = 0;
                                    
                                    % overwrite segment number as well (in case
                                    % it is a new segment)
                                    if segmentation.trial_data.Work(idc_onset - 1) == 0
                                        segmentation.trial_data.Seg(idc_onset:i_row,:) = segmentation.trial_data.Seg(idc_onset - 1);
                                    else
                                        segmentation.trial_data.Seg(idc_onset:i_row,:) = segmentation.trial_data.Seg(idc_onset - 1) + 1;
                                    end
                                    
                                    % reset everything
                                    segmentation.trial_data.T_Rest(i_row) = 1;
                                    segmentation.trial_data.Rest_Prog(i_row) = 0;
                                    segmentation.trial_data.Rest_Ons(i_row) = 0;
                                    
                                    % if nearly no change occurs in the next time
                                    % steps, i.e. a plateau below the threshold was
                                    % reached, stop searching
                                elseif abs(segmentation.trial_data.Com10D1F(i_row)) < 1
                                    
                                    segmentation.trial_data.Work(i_row) = segmentation.trial_data.Work(i_row - 1);
                                    segmentation.trial_data.T_Rest(i_row) = 1;
                                    segmentation.trial_data.Rest_Prog(i_row) = 0;
                                    segmentation.trial_data.Rest_Ons(i_row) = 0;
                                    
                                else
                                    
                                    % if no change happens here, continue segment
                                    segmentation.trial_data.Work(i_row) = segmentation.trial_data.Work(i_row - 1);
                                end
                            end
                        end
                        
                        % main if for work
                        % check the "big picture", i.e. in which time
                        % window is a change from rest to work
                        %
                        % only check for changes to work if last segment
                        % was not already a work segment (in this case, the
                        % work segment is continued automatically if no
                        % change to rest is registered)
                        if segmentation.trial_data.Com10D1F(i_row) > segmentation.changeinterval.multiplicator * segmentation.trial_data.STD(i_row) && ...
                                ((i_row == 1) || ...
                                (i_row ~= 1 && segmentation.trial_data.Work_Prog(i_row - 1) ~= 1 && ...
                                (segmentation.trial_data.Work(i_row - 1) ~= 1 || ...
                                segmentation.trial_data.Rest_Prog(i_row) == 1))) % even if it is still a work segment, if the code is searching
                            % for a rest segment, it should stop searching if a strong increasing slope appears
                            
                            % now check the details, i.e. where exactly is the
                            % change from rest to work
                            segmentation.trial_data.Work_Ons(i_row) = 1;
                            segmentation.trial_data.Work_Prog(i_row) = 1;
                            
                            % stop searching for a rest segment
                            segmentation.trial_data.Rest_Ons(i_row) = 0;
                            segmentation.trial_data.Rest_Prog(i_row) = 0;
                            segmentation.trial_data.T_Rest(i_row) = 1;
                            
                            % assumption: work onset is never directly here!
                            % if RelEffort starts to increase, work is set to 1
                            if i_row > 1
                                
                                % all of the next segments must be larger to
                                % save this timepoint as beginning of the next
                                % work segment
                                if ~any(segmentation.comingk_rf < segmentation.trial_data.RelEffort(i_row))
                                    
                                    segmentation.trial_data.Work_Ons(i_row) = 0;
                                    segmentation.trial_data.T_Work(i_row) = i_row;
                                    
                                    % overwrite other progresses in case of a change
                                    segmentation.trial_data.Rest_Ons(i_row) = 0;
                                    
                                    % continue last segment
                                    segmentation.trial_data.Work(i_row) = segmentation.trial_data.Work(i_row - 1);
                                    
                                    % if change to work does not occur immediately,
                                    % continue with last segment
                                else
                                    segmentation.trial_data.Work(i_row) = segmentation.trial_data.Work(i_row - 1);
                                end
                                
                            elseif (i_row == 1 && segmentation.trial_data.RelEffort(i_row) >= 50)
                                
                                segmentation.trial_data.Work(i_row) = 1;
                                
                                segmentation.trial_data.Work_Ons(i_row) = 0;
                                segmentation.trial_data.Work_Prog(i_row) = 0;
                            end
                            
                        elseif i_row <= 10 && segmentation.trial_data.RelEffort(i_row) >= 50 && ...
                                (~(segmentation.trial_data.Com10D1F(i_row) < -segmentation.changeinterval.multiplicator * segmentation.trial_data.STD(i_row)) ...
                                || (any(segmentation.comingk_rf(2:end) > 50) && segmentation.comingk_rf(end) > 50)) % do not include current row!
                            
                            segmentation.trial_data.Work(i_row) = 1;
                            
                            % overwrite all other progresses in case of
                            % a change
                            segmentation.trial_data.T_Work(i_row) = 1;
                            segmentation.trial_data.Work_Prog(i_row) = 0;
                            segmentation.trial_data.Work_Ons(i_row) = 0;
                            segmentation.trial_data.T_Rest(i_row) = 1;
                            segmentation.trial_data.Rest_Prog(i_row) = 0;
                            segmentation.trial_data.Rest_Ons(i_row) = 0;
                            
                            % main if for rest
                            % check the "big picture", i.e. in which time
                            % window is a change from work to rest
                            %
                            % only check for changes to rest if last segment
                            % was not already a rest segment (in this case, the
                            % rest segment is continued automatically if no
                            % change to work is registered)
                        elseif segmentation.trial_data.Com10D1F(i_row) < -segmentation.changeinterval.multiplicator * segmentation.trial_data.STD(i_row) && ... % this first part applies for aprupt changes from work to rest
                                ((i_row == 1) || (i_row ~= 1 && segmentation.trial_data.Rest_Prog(i_row - 1) ~= 1 && ...
                                (segmentation.trial_data.Work(i_row - 1) ~= 0 || ...
                                segmentation.trial_data.Work_Ons(i_row) == 1))) % even if it is still a rest segment, if the code is searching
                            % for a work segment, it should stop searching if a strong decreasing slope appears
                            
                            % now check the details, i.e. where exactly is the
                            % change from work to rest
                            segmentation.trial_data.Rest_Ons(i_row) = 1;
                            segmentation.trial_data.Rest_Prog(i_row) = 1;
                            
                            % stop searching for a work segment
                            segmentation.trial_data.Work_Ons(i_row) = 0;
                            segmentation.trial_data.Work_Prog(i_row) = 0;
                            segmentation.trial_data.T_Work(i_row) = 1;
                            
                            % if RelEffort starts to decrease, work is set to 1
                            if i_row > 1
                                
                                % all of the next segments must be smaller to
                                % change this time point as beginning of next
                                % rest segment
                                if ~any(segmentation.comingk_rf > segmentation.trial_data.RelEffort(i_row))
                                    
                                    segmentation.trial_data.Rest_Ons(i_row) = 0;
                                    segmentation.trial_data.T_Rest(i_row) = i_row;
                                    
                                    % overwrite other progresses in case of a change
                                    segmentation.trial_data.Work_Ons(i_row) = 0;
                                    
                                    % continue last segment
                                    segmentation.trial_data.Work(i_row) = segmentation.trial_data.Work(i_row - 1);
                                    
                                    % if change to rest does not occur immediately,
                                    % continue with last segment
                                else
                                    segmentation.trial_data.Work(i_row) = segmentation.trial_data.Work(i_row - 1);
                                end
                            end
                            
                            % if no change in segment (i.e. no onset pause or
                            % effort), then just take work value from previous
                            % segment
                        elseif i_row > 1
                            segmentation.trial_data.Work(i_row) = segmentation.trial_data.Work(i_row - 1);
                        end
                        
                        % frame status of Work with previous data points
                        if i_row > 1
                            if segmentation.trial_data.Work(i_row) ~= segmentation.trial_data.Work(i_row - 1)
                                
                                segmentation.trial_data.Seg(i_row) = segmentation.trial_data.Seg(i_row - 1) + 1;
                                segmentation.trial_data.V_line(i_row) = 1;
                            else
                                
                                segmentation.trial_data.Seg(i_row) = segmentation.trial_data.Seg(i_row - 1);
                                segmentation.trial_data.V_line(i_row) = 0;
                            end
                        end
                    end
                    
                    %% computations for each segment

                    % add default columns to table
                    segmentation.default = repmat(-1, height(segmentation.trial_data),1);
                    segmentation.trial_data = addvars(segmentation.trial_data, segmentation.default, 'NewVariableNames', 'S_Length');
                    segmentation.trial_data = addvars(segmentation.trial_data, segmentation.default, 'NewVariableNames', 'S_AUC');
                    segmentation.trial_data = addvars(segmentation.trial_data, segmentation.default, 'NewVariableNames', 'S_Slope');
                    segmentation.trial_data = addvars(segmentation.trial_data, segmentation.default, 'NewVariableNames', 'S_InvSlope');
                    
                    % extract number of segments from one trial
                    segmentation.trial.seg_num = segmentation.trial_data.Seg(end);
                    
                    % run through all segments
                    for i_seg_num = 1 : segmentation.trial.seg_num
                        
                        % cut segment
                        segmentation.segment.data = segmentation.trial_data(segmentation.trial_data.Seg == i_seg_num,:);
                        
                        % store data from timepoint before
                        if i_seg_num > 1
                            segmentation.segment.tprev = segmentation.trial_data(segmentation.trial_data.Seg == i_seg_num-1,:);
                            segmentation.segment.tprev = segmentation.segment.tprev(end,:);
                        end
                        
                        %% S_Length (Duration)
                        
                        segmentation.segment.duration = segmentation.segment.data.Time_ref(end)-segmentation.segment.data.Time_ref(1);
                        
                        %% S_AUC (Area under Curve)
                        
                        if height(segmentation.segment.data) > 1
                            
                            segmentation.segment.X = segmentation.segment.data.Time_ref(1:end);
                            segmentation.segment.Y = segmentation.segment.data.RelEffort(1:end);
                            
                            segmentation.segment.AUC = cumtrapz(segmentation.segment.X,segmentation.segment.Y);
                            
                        else
                            
                            segmentation.segment.AUC = 0;
                            
                        end
                        
                        %% Slope
                        
                        % slope computed over whole segment
                        segmentation.segment.ampDiff = segmentation.segment.data.RelEffort(end) - segmentation.segment.data.RelEffort(1);
                        segmentation.segment.slope = segmentation.segment.ampDiff / segmentation.segment.duration;
                        
                        
                        %% Invigoration slope
                        % slope computed only from start of increasing phase
                        % until the maximum amplitude is reached
                        segmentation.segment.invigo_done = 0;
                        
                        % in case the first segment is already a work segment,
                        % set default values
                        if i_seg_num == 1
                            segmentation.segment.lastPauseSegment_t = 0;
                            segmentation.segment.lastPauseSegment_RelEffort = 0;
                            
                            segmentation.segment.invigoY1 = 0;
                            segmentation.segment.invigoY2 = 0;
                            segmentation.segment.invigoX1 = 0;
                            segmentation.segment.invigoX2 = 0;
                        end
                        
                        if segmentation.segment.data.Work(1) == 0
                            % as long as the current segment is a pause
                            % segment, this variable tracks of its time_Ref
                            segmentation.segment.lastPauseSegment_t = segmentation.segment.data.Time_ref(end);
                            segmentation.segment.lastPauseSegment_RelEffort = segmentation.segment.data.RelEffort(end);
                            
                            % default values before first effort element is found
                            segmentation.segment.invigo_slope = NaN;
                            
                        % no slope can be computed!
                        elseif length(segmentation.segment.data.RelEffort) < 2 && i_seg_num == 1
                            
                            segmentation.segment.invigo_slope = NaN;
                            
                        % Select effort segments
                        elseif segmentation.segment.data.Work(1) == 1 && ~segmentation.segment.invigo_done
                            
                            % Find first local maximum in effort segment
                            if length(segmentation.segment.data.RelEffort) > 2
                                
                                segmentation.segment.work_peaks = findpeaks(segmentation.segment.data.RelEffort);
                                
                            else
                                
                                segmentation.segment.work_peaks = [];
                                
                            end

                            % If no clear peak, take inital point of plateau
                            if isempty(segmentation.segment.work_peaks) || ~any(segmentation.segment.work_peaks > 50)
                                
                                %   start plateau
                                segmentation.segment.plateau = segmentation.segment.data((segmentation.segment.data.Rel_Dev2 == 0),:);
                                
                                if isempty (segmentation.segment.plateau)
                                    
                                    % find maximum and its indice
                                    [segmentation.segment.first_peak, segmentation.segment.first_peak_i] = max(segmentation.segment.data.RelEffort);
                                    % read out time of maximum
                                    segmentation.segment.first_peak_t = segmentation.segment.data.Time_ref(segmentation.segment.first_peak_i);
                                    
                                    if i_seg_num > 1
                                        
                                        segmentation.segment.invigoY1 = segmentation.segment.lastPauseSegment_RelEffort;
                                        segmentation.segment.invigoY2 = segmentation.segment.first_peak;
                                        segmentation.segment.invigoX1 = segmentation.segment.lastPauseSegment_t;
                                        segmentation.segment.invigoX2 = segmentation.segment.first_peak_t;
                                        
                                        segmentation.segment.invigo_slope = (segmentation.segment.invigoY2 - segmentation.segment.invigoY1)/ ...
                                            (segmentation.segment.invigoX2 - segmentation.segment.invigoX1);
                                        
                                        % save to output for plotting
                                        if runLabel == 2
                                            plotting.new_entry = {i_subj, i_sess, i_trial, segmentation.segment.invigoX1, segmentation.segment.invigoX2, ...
                                                segmentation.segment.invigoY1, segmentation.segment.invigoY2};
                                            plotting.Inv_Slope = [plotting.Inv_Slope; plotting.new_entry];
                                        end
                                        
                                        segmentation.segment.invigo_done = 1;
                                    else
                                        
                                        segmentation.segment.invigoY1 = 0;
                                        segmentation.segment.invigoY2 = segmentation.segment.first_peak;
                                        segmentation.segment.invigoX1 = 0;
                                        segmentation.segment.invigoX2 = segmentation.segment.first_peak_t;
                                        
                                        segmentation.segment.invigo_slope = (segmentation.segment.invigoY2 - segmentation.segment.invigoY1)/ ...
                                            (segmentation.segment.invigoX2 - segmentation.segment.invigoX1);
                                        
                                        % save to output for plotting
                                        if runLabel == 2
                                            plotting.new_entry = {i_subj, i_sess, i_trial, segmentation.segment.invigoX1, segmentation.segment.invigoX2, ...
                                                segmentation.segment.invigoY1, segmentation.segment.invigoY2};
                                            plotting.Inv_Slope = [plotting.Inv_Slope; plotting.new_entry];
                                        end
                                        
                                        
                                        segmentation.segment.invigo_done = 1;
                                    end
                                else
                                    
                                    % delete plateau values smaller than 50 in case there are values larger than 50
                                    if(any(segmentation.segment.plateau.RelEffort_RAW > 50))
                                        segmentation.segment.plateau(segmentation.segment.plateau.RelEffort_RAW < 50, :) = [];
                                    end
                                    
                                    % find out the value in the plateau that occurs most often, choose this one
                                    segmentation.segment.plateau_vals = unique(segmentation.segment.plateau.RelEffort_RAW);
                                    segmentation.segment.plateau_counts = histc(segmentation.segment.plateau.RelEffort_RAW, segmentation.segment.plateau_vals);
                                    segmentation.segment.plateau_countidx = find(segmentation.segment.plateau_counts == max(segmentation.segment.plateau_counts));
                                    
                                    if length(segmentation.segment.plateau_countidx) > 1
                                        segmentation.segment.plateau_countidx = segmentation.segment.plateau_countidx(end);
                                    end

                                    segmentation.segment.plateau_validx = min(find(segmentation.segment.plateau.RelEffort_RAW == segmentation.segment.plateau_vals(segmentation.segment.plateau_countidx)));
                                    
                                    % read out initial point of plateau
                                    segmentation.segment.first_peak = segmentation.segment.plateau.RelEffort(segmentation.segment.plateau_validx);
                                    segmentation.segment.first_peak_t = segmentation.segment.plateau.Time_ref(segmentation.segment.plateau_validx);
                                    
                                    if i_seg_num > 1
                                        
                                        segmentation.segment.invigoY1 = segmentation.segment.lastPauseSegment_RelEffort;
                                        segmentation.segment.invigoY2 = segmentation.segment.first_peak;
                                        segmentation.segment.invigoX1 = segmentation.segment.lastPauseSegment_t;
                                        segmentation.segment.invigoX2 = segmentation.segment.first_peak_t;
                                        
                                        segmentation.segment.invigo_slope = (segmentation.segment.invigoY2 - segmentation.segment.invigoY1)/ ...
                                            (segmentation.segment.invigoX2 - segmentation.segment.invigoX1);
                                        
                                        % save to output for plotting
                                        if runLabel == 2
                                            plotting.new_entry = {i_subj, i_sess, i_trial, segmentation.segment.invigoX1, segmentation.segment.invigoX2, ...
                                                segmentation.segment.invigoY1, segmentation.segment.invigoY2};
                                            plotting.Inv_Slope = [plotting.Inv_Slope; plotting.new_entry];
                                        end
                                        
                                        segmentation.segment.invigo_done = 1;
                                    else
                                        
                                        segmentation.segment.invigoY1 = 0;
                                        segmentation.segment.invigoY2 = segmentation.segment.first_peak;
                                        segmentation.segment.invigoX1 = 0;
                                        segmentation.segment.invigoX2 = segmentation.segment.first_peak_t;
                                        
                                        segmentation.segment.invigo_slope = (segmentation.segment.invigoY2 - segmentation.segment.invigoY1)/ ...
                                            (segmentation.segment.invigoX2 - segmentation.segment.invigoX1);
                                        
                                        % save to output for plotting
                                        if runLabel == 2
                                            plotting.new_entry = {i_subj, i_sess, i_trial, segmentation.segment.invigoX1, segmentation.segment.invigoX2, ...
                                                segmentation.segment.invigoY1, segmentation.segment.invigoY2};
                                            plotting.Inv_Slope = [plotting.Inv_Slope; plotting.new_entry];
                                        end
                                        
                                        
                                        segmentation.segment.invigo_done = 1;
                                    end
                                end
                            else
                                
                                [segmentation.segment.peaks, segmentation.segment.peaks_t] = findpeaks(segmentation.segment.data.RelEffort);
                                
                                segmentation.segment.first_peak = segmentation.segment.peaks(1);
                                segmentation.segment.first_peak_i = segmentation.segment.peaks_t(1);
                                segmentation.segment.first_peak_t = segmentation.segment.data.Time_ref(segmentation.segment.first_peak_i);
                                
                                % if first peaks are very small (due to small and
                                % fast changes), take later
                                i = 1;
                                while segmentation.segment.first_peak < 50 && length(segmentation.segment.peaks) > i
                                    i = i + 1;
                                    segmentation.segment.first_peak = segmentation.segment.peaks(i);
                                    segmentation.segment.first_peak_i = segmentation.segment.peaks_t(i);
                                    segmentation.segment.first_peak_t = segmentation.segment.data.Time_ref(segmentation.segment.first_peak_i);
                                end
                                
                                if i_seg_num > 1
                                    
                                    segmentation.segment.invigoY1 = segmentation.segment.lastPauseSegment_RelEffort;
                                    segmentation.segment.invigoY2 = segmentation.segment.first_peak;
                                    segmentation.segment.invigoX1 = segmentation.segment.lastPauseSegment_t;
                                    segmentation.segment.invigoX2 = segmentation.segment.first_peak_t;
                                    
                                    segmentation.segment.invigo_slope = (segmentation.segment.invigoY2 - segmentation.segment.invigoY1)/ ...
                                        (segmentation.segment.invigoX2 - segmentation.segment.invigoX1);
                                    
                                    % save to output for plotting
                                    if runLabel == 2
                                        plotting.new_entry = {i_subj, i_sess, i_trial, segmentation.segment.invigoX1, segmentation.segment.invigoX2, ...
                                            segmentation.segment.invigoY1, segmentation.segment.invigoY2};
                                        plotting.Inv_Slope = [plotting.Inv_Slope; plotting.new_entry];
                                    end
                                    
                                    segmentation.segment.invigo_done = 1;
                                else
                                    
                                    % if directly the first segment is a work segment, compute the slope
                                    % relative to the first entry made in this trial
                                    segmentation.segment.invigoY1 = segmentation.segment.data.RelEffort(1);
                                    segmentation.segment.invigoY2 = segmentation.segment.first_peak;
                                    segmentation.segment.invigoX1 = segmentation.segment.data.Time_ref(1);
                                    segmentation.segment.invigoX2 = segmentation.segment.first_peak_t;
                                    
                                    segmentation.segment.invigo_slope = (segmentation.segment.invigoY2 - segmentation.segment.invigoY1)/ ...
                                        (segmentation.segment.invigoX2 - segmentation.segment.invigoX1);
                                    
                                    % save to output for plotting
                                    if runLabel == 2
                                        plotting.new_entry = {i_subj, i_sess, i_trial, segmentation.segment.invigoX1, segmentation.segment.invigoX2, ...
                                            segmentation.segment.invigoY1, segmentation.segment.invigoY2};
                                        plotting.Inv_Slope = [plotting.Inv_Slope; plotting.new_entry];
                                    end
                                    
                                    
                                    segmentation.segment.invigo_done = 1;
                                end
                                
                            end
                            
                        end
                        
                        % update values for segment with number i_seg_num
                        segmentation.trial_data.S_Length(segmentation.trial_data.Seg == i_seg_num) = segmentation.segment.duration;
                        segmentation.trial_data.S_AUC(segmentation.trial_data.Seg == i_seg_num) = segmentation.segment.AUC(end);
                        segmentation.trial_data.S_Slope(segmentation.trial_data.Seg == i_seg_num) = segmentation.segment.slope;
                        segmentation.trial_data.S_InvSlope(segmentation.trial_data.Seg == i_seg_num) = segmentation.segment.invigo_slope;
                        
                    end
                    
                    % Add column with total effort duration per trial
                    % = add segment duration for work_flag == 1
                    segmentation.filter.flag = segmentation.trial_data((segmentation.trial_data.V_line == 1),:);
                    segmentation.filter.work = segmentation.filter.flag.S_Length(segmentation.filter.flag.Work == 1);
                    
                    if segmentation.found_latency
                        % instead of boolean variable, save the time of change for latency
                        segmentation.latency_val = segmentation.trial_data.Time_ref(segmentation.trial_data.T_Lat == 1);
                        segmentation.trial_data.T_Lat(segmentation.trial_data.T_Lat == 1) = segmentation.latency_val;
                        
                        % since it is a trial measure, save in every row of the trial which latency it has
                        segmentation.trial_data.T_Lat(segmentation.trial_data.T_Lat == 0) = segmentation.latency_val;
                        
                    else
                        % if no latency found (i.e. never the level of minimum difficulty was reached) save NaN as value
                        segmentation.trial_data.T_Lat = NaN(size(segmentation.trial_data.Time_ref));
                        
                    end
                    
                    % Merge trial-wise modified data sheet for all subjects/sessions
                    if runLabel == 1
                        data.MergedTraining_time_seg = [data.MergedTraining_time_seg; segmentation.trial_data];
                    else
                        data.MergedExp_time_seg = [data.MergedExp_time_seg; segmentation.trial_data];
                    end
                    
                end
            end
        end
    end    
end

clearvars segmentation
clearvars i_movesum
clearvars idc_onset
clearvars i

%% end and saving of segmenting process

cd(files.file_dir)
if process_training
    data.MergedTraining_time_seg = removevars(data.MergedTraining_time_seg,{'T_Work',...
                                                                            'T_Rest',...
                                                                            'Work_Prog',...
                                                                            'Rest_Prog',...
                                                                            'Work_Ons',...
                                                                            'Rest_Ons'});
                                                                        
    savedata(['EAT_' experiment.paradigm_number '_Train_Merg+Seg'], data.MergedTraining_time_seg, files.data_dir)
    cd(files.file_dir)
end

% replace all zero entries of T_Lat by NaNs so that they are treated as
% missing values in the grpstats method (only the non-zero values are
% relevant!)
data.MergedExp_time_seg.T_Lat(data.MergedExp_time_seg.T_Lat == 0) = NaN;

data.MergedExp_time_seg = removevars(data.MergedExp_time_seg,{'T_Work',...
                                                              'T_Rest',...
                                                              'Work_Prog',...
                                                              'Rest_Prog',...
                                                              'Work_Ons',...
                                                              'Rest_Ons'});
                                                                        
savedata(['EAT_' experiment.paradigm_number '_Exp_Merg+Seg'], data.MergedExp_time_seg, files.data_dir)

cd(files.effort_dir)

%% Aggregation segment-wise
% 
% Training data
%
if process_training
    % break variables: subject ID, session ID, trial ID, segment
    data.EAT_Training_AggrSeg = grpstats(data.MergedTraining_time_seg, {'Subj_ID', 'Sess_ID', 'Trial_ID', 'Seg'});
    % delete group count Variable
    data.EAT_Training_AggrSeg.GroupCount = [];
    % Rename all Variables, dropping '_mean' prefix
    for i = 1:width(data.EAT_Training_AggrSeg)
        data.EAT_Training_AggrSeg.Properties.VariableNames{i} = strrep(data.EAT_Training_AggrSeg.Properties.VariableNames{i}, 'mean_', '');
    end
    % replacing NaN with 0 => for later analysis
    % (NaN always in first segment since no slope can be computed with only
    % one point)
    data.EAT_Training_AggrSeg.S_InvSlope(isnan(data.EAT_Training_AggrSeg.S_InvSlope)) = 0;
end

% Experimental data
%
% break variables: subject ID, session ID, trial ID, segment
data.EAT_fulldata_AggrSeg = grpstats(data.MergedExp_time_seg, {'Subj_ID', 'Sess_ID', 'Trial_ID', 'Seg'});
% delete group count Variable
data.EAT_fulldata_AggrSeg.GroupCount = [];
% Rename all Variables, dropping '_mean' prefix
for i = 1:width(data.EAT_fulldata_AggrSeg)
    data.EAT_fulldata_AggrSeg.Properties.VariableNames{i} = strrep(data.EAT_fulldata_AggrSeg.Properties.VariableNames{i}, 'mean_', '');
end
% replacing NaN with 0 => for later analysis
% (NaN always in first segment since no slope can be computed with only
% one point)
data.EAT_fulldata_AggrSeg.S_InvSlope(isnan(data.EAT_fulldata_AggrSeg.S_InvSlope)) = 0;


%% save aggregated-segment data 

cd(files.file_dir)
if process_training
    savedata(['EAT_' experiment.paradigm_number '_Train_Merg+Seg_AggrSeg'], data.EAT_Training_AggrSeg, files.data_dir)
    cd(files.file_dir)
end

savedata(['EAT_' experiment.paradigm_number '_Exp_Merg+Seg_AggrSeg'], data.EAT_fulldata_AggrSeg, files.data_dir)

cd(files.effort_dir)


%% Aggregation trial-wise

% Training data
%
if process_training
    % break variables: subject ID, session ID, trial ID
    data.EAT_Training_AggrTrial = grpstats(data.MergedTraining_time_seg, {'Subj_ID', 'Sess_ID', 'Trial_ID'});
    % delete group count Variable
    data.EAT_Training_AggrTrial.GroupCount = [];
    % Rename all Variables, dropping '_mean' prefix
    for i = 1:width(data.EAT_Training_AggrTrial)
        data.EAT_Training_AggrTrial.Properties.VariableNames{i} = strrep(data.EAT_Training_AggrTrial.Properties.VariableNames{i}, 'mean_', '');
    end
    % replacing NaN with 0 => for later analysis
    % (NaN always in first segment since no slope can be computed with only
    % one point)
    data.EAT_Training_AggrTrial.S_InvSlope(isnan(data.EAT_Training_AggrTrial.S_InvSlope)) = 0;
end

% Experimental data
%
% break variables: subject ID, session ID, trial ID
data.EAT_fulldata_AggrTrial = grpstats(data.MergedExp_time_seg, {'Subj_ID', 'Sess_ID', 'Trial_ID'});
% delete group count Variable
data.EAT_fulldata_AggrTrial.GroupCount = [];
% Rename all Variables, dropping '_mean' prefix
for i = 1:width(data.EAT_fulldata_AggrTrial)
    data.EAT_fulldata_AggrTrial.Properties.VariableNames{i} = strrep(data.EAT_fulldata_AggrTrial.Properties.VariableNames{i}, 'mean_', '');
end
% replacing NaN with 0 => for later analysis
% (NaN always in first segment since no slope can be computed with only
% one point)
data.EAT_fulldata_AggrTrial.S_InvSlope(isnan(data.EAT_fulldata_AggrTrial.S_InvSlope)) = 0;

%% save aggregated files

cd(files.file_dir)
if process_training
    savedata(['EAT_' experiment.paradigm_number '_Train_Merg+Seg_AggrSeg'], data.EAT_Training_AggrTrial, files.data_dir)
    cd(files.file_dir)
end

savedata(['EAT_' experiment.paradigm_number '_Exp_Merg+Seg_AggrTrial'], data.EAT_fulldata_AggrTrial, files.data_dir)

cd(files.effort_dir)

%% plotting one trial

h = figure('units','normalized','outerposition',[0 0 1 1]);

% plot data for one subject, one trial per plot
plotting.subj_id = 2;
plotting.i_trial = 36;
if experiment.N_sessions > 1
    plotting.i_session = 1;
end

% extract timepoints for one trial and invigoration slopes
plotting.data = data.MergedExp_time_seg(data.MergedExp_time_seg.Subj_ID == plotting.subj_id,:);
if experiment.N_sessions > 1
    plotting.data = plotting.data(plotting.data.Sess_ID == plotting.i_session,:);
end
plotting.data = plotting.data(plotting.data.Trial_ID == plotting.i_trial,:);
plotting.inv_data = plotting.Inv_Slope(plotting.Inv_Slope.Subj_ID == plotting.subj_id,:);
if experiment.N_sessions > 1
    plotting.inv_data = plotting.inv_data(plotting.inv_data.Sess_ID == plotting.i_session,:);
end
plotting.inv_data = plotting.inv_data(plotting.inv_data.Trial_ID == plotting.i_trial,:);

% read out x and y values
plotting.X = plotting.data.Time_ref;
plotting.Y = plotting.data.RelEffort;

% compute difficulty level that has to be reached by participant
plotting.l_threshold = ones(height(plotting.data),1) * plotting.data.Diff(1);

% read out in which area the participant worked
plotting.Y_work_true = plotting.data.RelEffort;
plotting.Y_work_true(plotting.data.Work ~= 1) = NaN;

% lines and areas
plotting.area_color = [0.85 0.85 0.85];
if plotting.data.Uncertn(1)
    plotting.max_uncertn = repelem(97,length(plotting.X));
    plotting.min_uncertn = repelem(62,length(plotting.X));
    plotting.test = line(plotting.X, plotting.max_uncertn);
    plotting.test = line(plotting.X, plotting.min_uncertn);
    plotting.uArea = [plotting.min_uncertn; (plotting.max_uncertn - plotting.min_uncertn)]';
    plotting.huArea = area(plotting.X, plotting.uArea,'FaceColor', 'r', 'FaceAlpha',.2,'EdgeAlpha',.2, 'DisplayName', 'Uncertainty area');
    set(plotting.huArea(1), 'FaceColor', 'none') % this makes the bottom area invisible
    set(plotting.huArea, 'LineStyle', 'none')
end
hold on
plotting.hEffort_area = area(plotting.X,plotting.Y_work_true,'FaceColor',plotting.area_color, 'FaceAlpha', 0.45, 'AlignVertexCenters', 'on');
plotting.hForce = line(plotting.X, plotting.Y);
plotting.hThreshold = line(plotting.X, plotting.l_threshold);

% invigoration slopes
for i = 1:height(plotting.inv_data)
    plotting.IX = linspace(plotting.inv_data.X1(i), plotting.inv_data.X2(i));
    plotting.IY = linspace(plotting.inv_data.Y1(i), plotting.inv_data.Y2(i));
    plotting.hInvSlope = line(plotting.IX, plotting.IY);
    
    set(plotting.hInvSlope                 , ...
        'Linewidth'       , 2              , ...
        'Color'           , [0.4 0 0.9]    );
end

% color settings
set(plotting.hThreshold                 , ...
    'Linewidth'       , 0.5             , ...
    'LineStyle'       , '--'            , ...
    'Color'           , [0.6 0 0.298]   );

if ~isempty(plotting.inv_data)
    set(plotting.hInvSlope                 , ...
        'Linewidth'       , 2.5            , ...
        'Color'           , [0.4 0 0.9]    );
end

set(plotting.hForce                     , ...
    'Color'           , 'k'             );

% labeling the plot
if plotting.data.Uncertn(1)
    plotting.uStr = 'uncertain difficulty';
else
    plotting.uStr = 'certain difficulty';
end
plotting.hXlabel = xlabel('Time (s)', 'FontSize', 12);
plotting.hYlabel = ylabel('Relative Effort (%)', 'FontSize', 12);
if experiment.N_sessions == 1
    if runLabel == 1
        plotting.title = ['TRAINING - Subj ', num2str(plotting.subj_id), ' - Trial ', num2str(plotting.i_trial)]; 
    else
        plotting.title = ['EXP - Subj ', num2str(plotting.subj_id), ' - Trial ', num2str(plotting.i_trial)]; 
    end
elseif experiment.N_sessions > 1
    if runLabel == 1
        plotting.title = ['TRAINING - Subj ', num2str(plotting.subj_id), '- Session ', num2str(plotting.i_session), ' - Trial ', num2str(plotting.i_trial)]; 
    else
        plotting.title = ['EXP - Subj ', num2str(plotting.subj_id), '- Session ', num2str(plotting.i_session), ' - Trial ', num2str(plotting.i_trial)];
    end
end
plotting.Htitle = title({['\fontsize{30}', plotting.title];'\fontsize{24}\color{red} '; plotting.uStr},'fontweight','b');

% legend
if isempty(plotting.inv_data)
    if plotting.data.Uncertn(1)
        plotting.hLegend = legend(                      ...
            [plotting.hForce, plotting.hThreshold     , ...
            plotting.hEffort_area, plotting.huArea]   , ...
            'Data'                                    , ...
            'Difficulty level'                        , ...
            'Effort area'                             , ...
            'Uncertainty around difficulty'           , ...
            'FontSize', 12);
    else
        plotting.hLegend = legend(                      ...
            [plotting.hForce, plotting.hThreshold     , ...
            plotting.hEffort_area]                    , ...
            'Data'                                    , ...
            'Difficulty level'                        , ...
            'Effort area'                             , ...
            'FontSize', 12);
    end
else
    if plotting.data.Uncertn(1)
        plotting.hLegend = legend(                      ...
            [plotting.hForce, plotting.hThreshold     , ...
            plotting.hEffort_area,plotting.hInvSlope  , ...
            plotting.huArea]                          , ...
            'Data'                                    , ...
            'Difficulty level'                        , ...
            'Effort area'                             , ...
            'Invigoration Slopes'                     , ...
            'Uncertainty around difficulty'           , ...
            'FontSize', 12);
    else
        plotting.hLegend = legend(                      ...
            [plotting.hForce, plotting.hThreshold     , ...
            plotting.hEffort_area,plotting.hInvSlope] , ...
            'Data'                                    , ...
            'Difficulty level'                        , ...
            'Effort area'                             , ...
            'Invigoration Slopes'                     , ...
            'FontSize', 12);
    end
end

% drawing
set(gca,'box','off')
drawnow
               
%% animated plot for all trials for all subjects

% open full-screen window
h = figure('units','normalized','outerposition',[0 0 1 1]);

% saving all trials in one gif is too big; therefore, splitting up data in
% several gif files
newgif = false;

% plot training and experimental data
for runLabel = 2:2
    
    % training and experiment had diff amount of trials
    if runLabel == 1
        experiment.trialnum = experiment.trialnums(1);
    elseif runLabel == 2
        experiment.trialnum = experiment.trialnums(2);
    end
    
    newgif = true;
    
    % run through all subjects
    for i_subj = 1:experiment.N

        if experiment.data_present(i_subj)
            
            if runLabel == 2
                newgif = true;
            end
            
            for i_sess = 1:experiment.N_sessions
            
                % run through all trials
                for i_trial = 1:experiment.trialnum
                    
                    if runLabel == 1
                        plotting.data = data.MergedTraining_time_seg;
                    else
                        plotting.data = data.MergedExp_time_seg;
                    end
                    
                    % properties plot
                    
                    % shaded area of effort
                    plotting.area_color = [0.85 0.85 0.85];
                    
                    % extract data for plot
                    
                    % extract timepoints for one trial
                    plotting.data = plotting.data(plotting.data.Subj_ID == i_subj,:);
                    plotting.data = plotting.data(plotting.data.Sess_ID == i_sess,:);
                    plotting.data = plotting.data(plotting.data.Trial_ID == i_trial,:);
                    
                    if isempty(plotting.data)
                        continue
                    end
                    plotting.inv_data = plotting.Inv_Slope(plotting.Inv_Slope.Subj_ID == i_subj,:);
                    plotting.inv_data = plotting.inv_data(plotting.inv_data.Sess_ID == i_sess,:);
                    plotting.inv_data = plotting.inv_data(plotting.inv_data.Trial_ID == i_trial,:);
                    
                    % read out x and y values
                    plotting.X = plotting.data.Time_ref;
                    plotting.Y = plotting.data.RelEffort;
                    
                    % compute difficulty level that has to be reached by participant
                    plotting.l_threshold = ones(height(plotting.data),1) * plotting.data.Diff(1);
                    
                    % read out in which area the participant worked
                    plotting.Y_work_true = plotting.data.RelEffort;
                    plotting.Y_work_true(plotting.data.Work ~= 1) = NaN;
                    
                    % lines and areas
                    plotting.area_color = [0.85 0.85 0.85];
                    if plotting.data.Uncertn(1)
                        plotting.max_uncertn = repelem(97,length(plotting.X));
                        plotting.min_uncertn = repelem(62,length(plotting.X));
                        plotting.test = line(plotting.X, plotting.max_uncertn);
                        plotting.test = line(plotting.X, plotting.min_uncertn);
                        plotting.uArea = [plotting.min_uncertn; (plotting.max_uncertn - plotting.min_uncertn)]';
                        plotting.huArea = area(plotting.X, plotting.uArea,'FaceColor', 'r', 'FaceAlpha',.2,'EdgeAlpha',.2, 'DisplayName', 'Uncertainty area');
                        set(plotting.huArea(1), 'FaceColor', 'none') % this makes the bottom area invisible
                        set(plotting.huArea, 'LineStyle', 'none')
                    end
                    hold on
                    plotting.hEffort_area = area(plotting.X,plotting.Y_work_true,'FaceColor',plotting.area_color, 'FaceAlpha', 0.45, 'AlignVertexCenters', 'on');
                    plotting.hForce = line(plotting.X, plotting.Y);
                    plotting.hThreshold = line(plotting.X, plotting.l_threshold);
                    
                    % invigoration slopes
                    for i = 1:height(plotting.inv_data)
                        plotting.IX = linspace(plotting.inv_data.X1(i), plotting.inv_data.X2(i));
                        plotting.IY = linspace(plotting.inv_data.Y1(i), plotting.inv_data.Y2(i));
                        plotting.hInvSlope = line(plotting.IX, plotting.IY);
                        
                        set(plotting.hInvSlope                 , ...
                            'Linewidth'       , 2              , ...
                            'Color'           , [0.4 0 0.9]    );
                    end
                    
                    % color settings
                    set(plotting.hThreshold                 , ...
                        'Linewidth'       , 0.5             , ...
                        'LineStyle'       , '--'            , ...
                        'Color'           , [0.6 0 0.298]   );
                    
                    if ~isempty(plotting.inv_data)
                        set(plotting.hInvSlope                 , ...
                            'Linewidth'       , 2.5            , ...
                            'Color'           , [0.4 0 0.9]    );
                    end
                    
                    set(plotting.hForce                     , ...
                        'Color'           , 'k'             );
                    
                    % labeling the plot
                    if plotting.data.Uncertn(1)
                        plotting.uStr = 'uncertain difficulty';
                    else
                        plotting.uStr = 'certain difficulty';
                    end
                    plotting.hXlabel = xlabel('Time (s)', 'FontSize', 12);
                    plotting.hYlabel = ylabel('Relative Effort (%)', 'FontSize', 12);
                    if experiment.N_sessions == 1
                        if runLabel == 1
                            plotting.title = ['TRAINING - Subj ', num2str(i_subj), ' - Trial ', num2str(i_trial)];
                        else
                            plotting.title = ['EXP - Subj ', num2str(i_subj), ' - Trial ', num2str(i_trial)];
                        end
                    elseif experiment.N_sessions > 1
                        if runLabel == 1
                            plotting.title = ['TRAINING - Subj ', num2str(i_subj), '- Session ', num2str(i_sess), ' - Trial ', num2str(i_trial)];
                        else
                            plotting.title = ['EXP - Subj ', num2str(i_subj), '- Session ', num2str(i_sess), ' - Trial ', num2str(i_trial)];
                        end
                    end
                    plotting.Htitle = title({['\fontsize{30}', plotting.title];'\fontsize{24}\color{red} '; plotting.uStr},'fontweight','b');
                    
                    % legend
                    if isempty(plotting.inv_data)
                        if plotting.data.Uncertn(1)
                            plotting.hLegend = legend(                      ...
                                [plotting.hForce, plotting.hThreshold     , ...
                                plotting.hEffort_area, plotting.huArea]   , ...
                                'Data'                                    , ...
                                'Difficulty level'                        , ...
                                'Effort area'                             , ...
                                'Uncertainty around difficulty'           , ...
                                'FontSize', 12);
                        else
                            plotting.hLegend = legend(                      ...
                                [plotting.hForce, plotting.hThreshold     , ...
                                plotting.hEffort_area]                    , ...
                                'Data'                                    , ...
                                'Difficulty level'                        , ...
                                'Effort area'                             , ...
                                'FontSize', 12);
                        end
                    else
                        if plotting.data.Uncertn(1)
                            plotting.hLegend = legend(                      ...
                                [plotting.hForce, plotting.hThreshold     , ...
                                plotting.hEffort_area,plotting.hInvSlope  , ...
                                plotting.huArea]                          , ...
                                'Data'                                    , ...
                                'Difficulty level'                        , ...
                                'Effort area'                             , ...
                                'Invigoration Slopes'                     , ...
                                'Uncertainty around difficulty'           , ...
                                'FontSize', 12);
                        else
                            plotting.hLegend = legend(                      ...
                                [plotting.hForce, plotting.hThreshold     , ...
                                plotting.hEffort_area,plotting.hInvSlope] , ...
                                'Data'                                    , ...
                                'Difficulty level'                        , ...
                                'Effort area'                             , ...
                                'Invigoration Slopes'                     , ...
                                'FontSize', 12);
                        end
                    end
                    
                    % drawing
                    
                    %                 % if you want to control with the enter key when the next
                    %                 % picture is shown
                    %                 while true
                    %                     w = waitforbuttonpress;
                    %                     switch w
                    %                         case 1 % (keyboard press)
                    %                             key = get(gcf,'currentcharacter');
                    %                             switch key
                    %                                 case 13 % 13 is the  key
                    %                                     break
                    %                                 otherwise
                    %                                     % Wait for a different command
                    %                             end
                    %                     end
                    %                 end
                    
                    drawnow
                    
                    % Capture the plot as an image
                    frame = getframe(h);
                    im = frame2im(frame);
                    [imind,cm] = rgb2ind(im,256);
                    
                    % Write to the GIF File
%                     if newgif
%                         if runLabel == 1
%                             imwrite(imind,cm,'Training','gif', 'Loopcount',inf);
%                         else
%                             imwrite(imind,cm,['Exp - Subj' num2str(i_subj)],'gif', 'Loopcount',inf);
%                         end
%                         
%                         newgif = false;
%                     else
%                         if runLabel == 1
%                             imwrite(imind,cm,'Training','gif', 'WriteMode','append');
%                         else
%                             imwrite(imind,cm,['Exp - Subj' num2str(i_subj)],'gif', 'WriteMode','append');
%                         end
%                         
%                         %imwrite(imind,cm,'segmented_data','gif','WriteMode','append');
%                     end
                    
                    % pause and clear
                    pause(1)
                    clf
                end
            end
        end
    end
end