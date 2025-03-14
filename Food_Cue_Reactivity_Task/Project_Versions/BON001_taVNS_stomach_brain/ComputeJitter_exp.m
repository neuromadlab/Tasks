% Computes a jittered ITI drawn from a exponential distribution and truncated at a maximum value
% See Ashby (2011) for a discussion of the advantages.

% For FCR enter the number of trials for one session, NOT one repetition!

function DelayJitter = ComputeJitter_exp(mu_jitter, max_delay, total_trials)

%sets the tolerance for local deviations of the sampled distribution from the intended mu
dev_tol = 0.01; 
%mu_jitter = 0.7; 
%max_delay = 4; 
%total_trials = 160; %rows as for FCR trials are showns twice
n_jitter = total_trials*2; % number of jitter values is 2 times the number of trials -> 2 fixation crosses

while 1
    %samples n_trials times from the exponential distribution
    DelayJitter = exprnd(mu_jitter,n_jitter,1);
    %truncates extreme values
    DelayJitter(DelayJitter > max_delay) = max_delay;
    %uses a criterion to break the loop when the sampled mu resembles the
    %intended mu
    if abs(mean(DelayJitter)-mu_jitter) < mu_jitter * dev_tol
        break
    end
end

save(['DelayJitter_mu_' num2str(mu_jitter) '_max_' num2str(max_delay) '_trials_' num2str(total_trials) '.mat'], 'DelayJitter');
histogram(DelayJitter,'Normalization','pdf');
disp(['Sampled Mu = ' num2str(mean(DelayJitter))]);

end
