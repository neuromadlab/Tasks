% 
% Function to decide choice pairs for stimuli presented in the second part
% (choice phase) of the reward rating task (TUE009)
% 
% Current Version: 3.1
% Coded by Johanna Theuer 
% with: Matlab R2021a
%
% Called by Reward_Rating_main
% Input: stimuli numbers, ratings, categories
% Output: choice pairs for choice task (stimuli to be presented each trial,
% left and right)


function choice_pairs = choose_pairs_trials(items, n_trials)

    % Chooses pairs to that no pair has two items of the same category and
    % so the ratings for each are far apart for all pairs


    s = size(items,2);
    l = size(items,1);
    
    % input: category, position, rating
    stimuli_ids = items(:,2);
    ratings = items(:,3);
    categories = items(:,1);
    
    len = length(unique(stimuli_ids)); % (depends on stimuli for task)
    
    % determine how the pairs are to be built regarding categories
    pair_o = [1,2; 2,3; 3,1];
    pair_order = repmat(pair_o, 0.5*l/length(pair_o),1);
    pair_o_2 = [1,3; 2,1; 3,2];
    pair_order_2 = repmat(pair_o_2, 0.5*l/length(pair_o_2),1); 
    
    % sort by category, then rating
    sorted_cats = sortrows(items,[1 3]);
    
    sorted_1 = sorted_cats(1:l/3,:);
    sorted_2 = sorted_cats((l/3)+1:(l/3)*2,:);
    sorted_3 = sorted_cats((l/3)*2+1:end,:);

    sorteds(:,:,1) = sorted_1;
    sorteds(:,:,2) = sorted_2;
    sorteds(:,:,3) = sorted_3;
    sorted_firsts = sorteds(1:end/2,:,:);
    sorted_seconds = sorteds(end/2+1:end,:,:);

    choice_pairs_0 = zeros(l/2,s*2);
    
    % check if target number is a multiple of how many items there are (i.e. 60)
    n = n_trials;
    if mod(n_trials,l/2) ~= 0
        n = ceil(n_trials/(l/2)) * (l/2);
        missing = n - n_trials;
    end
        
        % several passes
        choice_pairs = zeros(n_trials,s*2);
        for t = 1:size(pair_order,1):n
            % (wich iteration are we on?)
            turn = ceil(t/size(pair_order,1)) ; 
            
            % switch pairwise (to get new non-repeating pairs for later
            % turns)
            if turn == 3 %|| 4
                for i = 1:2:length(sorted_firsts)
                    temp = sorted_firsts(i,:,:);
                    sorted_firsts(i,:,:) = sorted_firsts(i+1,:,:);
                    sorted_firsts(i+1,:,:) = temp;
                end
            end

            % (switch further, for new choice pairs)
            if turn == 5 %||6
                for i = 1:4:size(sorteds,1)
                    temp = sorteds(i,:,:);
                    sorteds(i,:,:) = sorteds(i+2,:,:);
                    sorteds(i+2,:,:) = temp;
                    temp2 = sorteds(i+1,:,:);
                    sorteds(i+1,:,:) = sorteds(i+3,:,:);
                    sorteds(i+3,:,:) = temp2;
                end
                sorted_firsts = sorteds(1:end/2,:,:);
                sorted_seconds = sorteds(end/2+1:end,:,:);
            end
            % (switch further; resulting in blocks of four switched,
            % different pattern, outer and inner)
            if turn == 7 %||8
                for i = 1:2:size(sorted_firsts,1)
                    temp = sorteds(i,:,:);
                    sorteds(i,:,:) = sorteds(i+1,:,:);
                    sorteds(i+1,:,:) = temp;
                end
                sorted_firsts = sorteds(1:end/2,:,:);
                sorted_seconds = sorteds(end/2+1:end,:,:);
            end

            % order of choice pairs, alternating to avoid repeats
            order = pair_order;
            if mod(turn, 2) == 0
                order = pair_order_2;
            end


            % keep track how far we've iterated through each category's items
            k = [1, 1, 1; 1, 1, 1];
            
            for i = 1:size(order,1)
                % determine next choice pair
                one = order(i,1);
                two = order(i,2);
                firstp = sorted_firsts(k(1,one),:,one);
                secondp = sorted_seconds(k(2,two),:,two);
                
                k(1,one) = k(1,one) + 1;
                k(2,two) = k(2,two) + 1;
                
                % randomly switch half of the sides
                if rand <= 0.5
                    choice_pairs_0(i,:) = [firstp, secondp];
                else
                    choice_pairs_0(i,:) = [secondp, firstp];
                end
            end
            
            % cut rows if necessary
            if n > n_trials && t >= n-l/2
                tdl = 1:missing;
                choice_pairs_0(tdl,:) = [];
            end
            
            choice_pairs(t:t+size(choice_pairs_0,1)-1,:) = choice_pairs_0;

        end

    % randomly shuffle the rows
    choice_pairs = choice_pairs(randperm(length(choice_pairs)),:);
            

    % reorder columns
    % (rating, category, stimuli number)
    choice_pairs = choice_pairs(:,[3 1 2 6 4 5]);
    
end
