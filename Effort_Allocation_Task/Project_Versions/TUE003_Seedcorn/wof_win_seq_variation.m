function variations = wof_win_seq_variation()
%% wof_win_seq_variation computes sequence of 0, -1, +1 for the variation 
% in the win sequence for WOF
%
% script adapted from ComputerJitter_exp.m, by Wy Ming Lin

% 
dev_tol = 0.01; mu_variation = 5; n_trials = 14;

while 1
    
    samples = randi([1 9],[n_trials 1]);

    % uses a criterion to break the loop when the sampled mu resembles the intended mu
    if abs(mean(samples)-mu_variation) < mu_variation * dev_tol
        break
    end
end

variations = zeros([n_trials 1]);
variations(samples <= 3) = -1;
variations(samples >= 7) = 1;

disp(mean(variations));

% save(sprintf('DelayJitter_mu_%d_max_%d_trials_%d.mat', mu_jitter, max_delay, n_trials));

% histogram(variations,'Normalization','pdf');

% disp(['Sampled Mu = ' num2str(mean(variations))]);
