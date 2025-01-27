%% ========================================================================
% ====== Randomize Conditions for the IMT =================================
% Script for creating condition files -15/08/2022-
% Script heavily adapted from EAT (author: Monja P. Neuser, Mechteld van den Hoek Ostende)
% Current Usage: IMT 
% Author: Corinna Schulz 
% =========================================================================
% WHAT THE SCRIPT CREATES 
% 1. Randomize Tone-Reward Pairing (per Subject)
% 2.1 Cue Conditioning Conditions: Randomize Cues within one Set of Cue
% learning Trials and within one Set of Cue Query Trials.
% 2.2 Training: Fully Randomize Conditions 
% 2.3 Experiment: Fully Randomize Conditions 
%==========================================================================

clear all

%% settings/study information
% Load Settings for trial numbers and tone type (Tone Type is the same
% across sessions, thus only determined once (i.e., S1), randomization type
% (full or partial is described in settings) 
load(strcat('./IMT_settings_TUE008.mat'))

pilot = 0; %Set 1 if Pilot 

subj.sess = 'S2'; %indicates session 
subj.study = 'TUE008'; %study identifier
start_range = 000001; % indicates ID start 
id_range = 000040; % Indicates ID end 

conditions_for = {'cue_conditioning', 'training','experiment'};

%% 1. Randomization of Tone-Reward Pairings 
% The Tones used for respective conditions will remain the same for a
% participant throughout the whole experiment, thus in 

% Save/Load Tone-Reward Pairings for IDs
if pilot == 1
    filename = sprintf('%s/conditions/Tone_Reward_Pairings_All_PILOT', pwd);

elseif pilot == 0
    filename = sprintf('%s/conditions/Tone_Reward_Pairings_All', pwd);
end

if strcmp(subj.sess,'S1')
    if settings.tone_rand_rewardType == 1 %only partial randomization: between reward Types, but not low and high reward
        tone_options_1 = perms([1 2]); % Get all possible permutations for low
        tone_options_2 = perms([3 4]); % Get all possible permutations for high
        tone_pairing = []; % Create longer list so that for enough participants tones are matched
        repeat_factor = round(100/length(tone_options_1*2));  % Roughly for 100 participants

        for i= 1:repeat_factor
            tone_rand_1 = tone_options_1(randperm(length(tone_options_1)),:);
            tone_rand_2 = tone_options_2(randperm(length(tone_options_2)),:);
            tone_pairing = [tone_pairing; tone_rand_1, tone_rand_2];
        end

        clear tone_options_1 tone_options_2 tone_rand_1 tone_rand_2

    else %full randomization
        tone_options = perms([1 2 3 4]); % Get all possible permutations
        tone_pairing = []; % Create longer list so that for enough participants tones are matched
        repeat_factor = round(100/length(tone_options));  % Roughly for 100 participants
        for i= 1:repeat_factor
            tone_rand = tone_options(randperm(length(tone_options)),:);
            tone_pairing = [tone_pairing; tone_rand];
        end

        clear tone_options tone_rand
    end

    % Save Tone-Reward Pairings for IDs in seperate file!
    save([filename '.mat'], 'tone_pairing')

else % Load Tone-Reward Pairing determined for S1
    load([filename '.mat'])

end

%% Create Conditions for training and experiment

for c= 1:length(conditions_for)

    % Create Incentive conditions
    Money = 1;
    Food  = 0;

    LowRwrd  = 1;      % 1x multiplication
    HighRwrd = 10;    % 10x multiplication

    Value_labels = {'Money', Money; 'Food', Food; 'LowRwrd', LowRwrd; 'HighRwrd', HighRwrd};

    % all possible combinations
    M_low  = [Money, LowRwrd];
    M_high = [Money, HighRwrd];
    F_low  = [Food, LowRwrd];
    F_high = [Food, HighRwrd];

    % Condition vector
    vector  = [M_low; M_high; F_low; F_high];

    % For experiment extend condition file for all trials

    % For Training and Experiment everyone has another order
    % (pseudo-randomised)
    if strcmp(conditions_for(c),'cue_conditioning')
        % Produce many Cue Conditioning trials (as they are played as long
        % as performance is not good enough 

        % Repeat and Query should have 8 trials each
        vector  = repmat([M_low; M_high; F_low; F_high],settings.cue_conditioning_trials/4, 1); 
        vector(1:4,3) = 0; % Half of Block should be queried with Reward Type
        vector(5:8,3) = 1; % Half of Block should be queried with Reward Magnitude 

    elseif strcmp(conditions_for(c),'training')
        % E.g. For 12 Trials (trials/4)
        vector  = repmat([M_low; M_high; F_low; F_high], settings.train_trials/4, 1);
    elseif strcmp(conditions_for(c),'experiment')
        % E.g. For 48 Trials  (trials/4)
        vector  = repmat([M_low; M_high; F_low; F_high], settings.trials/4, 1);
    end

   
    id = 1; %init count for participant number 
    for i_id = start_range:id_range
       

        conditions = [];

        if strcmp(conditions_for(c),'cue_conditioning') == 0
            
            % Random selection without displacement of indices
            perm_i = randperm(length(vector));

            % Create conditions vector
            for k = 1:length(vector)
                fin_k = vector(perm_i(k),1:2);
                conditions = [conditions; fin_k];
            end
        
        % For Conditioning have 2x each condition (8x) for one round of
        % Repeat. Then Followed by 2x each condition (8x) for one round of
        % Query Trials. This is repeated at least 3x and until performance
        % reaches 100%. 
        elseif strcmp(conditions_for(c),'cue_conditioning') == 1
        conditions_fin = []; 

            for repeats = 1:30 %Each Round should have all cues 2x but we need many rounds 
                conditions_rep = [];
                conditions_query = []; 
                    
                % Random selection without displacement of indices
                perm_i = randperm(length(vector));
    
                % Create conditions vector
                for k = 1:length(vector)
                    fin_k = vector(perm_i(k),1:3);
                    conditions_rep = [conditions_rep; fin_k];
                end
            
                % Random selection without displacement of indices
                perm_i = randperm(length(vector));
                
                for k = 1:length(vector)
                    fin_query = vector(perm_i(k),1:3);
                    conditions_query = [conditions_query; fin_query];
                end
    
                conditions_fin = [conditions_fin; conditions_rep; conditions_query]; 
            end 

            conditions = conditions_fin; %same name for rest of script 
            conditions(:,4) = repmat([zeros(settings.cue_conditioning_trials,1);ones(settings.cue_conditioning_test_trials,1)],30,1);  % Index for Repeat Vs. Query Trial
        
        
        end 

       
        % Create Cue Conditionstable 
        if strcmp(conditions_for(c),'cue_conditioning') == 0
            conditionstable = array2table(conditions, 'VariableNames', {'Money', 'Rew_magn'});
        else
            conditionstable = array2table(conditions, 'VariableNames', {'Money', 'Rew_magn','Query_Mag','Query'});
        end
        % Add Tone Column with the Tone-Reward Pairing 
        conditionstable.Tone(conditionstable.Money == 0 & conditionstable.Rew_magn == 1) = tone_pairing(id,1); % food low
        conditionstable.Tone(conditionstable.Money == 1 & conditionstable.Rew_magn == 1) = tone_pairing(id,2); % money low
        conditionstable.Tone(conditionstable.Money == 0 & conditionstable.Rew_magn == 10) = tone_pairing(id,3); % food high
        conditionstable.Tone(conditionstable.Money == 1 & conditionstable.Rew_magn == 10) = tone_pairing(id,4); % money high

        if strcmp(conditions_for(c), 'cue_conditioning')
            % Rename conditioning table so that later in script two tables
            % are not overwritten when loaded
            cue_conditionstable = conditionstable; 
            cue_conditions = conditions; 
            output.filename = sprintf('%s/conditions/Conditioning_IMT_cond_%s_%06d_%s', pwd, subj.study, i_id, subj.sess);
            save([output.filename '.mat'], 'cue_conditions', 'Value_labels', 'cue_conditionstable')
        
        elseif strcmp(conditions_for(c), 'training')
            output.filename = sprintf('%s/conditions/Train_IMT_cond_%s_%06d_%s', pwd, subj.study, i_id,subj.sess);
            save([output.filename '.mat'], 'conditions', 'Value_labels', 'conditionstable')
        
        elseif strcmp(conditions_for(c),'experiment')
            output.filename = sprintf('%s/conditions/Exp_IMG_cond_%s_%06d_%s', pwd, subj.study, i_id, subj.sess);
            save([output.filename '.mat'], 'conditions', 'Value_labels', 'conditionstable')
        end

         id = id+1; %count participant number 

    end

end