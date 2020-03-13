% Additional infos for food cues to group pictures in blocks for MR version
% Written by Monja 12.08.2019
clear

load('img_sel_TUE002_fMRI.mat')



% add colum for picture type
for img_indx = 1 : 453
    
   images(img_indx).type = 0; 
    
    
end



% Add picture type according to
% Excel file: N377_FoodPics_NutrientInfo.xslx  (Google Drive path: TUE_general/Resources/Food_cues/Charbonnier)


% 'salt_hc' => salty + high caloric
% 'salt_lc' => salty + low caloric
% 'sweet_hc' => sweet + high caloric
% 'sweet_lc' => sweet + low caloric
% 'NF' => non food

% high caloric = 180kcal pro 100g

images(4).type= 'salt_hc';      % ImageNr 1
images(182).type= 'sweet_hc'; % ImageNr 26
images(304).type= 'sweet_hc'; % ImageNr 37
images(316).type= 'sweet_hc'; % ImageNr 40
images(322).type= 'sweet_hc'; % ImageNr 46
images(340).type= 'salt_lc'; % ImageNr 62
images(347).type= 'salt_lc';   % ImageNr 69
images(369).type= 'sweet_hc'; % ImageNr 89
images(10).type= 'sweet_hc'; % ImageNr 104
images(33).type= 'salt_hc'; % ImageNr 125
images(40).type= 'salt_hc'; % ImageNr 131
images(41).type= 'salt_hc'; % ImageNr 132
images(51).type= 'salt_hc'; % ImageNr 141
images(52).type= 'sweet_lc'; % ImageNr 142
images(54).type= 'sweet_lc'; % ImageNr 144
images(55).type= 'sweet_lc'; % ImageNr 145
images(56).type= 'sweet_lc'; % ImageNr 146
images(58).type= 'sweet_lc'; % ImageNr 148
images(62).type= 'sweet_lc'; % ImageNr 151
images(70).type= 'sweet_lc'; % ImageNr 159
images(72).type= 'sweet_lc'; % ImageNr 160
images(73).type= 'sweet_lc'; % ImageNr 161
images(78).type= 'salt_lc'; % ImageNr 166
images(83).type= 'salt_lc'; % ImageNr 170
images(84).type= 'salt_lc'; % ImageNr 171
images(85).type= 'salt_lc'; % ImageNr 172
images(90).type= 'salt_lc'; % ImageNr 177
images(95).type= 'salt_lc'; % ImageNr 181
images(98).type= 'salt_hc'; % ImageNr 184
images(114).type= 'salt_hc'; % ImageNr 199
images(123).type= 'sweet_lc'; % ImageNr 206
images(176).type= 'sweet_hc'; % ImageNr 254
images(211).type= 'salt_hc'; % ImageNr 286
images(234).type= 'salt_hc'; % ImageNr 306
images(236).type= 'sweet_hc'; % ImageNr 308
images(258).type= 'salt_lc'; % ImageNr 328
images(261).type= 'salt_lc'; % ImageNr 330
images(267).type= 'sweet_hc'; % ImageNr 336
images(298).type= 'sweet_hc'; % ImageNr 364
images(308).type= 'salt_hc'; % ImageNr 373



% count selection

counter = 0;
for img_indx = 1 : 453
    
    if strcmp(images(img_indx).type, 'salt_lc')
        
        counter = counter + 1;
    end
    
end



filename = [pwd '\img_sel_TUE002_fMRI.mat']; %change path/name accordingly
save(filename, 'images')
    


