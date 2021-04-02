
%%===================Effort VAS===================
%Script for VAS before and after tVNS+Effort -11/07/2017-
%author: Monja P. Neuser, Nils B. Kroemer

%input via XBox USB-Controller

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
subj.studyID='TUE001';
subj.subjectID=input('Subject ID [2-stellig]: ','s');
subj.sessionID=input('Session ID: ','s');
subj.tID=input('timepoint ID: ','s');
   
subj.sess = str2double(subj.sessionID); %converts Session ID to integer
subj.num = str2double(subj.subjectID); %converts Subject ID to integer
subj.t = str2double(subj.tID);

            
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

%load jitters and initialize jitter counters
jitter_filename = sprintf('%s\\jitters\\DelayJitter_mu_0.70_max_4_trials_25.mat', pwd);
load(jitter_filename);

jitter = Shuffle(DelayJitter);
count_jitter = 1;


% Open the screen
if setup.fullscreen ~= 1   %if fullscreen = 0, small window opens
    [w,wRect] = Screen('OpenWindow',setup.screenNum,color.white,[0 0 800 600]);
else
    [w,wRect] = Screen('OpenWindow',setup.screenNum,color.white, []);
end;


% Get the center coordinates
[setup.xCen, setup.yCen] = RectCenter(wRect);

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

%Instruction text                                               
text = ['Willkommen. \n\nZunächst möchten wir Ihnen einige Fragen zu Ihrem aktuellen Befinden stellen.'];
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);

GetClicks(setup.screenNum);


%Instruction text                                               
text = ['Um Ihre Antworten einzugeben können Sie einen Regler über eine Skala verschieben. Bewegen Sie den Regler mit dem linken Joystick des Controllers und bestätigen Sie Ihre Eingabe mit der A-Taste (grün, rechter Daumen).\nBitte lassen Sie im Anschluss den Joystick wieder los, sodass er in die Mittelposition zurückgehen kann.'];
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);

GetClicks(setup.screenNum);

%VAS rating duration
VAS_rating_duration = 30;
VAS_time_limit = 0;

%%==============call VAS_exhaustion_wanting===================

state_questions = {  'hungry', 'hungrig', 'State';
                     'thirsty', 'durstig', 'State';    
                     'tired', 'müde', 'State';
                     'full', 'satt', 'State';
                   %  'awake', 'wach', 'State';
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
                 
for i_state = 1:length(state_questions) 
    
   
    trial.question = state_questions{i_state,2};

    Effort_VAS
    
    output.rating(i_state, 1) = startTime; %Start time of rating
    output.rating(i_state,2) = rating; %rating value
    output.rating(i_state,3) = i_state; %rating label code (index of state_questions cell array)
    output.rating(i_state,4) = rating_subm;  % answer submitted by pressing A
    output.rating(i_state,5) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_label = nan;
rating_subm = nan;

output.filename = sprintf('%s\\data\\VASstate_%s_%s_%s_%s_temp', pwd, subj.studyID, subj.subjectID, subj.sessionID, subj.tID);

save([output.filename '.mat'], 'output', 'subj', 'state_questions', 'jitter')

end




%%Store output
output.time = datetime;
output.filename = sprintf('VASstate_%s_%s_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID, subj.tID);

save(fullfile('data', [output.filename datestr(now, 'yymmdd_HHMM') '.mat']), 'output', 'subj', 'state_questions', 'jitter');
save(fullfile('Backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));





%Instruction text                                               
text = ['Der Fragenblock ist zu Ende. Bitte wenden Sie sich an die Versuchsleitung.'];
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);

GetClicks(setup.screenNum);

Screen('CloseAll')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
