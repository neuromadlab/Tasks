
%%===================Effort VAS============================================
% Script for VAS
% author: Monja P. Neuser, Nils B. Kroemer

% input via XBox USB-Controller or mouse

% Project Version for TUE008 (Corinna Schulz, Dec 2021:
% New since TUE007: no Jitter
% TUE008: No caloric load question anymore, no shake/water shown
%
% Modified by Jana Lieberz (2023-10-18) to include confirmation of session
% and run ID
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

% xbox_buffer = zeros(1,50); %will buffer the history of 50 button press status

%%get input from the MATLAB console
subj.study = 'BON001';
subj.subjectID = input('Subject ID: [6 digits] ','s');
subj.sessionID = input('Session [1, 2, 3, 4, 5, or 6]: ','s');

% ensure that the correct session ID was provided
correct_sess = 0;
while correct_sess ~= 1
    if str2double(subj.sessionID) == 1
        correct_sess = input(['The specified session is ' subj.sessionID ', indicating the first MRI session. Is this correct (1) or not (0)?: ']);
    elseif str2double(subj.sessionID) == 2
        correct_sess = input(['The specified session is ' subj.sessionID ', indicating the second MRI session. Is this correct (1) or not (0)?: ']);
    elseif str2double(subj.sessionID) == 3
        correct_sess = input(['The specified session is ' subj.sessionID ', indicating the first EGG session (pre session before first stimulation phase starts). Is this correct (1) or not (0)?: ']);
    elseif str2double(subj.sessionID) == 4
        correct_sess = input(['The specified session is ' subj.sessionID ', indicating the second EGG session (post session after first stimulation phase). Is this correct (1) or not (0)?: ']);
    elseif str2double(subj.sessionID) == 5
        correct_sess = input(['The specified session is ' subj.sessionID ', indicating the third EGG session (pre session before second stimulation phase starts). Is this correct (1) or not (0)?: ']);
    elseif str2double(subj.sessionID) == 6
        correct_sess = input(['The specified session is ' subj.sessionID ', indicating the fourth EGG session (post session after second stimulation phase). Is this correct (1) or not (0)?: ']);
    elseif ~ismember(str2double(subj.sessionID), 1:6)
        fprintf('\nThe specified session is not a valid session for BON001! ');
    end

    if correct_sess ~= 1
        subj.sessionID = input('Please enter the correct session ID [1, 2, 3, 4, 5, or 6]: ','s');
    end
end

if str2double(subj.sessionID) == 1 || str2double(subj.sessionID) == 2
    subj.runID = input('Run [1, 2, or 3]: ','s');
else
    subj.runID = input('Run [1 or 2]: ','s');
end

% ensure that the correct run ID was provided
correct_run = 0;
while correct_run ~= 1
    if str2double(subj.sessionID) == 1 || str2double(subj.sessionID) == 2
        if str2double(subj.runID) == 1
            correct_run = input(['The specified run is ' subj.runID ', indicating the first (pre) run. Is this correct (1) or not (0)?: ']);
        elseif str2double(subj.runID) == 2
            correct_run = input(['The specified run is ' subj.runID ', indicating the second (post) run. Is this correct (1) or not (0)?: ']);
        elseif str2double(subj.runID) == 3
            correct_run = input(['The specified run is ' subj.runID ', indicating the last run (end of session). Is this correct (1) or not (0)?: ']);
        elseif ~ismember(str2double(subj.runID), 1:3)
            fprintf('\nThe specified run is not a valid run for BON001 S1 to S2! ');
        end
    else
        if str2double(subj.runID) == 1
            correct_run = input(['The specified run is ' subj.runID ', indicating the first (pre) run. Is this correct (1) or not (0)?: ']);
        elseif str2double(subj.runID) == 2
            correct_run = input(['The specified run is ' subj.runID ', indicating the last run (end of session). Is this correct (1) or not (0)?: ']);
        elseif ~ismember(str2double(subj.runID), 1:2)
            fprintf('\nThe specified run is not a valid run for BON001 S3 to S6! ');
        end
    end

    if correct_run ~= 1
        if str2double(subj.sessionID) == 1 || str2double(subj.sessionID) == 2
            subj.runID = input('Please enter the correct run ID [1, 2, or 3]: ','s');
        else
            subj.runID = input('Please enter the correct run ID [1 or 2]: ','s');
        end
    end
end

subj.id = str2double(subj.subjectID);   % converts Subject ID to integer
subj.sess = str2double(subj.sessionID); %converts Session ID to integer
subj.run = str2double(subj.runID);
subj.date_start      = datestr(now);


% Load VAS settings
load([pwd filesep 'VASsettings_' subj.study '_S' subj.sessionID '.mat'])


% specify language (default in settings is German)
% subj.lang_de = input('German (1) or English (0): ');
% settings.lang_de = subj.lang_de;

do_gamepad = settings.do_gamepad;
do_EGG = settings.do_EGG;

if do_gamepad == 1
    load('JoystickSpecification.mat')
    findJoystick %runs script to check whether Joystick is at Handle 0 or 1 and corrects for it
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


%Setup overlay screen
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

if do_gamepad == 1
    if settings.lang_de == 1
        text_Cont = ['Weiter mit A.'];
    else
        text_Cont = ['Continue by pressing A.'];
    end
else
    if settings.lang_de == 1
        text_Cont = ['Weiter mit Mausklick.'];
    else
        text_Cont = ['Continue with mouse click.'];
    end
end

%% State Questions

%Instruction text I
if settings.lang_de == 1
    text1 = ['Willkommen. \n\n Im Folgenden werden Sie einige Fragen zu Ihrem aktuellen Befinden beantworten.'];
else
    text1 = ['Welcome. \n\n We will now ask you a few questions about your current mood.'];
end

Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text1, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 60, [], [], 1.2);
Screen('Flip',w);

%Hide mouse cursor
HideCursor()

if do_gamepad == 1
    while Joystick.Button(1) ~= 1
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    end
    WaitSecs(0.5);
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
else
    GetClicks(setup.screenNum);
end

%Instruction text II
if do_gamepad == 1
    if settings.lang_de == 1
        text = ['Um Ihre Antworten einzugeben, koennen Sie einen Regler ueber eine Skala verschieben. Bewegen Sie den Regler mit dem linken Joystick des Controllers und bestaetigen Sie Ihre Eingabe mit der A-Taste (gruen, rechter Daumen).\nBitte lassen Sie im Anschluss den Joystick wieder los, sodass er in die Mittelposition zurueckgehen kann.'];
    else
        text = ['To answer the questions, you can move the point on the scale using the left joystick on the controller and confirming your response with the A button (green, use the right thumb). \nPlease then let go of the joystick after confirming your response so that it can go back to the middle position.'];
    end
else
    if settings.lang_de == 1
        text = ['Um Ihre Antworten einzugeben, koennen Sie einen Regler ueber eine Skala verschieben. Bewegen Sie den Regler mit der Maus und bestaetigen Sie Ihre Eingabe mit einem Klick.'];
    else
        text = ['To answer the questions, you can move the point on the scale using the mouse and confirming your response with a left click.'];
    end

end

Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);

if do_gamepad == 1
    while Joystick.Button(1) ~= 1
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    end
    WaitSecs(0.5);
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
else
    GetClicks(setup.screenNum);
end

% Screen('DrawTexture',w,texture.shake,[],[setup.ScrWidth/2-0.75*512 setup.ScrHeight/2-0.75*341 setup.ScrWidth/2+0.75*512 setup.ScrHeight/2+0.75*341])
% Screen('Flip',w);
% pause(3)

%VAS rating duration
VAS_rating_duration = 30;
VAS_time_limit = 0;

%%==============call VAS_exhaustion_wanting===================

state_questions = {  'hungry', 'hungrig', 'State';
    'thirsty', 'durstig', 'State';
    'tired', 'müde', 'State';
    'full', 'satt', 'State';
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


% Save Start time experiment
output.timestamps.exp_on = GetSecs;

% Stimulus presentation loop
for i_state = 1:length(state_questions)

    if settings.lang_de == 1
        trial.question = state_questions{i_state,2}; % Question Item
    else
        trial.question = state_questions{i_state,1};
    end
    trial.type = state_questions{i_state,3}; % State or PANAS

    Effort_VAS



    % Save the VAS in output structure
    output.rating(i_state, 1) = subj.id;
    output.rating(i_state, 2) = subj.sess;
    output.rating(i_state, 3) = subj.run;
    output.rating(i_state, 4) = i_state; %rating label code (index of question cell array)
    output.rating(i_state, 5) = rating; %rating value
    output.rating(i_state, 6) = rating_subm;  % answer submitted by pressing A
    output.rating(i_state, 7) = t_rating_ref; %Time of rating submission

    output.ratingLabels = {'ID','Session','Timepoint','Question_Index','Rating','Submitted','RT'};

    %Reset variables
    rating = nan;
    rating_label = nan;
    rating_subm = nan;

    filename = ['VASstate_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_R', subj.runID];
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
filename = ['VASstate_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '_R', subj.runID];
output.filename = fullfile(pwd, filesep, 'Data', filesep, filename);

save(fullfile('Data', [filename '.mat']), 'output', 'subj', 'state_questions');
save(fullfile('Backup', [filename datestr(now,'_yymmdd_HHMM') '.mat']));

%Instruction text
if settings.lang_de == 1
    text = ['Der Fragenblock ist zu Ende. Bitte wenden Sie sich an die Versuchsleitung.'];
else
    text = ['The question block is over. Please contact the experimenter.'];
end
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);

ShowCursor

GetClicks(setup.screenNum);

Screen('CloseAll')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
