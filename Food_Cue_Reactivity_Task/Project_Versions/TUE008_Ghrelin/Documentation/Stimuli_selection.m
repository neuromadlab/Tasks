%% FCR Stimuli selection 
% Notes on how stimuli were selected
% For TUE008 we want to balance nr. of stimuli that are high vs. low caloric 
% and sweet vs. salty
% Corinna Schulz 

% Image meta data of 80 Food items that were most used available 
FCR_images_80 = readtable('C:\Users\neuromadlab\SynologyDrive\Tasks\FCR\Documentation\Images_meta_data.xlsx','sheet','Images');
% Image meta data of all possible items 
FCR_all = readtable('C:\Users\neuromadlab\SynologyDrive\Resources\Food_cues\Charbonnier\N377_FoodPics_NutrientInfo.xlsx','sheet','FoodImage_data');

% TUE007 Stimulus Set that was used - 60 Food Items
% Idea: take most stimuli that were previously used, just change a few such
% that categories are equally distributed
load('C:\Users\neuromadlab\Desktop\TUE007\FCR\Order_TUE007\FCRcond_mat_TUE007_000001.mat')
TUE007_food_items = design.stim.image_index(1:60,1); 
TUE007_NF_items = design.stim.image_index(61:end,1); 

% Match TUE007 Stimuli and meta data and plot distribution of stimulus
% qualities 
for i = 1:length(TUE007_food_items)
    TUE007_cat(i,1) = table2array(FCR_images_80(FCR_images_80.Number == TUE007_food_items(i,1), "HighCAL")); 
    TUE007_cat(i,2) = table2array(FCR_images_80(FCR_images_80.Number == TUE007_food_items(i,1), "Sweet_incl_Fruits_")); 
    TUE007_cat(i,3) = table2array(FCR_images_80(FCR_images_80.Number == TUE007_food_items(i,1), "Number")); 
end 

high_and_sweet = TUE007_cat(:,1) == 1 & TUE007_cat(:,2) == 1; 
low_and_sweet = TUE007_cat(:,1) == 0 & TUE007_cat(:,2) == 1; 
high_and_salty = TUE007_cat(:,1) == 1 & TUE007_cat(:,2) == 0; 
low_and_salty = TUE007_cat(:,1) == 0 & TUE007_cat(:,2) == 0; 

number_items_cat = [sum(TUE007_cat(:,1)) sum(TUE007_cat(:,2)) sum(high_and_sweet) sum(low_and_sweet) sum(high_and_salty) sum(low_and_salty) ];
b = bar(number_items_cat, 'facecolor', 'flat'); 
set(gca,'xticklabel',{'Sweet','High', 'High & Sweet','Low & Sweet','High & Salty','Low & Salty'});
yline(60/2,'r')
yline(60/4,'b')
title('TUE007 Food Stimuli Set n = 60')
legend('','50%','25%')
saveas(gcf,'TUE007_Food_items_qualities.jpg')

% For TUE008 adapt the selection slighly, such that equal nr./category
% Inspect meta data of all stimuli
total_high_and_sweet = FCR_images_80.HighCAL == 1 & FCR_images_80.Sweet_incl_Fruits_ == 1; 
total_low_and_sweet = FCR_images_80.HighCAL == 0 & FCR_images_80.Sweet_incl_Fruits_  == 1; 
total_high_and_salty = FCR_images_80.HighCAL == 1 & FCR_images_80.Sweet_incl_Fruits_ == 0; 
total_low_and_salty = FCR_images_80.HighCAL == 0 & FCR_images_80.Sweet_incl_Fruits_  == 0; 

total_number_items_cat = [sum(total_high_and_sweet) sum(total_low_and_sweet) sum(total_high_and_salty) sum(total_low_and_salty) ];

% Check whether already avaialble in TUE007, select 15 from it. Otherwise
% add new stimuli (I added some that were not meat/fish etc). 
TUE008_high_and_sweet = TUE007_cat(ismember(TUE007_cat(:,3), FCR_images_80.Number(total_high_and_sweet)),3); 
TUE008_high_and_sweet = TUE008_high_and_sweet(1:15,1);  %reduce set to 15

TUE008_low_and_sweet = TUE007_cat(ismember(TUE007_cat(:,3), FCR_images_80.Number(total_low_and_sweet)),3); 
TUE008_low_and_sweet = TUE008_low_and_sweet(1:15,1);  %reduce set to 15

TUE008_high_and_salty = TUE007_cat(ismember(TUE007_cat(:,3), FCR_images_80.Number(total_high_and_salty)),3); 
% However pizza slice is too cricical (Image Nr. 18, just so high caloric
% with 251 cal, decided to exchange!)
% stimuli that are low and salty but not yet included in TUE007
new_stim = FCR_images_80.Number(total_high_and_salty);
new_stim = new_stim(~ismember(FCR_images_80.Number(total_high_and_salty), TUE007_cat(:,3))); 
TUE008_high_and_salty(TUE008_high_and_salty==18,1) = new_stim([2],1);  %add cracker with cheese Image Nur 192


TUE008_low_and_salty = TUE007_cat(ismember(TUE007_cat(:,3), FCR_images_80.Number(total_low_and_salty)),3); 
% stimuli that are low and salty but not yet included in TUE007
new_stim = FCR_images_80.Number(total_low_and_salty);
new_stim = new_stim(~ismember(FCR_images_80.Number(total_low_and_salty), TUE007_cat(:,3))); 
TUE008_low_and_salty(13:15,1) = new_stim([2,3,7],1);  %add 3

% Make sure that TASTE TEST Pictures correspond to FCR 
% Taste Test selection: 26, 40, 89, 184, (207), 286, 373
TasteTest = [26,40,89,184,286,373,217]; 
for item=1:length(TasteTest)
    TasteTest_characteristics(item,1) = FCR_all(TasteTest(item),"Description");
    calories = table2array(FCR_all(TasteTest(item),"Energy_kcal_100g_"));
    if calories >= 250
        TasteTest_characteristics(item,2) = array2table(1); %code into high cal
    else 
        TasteTest_characteristics(item,2) = array2table(0); %code into low cal
    end 
    cat = FCR_all(TasteTest(item),"Category");
    if item==5 
        TasteTest_characteristics(item,3) = {'SA'}; %NicNacs are salty not sweet, mistake database"
    else 
        TasteTest_characteristics(item,3) = cat; 
    end 
    TasteTest_characteristics(item,4) = FCR_all(TasteTest(item),"ImageNr");
end 
TasteTest_characteristics.Properties.VariableNames = {'Description','High_Cal','Categorie','Number'};

% taste test has 6 High cal snacks, of which 4 are salty, 3 sweet. Exchange
% with current stimulus set 
TUE008_high_and_sweet(13:15) = TasteTest_characteristics.Number(1:3); 
TUE008_high_and_salty(12:15) =  TasteTest_characteristics.Number(4:end); 

% Final Stimulus Set for TUE008 
TUE008_total_stim_set = [TUE008_high_and_sweet; TUE008_low_and_sweet; TUE008_high_and_salty ;TUE008_low_and_salty ];

figure
number_items_cat = [ length(TUE008_high_and_sweet) length(TUE008_low_and_sweet) length(TUE008_high_and_salty) length(TUE008_low_and_salty) ];
b = bar(number_items_cat); 
set(gca,'xticklabel',{'High & Sweet','Low & Sweet','High & Salty','Low & Salty'});
yline(60/4,'b')
title('TUE008 Food Stimuli Set n = 60')
legend('','25%')
saveas(gcf,'TUE008_Food_items_qualities.jpg')

for i = 1:size(TUE008_total_stim_set,1)
    TUE008_total_stim_meta(i,:) = FCR_all(FCR_all.ImageNr == TUE008_total_stim_set(i,1),:); 
end 

% Save meta data for TUE008 
writetable(TUE008_total_stim_meta,'Images_meta_data_TUE008.xlsx')
% Add NF Items and save .mat for randomization and FCR task
TUE008_total_stim_set = [sort(TUE008_total_stim_set); TUE007_NF_items]; 
save('TUE008_stimulus_set.mat',"TUE008_total_stim_set")

FCR_Food_Stimuli_long = sortrows(TUE008_total_stim_meta,"ImageNr"); 
FCR_Food_Stimuli(:,1) = cell2table(FCR_Food_Stimuli_long.Description); 
FCR_Food_Stimuli(:,2) = table(FCR_Food_Stimuli_long.ImageNr); 

% Greek Salad nr. 182 & Cracker nr 192 not correct in database, replace NaN value 
FCR_Food_Stimuli_long.Energy_kcal_100g_(FCR_Food_Stimuli_long.ImageNr == 182) = FCR_images_80.Energy_kcal_100g_(FCR_images_80.Number==182); 
FCR_Food_Stimuli_long.Energy_kcal_100g_(FCR_Food_Stimuli_long.ImageNr == 192) = FCR_images_80.Energy_kcal_100g_(FCR_images_80.Number==192); 

cal_cat = (FCR_Food_Stimuli_long.Energy_kcal_100g_); 
cal_cat(cal_cat < 250) = 0; 
cal_cat(cal_cat >= 250) = 1; 

FCR_Food_Stimuli(:,3) = table(cal_cat);
FCR_Food_Stimuli(:,4) = table(FCR_Food_Stimuli_long.Category); 
FCR_Food_Stimuli(:,5) = table(FCR_Food_Stimuli_long.Category); 

FCR_Food_Stimuli.Properties.VariableNames = {'Description','ImageNr','CaloricCategory','NaN','FoodCategory'}; 

FCR_NonFood_Stimuli = TUE007_NF_items; 
save('TUE008_FCR_Food_Stimuli.mat',"FCR_Food_Stimuli")
save('TUE008_FCR_NonFood_Stimuli.mat',"FCR_NonFood_Stimuli")

% Plot exact kcal values  
equal_n = 15; %how many items per category 
Cat1 = table2array(TUE008_total_stim_meta(1:equal_n,"Energy_kcal_100g_")); 
Cat2 = table2array(TUE008_total_stim_meta(equal_n+1:2*equal_n,"Energy_kcal_100g_")); 
Cat3 = table2array(TUE008_total_stim_meta(2*equal_n+1:3*equal_n,"Energy_kcal_100g_")); 
Cat4 = table2array(TUE008_total_stim_meta(3*equal_n+1:4*equal_n,"Energy_kcal_100g_")); 

figure
histogram(Cat1, 'BinWidth', 10)
hold on 
histogram(Cat2,'BinWidth', 10)
hold on 
histogram(Cat3, 'BinWidth',10)
hold on 
histogram(Cat4, 'BinWidth', 10)
xline(250, 'r')
legend('High and sweet','Low and sweet', 'High and salty','Low and salty','>250: High caloric')
title('TUE008 Stimulus set Caloric distribution')
xlabel('Energy in kcal/100g')
saveas(gcf,'TUE008_Food_items_calories.jpg')


