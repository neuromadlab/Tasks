%%===================PTB collection===================
%Machine Slot Task - Sara Parnell, Sophie M??ller
%contact: sara.parnell@student.uni-tuebingen.de or
%sophie1.mueller@student.uni-tuebingen.de
%========================================================
%
% 
% Instructions:
% Simply run the entire file.
% Make sure cilps and Conditions files are in same directory as this m-file.
%
%% STAND : 12.01.24

%% Preparation
% Clear the workspace
close all; 
sca;
clear all

%%
settings.debug = 0; %debug == 0 when in scanner (waits for triggers)

%get input from the MATLAB console
subj.version='BON002_v1.0';
subj.studyID='BON002';
if settings.debug == 1
    subj.subjectID='900007';
    subj.sessionID='1';
    subj.runID='1';
    subj.lang_de = 0;
else
    subj.subjectID=input('Subject ID (6 digits): ','s');
    subj.sessionID=input('Session ID [2/3]: ','s');
    subj.lang_de = input('German (1) or English (0): ');
    subj.sessionID = num2str(str2double(subj.sessionID) - 1);
    subj.runID='1';
end
%subj.sess = str2double(subj.sessionID); %sometimes it is better to work with integers
%subj.num = str2double(subj.subjectID);




%% Load settings
disp('Loading settings...')
load('BON002_setup')

%setup.flip_interval = test_for_flipinterval (3, []);
setup.flip_interval = 0.0167; %value for scanner
%setup.flip_interval = 0.0185;
% name_settings_file = strcat('FCRsettings_', subj.studyID, '_S', subj.sessionID, '_R', subj.runID);
% %load(name_file);
% load ('SMsettings.mat');
SMsettings.settings.do_fullscreen = 1;
SMsettings.settings.lang_de = subj.lang_de;

%set_up trials and blocks: BON002 4 blocks with 48 trials each %Todo: consider to match comment and real values!
if settings.debug == 1    
    setup.nblocks = 1;
    setup.ntrials = 4;
    
else
    setup.nblocks = 2;
    setup.ntrials = 48;    
end
task_start = GetSecs;

if mod(setup.nblocks,2) ~=0
    warning('Uneven number of blocks, one additional block will be added to the task.')
    setup.nblocks = setup.nblocks +1;
end

% Setup PTB with some default values
PsychDefaultSetup(1); %unifies key names on all operating systems
%PsychDefaultSetup(2); %unifies color specs to floating point numbers [0-1]

% Automatic operating information
Screen('Preference', 'SkipSyncTests', 1);

% Seed the random number generator.
rand('seed', sum(100 * clock)); %old MATLAB way
%setup.rs = RandStream('mt19937ar','Seed','shuffle');
%RandStream.setGlobalStream(setup.rs); %new MATLAB way; store if you want
%to reproduce random numbers

% Basic screen setup
setup.screenNum = max(Screen('Screens')); %secondary monitor if there is one connected
%setup.fullscreen = 2; % 0 - debugging window, 1- fullscreen, 2 - medium size
%Screen('Preference', 'SkipSyncTests', 1)

if SMsettings.settings.do_fmri == 1
    setup.flip_flag_horizontal = 1;
    setup.flip_flag_vertical = 0;
else
     setup.flip_flag_horizontal = 0;
     setup.flip_flag_vertical = 0;
 end

% Define colors
color.white = WhiteIndex(setup.screenNum); %color.white = [255 255 255]; define a color in the common RGB scheme
color.grey = color.white / 2;
color.black = BlackIndex(setup.screenNum);
color.red = [255 0 0];
color.green = [0 255 0];
color.blue = [0 0 255];

if SMsettings.settings.do_fmri == 1
    % load jitters
   %load('jitters.mat');
   option_duration = 2.45 + jitter_isi(:,1:setup.ntrials); % jitter 2.5+(1.25 max 6) for after choice the logged answer is shown until the spin vid (-0.15 for loading)
   spin_duration = 1.0; % + jitter_isi(:,1:setup.ntrials); % jitter 1.25+(0.5 max 4)
   iti_duration = 1.05 + jitter_iti(:,1:setup.ntrials); % jitter 1+(3 max 12) (+0.15 to compensate for loading missing isi)
   feedback_duration = 1.85;
   %code for generating jitters
    %    for nblock = 1:4
    %         jitter_iti(nblock,:) = ComputeJitter_exp(3, 12, 48);
    %         jitter_isi (nblock,:)= ComputeJitter_exp(0.5, 4, 48);
    %    end
    %    save('jitters.mat', 'jitter_iti', 'jitter_isi');
   
  
else
    Beh_timings.interval = 1; %length of spin video
    Beh_timings.iti = 1;
    Beh_timings.option_duration = 1.5;
    Beh_timings.feedback = 1.85;
    Beh_timings.interblockinterval = 8;
end




%output.rgw_prob = setup.rgw.allprob;
run_nr = str2double(subj.sessionID);%-1;

output.rgw_prob = setup.rgw.allprob(run_nr,:);

%setup.prob = prob;
%genereate rewards for each trial
if strcmp(subj.studyID,'BON002')
    %     load('rewardBON002.mat')
else
    for i = 1:setup.nblocks
        reward.left{i} = round(normrnd(50,16,[setup.ntrials,1])); % random numbers with mean 50 and st 16
        reward.right{i} = 100-reward.left{i};
        reward.grid{i}(:,:) = [reward.left{i},reward.right{i}];
    end
end
output.reward = reward.grid;

%flip coins Maybe use the same always
if setup.ntrials == 48 && setup.nblocks ==2
    for i_block = 1:setup.nblocks
        
        setup.rgw.coin(:,i_block) =  setup.rgw.coin(randperm(setup.ntrials),i_block);
        
    end
else
    setup.rgw.coin = rand(setup.ntrials,setup.nblocks);
end
%create arrays representing the codings for the options left & right
setup.mouse_response = [1,3];
if settings.debug == 1
    setup.key_response = {KbName('1'), KbName('3')};
else
    setup.key_response = {[51],[49]};
end

setup.option_codes = [0,1];% blue and red
setup.option_colours = {color.blue,color.red};
setup.option_names = {'blue', 'red'};

% Key settings for MRI (only)
keyTrigger=KbName('5%');
keyTrigger2=KbName('5');
keyQuit=KbName('q');

% MRI relevant variables
if SMsettings.settings.do_fmri
    dummy_volumes = 0; % will have to be set according to the sequence
    MR_timings.dummy_volumes = dummy_volumes;
    count_trigger = 0;
    MR_timings.max_decision_interval = 2.5;
else
    Beh_timings.max_decision_interval = 30;
end

% Page Setup
if SMsettings.settings.do_fmri
    setup.stim = load('stim_flipped.mat');
%     block_money = imread('clips\money_flipped.jpg'); %-> as mat
%     block_food = imread('clips\food_flipped.jpg'); % -> as mat
%     filename_spin_vid = '%s_%d_%d_cropped_flipped.mp4'
%     start_frame = imread('clips\start_frame_new_flipped.jpg'); %-> as .mat
else
    setup.stim = load('stim.mat');
%     block_money = imread('clips\money.jpg'); %-> as mat
%     block_food = imread('clips\food.jpg'); % -> as mat
%     filename_spin_vid = '%s_%d_%d_cropped.mp4'
%     start_frame = imread('clips\start_frame_new.jpg'); %-> as .mat
end

setup.stim.dir = 'clips\';    
%preload videos
for i_win = 1:2
    for i_rand = 1:3
        trial_name_f = [setup.stim.dir sprintf(setup.stim.filename_spin_vid, 'food', i_win-1, i_rand)];
        spin_vids(i_win,i_rand).food = VideoReader(trial_name_f);
        trial_name_m = [setup.stim.dir sprintf(setup.stim.filename_spin_vid, 'money', i_win-1, i_rand)];
        spin_vids(i_win,i_rand).money = VideoReader(trial_name_f);
    end
end

%save(block_money,block_food,filename_spin_vid, start_frame )
i = 1 ;
j = 1;

[height, width, ~] = size(setup.stim.start_frame);
first_block = 1;
%end

try
    %HideCursor;
    %% Open the screen
    if SMsettings.settings.do_fullscreen == 0
        [w,wRect] = Screen('OpenWindow',setup.screenNum,color.white,[0 0 400 300]);
    elseif SMsettings.settings.do_fullscreen == 2
        [w,wRect] = Screen('OpenWindow',setup.screenNum,color.white,[0 0 1200 800]); %[0 0 1920 1080] fullscreen
    elseif SMsettings.settings.do_fullscreen == 1
        [w,wRect] = Screen('OpenWindow',setup.screenNum,color.white, []);
    end

    % Screen settings
        % rectangles for options
    r = [0 0 width height];
    r = ScaleRect(r,(wRect(3)/3)/width, (wRect(3)/3)/width);
    r = CenterRect(r, wRect);
    if SMsettings.settings.do_fmri
        setup.r_options{2} = OffsetRect(r, -wRect(3)/4, +wRect(4)/6); % r1 = OffsetRect(r, (-wr/2*1.5), 0);
        setup.r_options{1} = OffsetRect(r, +wRect(3)/4, +wRect(4)/6); %  r2 = OffsetRect(r, (+wr/2*1.5), 0);
    else
        setup.r_options{1} = OffsetRect(r, -wRect(3)/4, +wRect(4)/6); % r1 = OffsetRect(r, (-wr/2*1.5), 0);
        setup.r_options{2} = OffsetRect(r, +wRect(3)/4, +wRect(4)/6); %  r2 = OffsetRect(r, (+wr/2*1.5), 0);
    end
    clear r % get rid of r

        % rectangle for score bar
    setup.full_rect = [0 0 wRect(3)/2 round(wRect(4)/35)];
    setup.full_rect = AlignRect(setup.full_rect, wRect, 'center', 'top');
    setup.full_rect = OffsetRect(setup.full_rect, 0, (wRect(4)*0.1));
    clear score_bar_size
    setup.maxscore = setup.ntrials*30*2;
    setup.border_size = RectWidth(setup.r_options{1})/50;
    setup.fix = '+';
    num_spin_options = 3; % array with options for vid


    % generate random block sequence %setup.nblocks
    if SMsettings.settings.do_food == 1
        blocks = [0 1]; % 0-food, 1-money
        output.moneyblock = [];
        for nblock = 1:(setup.nblocks/2)
            output.moneyblock = [output.moneyblock, blocks(randperm(length(blocks)))];
        end
    else
        output.moneyblock = ones(1,setup.nblocks);

    end
    clear blocks;

    output.moneyscore = [];
    output.foodscore = [];
    output.allfoodscore = 0;
    output.allmoneyscore = 0;

    durations = NaN(setup.nblocks,1);

    disp('All settings loaded.')

%% Instructions
% Get the center coordinates and flip interval
[setup.xCen, setup.yCen] = RectCenter(wRect);
Screen('Flip', w);
setup.ifi = Screen('GetFlipInterval', w);

% display instructions & click to continue
if SMsettings.settings.lang_de == 1 && SMsettings.settings.do_fmri
    setup.intro_txt = 'Willkommen zur Spielautomaten-Aufgabe.\n\nDruecken Sie einen beliebingen Knopf, um fortzufahren.';
    if SMsettings.settings.do_food == 1
        setup.long_instr_txt = ['In dieser Aufgabe koennen Sie Essen und Geld gewinnen.\nDafuer spielen Sie mehrere Durchgaenge (' num2str(setup.nblocks) ' Bloecke mit je ' num2str(setup.ntrials) ' Versuchen). \n\nIn jedem Versuch fuehrt jeweils einer der beiden Spielautomaten zum Gewinn, der andere zum Verlust. \nSie waehlen jeweils einen der Automaten aus und gewinnen oder verlieren entsprechend Punkte.\n\n Druecken Sie einen beliebigen Knopf, um fortzufahren.'];
        setup.instr_cat_txt = 'Dieses Symbol zeigt Ihnen an, ob Sie gerade um Essen oder Geld spielen.\n\n Druecken Sie einen beliebigen Knopf, um fortzufahren.';
    else
        setup.long_instr_txt = ['In dieser Aufgabe koennen Sie Geld gewinnen.\nDafuer spielen Sie mehrere Durchgaenge (' num2str(setup.nblocks) ' Bloecke mit je ' num2str(setup.ntrials) ' Versuchen). \n\nIn jedem Versuch fuehrt jeweils einer der beiden Spielautomaten zum Gewinn, der andere zum Verlust. \nSie waehlen jeweils einen der Automaten aus und gewinnen oder verlieren entsprechend Punkte.\n\n Druecken Sie einen beliebigen Knopf, um fortzufahren.'];
        setup.instr_cat_txt = 'Dieses Symbol zeigt Ihnen an, dass sie gerade um Geld spielen.\n\n Druecken Sie einen beliebigen Knopf, um fortzufahren.';
    end
    setup.instr_reward = 'Diese Zahlen zeigen an, wie viele Punkte Sie bei welchem Automaten gewinnen bzw. verlieren.\n\nDruecken Sie einen beliebigen Knopf, um fortzufahren.';
    setup.instr_corr_txt = 'Die Farbe des Rings zeigt an, welcher Automat im letzten Durchgang die richtige Wahl war.\n\nDruecken Sie einen beliebigen Knopf, um fortzufahren.';
    setup.instr_score_txt = 'Ihren aktuellen Punktestand koennen Sie auf dieser Leiste ablesen.\n\nDruecken Sie einen beliebigen Knopf, um fortzufahren.';
    setup.instr_mach_txt = 'Druecken Sie den linken Knopf, um den linke Spielautomaten zu waehlen (blau). \n\nDruecken Sie den rechten Knopf, um den rechten Spielautomaten zu waehlen (rot).\n\nDruecken Sie einen beliebigen Knopf, um fortzufahren.';
    setup.instr_decision_txt = 'Nachdem sie den Spielautomaten ausgewaehlt haben, erscheint um den entsprechenden Automaten ein grünes Rechteck.\n Sie koennen Ihre Wahl nun nicht mehr aendern.\n\nDruecken Sie einen beliebigen Knopf, um fortzufahren.';
    setup.instr_fast = ['Bitte antworten Sie zuegig, ohne zu lange nachzudenken.\nSie haben etwa ' num2str(MR_timings.max_decision_interval) ' Sekunden Zeit zum Antworten.'];
    setup.instr_start_txt = 'Falls Sie noch Fragen haben, koennen Sie diese jetzt stellen. \n\nDruecken Sie dann einen beliebigen Knopf, wenn Sie bereit sind, die Messung zu beginnen.';
    setup.instr_repeat_txt = 'Wie bei der letzten Runde koennen Sie mit dem linken Knopf den linken Automaten waehlen (blau). \nMit dem rechten Knopf waehlen Sie den rechten Automaten aus (rot).\n\nFalls Sie noch Fragen haben, koennen Sie diese jetzt stellen. \n\n Druecken Sie dann einen beliebigen Knopf, wenn Sie bereit sind, die Messung zu beginnen.';
elseif SMsettings.settings.lang_de == 1 && ~SMsettings.settings.do_fmri
    setup.intro_txt = 'Willkommen zum Spielautomaten-Spiel.\n\n Klicken Sie, um fortzufahren.';
    if SMsettings.settings.do_food == 1
        setup.long_instr_txt = ['In dieser Aufgabe koennen Sie Essen und Geld gewinnen.\nDafuer spielen Sie mehrere Durchgaenge (' num2str(setup.nblocks) ' Bloecke mit je ' num2str(setup.ntrials) ' Versuchen). \n\nIn jedem Versuch fuehrt jeweils einer der beiden Spielautomaten zum Gewinn, der andere zum Verlust. \nSie waehlen jeweils einen der Automaten aus und gewinnen oder verlieren entsprechend Punkte.\n\n Klicken Sie, um fortzufahren.'];
        setup.instr_cat_txt = 'Dieses Symbol zeigt Ihnen an, ob Sie gerade um Essen oder Geld spielen.\n\nKlicken Sie, um fortzufahren.';
        else
        setup.long_instr_txt = ['In dieser Aufgabe koennen Sie Geld gewinnen.\nDafuer spielen Sie mehrere Durchgaenge (' num2str(setup.nblocks) ' Bloecke mit je ' num2str(setup.ntrials) ' Versuchen). \n\nIn jedem Versuch fuehrt jeweils einer der beiden Spielautomaten zum Gewinn, der andere zum Verlust. \nSie waehlen jeweils einen der Automaten aus und gewinnen oder verlieren entsprechend Punkte.\n\n Klicken Sie, um fortzufahren.'];
        setup.instr_cat_txt = 'Dieses Symbol zeigt Ihnen an, dass sie gerade um Geld spielen.\n\nKlicken Sie, um fortzufahren.';
    end

    setup.instr_reward = 'Diese Zahlen zeigen an, wie viele Punkte Sie bei welchem Automaten gewinnen bzw. verlieren.\n\nKlicken Sie, um fortzufahren.';
    setup.instr_corr_txt = 'Die Farbe des Rings zeigt an, welcher Automat im letzten Durchgang die richtige Wahl war.\n\nKlicken Sie, um fortzufahren.';
    setup.instr_score_txt = 'Ihren aktuellen Punktestand koennen Sie auf dieser Leiste ablesen.\n\nKlicken Sie, um fortzufahren.';
    setup.instr_mach_txt = 'Klicken Sie die linke Taste, um den linke Spielautomaten zu waehlen (blau). \n\nKLicken Sie die rechte Taste, um den rechten Spielautomaten zu waehlen (rot).\n\nKlicken Sie, um fortzufahren.';
    setup.instr_decision_txt = 'Nachdem sie den Spielautomaten ausgewaehlt haben, erscheint um den entsprechenden Automaten ein grünes Rechteck.\n Sie koennen Ihre Wahl nun nicht mehr aendern.\n\nKlicken Sie, um fortzufahren.';
    setup.instr_fast = ['Bitte antworten Sie zuegig, ohne zu lange nachzudenken.\nSie haben etwa ' num2str(Beh_timings.max_decision_interval) ' Sekunden Zeit zum Antworten.'];
    setup.instr_start_txt = 'Falls Sie noch Fragen haben, koennen Sie diese jetzt stellen. \n\nKlicken Sie, wenn Sie bereit sind, die Messung zu beginnen.';
    setup.instr_repeat_txt = 'Wie bei der letzten Runde koennen Sie mit der linken Taste den linken Automaten waehlen (blau). \nMit der rechten Taste waehlen Sie den rechten Automaten aus (rot).\n\nFalls Sie noch Fragen haben, koennen Sie diese jetzt stellen. \n\nKlicken Sie, wenn Sie bereit sind, die Messung zu beginnen.';
elseif SMsettings.settings.lang_de ~= 1 && SMsettings.settings.do_fmri
    setup.intro_txt = 'Welcome to the slot-machine task.\n\nPress any button to continue.';
    if SMsettings.settings.do_food == 1
        setup.long_instr_txt = ['You can win food and money in this task.\nFor that, you will play several runs (' num2str(setup.nblocks) ' blocks ' num2str(setup.ntrials) ' trials each). \n\nIn each trial, one of the machines will lead to a win, the other one to a loss. \nYou choose one of the machines and will respectively receive or lose points.\n\nPress any button to continue.'];
        setup.instr_cat_txt = 'This symbol shows whether you are currently playing for food or money.\n\nPress any button to continue.';
    else
        setup.long_instr_txt = ['You can win money in this task.\nFor that, you will play several runs (' num2str(setup.nblocks) ' blocks ' num2str(setup.ntrials) ' trials each). \n\nIn each trial, one of the machines will lead to a win, the other one to a loss. \nYou choose one of the machines and will respectively receive or lose points.\n\nPress any button to continue.'];
        setup.instr_cat_txt = 'This symbol shows that you are currently playing for money.\n\nPress any button to continue.';
    
    end

    setup.instr_reward = 'These numbers show the amount of points that you can win/loose at each machine.\n\nPress any button to continue.';
    setup.instr_corr_txt = 'The color of this ring indicates the right choice (= machine that led to a win) during the previous trial\n\nPress any button to continue.';
    setup.instr_score_txt = 'You can see your current score depicted on this bar.\n\nPress any button to continue.';
    setup.instr_fast = ['Please respond fast without overthinking.\nYou have about ' num2str(MR_timings.max_decision_interval) ' seconds to choose a machine.'];    
    setup.instr_start_txt = 'If you have any open questions, please ask them now. \n\nAfter that, please press any button when you are ready to start the measurement.';
    setup.instr_repeat_txt = 'As before, you can press the left button to choose the left slot machine (blue). \nPressing the right button will select the right slot machine (red).\n\nIf you have any open questions, please ask them now. \n\nAfter that, please press any button when you are ready to start the measurement.';
    setup.instr_decision_txt = 'After choosing one of the slot machines, a green rectangle appears around the chosen machine.\n You can not change the slot machine anymore now.\n\nPress any button to continue.';
    setup.instr_mach_txt = 'Press the left button to choose the left slot machine (blue). \n\n Press the right button choose the right slot machine (red). \n\n Press any button to continue.';
elseif SMsettings.settings.lang_de ~= 1 && ~SMsettings.settings.do_fmri
    setup.intro_txt = ['Welcome to the SLOT MACHINE task.\n\n Click to continue.'];
     if SMsettings.settings.do_food == 1
        setup.long_instr_txt = ['You can win food and money in this task.\nFor that, you will play several runs (' num2str(setup.nblocks) ' blocks ' num2str(setup.ntrials) ' trials each). \n\nIn each trial, one of the machines will lead to a win, the other one to a loss. \nYou choose one of the machines and will respectively receive or lose points.\n\nClick to continue.'];
        setup.instr_cat_txt = 'This symbol shows whether you are currently playing for food or money.\n\nClick to continue.';
    else
        setup.long_instr_txt = ['You can win money in this task.\nFor that, you will play several runs (' num2str(setup.nblocks) ' blocks ' num2str(setup.ntrials) ' trials each). \n\nIn each trial, one of the machines will lead to a win, the other one to a loss. \nYou choose one of the machines and will respectively receive or lose points.\n\nClick to continue.'];
        setup.instr_cat_txt = 'This symbol shows that you are currently playing for money.\n\nClick to continue.';
    
    end
	setup.instr_reward = 'These numbers show the amount of points that you can win/loose at each machine.\n\nClick to continue.';
    setup.instr_corr_txt = 'The color of this ring indicates the right choice (= machine that led to a win) during the previous trial\n\nClick to continue.';
    setup.instr_score_txt = 'You can see your current score depicted on this bar.\n\nClick to continue.';
    setup.instr_fast = ['Please respond fast without overthinking.\nYou have about ' num2str(Beh_timings.max_decision_interval) ' seconds to choose a machine.'];        
    setup.instr_start_txt = 'If you have any open questions, please ask them now. \n\nAfter that, please press any button when you are ready to start the measurement.';
    setup.instr_repeat_txt = 'As before, you can click the left button to choose the left slot machine (blue). \nClicking the right button will select the right slot machine (red).\n\nIf you have any open questions, please ask them now. \n\nAfter that, please click when you are ready to start the measurement.';
    setup.instr_decision_txt = 'After choosing one of the slot machines, a green rectangle appears around the chosen machine.\n You can not change the slot machine anymore now.\n\nClick to continue.';
    setup.instr_mach_txt = 'Click the left button to choose the left slot machine (blue). \n\n Click the right button choose the right slot machine (red). \n\n Click to continue.';
end

%Welcome screen
Screen('TextSize',w, round(wRect(4)/30)); Screen('TextFont',w,'Arial');
DrawFormattedText(w, setup.intro_txt, 'center', 'center', color.black, 60, setup.flip_flag_horizontal, setup.flip_flag_vertical,1.2);
Screen('Flip',w);
WaitSecs(1);
if SMsettings.settings.do_fmri
    while true
        [pressed,~,key] = KbCheck();
        if key(setup.key_response{1}) || key(setup.key_response{2})
            break
        end
    end
else
    GetClicks(setup.screenNum);
end

if str2num(subj.runID) == 1 
    %Main instructions
    Screen('TextSize',w, round(wRect(4)/30)); Screen('TextFont',w,'Arial');
    DrawFormattedText(w, setup.long_instr_txt, 'center', 'center', color.black, 60, setup.flip_flag_horizontal, setup.flip_flag_vertical,1.2);
    Screen('Flip',w);
    WaitSecs(1);
    if SMsettings.settings.do_fmri
        while true
            [pressed,~,key] = KbCheck();
            if key(setup.key_response{1}) || key(setup.key_response{2})
                break
            end
        end
        %KbWait();
    else
        GetClicks(setup.screenNum);
    end

    %Machine instructions
    Screen('TextSize',w, round(wRect(4)/30)); Screen('TextFont',w,'Arial');
    DrawFormattedText(w, setup.instr_mach_txt, 'center', setup.yCen*0.2, color.black, 60, setup.flip_flag_horizontal, setup.flip_flag_vertical,1.2);
    start_texture = Screen('MakeTexture', w, setup.stim.start_frame);
        %options
    display_options(w, setup.r_options, setup.option_colours, start_texture, setup.border_size);
    Screen('Flip',w);
    WaitSecs(1);
    if SMsettings.settings.do_fmri
        while true
            [pressed,~,key] = KbCheck();
            if key(setup.key_response{1}) || key(setup.key_response{2})
                break
            end
        end
        %KbWait();
    else
       while true
           [~,~,mouse.button] = GetMouse;
            if mouse.button(setup.mouse_response(1)) || mouse.button(setup.mouse_response(2))
                            break
            end
       end
    end
    
        %Logged response instructions
    Screen('TextSize',w, round(wRect(4)/30)); Screen('TextFont',w,'Arial');
    DrawFormattedText(w, setup.instr_mach_txt, 'center', setup.yCen*0.2, color.black, 60, setup.flip_flag_horizontal, setup.flip_flag_vertical,1.2);
    start_texture = Screen('MakeTexture', w, setup.stim.start_frame);
        %options
     if SMsettings.settings.do_fmri   
	    if key(setup.key_response{1})
            display_choice(w, setup.r_options, setup.option_colours, start_texture, setup.border_size,0);
        elseif key(setup.key_response{2})
            display_choice(w, setup.r_options, setup.option_colours, start_texture, setup.border_size,1);
        end
	else
	    if mouse.button(setup.mouse_response(1))
		    display_choice(w, setup.r_options, setup.option_colours, start_texture, setup.border_size,0);
        elseif mouse.button(setup.mouse_response(2))
		    display_choice(w, setup.r_options, setup.option_colours, start_texture, setup.border_size,1);
	    end
    end
    Screen('Flip',w);
    WaitSecs(1);
    if SMsettings.settings.do_fmri
        while true
            [pressed,~,key] = KbCheck();
            if key(setup.key_response{1}) || key(setup.key_response{2})
                break
            end
        end
        %KbWait();
    else
        GetClicks(setup.screenNum);
    end
    
    
    %Reward numbers instructions
    Screen('TextSize',w, round(wRect(4)/30)); Screen('TextFont',w,'Arial');
    DrawFormattedText(w, setup.instr_reward, 'center', setup.yCen*0.8, color.black, 60, setup.flip_flag_horizontal, setup.flip_flag_vertical,1.2);
    display_reward(w, wRect, [20 80], color.black, setup.option_colours, setup.r_options{1}, setup.r_options{2}, setup.border_size, setup.flip_flag_horizontal, setup.flip_flag_vertical);
    Screen('Flip',w);
    WaitSecs(1);
    if SMsettings.settings.do_fmri
        while true
            [pressed,~,key] = KbCheck();
            if key(setup.key_response{1}) || key(setup.key_response{2})
                break
            end
        end
        %KbWait();
    else
        GetClicks(setup.screenNum);
    end
    
    %Current category instructions
    Screen('TextSize',w, round(wRect(4)/30)); Screen('TextFont',w,'Arial');
    DrawFormattedText(w, setup.instr_cat_txt, 'center', 'center', color.black, 60, setup.flip_flag_horizontal, setup.flip_flag_vertical,1.2);    
    if SMsettings.settings.do_food == 1
        blocktype_texture = Screen('MakeTexture', w, setup.stim.block_food);    
        display_blocktype(w, wRect, blocktype_texture, setup.full_rect, SMsettings.settings.do_fmri);
    else
        blocktype_texture = Screen('MakeTexture', w, setup.stim.block_money);    
        display_blocktype(w, wRect, blocktype_texture, setup.full_rect, SMsettings.settings.do_fmri);
    end
    
    Screen('Flip',w);
    WaitSecs(1);
    if SMsettings.settings.do_fmri
        while true
            [pressed,~,key] = KbCheck();
            if key(setup.key_response{1}) || key(setup.key_response{2})
                break
            end
        end
        %KbWait();
    else
        GetClicks(setup.screenNum);
    end

%     %Feedback instruction
%     Screen('TextSize',w, round(wRect(4)/30)); Screen('TextFont',w,'Arial');
%     DrawFormattedText(w, setup.instr_corr_txt, 'center', setup.yCen*0.4, color.black, 60, setup.flip_flag_horizontal, setup.flip_flag_vertical);
%     start_texture = Screen('MakeTexture', w, setup.stim.start_frame);
%         %options
%     display_feedback(w, setup.r_options, setup.option_colours, start_texture, setup.border_size);
%     Screen('Flip',w);   
%     Screen('Flip',w);
%     WaitSecs(1);
%     if SMsettings.settings.do_fmri
%         while true
%             [pressed,~,key] = KbCheck();
%             if key(setup.key_response{1}) || key(setup.key_response{2})
%                 break
%             end
%         end
%         %KbWait();
%     else
%         GetClicks(setup.screenNum);
%     end
  
    %Score scale instructions
    Screen('TextSize',w, round(wRect(4)/30)); Screen('TextFont',w,'Arial');
    DrawFormattedText(w, setup.instr_score_txt , 'center', setup.yCen, color.black, 60, setup.flip_flag_horizontal, setup.flip_flag_vertical,1.2);
    display_score_bar(w, wRect, 200 ,setup.maxscore, color, setup.full_rect, SMsettings.settings.lang_de, SMsettings.settings.do_fmri, setup.flip_flag_horizontal, setup.flip_flag_vertical); 
    Screen('Flip',w);
    WaitSecs(1);
    if SMsettings.settings.do_fmri
        while true
            [pressed,~,key] = KbCheck();
            if key(setup.key_response{1}) || key(setup.key_response{2})
                break
            end
        end
        %KbWait();
    else
        GetClicks(setup.screenNum);
    end
    
    %Fast response reminder
    Screen('TextSize',w, round(wRect(4)/30)); Screen('TextFont',w,'Arial');
    DrawFormattedText(w, setup.instr_fast, 'center', 'center', color.black, 60, setup.flip_flag_horizontal, setup.flip_flag_vertical,1.2);
    Screen('Flip', w);
    WaitSecs(1);
    if SMsettings.settings.do_fmri
        while true
            [pressed,~,key] = KbCheck();
            if key(setup.key_response{1}) || key(setup.key_response{2})
                break
            end
        end
        %KbWait();
    else
        GetClicks(setup.screenNum);
    end
    
    %Questions & Start
    Screen('TextSize',w, round(wRect(4)/30)); Screen('TextFont',w,'Arial');
    DrawFormattedText(w, setup.instr_start_txt, 'center', 'center', color.black, 60, setup.flip_flag_horizontal, setup.flip_flag_vertical,1.2);
    Screen('Flip', w);
    WaitSecs(1);
    if SMsettings.settings.do_fmri
        while true
            [pressed,~,key] = KbCheck();
            if key(setup.key_response{1}) || key(setup.key_response{2})
                break
            end
        end
        %KbWait();
    else
        GetClicks(setup.screenNum);
    end
else
    Screen('TextSize',w, round(wRect(4)/30)); Screen('TextFont',w,'Arial');    
    DrawFormattedText(w, setup.instr_repeat_txt, 'center', 'center', color.black, 60, setup.flip_flag_horizontal, setup.flip_flag_vertical,1.2);
    Screen('Flip', w);
    WaitSecs(1);
    if SMsettings.settings.do_fmri
        while true
            [pressed,~,key] = KbCheck();
            if key(setup.key_response{1}) || key(setup.key_response{2})
                break
            end
        end
        %KbWait();
    else
        GetClicks(setup.screenNum);
    end
    
end

%% START
for nblock = first_block:setup.nblocks
    start_block = GetSecs;
    score = 0;
    if SMsettings.settings.do_fmri == 1
        MR_timings.jitter.isi(:, nblock) = Shuffle(option_duration(nblock,:)); 
        MR_timings.jitter.iti(:, nblock) = Shuffle(iti_duration(nblock,:));
        trial_duration(:,nblock) = MR_timings.jitter.isi(:,nblock) + 0.05 + spin_duration + feedback_duration +  MR_timings.jitter.iti(:, nblock);
        % randomize rewards:
        reward.grid{nblock}=reward.grid{nblock}(randperm(setup.ntrials),:);
        MR_timings.interblockinterval = 8;
    end
    %change order in output as well 
    output.reward{nblock} = reward.grid{nblock};
    
    Screen('TextSize',w,wRect(4)/10); Screen('TextFont',w,'Arial');
    DrawFormattedText(w, setup.fix, 'center', 'center', color.black, [], setup.flip_flag_horizontal, setup.flip_flag_vertical);
    Screen('Flip',w);
    if nblock == 1
        WaitSecs(5);
    elseif nblock == 3%longer break after the second block in the scanner (for the 
    
            if SMsettings.settings.do_fmri == 1
                interblocktime = MR_timings.interblockinterval - (GetSecs-end_block(nblock-1)) + 60;
            else
                interblocktime = Beh_timings.interblockinterval - (GetSecs-end_block(nblock-1));
            end
     
        WaitSecs(interblocktime-5);
        % show text for the last 5 seconds (time to prep measurement) don't
        % actually start it before the text disappears. From there on the
        % task waits for the scanner trigger to start the task

        Screen('TextSize',w, round(wRect(4)/26)); Screen('TextFont',w,'Arial');
        if SMsettings.settings.lang_de == 1
            block_result = ['Gleich geht es weiter'];
        else

            block_result = ['The task will continue soon'];

        end
        DrawFormattedText(w, block_result, 'center', 'center', color.black, [], setup.flip_flag_horizontal, setup.flip_flag_vertical);
        Screen('Flip',w);
        WaitSecs(5)
        Screen('TextSize',w,wRect(4)/10); Screen('TextFont',w,'Arial');
        DrawFormattedText(w, setup.fix, 'center', 'center', color.black, [], setup.flip_flag_horizontal, setup.flip_flag_vertical);
        Screen('Flip',w);
    else
        if SMsettings.settings.do_fmri == 1
                interblocktime = MR_timings.interblockinterval - (GetSecs-end_block(nblock-1));
            else
                interblocktime = Beh_timings.interblockinterval - (GetSecs-end_block(nblock-1));
        end
        WaitSecs(interblocktime);
    end
    
    if SMsettings.settings.do_fmri == 1 & settings.debug ~=1
 
        MR_timings.on_trigger_loop(nblock) = GetSecs;
        KbQueueCreate();
        KbQueueFlush();
        KbQueueStart();
        %[ons_resp, starttime] = Screen('Flip', w, []);
        [b,c] = KbQueueCheck;
        
        % in MR environment: count triggers until start of imgage display
        while c(keyQuit) == 0
            [b,c] = KbQueueCheck;
            if c(keyTrigger) || c(keyTrigger2) > 0
                count_trigger = count_trigger + 1;
                MR_timings.trigger.all(count_trigger,1) = GetSecs;
                if count_trigger > dummy_volumes
                    if nblock == 1
                        MR_timings.trigger.fin = GetSecs;
                    end
                    break
                end
            end
        end
    
    elseif SMsettings.settings.do_fmri == 0   
        Beh_timings.trigger.fin = GetSecs;
    end
   
    
    for ntrial = 1:setup.ntrials
        %% Option phase with decision in the end
        % display options, previous choice and score, flip screen
        
        
         % DETERMINE WHICH SLOT MACHINE WINS for this trial
        if setup.rgw.coin(ntrial,nblock) < setup.rgw.allprob{nblock}(ntrial,1)
            output.draw(ntrial,nblock) = setup.option_codes(1); %blue, 0
        else
            output.draw(ntrial,nblock) = setup.option_codes(2); %red, 1
        end
        
        
        % display start screen
        wSM = Screen('OpenOffscreenwindow',w,color.white);
        start_texture = Screen('MakeTexture', w, setup.stim.start_frame);
            %options
        display_options(wSM, setup.r_options, setup.option_colours, start_texture, setup.border_size);
            %reward
        display_reward(wSM, wRect, reward.grid{nblock}(ntrial,:), color.black, setup.option_colours, setup.r_options{1}, setup.r_options{2}, setup.border_size, setup.flip_flag_horizontal, setup.flip_flag_vertical);
            %block icon
        if output.moneyblock(nblock) 
            blocktype_texture = Screen('MakeTexture', w, setup.stim.block_money);
        else
            blocktype_texture = Screen('MakeTexture', w, setup.stim.block_food);
        end
        display_blocktype(wSM, wRect, blocktype_texture, setup.full_rect, SMsettings.settings.do_fmri);


            %score
        display_score_bar(wSM, wRect, score ,setup.maxscore, color, setup.full_rect, SMsettings.settings.lang_de, SMsettings.settings.do_fmri, setup.flip_flag_horizontal, setup.flip_flag_vertical);
        Screen('CopyWindow',wSM,w);
        onset_options = Screen('Flip',w);
        
        if SMsettings.settings.do_fmri
            MR_timings.onsets.options(ntrial,nblock) = onset_options;
        end
        
        if SMsettings.settings.do_fmri && ntrial>1
            MR_timings.durations.iti(ntrial-1,nblock) = MR_timings.onsets.options(ntrial,nblock) - MR_timings.onsets.iti(ntrial-1,nblock);
        end
        Screen('Close', start_texture);
        if SMsettings.settings.do_fmri
            if ntrial > 1
                start_time(ntrial,nblock) = MR_timings.onsets.options(ntrial,nblock) - time_stamp_interval_iti;
            end
        end
            % Get  response and record response time
        time_stamp_interval = GetSecs;
        if SMsettings.settings.do_fmri == 1
            while time_stamp_interval-onset_options < MR_timings.max_decision_interval
                [pressed,~,key] = KbCheck();
                time_stamp_interval = GetSecs;
                if key(setup.key_response{1})
                    output.choice(ntrial,nblock) = setup.option_codes(1);
                    break
                elseif key(setup.key_response{2})
                    output.choice(ntrial,nblock) = setup.option_codes(2);
                    break
                end
            end
        else
            while time_stamp_interval-onset_options < Beh_timings.max_decision_interval
                [~,~,mouse.button] = GetMouse;
                time_stamp_interval = GetSecs;
                if mouse.button(setup.mouse_response(1))
                    output.choice(ntrial,nblock) = setup.option_codes(1);
                    break
                elseif mouse.button(setup.mouse_response(2))
                    output.choice(ntrial,nblock) = setup.option_codes(2);
                    break
                end
                % on pressing keyQuit, abort the task
                [~,~,key] = KbCheck();
                if key(keyQuit)
	                error('Quit-key pressed!')
                end
            end
        end
        if SMsettings.settings.do_fmri
            MR_timings.onsets.decision(ntrial,nblock) = time_stamp_interval;
            [output.rt(ntrial, nblock), MR_timings.durations.options(ntrial,nblock)] = deal(MR_timings.onsets.decision(ntrial,nblock) - MR_timings.onsets.options(ntrial,nblock));
            decision_time_leftover = MR_timings.max_decision_interval-MR_timings.durations.options(ntrial,nblock);
            output.confirmed(ntrial,nblock) = 1;            
        else
            output.rt(ntrial, nblock) = time_stamp_interval - onset_options;
            output.confirmed(ntrial,nblock) = 1;                        
        end
            %generate random choice if no response in given time
        if SMsettings.settings.do_fmri
            if key(setup.key_response{1}) == 0 && key(setup.key_response{2}) == 0
                output.choice(ntrial,nblock) = randsample(setup.option_codes,1);
                output.rt(ntrial, nblock) = NaN;
                output.confirmed(ntrial,nblock) = 0;
            end
        else
            if mouse.button(setup.mouse_response(1)) == 0 && mouse.button(setup.mouse_response(2)) == 0
                output.choice(ntrial,nblock) = randsample(setup.option_codes,1);
                output.rt(ntrial, nblock) = NaN;
                output.confirmed(ntrial,nblock) = 0;
            end
        end
        
        %% ISI - Show logged response 
          % define choice made depending on mouse button (0-left, 1-right)
 
        %add green rectangle
        %display start screen
        wSM = Screen('OpenOffscreenwindow',w,color.white);
        start_texture = Screen('MakeTexture', w, setup.stim.start_frame);
            %options
        display_choice(wSM, setup.r_options, setup.option_colours, start_texture, setup.border_size, output.choice(ntrial,nblock))  %, output.choice(ntrial,nblock)
            %reward
        display_reward(wSM, wRect, reward.grid{nblock}(ntrial,:), color.black, setup.option_colours, setup.r_options{1}, setup.r_options{2}, setup.border_size, setup.flip_flag_horizontal, setup.flip_flag_vertical);
            %block icon
        display_blocktype(wSM, wRect, blocktype_texture, setup.full_rect, SMsettings.settings.do_fmri);

             %score
        display_score_bar(wSM, wRect, score ,setup.maxscore, color, setup.full_rect, SMsettings.settings.lang_de, SMsettings.settings.do_fmri, setup.flip_flag_horizontal, setup.flip_flag_vertical);
        Screen('CopyWindow',wSM,w);
        
        time_choice_logged = Screen('Flip',w);
        Screen('Close', start_texture);
        
        time_stamp_interval_isi = GetSecs;
        if SMsettings.settings.do_fmri
            while time_stamp_interval_isi-onset_options < MR_timings.jitter.isi(ntrial, nblock)
                time_stamp_interval_isi = GetSecs;

            end
        else
            while time_stamp_interval_isi-onset_options < Beh_timings.option_duration
                time_stamp_interval_isi = GetSecs;
            end
        end

        %% INTERVAL PHASE - PLAY VIDEO
        %save current score 
        score_old = score;
        
        if output.confirmed(ntrial,nblock) == 1
            % evaluate response and calculate new score
            if output.choice(ntrial,nblock) == output.draw(ntrial,nblock)
                %correct
                output.eval(ntrial,nblock) = 1;
                diffscore = reward.grid{nblock}(ntrial, output.choice(ntrial,nblock)+1);
                score = score + reward.grid{nblock}(ntrial, output.choice(ntrial,nblock)+1);
            elseif output.choice(ntrial,nblock) ~= output.draw(ntrial,nblock)
                %incorrect
                output.eval(ntrial,nblock) = 0;
                diffscore = -reward.grid{nblock}(ntrial, output.choice(ntrial,nblock)+1);
                score = score - reward.grid{nblock}(ntrial, output.choice(ntrial,nblock)+1);
            end
        else
            if output.choice(ntrial,nblock) == output.draw(ntrial,nblock)
                output.eval(ntrial,nblock) = 1;
            else
                output.eval(ntrial,nblock) = 0;
            end
            diffscore = 0;
       end
        
        output.score(ntrial,nblock) = score;
        output.diffscore(ntrial,nblock) = diffscore;
             
        
        
        % randomise which video is diplayed - video is coded: full_time_x_y
        %(x: 0 for lost, 1 for won) (y: differnt types of lose or win)
        if output.moneyblock(nblock)
            block_type = 'money';
        else
            block_type = 'food';
        end
        
        %Prepare basic screen without score bar (is added depending on
        %time)
        
        wSM = Screen('OpenOffscreenwindow',w,color.white);
        start_texture = Screen('MakeTexture', w, setup.stim.start_frame);
        %options
        display_choice(wSM, setup.r_options, setup.option_colours, start_texture, setup.border_size, output.choice(ntrial,nblock))  %, output.choice(ntrial,nblock)
        %reward
        display_reward(wSM, wRect, reward.grid{nblock}(ntrial,:), color.black, setup.option_colours, setup.r_options{1}, setup.r_options{2}, setup.border_size, setup.flip_flag_horizontal, setup.flip_flag_vertical);
        %block icon
        display_blocktype(wSM, wRect, blocktype_texture, setup.full_rect, SMsettings.settings.do_fmri);
        Screen('Close', start_texture);
       
        %trial_name = 'clips\food_1_1_cropped_flipped.mp4'; % fixed video for testing
        spin_vid = spin_vids(output.eval(ntrial,nblock)+1,randi(num_spin_options)).(block_type);
        % set start time of video according to jitter (after converting
        % duration based on actual frame rate)1
        % play video for fixed duration (defined in the beginning)  jitter is included in the waiting before.  
        if SMsettings.settings.do_fmri
            interval_duration_trial = spin_duration(1,1) * ((1/spin_vid.FrameRate)/setup.flip_interval);  % double duration because video has double length but is played at double hz
            spin_vid.CurrentTime = spin_vid.Duration -interval_duration_trial;
         
            [MR_timings.durations.spin(ntrial, nblock), MR_timings.onsets.spin(ntrial, nblock), MR_timings.onsets.feedback(ntrial, nblock),End_time] = play_spin_vid(w, wSM, spin_vid, interval_duration_trial/2, output.choice(ntrial,nblock), setup.r_options, setup.option_colours, setup.option_codes, time_stamp_interval_isi, setup.flip_interval, setup.border_size, setup, SMsettings, wRect, blocktype_texture, diffscore, color, score, nblock, ntrial, output, score_old);
        else
            interval_duration_trial =  Beh_timings.interval* ((1/spin_vid.FrameRate)/setup.flip_interval);
            if interval_duration_trial >= spin_vid.Duration
                WaitSecs((interval_duration_trial - spin_vid.Duration)/2)
                spin_vid.CurrentTime = 0;
            else
                spin_vid.CurrentTime = spin_vid.Duration -interval_duration_trial;
            end
            play_spin_vid(w, wSM, spin_vid, Beh_timings.interval, output.choice(ntrial,nblock), setup.r_options, setup.option_colours, setup.option_codes, time_stamp_interval, setup.flip_interval, setup.border_size, setup, SMsettings, wRect, blocktype_texture, diffscore, color, score, nblock, ntrial, output, score_old);
        end
        
        %load_time(ntrial,nblock) = MR_timings.onsets.spin(ntrial,nblock) - time_stamp_interval_isi;
        %% FEEDBACK PHASE - show final frame and feedback 
        
        % loads video again and displays last frame 
        % - if video did not play smoothly final-outcome frame will still be presented
        wSM = Screen('OpenOffscreenwindow',w,color.white);
        start_texture = Screen('MakeTexture', w, setup.stim.start_frame);
            %options
        display_options(wSM, setup.r_options, setup.option_colours, start_texture, setup.border_size);
        %frame_texture=Screen('MakeTexture', w, last_frame);
        %Screen('DrawTexture', wSM, frame_texture,  [],  [setup.r_options{output.choice(ntrial,nblock)+1}]);% was w
            %reward
        display_reward_feedback(wSM, wRect, reward.grid{nblock}(ntrial,:), color.black, setup.option_colours, setup.r_options{1}, setup.r_options{2}, setup.border_size, setup.flip_flag_horizontal, setup.flip_flag_vertical,output.choice(ntrial,nblock), setup.option_codes, output.eval(ntrial,nblock));
            %block icon
        display_blocktype(wSM, wRect, blocktype_texture, setup.full_rect, SMsettings.settings.do_fmri);
        display_blocktype_feedback(wSM, wRect, blocktype_texture);

       %spin_vid = VideoReader(trial_name); -> had to add this for old
       %matlab version
        display_feedback(w, wSM, wRect, setup.option_colours, setup.option_codes, spin_vid, output.choice(ntrial,nblock), output.eval(ntrial,nblock), output.choice(ntrial,nblock), setup.r_options, setup.border_size, SMsettings.settings.lang_de, setup.flip_flag_horizontal, setup.flip_flag_vertical,output.confirmed(ntrial,nblock),0);
        display_score_bar(wSM, wRect, score ,setup.maxscore, color, setup.full_rect, SMsettings.settings.lang_de, SMsettings.settings.do_fmri, setup.flip_flag_horizontal, setup.flip_flag_vertical,diffscore);
        Screen('CopyWindow',wSM,w);
        feedback_onset = Screen('Flip',w);
        time_stamp_interval_fb = GetSecs;
        if SMsettings.settings.do_fmri
            while time_stamp_interval_fb-MR_timings.onsets.spin(ntrial, nblock) < (spin_duration + feedback_duration)
                time_stamp_interval_fb = GetSecs;

            end
        else
            fb_time = GetSecs;
            while time_stamp_interval_fb-fb_time < Beh_timings.feedback
                time_stamp_interval_fb = GetSecs;

            end

        end
        clear spin_vid
        clear trial_name
        
        %% ITI
        Screen('TextSize',w,wRect(4)/10); Screen('TextFont',w,'Arial');
        DrawFormattedText(w, setup.fix, 'center', 'center', color.black, [], setup.flip_flag_horizontal, setup.flip_flag_vertical);
        iti_onset = Screen('Flip',w);
        if SMsettings.settings.do_fmri
            MR_timings.onsets.iti(ntrial,nblock) = iti_onset;
            MR_timings.durations.feedback(ntrial,nblock) = MR_timings.onsets.iti(ntrial,nblock) - MR_timings.onsets.feedback(ntrial,nblock);
            time_stamp_interval_iti = GetSecs;
            while time_stamp_interval_iti-onset_options < trial_duration(ntrial,nblock)
                time_stamp_interval_iti = GetSecs;
            end
            
            
        else
            WaitSecs(Beh_timings.iti);
        end
    end

    %% End of block
    if output.moneyblock(nblock) == 0
        if SMsettings.settings.do_fmri
            MR_timings.endblock(nblock) = GetSecs;
            MR_timings.durations.iti(ntrial,nblock) = MR_timings.endblock(nblock) - MR_timings.onsets.iti(ntrial,nblock);
        end
        
        if SMsettings.settings.lang_de == 1
            reward_type = 'Essen';
        else
            reward_type = 'food';
        end
        output.foodscore = [output.foodscore;score];
        output.allfoodscore = sum(output.foodscore,'all');
        %output.allfoodscore = sum(output.foodscore);-> old matlab version
    else
        if SMsettings.settings.do_fmri
            MR_timings.endblock(nblock) = GetSecs;
            MR_timings.durations.iti(ntrial,nblock) = MR_timings.endblock(nblock) - MR_timings.onsets.iti(ntrial,nblock);
        end
    
        if SMsettings.settings.lang_de == 1
            reward_type = 'Geld';
        else
            reward_type = 'money';
        end
        output.moneyscore = [output.moneyscore;score];
        output.allmoneyscore = sum(output.moneyscore,'all');
        %output.allmoneyscore = sum(output.moneyscore);->old matlab version
    end
    
    if nblock < setup.nblocks
        % Screen for block results
        Screen('TextSize',w, round(wRect(4)/26)); Screen('TextFont',w,'Arial');
         if SMsettings.settings.lang_de == 1
            if nblock ~= 2
                block_result = ['Block beendet. \nSie koennen sich kurz entspannen.'];
            else 
                block_result = ['Block beendet. \nNun kommt eine etwas laenger Pause. \nSie koennen sich kurz entspannen.'];
            end    
        else
            if nblock ~= 2
                block_result = ['Block finished.\nYou can relax for a moment.'];
            else
                block_result = ['Block finished.\nThere will be a slightly longer break now.\nYou can relax for a moment.'];
            end
        end   
        DrawFormattedText(w, block_result, 'center', 'center', color.black, [], setup.flip_flag_horizontal, setup.flip_flag_vertical);
        Screen('Flip',w);
        WaitSecs(2)

        output.time = datetime;
        output.filename = sprintf('SM_%s_%s_S%s_R%s', subj.studyID, subj.subjectID, subj.sessionID, subj.runID);
        
        end_block(nblock) = GetSecs;
        durations(nblock) = end_block(nblock)-start_block;

        if SMsettings.settings.do_fmri == 1
            save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'MR_timings');
        else
            save(fullfile('data', [output.filename '.mat']), 'output', 'subj');
        end
        save(fullfile('backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));
    end
    end_block(nblock) = GetSecs;
    durations(nblock) = end_block(nblock)-start_block;
end
task_end = GetSecs;
task_duration = task_end-task_start;

%Calculate payout
payout.money = output.allmoneyscore/400;
if payout.money < 0
    payout.money = 0;
end
payout.food = output.allfoodscore/4;
if 55555 < 0
    payout.food = 0;
end

payout.food_muesli = floor(payout.food*0.8);
payout.food_snack = floor(payout.food*0.2);

musli_ent = round(payout.food_muesli/30);
if musli_ent > 17
    diff_kcal = payout.food_muesli - (17*30);
    payout.food_snack = payout.food_snack + diff_kcal;
    musli_ent = 17;
end

Screen('TextSize',w, round(wRect(4)/26)); Screen('TextFont',w,'Arial');
if SMsettings.settings.lang_de == 1
    task_result = ['Die Aufgabe ist nun zu Ende.\n\nInsgesamt haben Sie ' num2str(output.allfoodscore) ' Essenspunkte und ' num2str(output.allmoneyscore) ' Geldpunkte gewonnen.\nDas entspricht ' num2str(payout.money) '\nEuro und ' num2str(payout.food) ' Kilokalorien (= ' num2str(round(payout.food_snack/100,1)) ' Snacks + ' num2str(musli_ent) 'Muesli).'];
else
    task_result = ['The task is now over.\n\nOverall, you won ' num2str(output.allfoodscore) ' points of food and ' num2str(output.allmoneyscore) ' points of money.\nThis equals ' num2str(payout.money) ' euro and ' num2str(payout.food) ' kilocalories (= ' num2str(payout.food/20) ' snacks).'];
end   
DrawFormattedText(w, task_result, 'center', 'center', color.black, 60, setup.flip_flag_horizontal, setup.flip_flag_vertical,1.2);
Screen('Flip',w);

output.time = datetime;
output.filename = sprintf('SM_%s_%s_S%s_R%s', subj.studyID, subj.subjectID, subj.sessionID, subj.runID);

if SMsettings.settings.do_fmri == 1
    save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'MR_timings','payout');
else
    save(fullfile('data', [output.filename '.mat']), 'output', 'subj');
end
save(fullfile('backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));

WaitSecs(6)
sca;
ShowCursor;
catch
    sca
    ShowCursor;
    error(lasterror)
end
disp(append(num2str(payout.food_snack),' Snack Kalorien',num2str(musli_ent) ,' Muesli einheiten und ', num2str(payout.money),' Euro ausbezahlen.'))

function display_options(wSM, r_options, option_colours, start_texture, border_size) %wRect, option_names, color)
Screen('DrawTexture', wSM, start_texture,  [],  r_options{1});
Screen('DrawTexture', wSM, start_texture,  [],  r_options{2});
Screen ('FrameRect', wSM, option_colours{1}, r_options{1}, border_size);
Screen ('FrameRect', wSM, option_colours{2}, r_options{2}, border_size);
end

function display_choice(w, r_options, option_colours, start_texture, border_size, choice) %wRect, option_names, color)
Screen('DrawTexture', w, start_texture,  [],  r_options{1});
Screen('DrawTexture', w, start_texture,  [],  r_options{2});
if choice == 1
    Screen ('FrameRect', w, option_colours{1}, r_options{1}, border_size);
    Screen ('FrameRect', w, [50,205,50], r_options{2}, border_size);
elseif choice == 0
    Screen ('FrameRect', w, [50,205,50], r_options{1}, border_size);
    Screen ('FrameRect', w, option_colours{2}, r_options{2}, border_size);
end
end

function display_prev (w, wRect, color, color_choice)
rect = CenterRect([0 0 wRect(4)/10 wRect(4)/10],wRect);
rect = OffsetRect(rect, 0, +wRect(4)/6);
Screen('FillOval', w, color.white, rect);
Screen('FrameOval', w, color_choice, rect, round(wRect(4)/200));
end


function [full_rect, score,score_rect,score_rel] = display_score_bar(w, wRect, score, maxscore, color, full_rect, lang, do_fmri, flip_flag_horizontal, flip_flag_vertical,aftertrial)
% if ~exist('aftertrial')
%     aftertrial = 0;
% end
Screen('TextSize', w, round(wRect(4)/27));
Screen('TextFont',w,'Arial');

    if lang == 1
        txt = ['Punkte   ' num2str(score) '\n     '];
    else
        txt = ['Score   ' num2str(score) '\n     '];
    end
if exist('aftertrial')
    if aftertrial > 0
        symbol = '+';
    else
        symbol = ' ';
    end
    
 
        txt_2 = [symbol num2str(aftertrial)];
end

[score_rect] = Screen ('TextBounds', w, txt);
if exist('aftertrial')
[score_rect_2] = Screen ('TextBounds', w, txt_2);
end
if do_fmri 
    score_rect =  AdjoinRect(score_rect, full_rect, RectRight); %rightleft
    score_rect = OffsetRect(score_rect, full_rect(3)*0.02, full_rect(4)-RectHeight(score_rect)); % center according to score bar
    if exist('aftertrial')
    score_rect_2 = CenterRect(score_rect_2, wRect); %rightleft
    score_rect_2 = OffsetRect(score_rect_2, -wRect(3)*0.008, +wRect(4)/24); % center according to score bar
    end
else
    score_rect =  AdjoinRect(score_rect, full_rect, RectLeft); %rightleft
    score_rect = OffsetRect(score_rect, -full_rect(3)*0.10, full_rect(4)-RectHeight(score_rect)); % center according to score bar
    if exist('aftertrial')
    score_rect_2 = CenterRect(score_rect_2, wRect); %rightleft
    score_rect_2 = OffsetRect(score_rect_2, -wRect(3)*0.008, +wRect(4)/24);
    end
end
if exist('aftertrial')
    if aftertrial ~=0
        if aftertrial < 0
            score_text_color = [95,92,89];
            %score_text_color = [68 125 44];
        else
            score_text_color = [68 125 44];
            
            %score_text_color = [135,191,8];
        end
    else
        score_text_color = color.black;
    end
else
    score_text_color = color.black;
end
%DrawFormattedText(w, txt, 'center', 'center', score_text_color, [], flip_flag_horizontal, flip_flag_vertical,[],[], score_rect);
DrawFormattedText(w, txt, 'center', 'center', score_text_color, [], flip_flag_horizontal, flip_flag_vertical,[],[], score_rect);
if exist('aftertrial')
    Screen('TextSize',w,round(wRect(4)/15));
    DrawFormattedText(w, txt_2, 'center', 'center', score_text_color, [], flip_flag_horizontal, flip_flag_vertical,[],[], score_rect_2);
    Screen('TextSize',w,round(wRect(4)/15));
end

%DrawFormattedText(w, txt, 'center', 'center', color.black, [], flip_flag_horizontal, flip_flag_vertical,[],[], score_rect);
Screen('FillRect', w, [206 206 206], full_rect);
Screen('FrameRect', w, color.black, full_rect, 1);
score_disp = score + maxscore/2;

% scales a rectangle to fill the score bar proportional to the score
score_rel = abs(score)/(maxscore);
score_rect = ScaleRect(full_rect, score_rel, 1);
score_rect = AlignRect(score_rect, full_rect, 'center', 'top');   
score_rect = AlignRect(score_rect, full_rect, 'center', 'top');

if (score>0 && ~do_fmri) || (score<0 && do_fmri)
    score_rect = OffsetRect(score_rect, +RectWidth(score_rect)/2, 0);
elseif (score<0 && ~do_fmri) || (score>0 && do_fmri)
     score_rect = OffsetRect(score_rect, -RectWidth(score_rect)/2, 0);
end

if score < 0
%     score_color = [68 125 44];
    score_color = [95,92,89];
else
%     score_color = [135,191,8];
    score_color = [68 125 44];
end    

Screen('FillRect', w, score_color, score_rect);
%Screen('FillRect', w, [56 56 56], score_rect);

markers = {num2str(-maxscore/2), num2str(0), num2str(+maxscore/2)};
Screen('TextSize', w, round(wRect(4)/40));
[min] = Screen ('TextBounds',w,  markers{1});
[zero] = Screen ('TextBounds',w,  markers{2});
[max] = Screen ('TextBounds', w, markers{3});

if do_fmri
    min =AlignRect(min, full_rect, 'right', 'top');
    zero =AlignRect(zero, full_rect, 'center', 'top');
    max = AlignRect(max, full_rect, 'left', 'top');
else
    min =AlignRect(min, full_rect, 'left', 'top');
    zero =AlignRect(zero, full_rect, 'center', 'top');
    max = AlignRect(max, full_rect, 'right', 'top');
end
min = OffsetRect(min, 0, -RectHeight(full_rect)*1.5);
zero = OffsetRect(zero, 0, -RectHeight(full_rect)*1.5);
max = OffsetRect(max, 0, -RectHeight(full_rect)*1.5);

DrawFormattedText(w,  markers{1}, 'center', 'center', color.black, [], flip_flag_horizontal, flip_flag_vertical,[],[], min);
DrawFormattedText(w,  markers{2}, 'center', 'center', color.black, [], flip_flag_horizontal, flip_flag_vertical,[],[], zero);
DrawFormattedText(w,  markers{3}, 'center', 'center', color.black, [], flip_flag_horizontal, flip_flag_vertical,[],[], max);
end

function display_reward(w, wRect, reward, txt_color, option_colours, r_left, r_right, border_size, flip_flag_horizontal, flip_flag_vertical)

width = RectWidth(r_left);
height = RectHeight(r_left)/6;
box_dim = [0 0 width height];
box_left = AlignRect(box_dim, r_left, 'center', 'top');
box_left = OffsetRect(box_left, 0, -height*2);

box_right = AlignRect(box_dim, r_right, 'center', 'top');
box_right = OffsetRect(box_right, 0, -height*2);

Screen ('FrameRect', w, option_colours{1}, box_left, border_size/2);
Screen ('FrameRect', w, option_colours{2}, box_right, border_size/2);

%Screen('TextSize',w,round(height-10));
Screen('TextSize',w,round(height*0.6));
Screen('TextFont',w,'Arial');
txt_left = num2str(reward(1));
txt_right = num2str(reward(2));

DrawFormattedText(w, txt_left,'center','center', txt_color,[], flip_flag_horizontal, flip_flag_vertical,[],[],box_left);
DrawFormattedText(w, txt_right,'center','center', txt_color,[], flip_flag_horizontal, flip_flag_vertical,[],[],box_right);
end

function display_reward_feedback(w, wRect, reward, txt_color, option_colours, r_left, r_right, border_size, flip_flag_horizontal, flip_flag_vertical, choice, option_codes, correct)


if correct == 0
%     score_color = [68 125 44];
    score_color = [191,92,89,0.3];
else
%     score_color = [135,191,8];
    score_color = [68 125 44,0.3];
end    


width = RectWidth(r_left);
height = RectHeight(r_left)/6;
box_dim = [0 0 width height];
box_left = AlignRect(box_dim, r_left, 'center', 'top');
box_left = OffsetRect(box_left, 0, -height*2);

box_right = AlignRect(box_dim, r_right, 'center', 'top');
box_right = OffsetRect(box_right, 0, -height*2);

Screen ('FrameRect', w, option_colours{1}, box_left, border_size/2);
Screen ('FrameRect', w, option_colours{2}, box_right, border_size/2);

if choice == option_codes(2) % 1%black to red
    %Screen ('FillRect', w, [255 255 255 .5], box_left);
    Screen ('FillRect', w, score_color, box_right);
elseif choice == option_codes(1) %0 %black to blue
    %Screen ('FillRect', w, [255 255 255 .5], box_right);
    Screen ('FillRect', w, score_color, box_left);
end


%Screen('TextSize',w,round(height-10));
Screen('TextSize',w,round(height*0.6));
Screen('TextFont',w,'Arial');
txt_left = num2str(reward(1));
txt_right = num2str(reward(2));

DrawFormattedText(w, txt_left,'center','center', txt_color,[], flip_flag_horizontal, flip_flag_vertical,[],[],box_left);
DrawFormattedText(w, txt_right,'center','center', txt_color,[], flip_flag_horizontal, flip_flag_vertical,[],[],box_right);
end

function display_blocktype(wSM, wRect, block_type_texture, full_rect, do_fmri)

box_dim = [0 0 wRect(3)*0.05  wRect(3)*0.05];
if do_fmri
    r_block_type = AlignRect(box_dim, wRect, 'left', 'top');
    r_block_type = OffsetRect(r_block_type, +wRect(3)*0.1, (wRect(4)*0.1)-(RectHeight(r_block_type)-RectHeight(full_rect))/2); % was 11 half of height of score bar
else
    r_block_type = AlignRect(box_dim, wRect, 'right', 'top');
    r_block_type = OffsetRect(r_block_type, -wRect(3)*0.1, (wRect(4)*0.1)-(RectHeight(r_block_type)-RectHeight(full_rect))/2);
%r_block_type =  AdjoinRect(r_block_type, full_rect, RectRight); 
end

Screen('DrawTexture', wSM, block_type_texture,  [],  [r_block_type]);
end

function display_blocktype_feedback(wSM, wRect, block_type_texture)

r_block_type = CenterRect([0 0 wRect(4)/10 wRect(4)/10],wRect);
r_block_type = OffsetRect(r_block_type, 0, +wRect(4)/6);

Screen('DrawTexture', wSM, block_type_texture,  [],  [r_block_type]);
end


function [actualTime, first_flip, end_time_interval,time_lastFlip] = play_spin_vid(w, wSM, spin_vid, iduration, choice, r_options, option_colours, option_codes, time_lastFlip, flip_interval, border_size, setup, SMsettings, wRect, blocktype_texture, diffscore, color, score, nblock, ntrial, output, score_old)

priorityLevel = MaxPriority(w); 
Priority(priorityLevel); % to ensure smooth video playing

start_time_interval = GetSecs;
end_time_interval = [];
is_firstFlip = true;
i = 1;
while hasFrame(spin_vid)
    
    frame = readFrame(spin_vid);
    % Change Color depending on the selection
    isBlack = all(frame >= 0 & frame<=5, 3);
    g = frame(:, :, 2);
    g(isBlack) = 0;
    if choice == option_codes(2) %1%black to red
        r = frame(:, :, 1);
        r(isBlack) = 255;
        b = frame(:, :, 3);
        b(isBlack) = 0;
    elseif choice == option_codes(1) % 0 %black to blue
        r = frame(:, :, 1);
        r(isBlack) = 0;
        b = frame(:, :, 3);
        b(isBlack) = 255;
    end
    frame = cat(3, r, g, b);
    %display each frame and flip
    frame_texture=Screen('MakeTexture', w, frame);
    Screen('DrawTexture', wSM, frame_texture,  [],  [r_options{choice+1}]);% was w
    Screen ('FrameRect', wSM, option_colours{choice+1}, r_options{choice+1}, border_size); %was w
    % add score w or without win depending on time 
    if time_lastFlip >= start_time_interval + iduration - flip_interval/2
        display_score_bar(wSM, wRect, score ,setup.maxscore, color, setup.full_rect, SMsettings.settings.lang_de, SMsettings.settings.do_fmri, setup.flip_flag_horizontal, setup.flip_flag_vertical,diffscore)
        display_blocktype_feedback(wSM, wRect, blocktype_texture)
        display_feedback(w, wSM, wRect, setup.option_colours, setup.option_codes, spin_vid, output.choice(ntrial,nblock), output.eval(ntrial,nblock), output.choice(ntrial,nblock), setup.r_options, setup.border_size, SMsettings.settings.lang_de, setup.flip_flag_horizontal, setup.flip_flag_vertical,output.confirmed(ntrial,nblock),1);
    else
        display_score_bar(wSM, wRect, score_old ,setup.maxscore, color, setup.full_rect, SMsettings.settings.lang_de, SMsettings.settings.do_fmri, setup.flip_flag_horizontal, setup.flip_flag_vertical)
    end
    Screen('CopyWindow',wSM,w);
    %GetSecs - time_lastFlip
    
    time_lastFlip(i) = Screen('Flip',w);

    
    if is_firstFlip
        first_flip = time_lastFlip;
        is_firstFlip = false;
    end
    
    Screen('Close', frame_texture);
    %time_lastFlip2 - time_lastFlip
    %Screen('GetFlipInterval', w)
    %Screen('GetFlipInfo', w) -> only linux
    end_time_interval = GetSecs;
    i = i+1;
end
Priority(0);
current_display = Screen('GetImage',w);
imwrite(current_display, 'test_endvid_II.png');
actualTime = end_time_interval(end) - first_flip; % measure time 
end

function display_feedback(w,wSM, wRect, option_colours, option_codes, spin_vid, choice, correct, color_choice, r_options, border_size, lang, flip_flag_horizontal, flip_flag_vertical,confirmed,text_only)
if text_only == 0
last_frame = read(spin_vid, Inf);

% Change Color depending on the selection
isBlack = all(last_frame >= 0 & last_frame<=5, 3); % uint8(0)
g = last_frame(:, :, 2);
g(isBlack) = 0;
if choice == option_codes(2) % 1%black to red
    r = last_frame(:, :, 1);
    r(isBlack) = 255;
    b = last_frame(:, :, 3);
    b(isBlack) = 0;
elseif choice == option_codes(1) %0 %black to blue
    r = last_frame(:, :, 1);
    r(isBlack) = 0;
    b = last_frame(:, :, 3);
    b(isBlack) = 255;
end
last_frame = cat(3, r, g, b);
last_frame_texture = Screen('MakeTexture', w, last_frame);
Screen('DrawTexture', wSM, last_frame_texture,  [],  r_options{choice+1});
Screen ('FrameRect', wSM,  option_colours{choice+1}, r_options{choice+1}, border_size);
end

Screen('TextSize',wSM,round(RectHeight(r_options{1})/6));
Screen('TextFont',wSM,'Arial');
Screen('TextStyle',wSM,1); %bold
if confirmed == 1
    if lang == 1
        feedback = {'VERLUST!', 'GEWINN!'};
    else
        feedback = {'YOU LOSE!', 'YOU WIN!'};  
    end
    [fb_rect] = Screen ('TextBounds', wSM, feedback{correct+1});
    
    fb_rect = CenterRect(fb_rect, wRect);
    fb_rect = OffsetRect(fb_rect, 0, +wRect(4)/3);
    fb_rect = GrowRect(fb_rect, 4,8);
    Screen('FillRect', wSM, [255 255 255], fb_rect);
    DrawFormattedText(wSM, feedback{correct+1}, 'center', 'center' , option_colours{color_choice+1}, [], flip_flag_horizontal, flip_flag_vertical,[],[], fb_rect);
    Screen('TextStyle',wSM,0); % not bold
else
    if lang == 1
        feedback = 'ZU LANGSAM!';
    else
        feedback = 'TOO SLOW';  
    end
    [fb_rect] = Screen ('TextBounds', wSM, feedback);
    fb_rect = CenterRect(fb_rect, wRect);
    fb_rect = OffsetRect(fb_rect, 0, +wRect(4)/3);
    fb_rect = GrowRect(fb_rect, 4,8);
    Screen('FillRect', wSM, [255 255 255], fb_rect);
    DrawFormattedText(wSM, feedback, 'center', 'center' , [0 0 0], [], flip_flag_horizontal, flip_flag_vertical,[],[], fb_rect);
    Screen('TextStyle',wSM,0); % not bold
end
end 




% Computes a jittered ITI drawn from a exponential distribution and truncated at a maximum value
% See Ashby (2011) for a discussion of the advantages.
function DelayJitter = ComputeJitter_exp(mu_jitter, max_delay, n_trials)

%sets the tolerance for local deviations of the sampled distribution from the intended mu
dev_tol = 0.01; %mu_jitter = 1.5; max_delay = 12; n_trials = 72;

while 1
    %samples n_trials times from the exponential distribution
    DelayJitter = exprnd(mu_jitter,n_trials,1);
    %truncates extreme values
    DelayJitter(DelayJitter > max_delay) = max_delay;
    %uses a criterion to break the loop when the sampled mu resembles the
    %intended mu
    if abs(mean(DelayJitter)-mu_jitter) < mu_jitter * dev_tol
        break
    end
end

%save(sprintf('DelayJitter_mu_%d_max_%d_trials_%d.mat', mu_jitter, max_delay, n_trials));
%histogram(DelayJitter,'Normalization','pdf');
%disp(['Sampled Mu = ' num2str(mean(DelayJitter))]);
end
