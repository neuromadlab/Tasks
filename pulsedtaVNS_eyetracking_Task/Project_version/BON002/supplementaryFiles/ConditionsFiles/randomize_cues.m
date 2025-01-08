function cues = randomize_cues
% This function creates randomized cuepairs with the property of different
% colors, patterns & rings
% Author: Anne Kühnel
% Author: Paul Jung
% Creation: 19.01.24
% Last change: 11.04.2024

load("../Cues/cues.mat")
planetsgrid = readtable("../Cues/planets_grid.xlsx");

planetsgrid_current = planetsgrid;

for i_pairs = 1:19

    %select first item randomly from all current cues
    %use a temporary selection exluding colors from the previous pair
    
    if i_pairs == 1 % for first pair choose cues from whole grid
        planetsgrid_temp = planetsgrid_current;
    else 
        % for remaining pairs exclude colors of directly preceding pair
        excludeCol1 = ~ismember(planetsgrid_current(:,2), chosen_cue_2(:,2));
        excludeCol2 = ~ismember(planetsgrid_current(:,2), chosen_cue_1(:,2));
        planetsgrid_temp = planetsgrid_current( excludeCol1 & excludeCol2 , :);
    end

    % select randomly a first cue
    count = length(planetsgrid_temp.name);
    cues_possible = 0;
    while cues_possible == 0
    randomLine = randi(count);
    chosen_cue_1 = planetsgrid_temp( randomLine, :);

    % select second item from a reduced grid including only planets where
    % all features differ

    % find the lines/cues with different properties than the first cue
    
    %manually select possible colors based on first choice
    color_cue_1 = char(chosen_cue_1{:,2});

    switch color_cue_1
        case 'blue'
            notSameColor = ismember(planetsgrid_temp(:,2), cell2table({'orange','pink','purple','red','yellow'}',"VariableNames",{'color'}));
        case 'green'
            notSameColor = ismember(planetsgrid_temp(:,2), cell2table({'orange','pink','purple'}',"VariableNames",{'color'}));
        case 'orange'
            notSameColor = ismember(planetsgrid_temp(:,2), cell2table({'blue','green','pink','purple'}',"VariableNames",{'color'}));
        case 'pink'
            notSameColor = ismember(planetsgrid_temp(:,2), cell2table({'blue','green','yellow','orange'}',"VariableNames",{'color'}));
        case 'purple'
            notSameColor = ismember(planetsgrid_temp(:,2), cell2table({'blue','green','yellow','orange'}',"VariableNames",{'color'}));
        case 'red'
            notSameColor = ismember(planetsgrid_temp(:,2), cell2table({'blue','yellow','orange'}',"VariableNames",{'color'}));
    
        case 'yellow'
            notSameColor = ismember(planetsgrid_temp(:,2), cell2table({'blue','pink','red','purple'}',"VariableNames",{'color'}));
  
    end
    notSameRing = ~ismember(planetsgrid_temp(:,3), chosen_cue_1(:,3));
    notSamePattern = ~ismember(planetsgrid_temp(:,4),chosen_cue_1(:,4));
    lines = notSameColor & notSameRing & notSamePattern;
    cues_possible = sum(lines);
    end
    
    planetsgrid_temp = planetsgrid_temp( lines , :);
    % choose randomly a second cue out of the differing grid
    count = length(planetsgrid_temp.name);
    randomLine = randi(count);
    chosen_cue_2 = planetsgrid_temp( randomLine, :);

    % use both cues to create a pair
    pairs{i_pairs,1} = ['planet_space_',char(chosen_cue_1.name),'.png'];
    pairs{i_pairs,2} = ['planet_space_',char(chosen_cue_2.name),'.png'];

    % kickout already used cues
    without1 = ~ismember(planetsgrid_current(:,1), chosen_cue_1(:,1));
    without2 = ~ismember(planetsgrid_current(:,1), chosen_cue_2(:,1));
    planetsgrid_current = planetsgrid_current( without1 & without2, :);
end

% overwrite the old valuess
cues.trainingPairs=pairs(1:3,:);
tmp = cues.trainingPairs';
cues.trainingFiles = tmp(:);

cues.pairs = pairs(4:19,:);
tmp = cues.pairs;
cues.files = tmp(:);

end
