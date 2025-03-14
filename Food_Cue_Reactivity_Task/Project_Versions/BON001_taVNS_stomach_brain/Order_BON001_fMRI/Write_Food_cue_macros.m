% Create mean centered information about carbs & fat for FCR parametric
% modulation

%load design file including all needed information (trials, image numbers,
%macros)
load('X:\Tasks\FCR\Project_Versions\BON001\Order_BON001_fMRI\FCRcond_mat_BON001_fmri.mat')

Image_number_food_cues = design.rand.order_mat(:,design.rand.order_mat_labels == 'img_index');
trial = design.rand.order_mat(:,design.rand.order_mat_labels == 'row_index');

Fat=design.rand.order_mat(:,design.rand.order_mat_labels == 'fat');
%exclude nonfood stimuli
Fat(design.rand.order_mat(:,design.rand.order_mat_labels == 'food')==0)=NaN;
%mean center fat data
Fat=Fat-mean(Fat(~isnan(Fat)));

Carbs=design.rand.order_mat(:,design.rand.order_mat_labels == 'carbs');
%exclude nonfood stimul
Carbs(design.rand.order_mat(:,design.rand.order_mat_labels == 'food')==0)=NaN;
%mean center carbs data
Carbs=Carbs-mean(Carbs(~isnan(Carbs)));

%calculate interaction
Fat_x_Carbs = Fat.*Carbs;

%create table containing all variables
Food_cue_macros=table(Image_number_food_cues,trial,Fat,Carbs,Fat_x_Carbs);

%save table
writetable(Food_cue_macros,'X:\Tasks\FCR\Project_Versions\BON001\Order_BON001_fMRI\Food_cue_macros.csv')