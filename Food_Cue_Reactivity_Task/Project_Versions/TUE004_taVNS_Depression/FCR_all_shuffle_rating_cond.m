% Shuffle Script 
% Creates shuffled condition files for Food Cue Reactivity task
% creates a mat files with the conditions (order of image and scale presentation)
% for FCR_all.mat paradigm as used in TUE004 study
%
% condition files contain the following variables:
% design.stim: contains information about the stimuli used in the task
% design.rand: contains information about the (individual) order of stimuli and scales
%   design.rand.full_flip_coin == 0 -> call LHS (Liking)
%   design.rand.full_flip_coin == 0 -> call VAS (Wanting)
% 
%
% the design.rand.image_file has the following format:
% 4 colums -> 4 runs
% 120 rows -> 120 images 
% (will be shown twice per session [Run 1&2] with LHS & VAS respctively)
%
% Source: folder 'Stimuli' /contains all Stimuli created by Charbonnier et
% al (2014)

% Adapted by Monja, October 2019



clear


%% settings

% Does this condition/image selection case exist already? 0 = no, 1 = yes
Shuffle_Cond_Version = 1; %1=behav&food / 2=behav&NF / 3=fMRI&food&NF 
% Create pilot or experiment condition files: 0 = pilot / 1 = participant
create_exp_files = 1;
% Selection of images has been completed 0= no / 1 = yes
selection_exists = 1;
% For BEDVAR MRI version:
% Some NF images have to be re-ordered after randomization
BEDVAR_NF = 0; %change to 0 if randomization script is used for other studies


% set study parameters:
% stduy ID: used to load/save selection list / order files
%   study_ID = 'TUE002';
	study_ID = 'TUE004';

% Participants
    if create_exp_files == 1 
        n_subj = 100;
    else  % For pilot condition files
        n_subj = 20;
    end


    
% Paths
% project_path = 'C:\Users\Monja\Google Drive\TUE_general\Tasks\FCR\FCR_beh\TUE002_FCR_behav';
project_path = 'C:\Users\Monja\Google Drive\TUE_general\Tasks\FCR\FCR_beh\TUE004_FCR_behav';

% Full stimulus ste as created by Charbonnier, 2014
stim_directory = 'C:\Users\Monja\Google Drive\TUE_general\Tasks\FCR\FCR_beh\Stimuli';
% Studies will use subsets as defined in "img_sel_%studyID_....m" 

order_directory = [project_path '\Order'];

%% Manual image selection
if selection_exists == 0
    
    %Load full images set
    images = dir(stim_directory); % read all images available
    
    % Add new variable 'select', pre-defined with 0
    % and add new variable 'type'
    for i = 1:length(images)
     
        images(i).select = 0;
        images(i).type = 0;
    
    end
    % Manually select  which photos to use in current run by setting
    % .select to 1
    % 0 = not in use, 1 = in use

    % Add type of images: 'salt_hc' / 'salt_lc' / 'sweet_hc' / 'sweet_lc' / 'NF'

    % save files depending on case (path and or file name)
    
    switch Shuffle_Cond_Version
        case 1
            filename = [project_path '\img_sel_' study_ID '_beh.mat']; %change path/name accordingly
        case 2
            filename = [project_path '\img_sel_' study_ID '_NF.mat'];
        case 3
            filename = [project_path '\img_sel_' study_ID '_fMRI.mat'];
    end
    
    save(filename, 'images')
    
sprintf('Please run script again, set VARIABLE "selection_exists" = 1')
    
end   

if selection_exists == 1     % Selection exists    
%% Prepare shuffled condition files   
    

    % Load file with image list to be used

    switch Shuffle_Cond_Version
        case 1
            sel_filename = [project_path '\img_sel_' study_ID '_beh.mat'];
        case 2
            sel_filename = [project_path '\img_sel_' study_ID '_NF.mat'];
        case 3
            sel_filename = [project_path '\img_sel_' study_ID '_fMRI.mat']; 
    end
    
    load(sel_filename)
    
    % Extract image files being used
    images([images.select] == 0) = [];
    
    

%% For behavioral testing   
if (Shuffle_Cond_Version == 1 || Shuffle_Cond_Version == 2)


%% Create order scripts

    if strcmp(study_ID, 'TUE002') && Shuffle_Cond_Version == 1 

        n_reps = 4;
        n_trials = 60;

    elseif  strcmp(study_ID, 'TUE002') && Shuffle_Cond_Version == 2

        n_reps = 4;
        n_trials = 20;
        
    else % e.g. for TUE004
        
        n_reps = 4;
        n_trials = 80;

    end

        sep_trial_vect = (1:n_trials)';
        cont_trial_vect = (1:n_trials*n_reps)';
        full_design_mat = [];



    % Randomization; 0 for liking, 1 for wanting

    % For behavioral part, create order file for eacht subject
    for ind = 1:n_subj

        full_flip_coin = [];

        for ind_flip = 1:(n_reps/2)
            flip_coin = [zeros((n_trials/2),1); ones((n_trials/2),1)];
            flip_coin = Shuffle(flip_coin);
            run_flip_coin = [flip_coin (1 - 1 .* flip_coin)];
            full_flip_coin = [full_flip_coin run_flip_coin];
        end

        image_index = [];
        for ind_ima = 1:length(images)

            image_temp_str = strtok(images(ind_ima).name, '.');

            if strcmp(strtok(images(ind_ima).name, '_'), 'NF')

                if length(image_temp_str) == 5

                image_index(ind_ima,1) = str2double(['99' image_temp_str(4:end)]);

                else

                image_index(ind_ima,1) = str2double(['990' image_temp_str(4:end)]);

                end

            else

                image_index(ind_ima,1) = str2double(image_temp_str);

            end

        end

        %cell array with all images to be shuffled
        image_files = {images(1:length(images)).name}';


        %% Shuffling

        for ind_flip = 1:(n_reps/2)
            [rand_image_ind, order] = Shuffle(image_index); % 2 outputs
            order_r2 = Shuffle(order);
            rand_image_mat(:,ind_flip*2-1) = image_index(order);
            rand_image_mat(:,ind_flip*2) = image_index(order_r2);
            rand_image_file(:,ind_flip*2-1) = image_files(order);
            rand_image_file(:,ind_flip*2) = image_files(order_r2);
            r2_flip_coin = full_flip_coin(:,ind_flip*2);
            full_flip_coin(:,ind_flip*2-1) = full_flip_coin(order,ind_flip*2-1);
            full_flip_coin(:,ind_flip*2) = r2_flip_coin(order_r2);
        end



        design.stim.image_files = image_files;
        design.stim.image_index = image_index;
        design.rand.full_flip_coin = full_flip_coin;
        design.rand.image_mat = rand_image_mat;
        % design.rand.order = order;
        % design.rand.order_r2 = order_r2;
        design.rand.image_file = rand_image_file;


        design.rand.order_mat(1:n_trials*n_reps,1) = 1:(n_trials*n_reps); %row index
        design.rand.order_mat(:,2) = NaN; %block index (relevant for MR block design)
        design.rand.order_mat(:,3) = NaN; %block type (relevant for MR block design)
        design.rand.order_mat(:,4) = NaN; %block id (relevant for MR block design)
        
        %Rearrange design matrix to long format
        for i_rep=1:n_reps
        design.rand.order_mat((((i_rep-1)*n_trials)+1):(i_rep*n_trials),5) = i_rep;
            for i_img = 1:n_trials
                img_mat = design.rand.image_mat(i_img,i_rep);
                img_file = design.rand.image_file(i_img,i_rep);
                design.rand.order_mat((((i_rep-1)*n_trials)+i_img),6) = img_mat; % image name
                
                % Add coding of picture type to design matrix
                find_img = 0;
                for idx = 1:n_trials
                    if strcmp(char(img_file),images(idx).name)
                    find_img = idx;
                    end
                end
                
                
                switch images(find_img).type
              case 'salt_hc'
                 img_spec = [1 0 1]; % food / not sweet / hcal
              case 'salt_lc'
                 img_spec = [1 0 1]; % food / not sweet / not hcal
              case 'sweet_hc'
                 img_spec = [1 1 1]; % food / sweet / hcal
              case 'sweet_lc'
                 img_spec = [1 1 0]; % food / sweet / not hcal
              case 'NF'
                  img_spec = [0 0 0]; % not food / not sweet / not hcal                 
                end

                
                design.rand.order_mat((((i_rep-1)*n_trials)+i_img),7:9) = img_spec;

            end
        end
        
        
 design.rand.order_mat_labels = [1:9;...
                                        "row_index", "block_index", "block_type", "block_id", ...
                                        "block_repetition", "img_index", "food", "sweet", "high_cal"]';
        

        %% Save order files
        if create_exp_files == 1 
            subj_ind = pad(num2str(ind),6,'left','0');
        else
            subj_ind = ['9' pad(num2str(ind),5,'left','0')];
        end



        if Shuffle_Cond_Version == 1
                save([project_path '\Order\FCRcond_mat_' study_ID '_' subj_ind '.mat'],'design')
        else %Shuffle_Cond_Version == 2 
                save([project_path '\Order_TUE002_NF/FCRcond_mat_' study_ID '_', subj_ind, '.mat'],'design')
        end


    end

else %Shuffle_Cond_Version == 3

    % Prepare Block randomization   
    block_mat = [];
    design.rand.order_mat = [];
    %block_array = [];
       
    % Settings        
    n_subj = 1; % For fMRI, all subjs will be presented tha same order
    n_trials = 60; % 60 images for one repetition
    n_reps = 2; % all image blocks are shown twice
    img_per_block = 5;    
    
    % Initiate image type
    image_type = {1 2 3 4 5;'salt_hc' 'salt_lc' 'sweet_hc' 'sweet_lc' 'NF'};
    % Numerical vector 4 blocks (1:4) food images, 2 blocks (5) NF
    block_type = [cell2mat(image_type(1,:)) 5];
    % Prepare full vector of blocks (unique ID) for all images
    block_type_long = [block_type block_type]; % of length = 12
    % Dublicate block indices to fit number of trials (5 images per block)
    block_vect = repelem(block_type_long,  img_per_block)'; % of length = 60
%     sep_trial_vect = (1:n_trials)';
%     cont_trial_vect = (1:n_trials*n_reps)';
    
       
          %% Randomization of blocks
          
          % Duplicate all block IDs (for second repetition)
          all_blocks = [[block_type_long, block_type_long]; ...%Block type
                        [1:length(block_type_long), 1:length(block_type_long)]]; %Block ID
          rand_blocks = all_blocks;
          [rand_blocks_m, rand_blocks_n] = size(rand_blocks);
          % Randomize order, avoid two subsequent similar blocktypes
            while ~all(diff(rand_blocks(1,:)))
                rand_blocks = datasample(rand_blocks,rand_blocks_n,rand_blocks_m,'Replace',false);  
            end
            % Add row for repetition labels
            rand_blocks(3,:) = zeros(1,length(rand_blocks));          

          %Mark repetition of Block ID
          for i_block = 1 : length(rand_blocks)
             
              if rand_blocks(3,i_block) == 0 %IF not labeled so far
                  
                  rand_blocks(3,i_block) = 1; % set first repetition
                  
                  rep_i_block = find((rand_blocks(2,:) == rand_blocks(2,i_block)));
                  rep_i_block = rep_i_block(end);
                  
                  rand_blocks(3,rep_i_block) = 2; % set second repetition
                  
              end
                  
          end
          
          % Add block randomizaton to design matrix 
          design.rand.order_mat(:,1) = [1:(length(block_vect)) * n_reps']; % running number for all 120 trials
          design.rand.order_mat(:,2) = repelem([1:(length(block_type_long) * n_reps)],  img_per_block); % Block index in task
          design.rand.order_mat(:,3:5) =  repelem(rand_blocks', img_per_block, 1); % Block ID and repetition 
          
         
 %% Randomly Assign images to blocks   
          
     
      % Extract image indices for selected stimuli
      for ind_t_ima = 1:length(images)
            image_temp_str = strtok(images(ind_t_ima).name, '.');
            
            if strcmp(strtok(images(ind_t_ima).name, '_'), 'NF')
                
                if length(image_temp_str) == 5
                
                image_index(ind_t_ima,1) = str2double(['99' image_temp_str(4:end)]);
                
                else
                
                image_index(ind_t_ima,1) = str2double(['990' image_temp_str(4:end)]);
                
                end
                
            else
                
                image_index(ind_t_ima,1) = str2double(image_temp_str);
              
            end
         
        end
    
        %cell array with all images to be shuffled
        image_files = {images(1:length(images)).name}';
        image_types = {images(1:length(images)).type}';
        image_files_typed = [image_files, image_types];
 
        
        rand_image_ind = [];
        order = [];
        track_draws = image_files_typed;  
        
        % Initiate matrix for randomized image assignment
        block_mat(:,1) = [1:length(block_vect)']; % running index (length 60)
        block_mat(:,2) = repelem([1:length(block_type_long)],  img_per_block); % Block index (1:12)
        block_mat(:,3) = block_vect; % Block type, sorted
        
        
        
        %%Assign images to blocks
     
        for i_image = 1 : length(block_mat)
            
            %Determine image type at index i_image from block array
            curr_image_type = block_mat(i_image,3);

            %Go through image vector, draw randomly until image_type fits
            type_match = 0;
            in_list = 0;

            while all([type_match in_list]) == 0
            
                rand_index = randsample(1:length(image_files_typed), 1);
                drawn_file = image_files_typed(rand_index,1);
                drawn_type = image_files_typed(rand_index,2);

             %Check if type of drawn image matches currrent block type
             %YES -> set 1, break loop
             type_match = isempty(setdiff(image_type(2,curr_image_type), drawn_type));
            
             % Check if drawn image is still in track_draws list
             % YES -> set 1, break loop
             % NO -> leave 0 (image is not eligible anymore)
             in_list = any(any(ismember(track_draws, drawn_file)));
            
            end
                find_draw = find(ismember(track_draws, drawn_file));
                track_draws(find_draw,:) = [];

                % Parallel store image index (_mat) and image file name (_file) 
                assign_image_mat(i_image) = rand_index;
                assign_image_file(i_image) = drawn_file;
                
        end
 
        % Add image index to block mat
        block_mat(:,4) = assign_image_mat;
        %block_mat(:,5) = rand_image_file;    
    
        
        % Swop NF images to have one that contains all available otpions for lottery in BEDVAR version
        % Have in one block: idx 43 / 45 / 46/59/50
        if BEDVAR_NF == 1
           
           block_mat([53,22],4) =  block_mat([22,53],4);
           block_mat([52,21],4) =  block_mat([21,52],4);
           block_mat([28,51],4) =  block_mat([51,28],4);
           block_mat([54,60],4) =  block_mat([60,54],4);

           
           assign_image_mat([53,22]) =  assign_image_mat([22,53]);
           assign_image_mat([52,21]) =  assign_image_mat([21,52]);
           assign_image_mat([28,51]) =  assign_image_mat([51,28]);
           assign_image_mat([54,60]) =  assign_image_mat([60,54]);

           assign_image_file([53,22]) =  assign_image_file([22,53]);
           assign_image_file([52,21]) =  assign_image_file([21,52]);
           assign_image_file([28,51]) =  assign_image_file([51,28]);
           assign_image_file([54,60]) =  assign_image_file([60,54]);

           
           
        end
        
            
      %% Assign image blocks to block order
    % Add colum of NaNs to design matrix to be filled with image number
      design.rand.order_mat(:,end+1) = NaN;
      
      for i_designmat = 1: length(design.rand.order_mat(:,1))
         
         % Extract Block ID (from 1:12)
         design_block_ID = design.rand.order_mat(i_designmat,4);
         
            
        %Add images block-wise, align with first image from block
        if mod(i_designmat,img_per_block) == 1
        
           % Find Block in Block mat with corresponding images
          isol_block = block_mat((block_mat(:,2)==design_block_ID),:) ; 
          % Check position in matrix to also track files
          block_position = isol_block(:,1);
          %isolate images from matrix
          isol_imgs = isol_block(:,end);  
          
          % Add image vector to design matrix
          design.rand.order_mat(i_designmat:(i_designmat+img_per_block-1), end) = isol_imgs;
          
          rand_image_mat(i_designmat:(i_designmat+img_per_block-1)) = isol_imgs;
          rand_image_file(i_designmat:(i_designmat+img_per_block-1)) = assign_image_file(block_position);
        end
        
      end
              
   
      % Add coding of picture type to design matrix
      for i_mat = 1 : length(design.rand.order_mat)
          
          switch design.rand.order_mat(i_mat,3)
              case 1
                 design.rand.order_mat(i_mat,7:9) = [1 0 1]; % food / not sweet / hcal
              case 2
                 design.rand.order_mat(i_mat,7:9) = [1 0 1]; % food / not sweet / not hcal
              case 3
                 design.rand.order_mat(i_mat,7:9) = [1 1 1]; % food / sweet / hcal
              case 4
                 design.rand.order_mat(i_mat,7:9) = [1 1 0]; % food / sweet / not hcal
              case 5
                 design.rand.order_mat(i_mat,7:9) = [0 0 0]; % not food / not sweet / not hcal                 
          end
      end

      
      % Prepare output
      
        design.stim.image_files = image_files;
        design.stim.image_index = image_index;
      % in design matrix, change image_index to image file
      for change_indx = 2 : length(design.rand.order_mat(:,6))
          indx_value = design.rand.order_mat(change_indx,6);
        
          design.rand.order_mat(change_indx,6) = design.stim.image_index(indx_value);
      end
      
      
        design.rand.full_flip_coin = []; %No VAS coded
        %Save verctor with randomized image order (according to block
        %randomization)
        design.rand.image_mat = rand_image_mat';
        design.rand.image_file = rand_image_file';
        % design.rand.order = order;


        design.rand.order_mat_labels = [1:9;...
                                        "row_index", "block_index", "block_type", "block_id", ...
                                        "block_repetition", "img_index", "food", "sweet", "high_cal"]';
        
        %Save

            save(sprintf('Order_TUE002_fMRI/FCRcond_mat_TUE002_fmri_test.mat'), 'design')
            save(sprintf('Order_TUE002_fMRI/FCRcond_mat_TUE002_fmri.mat'), 'design')

     end
 
end
   
