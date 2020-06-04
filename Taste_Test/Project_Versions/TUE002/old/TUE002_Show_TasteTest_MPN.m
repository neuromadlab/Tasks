%%===================Food evaluation paradigm===================
%For a description of the set of images, see Charbonnier (2015) Appetite

%Coded by: Nils Kroemer 
%Modified by Emily Corwin-Renner, Monja Neuser
%Coded with: Matlab R2014a using Psychtoolbox 3.0.11

%========================================================


clear all; close all; sca;

%debugging settings
debug = 1; %set to 0 for real experiment
subj.debug_ID = '9999';
subj.debug_sess = '99';
subj.debug_scan_id = '014_90002';

%Screen('Preference', SkipSyncTests', 2);
load('JoystickSpecification.mat')

% Change settings
screens = Screen('Screens');
screenNumber = max(screens);


do_fullscreen = 0; %will show window as fullscreen (default second monitor, if connected)
do_joystick = 0;
do_gamepad = 0;



%% Initialize subject info: get input from the MATLAB console

subj.studyID='TUE002';
if debug == 0
    subj.subjectID=input('Subject ID : ','s');
    subj.sessionID=input('Session ID: ','s');
else
    subj.subjectID = subj.debug_ID;
    subj.sessionID = subj.debug_sess;
end

%Convert ID to 6-digit format
subj.subjectID = pad(subj.subjectID,6,'left','0');

%Convert subj/sess IDs to integers
subj.num = str2double(subj.subjectID); 
subj.sess = str2double(subj.sessionID);



%% Paradigm settings
   
    do_scales = 1; %will run scale in prob_scales*100% of trials
    feedback_delay = 0.20; %for scales
    preset = 1; %will skip separate initialization of scales
    max_dur_rating = 60; %after the specified seconds, the rating screen will terminate
    color_scale_background = [255 255 255]; %white
    color_scale_anchors = [0 0 0]; %black
    lang_de = 1; %changes display language to German
    
    screen_offset_y = 0.01; %relative offset; positive values move the screen towards to top, negative towards the bottom
    scale_offset_y = 0.25;
    min_ISI = 0.1;

%load jitters and initialize jitter counters
load('DelayJitter_mu_0.70_max_4_trials_180.mat');
jitter = Shuffle(DelayJitter);

count_jitter = 1;

%load condition matrix
%part_file = sprintf('Order/cond_mat_%04d.mat',subj.num);
%load(part_file);



%% Stimulus preparation
%Snacks presented in the Tates Test
Snacks = {  'Nic Nacs', 'Nic Nacs', 'salty';
            'Cracker', 'Cracker', 'salty';
            'Chips', 'Chips', 'salty';
            'Cookies', 'Kekse', 'sweet';
            'Sweets', 'Gummibärchen', 'sweet';
            'Big Bens', 'M&Ms', 'sweet' };

%Paradigm will include two phases of ratings for each Snack        
Phase = {   '1', 'anticipation', 'Beschreiben Sie das Aussehen:';
            '2', 'consumption', 'Beschreiben Sie den Geschmack:' };
        
Question = { 'appetite';
            'craving' };


        
%load('JoystickSpecification.mat');

% Open Screen
% screens = Screen('Screens'); %Define display screen

if do_fullscreen == 1
    w = Screen(screenNumber,'OpenWindow',[255 255 255]);
    HideCursor
else
    w = Screen('OpenWindow', 0, 255, [10 30 810 630]);
    Screen('Preference', 'SkipSyncTests', 1);
end
[ww, wh]=Screen('WindowSize', w);


subj.time.trial = zeros(length(Snacks),1); %stores total trial time




%RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock))); %resets the seed for the random number generator
  
%scale images according to screen settings window width, ww, and window
%height, wh
scale_x = ww/1024;
scale_y = wh/768;
x_cent = ww/2;
y_cent = wh/2;

%initialize VARs
rating = 0;
text_freerating = [];










%% Start Paradigm

% Instructions 
if lang_de == 1
    
    instruct.text = ['Bitte bewerten Sie die Snacks nacheinander ' ...
                     '\n\n ...' ];
else
    instruct.text = [];
%     ['Please rate the snacks,...' ...
%     '\n\n ...' ];

end 

Screen('TextSize',w,28);
Screen('TextFont',w,'Arial');
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text, 'center', 'center', [0 0 0],150);
[ons_resp, starttime] = Screen('Flip', w, []);

GetClicks;

%%%%%%%start of the experiment
time.on_trigger_loop = GetSecs;

subj.trigger.fin = GetSecs;
   
KbQueueRelease();
subj.time.exp_on = GetSecs;



%%
for i_phase = 1 : length(Phase)
    
for i_Snack=1:length(Snacks)
    
    for i_rating = 1 : length(Question)
    
    %image_path = sprintf('Stimuli/%s', design.rand.image_file{i_Snack,subj.sess});
    %[Pic, map, alpha] = imread(image_path);
        
    %Texture_Pic = Screen('MakeTexture', w, Pic);
    
    %Screen('DrawTexture', w, Texture_Pic, [], [0 0 ww wh]);
    
    %Screen('PutImage', w, Pic, [0 0 ww wh]);
%     [ons_resp, starttime] = Screen('Flip', w);
%     subj.onsets.image(i_Snack,1) = starttime - subj.trigger.fin;
    
   % WaitSecs(pic_dur);
    
    fixation = '+';
    Screen('TextSize',w,64);
    Screen('TextFont',w,'Arial');
    DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);
    
    [ons_resp, starttime] = Screen('Flip', w);
    subj.onsets.fix1(i_Snack,1) = starttime - subj.trigger.fin;
    
    WaitSecs(min_ISI+jitter(count_jitter));
    count_jitter = count_jitter + 1;
    
    subj.time.scale_trigger = GetSecs;
    subj.onsets.scales.all(i_Snack,1) = subj.time.scale_trigger - subj.trigger.fin;
            

        rating_type_num = 1;
        output.rating.type_num(i_Snack,1) = rating_type_num;
        subj.onsets.scales.VAS(i_Snack,1) = GetSecs - subj.trigger.fin;
        
        if do_joystick == 1
            VAS_horz_joystick
        elseif do_gamepad == 1
            VAS_horz_gamepad
        else
            VAS_horz_TT
        end
        subj.durations.scales.VAS(i_Snack,1) = GetSecs - (subj.onsets.scales.VAS(i_Snack,1) + subj.trigger.fin) ;
        subj.durations.scales.all(i_Snack,1) = GetSecs - (subj.onsets.scales.all(i_Snack,1) + subj.trigger.fin);
%     end
       
    fixation = '+';
    Screen('TextSize',w,64);
    Screen('TextFont',w,'Arial');
    DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);
    
    [ons_resp, starttime] = Screen('Flip', w);
    subj.onsets.fix2(i_Snack,1) = starttime - subj.trigger.fin;
    
    if flag_resp == 1
        WaitSecs((max_dur_rating-subj.durations.scales.all(i_Snack,1))+jitter(count_jitter));
    else
        WaitSecs((0.5-feedback_delay)+jitter(count_jitter));
    end
    
    if flag_resp == 0
        output.rating.value(i_Snack,1) = rating;
        output.rating.label{i_Snack,1} = text_freerating;
        output.rating.subm(i_Snack,1) = 0;
        output.rating.type_num(i_Snack,1) = rating_type_num;
    end
    
    
    filename = sprintf('TUE002_TasteTest_%06d_%01d_temp',subj.num, subj.sess);
    save(fullfile('Data', [filename '.mat']),'design','output','subj','time');
    
    
    count_jitter = count_jitter + 1;
            
    end

end

end
%%

% for i=1:n_trials
%     
%     image_path = sprintf('Stimuli/%s', design.rand.image_file{i,subj.sess});
%     [Pic, map, alpha] = imread(image_path);
%         
%     %Texture_Pic = Screen('MakeTexture', w, Pic);
%     
%     %Screen('DrawTexture', w, Texture_Pic, [], [0 0 ww wh]);
%     
%     Screen('PutImage', w, Pic, [0 0 ww wh]);
%     [ons_resp, starttime] = Screen('Flip', w);
%     subj.onsets.image(i,1) = starttime - subj.trigger.fin;
%     
%     WaitSecs(pic_dur);
%     
%     fixation = '+';
%     Screen('TextSize',w,64);
%     Screen('TextFont',w,'Arial');
%     DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);
%     
%     [ons_resp, starttime] = Screen('Flip', w);
%     subj.onsets.fix1(i,1) = starttime - subj.trigger.fin;
%     
%     WaitSecs(min_ISI+jitter(count_jitter));
%     count_jitter = count_jitter + 1;
%     
%     subj.time.scale_trigger = GetSecs;
%     subj.onsets.scales.all(i,1) = subj.time.scale_trigger - subj.trigger.fin;
%             
% %     if design.rand.full_flip_coin(i,subj.sess) == 0
% %         rating_type_num = 0;
% %         output.rating.type_num(i,1) = rating_type_num;
% %         subj.onsets.scales.LHS(i,1) = GetSecs - subj.trigger.fin;
% %         if do_joystick == 1
% %             LHS_vertical_joystick
% %         elseif do_gamepad == 1
% %             LHS_vertical_gamepad
% %         else
% %             LHS_vertical
% %         end
% %         subj.durations.scales.LHS(i,1) = GetSecs - (subj.onsets.scales.LHS(i,1) + subj.trigger.fin);
% %         subj.durations.scales.all(i,1) = GetSecs - (subj.onsets.scales.all(i,1) + subj.trigger.fin);
% %             
% %     else
%         rating_type_num = 1;
%         output.rating.type_num(i,1) = rating_type_num;
%         subj.onsets.scales.VAS(i,1) = GetSecs - subj.trigger.fin;
%         if do_joystick == 1
%             VAS_horz_joystick
%         elseif do_gamepad == 1
%             VAS_horz_gamepad
%         else
%             VAS_horz_TT_new
%         end
%         subj.durations.scales.VAS(i,1) = GetSecs - (subj.onsets.scales.VAS(i,1) + subj.trigger.fin) ;
%         subj.durations.scales.all(i,1) = GetSecs - (subj.onsets.scales.all(i,1) + subj.trigger.fin);
% %     end
%        
%     fixation = '+';
%     Screen('TextSize',w,64);
%     Screen('TextFont',w,'Arial');
%     DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);
%     
%     [ons_resp, starttime] = Screen('Flip', w);
%     subj.onsets.fix2(i,1) = starttime - subj.trigger.fin;
%     
%     if flag_resp == 1
%         WaitSecs((max_dur_rating-subj.durations.scales.all(i,1))+jitter(count_jitter));
%     else
%         WaitSecs((0.5-feedback_delay)+jitter(count_jitter));
%     end
%     
%     if flag_resp == 0
%         output.rating.value(i,1) = rating;
%         output.rating.label{i,1} = text_freerating;
%         output.rating.subm(i,1) = 0;
%         output.rating.type_num(i,1) = rating_type_num;
%     end
%     
%     
%     filename = sprintf('FCR_beh_%04d_%01d_temp',subj.num, subj.sess);
%     save(fullfile('Data', [filename '.mat']),'design','output','subj','time');
%     
%     
%     count_jitter = count_jitter + 1;
%             
% end

%last fixation
fixation = '+';
Screen('TextSize',w,64);
DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);
[ons_resp, starttime] = Screen('Flip', w);
subj.onsets.fix_fin = starttime - subj.trigger.fin;

if do_fmri_flag == 1
    WaitSecs(15-(1+jitter(count_jitter-1)));
else
    WaitSecs(1+jitter(count_jitter-1));
end

%subj.onsets.fix_fin = GetSecs - subj.trigger.fin;

filename = sprintf('FCR_beh_%02d_%01d',subj.num, subj.sess);
save(fullfile('Data', [filename '.mat']),'design','output','subj','time');
save(fullfile('Backup', [filename datestr(now,'_yymmdd_HHMM') '.mat']));

ShowCursor

Screen('CloseAll');
 