% Foraging_task/prepare - part of Foraging_task - BON001
% Version 1.0.0
% Author: Paul Jung
% Mail  : jung.science@web.de
% Date  : 12.04.2024
% 
% Here we prepare the condition files, that hold all the information about
% the blocks, timing, randomization, etc. & general settings.
% For each participant 2 sessions are created, each session with 3 blocks a
% 8 min per block, but with different colors between the sessions and
% blocks.
%--------------------------------------------------------------------------
close all; clear; clc
rng('shuffle'); % take care for real random numbers
study   = 'BON001'; % used for filenames

% to set the amount of expected persons / desired condition files
personNumBegin  = 999999;    % first number of condition files
personNumEnd    = 999999;    % last  number of condition files
                        
%%% now some general settings, that apply for all participants & sessions
cond.delayDiff = 0;     % choose 1 if high & low effort shall differ in
% delay, choose 0 if they shall differ in needed force.

% (delayDiff = 1) or a high and low effort threshold (delay = 0)?
cond.dummyVolumes = 0;  % the ammount of scanner-volumes we want to skip
cond.forceRelease = 49; % Max value for reset of force-device
cond.forceLow = 50;     % Threshold for low effort votum with force-device
cond.forceHigh = 75;    % Threshold for high effort votum with force-device
cond.rewardHigh = 80;   % Point value for high reward
cond.rewardLow  = 20;   % Point value for low reward
cond.imgPath = '.\supplementaryFiles\Images\';
% specify the general timing infos (all in seconds)
cond.blockDur = 8*60;   % block duration in minutes
cond.announceDur = 4;	% duration of block announcement
cond.rewardDur = 1;     % duration of trial reward presentation
cond.gRewardDur = 10;   % duration of global reward presentation
cond.respWin = 2;       % duration of response window (approach of option)
cond.timeoutDur = 8;    % duration of timeout-punishment
cond.isiDur = 2;        % duration of isi between trials
% specify the selection/effort related timings
cond.expanseDur = 3;    % duration of selection window (option expands)
cond.delayHigh = 3;     % duration needed to select the high effort option
cond.delayLow = 1;      % duration needed to select the low effort option
% specify variables needed to calculate monetary reward
cond.moneyFactor = 0.05; % how many cent correspond to 1 point of fuel?
cond.moneyExample = 200; % how many points (liters of fuel) should be used 
% as for an example calculation in the instructions?

%%% prepare the options
% prepare rewards
cond.options.HELR.reward = cond.rewardLow;
cond.options.HEHR.reward = cond.rewardHigh;
cond.options.LELR.reward = cond.rewardLow;
cond.options.LEHR.reward = cond.rewardHigh;

% prepare effort thresholds and delays
if cond.delayDiff % difference between high an low effort through different
    % delays but same thresholds
    cond.options.HELR.effort = cond.forceHigh;
    cond.options.HELR.delay = cond.delayHigh;

    cond.options.HEHR.effort = cond.forceHigh;
    cond.options.HEHR.delay = cond.delayHigh;

    cond.options.LELR.effort = cond.forceHigh;
    cond.options.LELR.delay = cond.delayLow;

    cond.options.LEHR.effort = cond.forceHigh;
    cond.options.LEHR.delay = cond.delayLow;

else % difference between high an low effort through different
    % force thresholds but same delays
    cond.options.HELR.effort = cond.forceHigh;
    cond.options.HELR.delay = cond.delayHigh;

    cond.options.HEHR.effort = cond.forceHigh;
    cond.options.HEHR.delay = cond.delayHigh;

    cond.options.LELR.effort = cond.forceLow;
    cond.options.LELR.delay = cond.delayHigh;

    cond.options.LEHR.effort = cond.forceLow;
    cond.options.LEHR.delay = cond.delayHigh;
end

%%% prepare the trigger codes
cond.trigger.start = 1;     % start of experiment
cond.trigger.tvns_on = 11;  % begin of stimulation
cond.trigger.tvns_off = 201;% end of stimulation
cond.trigger.end = 255;     % end of experiment
cond.options.HELR.trigger = 2;
cond.options.HEHR.trigger = 4;
cond.options.LELR.trigger = 8;
cond.options.LEHR.trigger = 16;
cond.env.rich.trigger = 32;
cond.env.poor.trigger = 64; 
% 128 for the third block/ the 2. poor block, changed later inside loop

%%% prepare the environments
% determine the populations for random sampling an option
% (HighEffort/LowEffort & HighReward/LowReward)
cond.env.rich.population = {
    'HELR', 'HEHR', 'LELR', 'LEHR', 'LEHR', 'LEHR', 'LEHR'};
cond.env.poor.population = {
    'HELR', 'HELR', 'HELR', 'HELR', 'HEHR', 'LELR', 'LEHR'};
% for easier use
cond.env.rich.name = 'rich';
cond.env.poor.name = 'poor';
% individual duration-info for environments needed for training
cond.env.rich.duration = cond.blockDur;
cond.env.poor.duration = cond.blockDur;

%%% begin loop to create individual parts of condition file cond
for person_i = personNumBegin:personNumEnd

    for session_i = 1:2
        if session_i == 1
            cond.env.rich.backColor = 'lightblue';
            cond.env.poor.backColor = 'lightbrown';
            % prepare images for the options
            cond.options.HELR.img = 'pathogen_2.png';
            cond.options.HEHR.img = 'pathogen_11.png';
            cond.options.LELR.img = 'pathogen_18.png';
            cond.options.LEHR.img = 'pathogen_21.png';

        elseif session_i == 2
            cond.env.rich.backColor = 'lightpink';
            cond.env.poor.backColor = 'lightgreen';
            % in second session we use different images for the options
            cond.options.HELR.img = 'pathogen_17.png';
            cond.options.HEHR.img = 'pathogen_9.png';
            cond.options.LELR.img = 'pathogen_15.png';
            cond.options.LEHR.img = 'pathogen_27.png';
        end

        cond.block(1) = {cond.env.poor};
        cond.block(2) = {cond.env.rich};
        cond.env.poor.trigger =128; % adjust trigger-code for 2. poor block
        cond.block(3) = {cond.env.poor};
                
        % save the individual condition file
        id = pad(num2str(person_i) ,6,"left",'0'); % add leading zeros
        save(['Foraging_cond_' study '_' id '_S' num2str(session_i)], 'cond')   
    
    end % of session loop
end % of person loop

%%% create a common training condition file
cond.blockDur = 60;   % in seconds
% prepare the options
cond.options = [];
cond.options.tr1.img = 'pathogen_1.png';
if cond.delayDiff %low effort = low delay but high threshold
    cond.options.tr1.effort = cond.forceHigh;
    cond.options.tr1.delay = cond.delayLow;
else % low effort = low threshold but high delay
    cond.options.tr1.effort = cond.forceLow;
    cond.options.tr1.delay = cond.delayHigh;
end
cond.options.tr1.reward = 80;
cond.options.tr1.trigger = 3;

cond.options.tr2.img = 'pathogen_23.png';
cond.options.tr2.effort = cond.forceHigh;
cond.options.tr2.delay = cond.delayHigh;
cond.options.tr2.reward = 20;
cond.options.tr2.trigger = 5;

% prepare the environment
% determine the population for random sampling an option
cond.env = [];
cond.env.train.population = {'tr1', 'tr2'};
cond.env.train.name = 'train'; % for easier use
cond.env.train.backColor = 'grey';
cond.env.train.trigger = 17;
cond.env.train.duration = cond.blockDur;

% prepare the blocks, set new durations
cond.block = {};
cond.block(1) = {cond.env.train}; % one block only accept
cond.block{1}.duration = 60;
cond.block(2) = {cond.env.train}; % one block only reject
cond.block{2}.duration = 30;
cond.block(3) = {cond.env.train}; % one block real training
cond.block{3}.duration = 4*60;

save(['Foraging_longTraining_cond_' study], 'cond')

%%% shortened durations for short (inside MRI) training
cond.block{1}.duration = 30;
cond.block{2}.duration = 20;
cond.block{3}.duration = 2*60;
save(['Foraging_shortTraining_cond_' study], 'cond')

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
