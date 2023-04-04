%Make settings files 

Study_id = 'BON002';
n_id = 3;
stim_length = [0.5,1,1.5,2,3,5];
stim_freq = [10,20,30,40];
trial_length = 30;
n_sessions = 2;
n_trials = 3;
pilot = 1; % 0 for condition files real data (please don't rerun as randomization file for the whole set up will be stored!), 1 pilot data (IDs 9XXXXX)

home_dir = 'C:/Users/Studien/';

setup_randomization_taVNS(Study_id,n_id,stim_length,stim_freq,n_sessions,trial_length,n_trials,home_dir, pilot)

function setup_randomization_taVNS(Study_id,n_id,stim_length,stim_freq,n_session, trial_length, n_trials,home_dir, pilot)
    setup.study = Study_id;
    setup.do_eyetracking = 0;
    setup.trial_length = trial_length;
    setup.n_repetions = n_trials;
    setup.do_fullscreen = 1;

for i_sub = 1:n_id
    
    cond = [0,1];
    stim_cond = cond(randperm(2));
    conditions(i_sub,:) = [i_sub,stim_cond]; 
    
    for i_sess = 1:n_session
    
    setup.stim_cond = stim_cond(i_sess);
    %table with frequency, Stim_length and block ID
    %define number of blocks
    n_blocks = length(stim_length)*length(stim_freq);

    %find all combinations
    [A,B] = meshgrid(stim_length,stim_freq);
    c = cat(2,A',B');
    combinations = reshape(c,[],2);
    
    av_freq_1 = 0;
    av_freq_2 = 0;
    av_len_1 = 0;
    av_len_2 = 0;

    %randomize combinations
    while (av_freq_1 < 24 || av_freq_1 > 26) || (av_freq_2 < 23|| av_freq_2 > 27) || (av_len_1 < 2.1|| av_len_1 > 2.2) || (av_len_2 < 2.1|| av_len_2 > 2.2)
        combinations = combinations(randperm(n_blocks),:);
        av_freq_1 = mean(combinations(1:round(length(combinations)/2),2));
        av_freq_2 = mean(combinations(round(length(combinations)/2)+1:end,2));
        av_len_1 = mean(combinations(1:round(length(combinations)/2),1));
        av_len_2 = mean(combinations(round(length(combinations)/2)+1:end,1));

    end
    combinations(:,end+1) = 1:n_blocks;
    combinations(:,end+1) = [ones(12,1);repmat(2,12,1)];
    setup.randomization = array2table(combinations,"VariableNames",{'Stim_length','frequency','block_id','run_id'});
    

    setup.instruction.text_p1.de = 'XXX';
    setup.instruction.text_p1.en = 'XXX';
    
    if pilot == 0
        name_file = strcat('settings/taVNSoptimize_', setup.study, '_' , pad(num2str(i_sub),6,"left",'0'), '_S', num2str(i_sess),'.mat');
    else
        name_file = strcat('settings/taVNSoptimize_', setup.study, '_9' , pad(num2str(i_sub),5,"left",'0'), '_S', num2str(i_sess),'.mat');
    end
    save(name_file, "setup");
    end 

end

study_name = dir([home_dir,'SynologyDrive/Projects/',setup.study,'*']);
if pilot == 0
    save([home_dir,'SynologyDrive/Projects/',study_name.name,'/06_Participants/Stimulation_conditions.mat'],"conditions")
end
end