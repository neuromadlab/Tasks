% ================== Reward rating task evaluation paradigm TUE009 =============================
% Coded by: Maria Berjano and Johanna Theuer
% Coded 1
% with: Matlab R2020b using Psychtoolbox 3.0.11
%
% Current Version: 1 (February 2022)
% =========================================================================
clear
sca

%% Part 1: General settings and preparation
subj.version = 1; %Task version
output.version = subj.version;
subj.study = 'TUE009'; % Enter here current study name
subj.subjectID = input('Subject ID: ','s');
subj.sessionID = input('Session ID [0]: ','s');
subj.sessionID = num2str(str2double(subj.sessionID)+1);
subj.date_start = datestr(now);

% Convert subject info
subj.subjectID = [repmat('0',1,6-length(subj.subjectID)) subj.subjectID];
subj.id = str2double(subj.subjectID);   % converts Subject ID to integer
subj.sess = str2double(subj.sessionID); % converts Session ID to integer

validInput = false;
while ~validInput
    i_rep = input('German? (Elsewise english) [y/n] ','s');
    if strcmp(i_rep,'y')
        settings.lang_de = true;
        validInput = true;
    elseif strcmp(i_rep,'n')
        settings.lang_de = false;
        validInput = true;
    else
        warning('Not a valid answer! Please try again.');
    end
end

validInput = false;
while ~validInput
    i_rep = input('Would you like to start the experiment in Phase I or Phase II? [1/2] ','s');
    if strcmp(i_rep,'1')
        settings.start_phase_I = true;
        validInput = true;
    elseif strcmp(i_rep,'2')
        settings.start_phase_I = false;
        validInput = true;
    else
        warning('Not a valid answer! Please try again.');
    end
end

subj.erotic_cat = input('Erotische Bilder von Männern (1), Frauen (2) oder beiden Geschlechtern (3): ','s');


settings.do_fullscreen = 0;
settings.do_joystick = 1;

% set up folder for backups and final data
backup_folder = 'Backup';
data_folder = 'Data';

if ~exist([pwd, filesep,backup_folder], 'dir')
    mkdir([pwd, filesep,backup_folder])
end
if ~exist([pwd, filesep,data_folder], 'dir')
    mkdir([pwd, filesep,data_folder])
end

subj.date = datestr(now, 'yyyymmdd-HHMM');

% Automatic operating information
Screen('Preference', 'SkipSyncTests', 1);

% Get operating system and set OS flags
system_info = Screen('Computer');
windows = system_info.windows;
mac = system_info.osx;
linux = system_info.linux;   

%%  Part 2: Set task parameters   
% Display settings
color_background = [255 255 255]; %white
color_scale_anchors = [0 0 0]; %black

screen_offset_y = 0.01; %relative offset; positive values move the screen towards to top, negative towards the bottom
scale_offset_y = 0.25;
min_ISI = 0.1;
    
do_scales = 1; %will run scale in prob_scales*100% of trials
preset = 1; % needs to be 1 to skip screen initialization, thus use scales as part of experiment    

% Screen settings
Screen('Preference', 'SkipSyncTests', 1);
PsychDefaultSetup(2);
screens = Screen('Screens'); %Define display screen
setup.screenNum = max(screens);

if settings.do_fullscreen == 1
    [w,wRect] = Screen('OpenWindow', setup.screenNum,[255 255 255]);
    Screen('Preference', 'SkipSyncTests', 0);
    HideCursor()
else
    [w,wRect] = Screen('OpenWindow', 0, 255, [10 30 810 630]);
    Screen('Preference', 'SkipSyncTests', 1);
end

% Get the center coordinates
[ww, wh] = Screen('WindowSize', w);
setup.ScrWidth = ww;
setup.ScrHeight = wh;
% Image scaling according to screen settings 
% window width: ww, and window height: wh
scale_x = ww/1024;
scale_y = wh/768;
x_cent = ww/2;
y_cent = wh/2;

% Load Gamepad Controller Specifications and query one time to generate variables
load('JoystickSpecification.mat');
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

% Fixation cross
fixation = '+';

%% Part 3: Load instructions and stimuli 
load('texts.mat')
if settings.lang_de == 1
    language = 'de';
else
    language = 'en';
end

text_Cont = texts.text_Cont.(language);

%load stimuli depending on male/female choice
if str2double(subj.erotic_cat) == 1
    load('stimuli_male.mat')
elseif str2double(subj.erotic_cat) == 2
    load('stimuli_female.mat')
else
    load('stimuli.mat')
end

music_icon = Screen('MakeTexture',w,stimuli.music_icon);
for i = 1:60
    if i <= 20
        stimuli_all{i} = Screen('MakeTexture',w,stimuli.food{i});
    elseif i <= 40
        stimuli_all{i} = Screen('MakeTexture',w,stimuli.erotic{i-20});
    else
    InitializePsychSound(1);
    pahandle = PsychPortAudio('Open', [], [], [], [], 2, 0);
    stimuli_all{i} = stimuli.music_data{i-40};
    end
end

%% Part 4: Phase I settings
% Get random order of stimuli presentation for Phase I without
% consecutively repeating the same item
total_stimuli = repelem(1:60,2); % each stimulus appears twice
total_questions = repmat([0,1], 1, 60); % 0 --> Wanting question; 1 --> Liking question
sequence_found = false;
rng(GetSecs);
while ~sequence_found 
    shuffle_order = randperm(numel(total_stimuli));
    candidate = total_stimuli(shuffle_order);
    if all(diff(candidate) ~= 0) % check if no repeated values
        sequence_found = true;
    end
end
stimuli_order = candidate;
question_order = total_questions(shuffle_order);

% rectangle that frames pictures and task
img_fct = 2*size(stimuli_all{1},2)/size(stimuli_all{1},1);
rating_scr_rect_y1 = 125;
rating_scr_rect_y2 = 450;
rating_scr_rect_x1 = (ww - 0.95*ww);
rating_scr_rect_x2 = (ww - 0.95*ww)+(rating_scr_rect_y2-rating_scr_rect_y1)*img_fct;
rating_scr_rect = [rating_scr_rect_x1 rating_scr_rect_y1 rating_scr_rect_x2 rating_scr_rect_y2+200];
highlighter_colour = [200 200 200];

% choose position of task text relative to rectangle
position_task_x = ww - 0.89*ww;
position_task_y = (rating_scr_rect_y2 + 44)/2;

% compute size of image to fit into the rectangle
desired_img_height = (rating_scr_rect_y2 - rating_scr_rect_y1);
desired_img_width = (rating_scr_rect_x2 - rating_scr_rect_x1);

%% Part 5: Phase II and III settings
% Postition of stimulus in Phase II
image_width = 500;
image_height = 500; 
position_left = [ww/2-260-image_width wh/2-image_height/2 ww/2-200 wh/2+image_height/2];
position_right = [ww/2+200 wh/2-image_height/2 ww/2+260+image_width wh/2+image_height/2];

% Number of trials in Phase II
n_trials = 210;

% Time constrains in Phase II and III
time_limit = 4;
sampling_time_phase_III = 30;

% Reward trials (Phase III)
n_reward_trials = 3;
con_trials = [n_trials/n_reward_trials:n_trials/n_reward_trials:n_trials]; 
% If the number of trials in Phase II or the number of reward trials want
% to be changed, the above line should be adapted so that the number of
% total trials is a multiple of the number of reward trials. If it is not
% the case, the code should be adapted

% List of nonavailable food rewards (Phase III)
exclude_food = [0,3,5,7:18];

%% Part 6: Input device settings
control_joystick = 1;
if settings.do_joystick == 1 
    load('JoystickSpecification.mat');
    input_type = 1; % variable needed in VAS and LHS scale scripts to index Joystick (vs. Mouse)
    if strcmp(subj.study,'TUE009')
        findJoystick
    end
end
VAS_rating_duration = 20;

%% Part 7: Load jitters and initialize jitter counters
load('DelayJitter_mu_0.3_max_0.8_trials_500.mat'); 
jitter = Shuffle(DelayJitter);
count_jitter = 1;
load('DelayJitter_mu_2_max_6_trials_250.mat');
jitter_slider = Shuffle(DelayJitter);
count_jitter_slider = 1;

%% Part 8: Start of experiment and Phase I 
% ======================== Start of the experiment ========================
% =========================================================================
% The experiment consists of two phases and a reward presentation:
% 1. Rating of all stimuli (wanting and liking)
% 2. Choosing between 2 stimuli presented simultaneously
% 3. Reward presentation

subj.time.start = GetSecs;

% ================== Phase I: Rating ==================
% 
phase_i = 1;

if settings.start_phase_I 
    % Instructions screen
    Screen('TextSize',w,44);
    Screen('TextFont',w,'Arial');
    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(texts.instructions.header.(language), 'Bewertung'), 'center', wh/4, [0 0 0],60);
    Screen('TextSize',w,40);
    Screen('TextFont',w,'Arial');
    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, texts.instructions.phase_I.(language), 'center', pos.y + 50, [0 0 0],60);
    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text_Cont, 'center', wh-50, [0 0 0],60);
    Screen('Flip', w, []);    
    
    while Joystick.Button(1) ~= 1
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    end
    WaitSecs(0.5);
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    
    % show fixation cross
    Screen('TextSize',w,64);
    Screen('TextFont',w,'Arial');
    DrawFormattedText(w, fixation, 'center', 'center', [0 0 0],80);
    [ons_resp, startTime] = Screen('Flip', w);

    % Loop for rating all stimuli
    paradigm_onset = GetSecs; % get time of beginning of the paradigm
    output_phase_1 = struct([]);
    output_phase_I = zeros(60,3);
    sampling_time = 2;
    for idx = 1:length(total_stimuli)
        % Stop loop by holding any key pressed
        [keyIsDown, keysecs, keyCode] = KbCheck;
        if keyIsDown == 1
            Screen('CloseAll');
            break;
        end
             
        % Identify question type
        if question_order(idx) == 0
            scale_type = 'wanting';
            question_type = 'wanting';
            trial.question = 'wanting';                        
        else
            scale_type = 'liking';
            question_type = 'liking';
            trial.question = 'liking';
        end
        
        % Identify stimulus 
        position = stimuli_order(idx);
        if position <= 40 % food or erotic stimuli (image)
            texture_i = stimuli_all{position};
            if position < 21
                item_label = 'food';
                category = 1;
            else
                item_label = 'erotic';
                category = 2;
            end
        else % music stimuli (audio)
            texture_i = music_icon;
            PsychPortAudio('FillBuffer', pahandle, stimuli_all{position}');
            item_label = 'music';
            category = 3;
        end
        
        % Display stimulus and rating scale
        Effort_VAS            
                
        % show fixation cross
        Screen('TextSize',w,64);
        Screen('TextFont',w,'Arial');
        DrawFormattedText(w, fixation, 'center', 'center', [0 0 0],80);
        [ons_resp, startTime] = Screen('Flip', w);
       
        % saving how much time passed between experiment onset and fixation
        % cross onset
        %output_phase_1.time.fix1(idx,1) = startTime - paradigm_onset;
        WaitSecs(min_ISI+jitter(count_jitter));
        count_jitter = count_jitter + 1;
        
        % save output data
        output_phase_1{idx,1} = subj.id;
        output_phase_1{idx,2} = subj.sess;
        output_phase_1{idx,3} = idx; %trial
        output_phase_1{idx,4} = position; %image number
        output_phase_1{idx,5} = img_file{position,1};
        output_phase_1{idx,6} = item_label; %image category
        output_phase_1{idx,7} = double(string(item_label)=="erotic");
        output_phase_1{idx,8} = double(string(item_label)=="music");
        output_phase_1{idx,9} = double(string(scale_type)=="wanting"); %wanting/liking
        output_phase_1{idx,10} = rating; %rescaling of scale_width independent of screen resolution [0-100]
        output_phase_1{idx,11}  = t_rating_ref; %timing
        if flag_resp == 1
            output_phase_1{idx,12} = 1; %response submitted                  
        elseif flag_resp == 0
            output_phase_1{idx,12} = 0; %response not submitted
        end
        output_phase_1{idx,13} = img_file{position,2};    %male
        output_phase_1{idx,14} = img_file{position,4};   %high_cal
        output_phase_1{idx,15} = img_file{position,3};  %sweet
        %output_phase_1{idx,8} = controller_positions; 
        if idx == length(total_stimuli)
        output_phase_1 = cell2table(output_phase_1,'VariableNames',{'ID' 'Session' 'Trial' 'stimulus' 'filename' 'category' 'erotic' 'music' 'wanting' 'rating' 'RT' 'submitted' 'male' 'high_cal' 'sweet'});
        end
        % save temporary file
        filename = ['RR_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_phase_1', '_temp_', subj.date ];
        save(fullfile('Backup', [filename '.mat']),'output_phase_1','subj');
        
        % input for phase II order generator function
        % category: 1 (food), 2 (erotic), or 3 (music)
        % position: from 1 to 60 (stimuli identifier)
        % rating: value obtained in the wanting rating
        if question_order(idx) ~= 0
            output_phase_I(position,:) = [category, position, rating]; 
        end
    end
    
        filename = ['temp_RR_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_phase_1'];
        save(fullfile('Backup', [filename '.mat']),'output_phase_I','output_phase_1','subj');
          
    
end

%% Part 9: ================== Phase II: Choosing ================== 
phase_i = 2;

if settings.start_phase_I 
    chosen_pairs = choose_pairs_trials_random(output_phase_I, n_trials);
elseif ~isempty(dir(['Backup/temp_RR_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_phase_1.mat']))
    filename = ['temp_RR_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_phase_1'];
    load(fullfile('Backup', [filename '.mat']),'output_phase_I','output_phase_1','subj');
    chosen_pairs = choose_pairs_trials_random(output_phase_I, n_trials);
else   
    load('output_phase_I_generic.mat');
    chosen_pairs = choose_pairs_trials_random(output_phase_I, n_trials);
end

% Instructions screen
Screen('TextSize',w,44);
Screen('TextFont',w,'Arial');
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(texts.instructions.header.(language), ' Entscheidung'), 'center', wh/4, [0 0 0],60);
Screen('TextSize',w,40);
Screen('TextFont',w,'Arial');
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, texts.instructions.phase_II.(language), 'center', pos.y + 50, [0 0 0],60);
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text_Cont, 'center', wh-50, [0 0 0],60);
Screen('Flip', w, []);  

while Joystick.Button(1) ~= 1
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(0.5);
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

% Instructions screen
Screen('TextSize',w,44);
Screen('TextFont',w,'Arial');
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(texts.instructions.header.(language), ' Entscheidung'), 'center', wh/4, [0 0 0],60);
Screen('TextSize',w,40);
Screen('TextFont',w,'Arial');
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, texts.instructions.phase_III.(language), 'center', pos.y + 50, [0 0 0],60);
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text_Cont, 'center', wh-50, [0 0 0],60);
Screen('Flip', w, []);  

while Joystick.Button(1) ~= 1
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(0.5);
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);


Screen('TextSize',w,44);
Screen('TextFont',w,'Arial');
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(texts.instructions.header.(language), ' Entscheidung'), 'center', wh/4, [0 0 0],60);
Screen('TextSize',w,40);
Screen('TextFont',w,'Arial');
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, texts.instructions.reward.(language), 'center', pos.y + 50, [0 0 0],60);
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text_Cont, 'center', wh-50, [0 0 0],60);
Screen('Flip', w, []);  


while Joystick.Button(1) ~= 1
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(0.5);
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

% show fixation cross
Screen('TextSize',w,64);
Screen('TextFont',w,'Arial');
DrawFormattedText(w, fixation, 'center', 'center', [0 0 0],80);
[ons_resp, startTime] = Screen('Flip', w);
WaitSecs(min_ISI+jitter(count_jitter));
count_jitter = count_jitter + 1;

feedback_delay = 0.1;
paradigm_onset_2 = GetSecs;
winner_candidate = zeros(1,n_trials);
output_phase_2 = cell(n_trials,25);

scale_type = 'liking';
question_type = 'liking';
trial.question = 'liking';
VAS_rating_duration = sampling_time_phase_III;
position = 1;
rating_pos = [];
trial_nr = [];
trial_pos = [];
stimulus = [];
high_cal = [];
sweet = [];
male = [];
condition = [];
erotic = [];
music = [];
rating_lik = [];
output_reward = [];

idx_3 =1;
sampling_time = sampling_time_phase_III;
% matrix_phase_II_order: 
% rows --> choosing trials
% columns ---> rating, category, stimuli number 
for idx_2 = 1:n_trials
    
    % Stop loop by holding any key pressed
    [keyIsDown, keysecs, keyCode] = KbCheck;
    if keyIsDown == 1
        Screen('CloseAll');
        break;
    end
    sound = 0;
    for j = 1:2
        category_trial = chosen_pairs(idx_2,2+3*(j-1));
        candidate = chosen_pairs(idx_2,3+3*(j-1));
        if category_trial == 1
            selected_stimulus = stimuli_all{candidate};
            item_label = 'food';  
        elseif category_trial == 2
            selected_stimulus = stimuli_all{candidate};
            item_label = 'erotic';
        else
            selected_stimulus = music_icon;
            PsychPortAudio('FillBuffer', pahandle, stimuli_all{candidate}');
            PsychPortAudio('Start', pahandle, 1, 0);
            sound = 1;
            item_label = 'music';
        end
        if j == 1
            left_stimulus = selected_stimulus;
            item_label_left = item_label;
            candidate_left = candidate;
            category_stimulus = category_trial;
        else
            right_stimulus = selected_stimulus;
            item_label_right = item_label;
            candidate_right = candidate;
            category_stimulus = category_trial;
        end
    end
    
    Screen('DrawTexture',w, left_stimulus,[], [position_left]);
    Screen('DrawTexture',w, right_stimulus,[], [position_right]);
    Screen('Flip',w,[]);
    
    choosing_subm = 0;
    start_time_trial = GetSecs;
    
    while GetSecs - start_time_trial < time_limit && choosing_subm == 0
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        if time_limit - (GetSecs - start_time_trial) < 1 && time_limit - (GetSecs - start_time_trial) > 0.99
        
            Screen('DrawTexture',w, left_stimulus,[], [position_left]);
            Screen('DrawTexture',w, right_stimulus,[], [position_right]);
            Screen('TextSize',w,240);
            Screen('TextFont',w,'Arial');
            Screen('TextColor',w,[255 0 0]);
            Screen('TextStyle',w,1)
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, '!', 'center', wh/2, [255 0 0]);
            Screen('Flip',w);

        end
        
        if Joystick.Button(2) == 1 || Joystick.Button(3) == 1
            if Joystick.Button(2) == 1
                %output_phase_2.button{idx_2} = 'right';
                winner_candidate(idx_2) = candidate_right; 
                choice = double(Joystick.Button(2) == 1);
            else
                %output_phase_2.button{idx_2} = 'left';
                winner_candidate(idx_2) = candidate_left; 
                choice = double(Joystick.Button(2) == 1);
            end
            Joystick.Button(2) = 0;
            Joystick.Button(3) = 0;
            t_rating_ref = GetSecs - start_time_trial;
            choosing_subm = 1;
            output_phase_2{idx_2,8} = 1; % response submitted
        end
    end
    
    if choosing_subm == 0
        t_rating_ref = GetSecs - start_time_trial;
        output_phase_2{idx_2,8} = 0; % response not submitted
    end
    
    if sound == 1
        PsychPortAudio('Stop', pahandle);
    end   
    
    % show 2nd fixation cross
    Screen('TextSize',w,64);
    Screen('TextFont',w,'Arial');
    DrawFormattedText(w, fixation, 'center', 'center', [0 0 0],80);
    [ons_resp, startTime] = Screen('Flip', w);
    WaitSecs(min_ISI+jitter(count_jitter));
    count_jitter = count_jitter + 1;
    
    % saving how much time passed between experiment onset and fixation
    % cross onset
    %output_phase_2.time.fix2(idx_2,1) = startTime - paradigm_onset_2;
    WaitSecs(min_ISI+jitter(count_jitter));
    count_jitter = count_jitter + 1;
    
    %winner category
    if winner_candidate(idx_2) < 21
        cat_win = "food";
    elseif winner_candidate(idx_2) < 41 
        cat_win = "erotic";
    else
        cat_win = "music";
    end
    
    % save output data
    output_phase_2{idx_2,1} = subj.id;
    output_phase_2{idx_2,2} = subj.sess;
    output_phase_2{idx_2,3} = idx_2; %trial
    output_phase_2{idx_2,4} = item_label_left; % left image category
    output_phase_2{idx_2,5} = chosen_pairs(idx_2,3); % image number left stimulus
    output_phase_2{idx_2,6} = double(string(item_label_left)=="erotic");
    output_phase_2{idx_2,7} = double(string(item_label_left)=="music");
    output_phase_2{idx_2,8} = img_file{chosen_pairs(idx_2,3),1};    %image file name
    output_phase_2{idx_2,9} = img_file{chosen_pairs(idx_2,3),2};    %male
    output_phase_2{idx_2,10} = img_file{chosen_pairs(idx_2,3),4};   %high_cal
    output_phase_2{idx_2,11} = img_file{chosen_pairs(idx_2,3),3};  %sweet
    output_phase_2{idx_2,12} = output_phase_I(output_phase_I(:,2)== chosen_pairs(idx_2,3),3);   %liking rating left
    output_phase_2{idx_2,13} = output_phase_1.rating(output_phase_1.stimulus==chosen_pairs(idx_2,3)&output_phase_1.wanting == 1);
    output_phase_2{idx_2,14} = item_label_right; % right image category
    output_phase_2{idx_2,15} = chosen_pairs(idx_2,6); % image number right stimulus
    output_phase_2{idx_2,16} = double(string(item_label_right)=="erotic");
    output_phase_2{idx_2,17} = double(string(item_label_right)=="music");
    output_phase_2{idx_2,18} = img_file{chosen_pairs(idx_2,6),1};    %image file name
    output_phase_2{idx_2,19} = img_file{chosen_pairs(idx_2,6),2};    %male
    output_phase_2{idx_2,20} = img_file{chosen_pairs(idx_2,6),4};   %high_cal
    output_phase_2{idx_2,21} = img_file{chosen_pairs(idx_2,6),3};  %sweet
    output_phase_2{idx_2,22} = output_phase_I(output_phase_I(:,2)== chosen_pairs(idx_2,6),3);   %liking rating left
    output_phase_2{idx_2,23} = output_phase_1.rating(output_phase_1.stimulus==chosen_pairs(idx_2,6)&output_phase_1.wanting == 1);
    output_phase_2{idx_2,24} = choice;
    output_phase_2{idx_2,25} = cat_win;
    output_phase_2{idx_2,26} = winner_candidate(idx_2); %choice
    output_phase_2{idx_2,27} = t_rating_ref; %timing 
    
    if idx_2 ==n_trials
    output_phase_2 = cell2table(output_phase_2,'VariableNames',{'ID' 'Session' 'Trial' 'category_l' 'stimulus_l' 'erotic_l' 'music_l' 'filename_l' 'male_l' 'high_cal_l' 'sweet_l' 'rating_liking_l' 'rating_wanting_l' 'category_r' 'stimulus_r' 'erotic_r' 'music_r' 'filename_r' 'male_r' 'high_cal_r' 'sweet_r' 'rating_liking_r' 'rating_wanting_r' 'choice_r' 'choice_cat' 'choice_item' 'RT'});
    end 
    % save temporary file
    filename = ['RR_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_phase_2','_temp_', subj.date ];
    save(fullfile('Backup', [filename '.mat']),'output_phase_2','subj','output_reward');
    
    % after every 1/3 
    % choice value: how often this stimulus is chosen
    
    if idx_2==con_trials(idx_3)
        
        if idx_3 < 3
            %instruction 1/2 do whatever 3 if food get experimenter
            % Instructions screen II
            Screen('TextSize',w,44);
            Screen('TextFont',w,'Arial');
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf('Belohnung'), 'center', wh/4, [0 0 0],60);
            Screen('TextSize',w,40);
            Screen('TextFont',w,'Arial');
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, texts.instructions.reward_III.(language), 'center', pos.y + 50, [0 0 0],60);
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, texts.text_Cont.(language), 'center', wh-50, [0 0 0],60);
            Screen('Flip', w, []);
            
            while Joystick.Button(1) ~= 1
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            end
            WaitSecs(0.5);
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            
            %filter choices for available rewards
            potential_reward = winner_candidate(winner_candidate>20 & ~ismember(winner_candidate,exclude_food));
            
            %choose one item randomly 
            consummatory_ch =  randsample(potential_reward,1);
            
            exclude_food(end+1) = consummatory_ch;
            
        elseif idx_3 == 3
            
            %filter choices for available rewards
            potential_reward = winner_candidate(~ismember(winner_candidate,exclude_food));
            
            %choose one item randomly 
            consummatory_ch =  randsample(potential_reward,1);
            
            % Instructions screen II
            Screen('TextSize',w,44);
            Screen('TextFont',w,'Arial');
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf('Belohnung'), 'center', wh/4, [0 0 0],60);
            Screen('TextSize',w,40);
            Screen('TextFont',w,'Arial');
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, texts.instructions.reward_III.(language), 'center', pos.y + 50, [0 0 0],60);
            if consummatory_ch < 21
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, [texts.text_Cont_III.(language),' (',num2str(consummatory_ch),')'], 'center', wh-50, [0 0 0],60);
            else
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, texts.text_Cont.(language), 'center', wh-50, [0 0 0],60);
            end
            
            Screen('Flip', w, []);
            if consummatory_ch < 21
                while Joystick.Button(2) ~= 1
                    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
                end
            else
                while Joystick.Button(1) ~= 1
                    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
                end
            end
            WaitSecs(0.5);
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
                
            
        end
        
        %choose items from the ones chosen in up until now. Exclude previous
        %rewards and food items depending on trial number
        
        if consummatory_ch > 40
            texture_i = music_icon;
            PsychPortAudio('FillBuffer', pahandle, stimuli.music_data{consummatory_ch-20}');
            PsychPortAudio('Start', pahandle, 1, 0);
        else
            texture_i = stimuli_all{consummatory_ch};
        end
        
        Effort_VAS
        output_reward.controller_pos.(['reward',num2str(idx_3)]) = controller_positions;
        
        if consummatory_ch > 40
            PsychPortAudio('Stop', pahandle);
        end
        % show fixation cross
        Screen('TextSize',w,64);
        Screen('TextFont',w,'Arial');
        DrawFormattedText(w, fixation, 'center', 'center', [0 0 0],80);
        [ons_resp, startTime] = Screen('Flip', w);
        WaitSecs(min_ISI+jitter(count_jitter));
        count_jitter = count_jitter + 1;
        
        if  consummatory_ch > 40
            cond = "music";
        elseif  consummatory_ch > 20
            cond = "erotic";
        else
            cond = "food";
        end
        
        %longformat output data
        rating_pos = [rating_pos; controller_positions_rating];
        id = repmat(subj.id,length(rating_pos),1);
        session = repmat(subj.sess,length(rating_pos),1);
        trial_nr = [trial_nr;repmat(idx_3,length(controller_positions),1)];
        trial_pos = [trial_pos;[0.01:0.01:30]'];
        stimulus = [stimulus;repmat(consummatory_ch,length(controller_positions),1)];
        high_cal = [high_cal;repmat(img_file{consummatory_ch,4},length(controller_positions),1)];
        sweet = [sweet;repmat(img_file{consummatory_ch,3},length(controller_positions),1)];
        male = [male;repmat(img_file{consummatory_ch,2},length(controller_positions),1)];
        condition = [condition;string(repmat(cond,length(controller_positions),1))];
        erotic = [erotic;repmat(double(string(cond)=="erotic"),length(controller_positions),1)];
        music = [music;repmat(double(string(cond)=="music"),length(controller_positions),1)];
        rating_lik = [rating_lik;repmat(output_phase_I(output_phase_I(:,2)== consummatory_ch,3),length(controller_positions),1)];
        
        output_reward.data = array2table([id,session,trial_nr, trial_pos,stimulus,erotic,music,male,high_cal,sweet,rating_lik,rating_pos],...
            'VariableNames',{'ID' 'Session' 'Trial' 'Time' 'stimulus' 'erotic' 'music' 'male' 'high_cal' 'sweet' 'rating_liking_antic' 'rating'} );
        output_reward.data.category = string(condition);
        
        % save temporary file
        filename = ['RR_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_temp_', subj.date ];
        save(fullfile('Backup', [filename '.mat']),'output_reward','subj');
        
        idx_3 = idx_3 +1;
    end
    
end

%% Part 10: End of experiment
Screen('TextSize',w,44);
Screen('TextFont',w,'Arial');
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(texts.end_text.(language)), 'center', 'center', [0 0 0],60);
Screen('Flip', w, []);  

% Save time end of experiment
subj.time.end = GetSecs;
subj.length_exp = (subj.time.end - subj.time.start)/60; %length exp in min

%% Part 11: Save experiment data
% Save output
filename = ['RR_', subj.study, '_', subj.subjectID, '_S', subj.sessionID];
if settings.start_phase_I 
    save(fullfile('Data', [filename '.mat']),'output_phase_1','output_phase_2','output_reward','subj');
else
    save(fullfile('Data', [filename '.mat']),'output_phase_1','output_phase_2','output_reward','subj');
end
clear stimuli
save(fullfile('Backup', [filename datestr(now,'_yymmdd_HHMM') '.mat']));

ShowCursor();
Screen('CloseAll');