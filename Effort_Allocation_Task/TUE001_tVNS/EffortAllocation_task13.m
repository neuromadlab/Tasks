%%===================Effort allocation task===================
%Script for Effort cost paradigm -30/05/2017-
%author: Monja P. Neuser, Vanessa Teckentrup, Nils B. Kroemer

%frequency estimation with exponential weighting
%https://de.mathworks.com/help/dsp/ug/sliding-window-method-and-exponential-weighting-method.html

%input via XBox USB-Controller

% UPDATE: subject ID with 6 digit length [task version = 3]
% coded by Monja, 02.04.2019
%========================================================

%% Preparation

% Clear workspace
close all;
clear all; 
sca;

Screen('Preference', 'SkipSyncTests', 2);
load('JoystickSpecification.mat')

% Change settings
% Basic screen setup 
setup.screenNum = max(Screen('Screens')); %secondary monitor if there is one connected
setup.fullscreen = 1; %if 0 -> will create a small window ideal for debugging, set =1 for Experiment

do_gamepad = 1; %do not set to 0, this is not implemented yet
xbox_buffer = zeros(1,50); %will buffer the history of 50 button press status



%%get input from the MATLAB console
subj.studyID= 'TUE001';
subj.runLABEL=input('Study ID [1 für Training / 2 für Experiment]: ','s');
subj.subjectID=input('Subject ID [ohne Nullen]: ','s');
subj.sessionID=input('Session ID [1/2]: ','s');



%Translate StudyID to Study name
if strcmp(subj.runLABEL, '1')
subj.runLABEL = 'training';
subj.tasklabel = 'TrainEAT';
else
subj.runLABEL = 'tVNS';
subj.tasklabel = 'ExpEAT';
end

%Complete subj-struct
subj.subjectID = pad(subj.subjectID,6,'left','0');

subj.run = str2double(subj.runLABEL); %converts Run ID to integer
subj.num = str2double(subj.subjectID); %converts Subject ID to integer
subj.sess = str2double(subj.sessionID); %converts Session ID to integer

%save task version 
subj.runID = 'R1';
subj.task_version = 3;
subj.date = datestr(now,'yyyymmdd_HHMM');



% Load Conditions
    % for training run
if  strcmp(subj.runLABEL, 'training')
    
    cond_filename = sprintf('%s\\conditions\\cond_training_%s', pwd, subj.subjectID);
    maxfreq_filename = sprintf('%s\\data\\dummy_freq_estimate', pwd);
    
elseif strcmp(subj.runLABEL, 'tVNS')
    
    % for individual rand conditions (diff+incentive):
    cond_filename = sprintf('%s\\conditions\\cond_exp_%s', pwd, subj.subjectID);
    
    % for training purposes
    % cond_filename = sprintf('%s\\conditions\\cond_exp_75-85', pwd);
    
    
    % Load Maximum Frequency (always from Session 1, t1)
    
    %maxfreq_searchname = [[pwd '\data\effort_TUE001_training_' num2str(subj.num,'%02d') '_s1'] '*'];
    maxfreq_searchname = [pwd, '\data\TrainEAT_TUE001_',  subj.subjectID, '_S1', '*'];
    maxfreq_searchname = dir(maxfreq_searchname);
    maxfreq_filename = sprintf('%s\\data\\%s', pwd, maxfreq_searchname.name);

    %maxfreq_filename = sprintf('%s\\data\\effort_1_%02d_1   ', pwd, subj.num); 
    

end

load(maxfreq_filename, 'input');
load(cond_filename);

            
% Setup PTB with some default values
PsychDefaultSetup(1); %unifies key names on all operating systems


% Define colors
color.white = WhiteIndex(setup.screenNum); %with intensity value for white on second screen
color.grey = color.white / 2;
color.black = BlackIndex(setup.screenNum);
color.red = [255 0 0];
color.darkblue = [0 0 139];
color.royalblue = [65 105 225]; %light blue, above threshold
color.gold = [255,215,0];
color.scale_anchors = [205 201 201];

% Define the keyboard keys that are listened for. 
keys.escape = KbName('ESCAPE');%returns the keycode of the indicated key.
keys.resp = KbName('Space');
keys.left = KbName('LeftArrow');
keys.right = KbName('RightArrow');
keys.down = KbName('DownArrow');



% Open the screen
if setup.fullscreen ~= 1   %if fullscreen = 0, small window opens
    [w,wRect] = Screen('OpenWindow',setup.screenNum,color.white,[0 0 800 600]);
else
    [w,wRect] = Screen('OpenWindow',setup.screenNum,color.white, []);
end

% Get the center coordinates
[setup.xCen, setup.yCen] = RectCenter(wRect);

% Flip to clear
Screen('Flip', w);

% Query the frame duration                                       Wofür?
setup.ifi = Screen('GetFlipInterval', w);

% Query the maximum priority level - optional
setup.topPriorityLevel = MaxPriority(w);

%initialize counter
count_joy = 1;
count_jitter = 1;


%Setup ovrlay screen
effort_scr = Screen('OpenOffscreenwindow',w,color.white);
Screen('TextSize',effort_scr,16);
Screen('TextFont',effort_scr,'Arial');

setup.ScrWidth = wRect(3) - wRect(1);
setup.ScrHeight = wRect(4) - wRect(2);

% Key Press settings    
KbQueueCreate();
KbQueueFlush(); 
KbQueueStart();
[b,c] = KbQueueCheck;

VAS_rating_duration = 2.8;
VAS_time_limit = 1;

%% Stimulus settings

%Draw Thermometer
%rescale screen_height to scale_height
Tube.width = round(setup.ScrWidth * .20);
Tube.offset = round((setup.ScrHeight - (setup.ScrHeight * .95)) * .35);
Tube.height = round(Tube.offset+setup.ScrHeight/4);

Ball.width = round(setup.ScrWidth * .12);

%Reward details
Coin.width = round(setup.ScrWidth * .15);



%Drawing parameters 
output.resp = 0; %Updated by exponential weighting
freq_interval=1; % Frequency estimation interval 1 sec

maxfreq_estimate = 5.5; % numerator of narmalising factor. Should be updated after task piloting
%input.maxFrequency = 5.5; %Dummy for MaxFreq estimation, updated before trial start if do_training==1 
%input.percentFrequency = 85; %Dummy for MaxFreq estimation, updated before trial start with values from condition sheet

draw_frequency_normalize = maxfreq_estimate/input.maxFrequency; %
draw_frequency_factor = Tube.height*0.3 * draw_frequency_normalize; %value normalied to tube height, to have a nice ball movement using the full screen
draw_frequency = 0; %Ball position dependent on output/phantom frequency, initially ball at bottom 


text_Cont = ['Weiter mit Mausklick.'];


%First task start
if strcmp(subj.runLABEL, 'training') 

    %Instruction text                                               
    text = ['Willkommen. \n\nDies ist ein einfaches Spiel, bei dem Sie um Geld und ein Frühstück spielen.\nSie können sich zunächst mit den Funktionen vertraut machen und ein bisschen üben. Das eigentliche Spiel wird dann zu einem späteren Zeitpunkt starten.'];
    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
    Screen('Flip',w);

    GetClicks(setup.screenNum);
      

%%=========================
%%     Do Training
%%=========================

%Set do_training 0 for skipping
do_training = 1;
%If skipping training: need Dummy Input = 6

    if do_training == 1
     input.maxFrequency=[];
     EffortAllocation_Training
    end

end
%%========================
%%    1 Trial effort    
%%========================
%load VAS-jitters
if strcmp(subj.runLABEL, 'training') 
    
    jitter_filename = sprintf('%s\\jitters\\DelayJitter_mu_0.70_max_4_trials_16.mat', pwd);
    
else
    
    jitter_filename = sprintf('%s\\jitters\\DelayJitter_mu_0.70_max_4_trials_96.mat', pwd);
    
end
    
load(jitter_filename);
jitter = Shuffle(DelayJitter);


%Reset values
if strcmp(subj.runLABEL, 'tVNS')
    
  %load MaxFreq from Training Session1
    maxfreq_searchname = [pwd, '\data\TrainEAT_TUE001_',  subj.subjectID, '_S1', '*'];
    maxfreq_searchname = dir(maxfreq_searchname);
    maxfreq_filename = sprintf('%s\\data\\%s', pwd, maxfreq_searchname.name);   
    load(maxfreq_filename, 'input');
end



%Initialise exponential weighting
forget_fact = 0.6;
prev_weight_fact = 0;
prev_movingAvrg = 0;
t_button = 0;
current_input = 0; 
Avrg_value = 0;
frequency_estimate=0;
draw_frequency = 0;

collect_freq.t_button_interval  = []; %stores current_input (t2-t1)
collect_freq.avrg               = []; %stores weighted interval value of a click

i_resp = 1;
i_phantom = 1;

t_button_vec = [nan];
frequency_vector = [nan]; %stores weighted interval value of a click

i_step = 1;
t_100_vector = [];
frequency_t100_vector = [];

output.t_button = []; % stores clicks: timestamp
output.t_button_referenced = []; %referenced to t_trial_onset
output.frequency_button = [];
output.values_per_trial = []; %Matrix of output values Button press referenced
output.values_per_trial_t100 = []; %Matrix of output values / timepoint referenced (every 100ms)
output.t_100 = []; %Timestamp every 100ms
output.frequency_t100 = []; %Frequency every 100 ms

%Payout calculation
flag = 0; %1 if frequency exceeds MaxFrequency
exceed_onset = 0; %Time point of ball exceding threshold

t_payout = [nan; nan]; %collects all t1/t2 in one trial
i_payout_onset = 1;

output.t_payout = []; %collects all t1/t2 across all trials
output.payout_per_trial = 0;
output.t_payout_calories = 0;

%Payout display (Counter visible during trial)
win_coins = nan;
win_cookies = nan;
payout.diff = [nan nan]';
payout.counter = 0;
payout.win = 0;

%Trial counter CHANGE TO 30 IN EXPERIMENT
trial_length = 30; %seconds




%Text before Trial-Block
if strcmp(subj.runLABEL, 'training') 
    text = ['Jetzt üben Sie die eigentliche Aufgabe: \nDie Linie wird sich nun nicht mehr mit dem Ball bewegen.\n\nVersuchen Sie mithilfe des Tastendrucks den Ball nach oben und über eine rote Linie zu bewegen. Sie können Punkte gewinnen für jede volle Sekunde, die der Ball über der roten Linie bleibt. Sie können erkennen, dass Sie etwas gewinnen, wenn der Ball seine Farbe zu hellblau ändert.'];
        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', setup.ScrHeight/5, color.black,60, [], [], 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
        Screen('Flip',w);
        GetClicks(setup.screenNum);
else
    text = ['Wir beginnen nun mit dem Spiel, das Sie vorhin geübt haben. Zur Erinnerung: dies ist ein einfaches Spiel, bei dem Sie um Geld und ein Frühstück spielen.\n\nVersuchen Sie mithilfe des Tastendrucks den Ball nach oben und über eine rote Linie zu bewegen. Sie können Punkte gewinnen für jede volle Sekunde, die der Ball über der roten Linie bleibt. Sie können erkennen, dass Sie etwas gewinnen, wenn der Ball seine Farbe zu hellblau ändert.'];
        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', setup.ScrHeight/5, color.black,60, [], [], 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
        Screen('Flip',w);
        GetClicks(setup.screenNum);

      text = ['Der Unterschied zur Übung vorhin ist, dass wir gleichzeitig zur Aufgabe die Vagusnerv-Stimulation am Ohr durchführen. Jeder Durchgang wird zusammen mit der Stimulation von der Versuchsleitung gestartet.'];
        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', setup.ScrHeight/5, color.black,60, [], [], 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
        Screen('Flip',w);
        GetClicks(setup.screenNum);  
end   


 text = ['Sie können in den einzelnen Durchgängen unterschiedliche Gewinne erhalten. Sie spielen dabei sowohl für Geld als auch für Kalorien, die Sie im Anschluss an die Aufgabe für ein Frühstück eintauschen können. Was die aktuelle Belohnung ist bleibt für einen Durchgang von 30 Sekunden konstant und wird Ihnen mit Hilfe von Bildern angezeigt.'];
    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', setup.ScrHeight/5, color.black,60, [], [], 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum);   
    
% load and show incentives
[img.incentive_coins1, img.map, img.alpha] = imread('incentive_coins1.jpg');
[img.incentive_coins10, img.map, img.alpha] = imread('incentive_coins10.jpg');
[img.incentive_cookies1, img.map, img.alpha] = imread('incentive_cookies1.jpg');
[img.incentive_cookies10, img.map, img.alpha] = imread('incentive_cookies10.jpg');

stim.incentive_coins1 = Screen('MakeTexture', w, img.incentive_coins1);
stim.incentive_coins10 = Screen('MakeTexture', w, img.incentive_coins10);
stim.incentive_cookies1 = Screen('MakeTexture', w, img.incentive_cookies1);
stim.incentive_cookies10 = Screen('MakeTexture', w, img.incentive_cookies10);

text_coins1 = ['1 Geld-Punkt pro Sekunde'];
text_coins10 = ['10 Geld-Punkte pro Sekunde'];
text_cookies1 = ['1 Essens-Punkt pro Sekunde'];
text_cookies10 = ['10 Essens-Punkte pro Sekunde'];


text_instr =  ['In manchen Durchgängen können Sie Geld-Punkte gewinnen. Im Anschluss an die Aufgabe bekommen Sie den entsprechenden Geldbetrag ausgezahlt.\n\nFolgende Bedingungen gibt es:'];
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_instr, 'center', setup.ScrHeight/5, color.black,60, [], [], 1.2);
        
        Screen('DrawTexture', w, stim.incentive_coins1,[], [(setup.xCen*0.7) ((setup.ScrHeight/5)*2.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) ((setup.ScrHeight/5)*2.9)])
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_coins1, setup.xCen, ((setup.ScrHeight/5)*3.2-Coin.width/2), color.black,40, [], [], 1.2);
        
        Screen('DrawTexture', w, stim.incentive_coins10,[], [(setup.xCen*0.7) ((setup.ScrHeight/5)*3.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) ((setup.ScrHeight/5)*3.9)])
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_coins10, setup.xCen, ((setup.ScrHeight/5)*4.2-Coin.width/2), color.black,40, [], [], 1.2);
        

        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
        time.img = Screen('Flip', w);    
        
        GetClicks(setup.screenNum);         
        
text_instr =  ['In manchen Durchgängen können Sie Kalorien gewinnen. Im Anschluss an die Aufgabe bekommen Sie eine entsprechend große Portion Frühstück. \n\nFolgende Bedingungen gibt es:'];
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_instr, 'center', setup.ScrHeight/5, color.black,60, [], [], 1.2);   
        
        Screen('DrawTexture', w, stim.incentive_cookies1,[], [(setup.xCen*0.7) ((setup.ScrHeight/5)*2.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) ((setup.ScrHeight/5)*2.9)])
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_cookies1, setup.xCen, ((setup.ScrHeight/5)*3.2-Coin.width/2), color.black,40, [], [], 1.2);
        
        Screen('DrawTexture', w, stim.incentive_cookies10,[], [(setup.xCen*0.7) ((setup.ScrHeight/5)*3.9-Coin.width*0.6) (setup.xCen*0.7+Coin.width*0.6) ((setup.ScrHeight/5)*3.9)])
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_cookies10, setup.xCen, ((setup.ScrHeight/5)*4.2-Coin.width/2), color.black,40, [], [], 1.2);

        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2); 
        time.img = Screen('Flip', w);    
        
        GetClicks(setup.screenNum); 

text = ['Die Umrechnung der Punkte richtet sich nach folgendem Kurs:  \n5 Geld-Punkte entsprechen 1 cent.\n\n5 Essens-Punkte entsprechen 1 kcal.\n\nIm Anschluss an die Aufgabe können Sie die Geldpunkte in einen entsprechenden Geldbetrag eintauschen und für die Essens-Punkte ein entsprechendes Frühstück erhalten.'];
    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', setup.ScrHeight/5, color.black,60, [], [], 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum); 
        
text = ['Im Verlaufe des Experiments wird es unterschiedliche Schwierigkeitsstufen geben. Es wird also nicht immer möglich sein, den Ball die ganze Zeit über vollständig über der Linie zu halten. Eine Möglichkeit damit umzugehen ist, auch während eines Durchgangs Pausen zu machen um danach wieder schneller drücken zu können.'];
    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', setup.ScrHeight/5, color.black,60, [], [], 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum); 
    
text = ['Nach jedem Durchgang werden Ihnen nacheinander zwei Fragen angezeigt:\n\n' char(39) 'Wie stark haben Sie sich in diesem Durchgang verausgabt?' char(39) ' \n ' char(39) 'Wie sehr wollten Sie die Belohnung in diesem Durchgang erhalten?' char(39) '\n\nSie können zum antworten den Regler auf einer Skala (überhaupt nicht - sehr) verschieben. Nutzen Sie dazu bitte den linken Joystick auf dem Controller. Ihre Antwort müssen Sie dann mit der grünen A-Taste auf dem Controller bestätigen.\nBitte beachten Sie, dass Sie für die Antworten nur eine begrenzte Zeit zur Verfügung haben. Überlegen Sie deshalb nicht zu lange, sondern antworten Sie spontan. Es gibt dabei kein ' char(39) 'Richtig' char(39) ' oder ' char(39) 'Falsch' char(39) '.'];
    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', setup.ScrHeight/5, color.black,60, [], [], 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum); 
    
if strcmp(subj.runLABEL, 'training') 
    
    text = ['Die nun folgende Übungsphase wird ca. 5 Minuten dauern.\nSollten Sie noch Fragen haben, können Sie diese jetzt stellen.\nWenn Sie sich bereit fühlen, können wir jetzt mit dem Experiment beginnen.'];

elseif strcmp(subj.runLABEL, 'tVNS') 
    
    text = ['Das gesamte Experiment wird ca. 40 Minuten dauern.\nSollten Sie noch Fragen haben, können Sie diese jetzt stellen.\nWenn Sie sich bereit fühlen, können wir jetzt mit dem Experiment beginnen.'];
    
end
    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
    Screen('Flip',w);
    GetClicks(setup.screenNum);


%% Experimental procedure
%  Loop while conditions pending

for i_trial = 1:length(conditions) %Condition sheet determines repetitions
    
    if i_trial == ((length(conditions)/2) + 1) %After half of the trials enable short break
        
        if strcmp(subj.runLABEL, 'training') 
         text = ['Sie haben jetzt die Hälfte geschafft. Sie können eine kleine Pause machen und sich lockern.'];          
        else
         text = ['Sie haben jetzt die Hälfte geschafft. Sie können eine kleine Pause machen und sich lockern. Die Stimulation bleibt währenddessen aktiv.'];
        end
        
         Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', setup.ScrHeight/5, color.black,60, [], [], 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
        Screen('Flip',w);
        GetClicks(setup.screenNum);  
    end
    
     % Manual trigger together with NEMOS tVN-Stimulation
      fix = ['+'];
      Screen('TextSize',w,64);
      Screen('TextFont',w,'Arial');
      [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', color.black,80);
      time.fix = Screen('Flip', w);
      
     GetClicks(setup.screenNum);
    
     
    %Update Conditions trialwise
    input.percentFrequency = input.maxFrequency * (conditions(i_trial, 1) * 0.01); % 75% or 85%
    input.incentive = conditions(i_trial, 2); %1 = Money, 2 = Food
    input.value = conditions(i_trial, 3); % 1 or 10
              
    % load incentive & counter icon
    if input.incentive == 1 && input.value == 1
       incentive = stim.incentive_coins1;
        [img.winCounter, img.map, img.alpha] = imread('singlecoin.jpg');
    elseif input.incentive == 1 && input.value == 10
       incentive = stim.incentive_coins10;
        [img.winCounter, img.map, img.alpha] = imread('singlecoin.jpg');
    elseif input.incentive == 2 && input.value == 1
       incentive = stim.incentive_cookies1;
        [img.winCounter, img.map, img.alpha] = imread('singlecookie.jpg');
    elseif input.incentive == 2 && input.value == 10
       incentive = stim.incentive_cookies10;
        [img.winCounter, img.map, img.alpha] = imread('singlecookie.jpg');
    end
 
    % load single-coin/single-cookie picture for Counter
    stim.winCounter = Screen('MakeTexture', w, img.winCounter);
    
    % Draw incentive
    Screen('DrawTexture', w, incentive,[], [((setup.xCen-Tube.width)-Coin.width) (setup.ScrHeight/4) (setup.xCen-Tube.width) (setup.ScrHeight/4+Coin.width)]); 
    time.img = Screen('Flip', w);
    
    WaitSecs(1); %Show screen for 1s

    
    t_trial_onset = GetSecs;
    t_buttonN_1 = t_trial_onset;
    
   

    while (trial_length > (GetSecs - t_trial_onset))       %Trial-length 30sec
        
         %routine for timestamps every 100ms
         t_step = GetSecs;
         if ((0.1 * i_step) <= (t_step - t_trial_onset))
            
            t_100_vector(1,i_step) = t_step;
            frequency_t100_vector(1,i_step) = draw_frequency;
            
            i_step = i_step + 1;
         end
         
       
          % Draw Tube
            Screen('DrawLine',effort_scr,color.black,(setup.xCen-Tube.width/2), Tube.height, (setup.xCen-Tube.width/2), (setup.ScrHeight-Tube.offset),6);
            Screen('DrawLine',effort_scr,color.black,(setup.xCen+Tube.width/2), Tube.height, (setup.xCen+Tube.width/2), (setup.ScrHeight-Tube.offset),6);
            Screen('DrawLine',effort_scr,color.black,(setup.xCen-Tube.width/2), (setup.ScrHeight-Tube.offset), (setup.xCen+Tube.width/2), (setup.ScrHeight-Tube.offset),6);
          
            Screen('DrawTexture', effort_scr, incentive,[], [((setup.xCen-Tube.width)-Coin.width) (setup.ScrHeight/4) (setup.xCen-Tube.width) (setup.ScrHeight/4+Coin.width)]);
            Screen('CopyWindow',effort_scr,w);
          
          % Draw Max% line
            Threshold.yposition = (setup.ScrHeight-Tube.offset-(input.percentFrequency * draw_frequency_factor));
            Screen('DrawLine',w,color.red,(setup.xCen-Tube.width/2), Threshold.yposition, (setup.xCen+Tube.width/2), Threshold.yposition,3);

          % Show incentive counter
            Screen('DrawTexture', w, stim.winCounter,[], [(setup.xCen*1.5-(size(img.winCounter,2)*0.3)) (setup.ScrHeight/6-(size(img.winCounter,1)*0.3)) (setup.xCen*1.5) (setup.ScrHeight/6)]);
            
            text = [' x ' num2str(payout.win, '%02i')];
                   Screen('TextSize',w,56);
                   Screen('TextFont',w,'Arial');
                   [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, setup.xCen*1.5, (setup.ScrHeight/6), color.black);
            
            
            
          % Draw Ball
            Ball.position = [(setup.xCen-Ball.width/2) ((setup.ScrHeight-Tube.offset-Ball.width)-(draw_frequency * draw_frequency_factor)) (setup.xCen+Ball.width/2) ((setup.ScrHeight-Tube.offset)-(draw_frequency * draw_frequency_factor))];

            if (Ball.position(1,4) < Threshold.yposition) %Ball above threshold 
                
                Ball.color = color.royalblue;
                
%                 if (flag == 1)
%                     continue
                    
                if (flag == 0)
                    
                    flag = 1;                    
                    exceed_onset = GetSecs;
                    t_payout(1,i_payout_onset) = exceed_onset;
                                   
                end
                
                % Calculate payoff for exceed_Threshold:
                %If ball above threshold, need phantom value to update
                %reward counter
                t_payout(3,i_payout_onset) = GetSecs;

                payout.diff = t_payout(3,1:end) - t_payout(1,1:end);
                payout.counter = nansum(payout.diff);
                  %Payout: counter only for seconds, exchange rate computed
                  %internally
%                 if input.value == 1
                   payout.win = floor(payout.counter); 
%                elseif input.value == 10
%                    payout.win = (floor(payout.counter) * 10);
%                 end

                    
            else    %Ball below threshold    
                
                 Ball.color = color.darkblue;
                 
%                  if (flag == 0)
%                      continue
                     
                 if (flag == 1)
                     
                     flag = 0;
                     exceed_offset = GetSecs;
                     t_payout(2,i_payout_onset) = exceed_offset;
                     
                     i_payout_onset = i_payout_onset + 1;
                                       
                 end  
                 
                 %For last trial
               
                % Calculate payoff for exceed_Threshold:
                %If ball above threshold, need phantom value to update
                %reward counter
%                 payout.diff = t_payout(2,1:end) - t_payout(1,1:end);
%                 payout.counter = nansum(payout.diff); 
%                 payout.win = floor(payout.counter);
                
            end  
            
                Screen('FillOval',w,Ball.color,Ball.position);
                Screen('Flip', w);
             
                
             
                
                       
            [b,c] = KbQueueCheck;  
            
            
            %If experiment is run with GamePad
            if do_gamepad == 1
                
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
                 
                %Buffer routine
                for buffer_i = 2:50 %buffer_size
                    
                %continuously log position and time of the button for the right index
                %finger Joystick.Z
                %[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
                joy.pos_Z(count_joy,i_trial) = Joystick.Z;
                joy.time_log(count_joy,i_trial) = GetSecs - t_trial_onset;
                count_joy = count_joy + 1;
                
                    if Joystick.Z < 200
                        Joystick.RI_button = 1;
                    else
                        Joystick.RI_button = 0;
                    end
                    xbox_buffer(buffer_i) = Joystick.RI_button; %Joystick.Button(1);
                    if xbox_buffer(buffer_i)==1 && xbox_buffer(buffer_i-1)==0
                        count_joystick = 1;
                        %Stores time stamp of BP
                        t_button = GetSecs; 
                    else
                        count_joystick = 0;
                    end
                    if buffer_i == 50
                        buffer_i = 2;
                        xbox_buffer(1)=xbox_buffer(50);
                    end

        %Frequency estimation based on Button Press            
        if c(keys.resp) > 0 || count_joystick == 1
            % resp=resp+1;
%              if c(keys.resp) > 0
%                  
%                 t_button = c(keys.resp);
                                
                if (t_button > (t_trial_onset + 0.1)) %Prevents too fast button press at the beginning
                    
                    t_button_vec(1,i_resp) = t_button;
                      
                    %Exponential weightended Average of RT for frequency estimation
                    current_input = t_button - t_buttonN_1;
                    current_weight_fact = forget_fact * prev_weight_fact + 1;
                    Avrg_value = (1-(1/current_weight_fact)) * prev_movingAvrg + ((1/current_weight_fact) * current_input);
                    frequency_estimate = freq_interval/Avrg_value;
                    
                    
                    %update Ball height and store frequency for output
                    draw_frequency = frequency_estimate; 
                    frequency_vector(1,i_resp) = frequency_estimate;
                    
                    %Refresh values
                    prev_weight_fact = current_weight_fact; 
                    prev_movingAvrg = Avrg_value;
                    t_buttonN_1 = t_button;

                    collect_freq.avrg(1,i_resp) = Avrg_value;
                    collect_freq.t_button_interval(1,i_resp) = current_input;

                    i_resp = i_resp + 1;
                    count_joystick = 0;

                end

             
             %if no button press happened: Frequency should decrease slowly based on phantom estimates   
             elseif (GetSecs - t_buttonN_1) > (1.5 * Avrg_value) && (i_resp > 1);

                    phantom_current_input = GetSecs - t_buttonN_1;
                    current_weight_fact = forget_fact * prev_weight_fact + 1;
                    Estimate_Avrg_value = (1-(1/current_weight_fact)) * prev_movingAvrg + ((1/current_weight_fact) * phantom_current_input);
                    phantom.freq = freq_interval/Estimate_Avrg_value;
                    
                    %update Ball height
                    draw_frequency = phantom.freq; 

                    %Refresh values in phantom output vector
                    prev_weight_fact = current_weight_fact; 
                    prev_movingAvrg = Estimate_Avrg_value;
                   % t_buttonN_1 = t_button; %Not necessary for phantom count, Last key press remains unchanged 
                       % output.t_button(1,output_index) = t_button;
                        phantom.avrg(1,i_phantom) = Avrg_value;
                        phantom.t_button_interval(1,i_phantom) = current_input;
                        phantom.frequency(1,i_phantom) = phantom.freq; 
                        
                        
                        i_phantom = i_phantom + 1;

            end
              
                end
         
            end
            
         
            
    end
            
    count_joy = 1;
    end_of_trial = GetSecs;
    
    if (flag == 1)
        
        t_payout(2,i_payout_onset) =  end_of_trial;
    end
    
% catch empty trial
% test = (isempty(frequency_vector));
% if test == 1
%     
%     t_payout = [nan; nan];
%     frequency_vector = [nan];
%     t_button_ref_vec = [nan];
%     
%     
% end

% Calculate payoff for exceed_Threshold
exc_thresh_this_trial = t_payout(2,1:end)-t_payout(1,1:end);
   


% Calculate win for this trial
if input.incentive == 1 && input.value == 1
    win_coins = floor(nansum(exc_thresh_this_trial));
elseif input.incentive == 2 && input.value == 1
    win_cookies = floor(nansum(exc_thresh_this_trial));    
elseif input.incentive == 1 && input.value == 10
    win_coins = floor(nansum(exc_thresh_this_trial)) * 10;
elseif input.incentive == 2 && input.value == 10
    win_cookies = floor(nansum(exc_thresh_this_trial)) * 10;
end



output.t_payout = [output.t_payout, t_payout(1:2,1:end)];   
output.payout_per_trial(1,i_trial) = win_coins;
output.payout_per_trial(2,i_trial) = win_cookies;
output.payout_per_trial(3,i_trial) = input.incentive;
output.payout_per_trial(4,i_trial) = input.value;



%%==============call VAS_exhaustion_wanting===================

trial.question = 'exhausted';

Effort_VAS

output.rating_exhaustion_runstart(1,i_trial) = startTime; %Start time of rating
output.rating_exhaustion(1,i_trial) = rating;
output.rating_exhaustion_label{1,i_trial} = rating_label;
output.rating_exhaustion_subm(1,i_trial) = rating_subm;
output.rating_exhaustion_t_button(i_trial,5) = t_rating_ref; %Time of rating submission


%Reset variables
rating = nan;
rating_label = nan;
rating_subm = nan;



trial.question = 'wanted';

Effort_VAS

output.rating_wanting_runstart(1,i_trial) = startTime; %Start time of rating
output.rating_wanting(1,i_trial) = ((Slider_x_pos - (setup.ScrWidth/2-Scale_width/2))/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
output.rating_wanting_label{1,i_trial} = text_freerating;
output.rating_wanting_subm(1,i_trial) = 1;
output.rating_wanting_t_button(i_trial,5) = t_rating_ref; %Time of rating submission
  

%Reset variables
rating = nan;
rating_label = nan;
rating_subm = nan;


%%==============call feedback===================   

%If no VAS: Show feedback
%effort_feedback


%%==============for training: update Max Frequency====
if strcmp(subj.runLABEL, 'training') && (subj.sess ==1)
    
    if length(frequency_vector) == 0

        collectMax.next = nan;
        
    else
        
        collectMax.next = max(frequency_vector);
        
    end 
    
        collectMax.maxFreq(1,i_collectMax) = collectMax.next;
        i_collectMax = i_collectMax + 1;
    
end



%%=======Prepare Output=========================
%Reference t_Button to trial_start 
t_button_ref_vec = t_button_vec - t_trial_onset;


%Copy Output Values into Output Matrix
output.values_per_trial = [output.values_per_trial, [ones(1,length(frequency_vector)) * subj.num ; ...  %Subj_ID
                           ones(1,length(frequency_vector)) * input.maxFrequency; ...                   %MaxFrequency
                           ones(1,length(frequency_vector)) * i_trial ; ...                             %Trial_ID
                           ones(1,length(frequency_vector)) * conditions(i_trial, 1); ...               %Difficulty in %
                           (1:length(frequency_vector)) ; ...                                           %t_Button ID
                           t_button_ref_vec ; ...                                                       %t_Button referenced to trial start
                           frequency_vector ; ...                                                       %Frequency at t_Button
                           ones(1,length(frequency_vector)) * conditions(i_trial,2); ...                %Cond.incentive 1= Money, 2= Food
                           ones(1,length(frequency_vector)) * conditions(i_trial,3);   ...              %Cond.value 1 / 10 per Sec
                           ones(1,length(frequency_vector)) * output.payout_per_trial(1,i_trial); ...   %payout: Money
                           ones(1,length(frequency_vector)) * output.payout_per_trial(2,i_trial); ...   %payout: Food
                           ones(1,length(frequency_vector)) * output.rating_exhaustion(i_trial); ...    %VAS Rating exhaustion
                           ones(1,length(frequency_vector)) * output.rating_wanting(i_trial)]];         %VAS Rating wanting

t_100_ReftoTrialStart = t_100_vector - t_trial_onset;                       
output.values_per_trial_t100 = [output.values_per_trial_t100, [ones(1,length(t_100_vector)) * subj.num ; ...  %Subj_ID
                           ones(1,length(t_100_vector)) * input.maxFrequency; ...                   %MaxFrequency
                           ones(1,length(t_100_vector)) * i_trial ; ...                             %Trial_ID
                           ones(1,length(t_100_vector)) * conditions(i_trial, 1); ...               %Difficulty in %
                           t_100_vector; ...                                                        %Timestamps every 100ms
                           t_100_ReftoTrialStart; ...                                               %Timestamps referenced to trial start
                           frequency_t100_vector; ...                                               %Estimated frequency at t100
                           ones(1,length(t_100_vector)) * conditions(i_trial,2); ...                %Cond.incentive 1= Money, 2= Food
                           ones(1,length(t_100_vector)) * conditions(i_trial,3);   ...              %Cond.value 1 / 10 per Sec
                           ones(1,length(t_100_vector)) * output.payout_per_trial(1,i_trial); ...   %payout: Money
                           ones(1,length(t_100_vector)) * output.payout_per_trial(2,i_trial); ...   %payout: Food
                           ones(1,length(t_100_vector)) * output.rating_exhaustion(i_trial); ...    %VAS Rating exhaustion
                           ones(1,length(t_100_vector)) * output.rating_wanting(i_trial)]];         %VAS Rating wanting
                        
                       
output.t_button = [output.t_button, t_button_vec];
    t_button_vec = [];

output.frequency_button = [output.frequency_button, frequency_vector];
    frequency_vector = [];

output.t_button_referenced = [output.t_button_referenced, t_button_ref_vec];
    t_button_ref_vec = [nan];
    
 output.t_100 = [output.t_100, t_100_vector];
    t_100_vector = [];
    
output.frequency_t100 = [output.frequency_t100, frequency_t100_vector];
    frequency_t100_vector = [];                      

%create temporary storage
%output.filename = sprintf('%s\\data\\effort_%s_%s_%s_s%s_temp', pwd, subj.studyID, subj.runLABEL, subj.subjectID, subj.sessionID);
output.filename = sprintf('%s\\data\\%s_%s_%s_S%s_%s_temp', pwd, subj.tasklabel, subj.studyID, subj.subjectID, subj.sessionID, subj.runID);
save([output.filename '.mat'], 'output', 'subj', 'input', 'joy', 'conditions', 'jitter')
    

%%=========Clear Variables
t_payout = [nan; nan];
i_payout_onset = 1;
i_payout_offset = 1;

t_trial_onset = nan;
t_buttonN_1 = 0;
t_button = 0;

draw_frequency = 0; %resets ball position
input.percentFrequency = 0;

current_input = 0;
current_weight_fact = 0;
Avrg_value = 0;
frequency_estimate = 0;
prev_weight_fact = 0; 
prev_movingAvrg = 0;


collect_freq.avrg = [];
collect_freq.t_button_interval = [];


phantom_current_input = 0;

Estimate_Avrg_value = 0;
phantom.freq = 0;

phantom.avrg = [];
phantom.t_button_interval = [];
phantom.frequency = []; 

exc_thresh_this_trial = 0;
payout.win = 0;
win_coins = nan;
win_cookies = nan;
i_phantom = 1;

i_resp = 1;
count_joystick = 0;

i_step = 1;

flag = 0;
end_of_trial = 0;


end

if strcmp(subj.runLABEL, 'training') 
    
    input.maxFrequency = max(collectMax.maxFreq);
    
end

       %%Compute win
       win_sum_coins = floor(nansum(output.payout_per_trial(1,3:end)));
       win_sum_cookies = floor(nansum(output.payout_per_trial(2,3:end)));
       
       if strcmp(subj.runLABEL, 'training') 
        
            text = ['Die Übung ist nun zu Ende. Im richtigen Spiel hätten Sie \n' num2str(win_sum_coins) ' Geld-Punkte und\n' num2str(win_sum_cookies) ' Essens-Punkte gewonnen.'];
 
       elseif strcmp(subj.runLABEL, 'tVNS') 
           
            text = ['Das Spiel ist nun zu Ende.\n Sie gewinnen ' num2str(win_sum_coins) ' Punkte in Euro.\nSie gewinnen ' num2str(win_sum_cookies) ' Punkte in Kcal. \n\nVielen Dank für die Teilnahme!'];
            
       end
       
            Screen('TextSize',w,32);
            Screen('TextFont',w,'Arial');
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', setup.ScrHeight/5, color.black,60, [], [], 1.2);
            Screen('Flip',w);
            WaitSecs(1.5);
            GetClicks(setup.screenNum);



KbQueueRelease();
           




% Create Output Format
%  Suj_ID  /  Trial_ID  /  difficulty(%) / t_Button_Index  /  t_Button(ref_to_trialStart  /
%  Frequency_at_t_Button / VAS_exhaustion / VAS_wanting
output.values_per_trial_flipped = output.values_per_trial';
output.values_per_trial_t100_flipped = output.values_per_trial_t100';

%%Store output
output.time = datetime;
output.filename = sprintf('%s_%s_%s_S%s_%s_%s', subj.tasklabel, subj.studyID, subj.subjectID, subj.sessionID, subj.runID, datestr(now, 'yymmdd_HHMM'));

save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'input', 'joy', 'conditions', 'jitter');
save(fullfile('Backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));




temp.filename = sprintf('%s\\data\\%s_%s_%s_S%s_%s_temp', pwd, subj.tasklabel, subj.studyID, subj.subjectID, subj.sessionID, subj.runID);
delete([temp.filename '.mat']);

GetClicks(setup.screenNum);
Screen('CloseAll');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%