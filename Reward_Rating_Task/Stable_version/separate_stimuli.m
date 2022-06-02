
%male images
clear img_file
images = dir('07_Stimuli/Erotic_Stimuli/GlucoseRPE_Erotic/Male/*jpg');
food_img = dir('07_Stimuli/Food_Stimuli/*jpg');
music = dir('07_Stimuli/Musik_Stimuli/Music_Samples_cut/*mp3');
music = music(~contains({music.name}, 'long'));

for i_im = 1:length(images)
    
   img = imread([images(i_im).folder,filesep,images(i_im).name]); 
   img_file{i_im} = images(i_im).name;
  
   music_file{i_im} = music(i_im).name;
   stimuli.erotic{i_im} = img; 
   
end
 
food_file = natsortfiles({food_img.name});
img_file = [food_file';img_file';music_file'];
img_file(:,2) = num2cell([nan(20,1);ones(20,1);nan(20,1)]);
img_file(:,3) = num2cell([1;1;0;1;1;1;0;0;0;1;1;1;1;1;0;0;0;0;0;0;nan(40,1)]);
img_file(:,4) = num2cell([1;1;0;1;1;1;1;1;1;0;0;0;0;0;0;0;0;0;1;1;nan(40,1)]);


save('stimuli_male.mat','stimuli','img_file')


%male images
images = dir('07_Stimuli/Erotic_Stimuli/GlucoseRPE_Erotic/Female/*jpg');

clear img_file
for i_im = 1:length(images)
    
   img = imread([images(i_im).folder,filesep,images(i_im).name]); 
   img_file{i_im} = images(i_im).name;
    
   stimuli.erotic{i_im} = img; 
   
end
img_file = [food_file';img_file';music_file'];
img_file(:,2) = num2cell([nan(20,1);zeros(20,1);nan(20,1)]);
img_file(:,3) = num2cell([1;1;0;1;1;1;0;0;0;1;1;1;1;1;0;0;0;0;0;0;nan(40,1)]);
img_file(:,4) = num2cell([1;1;0;1;1;1;1;1;1;0;0;0;0;0;0;0;0;0;1;1;nan(40,1)]);

save('stimuli_female.mat','stimuli','img_file')

%find old stimuli
clear stimuli 
load('stimuli.mat')
clear img_file 
images = dir('07_Stimuli/Erotic_Stimuli/GlucoseRPE_Erotic/*/*jpg');
n = 1;
for i_im = 1:length(images)
    
   img = imread([images(i_im).folder,filesep,images(i_im).name]); 
   n = 1;
   while n>0 && n < 21
        test = all(img == stimuli.erotic{n},'all');
        if test == 1
            break
        end
        n = n+1;
   end 
   
   if test == 1
   img_file{n} = images(i_im).name;
   end
  
end

img_file = [food_file';img_file';music_file'];
img_file(:,2) = num2cell([nan(20,1);repmat([1;0],10,1);nan(20,1)]);
img_file(:,3) = num2cell([1;1;0;1;1;1;0;0;0;1;1;1;1;1;0;0;0;0;0;0;nan(40,1)]);
img_file(:,4) = num2cell([1;1;0;1;1;1;1;1;1;0;0;0;0;0;0;0;0;0;1;1;nan(40,1)]);
save('stimuli.mat','stimuli','img_file')
