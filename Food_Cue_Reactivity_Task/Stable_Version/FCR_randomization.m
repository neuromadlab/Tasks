% ====================================================================== & 
% ================= Randomization FCR Stimuli ========================== %
% ====================================================================== & 
% This script shuffles the Food and Non-Food Stimuli for the FCR from a
% folder with the selected stimuli that are to be used in the respective 
% study. Further it initializes the Jitter variable needed to set the
% waiting times between stimuli presentations. 

% Created: July 2021 by Corinna Schulz 
% contact: corinna.schulz96@gmail.com 

clearvars

% settings: please adapt these for your study before running the script!
study.name = 'TUE008' ; 
study.sessions = 1; 
study.participants = 50; 
study.pilot = 1; %set 1 to create randomization for pilot

% load Food and Non-Food Tables, with indices of stimuli to be used  
load('C:\Users\neuromadlab\SynologyDrive\Tasks\FCR\Project_Versions\FCR_Images\TUE008\Documentation\TUE008_FCR_Food_Stimuli.mat');
load('C:\Users\neuromadlab\SynologyDrive\Tasks\FCR\Project_Versions\FCR_Images\TUE008\Documentation\TUE008_FCR_NonFood_Stimuli.mat');
stimuli_indeces = FCR_Food_Stimuli.ImageNr; 

% concatenate Food and NonFood Stimuli 
stimuli_all = [stimuli_indeces; FCR_NonFood_Stimuli];
n_trials = length(stimuli_all); 
total_trials = 2*n_trials; %trials are shown twice, linking and wanting

% Create Jitter (same across participants& sessions, thus only called once)
mu_jitter = 0.7; % set here mean waiting time (sec)
max_delay = 4; % set here max waiting time (sec)
ComputeJitter_exp(mu_jitter, max_delay, total_trials)  %attention: ComputeJitter_exp.m needs to be in the experimental folder to call function) 

% prepare image filenames (.jpg)
for img = 1:length(stimuli_all)
    if contains(string(stimuli_all(img)),'99')
       char_strip = char(string(stimuli_all(img)));
       if char_strip(3) == "0"
           char_strip = char_strip(4);
       else
           char_strip = char_strip(3:4);
       end 
       image_filenames{img,1} = string(['NF_',char_strip,'.jpg']);
    else 
       char_strip = char(string(stimuli_all(img)));
       image_filenames{img,1} = string([char_strip,'.jpg']);
    end 
end 

% create folder to save subject and session randomization order
if ~exist([pwd, filesep,'Order_',study.name], 'dir')
    mkdir([pwd, filesep, 'Order_',study.name])
end 

% create per participant random display of stimuli and random order of
% liking and wanting assessment
for n = 1:study.participants
    
    % 1. randomly determine per stimuli whether first liking or wanting is assessed
    % 0 = liking, 1 = wanting
    coin = [];
    coin_flipped = [];
    for ind_flip = 1:study.sessions
        % create vector of 1 and 0 for trial length
        flip_coin = [zeros((n_trials/2),1); ones((n_trials/2),1)];
        % randomize order of 1 and 0
        flip_coin = Shuffle(flip_coin);
        % create mirrored values for the 2nd run
        other_coin = (1 - flip_coin);
        % add vectors to full session matrix
        coin = [coin, flip_coin];
        coin_flipped = [coin_flipped, other_coin];
    end
    
    % 2. randomly determine stimuli order for each session
    images_rand = []; %for index of stimuli
    images_filenames_rand = []; %for .jpg stimuli
    for ind_rand = 1:study.sessions % 2 orders per session - for liking and wanting
        % randomize order of images
        index = Shuffle(1:n_trials)';
        images = stimuli_all(index);
        image_files_rand = image_filenames(index);
        % add vectors to full images order
        images_rand = [images_rand, images];
        images_filenames_rand = [images_filenames_rand, image_files_rand];
    end
    
    % 3. Per Session we need two runs, with random stimuli order but
    % corresponding liking and wanting, so put step 1 and step 2 together
    final_randomized_images = [];
    final_randomized_question = [];
    final_randomized_images_files = [];
    for run_reps = 1:study.sessions
        index = 1:n_trials;
        second_run_randomized(:,run_reps) = Shuffle(index)';
        % Use the same randomly created index to shuffle images and liking/wanting order
        second_run_randomized_images(:,run_reps) = images_rand(second_run_randomized(:,run_reps),run_reps);
        second_run_randomized_images_files(:,run_reps) = images_filenames_rand(second_run_randomized(:,run_reps),run_reps);
        second_run_flipped_coin(:,run_reps)  = coin_flipped(second_run_randomized(:,run_reps),run_reps);
        
        final_randomized_images = [final_randomized_images, images_rand(:,run_reps), second_run_randomized_images(:,run_reps)];
        final_randomized_question = [final_randomized_question, coin(:,run_reps), second_run_flipped_coin(:,run_reps)];
        final_randomized_images_files = [final_randomized_images_files, images_filenames_rand(:,run_reps), second_run_randomized_images_files(:,run_reps)];
        
    end
    
    % For each subject, save matrix with settings
    % 1. Stimuli used (as index and as file jpg.name)
    design.stim.image_index = stimuli_all;
    design.stim.image_files = image_filenames;
    
    % 2. Randomized order of Liking/wanting (full_flip_coin), images and
    % image filenames
    design.rand.full_flip_coin = final_randomized_question;
    design.rand.image_mat = final_randomized_images;
    design.rand.image_file = final_randomized_images_files;
    
    % Order mat: longformat
    long_images_rand = [];
    run_repetitions = [];
    for runs = 1:(study.sessions*2)
        long_images_rand = [long_images_rand;  final_randomized_images(:,runs)] ;
        run_repetitions = [run_repetitions; runs*ones(n_trials,1)];
    end
    
    design.rand.order_mat(1:n_trials*study.sessions*2,1) = 1:(n_trials*study.sessions*2); %row index
    design.rand.order_mat(:,2) = run_repetitions; %run repetition (per session 2 runs)
    design.rand.order_mat(:,3) = long_images_rand; %Image index
    
    % Add Picture Classification (SW/SA and High/Low Caloric)
    for item = 1:size(design.rand.order_mat,1)
        if ~isempty(find(FCR_Food_Stimuli.ImageNr == long_images_rand(item), 1))
            FoodCategory_string = string(FCR_Food_Stimuli.FoodCategory(find(FCR_Food_Stimuli.ImageNr == long_images_rand(item))));
            if FoodCategory_string == "SW"
                FoodCategory(item,1) = 1;
            elseif FoodCategory_string == "SA"
                FoodCategory(item,1) = 0;
            end
            
            Calorie_nr = FCR_Food_Stimuli.CaloricCategory(find(FCR_Food_Stimuli.ImageNr == long_images_rand(item)));
            if Calorie_nr == 1
                CaloricCategory(item,1) = 1;
            elseif Calorie_nr == 0
                CaloricCategory(item,1) = 0;
            end
        else % Non-Food Item, hence, no classification
            FoodCategory(item,1) = NaN;
            CaloricCategory(item,1) = NaN;
        end
    end
    
    design.rand.order_mat(:,4) = FoodCategory;
    design.rand.order_mat(:,5) = CaloricCategory;
    
    design.rand.order_mat_labels = ["row_index","repetition", "img_index", "food_category_sweet", "caloric_category_high"]';
    
    
    %% Save order files
    % Create participant number (for pilot and real exp. separate)
    if study.pilot == 0
        subj_ind = pad(num2str(n),6,'left','0');
    elseif study.pilot == 1
        subj_ind = ['9' pad(num2str(n),5,'left','0')];
    end
    
    % save design structure for each participant
    save([pwd,filesep, 'Order_',study.name,filesep,'FCRcond_mat_',study.name,'_',subj_ind, '.mat'],'design')
    
end
