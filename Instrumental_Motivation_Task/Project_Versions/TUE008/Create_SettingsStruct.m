% ================== Instrumental Motivation Task ========================
% Creates File with Settings and Stimuli that are loaded in Instrumental Motivation Task
% main script (IMT.m). Also determines the tone-reward pairings for 100 participants. 
%
% Coded by: Corinna Schulz, 2022
% Coded with: Matlab R2021b using Psychtoolbox 3.0.16
%
% Project Version: TUE008
% =========================================================================
% WHAT TO DO WITH THIS SCRIPT: 
% Adapt Settings if needed, run first for runINDEX 1, then runINDEX 2. 

%% General settings
clear

% Change flags to customize script

%settings struct
settings.do_fullscreen =   1; % will show window as fullscreen (default second monitor, if connected), ...
                               % if 0, small debug window

% settings.do_fmri = 1 % if 1 this will include trigger, but this is
% actually determined in the IMT_main script. 

settings.lang_de        = 1; % display language German (otherwise english) (this can be flexibly overwritten in the main script upon console input!)

settings.do_GFD         = 1; %will load specific parameters for the use uf the grip force device for bidding (scale)
settings.clckforce      = 30000; % force needed to click to start experiment in MR scanner (before training)

%% Settings for the IMT 

settings.value_money   = 32;    % amount of cents earned with 100 points
settings.value_food    = 32;    % amount of kcal earned with 100 points

% Trial numbers 
settings.calibration_trials             = 3; % Calibration Trials (2 Max, 1 Min)
settings.cue_conditioning_trials        = 8; % Cue Conditioning Presentation Trials in one Set (loop)
settings.cue_conditioning_test_trials   = 8; % After conditioning trials test conditioning, here performance is tested (Trials in one Set (loop))
settings.train_trials                   = 16; % Full Trials during Training
settings.trials                         = 72; % Trials during Experiment 

settings.cond_performance = 1;  % benchmark for minimum performance in tone-reward association learning for one cue_conditioning_trials round (is repeated until this performance is reached) 
settings.invalid_effort = 20;  % threshold (in percentage) of max relative force that is allowed during beep tone before trial will be announced as invalid (during training) 

%% Settings Task Timings 

timings.cue_length          = 3; 
timings.signaltone_length   = 0.3; 
timings.effort_length       = 3; % responding time with GFD (bidding phase)
timings.break_length        = 10;
timings.feedback_length     = 4;

timings.number_breaks       = 1;
timings.calibration_length  = 10; % length of calibration trials in s
timings.cue_response_wait   = 3; % Time a response needs to be performed during cue condition learning 


% Set jitter specifications, at the end of code jitters are computed, 
% if you change setting here, re-create jitter files!
timings.avrg_jttr_feedback   = '2';
timings.avrg_jttr_itt        = '2';
timings.max_jttr_feedback    = '12';
timings.max_jttr_itt         = '12';

% MR specific timings (theory durations, actual ones will be saved during
% experiment as well) 
MR_timings.fixed.durations.condition_preview_reward = timings.cue_length; 
MR_timings.fixed.durations.effort     = timings.effort_length;
MR_timings.fixed.durations.feedback   = timings.feedback_length;
MR_timings.fixed.durations.break      = timings.break_length; 

% determine before what trial breaks should be inserted
timings.break_trials = [];
for brk = 1:timings.number_breaks   
   breaknumbr           = settings.trials /(timings.number_breaks + 1)* brk;
   timings.break_trials = [timings.break_trials, round(breaknumbr)];
end
timings.break_trials = timings.break_trials + 1;

%% Stimuli 
% Already read in as correct data format for faster processing during experiment 

% Visual Stimuli (Training Phase)
[stimuli.img.incentive_coins1, stimuli.img.map, stimuli.img.alpha]  = imread('./Stimuli/incentive_coins1.jpg');
[stimuli.img.incentive_coins10, stimuli.img.map, stimuli.img.alpha] = imread('./Stimuli/incentive_coins10.jpg');

[stimuli.img.incentive_cookies1, stimuli.img.map, stimuli.img.alpha]  = imread('./Stimuli/incentive_cookies_choc1.jpg');
[stimuli.img.incentive_cookies10, stimuli.img.map, stimuli.img.alpha] = imread('./Stimuli/incentive_cookies_choc10.jpg');

% Auditory Stimuli (Experiment) 
% Tone Frequencies for reward conditions, which Tone Type goes for which
% incentive is determined in Create_Conditions.m

% Choose 4 Distinct Tones: E.g. different Instruments
% Tone 1: Food Low 
% Tone 2: Money Low 
% Tone 3: Food High 
% Tone 4: Money High 

% If pseudoranomization:
% Two lower or sad instruments for low reward magnitudes
stimuli.tone.one.name = fullfile(pwd, '/Stimuli/mixkit-flute-music-notification-2311.wav');  % Tone 1
stimuli.tone.two.name = fullfile(pwd, '/Stimuli/mixkit-guitar-stroke-up-slow-2338.wav');  % Tone 2

% Two higher or successfull instruments for high reward magnitudes
stimuli.tone.three.name = fullfile(pwd, '/Stimuli/mixkit-orchestra-triumphant-trumpets-2285.wav');  % Tone 3
stimuli.tone.four.name = fullfile(pwd, '/Stimuli/mixkit-drum-roll-566.wav');  % Tone 4

% Read WAV file from filesystem
[stimuli.tone.one.y, stimuli.tone.one.freq] = psychwavread(stimuli.tone.one.name);
[stimuli.tone.two.y, stimuli.tone.two.freq] = psychwavread(stimuli.tone.two.name);
[stimuli.tone.three.y, stimuli.tone.three.freq] = psychwavread(stimuli.tone.three.name);
[stimuli.tone.four.y, stimuli.tone.four.freq] = psychwavread(stimuli.tone.four.name);


%% Randomization Tone-Reward Pairings 
settings.tone_rand_rewardType = 1; % Determine full (0) or partial (1, i.e. only across Reward Type not Magnitude) randomization
 
%% Create corresponding jitters
% Only do this in the beginning of the study, afterwards 
% comment this so that you don't re-create jitter over and over again

% % Jitter for the Time between Instrumental and Feedback phase
% DelayJitter(str2num(timings.avrg_jttr_feedback), str2num(timings.max_jttr_feedback), settings.train_trials)
% DelayJitter(str2num(timings.avrg_jttr_feedback), str2num(timings.max_jttr_feedback), settings.trials)
% 
% % % Jitter for inter-trial interval
% DelayJitter(str2num(timings.avrg_jttr_itt), str2num(timings.max_jttr_itt), settings.train_trials)
% DelayJitter(str2num(timings.avrg_jttr_itt), str2num(timings.max_jttr_itt), settings.trials)

%% Clear redundant variables 
clear breaknumbr brk i repeat_factor

%% Save Settings File

name_file = strcat('IMT_settings_TUE008.mat');
save(name_file)