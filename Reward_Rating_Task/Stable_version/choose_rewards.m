% 
% Function to decide reward stimuli presented in the third part (reward
% phase) of the reward rating task (TUE009)
% 
% Current Version: 2 (02.22)
% Coded by Johanna Theuer 
% with: Matlab R2021a
%
% Called by Reward_Rating_main
% Input: categories, stimuli numbers, ratings, number of choices
% Output: stimuli to be presented as a reward

% Version 2: in progress
% (only some food items that we have available for participants)


function output = choose_rewards(stimuli)

% Decide which stimulus to present as a reward by using the one the
% participant chose most often, and the highest-ranked if there are several
% Note: This assumes that there were enough trials that each stimulus was 
% presented equally often (meaning n_trials was a multiple of 30),
% otherwise the result might not be optimal

category1 = stimuli(stimuli(:,1) == 1,:);
category2 = stimuli(stimuli(:,1) == 2,:);
category3 = stimuli(stimuli(:,1) == 3,:);


% Note: Edit this to indicate which food items we have available to give
% out as rewards for the task
 available = category1(:,2); % (all)
%available = [];
% assuming category 1 is food, this restricts choices to those available
ind = ismember(category1(:,2), available);
category1 = category1(ind,:);

% sort by how many times it was chosen, use ratings to break ties
sorted_cat1 = sortrows(category1, [4 3]);
sorted_cat2 = sortrows(category2, [4 3]);
sorted_cat3 = sortrows(category3, [4 3]);

winner1 = sorted_cat1(end,2);
winner2 = sorted_cat2(end,2);
winner3 = sorted_cat3(end,2);
output = [winner1, winner2, winner3];

end
