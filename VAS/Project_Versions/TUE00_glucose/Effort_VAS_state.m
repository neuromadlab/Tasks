%%===================Effort VAS============================================
% Script for VAS 
% author: Monja P. Neuser, Nils B. Kroemer

% input via XBox USB-Controller

% Project Version for TUE008 (Corinna Schulz, Dec 2021:
% New since TUE007: no Jitter
% TUE008: No caloric load question anymore, no shake/water shown  
%==========================================================================

%% Preparation

% Clear workspace
close all;
clear all; 
sca;

Screen('Preference', 'SkipSyncTests', 2);

% Change settings
% Basic screen setup 
setup.screenNum = max(Screen('Screens')); %secondary monitor if there is one connected
setup.fullscreen = 1; %if 0 -> will create a small window ideal for debugging, set =1 for Experiment

do_gamepad = 1; %do not set to 0, this is not implemented yet
xbox_buffer = zeros(1,50); %will buffer the history of 50 button press status

%debug for piloting
setup.debug = 1; %for pilot condition files else == 0

%Load condition file (shake vs. water randomization)
if setup.debug == 1
    load('C:/Users/User/SynologyDrive/Projects/TUE009_DFG_Glucose_RPE/06_Participants/Randomizations/TUE009_randomized_conditions_pilot.mat');
else
    load('C:/Users/User/SynologyDrive/Projects/TUE009_DFG_Glucose_RPE/06_Participants/Randomizations/TUE009_randomized_conditions.mat');
end

%%get input from the MATLAB console
subj.study = 'TUE009';
subj.subjectID = input('Subject ID: [6 digits] ','s');
subj.sessionID = input('Session [0/1/2/3/4/5/6]: ','s');
subj.sessionID = num2str(str2double(subj.sessionID) + 1);
%behavioral sessions --> 2 VAS beginning and end
%fmri --> 3 VAS beginning, after scan, after Müsli 
if str2double(subj.sessionID) < 6
    subj.tID = input('timepoint [1 2]: ','s');
    do_gamepad = 1;
else 
    subj.tID = input('timepoint [1 2 3]: ','s');
    do_gamepad = 0;
end

%rate shake/water before (VAS1) and after scan (VAS2) on fmri days

if str2double(subj.sessionID) > 5 && str2double(subj.tID) < 3
    
    subj.caloricLoad = TUE009_conditions.Caloric_Cond(TUE009_conditions.ID==str2double(subj.subjectID)&TUE009_conditions.Session_Nr==(str2double(subj.sessionID)-5));
    
    if subj.caloricLoad == 1
        i_rep = input('Today the caloric load condition is milkshake [y/n] ','s');
        if strcmp(i_rep,'n')
            disp('Condition not congruent')
            return
        end
        subj.shake = input('Shake flavor (1 = strawb.,2 = choc.,3=car.): \n');
    else
        i_rep = input('Today the caloric load condition is water [y/n] ','s');
        if strcmp(i_rep,'n')
            disp('Condition not congruent')
            return
        end
        subj.shake = 4;
    end
    
   
else 
    subj.caloricLoad = NaN;
    subj.shake = NaN;
end

subj.id = str2double(subj.subjectID);   % converts Subject ID to integer
subj.sess = str2double(subj.sessionID); %converts Session ID to integer
subj.num = str2double(subj.subjectID); %converts Subject ID to integer
subj.t = str2double(subj.tID);
subj.date_start      = datestr(now);

% Load VAS settings (milkshape stimuli)
load([pwd filesep 'VASsettings_' subj.study '.mat'])
if do_gamepad == 1
findJoystick %runs script to check whether Joystick is at Handle 0 or 1 and corrects for it
end

% Select correct milchshake flavour
if subj.shake == 1
    shake_pic = settings.shake.strawberry;
elseif subj.shake == 2
    shake_pic = settings.shake.chocolate;
elseif subj.shake == 3
    shake_pic = settings.shake.caramel;
elseif subj.shake == 4
    shake_pic = settings.shake.water;
end

% set up folder for backups and final data
if ~exist([pwd, filesep, 'Backup'], 'dir')
    mkdir([pwd, filesep, 'Backup'])
end
if ~exist([pwd, filesep,'Data'], 'dir')
    mkdir([pwd, filesep, 'Data'])
end

% Setup PTB with some default values
PsychDefaultSetup(1); %unifies key names on all operating systems

% Define colors
color.white = WhiteIndex(setup.screenNum); %with intensity value for white on second screen
color.grey = color.white / 2;
color.black = BlackIndex(setup.screenNum);
color.red = [255 0 0];
color.scale_anchors = color.black;

% Define the keyboard keys that are listened for. 
keys.escape = KbName('ESCAPE');%returns the keycode of the indicated key.
keys.resp = KbName('Space');
keys.left = KbName('LeftArrow');
keys.right = KbName('RightArrow');
keys.down = KbName('DownArrow');

% Since TUE007 VAS: no jitter, only equal waiting length 
waiting_duration = 0.7; %0.7s waiting between stimuli presentation

% Open the screen
if setup.fullscreen ~= 1   %if fullscreen = 0, small window opens
    [w,wRect] = Screen('OpenWindow',setup.screenNum,color.white,[0 0 800 600]);
else
    [w,wRect] = Screen('OpenWindow',setup.screenNum,color.white, []);
end 

% Create milkshake texture
if exist('shake_pic','var')
texture.shake = Screen('MakeTexture',w,shake_pic);
end

settings.lang_de = 1;
% Get the center coordinates
[setup.xCen, setup.yCen] = RectCenter(wRect);
[ww, wh] = Screen('WindowSize', w);
Scr_Width = wRect(3) - wRect(1); 
% Image sacling according to screen settings 
% window width: ww, and window height: wh
scale_x = ww/1024;
scale_y = wh/768;
x_cent = ww/2;
y_cent = wh/2;

% Flip to clear
Screen('Flip', w);

% Query the frame duration                                       Wofür?
setup.ifi = Screen('GetFlipInterval', w);

% Query the maximum priority level - optional
setup.topPriorityLevel = MaxPriority(w);


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

text_Cont = ['Weiter mit Mausklick.'];

%% Caloric Load & State Questions

%Instruction text I
text1 = ['Willkommen. \n\n Im Folgenden werden Sie einige Fragen zu Ihrem aktuellen Befinden beantworten.'];
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text1, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 60, [], [], 1.2);
Screen('Flip',w);
GetClicks(setup.screenNum);

%Instruction text II                                               
if do_gamepad == 1
text = ['Um Ihre Antworten einzugeben können Sie einen Regler über eine Skala verschieben. Bewegen Sie den Regler mit dem linken Joystick des Controllers und bestätigen Sie Ihre Eingabe mit der A-Taste (grün, rechter Daumen).\nBitte lassen Sie im Anschluss den Joystick wieder los, sodass er in die Mittelposition zurückgehen kann.'];
else
text = ['Um Ihre Antworten einzugeben koennen Sie einen Regler ueber eine Skala verschieben. Bewegen Sie den Regler mit der Maus und bestaetigen Sie Ihre Eingabe mit einem Klick.'];
end
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);
GetClicks(setup.screenNum);

if exist('shake_pic','var')
Screen('DrawTexture',w,texture.shake,[],[setup.ScrWidth/2-0.75*512 setup.ScrHeight/2-0.75*341 setup.ScrWidth/2+0.75*512 setup.ScrHeight/2+0.75*341]) 
Screen('Flip',w);
pause(3)
end

%VAS rating duration
VAS_rating_duration = 30;
VAS_time_limit = 0;

%%==============call VAS_exhaustion_wanting===================

state_questions = {  'hungry', 'hungrig', 'State';
                     'thirsty', 'durstig', 'State';    
                     'tired', 'müde', 'State';
                     'full', 'satt', 'State';
                     'masculine', 'maskulin', 'State';
                     'feminine', 'feminin', 'State';
                     'selfsatisfaction','selbstzufrieden', 'Influenca_1'
                     'physical condition' , 'körperliches Befinden', 'Influenca_2';
                     'mental condition' , 'psychisches Befinden', 'Influenca_3';
                     %'awake', 'wach', 'State';
                     'active', 'aktiv', 'PA';
                     'distressed', 'bedrückt', 'NA';
                     'interested', 'interessiert', 'PA';
                     'excited', 'freudig erregt', 'PA';
                     'upset', 'verärgert', 'NA';
                     'strong', 'stark', 'PA';
                     'guilty', 'schuldig', 'NA';
                     'scared', 'verängstigt', 'NA';
                     'hostile', 'feindselig', 'NA';
                     'inspired', 'angeregt', 'PA';
                     'proud', 'stolz', 'PA';
                     'irritable', 'reizbar', 'NA';
                     'enthusiastic', 'begeistert', 'PA';
                     'ashamed', 'beschämt', 'NA';
                     'alert', 'hellwach', 'PA';
                     'nervous', 'nervös', 'NA';
                     'determined', 'entschlossen', 'PA';
                     'attentive', 'aufmerksam', 'PA';
                     'jittery', 'unruhig', 'NA';
                     'afraid', 'ängstlich', 'NA'};
%add questions regarding liking and wanting of the shake/water in
%corresponding sessions
if subj.sess > 5
    
    if subj.t == 1
    
            state_questions = [ {'drink_wanting','drink_wanting','wanted'};
            {'drink_liking','drink_liking','liking'}
            state_questions];
    end
    
    if subj.t == 2
        if subj.shake == 4
         load_questions = {'How pleasant did you find the taste of the water?','Wie angenehm empfanden Sie den Geschmack des Wassers?','fcqtr_1';
            'If you could choose: How often would you drink the water?','Wenn Sie die Wahl haetten, wie oft wuerden Sie das Wasser waehlen?','fcqtr_2';
            'tasty','lecker','load_shake';
            'sweet','suess','load_shake';
            'salty','salzig','load_shake';
            'bitter','bitter','load_shake';
            'sour','sauer','load_shake'};
        else
        load_questions = {'How pleasant did you find the taste of the shake?','Wie angenehm empfanden Sie den Geschmack des Shakes?','fcqtr_1';
            'If you could choose: How often would you drink the shake?','Wenn Sie die Wahl haetten, wie oft wuerden Sie den Shake waehlen?','fcqtr_2';
            'tasty','lecker','load_shake';
            'sweet','suess','load_shake';
            'salty','salzig','load_shake';
            'bitter','bitter','load_shake';
            'sour','sauer','load_shake'};
        end
        
        state_questions = [ {'drink_wanting','drink_wanting','wanted'};
            {'drink_liking','drink_liking','liking'};
            load_questions;
            state_questions];
    end
    
    if subj.t == 3
        load_questions = {'How pleasant did you find the taste of the musli?','Wie angenehm empfanden Sie den Geschmack des Mueslis?','fcqtr_1';
            'If you could choose: How often would you eat the musli?','Wenn Sie die Wahl haetten, wie oft wuerden Sie das Muesli waehlen?','fcqtr_2';
            'tasty','lecker','load_muesli';
            'sweet','suess','load_muesli';
            'salty','salzig','load_muesli';
            'bitter','bitter','load_muesli';
            'sour','sauer','load_muesli'};
        state_questions = [load_questions;
            state_questions];
    end
    
    
end




% Save Start time experiment 
output.timestamps.exp_on = GetSecs;

% Stimulus presentation loop 
for i_state = 1:2%length(state_questions) 
    
    trial.question = state_questions{i_state,2}; % Question Item
    trial.type = state_questions{i_state,3}; % State or Caloric Load
    
%     if  strcmp(trial.type,'Caloric_wanting') || strcmp(trial.type,'Caloric_liking')
%         Caloric_Load
%     else 
    Effort_VAS_new
 %   end 

    
    % Save the VAS in output structure 
    output.rating(i_state, 1) = subj.id; 
    output.rating(i_state, 2) = subj.sess; 
    output.rating(i_state, 3) = subj.t; 
    output.rating(i_state, 4) = i_state; %rating label code (index of question cell array)
    output.rating(i_state, 5) = rating; %rating value
    output.rating(i_state, 6) = rating_subm;  % answer submitted by pressing A
    output.rating(i_state, 7) = t_rating_ref; %Time of rating submission
    
    output.ratingLabels = {'ID','Session','Timepoint','Question_Index','Rating','Submitted','RT'};

    %Reset variables
    rating = nan;
    rating_label = nan;
    rating_subm = nan;
    
    filename = ['VASstate_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_T', subj.tID];
    output.filename = fullfile(pwd, filesep, 'Data', filesep, filename);
    
    save([output.filename '.mat'], 'output', 'subj', 'state_questions')

end

output.timestamps.exp_end = GetSecs;

%%Store output
%Save time end of experiment
subj.date_end      = datestr(now);
t_start=datevec(datenum(subj.date_start));
t_end=datevec(datenum(subj.date_end ));
subj.length_exp = etime(t_end, t_start)/60; %length exp in min

output.time = datetime;
filename = ['VASstate_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_T', subj.tID];
output.filename = fullfile(pwd, filesep, 'Data', filesep, filename);

save(fullfile('Data', [filename '.mat']), 'output', 'subj', 'state_questions');
%clear images before saving the backup files
clear shake settings shake_pic
save(fullfile('Backup', [filename datestr(now,'_yymmdd_HHMM') '.mat']));

%Instruction text                                               
text = ['Der Fragenblock ist zu Ende. Bitte wenden Sie sich an die Versuchsleitung.'];
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);

GetClicks(setup.screenNum);

Screen('CloseAll')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
