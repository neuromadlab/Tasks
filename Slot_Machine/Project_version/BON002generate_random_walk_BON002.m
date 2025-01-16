function out = generate_random_walk_BON002(nruns, ntrials)
% Generates the random walk as in the App together with rewarded choice and
% reward vectors for blue and green. Generates n_runs walks with n_trials
% trials


for i_run = 1:nruns
%% Generate random walk
    %Generate as many random walks as runs
%Initialize vector with probabilities for each trial
 probs = zeros(ntrials,1);
 %reward_grid = zeros(ntrials,2);
 r = rand();
 probs(1) = 0.8 * (r > 0.5) + 0.2 * (r <= 0.5);
while true
    for i_trial  = 1:ntrials-1
        
    	step = randn*0.1; % random scalar drawn from the standard normal distribution, convert to probability value
        
        %check if step is ok
    	while (probs(i_trial) + step - 0.03 * (probs(i_trial) - 0.5)) < 0 || (probs(i_trial) + step - 0.03 * (probs(i_trial) - 0.5)) > 1
    		
            step = randn*0.1; %if value >1, draw again
            
        end
        
        %Concatenate probability values
    	probs(i_trial+1) = probs(i_trial) + step - 0.03 * (probs(i_trial) - 0.5);
        
%         reward_blue = round(normrnd(50,16));
%         if reward_blue < 1
%             reward_blue = 1;
%         elseif reward_blue > 99
%             reward_blue = 99;
%         end
%         reward_green = 100-reward_blue;
%         reward_grid(i_trial,1:2) = [reward_blue,reward_green];

    end
    
    % reject if run has not = 2 steps
    sw = probs>0.5;
    steps = NaN(size(sw));
    for tr = 1:length(sw)
        if tr == 1
            steps(tr) = 0;
        else
            if steps(tr-1)~= 0
                steps(tr) = 0;
            else
                steps(tr) = sw(tr)-sw(tr-1);
            end
        end
    end
    steps = length(abs(steps(steps~=0)));
    if steps ~=2
        continue
    end
    
    %only accept run if mean of prob differences is btw 0.44 and 0.46
    antiprobs = 1-probs;
    diff = abs(probs-antiprobs);
    if mean(diff) >=0.44 && mean(diff) <=0.46
        break
    end
end
    
    
%% determine correct choices depending on probabilities

% %rand returns a single uniformly distributed random number in the interval (0,1).
% gpt = rand(ntrials, 1) < probs; %1 blue, 2 green
% 
% good_opt = ones(ntrials,1);
% good_opt(gpt) = 2;
% 
% correct = double(probs > .5);
% correct = correct + 1; 
% 
% out.inputs(:,i_run) = good_opt;
% out.correct_option(:,i_run) = correct;
% out.reward_grid(:,:,i_run)= reward_grid;
out.probs(:,i_run) = probs;
  
end    




end
