% Computes a jittered ITI drawn from a exponential distribution and truncated at a maximum value
% See Ashby (2011) for a discussion of the advantages.

function DelayJitter = ComputeJitter_exp(mu_jitter, max_delay, n_trials,Study_ID)

test_available = dir(sprintf('Stable_version/jitters/DelayJitter_mu_%d_max_%d_trials_%d.mat', mu_jitter, max_delay, n_trials));

if isempty(test_available)
    %sets the tolerance for local deviations of the sampled distribution from the intended mu
    dev_tol = 0.01;

    while 1
        %samples n_trials times from the exponential distribution
        DelayJitter = exprnd(mu_jitter,n_trials,1);
        %truncates extreme values
        DelayJitter(DelayJitter > max_delay) = max_delay;
        %uses a criterion to break the loop when the sampled mu resembles the
        %intended mu
        if abs(mean(DelayJitter)-mu_jitter) < mu_jitter * dev_tol
            break
        end
    end
    if rem(mu_jitter,1)==0
        save(sprintf('Project_Version/%s/jitters/DelayJitter_mu_%d_max_%d_trials_%d.mat', Study_ID, mu_jitter, max_delay, n_trials));
    else
        save(sprintf('Project_Version/%s/jitters/DelayJitter_mu_%.2f_max_%d_trials_%d.mat', Study_ID, mu_jitter, max_delay, n_trials));
    end
    histogram(DelayJitter,'Normalization','pdf');

    disp(['Sampled Mu = ' num2str(mean(DelayJitter))]);

else

    copyfile([test_available.folder,filesep,test_available.name],['Project_version\/',Study_ID,filesep,'jitters/',test_available.name])
end