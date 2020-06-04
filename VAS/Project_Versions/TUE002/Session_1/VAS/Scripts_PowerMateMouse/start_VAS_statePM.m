
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
% load('JoystickSpecification.mat')

HideCursor()

% Change settings
% Basic screen setup 
setup.screenNum = max(Screen('Screens')); %secondary monitor if there is one connected
setup.fullscreen = 1; %if 0 -> will create a small window ideal for debugging, set =1 for Experiment

% Get operating system and set OS flags
system_info = Screen('Computer');
windows = system_info.windows;
mac = system_info.osx;
linux = system_info.linux;

if windows
    do_gamepad = 0; %set to 0 for mouse, 1 for xbox controller
    xbox_buffer = zeros(1,50); %will buffer the history of 50 button press status
end

% Search for connected PowerMate if on Linux and warn if PowerMate is not
% found, default to Mouse then
if linux
    
   PowerMateID = PsychPowerMate('List');
   
   if ~isempty(PowerMateID)
       
       PowerMateHandle = PsychPowerMate('Open', PowerMateID);
       vas_powermate = 1;
       
   else
       
       warning('Although VAS is run on a Linux system, no connected PowerMate could be found as input device for the VAS. Defaulting to mouse input now!')
       vas_powermate = 0;
       
   end
   
elseif windows

    vas_powermate = 0;
    
end

%Time limit for VAS on (1) or off (0)
timelimit = 0;

%Set input for study
subj.studyID='TUE002';
subj.version=2;
subj.run = '1'; %fixed, in BEDAVR study there is only 1 run
subj.date = datestr(now);
%%get input from the MATLAB console
subj.subjectID=input('Subject ID: ','s');
subj.sessionID=input('Session ID: ','s');
subj.tID=input('timepoint ID: ','s');
   
subj.sess = str2double(subj.sessionID); %converts Session ID to integer
subj.id = str2double(subj.subjectID); %converts Subject ID to integer
subj.t = str2double(subj.tID);

% Convert ID to 6-digit format
subj.subjectID = pad(subj.subjectID,6,'left','0');
            
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
if windows
    jitter_filename = sprintf('%s\\jitters\\DelayJitter_mu_0.70_max_4_trials_25.mat', pwd);
elseif linux
    jitter_filename = sprintf('%s/jitters/DelayJitter_mu_0.70_max_4_trials_25.mat', pwd);
end
load(jitter_filename);

jitter = Shuffle(DelayJitter);
count_jitter = 1;


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

% Query the frame duration                                       Wof�r?
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
text = ['Willkommen. \n\nZunaechst moechten wir Ihnen einige Fragen zu Ihrem aktuellen Befinden stellen.'];
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);

GetClicks(setup.screenNum);

if vas_powermate == 0
%Instruction text                                               
text = ['Um Ihre Antworten einzugeben koennen Sie einen Regler ueber eine Skala verschieben. Bewegen Sie den Regler mit der Maus und bestaetigen Sie Ihre Eingabe mit einem Klick.'];
elseif vas_powermate == 1
text = ['Um Ihre Antworten einzugeben koennen Sie einen Regler ueber eine Skala verschieben. Bewegen Sie den Regler mit dem Drehknopf und druecken Sie auf diesen Knopf um Ihre Eingabe zu bestaetigen. Benutzen Sie dazu bitte Ihre nicht-dominante Hand.'];    
end

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
                     'tired', 'muede', 'State';
                     'full', 'satt', 'State';
                   %  'awake', 'wach', 'State';
                     'active', 'aktiv', 'PA';
                     'distressed', 'bedrueckt', 'NA';
                     'interested', 'interessiert', 'PA';
                     'excited', 'freudig erregt', 'PA';
                     'upset', 'veraergert', 'NA';
                     'strong', 'stark', 'PA';
                     'guilty', 'schuldig', 'NA';
                     'scared', 'veraengstigt', 'NA';
                     'hostile', 'feindselig', 'NA';
                     'inspired', 'angeregt', 'PA';
                     'proud', 'stolz', 'PA';
                     'irritable', 'reizbar', 'NA';
                     'enthusiastic', 'begeistert', 'PA';
                     'ashamed', 'beschaemt', 'NA';
                     'alert', 'hellwach', 'PA';
                     'nervous', 'nervoes', 'NA';
                     'determined', 'entschlossen', 'PA';
                     'attentive', 'aufmerksam', 'PA';
                     'jittery', 'unruhig', 'NA';
                     'afraid', 'aengstlich', 'NA'};
                 
for i_state = 1:length(state_questions) 
    
   
    trial.question = state_questions{i_state,2};
    
    if linux || do_gamepad == 0
        VAS_mouse_PM
    elseif do_gamepad == 1
        Effort_VAS
    end
        
    output.rating.value(i_state,1) = startTime; %Start time of rating
    output.rating.value(i_state,2) = rating; %rating value
    output.rating.value(i_state,3) = i_state; %rating label code (index of state_questions cell array)
    output.rating.value(i_state,4) = rating_subm;  % answer submitted by pressing A
    output.rating.value(i_state,5) = t_rating_ref; %Time of rating submission
    output.version = subj.version;

%Reset variables
rating = nan;
rating_label = nan;
rating_subm = nan;

if windows
    output.filename = sprintf('%s\\data\\VASstate_%s_%06d_S%s_R%s_temp_%s', pwd, subj.studyID, subj.id, subj.sessionID, subj.tID, datestr(subj.date,'yymmdd_HHMM'));
elseif linux
    output.filename = sprintf('%s/data/VASstate_%s_%s_%s_%s_temp_%s', pwd, subj.studyID, subj.id, subj.sessionID, subj.tID, datestr(subj.date,'yymmdd_HHMM'));
end

save([output.filename '.mat'], 'output', 'subj', 'state_questions', 'jitter')

end




%%Store output
output.time = datetime;
output.filename = sprintf('VASstate_%s_%06d_S%s_R%s', subj.studyID, subj.id, subj.sessionID, subj.tID);

save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'state_questions', 'jitter');
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
