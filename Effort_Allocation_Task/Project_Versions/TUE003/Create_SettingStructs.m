%% save all study specific settings in .mat 
% choose name for .mat file
clear
name_file = 'EATsettings';

%% Part 1: settings and study information

% settings
settings.do_fullscreen = 1;  % default second monitor, if connected
settings.do_fmri       = 0;  % will include trigger
settings.debug         = 0;  % input device not required
settings.do_gamepad    = 1;  % frequency
settings.do_WOF        = 1;  % include wheel of fortune
settings.do_VAS        = 1;  % include VAS
settings.do_val_cal    = 1;  % calibrate value difference between food/money
settings.use_val_cal   = 0;  % use calibrated value difference for food/money (txt file in data folder)
settings.do_timelimit  = 1;  % time limit for intermittent VAS questions
settings.lang_de       = 1;  % german. English when 0
settings.do_feedback   = 1;  % feedback on (1) or off (0)
settings.train_trials  = 2;  % amount of training trials to estimate max/min (2 or 3)
settings.do_EGG        = 0;  % turn on/off settings for electrogastrogram
settings.do_VNS        = 0;  % turn on/off settings for vagus nerve stimulation
settings.load_max_sess = 1;  % 
settings.do_uncertain  = 1;  % turn off uncertainty trials in EAT

% Study information
subj.study             = 'TUE003';  % Project number
subj.sessionID         = '1';  % Session
subj.runID             = '1';  % Runs per session   

% Settings VAS
if settings.do_VAS == 1
    settings.VAS_input      = 1; % VAS input is 1 for joystick, 0 for mouse
    settings.VAS.exhaustion = 1;
    settings.VAS.wanting    = 1;
    settings.VAS.happy1     = 1;
    settings.VAS.happy2     = 1;
end

if settings.do_WOF == 1
    settings.wof.win_sequence = [2 -2 2 4 -1 -6 7 6 -3 -7 2 6 -7 2]';
    settings.wof.win_variation = [-1 1 1 1 0 0 0 0 -1 1 1 -1 -1 -1]';
end

settings.value_money   = 32;    % amount of cents earned with 100 points
settings.value_food    = 32;    % amount of kcal earned with 100 points
settings.clckforce     = 20000; % only relevant for grip force device set-ups

%% Part 2: task timings

% Durations of  
if settings.do_fmri == 0
    timings.trial_length        = 24; 
    timings.break_length        = 15; 
    timings.feedback_length     = 2.5;
    timings.fix1_length         = 0;
    timings.fix2_length         = 1.5;
    timings.bidding_length      = 3;
    timings.VAS_rating_duration = 3.2; 
    timings.number_breaks       = 3;
    timings.number_trials       = 72;
    timings.avrg_jttr_ball      = '1';
    timings.avrg_jttr_fix1      = '1';
    timings.avrg_jttr_fix2      = '1';
    timings.max_jttr_ball       = '4';
    timings.max_jttr_fix1       = '12';
    timings.max_jttr_fix2       = '12';
elseif settings.do_fmri == 1
    timings.trial_length        = 22;
    timings.break_length        = 10;
    timings.feedback_length     = 2.5;
    timings.fix1_length         = 0.5;
    timings.fix2_length         = 1;
    timings.number_breaks       = 2;
    timings.number_trials       = 64;
    timings.avrg_jttr_ball      = '1';
    timings.avrg_jttr_fix1      = '1.5';
    timings.avrg_jttr_fix2      = '3';
    timings.max_jttr_ball       = '4';
    timings.max_jttr_fix1       = '12';
    timings.max_jttr_fix2       = '12';
    %MR specific timings
    MR_timings.durations.effort     = timings.trial_length;
    MR_timings.durations.feedback   = timings.feedback_length;
    MR_timings.durations.win        = [];
    MR_timings.durations.rest_phase = [];
end

% determine before what trial breaks should be inserted
timings.break_trials = [];
for brk = 1:timings.number_breaks   
   breaknumbr           = timings.number_trials/(timings.number_breaks + 1)* brk;
   timings.break_trials = [timings.break_trials, round(breaknumbr)];
end
timings.break_trials = timings.break_trials + 1;

if settings.do_WOF == 1
    timings.nmbr_trls_to_WOF    = 6;
    timings.time_to_start       = 1; %Time to spin WOF from button press
    timings.show_wheel          = 0.5;
    timings.show_feedback       = 5;
    timings.PANAS_trials        = timings.break_trials - 1;   
    timings.PANAS_trials        = [timings.PANAS_trials, timings.number_trials];
    timings.wof.time_wait       = 1;
    timings.wof.time_show_pie_feedback_phase = 5;
    timings.wof.time_show_feedback = 3;
end

%% create WoF instructions

instr = generate_wof_instr(settings.do_fmri);

%%

save([name_file '_' subj.study '_S' subj.sessionID '_R' subj.runID '.mat'])