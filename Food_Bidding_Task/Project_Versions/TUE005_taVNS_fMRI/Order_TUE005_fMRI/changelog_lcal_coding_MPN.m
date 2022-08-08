%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fix coding of stimuli
% Condition file was copied from BEDVAR study (TUE002)
% error in BEDVAR condition file detected:
% Food-Salty-Lowcal coded 1-0-1 instead of 1-0-0
%
% changelog coded by Monja Neuser, 16.05.2020
% Re-codes categorization of Food-Salty-Lowcal images
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load condition file
load('D:\home\sektion\AG_Walter\taVNS\FCR\TUE005\Paradigm\Order_TUE005_fMRI\FCRcond_mat_TUE005_fmri.mat')

% change blocks salty & loow caloric: 
% should be: food == 1 / sweet == 0 / hcal == 0
%
% Block identity (design.rand.order_mat(:, 3) => 2)
% Block IDs to change:
% design.rand.order_mat(:, 2) => [10, 17, 19, 22])
% Set hcal (colum 9) to 0
%
% Block ID 10
design.rand.order_mat(46:50,9) = 0;
% Block ID 17
design.rand.order_mat(81:85,9) = 0;
% Block ID 19
design.rand.order_mat(91:95,9) = 0;
% Block ID 22
design.rand.order_mat(106:110,9) = 0;






% save design matrix
filename = 'D:\home\sektion\AG_Walter\taVNS\FCR\TUE005\Paradigm\Order_TUE005_fMRI\FCRcond_mat_TUE005_fmri.mat';
save(fullfile([filename]),'design');