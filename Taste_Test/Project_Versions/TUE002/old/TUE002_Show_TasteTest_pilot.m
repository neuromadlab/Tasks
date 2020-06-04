%%================== Food evaluation paradigm =============================
% For a description of the set of images, see Charbonnier (2015) Appetite
%
% Coded by: Nils Kroemer 
% Modified by Emily Corwin-Renner, Monja Neuser
% Coded with: Matlab R2014a using Psychtoolbox 3.0.11
%
%==========================================================================

%% preparation

% clear workspace
clear all; 
close all; 
sca;

% Set random seed:
seed = sum(100 * clock);
reset(RandStream.getGlobalStream,seed);

% pathes and OS information
OS = computer;
exp_dir = pwd;

% Windows
if OS == 'PCWIN64'
    img_dir = [pwd '\SnackPics\'];
% Linux or Mac
else 
    img_dir = [pwd '/SnackPics/'];
end
addpath(img_dir);

% Specify parameters
subj.studyID='TUE002';

validInput = false;
while ~validInput
    i = input('Debug mode? [y/n] ','s');
    if strcmp(i,'y')
        debug = true;
        subj.subjectID = '9999';
        subj.sessionID = '99';
        subj.debug_scan_id = '014_90002';
        validInput = true;
    elseif strcmp(i,'n')
        debug = false;
        validInput = true;
        
        subj.subjectID = input('Subject ID : ','s');
        subj.sessionID = input('Session ID: ','s');
    else
        warning('Not a valid answer! Please try again.');
    end
end

validInput = false;
while ~validInput
    i = input('German? (Elsewise english) [y/n] ','s');
    if strcmp(i,'y')
        lang_de = true;
        validInput = true;
    elseif strcmp(i,'n')
        lang_de = false;
        validInput = true;
    else
        warning('Not a valid answer! Please try again.');
    end
end

validInput = false;
while ~validInput
    i = input('Which condition? [A = sweet first/ B = salty first] ','s');
    if strcmp(i,'A')
        sweet_first = true;
        validInput = true;
    elseif strcmp(i,'B')
        sweet_first = false;
        validInput = true;
    else
        warning('Not a valid answer! Please try again.');
    end
end

% Convert ID to 6-digit format
subj.subjectID = pad(subj.subjectID,6,'left','0');

% Convert subj/sess IDs to integers
subj.num = str2double(subj.subjectID); 
subj.sess = str2double(subj.sessionID);

% default
design.value = 0;

% Screen preparation
Screen('Preference', 'SkipSyncTests', 0)
PsychDefaultSetup(2);
ListenChar(2);
% Screen('Preference', SkipSyncTests', 2);
screens = Screen('Screens');
screenNumber = max(screens);

% hardware usage
% fullscreen only if experimental mode
if debug
    do_fullscreen = 0;
    do_joystick = 0;
    do_gamepad = 0;
else
    do_fullscreen = 1;
    do_joystick = 0;
    do_gamepad = 0;
end

% read image files
if sweet_first
    img.d = imread([img_dir '184.jpg']);
    img.f = imread([img_dir '286.jpg']);
    img.c = imread([img_dir '26.jpg']);
    img.e = imread([img_dir '207.jpg']);
    img.a = imread([img_dir '40.jpg']);
    img.b = imread([img_dir '373.jpg']);
else
    img.d = imread([img_dir '40.jpg']);
    img.f = imread([img_dir '26.jpg']);
    img.c = imread([img_dir '373.jpg']);
    img.e = imread([img_dir '286.jpg']);
    img.a = imread([img_dir '184.jpg']);
    img.b = imread([img_dir '207.jpg']);
end

% save final image size
[image_y image_x] = size(img.d);

%% Paradigm settings

% will run scale in prob_scales*100% of trials
do_scales = 1;
% for scales
feedback_delay = 0.20;
% currently the next rating screen will appear when the participant entered
% the rating
% after the specified seconds, the rating screen will terminate
% max_dur_rating = 60;
% background colour specs
color_scale_background = [255 255 255];
color_scale_anchors = [0 0 0];
% relative offset; positive values move the screen towards to top, negative towards the bottom
screen_offset_y = 0.01;
scale_offset_y = 0.25;
min_ISI = 0.1;
% load jitters and initialize jitter counters
load('DelayJitter_mu_0.70_max_4_trials_192.mat');
jitter = Shuffle(DelayJitter);
count_jitter = 1;

%% Stimulus preparation
normal_text_size = 40;
large_text_size = 44;
small_text_size = 25;
fixation_cross_text_size = 64;

if lang_de == 1
    
    % Snacks presented in the Taste Test, depending on condition
    if sweet_first
        Snacks = { 'Sweets', 'Gummibaerchen', 'sweet', 'a', '[A]';
            'Cracker', 'Cracker', 'salty', 'b', '[B]';
            'Cookies', 'Kekse', 'sweet', 'c', '[C]';
            'Brezeln', 'Brezeln', 'salty', 'd', '[D]';
            'Fruits', 'Trockenobst', 'sweet', 'e', '[E]';
            'Nic Nacs', 'Nic Nacs', 'salty', 'f', '[F]'};
    else
        Snacks = { 'Brezeln', 'Brezeln', 'salty', 'a', '[A]';
            'Fruits', 'Trockenobst', 'sweet', 'b', '[B]';
            'Cracker', 'Cracker', 'salty', 'c', '[C]';
            'Sweets', 'Gummibaerchen', 'sweet', 'd', '[D]';
            'Nic Nacs', 'Nic Nacs', 'salty', 'e', '[E]'
            'Cookies', 'Kekse', 'sweet', 'f', '[F]';};
    end
    
    % Paradigm will include two phases of ratings for each Snack
    Phase = {   '1', 'anticipation', 'Stellen Sie sich vor wie dieser Snack schmeckt.', 'I';
        '2', 'consumption', 'Probieren Sie den Snack.', 'II' };
    % instruction text
    instruct.header = 'Geschmackstest: Phase %s';
    instruct.text = ['\n\n' ...
        '\n\n' ...
        '\n\n'...
        'Im Folgenden m�chten wir erfassen, wie Sie anhand ' ...
        '%s den Snack bewerten.'];
    
    % inter trial texts
    ITI_text_1 = 'Drehen Sie nun zum %s Snack. \n\n Sch�ssel %s';
    ITI_text_2 = 'Trinken Sie jetzt einen Schluck Wasser, um den Geschmack des vorherigen Snacks zu neutralisieren.';
    
    % question type, question phase 1, question phase 2
    Question = { 'Wanting', 'Wie sehr wollen Sie den Snack?', 'Wie sehr wollen Sie den Snack?';
        'Liking', 'Bitte bewerten Sie den Snack im Vergleich zu allen bisher in Ihrem Leben erfahrenen Empfindungen.', 'Bitte bewerten Sie den Snack im Vergleich zu allen bisher in Ihrem Leben erfahrenen Empfindungen.';
        'Intensit�t', 'Wie intensiv\n w�rde der Snack schmecken?', 'Wie intensiv\n schmeckt der Snack?';
        'S��e', 'Wie s��\n w�rde der Snack schmecken?', 'Wie s��\n schmeckt der Snack?';
        'S�ure', 'Wie sauer\n w�rde der Snack schmecken?', 'Wie sauer\n schmeckt der Snack?';
        'Salzigkeit', 'Wie salzig\n w�rde der Snack schmecken?', 'Wie salzig\n schmeckt der Snack?';
        'Bitternis', 'Wie bitter\n w�rde der Snack schmecken?', 'Wie bitter\n schmeckt der Snack?';
        'Umami', 'Wie umami/w�rzig\n w�rde der Snack schmecken?', 'Wie umami/w�rzig\n schmeckt der Snack?'};
    
    mouseclick = 'Weiter mit Mausklick';
    
    single_phase_2 = 'Probieren Sie den Snack.';
    double_phase_2 = 'Probieren Sie den Snack erneut.';
else
    % Snacks presented in the Taste Test, depending on the condition
    if sweet_first
        Snacks = {  'Sweets', 'Gummy Bear', 'sweet', 'a', '[A]';
            'Cracker', 'Cracker', 'salty', 'b', '[B]';
            'Cookies', 'Cookies', 'sweet', 'c', '[C]';
            'Pretzels', 'Pretzels', 'salty', 'd', '[D]';
            'Fruits', 'Dried Fruits', 'sweet', 'e', '[E]';
            'Nic Nacs', 'Nic Nacs', 'salty', 'f', '[F]'};
    else
        Snacks = { 'Pretzels', 'Pretzels', 'salty', 'a', '[A]';
            'Fruits', 'Dried Fruits', 'sweet', 'b', '[B]';
            'Cracker', 'Cracker', 'salty', 'c', '[C]';
            'Sweets', 'Gummy Bear', 'sweet', 'd', '[D]';
            'Nic Nacs', 'Nic Nacs', 'salty', 'e', '[E]'
            'Cookies', 'Cookies', 'sweet', 'f', '[F]';};
    end
    
    % Paradigm will include two phases of ratings for each Snack
    Phase = {   '1', 'anticipation', 'Imagine the taste of the snack.', 'I';
        '2', 'consumption', 'Try the snack.', 'II'};
    
    % instruction text
    instruct.header = 'Taste Test: Phase %s';
    instruct.text = ['\n\n' ...
        '\n\n' ...
        '\n\n'...
        'We will test, how you rate the snack depending ' ...
        'on %s.'];
    
    % inter trial texts
    ITI_text_1 = 'Turn now to the %s snack. \n\n Bowl %s';
    ITI_text_2 = 'Have a sip of water now to neutralize the taste of the previous snack.';
    
    % question type, question phase 1, question phase 2
    Question = { 'wanting', 'How much do you want the snack?', 'How much do you want the snack?';
        'liking', 'Please rate in the context of the full range of sensations that you have experienced in your life.', 'Please rate in the context of the full range of sensations that you have experienced in your life.';
        'intensity', 'How intense\n would the snack be?', 'How intense\n is the snack?';
        'sweetness', 'How sweet\n would the snack be?', 'How sweet\n is the snack?';
        'sourness', 'How sour\n would the snack be?', 'How sour\n is the snack?';
        'saltiness', 'How salty\n would the snack be?', 'How salty\n is the snack?';
        'bitterness', 'How bitter\n would the snack be?', 'How bitter\n is the snack?';
        'umami', 'How umami/spicy\n would the snack be?', 'How umami/spicy\n is the snack?'};
    
    mousclick = 'Forward with Mouseclick';
    
    double_phase_1 = 'Try the snack.';
    double_phase_2 = 'Try the snack again.';
end

fixation = '+';

% in case, the consumption phase should be shown more than once to the
% participant, change the value of consumption_repetition to number of
% desired repetitions!
%
% repetition = 1: consumption phase is shown once to participant
% (i.e. starting counting with 1)
consumption_repetition = 2;
% phase 1 is always repeated once, consumption phase is flexible
desired_length = consumption_repetition + 1;

if consumption_repetition > 1
    % counts the length of the current phase cell array
    % one row will be added to the cell array until desired length is
    % reached
    % index of cell arrays start counting with 1
    j = 2;
    
    while j < desired_length
        j = j + 1;
        Phase{j,1} = Phase{2,1};
        Phase{j,2} = Phase{2,2};
        Phase{j,3} = Phase{2,3};
    end
end

%% Screen
if do_fullscreen == 1
    w = Screen(screenNumber,'OpenWindow',[255 255 255]);
    Screen('Preference', 'SkipSyncTests', 0);
    HideCursor
else
    w = Screen('OpenWindow', 0, 255, [10 30 810 630]);
    Screen('Preference', 'SkipSyncTests', 1);
end
[ww, wh] = Screen('WindowSize', w);

% screen values
scale_x = ww/1024;
scale_y = wh/768;
x_cent = ww/2;
y_cent = wh/2;

% rectangle that frames pictures and task
rating_scr_rect_y1 = 25;
rating_scr_rect_y2 = 175;
rating_scr_rect_x1 = (ww - 0.9*ww);
rating_scr_rect_x2 = (ww - 0.7*ww);
rating_scr_rect = [rating_scr_rect_x1 rating_scr_rect_y1 rating_scr_rect_x2 rating_scr_rect_y2];
highlighter_colour = [200 200 200];

% choose position of task text relative to rectangle
position_task_x = ww - 0.89*ww;
position_task_y = (rating_scr_rect_y2 + large_text_size)/2;

% compute size of image to fit into the rectangle
desired_img_height = (rating_scr_rect_y2 - rating_scr_rect_y1)/2;
% for some reasons - 100 is needed to adjust the y-coordinates
desired_img_width = (image_x / image_y * desired_img_height) - 100;

%% idependent variables
rating = 0;
text_freerating = [];

%%% starting experiment
%% Time variables
% saves timestamp of experimental loop onset
subj.time.on_trigger_loop = GetSecs;
subj.trigger.fin = GetSecs;
% saves timestamp of subject starting the experiment with click 
KbQueueRelease();
subj.time.exp_on = GetSecs;       

% compute number of rows/column of cell arrays
[nrP,ncP] = size(Phase);
[nrS,ncS] = size(Snacks);
[nrQ,ncQ] = size(Question);

% for each answer, one row in output struct is written
% after each loop, index is increased by one
output_index = 1;
                
%% experimental loop
% experiment involves two different phases
% 1. anticipation
% 2. consumption
% 3 and larger: repetitions of consumption phase
% participant runs for each phase through each snack
for i_phase = 1 : nrP
    
    % instruction screen 
    % show inter trial screen
    if i_phase == 1
        Screen('TextSize',w,large_text_size);
        Screen('TextFont',w,'Arial');
        if i_phase > 2
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(instruct.header, Phase{2,4}), 'center', wh/4, [0 0 0],60);
        else
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(instruct.header, Phase{i_phase,4}), 'center', wh/4, [0 0 0],60);
        end
        Screen('TextSize',w,normal_text_size);
        Screen('TextFont',w,'Arial');
        if lang_de
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(instruct.text, 'des Aussehens und des Geruchs'), 'center', pos.y + 50, [0 0 0],60);
        else
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(instruct.text, 'the appearance and the smell'), 'center', pos.y + 50, [0 0 0],60);
        end
        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, mouseclick, 'center', wh-50, [0 0 0],60);
        Screen('Flip', w, []);
    else
        Screen('TextSize',w,large_text_size);
        Screen('TextFont',w,'Arial');
        if i_phase > 2
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(instruct.header, Phase{2,4}), 'center', wh/4, [0 0 0],60);
        else
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(instruct.header, Phase{i_phase,4}), 'center', wh/4, [0 0 0],60);
        end
        
        Screen('TextSize',w,normal_text_size);
        Screen('TextFont',w,'Arial');
        if lang_de
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(instruct.text, 'des Geschmacks'), 'center', pos.y + 50, [0 0 0],60);
        else
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(instruct.text, 'the tasting'), 'center', pos.y + 50, [0 0 0],60);
        end
        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, mouseclick, 'center', wh-50, [0 0 0],60);
        Screen('Flip', w, []);
    end
    
    % wait until mouse click
    GetClicks();
    
    % there are several different snacks (see above)
    % for each snack, every question is asked
    for i_snack = 1 : nrS
        
         % show inter trial screen
        if i_snack == 1
            Screen('TextSize',w,normal_text_size);
            Screen('TextFont',w,'Arial');
            if lang_de
                [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(ITI_text_1, 'ersten', Snacks{i_snack,5}), 'center', wh/2 - 100, [0 0 0],60);
            else
                [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(ITI_text_1, 'first', Snacks{i_snack,5}), 'center', wh/2 - 100, [0 0 0],60);
            end
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, mouseclick, 'center', wh-50, [0 0 0],60);
            Screen('Flip', w, []);
        else
            Screen('TextSize',w,normal_text_size);
            Screen('TextFont',w,'Arial');
            if lang_de
                [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(ITI_text_1, 'n�chsten', Snacks{i_snack,5}), 'center', wh/2 - 100, [0 0 0],60);
            else
                 [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(ITI_text_1, 'next', Snacks{i_snack,5}), 'center', wh/2 - 100, [0 0 0],60);
            end
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, mouseclick, 'center', wh-50, [0 0 0],60);
            Screen('Flip', w, []);
        end
        
        % wait until mouse click
        GetClicks();
        
        % show fixation cross
        Screen('TextSize',w,fixation_cross_text_size);
        Screen('TextFont',w,'Arial');
        DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);
        [ons_resp, starttime] = Screen('Flip', w);
        
        % in phase 2, all questions are asked twice per snack
        % in other phases, all questions are asked once per snack
        if i_phase == 2
            n = 2;
        else 
            n = 1;
        end
        
        
        count_n = 1;
        for i = 1 : n
          
            
            if (i_phase == 2 || i_phase == 3) && i == 1
                Screen('TextSize',w,large_text_size);
                Screen('TextFont',w,'Arial');                
                [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, single_phase_2, 'center', 'center', [0 0 0],40);
                [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, mouseclick, 'center', wh-50, [0 0 0],60);                   
                 Screen('Flip', w, []);
                
                % wait until mouse click
                GetClicks();
                
            elseif i_phase == 2 && i == 2

                [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, double_phase_2, 'center', 'center', [0 0 0],40);
                [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, mouseclick, 'center', wh-50, [0 0 0],60);
                Screen('Flip', w, []);
                
                % wait until mouse click
                GetClicks();                
            end
            
            for i_rating = 1 : nrQ
                
                % save in which phase the participant is in current trial
                output.rating.phase(output_index,1) = i_phase;
                
                % show fixation cross
                Screen('TextSize',w,fixation_cross_text_size);
                Screen('TextFont',w,'Arial');
                DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);
                [ons_resp, starttime] = Screen('Flip', w);
                
                % saving how much time passed between experiment onset and
                % fixation cross onset
                subj.onsets.fix1(output_index,1) = starttime - subj.trigger.fin;
                
                WaitSecs(min_ISI+jitter(count_jitter));
                count_jitter = count_jitter + 1;
                
                subj.time.scale_trigger = GetSecs;
                subj.onsets.scales.all(output_index,1) = subj.time.scale_trigger - subj.trigger.fin;
                
                % depending on experimental block, set values
                trial.question = Question{i_rating};
                trial.snack = Snacks{i_snack,2};
                trial.image_code = Snacks{i_snack,4};
                trial.image = 0;
                if trial.image_code == 'a'
                    trial.image = img.a;
                elseif trial.image_code == 'b'
                    trial.image = img.b;
                elseif trial.image_code == 'c'
                    trial.image = img.c;
                elseif trial.image_code == 'd'
                    trial.image = img.d;
                elseif trial.image_code == 'e'
                    trial.image = img.e;
                elseif trial.image_code == 'f'
                    trial.image = img.f;
                end
                trial.phase = Phase{i_phase,2};
                if i_phase > 2
                    text.task = [Phase{2,4}, '.'];
                else
                    text.task = [Phase{i_phase,4}, '.'];
                end
                
                if i_phase == 1
                    text.question = Question{i_rating, i_phase+1};
                elseif i_phase >= 2
                    text.question = Question{i_rating, 3};
                end
                
                subj.onsets.scales.VAS(output_index,1) = subj.trigger.fin;
                
                if i_rating == 1
                    VAS_horz_TT
                elseif i_rating == 2
                    LHS_vertical_TT
                elseif i_rating >= 3
                    LMS_vertical_TT
                end
                
                subj.durations.scales.VAS(output_index,1) = GetSecs - (subj.onsets.scales.VAS(output_index,1) + subj.trigger.fin);
                subj.durations.scales.all(output_index,1) = GetSecs - (subj.onsets.scales.all(output_index,1) + subj.trigger.fin);
                
                
                % save how much time has passed between x and second fixation
                % cross presentation
                subj.onsets.fix2(output_index,1) = starttime - subj.trigger.fin;
                
                % if no response was given, default values are saved in output
                if flag_resp == 0
                    output.rating.value(output_index,1) = rating;
                    output.rating.label{output_index,1} = text_freerating;
                    output.rating.subm(output_index,1) = 0;
                end
                
                % saving in output which scale and which snack was used
                output.rating.scale_label{output_index,1} = Question{i_rating,1};
                output.rating.snack_label{output_index,1} = Snacks{i_snack,2};
                
                output_index = output_index + 1;
                
                % write data to file
                filename = sprintf('TUE002_TasteTest_%06d_%01d_temp',subj.num, subj.sess);
                save(fullfile('Data', [filename '.mat']),'design','output','subj');
            end
        end
        
        if i_phase >= 2 && i_snack ~= nrS
            Screen('TextSize',w,large_text_size);
            Screen('TextFont',w,'Arial');
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, [ITI_text_2], 'center', 'center', [0 0 0],40);
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, mouseclick, 'center', wh-50, [0 0 0],60);
            Screen('Flip', w, []);
            
            % wait until mouse click
            GetClicks();
        end         
    end   
end

Screen('TextSize',w,large_text_size);
Screen('TextFont',w,'Arial');
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, 'Das Experiment ist nun beendet.', 'center', 'center', [0 0 0],40);
Screen('Flip', w, []);

% save result file
filename = sprintf('TT_TUE002_%06d_S%01d_R1',subj.num, subj.sess);
save(fullfile('Data', [filename '.mat']),'design','output','subj');
save(fullfile('Backup', [filename datestr(now,'_yymmdd_HHMM') '.mat']));
 
% reset screen preferences
ShowCursor
ListenChar(0);
Screen('CloseAll');