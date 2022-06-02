%%======EATmain_ Randomise Conditions=======
%Script for creating condition files -18/06/2017-
%author: Monja P. Neuser, Mechteld van den Hoek Ostende

%Percent of MaxFreq between 64% and 95%
%Includes uncertainty condition (in Exp run)
%===========================================

subj.studyID = 'TUE009'; %Prefix of Seedcorn project
subj.study_part_ID = {'S2','S3','S4','S5'}; %indicates session, always S1
start_range = 000001;
id_range = 000095;    %

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

for i_session = 1:size(subj.study_part_ID,2)
    for i_id = start_range:id_range
        
        conditions_all = [];
        
        %Random selection without displacement of indices
        perm_i_LowDiff = randperm(length(LowDiff_vector));
        perm_i_HighDiff = randperm(length(LowDiff_vector));
        
        
        %Create conditions vector, HighDiff and LowDiff alternating
        for k = 1:length(LowDiff_vector)
            
            l_k = LowDiff_vector(perm_i_LowDiff(k),1:3);
            h_k = HighDiff_vector(perm_i_HighDiff(k),1:3);
            
            if mod(i_id,2)
                conditions_all = [conditions_all; l_k; h_k];
            else
                conditions_all = [conditions_all; h_k; l_k];
            end
            
        end
        
        uncertainty = zeros(length(conditions_all),1);
        
        conditions_all = [conditions_all, uncertainty];
        
        conditionstable = array2table(conditions_all, 'VariableNames', {'Difficulty', 'Money', 'Rew_magn', 'Uncertainty'});
        
        output.filename = sprintf('%s/conditions/EATTrain_cond_%s_%06d_%s_R1', pwd, subj.studyID, i_id,subj.study_part_ID{i_session});
        
        save([output.filename '.mat'], 'conditions_all', 'Value_labels', 'conditionstable')
        
        %     output.tablename = sprintf('%s/conditions/grEATTrain_table_%s_%06d_%s_R1.dat', pwd, subj.studyID, i_id,subj.study_part_ID);
        %
        %     writetable(conditionstable, output.tablename);
        
        
    end
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
LevelsVect = [60:3:90];

LevelsMat       = repmat(LevelsVect', 8, 1);

CertainVect     = repmat(Certainty, 44, 1);

UncertainVect   = repmat(Uncertainty, 44, 1);

CombCertainVect = [CertainVect; UncertainVect];

% Reward combinations

M_low  = [Money, LowRwrd];
M_high = [Money, HighRwrd];
F_low  = [Food, LowRwrd];
F_high = [Food, HighRwrd];

% Matrix with all reward combinations

RwrdCombMat = repmat([M_low; M_high; F_low; F_high], 22, 1);


for i_session = 1:2 %two sets of the same data split up into two sessions each
    
    conditions_all = [];
    
    % Random selection without displacement of indices
    ShfflRwrd = RwrdCombMat(randperm(size(RwrdCombMat,1)),:);
    
    % Combined Matrix of Rwrd and Difficulty/Uncertainty:
    FnlMat = horzcat(LevelsMat, RwrdCombMat, CombCertainVect);
    
    x1 = 0;
    x2 = 0;
    x3 = 0; 
    x4 = 0;
    
   while (x1 < 0.45 || x1 > 0.55) && (x2 < 0.45 || x2 > 0.55) && (x3 < 72 || x2 > 78) && (x4 < 5.4 || x4 > 5.5)
    
    ShfflFnlMat = randperm(size(FnlMat,1));
    FnlMat_shuffeld = FnlMat(ShfflFnlMat,:);
    
    
    x1 = mean(FnlMat_shuffeld(:,2));
    x2 = mean(FnlMat_shuffeld(:,4));
    x3 = mean(FnlMat_shuffeld(:,1));
    x4 = mean(FnlMat_shuffeld(:,3));
    
   end  
    
    
    
    for i_id = start_range:id_range
        
        
        
        %Create conditions vector,
        conditions_all = FnlMat_shuffeld(1:44,:);
        conditions_all(:,:,2) = FnlMat_shuffeld(45:88,:);
        

        
        for i_s = 1:2 %split data in two sessions
        
            conditionstable = array2table(conditions_all(:,:,i_s), 'VariableNames', {'Difficulty', 'Money', 'Rew_magn', 'Uncertainty'});
            conditions = squeeze(conditions_all(:,:,i_s)); 
            output.filename = sprintf('%s/conditions/EATExp_cond_%s_%06d_%s_R1', pwd, subj.studyID, i_id, subj.study_part_ID{(i_session-1)*2+i_s});
        
            save([output.filename '.mat'], 'conditions', 'Value_labels', 'conditionstable')
        end 
        %     output.tablename = sprintf('%s/conditions/grEATExp_table_%s_%06d_%s_R1.dat', pwd, subj.studyID, i_id,subj.study_part_ID);
        %
        %     writetable(conditionstable, output.tablename);
        
    end
    
end