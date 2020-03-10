%%======EATmain_ Randomise Conditions=======
%Script for creating condition files -18/06/2017-
%author: Monja P. Neuser, Mechteld van den Hoek Ostende

%Percent of MaxFreq 75% or 85%
%No uncertainty condition
%===========================================

%% settings/study information
subj.studyID = 'TUE004'; %Prefix of tVNS project
subj.study_part_ID = 'S2'; %indicates session (1 behavioral, 2 fmri)
start_range = 900001;
id_range = 900010;

%% Training
% Create difficulty+Incentive conditions for trainging
Money = 1;
Food  = 0;

LowRwrd  = 1;      %1  Cent, kCal / Sec
HighRwrd = 10;    %10 Cent, kCal / Sec

LowDiff  = 75; %percent of MaxFreq
HighDiff = 85; %percent of MaxFreq

Value_labels = {'Money', Money; 'Food', Food; 'LowRwrd', LowRwrd; 'HighRwrd', HighRwrd; 'LowDiff', LowDiff; 'HighDiff', HighDiff};

%all possible combinations
LowDiff_M_low  = [LowDiff, Money, LowRwrd];
LowDiff_M_high = [LowDiff, Money, HighRwrd];
LowDiff_F_low  = [LowDiff, Food, LowRwrd];
LowDiff_F_high = [LowDiff, Food, HighRwrd];

HighDiff_M_low  = [HighDiff, Money, LowRwrd];
HighDiff_M_high = [HighDiff, Money, HighRwrd];
HighDiff_F_low  = [HighDiff, Food, LowRwrd];
HighDiff_F_high = [HighDiff, Food, HighRwrd];

%Condition vector
LowDiff_vector  = [LowDiff_M_low; LowDiff_M_high; LowDiff_F_low; LowDiff_F_high];
HighDiff_vector = [HighDiff_M_low; HighDiff_M_high; HighDiff_F_low; HighDiff_F_high];

for i_id = start_range:id_range
    
    conditions = [];
    
    %Random selection without displacement of indices
    perm_i_LowDiff  = randperm(length(LowDiff_vector));
    perm_i_HighDiff = randperm(length(LowDiff_vector));


    %Create conditions vector, HighDiff and LowDiff alternating
    for k = 1:length(LowDiff_vector)

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
    output.filename = sprintf('%s/conditions/EATTrain_cond_%s_%06d_%s_R1', pwd, subj.studyID, i_id,subj.study_part_ID);
    save([output.filename '.mat'], 'conditions', 'Value_labels', 'conditionstable')

end

%% Experiment

%%Create difficulty+Incentive conditions for experiment
Money = 1;
Food  = 0;

LowRwrd  = 1;      %1  Cent, kCal / Sec
HighRwrd = 10;    %10 Cent, kCal / Sec

LowDiff  = 75; %percent of MaxFreq
HighDiff = 85; %percent of MaxFreq

Value_labels = {'Money', Money; 'Food', Food; 'LowRwrd', LowRwrd; 'HighRwrd', HighRwrd; 'LowDiff', LowDiff; 'HighDiff', HighDiff};

%all possible combinations
LowDiff_M_low  = [LowDiff, Money, LowRwrd];
LowDiff_M_high = [LowDiff, Money, HighRwrd];
LowDiff_F_low  = [LowDiff, Food, LowRwrd];
LowDiff_F_high = [LowDiff, Food, HighRwrd];

HighDiff_M_low  = [HighDiff, Money, LowRwrd];
HighDiff_M_high = [HighDiff, Money, HighRwrd];
HighDiff_F_low  = [HighDiff, Food, LowRwrd];
HighDiff_F_high = [HighDiff, Food, HighRwrd];


% For 48 Trials 
LowDiff_vector  = repmat([LowDiff_M_low; LowDiff_M_high; LowDiff_F_low; LowDiff_F_high], 6, 1);
HighDiff_vector = repmat([HighDiff_M_low; HighDiff_M_high; HighDiff_F_low; HighDiff_F_high], 6, 1);

for i_id = start_range:id_range
    
    conditions = [];

    %Random selection without displacement of indices
    perm_i_LowDiff = randperm(length(LowDiff_vector));
    perm_i_HighDiff = randperm(length(LowDiff_vector));


    %Create conditions vector, HighDiff and LowDiff alternating
    for k = 1:length(LowDiff_vector)

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
    output.filename = sprintf('%s/conditions/EATExp_cond_%s_%06d_%s_R1', pwd, subj.studyID, i_id, subj.study_part_ID);
    save([output.filename '.mat'], 'conditions', 'Value_labels', 'conditionstable')

end
