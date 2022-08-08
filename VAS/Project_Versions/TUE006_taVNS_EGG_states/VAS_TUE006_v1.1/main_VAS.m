 %%===================TUE006 VAS===================
%Script for Mood-VAS and FCQ-T-r (every 15 minutes) + tVNS and load
%questions + Willingness-to-pay-Test + Body Silhouette Task
%(-26/11/2020-)
% 
%coded with: Matlab R2020a, Psychtoolbox 3.0, gstreamer 1.0
% 
%author: Vanessa Teckentrup, Sophie Mueller, Alessandro Petrella
%
%based on: Effort VAS script by Monja P. Neuser, Nils B. Kroemer
%(-11/07/2017-)
% 
%input via XBox USB-Controller
%========================================================

reentryMarker = input('Reentry? (0/1)\n');
if reentryMarker == 0
    %% Clear workspace
    clear all
    close all
    sca; 
    
    rng('shuffle') %shuffle random number generator for WPT randomization

    %% General session settings
    generalSettings.pilot = 0; % pilot session = 1; normal session = 0
    generalSettings.waiting_time = 900; % normal waiting time = 900; set different for pilot/debugging
    generalSettings.with_EGG = 1; % set 1 to run with EGG triggers, set 0 for pilot/debugging without EGG
    generalSettings.with_saveUSB = 1; %set 1 to automatically save data on USB stick 

    generalSettings.studyID='TUE006';

    disp(['Pilot: ' num2str(generalSettings.pilot) ', waiting time (between VAS): ' num2str(generalSettings.waiting_time) 's, EGG triggers: ' num2str(generalSettings.with_EGG) ', Automatic USB save: ' num2str(generalSettings.with_saveUSB)]);
    disp(['Is EGG saving? (press any key to continue)'])
    pause()

    % Load VAS settings
    load([pwd filesep 'VASsettings_' generalSettings.studyID '.mat'])
    VAS_rating_duration = settings.VAS_rating_duration;
    VAS_time_limit = settings.VAS_time_limit;
    VAS_rep_marker = 1;

    %% Enter subject data in Matlab console
    subj.studyID = 'TUE006';
    subj.subjectID = input('Subject ID: \n','s');
    subj.sessionID = input('Session ID: \n','s');
    condition = input('Condition (1/2/3/4): \n');
    subj.language = input('Language (de/en): \n','s');   
    subj.shake = input('Shake flavor (1 = strawb.,2 = choc.,3=car.): \n');

    if strcmpi(subj.language,'de')
        settings.lang_de = 1;
        disp('Run in German.')
    else
        settings.lang_de = 0;
        disp('Run in English.')
    end

    subj.sess = str2double(subj.sessionID); %converts Session ID to integer
    subj.num = str2double(subj.subjectID); %converts Subject ID to integer

    if subj.num <10
        if generalSettings.pilot == 0
            subj.subjectID  = [repmat('0',1,5) subj.subjectID]; % Add zeros to subjectID's shorter than 6 integers
        else
            subj.subjectID = ['9' repmat('0',1,4) subj.subjectID]; %for pilot testing
        end
    else
        if generalSettings.pilot == 0
            subj.subjectID  = [repmat('0',1,4) subj.subjectID];
        else
            subj.subjectID = ['9' repmat('0',1,3) subj.subjectID];
        end
    end
    
    if subj.shake == 1
        shake_pic = settings.shake.strawberry;
    elseif subj.shake == 2
        shake_pic = settings.shake.chocolate;
    elseif subj.shake == 3
        shake_pic = settings.shake.caramel;
    end
    
    %% Load settings
    % Load images for willingness to pay
    set_index = find(settings.conditions.ID == subj.num & settings.conditions.Session == subj.sess);
    if settings.conditions.ImageSet(set_index) == 1
        load([pwd '\Stimuli\A\allpicsA.mat'])
    else
        load([pwd '\Stimuli\B\allpicsB.mat'])
    end
    
%     if settings.conditions.ImageSet(set_index) == 1
%         image_path = [pwd filesep 'Stimuli' filesep 'A'];
%     else
%         image_path = [pwd filesep 'Stimuli' filesep 'B'];
%     end
    
    WillPay_Stimuli = allpics(randperm(length(allpics)));
    wtpt.pics = zeros(40,1);
    for i = 1:length(WillPay_Stimuli)
        pic_idx = find(not(cellfun('isempty',strfind({allpics{:,1}},WillPay_Stimuli{i}))));
        if length(pic_idx) >1
            for k=1:length(pic_idx)
                if isequal(allpics{pic_idx(k),1},WillPay_Stimuli{i})
                    pic_idx = pic_idx(k);
                    break
                end
            end
        end
        wtpt.pics(i,1) = pic_idx;
    end
    
    if settings.conditions.ImageSet(set_index) == 1 && settings.conditions.Reward(set_index) == 1
        reward_name = '254.jpg'; % gummy bears
    elseif settings.conditions.ImageSet(set_index) == 1 && settings.conditions.Reward(set_index) == 2
        reward_name = '29.jpg'; % Twix
    elseif settings.conditions.ImageSet(set_index) == 2 && settings.conditions.Reward(set_index) == 1
        reward_name = '104.jpg'; % Bueno
    else
        reward_name = '336.jpg'; % Corny Chocolate
    end

    wtpt.reward_index = find(not(cellfun('isempty',strfind(WillPay_Stimuli,reward_name))));
    
    %% Check condition
    if generalSettings.pilot == 0
        subj.condition = settings.conditions.Condition(set_index);
        if subj.condition ~= condition
            error(['Conditions did not match. Entered condition was: ' num2str(condition) ', but it should have been: ' num2str(subj.condition) '. Please recheck!'])
        else
            disp(['Matching condition (' num2str(condition) '. All settings loaded. Starting with screen setup.']);
        end
    else
        subj.condition = condition;
        disp(['Pilot session with manually chosen condition: ' num2str(condition) '. All settings loaded. Starting with screen setup.'])
    end

    %% Setup Screen & Controller
    Screen('Preference', 'SkipSyncTests', 2);

    % Load Gamepad Controller Specifications and query one time to generate
    % variables
    load('JoystickSpecification.mat');
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

    % Change settings
    % Basic screen setup 
    setup.screenNum = max(Screen('Screens')); %secondary monitor if there is one connected
    setup.fullscreen = 1; %if 0 -> will create a small window ideal for debugging, set =1 for Experiment

    %do_gamepad = 1; %do not set to 0, this is not implemented yet
    %xbox_buffer = zeros(1,50); %will buffer the history of 50 button press status

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

    % Setup output variables 
    output = struct;
    load_questions = {};
    state_questions = {};
    fcqtr_questions = {};
    money = struct;
%     wtpt = struct;
    
    task_status = 11;

    %% Set up EGG
    if generalSettings.with_EGG == 1
        %Add path for io64 function
        addpath 'C:\Program Files\MATLAB\R2018a\toolbox'

        % Generate LPT I/O object
        LPT_IO_EGG = io64;
        % Check if status of the port is 0
        status = io64(LPT_IO_EGG);
        if status == 0
            disp('LPT port status for EGG triggers OK, continue task...')
        else
            error('LPT port status ~= 0, please check...')
        end 
        %write EGG trigger (baseline)
        io64(LPT_IO_EGG,settings.EGG.port_address,255-settings.EGG.trigger.start_baseline);
    end
else
    ID = input('ID (6 digits!): \n');
    ID_str = input('ID (6 digits!): \n','s');
    ses = input('session: \n');
    load([pwd '\Reentry\reentry_TUE006_' ID_str '_S' num2str(ses) '.mat'])
    
    if generalSettings.with_EGG == 1
        %Add path for io64 function
        addpath 'C:\Program Files\MATLAB\R2018a\toolbox'

        % Generate LPT I/O object
        LPT_IO_EGG = io64;
        status = io64(LPT_IO_EGG);
        if status == 0
            disp('LPT port status for EGG triggers OK, continue task...')
        else
            error('LPT port status ~= 0, please check...')
        end 
    end
    
    set_index = find(settings.conditions.ID == subj.num & settings.conditions.Session == subj.sess);
    if settings.conditions.ImageSet(set_index) == 1
        load([pwd '\Stimuli\A\allpicsA.mat'])
    else
        load([pwd '\Stimuli\B\allpicsB.mat'])
    end    
    if generalSettings.with_EGG == 1
        % write EGG trigger (start willingness to pay)             
        io64(LPT_IO_EGG,settings.EGG.port_address,255-settings.EGG.trigger.reentry);
    end
end

% Open the screen

HideCursor()
if setup.fullscreen ~= 1   %if fullscreen = 0, small window opens
    [w,wRect] = Screen('OpenWindow',setup.screenNum,color.white,[0 0 800 600]);
else
    [w,wRect] = Screen('OpenWindow',setup.screenNum,color.white, []);
end

% Create milkshake texture
texture.shake = Screen('MakeTexture',w,shake_pic);
for pic = 1:40
    texture.wtpt{pic} = Screen('MakeTexture',w,allpics{pic,2});
end
% Get the center coordinates
[setup.xCen, setup.yCen] = RectCenter(wRect);

% Flip to clear
Screen('Flip', w);
% Query the frame duration                                     
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

if settings.lang_de == 1
    text_Cont = ['Weiter mit A.'];
else
    text_Cont = ['Continue with A.']; %english translation
end

% rating_scr = Screen('OpenOffscreenwindow',w,color.white);

[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

try
    %% Liking and wanting for the load at the beginning
    if task_status == 1   
        beep
        timestamps.load1_start = datetime('now');
        %Instruction text 
        if settings.lang_de == 1
            text = ['Zunaechst werden wir Ihnen zwei kurze Fragen zum Milchshake stellen, den Sie auf dem Bild sehen.'];
        else
            text = ['We will begin with two short questions about the milkshake that you see in the picture.']; 
        end

        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 60, [], [], 1.2);
        Screen('DrawTexture',w,texture.shake,[],[setup.ScrWidth/2-0.75*512 setup.ScrHeight/2-0.75*341 setup.ScrWidth/2+0.75*512 setup.ScrHeight/2+0.75*341]) 
        Screen('Flip',w);
        pause(3)

        %GetClicks(setup.screenNum);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        WaitSecs(0.5);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

        if settings.lang_de == 1
            text = ['Um Ihre Antworten einzugeben koennen Sie einen Regler ueber eine Skala verschieben. Bewegen Sie den Regler mit dem linken Joystick des Controllers und bestaetigen Sie Ihre Eingabe mit der A-Taste (gruen, rechter Daumen).\nBitte lassen Sie im Anschluss den Joystick wieder los, sodass er in die Mittelposition zurueckgehen kann.'];
        else
            text = ['To answer the questions, you can move the point on the scale using the left joystick on the controller and confirming your response with the A button (green, use the right thumb). \nPlease then let go of the joystick after confirming your response so that it can go back to the middle position.']; 
        end

        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 60, [], [], 1.2);
        Screen('Flip',w);

        %GetClicks(setup.screenNum);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        WaitSecs(0.5);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

        % First liking and wanting
        % Liking
        scale_type = [];
        trial.question = 'liking';

        Effort_VAS

        output.rating.load{1,1} = startTime; %Start time of rating
        output.rating.load{1,2} = rating; %rating value
        output.rating.load{1,3} = 'Liking_Start'; %rating label code (index of state_questions cell array)
        output.rating.load{1,4} = rating_subm;  % answer submitted by pressing A
        output.rating.load{1,5} = t_rating_ref; %Time of rating submission

        %%Store output
        output.time = datetime;
        output.filename = sprintf('VAS_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);

        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter');
        save(fullfile('Backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));

        %Reset variables
        rating = nan;
        rating_subm = nan;

        % Wanting
        trial.question = 'wanted';

        Effort_VAS

        output.rating.load{2,1} = startTime; %Start time of rating
        output.rating.load{2,2} = rating; %rating value
        output.rating.load{2,3} = 'Wanting_Start'; %rating label code (index of state_questions cell array)
        output.rating.load{2,4} = rating_subm;  % answer submitted by pressing A
        output.rating.load{2,5} = t_rating_ref; %Time of rating submission

        %%Store output
        output.time = datetime;
        output.filename = sprintf('VAS_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);

        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter');
        save(fullfile('Backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));

        %Reset variables
        rating = nan;
        rating_subm = nan;
        task_status = 2;
        timestamps.load1_end = datetime('now');
    end

    if task_status == 2
        beep
        timestamps.stimset_start = datetime('now');
        %% Stimulation VAS
        stimulationVAS %stimulation VAS, press 'q' when finished 

        %Information text on screen
        if settings.lang_de == 1
            text = ['Bitte bleiben Sie weiterhin vollkommen entspannt und ruhig liegen. \nBitte bewegen sie sich nicht und vermeiden Sie es, zu lachen und zu sprechen.'];
        else
            text = ['Please stay relaxed and keep still. \nPlease do not move and avoid speaking or laughing.']; 
        end
        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 60, [], [], 1.2);
        Screen('Flip',w);   
        %GetClicks(setup.screenNum);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end 
        WaitSecs(0.5);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        task_status = 3;
        timestamps.stimset_end = datetime('now');
    end

    if task_status == 3
        if generalSettings.with_EGG == 1
            %write EGG trigger (baseline)
            io64(LPT_IO_EGG,settings.EGG.port_address,255-settings.EGG.trigger.start_baseline);
        end
        %Instruction text     
        if settings.lang_de == 1
            text = ['Alle 15 Minuten stellen wir Ihnen einige Fragen zu Ihrer aktuellen Stimmung. Um Ihre Antworten einzugeben, koennen Sie wie zuvor den Regler ueber eine Skala verschieben und Ihre Eingabe mit der A-Taste (gruen, rechter Daumen) bestaetigen. \nBitte lassen Sie im Anschluss den Joystick wieder los, sodass er in die Mittelposition zurueckgehen kann.'];
        else
            text = ['Every 15 minutes, we will ask you a few questions about your current mood. To answer the questions, you can move the point on the screen using the joystick and confirm your response with the A button (green, use the right thumb). \nPlease let go of the joystick after confirming your response so that it can go back to the middle position.']; 
        end

        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 60, [], [], 1.2);
        Screen('Flip',w);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        WaitSecs(0.5);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    end
    if task_status >= 3 & task_status <= 9
        %% VAS Loop
        %run VAS every 15 minutes
        for rep = 1:7
            if rep < VAS_rep_marker
                continue
            end
            beep
            timestamps.VAS_start{rep} = datetime('now');
            
            timestamps.start_q = GetSecs(); %timestamp start questionnaires

            %call VAS function with questionnaires
            questionnaireVAS;

            timestamps.end_q = GetSecs(); % timestamp end questionnaires
            VAS_rep_marker = VAS_rep_marker +1;
            timestamps.VAS_end{rep} = datetime('now');
            
            if rep == 3 % Stimulation is turned on after 30 Minutes (= run 3)
                    beep
                    %Information text on screen
                    if settings.lang_de == 1
                        text = ['Die Stimulation wird jetzt angeschaltet. Bitte geben Sie jetzt dem Versuchsleiter Ihren Controller.'];
                    else
                        text = ['The stimulation will now be switched on. Please hand the controller to the examiner now.']; 
                    end

                    Screen('TextSize',w,32);
                    Screen('TextFont',w,'Arial');
                    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
                    Screen('Flip',w);   

                    % click at the same time as you start the stimulation
                    while Joystick.Button(1) ~= 1
                        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
                    end
                    WaitSecs(0.5);
                    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

                    if generalSettings.with_EGG == 1
                        % write EGG trigger (stimulation start)
                         io64(LPT_IO_EGG,settings.EGG.port_address,255-settings.EGG.trigger.stim_start);
                    end
                    timestamps.stim_start = GetSecs(); % get timestamp
                    timestamps.stim_start_time = datetime('now');
                    Screen('Flip',w); 


            elseif rep == 5 % Milkshake after 60 Minutes (= run 5)
                	beep
                    %Information text
                    if settings.lang_de == 1
                        text = ['Bitte trinken Sie nun den Milchshake auf dem Tablett innerhalb von 5 Minuten.'];
                    else
                        text = ['Please drink the milkshake you see on the tablet within the next 5 minutes.']; 
                    end

                    Screen('TextSize',w,32);
                    Screen('TextFont',w,'Arial');
                    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
                    Screen('Flip',w);  

                    if generalSettings.with_EGG == 1
                        % write EGG trigger (load start)
                         io64(LPT_IO_EGG,settings.EGG.port_address,255-settings.EGG.trigger.load_start);
                    end

                    timestamps.load_start = GetSecs(); % Get timestamp
                    
                    timestamps.load_start_time = datetime('now');

                    %GetClicks(setup.screenNum);
                    while Joystick.Button(1) ~= 1
                        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
                    end
                    WaitSecs(0.5);
                    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

                    if generalSettings.with_EGG == 1
                        %write EGG trigger (load end)
                        io64(LPT_IO_EGG,settings.EGG.port_address,255-settings.EGG.trigger.load_end);
                    end
                    timestamps.load_end_time = datetime('now');

                    timestamps.load_end = GetSecs(); % get timestamp
                    Screen('Flip',w); 

            end


            if rep == 3
                WaitSecs(generalSettings.waiting_time-(timestamps.stim_start-timestamps.start_q))
            elseif rep == 5
                WaitSecs(generalSettings.waiting_time-(timestamps.load_end-timestamps.start_q))
            elseif rep ~=7
                %wait 15 minutes until next run (minus time needed for questionnaires)
                WaitSecs(generalSettings.waiting_time-(timestamps.end_q-timestamps.start_q)) 
            end 
            task_status = task_status +1;
        end
        
        task_status = 10;
        WaitSecs(5)
    end

    if task_status == 10
        beep
        timestamps.load2_start = datetime('now');
        %% Load questions
        % additional questions after last normal VAS

        %Information text on screen
        if settings.lang_de == 1
            text = ['Wir stellen Ihnen nun noch ein paar Fragen zum Milchshake. \nSie koennen wieder den Regler auf der Skala verschieben, um Ihre Antwort abzugeben.'];
        else
            text = ['We will now ask you a few questions about the milkshake. \nYou can move the point on the scale to respond.'];
        end

        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 60, [], [], 1.2);
        Screen('Flip',w);

        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        WaitSecs(0.5);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

        if generalSettings.with_EGG == 1
            % write EGG trigger (start load questions)             
            io64(LPT_IO_EGG,settings.EGG.port_address,255-settings.EGG.trigger.start_loadq);
        end

        % First liking and wanting after the load
        % Liking
        trial.question = 'liking';

        Effort_VAS

        output.rating.load{3,1} = startTime; %Start time of rating
        output.rating.load{3,2} = rating; %rating value
        output.rating.load{3,3} = 'Liking_AfterLoad'; %rating label code (index of state_questions cell array)
        output.rating.load{3,4} = rating_subm;  % answer submitted by pressing A
        output.rating.load{3,5} = t_rating_ref; %Time of rating submission

        %%Store output
        output.time = datetime;
        output.filename = sprintf('VAS_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);

        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter');
        save(fullfile('Backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));

        %Reset variables
        rating = nan;
        rating_subm = nan;

        % Wanting
        trial.question = 'wanted';

        Effort_VAS

        output.rating.load{4,1} = startTime; %Start time of rating
        output.rating.load{4,2} = rating; %rating value
        output.rating.load{4,3} = 'Wanting_AfterLoad'; %rating label code (index of state_questions cell array)
        output.rating.load{4,4} = rating_subm;  % answer submitted by pressing A
        output.rating.load{4,5} = t_rating_ref; %Time of rating submission

        %%Store output
        output.time = datetime;
        output.filename = sprintf('VAS_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);

        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter');
        save(fullfile('Backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));

        %Reset variables
        rating = nan;
        rating_subm = nan;

        % Load related questions
        load_questions = {'How pleasant did you find the taste of the shake?','Wie angenehm empfanden Sie den Geschmack des Shakes?';
                     'If you could choose: How often would you drink the shake?','Wenn Sie die Wahl haetten, wie oft wuerden Sie den Shake waehlen?';
                     'tasty','lecker';
                     'sweet','suess';
                     'salty','salzig';
                     'bitter','bitter';
                     'sour','sauer'};


        for i_load = 1:length(load_questions)

            if i_load <= 2
                scale_type = strcat('load_',num2str(i_load));
                question_type = 'fcqtr'; %displayed question == trial.question
            else
                scale_type = 'adjective';
                question_type = 'load'; %adjective will be embedded
            end

            trial.question = load_questions{i_load,settings.lang_de+1};

            Effort_VAS

            % Add 4 rows due to liking & wanting ratings (beginning and after load)
            output.rating.load{i_load+4,1} = startTime; %Start time of rating
            output.rating.load{i_load+4,2} = rating; %rating value
            output.rating.load{i_load+4,3} = ['Load ' num2str(i_load)]; %rating label code (index of state_questions cell array)
            output.rating.load{i_load+4,4} = rating_subm;  % answer submitted by pressing A
            output.rating.load{i_load+4,5} = t_rating_ref; %Time of rating submission

            %Reset variables
            rating = nan;
            rating_subm = nan;

            %%Store output
            output.time = datetime;
            output.filename = sprintf('VAS_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);

            save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter');

        end

        if generalSettings.with_EGG == 1
            %write EGG trigger (end load questions)    
            io64(LPT_IO_EGG,settings.EGG.port_address,255-settings.EGG.trigger.end_loadq);
        end

        %%Store output
        output.time = datetime;
        output.filename = sprintf('VAS_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);

        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter');
        save(fullfile('Backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));
        task_status = 11;
        timestamps.load2_end = datetime('now');
    end

    if task_status == 11
        beep
        timestamps.wpt_start = datetime('now');
        %% Willingness to pay task
        %Information text on screen
        if settings.lang_de == 1
            text = ['Wir zeigen Ihnen nun verschiedene Artikel, fuer die Sie ueber den Regler auf dem Bildschirm ein Gebot zwischen 0 und 2 Euro abgeben koennen, um diese Artikel zu erwerben. \nIhre Gebote werden mit den Geboten aus einer vorherigen Studie verglichen. \nJe hoeher Ihr Gebot ist, desto wahrscheinlicher koennen Sie den Artikel erwerben.'];
        else
            text = ['We will now show you a few items. You can use the joystick to move a point on the scale to offer between 0 and 2 Euros to receive these items. \nYour offeres will be compared to those from an earlier study. \nThe higher your offer is, the more likely you are to receive the item.']; 
        end

        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black,60, [], [], 1.2);
        Screen('Flip',w);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        WaitSecs(0.5);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

        %Information text on screen
        if settings.lang_de == 1
            text = ['Die zu erwerbende Menge entspricht den Bildern, die Sie sehen. \nNach der Praesentation aller Artikel, wird ein Artikel zufaellig bestimmt. Diesen Artikel erwerben Sie fuer den gebotenen Preis und koennen ihn mit nach Hause nehmen, wenn Sie das hoechste Gebot abgegeben haben. \nDer Preis wird automatisch von der Aufwandsentschaedigung abgezogen.'];
        else
            text = ['The amount you are to receive corresponds with the pictures you see. \nAfter the presentation of all items, a random item will be determined. This will be the item you will receive at your offered price if you had the highest offer. \nThe price will automatically be taken from your reimbursement for the study.']; 
        end

        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 60, [], [], 1.2);
        Screen('Flip',w);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        WaitSecs(0.5);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

        %Information text on screen
        if settings.lang_de == 1
            text = ['Wenn Sie bereit sind, startet die Aufgabe, wenn Sie A druecken.'];
        else
            text = ['When you are ready, press A to begin the task.'];
        end

        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 60, [], [], 1.2);
        Screen('Flip',w);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        WaitSecs(0.5);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

        % Start WTPT
        scale_type = 'willingnesspay';

        if settings.lang_de == 1
            text_question = 'Welchen Betrag zwischen 0 Euro und 2 Euro bieten Sie fuer den folgenden Artikel:';
        else
            text_question = 'How much between 0 and 2 Euros would you offer for the following item:'; 
        end

        trial.question = 'willingnesspay';
        question_type = 'willingnesspay';

        if generalSettings.with_EGG == 1
            % write EGG trigger (start willingness to pay)             
            io64(LPT_IO_EGG,settings.EGG.port_address,255-settings.EGG.trigger.start_wtpt);
        end

        for i_willpay = 1:length(WillPay_Stimuli) %length(willingnesspay_stimuli)

%             [Pic, map, alpha] = imread([image_path filesep WillPay_Stimuli{i_willpay,1}]);
            
            pic_index = wtpt.pics(i_willpay);

            Effort_VAS

            output.rating.willingnesspay{i_willpay,1} = startTime; %Start time of rating
            output.rating.willingnesspay{i_willpay,2} = rating; %rating value
            output.rating.willingnesspay{i_willpay,3} = WillPay_Stimuli{i_willpay};%WillPay_Stimuli{i_willpay,1}(1:end-4); % Picture ID
            output.rating.willingnesspay{i_willpay,4} = rating_subm;  % answer submitted by pressing A
            output.rating.willingnesspay{i_willpay,5} = t_rating_ref; %RT
            output.controller_willingnesspay{i_willpay,1} = controller_positions;

            %Reset variables
            rating = nan;
            rating_subm = nan;

            %%Store output
            output.time = datetime;
            output.filename = sprintf('VAS_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);

            save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter');

        end

%         %%Store output
%         output.time = datetime;
%         output.filename = sprintf('VAS_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);
% 
%         save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter');
%         save(fullfile('Backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));

        %Information text on screen
        if settings.lang_de == 1
            text = ['Die Aufgabe ist beendet. Es wird nun ein zufaelliger Durchgang bestimmt und Ihr Gebot mit vorherigen Geboten verglichen. \nWenn Sie das hoechste Gebot abgegeben haben, erwerben Sie den Artikel zum Preis ihres Gebots.'];
        else
            text = ['The task is now over. We will now draw a random trial and compare you offer for that item with all other offers. \nIf you had the highest offer, you will receive the item at the price of your offer.']; 
        end

        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 60, [], [], 1.2);
        Screen('Flip',w);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        WaitSecs(0.5);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        
        % Announce result of willingness to pay
        % Get bid for winning trial
        wtpt.bid = output.rating.willingnesspay{wtpt.pics(wtpt.reward_index),2};

        if wtpt.bid < 128 % 64
            probability_win = 0;
        else
            probability_win = (1 - exp(-0.04*((wtpt.bid - 127)*100/37)));
        end

        % Random probability (winning border)
        coinflip  = rand;
        if coinflip <= probability_win
            wtpt.reward_won = 1;
            % Calculate amount
            value = wtpt.bid;
            if value == 0
                value_text = '0 Euro';
            elseif value < 100
                value_text = ['0,' num2str(value,'%02d') ' Euro'];
            elseif value == 100
                value_text = '1 Euro';
            elseif value < 200
                value_text = ['1,' num2str((value-100),'%02d') ' Euro'];
            elseif value == 200
                value_text = '2 Euro';
            end
        else
            wtpt.reward_won = 0;
        end

        % Store WTPT results in output
        output.wtpt_results = {[wtpt.reward_index], [wtpt.pics(wtpt.reward_index)],[wtpt.bid], [probability_win], [coinflip], [wtpt.reward_won]}; 

        %%Store output
        output.time = datetime;
        output.filename = sprintf('VAS_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);

        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter');
        save(fullfile('Backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));


        % Show results screen
        if wtpt.reward_won == 0
            if settings.lang_de == 1
                text_question = 'Der folgende Artikel wurde ausgewaehlt. Leider war Ihr Gebot nicht ausreichend, um den Artikel zu erwerben.';
            else
                text_question = 'The following item was chosen. Your offer was unfortunately not high enough to receive the item.'; 
            end
            DrawFormattedText(w, text_question, 'center', setup.ScrHeight/10, color.scale_anchors,80,[],[],2);
            % Place image
            Scale_width = round(setup.ScrWidth * .50);
            Screen('DrawTexture',w, texture.wtpt{wtpt.pics(wtpt.reward_index)},[],[(setup.ScrWidth/2-Scale_width/2) (Scale_offset+setup.ScrHeight/2 - 500) (setup.ScrWidth/2+Scale_width/2) (setup.ScrHeight-setup.ScrHeight/3)]);
   
            %[Pic, map, alpha] = imread([image_path filesep WillPay_Stimuli{wtpt.reward_index,1}]);
            %Screen('PutImage', w, Pic, [(setup.ScrWidth/2-Scale_width/2) (Scale_offset+setup.ScrHeight/2 - 400) (setup.ScrWidth/2+Scale_width/2) (setup.ScrHeight-setup.ScrHeight/3+100)]);
            
        elseif wtpt.reward_won == 1
            if settings.lang_de == 1
                text_question = ['Der folgende Artikel wurde ausgewaehlt. Ihr Gebot war ausreichend. Sie haben den Artikel fuer ' value_text ' erworben!'];
            else
                text_question = ['The following item was chosen. Your offer was high enough. You will receive the item for ' value_text '!']; 
            end
            DrawFormattedText(w, text_question, 'center', setup.ScrHeight/10, color.scale_anchors,80,[],[],2);
            % Place image
            Scale_width = round(setup.ScrWidth * .50);
            Screen('DrawTexture',w, texture.wtpt{wtpt.pics(wtpt.reward_index)},[],[(setup.ScrWidth/2-Scale_width/2) (Scale_offset+setup.ScrHeight/2 - 500) (setup.ScrWidth/2+Scale_width/2) (setup.ScrHeight-setup.ScrHeight/3)]);
%             [Pic, map, alpha] = imread([image_path filesep WillPay_Stimuli{wtpt.reward_index,1}]);
%             Screen('PutImage', w, Pic, [(setup.ScrWidth/2-Scale_width/2) (Scale_offset+setup.ScrHeight/2 - 400) (setup.ScrWidth/2+Scale_width/2) (setup.ScrHeight-setup.ScrHeight/3+100)]);
        end
        Screen('Flip',w);
        WaitSecs(5)

        if generalSettings.with_EGG == 1
            % write EGG trigger (end willingness to pay)             
            io64(LPT_IO_EGG,settings.EGG.port_address,255-settings.EGG.trigger.end_wtpt);
        end
        
        timestamps.wpt_end = datetime('now');

        %Information screen
        if settings.lang_de == 1
            text = ['Die Stimulation wird nun ausgeschaltet.'];
        else
            text = ['The stimulation will now be turned off'];
        end
        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
        Screen('Flip',w);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        WaitSecs(0.5);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

%         % White screen
%         Screen('Flip',w);
%         while Joystick.Button(1) ~= 1
%             [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
%         end
%         WaitSecs(0.5);
%         [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        task_status = 12;
    end

    if task_status == 12
        beep
        %Information screen
        if settings.lang_de == 1
            text = ['Die nächste Aufgabe wird geladen. Das kann einen Moment dauern.'];
        else
            text = ['The next task will now load. This can take a moment.'];
        end
        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
        Screen('Flip',w);
        [keyIsDown, secs, keyCode, deltaSecs] = KbCheck();
        while keyCode(32) ~= 1
            [keyIsDown, secs, keyCode, deltaSecs] = KbCheck();
        end
        WaitSecs(0.5);
        [keyIsDown, secs, keyCode, deltaSecs] = KbCheck();
        
        timestamps.bodysil_start = datetime('now');
        %% BodySilC
        BodySilC_TUE006
        
        task_status = 13;
        timestamps.bodysil_end = datetime('now');
    end

    if task_status == 13
        if settings.lang_de == 1
            text_Cont = ['Weiter mit A.'];
        else
            text_Cont = ['Continue with A.']; %english translation
        end
        
        beep
        
        %Information screen
        if settings.lang_de == 1
            text = ['Der letzte Fragebogen wird geladen.'];
        else
            text = ['The final questionnaire will now load.'];
        end
        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
        Screen('Flip',w);
        [keyIsDown, secs, keyCode, deltaSecs] = KbCheck();
        while keyCode(32) ~= 1
            [keyIsDown, secs, keyCode, deltaSecs] = KbCheck();
        end
        WaitSecs(0.5);
        [keyIsDown, secs, keyCode, deltaSecs] = KbCheck();
        
        timestamps.VAS8_start = datetime('now');
        %% Final VAS
        for rep = 8
            questionnaireVAS %without food craving
        end
        timestamps.VAS8_end = datetime('now');
        %% Final information screen
        if settings.lang_de == 1
            text = ['Die Session ist beendet. \nBitte bleiben Sie noch ruhig liegen, bis der Versuchsleiter Ihnen Bescheid gibt. \nVielen Dank fuer Ihre Teilnahme!'];
        else
            text = ['The session is now over. \nPlease continue lying still until the experimenter comes in to get you. \nThank you for your participation!']; 
        end

        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
        Screen('Flip',w);
        WaitSecs(5)

        %close Screen
        sca
        ShowCursor()
        task_status = 14;
    end
    if task_status == 14
        %% Display results
        %Note down in protocol!
        disp(['Bid: ',num2str(wtpt.bid)]) %amount for winning trial
        disp(['Reward won: ',num2str(wtpt.reward_won)]) %1=won,0=not
        % disp(['Winning probability: ',num2str(probability_win)]) %winning probability
        % disp(['Border for winning: ',num2str(coinflip)]) %random coinflip as border for winning

        %% Save spent money
        % Load money struct from previous session
        if subj.sess > 1
            load([pwd filesep 'data' filesep 'VAS_' subj.studyID '_' subj.subjectID '_' num2str(subj.sess-1) '.mat'],'money')
        end

        % Save spent money from WTPT 
        if wtpt.reward_won == 1
            money.spent{subj.sess,1} = wtpt.bid; %bid (winning trial)
        else
            money.spent{subj.sess,1} = 0; %0 if not won
        end

        money.time = datetime;
        % money.filename = sprintf('money_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);
        % save(fullfile('data', [money.filename '.mat']),'money');

        %%Store output
        output.time = datetime;
        output.filename = sprintf('VAS_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);

        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter','money','timestamps');
        save(fullfile('Backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));

        % Display payout after session 4
        if subj.sess == 4
            allmoney_spent = sum(cell2mat(money.spent)); %sum all expenses from all sessions
            disp(['Proband hat insgesamt ' num2str(allmoney_spent/100) ' Euro ausgegeben.'])
            disp(['Entweder 4 VPH und ' num2str(40-allmoney_spent/100) ' Euro oder ' num2str(80-allmoney_spent/100) ' Euro als Verguetung auszahlen.'])
        else
            disp(['Ausgegebene Betraege wurden gespeichert. In dieser Session wurden ' num2str(money.spent{subj.sess,1}/100) ' Euro ausgegeben.'])
        end
        disp(['Protocol timestamps: VAS1-7 start: ' char(timestamps.VAS_start{1}) ', ' char(timestamps.VAS_start{2}) ', ' char(timestamps.VAS_start{3}) ', ' char(timestamps.VAS_start{4}) ', ' char(timestamps.VAS_start{5}) ', ' char(timestamps.VAS_start{6}) ', ' char(timestamps.VAS_start{7})])
        disp(['VAS 1-7 end: ' char(timestamps.VAS_end{1}) ', ' char(timestamps.VAS_end{2}) ', ' char(timestamps.VAS_end{3}) ', ' char(timestamps.VAS_end{4}) ', ' char(timestamps.VAS_end{5}) ', ' char(timestamps.VAS_end{6}) ', ' char(timestamps.VAS_end{7})])
        disp(['WTPT start, end: ' char(timestamps.wpt_start) ', ' char(timestamps.wpt_end)])
        disp(['BodySilC start, end: ' char(timestamps.bodysil_start) ', ' char(timestamps.bodysil_end)])
        disp(['VAS 8 start, end: ' char(timestamps.VAS8_start) ', ' char(timestamps.VAS8_end)])
        if generalSettings.with_saveUSB == 1
            disp('Insert neuroMADLAB USB Stick')
            pause()

            % Copy VAS data
            disp('Copying VAS data...')
            copyfile(['C:\Users\Doktorand\Desktop\taVNS_EGG_neuroMADLAB\VAS_TUE006_study_version\data\VAS_TUE006_' subj.subjectID '_' subj.sessionID '.mat'],'E:\TUE006\Data')
            copyfile(['C:\Users\Doktorand\Desktop\taVNS_EGG_neuroMADLAB\VAS_TUE006_study_version\Backup\VAS_TUE006_' subj.subjectID '_' subj.sessionID '_*'],'E:\TUE006\Backup\')
            disp('Copying silhouette data...')
            copyfile(['C:\Users\Doktorand\Desktop\taVNS_EGG_neuroMADLAB\VAS_TUE006_study_version\data\silhouette_TUE006_' subj.subjectID '_S' subj.sessionID '.mat'],'E:\TUE006\Data')
            copyfile(['C:\Users\Doktorand\Desktop\taVNS_EGG_neuroMADLAB\VAS_TUE006_study_version\Backup\silhouette_TUE006_' subj.subjectID '_S' subj.sessionID '_*'],'E:\TUE006\Backup\')
            
            disp('All data copied to USB stick. Do not forget to save the EGG data from the other PC!')
        end
    end
catch
    sca
    if generalSettings.with_EGG == 1
        % write EGG trigger (error)             
        io64(LPT_IO_EGG,settings.EGG.port_address,255-settings.EGG.trigger.error);
    end
    err = lasterror;
    disp(err)
    save([pwd '\Reentry\reentry_TUE006_' subj.subjectID '_S' subj.sessionID '.mat'],'timestamps','task_status','wtpt','subj','generalSettings','shake_pic','settings','color','keys','setup','output','money','jitter','load_questions', 'state_questions', 'fcqtr_questions','VAS_rep_marker','VAS_rating_duration','VAS_time_limit','WillPay_Stimuli','JoystickSpecification','Joystick')
end


