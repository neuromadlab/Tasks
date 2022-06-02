%%======EATmain_ Randomise Conditions=======
%Script for creating condition files -18/06/2017-
%author: Monja P. Neuser, Mechteld van den Hoek Ostende

%Percent of MaxFreq between 64% and 95%
%Includes uncertainty condition (in Exp run)
%===========================================

subj.studyID = 'TUE007'; %Prefix of tVNS project
subj.study_part_ID = 'S1'; %indicates session (1 behavioral, 2 fmri)
start_range = 000001;
id_range = 000100;

%%=========================
%%Conditions for training
%%=========================
%%Create difficulty+Incentive conditions for experiment
Money = 1;
Food = 0;

LowRwrd = 1;      %1  Cent, kCal / Sec
HighRwrd = 10;    %10 Cent, kCal / Sec

LowDiff = 75; %percent of MaxForce
HighDiff = 85; %percent of MaxForce

Value_labels = {'Money', Money; 'Food', Food; 'LowRwrd', LowRwrd; 'HighRwrd', HighRwrd; 'LowDiff', LowDiff; 'HighDiff', HighDiff};

%all possible combinations
LowDiff_M_low = [LowDiff, Money, LowRwrd];
LowDiff_M_high = [LowDiff, Money, HighRwrd];
LowDiff_F_low = [LowDiff, Food, LowRwrd];
LowDiff_F_high = [LowDiff, Food, HighRwrd];

HighDiff_M_low = [HighDiff, Money, LowRwrd];
HighDiff_M_high = [HighDiff, Money, HighRwrd];
HighDiff_F_low = [HighDiff, Food, LowRwrd];
HighDiff_F_high = [HighDiff, Food, HighRwrd];

%Condition vector
LowDiff_vector = [LowDiff_M_low; LowDiff_M_high; LowDiff_F_low; LowDiff_F_high];
HighDiff_vector = [HighDiff_M_low; HighDiff_M_high; HighDiff_F_low; HighDiff_F_high];


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
    
    conditions = [conditions, uncertainty];
    
    conditionstable = array2table(conditions, 'VariableNames', {'Difficulty', 'Money', 'Rew_magn', 'Uncertainty'});

    output.filename = sprintf('%s/conditions/EATTrain_cond_%s_%06d_%s_R1', pwd, subj.studyID, i_id,subj.study_part_ID);

    save([output.filename '.mat'], 'conditions', 'Value_labels', 'conditionstable')
    
%     output.tablename = sprintf('%s/conditions/grEATTrain_table_%s_%06d_%s_R1.dat', pwd, subj.studyID, i_id,subj.study_part_ID);
%     
%     writetable(conditionstable, output.tablename);


end


%%================================
%%Diff+Rewrd Cond for experiment
%%================================

%%Create difficulty+Incentive conditions for experiment
Money = 1;
Food  = 0;

LowRwrd  = 1;      %1  Cent, kCal / Sec
HighRwrd = 10;    %10 Cent, kCal / Sec

Certainty   = 0; %Bar you have to get higher than
Uncertainty = 1; %Uncertainty box

Value_labels = {'Money', Money; 'Food', Food; 'LowRwrd', LowRwrd; 'HighRwrd', HighRwrd; 'Certainty', Certainty; 'Uncertainty', Uncertainty};

%Levels and Certain/Uncertain combinations
LevelsVect = [64; 65; 66; 67; 68; 69; 70; 71; 72; 73; 74; 75; 76; 77; 78; 79; 80; ...
    81; 82; 83; 84; 85; 86; 87; 88; 89; 90; 91; 92; 93; 94; 95];

LevelsMat       = repmat(LevelsVect, 2, 1);

CertainVect     = repmat(Certainty, 32, 1);

UncertainVect   = repmat(Uncertainty, 32, 1);

CombCertainVect = [CertainVect; UncertainVect];

% Reward combinations

M_low  = [Money, LowRwrd];
M_high = [Money, HighRwrd];
F_low  = [Food, LowRwrd];
F_high = [Food, HighRwrd];

% Matrix with all reward combinations

RwrdCombMat = repmat([M_low; M_high; F_low; F_high], 16, 1);

for i_id = start_range:id_range
    
    conditions = [];

    % Random selection without displacement of indices
    ShfflRwrd = RwrdCombMat(randperm(size(RwrdCombMat,1)),:);
    
    % Combined Matrix of Rwrd and Difficulty/Uncertainty:
    FnlMat = horzcat(LevelsMat, ShfflRwrd, CombCertainVect);
    ShfflFnlMat = randperm(size(FnlMat,1));

    %Create conditions vector, HighDiff and LowDiff alternating
    for k = 1:length(LevelsMat)
        
        next = FnlMat(ShfflFnlMat(k), 1:4);

        conditions = [conditions; next];

    end
    
    conditionstable = array2table(conditions, 'VariableNames', {'Difficulty', 'Money', 'Rew_magn', 'Uncertainty'});
    
    output.filename = sprintf('%s/conditions/EATExp_cond_%s_%06d_%s_R1', pwd, subj.studyID, i_id, subj.study_part_ID);

    save([output.filename '.mat'], 'conditions', 'Value_labels', 'conditionstable')
    
%     output.tablename = sprintf('%s/conditions/grEATExp_table_%s_%06d_%s_R1.dat', pwd, subj.studyID, i_id,subj.study_part_ID);
%     
%     writetable(conditionstable, output.tablename);

end