
%%===================Effort VAS===================
%Script for VAS before and after tVNS+Effort -11/07/2017-
%author: Monja P. Neuser, Nils B. Kroemer

%input via XBox USB-Controller

%========================================================

%% Preparation

% Clear workspace
close all;
clear all; %#ok<CLALL> 
sca;

Screen('Preference', 'SkipSyncTests', 2);
load('JoystickSpecification.mat')
findJoystick %runs script to check whether Joystick is at Handle 0 or 1 and corrects for it

% Change settings
% Basic screen setup 
setup.screenNum = max(Screen('Screens')); %secondary monitor if there is one connected
setup.fullscreen = 1; %if 0 -> will create a small window ideal for debugging, set =1 for Experiment

doTVNS = 1; % set to 0 for stimulating manually / testing without tVNS

do_gamepad = 1; %do not set to 0, this is not implemented yet
xbox_buffer = zeros(1,50); %will buffer the history of 50 button press status

%%get input from the MATLAB console
subj.studyID='BON002';
subj.subjectID=input('Subject ID: ','s');
subj.sessionID=input('Session ID: ','s');
subj.runID='1';
t_start = datetime;
subj.date_start = char(t_start);
%subj.tID=input('timepoint ID: ','s');
subj.language = input('Language (de/en): \n','s');

if strcmpi(subj.language,'de')
    settings.lang_de = 1;
    disp('Run in German.')
else
    settings.lang_de = 0;
    disp('Run in English.')
end

subj.sess = str2double(subj.sessionID); %converts Session ID to integer
subj.num = str2double(subj.subjectID); %converts Subject ID to integer
%subj.t = str2double(subj.tID);
% Add zeros to subjectID's shorter than 6 integers
subj.subjectID  = [repmat('0',1,6-length(subj.subjectID)) subj.subjectID];

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
keys.quit=KbName('q');

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
end


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

[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);


if settings.lang_de == 1
    text_Cont = 'Weiter mit A (grüne Taste, rechter Daumen).';
else
    text_Cont = 'Continue with A (green button, right thumb).';
end

%Instruction text 
if settings.lang_de == 1
    text = 'Visuelle Analog-Skala zur Bestimmung der Stimulations-Stärke';
else
    text = 'Visual analogue scale to determine the optimal stimulation strength';
end
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);

while Joystick.Button(1) ~= 1
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(0.5);
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);


%Instruction text 
if settings.lang_de == 1
    text = 'Wir möchten im Folgenden die für Sie passende Stärke der Stimulation bestimmen. Dazu wird allmählich die Stimulationsstärke erhöht. Bitte bewerten Sie für jede Stufe, wie schmerzhaft Sie die Stimulation empfinden \n(von  0 [= keine Empfindung] bis 10 [= stärkste vorstellbare Empfindung]).';
else
    text = 'We now want to determine the optimal stimulation strength for you. We will increase the strength gradually in the following moments. After each step, please rate how painful you experienced the stimulation on as scale. \n(from 0 [= no sensation] to 10 [= strongest sensation imaginable]).';
end

Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);


while Joystick.Button(1) ~= 1
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(0.5);
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

if settings.lang_de == 1
    text = 'Um Ihre Antworten einzugeben können Sie einen Regler über eine Skala verschieben. Bewegen Sie den Regler mit dem linken Joystick des Controllers und bestätigen Sie Ihre Eingabe mit der A-Taste (grün, rechter Daumen).\nBitte lassen Sie im Anschluss den Joystick wieder los, sodass er in die Mittelposition zurückgehen kann.';
else
    text = 'To answer, you can move a slider across the scale. Please move the slider using the left joystick of the gamepad. You can submit your response by pressing A. After submitting, please release the joystick back to the middle position for the next trial.';
end
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);

while Joystick.Button(1) ~= 1
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(0.5);
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

if settings.lang_de == 1
    text = 'Die optimale Wirkung wird erzielt, wenn die Stimulation deutlich wahrnehmbar ist. Die Stimulation soll für Sie nicht unangenehm sein, muss aber als ein Prickeln oder leichtes Stechen auf der Haut an der Stimulationsstelle spürbar sein. ';
else
    text = 'The optimal response will be reached when the stimulation strength is clearly noticeable. The stimulation should not be uncomfortable, but should be felt as light prickling at the stimulation site.';
end

Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);

while Joystick.Button(1) ~= 1
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(0.5);
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

if settings.lang_de == 1
    text = 'Bitte drücken Sie A und informieren Sie die Versuchsleitung wenn Sie bereit sind zu beginnen.';
else
    text = 'Please press A and inform the experimenter when you are ready to begin.';
end

Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
%[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);

while Joystick.Button(1) ~= 1
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(0.5);
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);


%VAS rating duration
VAS_rating_duration = 30;
VAS_time_limit = 0;


%%==============call VAS_exhaustion_wanting===================

i_level = 1; % counter
trial.question = 'pain';
max_stimulation_intensity = 12;

[keys.a, keys.b, keys.c] = KbCheck();

%for i_level = 1:max_stimulation_intensity 
while keys.c(keys.quit) == 0   
    
    [keys.a, keys.b, keys.c] = KbCheck();
   
    text = 'Die Stimulations-Intensität wird eingestellt...';
    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
%    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
    Screen('Flip',w);

    % option for break the loop
    commandwindow; % focus on the Command Window
    disp(' ')
    disp(['You can quit this loop by entering:  ' KbName(keys.quit)])
    answer = input('To go on just hit "Enter": ', 's');
    if strcmp(answer, KbName(keys.quit))
        break
    end

    if doTVNS
        % prepare the stimulation through tVNS manager
        stimAmpl = input('Stimulation intensity [mA]: ', 's');
        stimFreq = 20;  % input('Stimulation frequency: ', 's');
        stimDur = 1; %jitter(count_jitter);
        if count_jitter < length(jitter)-1 % update the jitter counter
            count_jitter = count_jitter+1;
        else
            count_jitter = 1;
        end
        ptb = setupTVNS(stimAmpl, stimFreq, stimDur);
        
        % do the stimulation
        [~,~,~] = send(ptb.reqTreatOn, ptb.tvnsURL);
        disp('Stimulation on')
        WaitSecs(stimDur);
        [~,~,~] = send(ptb.reqTreatOff, ptb.tvnsURL);
        disp('Stimulation off')
    end

    %disp('Click on the touchpad when the stimulation strength is set and the participant should rate again')
    %WaitSecs(1);
    %GetClicks(setup.screenNum);
    % [mouse.x, mouse.y, mouse.buttons] = GetMouse(setup.screenNum);
    % if any(mouse.buttons)
        output.rating(i_level,1) = GetSecs; %Start time of rating
        Effort_VAS
        
        disp(['Pain rating of ',num2str(rating),'. Should be about 50'])
        output.rating(i_level,2) = rating; %rating value
        output.rating(i_level,3) = i_level; %rating label code (index of state_questions cell array)
        output.rating(i_level,4) = rating_subm;  % answer submitted by pressing A
        output.rating(i_level,5) = t_rating_ref; %Time of rating submission
    
        %Reset variables
        rating = nan;
        rating_label = nan;
        rating_subm = nan;

        output.filename = sprintf('%s\\data\\VASpain_%s_%s_S%s_R%s_temp', pwd, subj.studyID, subj.subjectID, subj.sessionID, subj.runID);

        save([output.filename '.mat'], 'output', 'subj', 'trial')

        i_level = i_level + 1;
    % end
end




%%Store output
%Save time end of experiment
t_end = datetime;
subj.date_end = char(t_end);
subj.length_exp = minutes( t_end - t_start);

output.time = datetime;
output.filename = sprintf('VASpain_%s_%s_S%s_R%s', subj.studyID, subj.subjectID, subj.sessionID,subj.runID);

save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'trial');
time_now = char(datetime('now', 'Format','_yyMMdd_HHm'));
save(fullfile('Backup', [output.filename time_now '.mat']));

%Instruction text                                               
text = 'Die Erhebung ist nun zu Ende.';
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
function ptb = setupTVNS(stimAmpl, stimFreq, stimDur)
% This function initializes the tVNS device

    % prepare several variables for communication with tVNS
    bAutoSwitch = matlab.net.http.MessageBody('automaticSwitch');
    bTreatOn = matlab.net.http.MessageBody('startTreatment');
    bTreatOff = matlab.net.http.MessageBody('stopTreatment');
    method = matlab.net.http.RequestMethod.POST;
    reqAutoSwitch = matlab.net.http.RequestMessage(method,[],bAutoSwitch);
    ptb.reqTreatOn = matlab.net.http.RequestMessage(method,[],bTreatOn);
    ptb.reqTreatOff = matlab.net.http.RequestMessage(method,[],bTreatOff);
    ptb.tvnsURL = 'http://localhost:51523/tvnsmanager/';

    % prepare the stimulation parameters for setting with tVNS Manager
    bSettings =  matlab.net.http.MessageBody(...
        ['minIntensity=100',...
        '&maxIntensity=5000', ...
        '&impulseDuration=400&frequency=',num2str(stimFreq),...
        '&stimulationDuration=',num2str(stimDur),...
        '&pauseDuration=30']); % pause needs to be longer than trial
    reqSettings = matlab.net.http.RequestMessage(method,[],bSettings);
    
    bStimIntensity = matlab.net.http.MessageBody(...
        ['intensity ',num2str(stimAmpl)]); 
    reqStimAmplitude = matlab.net.http.RequestMessage(method,[],bStimIntensity);
    % pause needs to be longer than trial
    reqSettings = matlab.net.http.RequestMessage(method,[],bSettings);
    [r1,~,~] = send(reqAutoSwitch, ptb.tvnsURL); % init tVNS Manager
    [r2,~,~] = send(reqSettings, ptb.tvnsURL);% set stimulation parameters
    [r3,~,~] = send(reqStimAmplitude, ptb.tvnsURL); %set stimulation intensity
    if r1.StatusCode ~= matlab.net.http.StatusCode.OK ||...
            r2.StatusCode ~= matlab.net.http.StatusCode.OK ||...
            r3.StatusCode ~= matlab.net.http.StatusCode.OK
        error('tVNS setup failed')
    end
end % end of setupTVNS
