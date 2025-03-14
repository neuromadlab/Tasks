%%======EATmain_ Randomise Conditions=======
%Script for creating condition files -18/06/2017-
%author: Monja P. Neuser, Mechteld van den Hoek Ostende

%Percent of MaxFreq 75% or 85%
%No uncertainty condition
%===========================================
function Create_Cond(Study_ID,nr_ids,Difficulty,nr_session,nr_runs,nr_trials,food)

rng('shuffle')  % set rng to shuffle for random shuffling everytime matlab is started

%% settings/study information
subj.studyID = Study_ID; %Prefix of tVNS project

for i_s = nr_session(1):nr_session(2)

    subj.study_part_ID = ['S',num2str(i_s)']; %indicates session
    start_range = nr_ids(1);
    id_range = nr_ids(2);

    %% Training
    % Create difficulty+Incentive conditions for training
    if food
    Money = 1;
    Food  = 0;
    else 
        Money = 1;
    end

    LowRwrd  = 1;      %1  Cent, kCal / Sec
    HighRwrd = 10;    %10 Cent, kCal / Sec

    LowDiff  = Difficulty(1); %percent of MaxFreq
    HighDiff = Difficulty(2); %percent of MaxFreq
    
    if food
        Value_labels = {'Money', Money; 'Food', Food; 'LowRwrd', LowRwrd; 'HighRwrd', HighRwrd; 'LowDiff', LowDiff; 'HighDiff', HighDiff};
    else
        Value_labels = {'Money', Money; 'LowRwrd', LowRwrd; 'HighRwrd', HighRwrd; 'LowDiff', LowDiff; 'HighDiff', HighDiff};
    end

    %all possible combinations
    LowDiff_M_low  = [LowDiff, Money, LowRwrd];
    LowDiff_M_high = [LowDiff, Money, HighRwrd];
    if food
        LowDiff_F_low  = [LowDiff, Food, LowRwrd];
        LowDiff_F_high = [LowDiff, Food, HighRwrd];
    end

    HighDiff_M_low  = [HighDiff, Money, LowRwrd];
    HighDiff_M_high = [HighDiff, Money, HighRwrd];
    if food
        HighDiff_F_low  = [HighDiff, Food, LowRwrd];
        HighDiff_F_high = [HighDiff, Food, HighRwrd];
    end
    %Condition vector
    if food
        LowDiff_vector  = [LowDiff_M_low; LowDiff_M_high; LowDiff_F_low; LowDiff_F_high];
        HighDiff_vector = [HighDiff_M_low; HighDiff_M_high; HighDiff_F_low; HighDiff_F_high];
    else
        LowDiff_vector  = [LowDiff_M_low; LowDiff_M_high];
        HighDiff_vector = [HighDiff_M_low; HighDiff_M_high];
    end

    for i_id = start_range:id_range

        conditions = [];

        %Random selection without displacement of indices
        perm_i_LowDiff  = randperm(size(LowDiff_vector,1));
        perm_i_HighDiff = randperm(size(HighDiff_vector,1));


        %Create conditions vector, HighDiff and LowDiff alternating
        for k = 1:size(LowDiff_vector,1)

            l_k = LowDiff_vector(perm_i_LowDiff(k),1:3);
            h_k = HighDiff_vector(perm_i_HighDiff(k),1:3);

            if mod(i_id,2)
                conditions = [conditions; l_k; h_k];
            else
                conditions = [conditions; h_k; l_k];
            end

        end

        % Add column of zeros for uncertainty (indicating no uncertainty)
        uncertainty = zeros(length(conditions),1);
        conditions  = [conditions, uncertainty];

        %save
        conditionstable = array2table(conditions, 'VariableNames', {'Difficulty', 'Money', 'Rew_magn', 'Uncertainty'});
        output.filename = sprintf('../conditions/EATTrain_cond_%s_%06d_%s_R1', subj.studyID, i_id,subj.study_part_ID);
        save([output.filename '.mat'], 'conditions', 'Value_labels', 'conditionstable')

    end

    %% Experiment

    %%Create difficulty+Incentive conditions for experiment
    if food
    Money = 1;
    Food  = 0;
    else 
        Money = 1;
    end

    LowRwrd  = 1;      %1  Cent, kCal / Sec
    HighRwrd = 10;    %10 Cent, kCal / Sec

    LowDiff  = Difficulty(1); %percent of MaxFreq
    HighDiff = Difficulty(2); %percent of MaxFreq
    
    if food
        Value_labels = {'Money', Money; 'Food', Food; 'LowRwrd', LowRwrd; 'HighRwrd', HighRwrd; 'LowDiff', LowDiff; 'HighDiff', HighDiff};
    else
        Value_labels = {'Money', Money; 'LowRwrd', LowRwrd; 'HighRwrd', HighRwrd; 'LowDiff', LowDiff; 'HighDiff', HighDiff};
    end

    %all possible combinations
    LowDiff_M_low  = [LowDiff, Money, LowRwrd];
    LowDiff_M_high = [LowDiff, Money, HighRwrd];
    if food
        LowDiff_F_low  = [LowDiff, Food, LowRwrd];
        LowDiff_F_high = [LowDiff, Food, HighRwrd];
    end

    HighDiff_M_low  = [HighDiff, Money, LowRwrd];
    HighDiff_M_high = [HighDiff, Money, HighRwrd];
    if food
        HighDiff_F_low  = [HighDiff, Food, LowRwrd];
        HighDiff_F_high = [HighDiff, Food, HighRwrd];
    end
    
    %Condition vector
    if food
        LowDiff_vector  = repmat([LowDiff_M_low; LowDiff_M_high; LowDiff_F_low; LowDiff_F_high], nr_trials/8,1);
        HighDiff_vector = repmat([HighDiff_M_low; HighDiff_M_high; HighDiff_F_low; HighDiff_F_high], nr_trials/8,1);
    else
        LowDiff_vector  = repmat([LowDiff_M_low; LowDiff_M_high], nr_trials/4,1);
        HighDiff_vector = repmat([HighDiff_M_low; HighDiff_M_high], nr_trials/4,1);
    end


    for i_run = nr_runs(1):nr_runs(2)
        for i_id = start_range:id_range

            conditions = [];

            %Random selection without displacement of indices
            perm_i_LowDiff = randperm(size(LowDiff_vector,1));
            perm_i_HighDiff = randperm(size(HighDiff_vector,1));


            %Create conditions vector, HighDiff and LowDiff alternating
            for k = 1:size(LowDiff_vector,1)

                l_k = LowDiff_vector(perm_i_LowDiff(k),1:3);
                h_k = HighDiff_vector(perm_i_HighDiff(k),1:3);

                if mod(i_id,2)
                    conditions = [conditions; l_k; h_k];
                else
                    conditions = [conditions; h_k; l_k];
                end

            end

            uncertainty = zeros(length(conditions),1);
            conditions  = [conditions, uncertainty];

            conditionstable = array2table(conditions, 'VariableNames', {'Difficulty', 'Money', 'Rew_magn', 'Uncertainty'});
            output.filename = sprintf('../conditions/EATExp_cond_%s_%06d_%s_R%s', subj.studyID, i_id, subj.study_part_ID, num2str(i_run));
            save([output.filename '.mat'], 'conditions', 'Value_labels', 'conditionstable')


        end
    end
end
