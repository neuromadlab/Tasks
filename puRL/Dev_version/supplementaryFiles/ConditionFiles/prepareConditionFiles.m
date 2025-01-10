% part of puRL_task - BON002
% Version 1.0.0
% Author: Paul Jung
% Mail  : jung.science@web.de
% Author: Anne Kühnel
% Date  : 11.04.2024
% 
% Here we prepare the condition files, that hold all the information about
% cue composition, sequence, randomization, etc. & general settings.
%--------------------------------------------------------------------------
close all; clear; clc
rng('shuffle'); % take care for real random numbers

% to set the amount of expected persons / desired condition files
personNumBegin  = 1;    % first number of condition files
personNumEnd    = 1;   % last  number of condition files

%%% now some general settings, that apply for all participants & sessions
cond.dummyVolumes = 1;  % the ammount of scanner-volumes we want to skip
cond.rewardStep = 10;   % how much points to win/loose per step?
cond.stimLowAmp = 100;  % amplitude of low tVNS stimulation
cond.stimDur = 1;       % duration of the tVNS stimulation
cond.stimFreq = 20;     % frequency of the tVNS stimulation
cond.forceRelease = 30; % Max value for reset of force-device
cond.forceThresh = 50;  % Threshold for response with force-device/joystick
% specify the general timing infos (all in seconds)
cond.instrDur = 5;      % duration after which an instruction hint fades in
cond.announceDur = 2;   % duration of the block announcement
cond.fixDur = 3;        % duration of fixation ahead of cue (w.o. jitter)
cond.respWin = 2.5;     % duration of response window
cond.respDur = 3;       % duration of response (expected/requested)
cond.cueDur = 6;	    % duration of cue in total
cond.isiDur = 2;        % duration of isi before result (w.o. jitter)
cond.resDur = 2.5;      % duration of trial result presentation
cond.ibiDur = 10;       % duration of pause between blocks
cond.gResDur = 4;       % duration of global result presentation
cond.rand_Cues = 1;
% trigger codes for sending TTL-trigger
cond.trigger.start = 1; % start of experiment
cond.trigger.end = 128; % end of experiment



%%% prepare data
if cond.rand_Cues == 0
    load '..\Cues\cues.mat';    % specify the cues
    cuePairs = cues.pairs;
    cond.cues = cues;           % pass on the information
end

% prepare the stimulation times
stimTimes = {'action', 'outcome'};


%%% begin loop to create individual parts of condition file cond
for person_i = personNumBegin:personNumEnd
    if cond.rand_Cues == 0
        cuePairs = shuffle(cuePairs, 1);% shuffle the cue-pairs
    else
        cues = randomize_cues();
        cuePairs = cues.pairs;
        cond.cues = cues;
    end

    cuePair_i = 1; % person-wide cuePair counter

    for session_i = 1:2 % (sham, tVNS)
    
        % randomize stimulation-time order 1&2 and 3&4 for the blocks
        stimBlocks = [shuffle(stimTimes, 2), shuffle(stimTimes, 2)];

        % prepare full probability set for each Session
        % create populations with the wanted win-probability
        probability_set = [ repmat( {'left'}, 1, 36), repmat( {'right'}, 1, 12)]; % 75/25
        probability_set(2,:) = [ repmat( {'left'}, 1, 31), repmat( {'right'}, 1, 17)]; % 65/35

    
        for block_i = 1:4
            cond.blocks(block_i).stimTime = stimBlocks{block_i};
    
            cuePair1 = cuePairs(cuePair_i, :); % select cuePairs for  block
            cuePair2 = cuePairs(cuePair_i+1, :);
            cuePair_i = cuePair_i+2;    % increase counter for next block

            [probabilities, probability_set] = createProbabilities(probability_set,block_i);
            cond.blocks(block_i).trials = createTrials(cuePair1, cuePair2, probabilities);
        end % of block loop

       
        
        % save the individual condition file
        id = pad(num2str(person_i) ,6,"left",'0'); % add leading zeros
        save(['puRL_cond_BON002_' id '_S' num2str(session_i)], 'cond')   
    
    end % of session loop
 

%%% create a common condition file for training, one cue pair, 10 repeats,
% high win probability
cond.blocks = []; % reset the condition-file structure
cond.cues = [];

trialCount = 16;    % we want 10 training trials in total
cuePairs = repmat(cues.trainingPairs(1:2,1:2), trialCount/2, 1); % prepare pairs

 highProb = [ repmat( {'left'}, 1, 7), repmat( {'right'}, 1, 1)]; % 1/8
 lowProb = [ repmat( {'left'}, 1, 6), repmat( {'right'}, 1, 2)];  % 1/4

highProb = shuffle(highProb,2);
lowProb = shuffle(lowProb,2);
% prepare win probabilities
cond.blocks(1).stimTime = 'train';              % prepare block
cond.cues = cues;

for i = 1:trialCount/2                            % prepare trials
    trial.cueL = cuePairs{i,1}; % specify the images for this trial
    trial.cueR = cuePairs{i,2};
    trial.winProb = 'high';     % win-probability
    trial.difficulty = 'very low';   % high win-probability = low difficulty
    trial.goodOption = 'left';  % the "good option" side
    trial.winProbLeft = 87.5;
    trial.winSide = highProb{i}; % the current probalistic winning side
    cond.blocks(1).trials(i) = flipSide(trial);
end

for i = (trialCount/2+1) : trialCount                             % prepare trials
    trial.cueL = cuePairs{i,1}; % specify the images for this trial
    trial.cueR = cuePairs{i,2};
    trial.winProb = 'high';     % win-probability
    trial.difficulty = 'low';   % high win-probability = low difficulty
    trial.goodOption = 'left';  % the "good option" side
    trial.winProbLeft = 75;
    trial.winSide = lowProb{i-8}; % the current probalistic winning side
    cond.blocks(1).trials(i) = flipSide(trial);
end

cond.blocks.trials = shuffle(cond.blocks.trials,2);

save(['puRLTrain_cond_BON002_',id], 'cond')

% create a shorter cond-file for in-scanner training
cond.blocks = []; % reset the condition-file structure
cond.cues = [];

trialCount = 4;    % we want 10 training trials in total
cuePairs = repmat(cues.trainingPairs(3,1:2), trialCount, 1); % prepare pairs

lowProb = [ repmat( {'left'}, 1, 3), repmat( {'right'}, 1, 1)];  % 1/4

lowProb = shuffle(lowProb,2);
% prepare win probabilities
cond.blocks(1).stimTime = 'train';              % prepare block
cond.cues = cues;

for i = 1:trialCount                           % prepare trials
    trial.cueL = cuePairs{i,1}; % specify the images for this trial
    trial.cueR = cuePairs{i,2};
    trial.winProb = 'high';     % win-probability
    trial.difficulty = 'low';   % high win-probability = low difficulty
    trial.goodOption = 'left';  % the "good option" side
    trial.winProbLeft = 75;
    trial.winSide = lowProb{i}; % the current probalistic winning side
    cond.blocks(1).trials(i) = flipSide(trial);
end

cond.blocks.trials = shuffle(cond.blocks.trials,2);

cond.blocks.stimTime = 'calibration';
save(['puRLCal_cond_BON002_',id], 'cond')

end % of person loop

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function trials = createTrials( cuePair1, cuePair2 , probabilities)
% This function creates the 24 trials for one block

% prepare the win-probabilities, a sample of 12 each
highProb = probabilities(1,:);
lowProb = probabilities(2,:);
hp_i = 1; % highProb counter
lp_i = 1; % lowProb counter

% accumulate all trials, unrandomized, one of both probabilities at a time
for trial_i = 1:2:24
    % high-probability trial
    trialH.cueL = cuePair1{1};      % specify the images for this trial
    trialH.cueR = cuePair1{2};
    trialH.winProb = 'high';        % win-probability
    trialH.difficulty = 'low';      % high win-probability = low difficulty
    trialH.goodOption = 'left';     % the "good option" side
    trialH.winProbLeft = 75;        % probab. for left to be winning side
    trialH.winSide = highProb{hp_i};% the current probalistic winning side
    hp_i = hp_i+1;

    % low-probability trial
    trialL.cueL = cuePair2{1};      % specify the images for this trial
    trialL.cueR = cuePair2{2};
    trialL.winProb = 'low';         % win-probability
    trialL.difficulty = 'high';     % low win-probability = high difficulty
    trialL.goodOption = 'left';     % the "good option" side
    trialL.winProbLeft = 65;        % probab. for left to be winning side
    trialL.winSide = lowProb{lp_i}; % the current probalistic winning side
    lp_i = lp_i+1;

    % trialH.t = trial_i; % for test & control of sub-group shuffling
    % trialL.t = trial_i+1;
    trials(trial_i)   = flipSide(trialH); %#ok<AGROW> % high-prob trial
    trials(trial_i+1) = flipSide(trialL); %#ok<AGROW> % low-prob trial
end

% shuffle the trials in 4 sub-groups of 6 trials each
trials = [shuffle(trials(1:6), 2), shuffle(trials(7:12), 2),...
    shuffle(trials(13:18), 2), shuffle(trials(19:24), 2)];
end %----------------------------------------------------------------------


function ret = shuffle(inp, dim)
% This function shuffles a matrix "inp" in the dimension "dim"
% inp - the data to shuffle
% dim - the dimension to shuffle
if nargin < 2
    dim = 2;
end
s = size(inp);
p = randperm( s(dim) );

if dim == 1
    ret(p,:) = inp;
else
    ret(:,p) = inp;
end
end %----------------------------------------------------------------------


function t = flipSide(t)
% This function randomizes the side of the good choice of one trial "t"
flip = randi([0 1]);
if flip
    tempCue = t.cueL;       % flip cues
    t.cueL = t.cueR;
    t.cueR = tempCue;
    t.goodOption = 'right'; % flip "good option" side
    t.winProbLeft = 100 - t.winProbLeft; % flip winProbLeft
    
    % flip current winning side
    if strcmp(t.winSide, 'left')
        t.winSide = 'right';
    else
        t.winSide = 'left';
    end
end
end %----------------------------------------------------------------------


function [block_probabilities,probability_set] = createProbabilities(probability_set, block_id)
% This function prepares 2 arrays of win-probabilities, the side of the 
% winning cue is denoted ('left' vs 'right'), with higher probability on
% left side.


highProbt = probability_set(1,:);
lowProbt = probability_set(2,:);

highProb = cell(1,12); % prepare space
lowProb  = cell(1,12);

% draw 12 realisations without replacement delete those 12 indeces from the
% set for the other resamples. Only take this decision if low prob is
% harder in both the current sample and the left overs
%in the left overs at least as many more correct choices should be
%available as blocks are left

diff_block = 0;
diff_rest = 0;

if block_id < 4

    while diff_block <= 0 || diff_rest <= (4-block_id)

        [highProb,idx_high] = datasample(highProbt,12,'Replace',false); % draw one sample
        [lowProb,idx_low] = datasample(lowProbt,12,'Replace',false);

        highProbt_temp = highProbt;
        lowProbt_temp = lowProbt;

        highProbt_temp(idx_high) = [];
        lowProbt_temp(idx_low) = [];


        diff_block = sum(string(highProb)=="left") - sum(string(lowProb)=="left");
        diff_rest = sum(string(highProbt_temp)=="left") - sum(string(lowProbt_temp)=="left");


    end

    highProbt(idx_high) = [];
    lowProbt(idx_low) = [];

else

    highProb = highProbt;
    lowProb = lowProbt;

    highProbt = [];
    lowProbt = [];

end
    

block_probabilities = [highProb;lowProb];
probability_set = [highProbt;lowProbt];



end %- %----------------------------------------------------------------------
