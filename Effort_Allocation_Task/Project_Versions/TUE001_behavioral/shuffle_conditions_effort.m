

%%======Effort allocation task_ Randomise Conditions=======
% Script for creating condition files - 18/06/2017 -
% Updated for new naming scheme - 29/10/2018 -
% author: Monja P. Neuser
%
% Creates condition files to run EffortAllocation_task14.m
% Randomize condition order
% 8 Conditions for Training
% 48 Conditions for behav. experiment (TUE001)
% 24 Conditions for fMRI experiment (TUE001 / TUE002)
%========================================================


clc
clear all

%%=========================
%%Conditions for training
%%=========================
%%Create difficulty+Incentive conditions for experiment
Money = 1;
Food = 2;

LowRwrd = 1;      %1  Cent, kCal / Sec
HighRwrd = 10;    %10 Cent, kCal / Sec

LowDiff = 75; %percent of MaxFreq
HighDiff = 85; %percent of MaxFreq

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


for i_id = 990:994
   
    
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

    output.filename = sprintf('%s\\conditions\\EAT-cond-Training_TUE001_0%03d_S5_R1', pwd, i_id);

    save([output.filename '.mat'], 'conditions', 'Value_labels')


end


%%================================
%%Diff+Rewrd Cond for experiment
%%================================

%%Create difficulty+Incentive conditions for experiment
Money = 1;
Food = 2;

LowRwrd = 1;      %1  Cent, kCal / Sec
HighRwrd = 10;    %10 Cent, kCal / Sec

LowDiff = 75; %percent of MaxFreq
HighDiff = 85; %percent of MaxFreq

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


% % For 48 Trials (TUE001_behav)
% % Condition vector
LowDiff_vector = repmat([LowDiff_M_low; LowDiff_M_high; LowDiff_F_low; LowDiff_F_high], 6, 1);
HighDiff_vector = repmat([HighDiff_M_low; HighDiff_M_high; HighDiff_F_low; HighDiff_F_high], 6, 1);


for i_id = 990:994
    
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

    output.filename = sprintf('%s\\conditions\\EAT-cond-Experiment_TUE001_0%03d_S5_R1', pwd, i_id);

    save([output.filename '.mat'], 'conditions', 'Value_labels')


end