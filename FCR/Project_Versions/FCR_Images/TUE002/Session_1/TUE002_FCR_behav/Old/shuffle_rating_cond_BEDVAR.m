%create shuffled condition files

create_exp_files = 0; %flag to choose to create pilot or experiment condition files

if create_exp_files == 1
   
    n_subj = 200; % 200 subjects, 20 pilots

else
    
    n_subj = 20;
end

% FLAG FOR NF ITEMS, NEED TO GO IN SAME STIMULI ORDNER. IF NF ITEMS BÜROCUE
% 20 ITEMS,2 RUNS 10 LIKING,10 WANTING, 10 LIKING, 1O WANTING.OUTPUT
% ORDER_NF_TUE002 FOR 200 SUBJECTS AND 20 PILOTS

n_runs = 4;
n_trials = 60;
sep_trial_vect = (1:n_trials)';
cont_trial_vect = (1:n_trials*n_runs)';
%Rand_Design_mat = zeros(number_trials,4);
%full_conditions = [1, 2, 1, 2, 1, 2];
full_design_mat = [];

% 0 for liking, 1 for wanting




for ind = 1:n_subj
    
    full_flip_coin = [];
    for ind_flip = 1:(n_runs/2)
        flip_coin = [zeros(30,1); ones(30,1)];
        flip_coin = Shuffle(flip_coin);
        run_flip_coin = [flip_coin (1 - 1 .* flip_coin)];
        full_flip_coin = [full_flip_coin run_flip_coin];
    end
    
    images = dir('Stimuli_TUE002');
    for ind_ima = 3:62
        
        image_temp_str = strtok(images(ind_ima).name, '.');
        
        image_index(ind_ima-2,1) = str2double(image_temp_str);
      
    end
    
    image_files = {images(3:62).name}';
    
    for ind_flip = 1:(n_runs/2)
        [rand_image_ind, order] = Shuffle(image_index); % 2 outputs
        order_r2 = Shuffle(order);  
         rand_image_mat(:,ind_flip*2-1) = rand_image_ind;
          rand_image_mat(:,ind_flip*2) = image_index(order_r2);
          rand_image_file(:,ind_flip*2-1) = image_files(order);
          rand_image_file(:,ind_flip*2) = image_files(order_r2);
          r2_flip_coin = full_flip_coin(:,ind_flip*2);
          full_flip_coin(:,ind_flip*2) = r2_flip_coin(order_r2);
    end
     
   
    design.stim.image_files = image_files;
    design.stim.image_index = image_index;
    design.rand.full_flip_coin = full_flip_coin;
    design.rand.rand_image_mat = rand_image_mat;
    % design.rand.order = order;
    % design.rand.order_r2 = order_r2;
    design.rand.image_file = rand_image_file;
    
if create_exp_files == 1
        
        save(sprintf('Order_TUE002/FCRcond_mat_TUE002_%06d.mat', ind),'design')
        
else
        
       save(sprintf('Order_TUE002/FCRcond_mat_TUE002_9%05d.mat', ind), 'design')

end

       	
   
end
    