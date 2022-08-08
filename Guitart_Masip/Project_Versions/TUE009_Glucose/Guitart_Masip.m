%%=================Guitart-Masip task====================
% Guitart Masip implementation (adapted from https://doi.org/10.1016/j.neuroimage.2012.04.024)
% using the stimulus timing from https://doi.org/10.1016/j.biopsych.2017.01.017
% vanessa.teckentrup@uni-tuebingen.de
%========================================================
% TUE007 Update: Corinna Schulz, corinna.schulz96@gmail.com
% TUE009 Update: Maria Berjano, berjanomaria@gmail.com

%%%%%%%%%%%%%%%%%%%%%% System preparation %%%%%%%%%%%%%%%%%%%%%%

% Clear the workspace
close all;
clearvars; 
sca; 

%================== Here Project-specific adaptations =====================
% Set study identifier
subj.study = 'TUE009';
% Set up whether instructions should be shown (1) or not (0)
show_intructions = 1; 
% Set up instructions language: German (1) or English (0)
validInput = false;
while ~validInput
    i = input('German? (Elsewise english) [y/n] ','s');
    if strcmp(i,'y')
        subj.lang_de = 1;
        validInput = true;
    elseif strcmp(i,'n')
        subj.lang_de = 0;
        validInput = true;
    else
        warning('Not a valid answer! Please try again.');
    end
end
%==========================================================================

% set up paradigm root folder
paradigm_root = pwd;

% fMRI setting
do_fmri_flag = 0; %will include trigger

% Get operating system and set OS flags
system_info = Screen('Computer');
windows = system_info.windows;
mac = system_info.osx;
linux = system_info.linux;

%get input from the MATLAB console
subj.subjectID = input('Subject ID: ','s');
subj.sessionID = input('Session [0]: ','s');
subj.sessionID = num2str(str2double(subj.sessionID)+1);
subj.runID            = '1';
subj.subjectID = pad(subj.subjectID,6,'left','0');
subj.version = 2;
subj.date_start       = datestr(now) ;
subj.date = datestr(now, 'yyyymmdd-HHMM');

subj.id = str2double(subj.subjectID);
subj.sess = str2double(subj.sessionID);
subj.run = str2double(subj.runID);

if do_fmri_flag == 1
    
    dummy_volumes = 2; %will have to be set according to the sequence
    keyTrigger=KbName('s');
    keyTrigger2=KbName('5');
    keyQuit=KbName('q');
    keyResp=KbName('1');
    keyResp2=KbName('1');
    count_trigger = 0;
    
end

% set up folder for backups and final data
backup_folder = 'Backup';
data_folder = 'Data';

if ~exist([pwd, filesep,backup_folder], 'dir')
    mkdir([pwd, filesep,backup_folder])
end
if ~exist([pwd, filesep,data_folder], 'dir')
    mkdir([pwd, filesep,data_folder])
end

% Setup PTB with some default values
PsychDefaultSetup(1); %unifies key names on all operating systems
%PsychDefaultSetup(2); %unifies color specs to floating point numbers [0-1]
Screen('Preference', 'SkipSyncTests', 2);

% Seed the random number generator
setup.rs = RandStream('mt19937ar','Seed','shuffle');
RandStream.setGlobalStream(setup.rs); %new MATLAB way; store if you want to reproduce random numbers

% Basic screen setup 
setup.screenNum = max(Screen('Screens')); %secondary monitor if there is one connected
setup.fullscreen = 1; %will create a small window ideal for debugging
[setup.fullscreenwidth, setup.fullscreenheight]=Screen('WindowSize',setup.screenNum);

% Define colors
color.white = WhiteIndex(setup.screenNum);
color.grey = color.white / 2;
color.black = BlackIndex(setup.screenNum);
color.red = [255 0 0];
color.green = [0 255 0];
color.blue = [0 0 255];

% Define the keyboard keys that are listened for. 
keys.left = KbName('LeftArrow');
keys.right = KbName('RightArrow');
keys.left_num = 1;
keys.right_num = 2;

% Open the screen
if setup.fullscreen ~= 1
    [screen,screen_Rect] = Screen('OpenWindow',setup.screenNum,color.grey,[0 0 800 600]);
    setup.screenwidth = 800;
    setup.screenheight = 600;
else
    [screen,screen_Rect] = Screen('OpenWindow',setup.screenNum,color.black, []);
    setup.screenwidth = setup.fullscreenwidth;
    setup.screenheight = setup.fullscreenheight;
end

% Allow transparent picture presentation using the alpha channel
Screen('BlendFunction', screen, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Get the center coordinates
[setup.xCen, setup.yCen] = RectCenter(screen_Rect);

% Flip to clear
Screen('Flip', screen);

% Query the frame duration
setup.ifi = Screen('GetFlipInterval', screen);

% Query the maximum priority level - optional
setup.topPriorityLevel = MaxPriority(screen);

%%%%%%%%%%%%%%%%%%%%%% Paradigm preparation %%%%%%%%%%%%%%%%%%%%%%

% load supplementary information
load([paradigm_root filesep 'supplementary_material.mat'])

% set up presentation duration for each element
duration_cue = 1;
duration_fix = 0.25;
duration_target = 1;
duration_feedback = 1;

% set up trial number
trial_num = 480;
output.trials = trial_num;

% shuffle chance probabilities vector
response_chance = datasample(supplementary.response_chance,length(supplementary.response_chance),'Replace',false);

% set up trial order
trials = (1:1:8);
trials = repmat(trials',60,1);
trial_order = datasample(trials,length(trials),'Replace',false);

% get response images
money = supplementary.response.money;
food = supplementary.response.food;    
    
% make money fractal textures
for i = 1:4
    fractal_i = supplementary.cues.(['session', subj.sessionID]).money.(['fractal' num2str(i)]);
    texture.fractal(i) = Screen('MakeTexture', screen, fractal_i);
end

% make food fractal textures
for i = 5:8
    fractal_i = supplementary.cues.(['session', subj.sessionID]).food.(['fractal' num2str(i)]);
    texture.fractal(i) = Screen('MakeTexture', screen, fractal_i);
end

% make response textures
texture.money = Screen('MakeTexture', screen, money);
texture.food = Screen('MakeTexture', screen, food);

% get feedback images
win = supplementary.feedback.win;
neutral = supplementary.feedback.neutral;
loose = supplementary.feedback.loose;

% 1 = Go to win
% 2 = Go to avoid punishment
% 3 = No-Go to win
% 4 = No-Go to avoid punishment
idx_cond_money = randperm(4);
idx_cond_food = randperm(4);
idx_cond = [idx_cond_money idx_cond_food];
for i=1:8
       output.cue_conditions.(['fractal' num2str(i)]) = idx_cond(i);
end

% win, nothing, punishment
% probabilities_matrix1_go = [0.8 0.2 0];
% probabilities_matrix1_nogo = [0.2 0.8 0];
% probabilities_matrix2_go = [0 0.8 0.2];
% probabilities_matrix2_nogo = [0 0.2 0.8];
% probabilities_matrix3_go = [0.2 0.8 0];
% probabilities_matrix3_nogo = [0.8 0.2 0];
% probabilities_matrix4_go = [0 0.2 0.8];
% probabilities_matrix4_nogo = [0 0.8 0.2];

output.probabilities_matrix = [0.8 0.2 0;...
                  0.2 0.8 0;...
                  0 0.8 0.2;...
                  0 0.2 0.8;...
                  0.2 0.8 0;...
                  0.8 0.2 0;...
                  0 0.2 0.8;...
                  0 0.8 0.2];
              
% initialize payouts and feedback storage vector
output.feedback_cond.money = [];
output.feedback_cond.food = [];

%%%%%%%%%%%%%%%%%%%%%% INSTRUCTION %%%%%%%%%%%%%%%%%%%%%%
if show_intructions == 0 %skip Intro
    
    % Start task
    if subj.lang_de == 1
        text = ('Starten Sie die Aufgabe mit einem Mausklick.');
    elseif subj.lang_de == 0
        text = ('Start the task by clicking a button on the mouse.');
    end
    Screen('TextSize',screen,36);
    Screen('TextFont',screen,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(screen, text, 'center', (setup.screenheight/5), color.white, 80, [], [], 1.2);
    Screen('Flip',screen);

    GetClicks(setup.screenNum); 
    
    
elseif show_intructions == 1 
    % Instruction screen 1
    if subj.lang_de == 1
    text = ('In der folgenden Aufgabe werden Sie in jedem Durchgang eines von acht verschiedenen Bildern sehen. Abhaengig davon welches Bild gezeigt wird, ist es entweder richtig eine Taste zu druecken oder den Tastendruck auszulassen. Sie erfahren zu Beginn nicht, welche Reaktion bei welchem Bild richtig ist. Das sollen Sie ueber den Verlauf der Aufgabe aus den Rueckmeldungen lernen.\n\n\n\n\n\nWeiter mit Mausklick.');
    elseif subj.lang_de == 0
        text = ('The following task consists of multiple runs. In each run, you are shown an image. In total, there are eight images. You are shown each image multiple times. After you are shown the image you are given the option to react by pressing a key. You can either press the key or not press the key. One of these reactions is correct. Which course of action is correct depends on the image. Your job is to figure out what the correct course of action is for each image.\n\n\n\n\n\nClick the mouse to continue.');
    end
    Screen('TextSize',screen,36);
    Screen('TextFont',screen,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(screen, text, 'center', (setup.screenheight/5), color.white, 80, [], [], 1.2);
    Screen('Flip',screen);

    GetClicks(setup.screenNum); 

    % Instruction screen 2
    if subj.lang_de == 1
    text = ('Nach dem jeweiligen Bild sehen Sie ein Geld- oder Kekssymbol entweder auf der linken oder rechten Seite des Bildschirms. Wenn Sie sich fuer einen Tastendruck entschieden haben, muessen Sie die linke Pfeiltaste druecken, wenn das Symbol auf der linken Seite des Bildschirms erscheint. Sehen Sie es auf der rechten Seite des Bildschirms, muessen Sie die rechte Pfeiltaste druecken. Wenn Sie sich gegen einen Tastendruck entschieden haben, machen Sie in diesem Durchgang nichts. Danach erhalten Sie direkt eine Rueckmeldung.\n\nSie sehen einen gruenen nach oben zeigenden Pfeil, wenn Sie Punkte dazugewonnen haben, einen roten nach unten zeigenden Pfeil, wenn Sie Punkte verloren haben und einen gelben Balken, wenn Sie weder Punkte gewonnen, noch verloren haben.\n\n\n\n\n\nWeiter mit Mausklick.');
    elseif subj.lang_de == 0
        text = ('After the image, a money or cookie symbol will appear on screen. It is either on the left or on the right of the screen. If you have decided to press a key, press the left arrow key if the symbol is on the left side of your screen. If the symbol is on the right side of your screen, press the right arrow key. If you do not want to press a key that is fine. After the symbol has gone your feedback appears on screen.\n\nA green arrow for points gained, a red arrow for points lost, a yellow bar for a neutral result.\n\n\n\n\n\nClick the mouse to continue.');
    end
    Screen('TextSize',screen,36);
    Screen('TextFont',screen,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(screen, text, 'center', (setup.screenheight/5), color.white, 80, [], [], 1.2);
    Screen('Flip',screen);

    GetClicks(setup.screenNum);

    % Instruction screen 3
    if subj.lang_de == 1
    text = ('Es besteht eine Wahrscheinlichkeit, dass Sie trotz korrekter Reaktion keine Belohnung erhalten oder trotz korrekter Reaktion den Verlust von Punkten nicht vermeiden koennen. Diese Wahrscheinlichkeit ist jedoch geringer als die Wahrscheinlichkeit bei korrekter Reaktion die Belohnung zu erhalten, bzw. den Verlust zu vermeiden.\n\n\n\n\n\nWenn Sie alles verstanden haben, beginnt die Aufgabe nach einem Mausklick.');
    elseif subj.lang_de == 0
        text = ('There is a certain probability that despite having chosen the correct course of action, you will not receive any points. It is also possible that despite having acted correctly, you will not be able to avoid losing points. However, if you have chosen the correct course of action, the probability that you will gain points/avoid the loss of points, is higher than the aforementioned probability of being punished for the correct course of action.\n\n\n\n\n\nIf you understand everything, the task starts after clicking the mouse.');
    end
    Screen('TextSize',screen,36);
    Screen('TextFont',screen,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(screen, text, 'center', (setup.screenheight/5), color.white, 80, [], [], 1.2);
    Screen('Flip',screen);

    GetClicks(setup.screenNum);
    
end

WaitSecs(0.5);

% end with fixation cross
fix = '+';
Screen('TextSize',screen,64);
Screen('TextFont',screen,'Arial');
DrawFormattedText(screen, fix, 'center', 'center', color.white);
Screen('Flip',screen);
WaitSecs(duration_fix);


%%%%%%%%%%%%%%%%%%%%%% TRIAL LOOP %%%%%%%%%%%%%%%%%%%%%%

time.paradigm_onset = GetSecs; % get time of beginning of the paradigm
output.time.paradigm_onset = time.paradigm_onset;

for i_tr = 1:trial_num
    
    % Stop loop by holding any key pressed
    [keyIsDown, keysecs, keyCode] = KbCheck;
    if keyIsDown == 1
        Screen('CloseAll');
        break;
    end
    
    % Setup output structure
    output.number_responses(i_tr,1) = 0;
    output.key_pressed(i_tr,1).keys = 0;

    output.time.trial_onset(i_tr,1) = GetSecs - time.paradigm_onset;
    
    %% fractal cue
    cue_num = trial_order(i_tr,1);
    output.cue_presented(i_tr,1) = cue_num;
    output.cond_presented(i_tr,1) = output.cue_conditions.(['fractal' num2str(cue_num)]);
    Screen('DrawTexture', screen, texture.fractal(cue_num), [], [setup.screenwidth/3 setup.screenheight/3 setup.screenwidth/3+setup.screenwidth/3 setup.screenheight/3+setup.screenheight/3]);
    output.time.cue(i_tr,1) = Screen('Flip', screen);
    output.time.cue(i_tr,1) = output.time.cue(i_tr,1) - time.paradigm_onset;
    WaitSecs(duration_cue);        
        
    %% fixation cross
    fix = '+';
    Screen('TextSize',screen,64);
    Screen('TextFont',screen,'Arial');
    DrawFormattedText(screen, fix, 'center', 'center', color.white);
    output.time.fix1(i_tr,1) = Screen('Flip',screen);
    output.time.fix1(i_tr,1) = output.time.fix1(i_tr,1) - time.paradigm_onset;
    WaitSecs(duration_fix);
    

    %% target images -> collect responses
    KbQueueCreate();
    KbQueueFlush(); 
    KbQueueStart();
    
    key_presses = 1;
    
    if cue_num < 5
        target_image = texture.money;
        output.reward_type(i_tr,1) = 1;
    else
        target_image = texture.food;
        output.reward_type(i_tr,1) = 0;
    end
    
    if response_chance(i_tr,1) == 0 % Check if target image appears on the left side...
        
        output.response_side(i_tr,1) = 1;
        
        Screen('DrawTexture', screen, target_image, [], [setup.screenwidth/8 setup.screenheight/5+setup.screenheight/5 (setup.screenwidth/8)+setup.screenheight/5 (setup.screenheight/5)+2*(setup.screenheight/5)]);
        output.time.target_image(i_tr,1) = Screen('Flip',screen);
        output.time.target_image(i_tr,1) = output.time.target_image(i_tr,1) - time.paradigm_onset;
        
        time.onset = GetSecs;
        [b,c] = KbQueueCheck;
        
        while (duration_target > (GetSecs-time.onset))
            
            [b,c] = KbQueueCheck;
            
            if c(keys.left) > 0 
                
                output.time.response(i_tr,key_presses) = GetSecs;
                output.time.RT(i_tr,key_presses) = output.time.response(i_tr,key_presses) - time.onset;
                output.time.response(i_tr,key_presses) = output.time.response(i_tr,key_presses) - time.paradigm_onset;
                output.number_responses(i_tr,1) = output.number_responses(i_tr,1) +1;
                output.key_pressed(i_tr,1).keys(key_presses) = keys.left_num;
                key_presses = key_presses + 1;
                
            elseif c(keys.right) > 0 
                
                output.time.response(i_tr,key_presses) = GetSecs;
                output.time.RT(i_tr,key_presses) = output.time.response(i_tr,key_presses) - time.onset;
                output.time.response(i_tr,key_presses) = output.time.response(i_tr,key_presses) - time.paradigm_onset;
                output.number_responses(i_tr,1) = output.number_responses(i_tr,1) +1;
                output.key_pressed(i_tr,1).keys(key_presses) = keys.right_num;
                key_presses = key_presses + 1;
                
            end
                            
        end
        
    else % ...or on the right side of the screen

        output.response_side(i_tr,1) = 2;
        
        Screen('DrawTexture', screen, target_image, [], [setup.screenwidth-((setup.screenwidth/8)+setup.screenheight/5), setup.screenheight/5+setup.screenheight/5, setup.screenwidth-(setup.screenwidth/8), (setup.screenheight/5)+2*(setup.screenheight/5)]);
        output.time.target_image(i_tr,1) = Screen('Flip',screen);
        output.time.target_image(i_tr,1) = output.time.target_image(i_tr,1) - time.paradigm_onset;
        
        time.onset = GetSecs;
        [b,c] = KbQueueCheck;
        
        while (duration_target > (GetSecs-time.onset))
            
            [b,c] = KbQueueCheck;
            
            if c(keys.left) > 0 
                
                output.time.response(i_tr,key_presses) = GetSecs;
                output.time.RT(i_tr,key_presses) = output.time.response(i_tr,key_presses) - time.onset;
                output.time.response(i_tr,key_presses) = output.time.response(i_tr,key_presses) - time.paradigm_onset;
                output.number_responses(i_tr,1) = output.number_responses(i_tr,1) +1;
                output.key_pressed(i_tr,1).keys(key_presses) = keys.left_num;
                key_presses = key_presses + 1;
                
            elseif c(keys.right) > 0 
                
                output.time.response(i_tr,key_presses) = GetSecs;
                output.time.RT(i_tr,key_presses) = output.time.response(i_tr,key_presses) - time.onset;
                output.time.response(i_tr,key_presses) = output.time.response(i_tr,key_presses) - time.paradigm_onset;
                output.number_responses(i_tr,1) = output.number_responses(i_tr,1) +1;
                output.key_pressed(i_tr,1).keys(key_presses) = keys.right_num;
                key_presses = key_presses + 1;
                
            end
                            
        end

    end
    
    KbQueueRelease();
    
      
    %% fixation cross
    Screen('TextSize',screen,64);
    Screen('TextFont',screen,'Arial');
    DrawFormattedText(screen, fix, 'center', 'center', color.white);
    output.time.fix2(i_tr,1)= Screen('Flip',screen);
    output.time.fix2(i_tr,1) = output.time.fix2(i_tr,1) - time.paradigm_onset;
    WaitSecs(duration_fix);
    
    
    %% check condition and response for feedback
    condition_num = output.cond_presented(i_tr,1);
    
    switch condition_num
        
        case 1 % Go to win
            
            if (output.response_side(i_tr,1) == 1 && output.key_pressed(i_tr,1).keys(end) == 1) || (output.response_side(i_tr,1) == 2 && output.key_pressed(i_tr,1).keys(end) == 2)
                
                probabilities= output.probabilities_matrix(1,:);
                output.correct_answer(i_tr,1) = 1;
                output.probabilities(i_tr,1) = 1;
                
            else
                
                probabilities= output.probabilities_matrix(2,:);
                output.correct_answer(i_tr,1) = 0;
                output.probabilities(i_tr,1) = 2;
                
            end

            
        case 2 % Go to avoid punishment
            
            if (output.response_side(i_tr,1) == 1 && output.key_pressed(i_tr,1).keys(end) == 1) || (output.response_side(i_tr,1) == 2 && output.key_pressed(i_tr,1).keys(end) == 2)
                
                probabilities= output.probabilities_matrix(3,:);
                output.correct_answer(i_tr,1) = 1;
                output.probabilities(i_tr,1) = 3;
                
            else
                
                probabilities= output.probabilities_matrix(4,:);
                output.correct_answer(i_tr,1) = 0;
                output.probabilities(i_tr,1) = 4;
                
            end
            
        case 3 % No-Go to win
            
            if output.key_pressed(i_tr,1).keys(end) == 0
                
                probabilities= output.probabilities_matrix(6,:);
                output.correct_answer(i_tr,1) = 1;
                output.probabilities(i_tr,1) = 6;
                
            else
                
                probabilities= output.probabilities_matrix(5,:);
                output.correct_answer(i_tr,1) = 0;
                output.probabilities(i_tr,1) = 5;
                
            end
            
        case 4 % No-Go to avoid punishment
            
            if output.key_pressed(i_tr,1).keys(end) == 0
                
                probabilities= output.probabilities_matrix(8,:);
                output.correct_answer(i_tr,1) = 1;
                output.probabilities(i_tr,1) = 8;
                
            else
                
                probabilities= output.probabilities_matrix(7,:);
                output.correct_answer(i_tr,1) = 0;
                output.probabilities(i_tr,1) = 7;
                
            end
        
    end
    
    
    %% determine feedback
    idx_zero = find(probabilities==0); % find feedback condition that doesn't apply here
    
    switch idx_zero
        
        case 1 % no win possible
            
            if probabilities(2) > probabilities(3)
                
                if rand < probabilities(2)
                    
                    feedback_cond = 2;
                    if cue_num < 5
                        output.feedback_cond.money = [output.feedback_cond.money; 2];
                    else
                        output.feedback_cond.food = [output.feedback_cond.food; 2];
                    end                   
                    
                else
                    
                    feedback_cond = 3;
                    if cue_num < 5
                        output.feedback_cond.money = [output.feedback_cond.money; 3];
                    else
                        output.feedback_cond.food = [output.feedback_cond.food; 3];
                    end   
                    
                end
                
            else
                
                if rand < probabilities(3)
                    
                    feedback_cond = 3;
                    if cue_num < 5
                        output.feedback_cond.money = [output.feedback_cond.money; 3];
                    else
                        output.feedback_cond.food = [output.feedback_cond.food; 3];
                    end   
                    
                else
                    
                    feedback_cond = 2;
                    if cue_num < 5
                        output.feedback_cond.money = [output.feedback_cond.money; 2];
                    else
                        output.feedback_cond.food = [output.feedback_cond.food; 2];
                    end   
                    
                end
                
            end
            
        case 3 % no punishment possible
            
            if probabilities(1) > probabilities(2)
                
                if rand < probabilities(1)
                    
                    feedback_cond = 1;
                    if cue_num < 5
                        output.feedback_cond.money = [output.feedback_cond.money; 1];
                    else
                        output.feedback_cond.food = [output.feedback_cond.food; 1];
                    end   
                    
                else
                    
                    feedback_cond = 2;
                    if cue_num < 5
                        output.feedback_cond.money = [output.feedback_cond.money; 2];
                    else
                        output.feedback_cond.food = [output.feedback_cond.food; 2];
                    end   
                    
                end
                
            else
                
                if rand < probabilities(2)
                    
                    feedback_cond = 2;
                    if cue_num < 5
                        output.feedback_cond.money = [output.feedback_cond.money; 2];
                    else
                        output.feedback_cond.food = [output.feedback_cond.food; 2];
                    end   
                    
                else
                    
                    feedback_cond = 1;
                    if cue_num < 5
                        output.feedback_cond.money = [output.feedback_cond.money; 1];
                    else
                        output.feedback_cond.food = [output.feedback_cond.food; 1];
                    end   
                    
                end
                
            end
            
    end
   
    % Storing feedback regardless of reward type  
    output.feedback_cond.all(i_tr,1) = feedback_cond;
    
    %% feedback
    if feedback_cond == 1
        
        feedback = Screen('MakeTexture', screen, win);
        Screen('DrawTexture', screen, feedback, [], [setup.screenwidth/5+setup.screenwidth/5 setup.screenheight/3 setup.screenwidth-(2*(setup.screenwidth/5)) setup.screenheight-setup.screenheight/3]);
        if cue_num < 5
            text = ('+ 5 cent');
        else
            text = ('+ 5 kcal');
        end
        Screen('TextSize',screen,36);
        Screen('TextFont',screen,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(screen, text, 'center', (setup.screenheight/5), color.white, 80, [], [], 1.2);       
        output.time.feedback(i_tr,1) = Screen('Flip', screen);
        output.time.feedback(i_tr,1) = output.time.feedback(i_tr,1) - time.paradigm_onset;
        WaitSecs(duration_feedback);
        
    elseif feedback_cond == 2
        
        feedback = Screen('MakeTexture', screen, neutral);
        Screen('DrawTexture', screen, feedback, [], [setup.screenwidth/5+setup.screenwidth/5 setup.screenheight/9+(3*(setup.screenheight/9)) setup.screenwidth-(2*(setup.screenwidth/5)) setup.screenheight-(4*(setup.screenheight/9))]);
        output.time.feedback(i_tr,1) = Screen('Flip', screen);
        output.time.feedback(i_tr,1) = output.time.feedback(i_tr,1) - time.paradigm_onset;
        WaitSecs(duration_feedback);
        
    elseif feedback_cond == 3
        
        feedback = Screen('MakeTexture', screen, loose);
        Screen('DrawTexture', screen, feedback, [], [setup.screenwidth/5+setup.screenwidth/5 setup.screenheight/3 setup.screenwidth-(2*(setup.screenwidth/5)) setup.screenheight-setup.screenheight/3]);
        if cue_num < 5
            text = ('- 5 cent');
        else
            text = ('- 5 kcal');
        end
        Screen('TextSize',screen,36);
        Screen('TextFont',screen,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(screen, text, 'center', (setup.screenheight/5), color.white, 80, [], [], 1.2);       
        output.time.feedback(i_tr,1) = Screen('Flip', screen);
        output.time.feedback(i_tr,1) = output.time.feedback(i_tr,1) - time.paradigm_onset;
        WaitSecs(duration_feedback);
        
    end
    
    clear probabilities feedback_cond condition_num
    
    %% get accuracy over the trials
    output.accuracies.overall = sum(output.correct_answer(:,1)) / i_tr;
    
    if sum(output.cond_presented == 1) ~= 0
        output.accuracies.go_to_win = sum(output.correct_answer(output.cond_presented == 1,1)) / sum(output.cond_presented == 1);
    end
    
    if sum(output.cond_presented == 2) ~= 0
        output.accuracies.go_to_avoid_punishment = sum(output.correct_answer(output.cond_presented == 2,1)) / sum(output.cond_presented == 2);
    end
    
    if sum(output.cond_presented == 3) ~= 0
        output.accuracies.no_go_to_win = sum(output.correct_answer(output.cond_presented == 3,1)) / sum(output.cond_presented == 3);
    end
    
    if sum(output.cond_presented == 4) ~= 0
        output.accuracies.no_go_to_avoid_punishment = sum(output.correct_answer(output.cond_presented == 4,1)) / sum(output.cond_presented == 4);
    end
    
    
    %% save temporary data at the end of each trial
    filename = ['GMT_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_R', subj.runID, '_temp_', subj.date ];
    if do_fmri_flag == 0
        save(fullfile(paradigm_root, backup_folder, [filename '.mat']),'output','subj');
    else
        save(fullfile(paradigm_root, backup_folder, [filename '.mat']),'output','subj','onsets');
    end
    
end

%% reward
payout = sum(2 - output.feedback_cond.money) * 0.05;
cookies = sum(2 - output.feedback_cond.food)*5;

%% Feedback screen
text = sprintf('Die Aufgabe ist beendet. Insgesamt haben Sie %.2f Euro und %.1f Snacks gewonnen.',payout,round(cookies/100,1));
Screen('TextSize',screen,36);
Screen('TextFont',screen,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(screen, text, 'center', (setup.screenheight/5), color.white, 80, [], [], 1.2);
Screen('Flip',screen);
WaitSecs(10);

%% close Psychtoolbox window
sca;

%Save time end of experiment
subj.date_end = datestr(now);
t_start=datevec(datenum(subj.date_start));
t_end=datevec(datenum(subj.date_end ));
subj.length_exp = etime(t_end, t_start)/60; %length exp in min

%% save output
filename = ['GMT_', subj.study, '_', subj.subjectID, '_S', subj.sessionID];
if do_fmri_flag == 0
    save(fullfile(paradigm_root, data_folder, [filename '.mat']),'output','subj');
else
    save(fullfile(paradigm_root, data_folder, [filename '.mat']),'output','subj','onsets');
end
save(fullfile(paradigm_root, backup_folder, [filename datestr(now,'_yymmdd_HHMM') '.mat']));


%% calculate probabilities_matrix 

fprintf('Payout:\nMoney: %.2f Euro \nFood: %.1f Snacks (%d calories)\n',payout,round(cookies/100,1), calories);