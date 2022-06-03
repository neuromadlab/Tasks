%%================== Food evaluation paradigm =============================
% For a description of the set of images, see Charbonnier (2015) Appetite
%
% Coded by: Nils Kroemer 
% Modified by Emily Corwin-Renner, Monja Neuser
% TUE008 version by María & Sophie
% Coded with: Matlab R2014a using Psychtoolbox 3.0.11
%
%==========================================================================

%% Part 1: Preparation
% try
% clear workspace
clear all; 
close all; 
sca;

% Set random seed:
seed = sum(100 * clock);
reset(RandStream.getGlobalStream,seed);

% paths and OS information
OS = computer;
exp_dir = pwd;

% Windows
% if OS == 'PCWIN64'
%     img_dir = [pwd '\SnackPics\'];
% % Linux or Mac
% else 
img_dir = [pwd '/SnackPics/'];
% end
addpath(img_dir);

% Specify parameters
subj.study='TUE008';
subj.run = '1'; 
subj.date_start = datestr(now);
subj.date = datestr(now, 'yyyymmdd-HHMM');
subj.version = 3;
subj.subjectID = input('Subject ID : ','s');
subj.sessionID = '1'; % only 1 Session TUE008, otherwise: input('Session ID: ','s');

% Convert ID to 6-digit format
subj.subjectID = pad(subj.subjectID,6,'left','0');

% Convert subj/sess IDs to integers
subj.id = str2double(subj.subjectID); 
subj.sess = str2double(subj.sessionID);

validInput = false;
while ~validInput
    i_rep = input('German? (Elsewise english) [y/n] ','s');
    if strcmp(i_rep,'y')
        settings.lang_de = true;
        validInput = true;
    elseif strcmp(i_rep,'n')
        settings.lang_de = false;
        validInput = true;
    else
        warning('Not a valid answer! Please try again.');
    end
end

% Here Controller Vs. mouse input could be chosen but for TUE008 set controller always to 1
control_joystick = 1;
% Load Gamepad Controller Specifications and query one time to generate variables
load('JoystickSpecification.mat');
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

% Screen preparation
Screen('Preference', 'SkipSyncTests', 1)
PsychDefaultSetup(2);
%ListenChar(2);
% Screen('Preference', SkipSyncTests', 2);
screens = Screen('Screens');
setup.screenNum = max(screens);

debug = 0; % Set here to 1 if you are debugging script

% hardware usage
% fullscreen only if experimental mode
if debug == 0
    settings.do_fullscreen = 1;
    settings.do_joystick = 0;
    settings.do_gamepad = 1;
else
    settings.do_fullscreen = 0;
    settings.do_joystick = 0;
    settings.do_gamepad = 0;
end

%% Part 2: Load stimuli images
% read image files 
img.d = imread([img_dir '184.jpg']); %pretzels
img.f = imread([img_dir '286.jpg']); % nic nocs
img.c = imread([img_dir '26.jpg']); %cookies
img.e = imread([img_dir '89.jpg']); %raisins
img.a = imread([img_dir '40.jpg']); %strawberry gummy bears
img.b = imread([img_dir '373.jpg']); % bread rings
img.g = imread([img_dir '217.jpg']); %rice cracker

order = {'d','f','b','g','e','c','a'};
order_names = {'pretzels','nic nocs','bread rings','rice cracker','raisins','cookies','gummy bears'};
for pic = 1:7
    all_img{pic} = img.(order{pic});
end

%% Part 3: Paradigm settings
% load jitters and initialize jitter counters
load('DelayJitter_mu_0.70_max_4_trials_192.mat');
jitter = Shuffle(DelayJitter);
count_jitter = 1;
%load('DelayJitter_mu_2_max_6_trials_250.mat');
load('DelayJitter_mu_3_max_12_trials_250.mat');
jitter_slider = Shuffle(DelayJitter);
count_jitter_slider = 1;

% background colour specs
color_scale_background = [255 255 255];
color_scale_anchors = [0 0 0];

% relative offset; positive values move the screen towards to top, negative towards the bottom
screen_offset_y = 0.01;
scale_offset_y = 0.25;
min_ISI = 0.1;

% when the subject is trying the snack in the second phase, after this
% amount of seconds the subject is summoned to continue with ratings
max_waiting_snack = 20;
max_waiting_rating = 5;
VAS_rating_duration = 20;

%% Part 4: Language, texts, instructions, and repetitions
normal_text_size = 40;
large_text_size = 44;
small_text_size = 27;%30;
fixation_cross_text_size = 64;

% load supplementary information
load('lang.mat')
if settings.lang_de == 1
    language = 'de';
else
    language = 'en';
end

if control_joystick == 1
    text_Cont = lang.text_Cont.joystick.(language);
else
    text_Cont = lang.text_Cont.mouse.(language);
end

fixation = '+';
fix1_count = 1;

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
        lang.phase.(language){j,1} = lang.phase.(language){2,1};
        lang.phase.(language){j,2} = lang.phase.(language){2,2};
        lang.phase.(language){j,3} = lang.phase.(language){2,3};
    end
end

%% Part 5: Screen 
if settings.do_fullscreen == 1
    w = Screen('OpenWindow',setup.screenNum,[255 255 255], []);
    Screen('Preference', 'SkipSyncTests', 0);
    HideCursor
else
    w = Screen('OpenWindow', 0, 255, [10 30 810 630]);
    Screen('Preference', 'SkipSyncTests', 1);
end
[ww, wh] = Screen('WindowSize', w);

setup.ScrWidth = ww;
setup.ScrHeight = wh;
% screen values
scale_x = ww/1024;
scale_y = wh/768;
x_cent = ww/2;
y_cent = wh/2;

% rectangle that frames pictures and task
img_fct = size(all_img{1},2)/size(all_img{1},1);
rating_scr_rect_y1 = 25;
rating_scr_rect_y2 = 175*2;
rating_scr_rect_x1 = (ww - 0.9*ww);
rating_scr_rect_x2 = (ww - 0.9*ww)+(rating_scr_rect_y2-rating_scr_rect_y1)*img_fct;
rating_scr_rect = [rating_scr_rect_x1 rating_scr_rect_y1 rating_scr_rect_x2 rating_scr_rect_y2];
highlighter_colour = [200 200 200];

% choose position of task text relative to rectangle
position_task_x = ww - 0.89*ww;
position_task_y = (rating_scr_rect_y2 + large_text_size)/2;

% compute size of image to fit into the rectangle
desired_img_height = (rating_scr_rect_y2 - rating_scr_rect_y1)/2;
desired_img_width = (rating_scr_rect_x2 - rating_scr_rect_x1)/2;

%% Part 6: Initialization before experiment loop
% initialization of other variables
rating = 0;
text_freerating = [];

% for each answer, one row in output struct is written
% after each loop, index is increased by one
output_index = 1;
output_index_bid = 1;

% compute number of rows/column of cell arrays
[nrP,ncP] = size(lang.phase.(language));
[nrS,ncS] = size(lang.snacks.(language));
[nrQ,ncQ] = size(lang.question.(language));

% Make textures from image files
for pic = 1:7
    imTexture{pic} = Screen('MakeTexture',w,all_img{pic});
end

%%% starting experiment
%% Part 7: Start of the experiment and timing
% saves timestamp of experimental loop onset
subj.trigger.fin = GetSecs;
% saves timestamp of subject starting the experiment with click 
KbQueueRelease();
subj.time.exp_on = GetSecs;       

%% Part 8: Experimental loop
% experiment involves two different phases
% 1. anticipation
% 2. consumption
% 3. and larger: repetitions of consumption phase
% participant runs for each phase through each snack

for i_phase = 1 : nrP
    
    % instruction screen 
    % show inter trial screen
    if i_phase == 1 
        Screen('TextSize',w,large_text_size);
        Screen('TextFont',w,'Arial');
        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(lang.instruct.header.(language), lang.phase.(language){i_phase,4}), 'center', wh/4, [0 0 0],60);
        Screen('TextSize',w,normal_text_size);
        Screen('TextFont',w,'Arial');
        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, lang.instruct.bid.(language), 'center', pos.y + 50, [0 0 0],60);
        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text_Cont, 'center', wh-50, [0 0 0],60);
        Screen('Flip', w, []);
    elseif i_phase == 5
        Screen('TextSize',w,large_text_size);
        Screen('TextFont',w,'Arial');
        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(lang.instruct.header.(language), lang.phase.(language){i_phase,4}), 'center', wh/4, [0 0 0],60);
        Screen('TextSize',w,normal_text_size);
        Screen('TextFont',w,'Arial');
        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, lang.instruct.bid_second.(language), 'center', pos.y + 50, [0 0 0],60);
        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text_Cont, 'center', wh-50, [0 0 0],60);
        Screen('Flip', w, []);
    elseif i_phase == 2
        Screen('TextSize',w,large_text_size);
        Screen('TextFont',w,'Arial');
        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(lang.instruct.header.(language), lang.phase.(language){i_phase,4}), 'center', wh/4, [0 0 0],60);
        Screen('TextSize',w,normal_text_size);
        Screen('TextFont',w,'Arial');
        if settings.lang_de
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(lang.instruct.text.de, 'des Aussehens und des Geruchs'), 'center', pos.y + 50, [0 0 0],60);
        else
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(lang.instruct.text.en, 'the appearance and the smell'), 'center', pos.y + 50, [0 0 0],60);
        end
        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text_Cont, 'center', wh-50, [0 0 0],60);
        Screen('Flip', w, []);
    else
        Screen('TextSize',w,large_text_size);
        Screen('TextFont',w,'Arial');
        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(lang.instruct.header.(language), lang.phase.(language){i_phase,4}), 'center', wh/4, [0 0 0],60);
        Screen('TextSize',w,normal_text_size);
        Screen('TextFont',w,'Arial');
        
        if settings.lang_de
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(lang.instruct.text.de, 'des Geschmacks'), 'center', pos.y + 50, [0 0 0],60);
        else
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(lang.instruct.text.en, 'the taste'), 'center', pos.y + 50, [0 0 0],60);
        end

        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text_Cont, 'center', wh-50, [0 0 0],60);
        Screen('Flip', w, []);
    end
    
    if control_joystick == 1
        %GetClicks(setup.screenNum);
        while Joystick.Button(1) ~= 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        end
        WaitSecs(0.5);
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    else
        [mouseX, mouseY, mousebuttons] = GetMouse(setup.screenNum);
        while mousebuttons(1)~=1
            [mouseX, mouseY, mousebuttons] = GetMouse(setup.screenNum);
        end
        WaitSecs(0.5)
        [mouseX, mouseY, mousebuttons] = GetMouse(setup.screenNum);
        % wait until mouse click
%         GetClicks();
    end
    
    % there are several different snacks (see above)
    % for each snack, every question is asked
    for i_snack = 1 : nrS
        trial.snack = order_names{i_snack};
        texture_i = imTexture{i_snack};
        
         % show inter trial screen
        if i_snack == 1 && i_phase >=2 && i_phase <=4
            Screen('TextSize',w,normal_text_size);
            Screen('TextFont',w,'Arial');
            if settings.lang_de
                [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(lang.ITI_text_1.de, 'ersten', lang.snacks.de{i_snack,5}), 'center', wh/2 - 100, [0 0 0],60);
            else
                [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(lang.ITI_text_1.en, 'first', lang.snacks.en{i_snack,5}), 'center', wh/2 - 100, [0 0 0],60);
            end
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text_Cont, 'center', wh-50, [0 0 0],60);
            Screen('FrameRect', w, highlighter_colour, rating_scr_rect,3);
             Screen('DrawTexture',w, texture_i,[], [rating_scr_rect]);

            Screen('Flip', w, []);
        elseif i_snack ~= 1 && i_phase >=2 && i_phase <=4
            Screen('TextSize',w,normal_text_size);
            Screen('TextFont',w,'Arial');
            if settings.lang_de
                [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(lang.ITI_text_1.de, 'nächsten', lang.snacks.de{i_snack,5}), 'center', wh/2 - 100, [0 0 0],60);
            else
                 [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(lang.ITI_text_1.en, 'next', lang.snacks.en{i_snack,5}), 'center', wh/2 - 100, [0 0 0],60);
            end
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text_Cont, 'center', wh-50, [0 0 0],60);

            Screen('FrameRect', w, highlighter_colour, rating_scr_rect,3);
            Screen('DrawTexture',w, texture_i,[], [rating_scr_rect]);
            Screen('Flip', w, []);
        end

        if control_joystick == 1 && i_phase >= 2 && i_phase <=4
            %GetClicks(setup.screenNum);
            while Joystick.Button(1) ~= 1
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            end
            WaitSecs(0.5);
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        elseif i_phase >= 2 && i_phase <=4
            % wait until mouse click
            GetClicks();
        end
        
        % slide emphasizing how the user needs to take some time to look
        % and smell the snacks in phase 2
        if i_phase == 2
            Screen('TextSize',w,normal_text_size);
            Screen('TextFont',w,'Arial');
            [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, sprintf(lang.ITI_text_3.(language), lang.snacks.(language){i_snack,5}), 'center', 'center', [0 0 0],60);
            Screen('FrameRect', w, highlighter_colour, rating_scr_rect,3);
            Screen('DrawTexture',w, texture_i,[], [rating_scr_rect]);

            Screen('Flip', w, []);
            
            % Wait until next slide is shown
            WaitSecs(7);
        end
        
        % in phase 3, all questions are asked twice per snack
        % in other phases, all questions are asked once per snack
        if i_phase == 3
            n_rep = 2;
        else 
            n_rep = 1;
        end
        
        % show fixation cross
        Screen('TextSize',w,fixation_cross_text_size);
        Screen('TextFont',w,'Arial');
        DrawFormattedText(w, fixation, 'center', 'center', [0 0 0],80);
        [ons_resp, starttime] = Screen('Flip', w);
        
        % saving how much time passed between experiment onset and first
        % fixation cross onset
        subj.onsets.fix1(fix1_count,1) = starttime - subj.trigger.fin;
        WaitSecs(min_ISI+jitter(count_jitter));
        count_jitter = count_jitter + 1;
        fix1_count = fix1_count + 1;
        
        for i_rep = 1 : n_rep
          
            
            if (i_phase == 3 || i_phase == 4) %&& i_rep == 1
                
                Screen('TextSize',w,large_text_size);
                Screen('TextFont',w,'Arial');
                if i_rep == 1
                    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, lang.single_phase_2.(language), 'center', 'center', [0 0 0],40);
                elseif i_rep == 2
                    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, lang.double_phase_2.(language), 'center', 'center', [0 0 0],40);
                end
                [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text_Cont, 'center', wh-50, [0 0 0],60);
                Screen('Flip', w, []);
                
                click_marker = 0;
                if control_joystick == 1
                    tic
                    while toc <= max_waiting_snack
                        while Joystick.Button(1) ~= 1
                            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
                        end   
                        until = toc;
                        click_marker = 1;
                        break
                    end
                    WaitSecs(0.5);
                    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
      
                else
                    [x,y,buttons] = GetMouse;
                    tic
                    while toc <= max_waiting_snack
                        while ~any(buttons)
                            [x,y,buttons] = GetMouse;
                        end
                        until = toc;
                        click_marker = 1;
                        break
                    end
                end
                
                if until > max_waiting_snack || click_marker == 1
                    % summon to go to ratings
                    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, lang.single_phase_summoning.(language), 'center', 'center', [0 0 0],40);
                    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text_Cont, 'center', wh-50, [0 0 0],60);
                    Screen('Flip', w, [])
                    
                    if control_joystick == 1
                        while Joystick.Button(1) ~= 1
                            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
                        end
                        WaitSecs(0.5);
                        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
                    else
                        % wait until mouse click
                        GetClicks();
                    end
                end
            end
            
            if i_phase == 1 || i_phase == 5
                text_freerating = order{i_snack};
                scale_type = 'willingnesspay';
                question_type = 'willingnesspay';
                trial.question = 'willingnesspay';
                pic = texture_i;
                
                scale_trigger = GetSecs;
                subj.onsets.scales.bid(output_index_bid,1) = scale_trigger - subj.trigger.fin;
                
                Effort_VAS
                
                if i_phase == 5
                    output.bidding.phase(output_index_bid,1) = i_phase + 1;
                else 
                    output.bidding.phase(output_index_bid,1) = i_phase;
                end
                output.bidding.snack_label{output_index_bid,1} = trial.snack;
                output.bidding.value(output_index_bid,1) = rating/100; %rescaling of scale_width independent of screen resolution [0-100]
                output.bidding.label{output_index_bid,1} = text_freerating;
                output.bidding.controller_pos{output_index_bid,1} = controller_positions; 
                output.bidding.timing(output_index_bid,1)  = t_rating_ref;
                if flag_resp == 1
                    output.bidding.subm(output_index_bid,1) = 1;                     
                % if no response was given, default values are saved in output
                elseif flag_resp == 0
                    output.bidding.subm(output_index_bid,1) = 0;
                end    
                
                subj.durations.scales.bid(output_index_bid,1) = GetSecs - (subj.onsets.scales.bid(output_index_bid,1) + subj.trigger.fin);
                
                % show fixation cross
                Screen('TextSize',w,fixation_cross_text_size);
                Screen('TextFont',w,'Arial');
                DrawFormattedText(w, fixation, 'center', 'center', [0 0 0],80);
                [ons_resp, starttime] = Screen('Flip', w);

                % saving how much time passed between experiment onset and
                % fixation cross onset
                subj.onsets.fix2(output_index_bid,1) = starttime - subj.trigger.fin;
                WaitSecs(min_ISI+jitter(count_jitter));
                count_jitter = count_jitter + 1;
                
                output_index_bid = output_index_bid + 1;
                
            elseif i_phase >= 2 && i_phase <=4 
                for i_rating = 1 : nrQ 

                    % save in which phase the participant is in current trial                  
                    % re-code Phase 2, first run to Phase 2
                    % re-code Phase 2, second run to Phase 3
                    if i_phase == 3
                        output.rating.phase(output_index,1) = i_phase + (i_rep-1);
                    % re-code Phase 3 to Phase 4
                    elseif i_phase == 4
                        output.rating.phase(output_index,1) = i_phase + 1;
                    else
                        output.rating.phase(output_index,1) = i_phase;
                    end

                    % show fixation cross
                    Screen('TextSize',w,fixation_cross_text_size);
                    Screen('TextFont',w,'Arial');
                    DrawFormattedText(w, fixation, 'center', 'center', [0 0 0],80);
                    [ons_resp, starttime] = Screen('Flip', w);

                    % saving how much time passed between experiment onset and
                    % fixation cross onset
                    subj.onsets.fix2(output_index_bid + output_index,1) = starttime - subj.trigger.fin;
                    WaitSecs(min_ISI+jitter(count_jitter));
                    count_jitter = count_jitter + 1;

                    scale_trigger = GetSecs;
                    subj.onsets.scales.rate(output_index_bid + output_index,1) = scale_trigger - subj.trigger.fin;

                    % depending on experimental block, set values
                    trial.question = lang.question.(language){i_rating};
                    trial.phase = lang.phase.(language){i_phase,2};
                    text.task = [lang.phase.(language){i_phase,4}, '.'];

                    if i_phase == 2
                        text.question = lang.question.(language){i_rating, 2}
                    elseif i_phase > 2
                        text.question = lang.question.(language){i_rating, 3};
                    end
                    
                    text_freerating = order{i_snack};                                   

                    if i_rating == 1
                        scale_type = 'wanting';
                        question_type = 'wanting';
                        trial.question = 'wanting';                        
                    elseif i_rating == 2
                        scale_type = 'liking';
                        question_type = 'liking';
                        trial.question = 'liking';
                    elseif i_rating >= 3 
                        scale_type = 'taste';
                        question_type = 'taste';
                        trial.question = 'taste';
                    end
                    
                    Effort_VAS
                    output.rating.value(output_index,1) = rating; %rescaling of scale_height independent of screen resolution [0-100]
                    output.rating.label{output_index,1} = text_freerating;
                    output.rating.subm(output_index,1) = rating_subm;
                    output.rating.timing(output_index,1) = t_rating_ref;

                    subj.durations.scales.rate(output_index,1) = GetSecs - (subj.onsets.scales.rate(output_index_bid + output_index,1) + subj.trigger.fin);

                    % if no response was given, default values are saved in output
                    if flag_resp == 0 && i_rating == nrQ
                        output.rating.subm(output_index,1) = 0;
                    end

                    % saving in output which scale and which snack was used
                    output.rating.scale_label{output_index,1} = lang.question.(language){i_rating,1};
                    output.rating.snack_label{output_index,1} = order_names{i_snack};

                    output_index = output_index + 1;                  
                end
                 % write data to file
                    filename = sprintf('TT_%s_%06d_S%01d_R%s_temp_', subj.study, subj.id, subj.sess, subj.run);
                    save(fullfile('Backup', [filename datestr(subj.date_start,'yymmdd_HHMM') '.mat']),'output','subj');
                
            end
        
            if i_phase > 2 && i_phase < 5 && i_snack ~= nrS
                
                Screen('TextSize',w,large_text_size);
                Screen('TextFont',w,'Arial');
                if ~(i_phase == 3 && i_rep == 1)
                    [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, [lang.ITI_text_2.(language)], 'center', 'center', [0 0 0],40);
                end
                [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text_Cont, 'center', wh-50, [0 0 0],60);
                Screen('Flip', w, []);


                if control_joystick == 1
                    while Joystick.Button(1) ~= 1
                        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
                    end
                    WaitSecs(0.5);
                    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
                else
                    % wait until mouse click
                    GetClicks();
                end           

            end         
        end
    end
end

%% Part 9: Winning trial
% Announce result of willingness to pay
        % Get bid for winning trial
        output.bidding.win_item_idx = randperm(nrS,1); % item chosen randomly
        bidding_second = output.bidding.value(output.bidding.phase == 6); % use only results from second bidding
        output.bidding.win_bid = bidding_second(output.bidding.win_item_idx);
        
        probability_win = 1/(1+exp((-(output.bidding.win_bid-1.10))/0.18)); %probability to win using sigmoid function

        % Inspect the Sigmoid function that is used here 
        % fplot(@(x) 1/(1+exp((-(x-1.10))/0.18)), [0 2])

        % Random probability (winning border)
        coinflip  = rand;
        if coinflip <= probability_win
            output.bidding.reward_won = 1;
            % Calculate amount
            value = output.bidding.win_bid;
            value_text = [num2str(value), ' Euro'];
        else
            output.bidding.reward_won = 0;
            value_text = 'nicht gewonnen';
        end
        
% Show results screen
        Screen('TextSize',w,normal_text_size);
        Screen('TextFont',w,'Arial');
        if output.bidding.reward_won == 0
            if settings.lang_de == 1
                text_question = 'Der folgende Artikel wurde ausgewaehlt. Leider war Ihr Gebot nicht ausreichend, um den Artikel zu erwerben.';
            else
                text_question = 'The following item was chosen. Your offer was unfortunately not high enough to receive the item.'; 
            end
            DrawFormattedText(w, text_question, 'center', wh-250, [0,0,0],60);
            % Place image
            Scale_width = round(setup.ScrWidth * .50);
            Scale_offset = round((setup.ScrHeight - (setup.ScrHeight * .95)) * .75);
            Screen('DrawTexture',w, imTexture{output.bidding.win_item_idx},[],[(setup.ScrWidth/2-desired_img_width*2) (Scale_offset+setup.ScrHeight/2-desired_img_height*5+300) (setup.ScrWidth/2+desired_img_width*2) (Scale_offset+setup.ScrHeight/2-desired_img_height+300)]);
            %[Pic, map, alpha] = imread([image_path filesep WillPay_Stimuli{wtpt.reward_index,1}]);
            %Screen('PutImage', w, Pic, [(setup.ScrWidth/2-Scale_width/2) (Scale_offset+setup.ScrHeight/2 - 400) (setup.ScrWidth/2+Scale_width/2) (setup.ScrHeight-setup.ScrHeight/3+100)]);
            
        elseif output.bidding.reward_won == 1
            if settings.lang_de == 1
                text_question = ['Der folgende Artikel wurde ausgewaehlt. Ihr Gebot war ausreichend. Sie haben den Artikel fuer ' value_text ' erworben!'];
            else
                text_question = ['The following item was chosen. Your offer was high enough. You will receive the item for ' value_text '!']; 
            end
            DrawFormattedText(w, text_question, 'center', wh-250, [0,0,0],60);
            % Place image
            Scale_width = round(setup.ScrWidth * .50);
            Scale_offset = round((setup.ScrHeight - (setup.ScrHeight * .95)) * .75);
            Screen('DrawTexture',w, imTexture{output.bidding.win_item_idx},[],[(setup.ScrWidth/2-desired_img_width*2) (Scale_offset+setup.ScrHeight/2-desired_img_height*5+300) (setup.ScrWidth/2+desired_img_width*2) (Scale_offset+setup.ScrHeight/2-desired_img_height+300)]);
%             [Pic, map, alpha] = imread([image_path filesep WillPay_Stimuli{wtpt.reward_index,1}]);
%             Screen('PutImage', w, Pic, [(setup.ScrWidth/2-Scale_width/2) (Scale_offset+setup.ScrHeight/2 - 400) (setup.ScrWidth/2+Scale_width/2) (setup.ScrHeight-setup.ScrHeight/3+100)]);
        end
        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text_Cont, 'center', wh-50, [0 0 0],60);
        Screen('Flip',w);
        
         if control_joystick == 1
            %GetClicks(setup.screenNum);
            while Joystick.Button(1) ~= 1
                [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            end
            WaitSecs(0.5);
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        else
            % wait until mouse click
            GetClicks();
        end

%% Part 10: End of experiment
Screen('TextSize',w,normal_text_size);
Screen('TextFont',w,'Arial');
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, lang.end_text.(language), 'center', 'center', [0 0 0],40);
Screen('Flip', w, []);
WaitSecs(2)
ShowCursor
%ListenChar(0);
Screen('CloseAll');

%% Part 11: Save experiment data
subj.date_end      = datestr(now);
t_start=datevec(datenum(subj.date_start));
t_end=datevec(datenum(subj.date_end ));
subj.length_exp = etime(t_end, t_start)/60; %length exp in min

% save result file
filename = sprintf('TT_%s_%06d_S%01d_R%s', subj.study, subj.id, subj.sess, subj.run);
save(fullfile('Data', [filename '.mat']),'output','subj');
save(fullfile('Backup', [filename datestr(now,'_yymmdd_HHMM') '.mat']));

disp(append('Item gewonnen: ', num2str(output.bidding.reward_won), ' (1=gewonnen/0=nicht gewonnen), Gebot: ', value_text, ' Snack: ', output.bidding.snack_label(output.bidding.win_item_idx))) 
% reset screen preferences

% catch
%     ShowCursor
%     sca
%     ListenChar(0);
% end
