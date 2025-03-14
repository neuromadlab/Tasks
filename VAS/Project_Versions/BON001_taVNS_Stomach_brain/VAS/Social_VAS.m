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
subj.sessionID = input('Session [1 or 2]: ','s');

% ensure that the correct session ID was provided
correct_sess = 0;
while correct_sess == 0
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

    if correct_sess == 0
        subj.sessionID = input('Please enter the correct session ID [1, 2, 3, 4, 5, or 6]: ','s');
    end
end

subj.condition = input('Condition: liking ratings [1] or willingness to pay [2]? ', 's');


subj.id = str2double(subj.subjectID);   % converts Subject ID to integer
subj.sess = str2double(subj.sessionID); %converts Session ID to integer
subj.date_start      = datestr(now);


% Load VAS settings
load([pwd filesep 'social_VASsettings_' subj.study '_S' subj.sessionID '.mat'])

% specify language (default in settings is German)
% subj.lang_de = input('German (1) or English (0): ');
settings.lang_de = 0;

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
    text1 = ['Willkommen. \n\n Im Folgenden werden Sie einige Fragen zu Freizeitaktivitäten beantworten.'];
else
    text1 = ['Welcome. \n\n We will now ask you a few questions about free time activities.'];
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
        text = ['Um Ihre Antworten einzugeben koennen Sie einen Regler ueber eine Skala verschieben. Bewegen Sie den Regler mit dem linken Joystick des Controllers und bestaetigen Sie Ihre Eingabe mit der A-Taste (gruen, rechter Daumen).\nBitte lassen Sie im Anschluss den Joystick wieder los, sodass er in die Mittelposition zurueckgehen kann.'];
    else
        text = ['To answer the questions, you can move the point on the scale using the left joystick on the controller and confirming your response with the A button (green, use the right thumb). \nPlease then let go of the joystick after confirming your response so that it can go back to the middle position.'];
    end
else
    if settings.lang_de == 1
        text = ['Um Ihre Antworten einzugeben koennen Sie einen Regler ueber eine Skala verschieben. Bewegen Sie den Regler mit der Maus und bestaetigen Sie Ihre Eingabe mit einem Klick.'];
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

if str2double(subj.condition) == 1
    activity_questions = {  'Cinema', 'Kinobesuch', 'activity_rating', '1';
        'Jumphouse', 'Trampolinhalle', 'activity_rating', '2';
        'Black light minigolf', 'Schwarzlichtminigolf', 'activity_rating', '3';
        'Escape room', 'Escape Room', 'activity_rating', '4';
        'Wellness', 'Wellness', 'activity_rating', '5';
        'Climbing hall', 'Kletterhalle', 'activity_rating', '6';
        'Zoo', 'Zoo', 'activity_rating', '7';
        'Cooking course', 'Kochkurs', 'activity_rating', '8';
        'Theatre', 'Theater', 'activity_rating', '9';
        'Pottery', 'Töpfern', 'activity_rating', '10';
        'Lasertag', 'Lasertag', 'activity_rating', '11';
        'Museum', 'Museum', 'activity_rating', '12';
        'Gym', 'Fitnessstudio', 'activity_rating', '13';
        'Ship tour', 'Schiffstour', 'activity_rating', '14';
        'City tour', 'Stadtführung', 'activity_rating', '15';
        'Swimming pool', 'Schwimmbad', 'activity_rating', '16';
        'Ropes course', 'Klettergarten', 'activity_rating', '17';
        'Shopping', 'Shopping', 'activity_rating', '18';
        'Concert', 'Konzert', 'activity_rating', '19';
        'Opera', 'Oper', 'activity_rating', '20';
        'Comedy', 'Comedyveranstaltung', 'activity_rating', '21';
        'Ice cream', 'Eis Essen', 'activity_rating', '22';
        'Restaurant', 'Restaurantbesuch', 'activity_rating', '23';
        'Cafe', 'Cafébesuch', 'activity_rating', '24'};


    % Save Start time experiment
    output.timestamps.exp_on = GetSecs;

    % Stimulus presentation loop
    for i_state = 1:length(activity_questions)

        if settings.lang_de == 1
            trial.question = activity_questions{i_state,2}; % Question Item
        else
            trial.question = activity_questions{i_state,1};
        end
        trial.type = activity_questions{i_state,3}; % liking rating or willingness to pay
        activity_index = str2double(activity_questions{i_state,4});

        Effort_VAS



        % Save the VAS in output structure
        output.rating(i_state, 1) = subj.id;
        output.rating(i_state, 2) = subj.sess;
        output.rating(i_state, 3) = activity_index; %rating label code (index of question cell array)
        output.rating(i_state, 4) = rating; %rating value
        output.rating(i_state, 5) = rating_subm;  % answer submitted by pressing A
        output.rating(i_state, 6) = t_rating_ref; %Time of rating submission

        output.ratingLabels = {'ID','Session','Question_Index','Rating','Submitted','RT'};

        %Reset variables
        rating = nan;
        rating_label = nan;
        rating_subm = nan;


        filename = ['VASsocialrating_', subj.study, '_', subj.subjectID, '_S', subj.sessionID];
        output.filename = fullfile(pwd, filesep, 'Data', filesep, 'Social_VAS', filesep, filename);

        save([output.filename '.mat'], 'output', 'subj', 'activity_questions')

    end
    % Create file needed for social discounting task implemented in
    % pavlovia

    output_table = table(output.rating(:,3),activity_questions(:,1),output.rating(:,4),'VariableNames', {'activityID', 'activity', 'rating'});
    writetable(output_table,[pwd filesep 'Data' filesep 'Social_VAS' filesep 'VASsocialrating_' subj.study '_' subj.subjectID '.csv'])

elseif str2double(subj.condition) == 2
    activity_questions = {  'Cinema', 'Kinobesuch', 'activity_pay_alone', '1';
        'Jumphouse', 'Trampolinhalle', 'activity_pay_alone', '2';
        'Black light minigolf', 'Schwarzlichtminigolf', 'activity_pay_alone', '3';
        'Escape room', 'Escape Room', 'activity_pay_alone', '4';
        'Wellness', 'Wellness', 'activity_pay_alone', '5';
        'Climbing hall', 'Kletterhalle', 'activity_pay_alone', '6';
        'Zoo', 'Zoo', 'activity_pay_alone', '7';
        'Cooking course', 'Kochkurs', 'activity_pay_alone', '8';
        'Theatre', 'Theater', 'activity_pay_alone', '9';
        'Pottery', 'Töpfern', 'activity_pay_alone', '10';
        'Lasertag', 'Lasertag', 'activity_pay_alone', '11';
        'Museum', 'Museum', 'activity_pay_alone', '12';
        'Gym', 'Fitnessstudio', 'activity_pay_alone', '13';
        'Ship tour', 'Schiffstour', 'activity_pay_alone', '14';
        'City tour', 'Stadtführung', 'activity_pay_alone', '15';
        'Swimming pool', 'Schwimmbad', 'activity_pay_alone', '16';
        'Ropes course', 'Klettergarten', 'activity_pay_alone', '17';
        'Shopping', 'Shopping', 'activity_pay_alone', '18';
        'Concert', 'Konzert', 'activity_pay_alone', '19';
        'Opera', 'Oper', 'activity_pay_alone', '20';
        'Comedy', 'Comedyveranstaltung', 'activity_pay_alone', '21';
        'Ice cream', 'Eis Essen', 'activity_pay_alone', '22';
        'Restaurant', 'Restaurantbesuch', 'activity_pay_alone', '23';
        'Cafe', 'Cafébesuch', 'activity_pay_alone', '24';
        'Cinema', 'Kinobesuch', 'activity_pay_together', '1';
        'Jumphouse', 'Trampolinhalle', 'activity_pay_together', '2';
        'Black light minigolf', 'Schwarzlichtminigolf', 'activity_pay_together', '3';
        'Escape room', 'Escape Room', 'activity_pay_together', '4';
        'Wellness', 'Wellness', 'activity_pay_together', '5';
        'Climbing hall', 'Kletterhalle', 'activity_pay_together', '6';
        'Zoo', 'Zoo', 'activity_pay_together', '7';
        'Cooking course', 'Kochkurs', 'activity_pay_together', '8';
        'Theatre', 'Theater', 'activity_pay_together', '9';
        'Pottery', 'Töpfern', 'activity_pay_together', '10';
        'Lasertag', 'Lasertag', 'activity_pay_together', '11';
        'Museum', 'Museum', 'activity_pay_together', '12';
        'Gym', 'Fitnessstudio', 'activity_pay_together', '13';
        'Ship tour', 'Schiffstour', 'activity_pay_together', '14';
        'City tour', 'Stadtführung', 'activity_pay_together', '15';
        'Swimming pool', 'Schwimmbad', 'activity_pay_together', '16';
        'Ropes course', 'Klettergarten', 'activity_pay_together', '17';
        'Shopping', 'Shopping', 'activity_pay_together', '18';
        'Concert', 'Konzert', 'activity_pay_together', '19';
        'Opera', 'Oper', 'activity_pay_together', '20';
        'Comedy', 'Comedyveranstaltung', 'activity_pay_together', '21';
        'Ice cream', 'Eis Essen', 'activity_pay_together', '22';
        'Restaurant', 'Restaurantbesuch', 'activity_pay_together', '23';
        'Cafe', 'Cafébesuch', 'activity_pay_together', '24'};


    % Save Start time experiment
    output.timestamps.exp_on = GetSecs;

    % Stimulus presentation loop
    for i_state = 1:length(activity_questions)

        if settings.lang_de == 1
            trial.question = activity_questions{i_state,2}; % Question Item
        else
            trial.question = activity_questions{i_state,1};
        end
        trial.type = activity_questions{i_state,3}; % liking rating or willingness to pay
        activity_index = str2double(activity_questions{i_state,4});

        Effort_VAS



        % Save the VAS in output structure
        output.rating(i_state, 1) = subj.id;
        output.rating(i_state, 2) = subj.sess;
        output.rating(i_state, 3) = activity_index; %rating label code (index of question cell array)
        output.rating(i_state, 4) = round(rating,2); %rating value
        output.rating(i_state, 5) = rating_subm;  % answer submitted by pressing A
        output.rating(i_state, 6) = t_rating_ref; %Time of rating submission

        output.ratingLabels = {'ID','Session','Question_Index','Payment','Submitted','RT'};

        %Reset variables
        rating = nan;
        rating_label = nan;
        rating_subm = nan;

        filename = ['VASsocialpay_', subj.study, '_', subj.subjectID, '_S', subj.sessionID];
        output.filename = fullfile(pwd, filesep, 'Data', filesep, 'Social_VAS', filesep, filename);

        save([output.filename '.mat'], 'output', 'subj', 'activity_questions')
    end

end

output.timestamps.exp_end = GetSecs;

%%Store output
%Save time end of experiment
subj.date_end      = datestr(now);
t_start=datevec(datenum(subj.date_start));
t_end=datevec(datenum(subj.date_end ));
subj.length_exp = etime(t_end, t_start)/60; %length exp in min

output.time = datetime;
if str2double(subj.condition) == 1
    filename = ['VASsocialrating_', subj.study, '_', subj.subjectID, '_S', subj.sessionID];
elseif str2double(subj.condition) == 2
    filename = ['VASsocialpay_', subj.study, '_', subj.subjectID, '_S', subj.sessionID];
end
output.filename = fullfile(pwd, filesep, 'Data', filesep, 'Social_VAS', filesep, filename);

save(fullfile('Data', 'Social_VAS', filesep, [filename '.mat']), 'output', 'subj', 'activity_questions');
save(fullfile('Backup', 'Social_VAS', filesep, [filename datestr(now,'_yymmdd_HHMM') '.mat']));

%Instruction text
text = ['Der Fragenblock ist zu Ende. Bitte wenden Sie sich an die Versuchsleitung.'];
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);

ShowCursor

GetClicks(setup.screenNum);

Screen('CloseAll')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
