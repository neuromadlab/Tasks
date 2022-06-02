% 
% Function to decide choice pairs for stimuli presented in the second part
% (choice phase) of the reward rating task (TUE009)
% 
% Current Version: 2.2 (22.03.22) (randomized version, no duplicate pairs)
% Coded by Johanna Theuer 
% with: Matlab R2021a
%
% Called by Reward_Rating_main
% Input: stimuli numbers, ratings, categories
% Output: choice pairs for choice task (stimuli to be presented each trial,
% left and right)

% A random version of the function to choose choice pairs
function choice_pairs = choose_pairs_trials_random(items, n_trials)

    s = size(items,2);
    l = size(items,1);

    % Chooses pairs to that no pair has two items of the same category
    
    % input: category, position, rating
    % sort by category
    sorted_cats = sortrows(items,1);
    r_1 = sorted_cats(1:l/3,:);
    r_2 = sorted_cats((l/3)+1:(l/3)*2,:);
    r_3 = sorted_cats((l/3)*2+1:end,:);  

    % check if target number is a multiple of how many items there are (i.e. 60)
    n = n_trials;
    if mod(n_trials,l/2) ~= 0
        n = ceil(n_trials/(l/2)) * (l/2);
        missing = n - n_trials;
    end

    current_pairs = [];

    % several passes, depending on number of trials
    choice_pairs = zeros(n_trials,s*2);
    choice_pairs_0 = zeros(l/2,s*2);
    for t = 1:l/2:n
        % prepare new pairs in batches (ensuring items appear the same
        % number of times)
        pairs(:,:,1) = [r_1(randperm(length(r_1)),2), r_2(randperm(length(r_2)),2)]; % pairs 1,2
        pairs(:,:,2) = [r_1(randperm(length(r_1)),2), r_3(randperm(length(r_3)),2)]; % pairs 1,3
        pairs(:,:,3) = [r_2(randperm(length(r_2)),2), r_3(randperm(length(r_3)),2)]; % pairs 2,3
        if t > 1
            for i = 1:3
                % check if one of these pairs appeared already
                r = ismember(pairs(:,:,i), current_pairs(:,:,i), 'rows');
                while sum(r) > 0
                    % repeat until there are no duplicates
                    pairs(:,:,i) = [pairs(randperm(l/3),1,i), pairs(randperm(l/3),2,i)];
                    r = ismember(pairs(:,:,i), current_pairs(:,:,i), 'rows');
                end
            end

        end
        current_pairs = [current_pairs; pairs];
        % create the actual pairs according to this ordering
        pairs11 = r_1(pairs(:,1,1),:);
        pairs12 = r_2(pairs(:,2,1)-20,:);
        pairs21 = r_1(pairs(:,1,2),:);
        pairs23 = r_3(pairs(:,2,2)-40,:);
        pairs32 = r_2(pairs(:,1,3)-20,:);
        pairs33 = r_3(pairs(:,2,3)-40,:);
        choice_pairs_0 = [pairs11, pairs12; pairs21, pairs23; pairs32, pairs33];

        % in case you want the sides stimuli are shown to be randomized
        for i = 1:length(choice_pairs_0)
            firstp = choice_pairs_0(i,1:3);
            secondp = choice_pairs_0(i,4:6);
            if rand <= 0.5
                choice_pairs_0(i,:) = [firstp, secondp];
            else
                choice_pairs_0(i,:) = [secondp, firstp];
            end
        end

        % randomly shuffle the rows
        choice_pairs_0 = choice_pairs_0(randperm(length(choice_pairs_0)),:);

        % cut rows if necessary
        if n > n_trials && t >= n-l/2
            tdl = 1:missing;
            choice_pairs_0(tdl,:) = [];
        end

        choice_pairs(t:t+size(choice_pairs_0,1)-1,:) = choice_pairs_0;

    end

    % if you want more randomization (could lead to same stimuli appearing
    % directly/shortly after each other)
    % choice_pairs = choice_pairs(randperm(length(choice_pairs)),:);

    % reorder columns
    % (rating, category, stimuli number)
    choice_pairs = choice_pairs(:,[3 1 2 6 4 5]);
    
end
