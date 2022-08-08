%%===================Food evaluation paradigm===================
%For a description of the set of images, see Charbonnier (2015) Appetite

%Coded by: Nils Kroemer 
%Modified by Emily Corwin-Renner, Monja Neuser
%Coded with: Matlab R2014a using Psychtoolbox 3.0.11

%========================================================
clear

%debugging settings
% subjn = 9999;
% sess = 1;
%scan_id = '014_90002';

%%get input from the MATLAB console
subj.studyID='TUE002';
subj.subjectID=input('Subject ID : ','s');
subj.sessionID=input('Session ID: ','s');

%Convert ID to 6-digit format
subj.subjectID = pad(subj.subjectID,6,'left','0');

%Convert subj/sess IDs to integers
subj.num = str2double(subj.subjectID); 
subj.sess = str2double(subj.sessionID);


%% Paradigm settings

%pic_dur = 2; %sets duration for the display of the pictures
do_fullscreen = 0; %will show window as fullscreen (default second monitor, if connected)
do_joystick = 0;
do_gamepad = 0;
do_fmri_flag = 0; %will include trigger
    dummy_volumes = 2; %will have to be set according to the sequence
%    keyTrigger=KbName('s');
 %   keyTrigger2=KbName('5');
  %  keyQuit=KbName('q');
 %   keyResp=KbName('1');
  %  keyResp2=KbName('1!');
    count_trigger = 0;
    
do_scales = 1; %will run scale in prob_scales*100% of trials
    feedback_delay = 0.20; %for scales
    preset = 1; %will skip separate initialization of scales
    max_dur_rating = 2.8; %after the specified seconds, the rating screen will terminate
    color_scale_background = [255 255 255]; %white
    color_scale_anchors = [0 0 0]; %black
    lang_de = 1; %changes display language to German
    
screen_offset_y = 0.01; %relative offset; positive values move the screen towards to top, negative towards the bottom
scale_offset_y = 0.25;
min_ISI = 0.1;

%% Stimulus preparation


%%

%vector containing possible questions
anticipationquestions = [ 'appetite', 'wanttoeat'];
% anticipationvector = repmat(anticipationquestions,1,6);% deson't work like this - need another way to make 6 copies of the anticipationquestions
anticipationvector = [ 'appetite', 'wanttoeat', 'appetite', 'wanttoeat', 'appetite', 'wanttoeat','appetite', 'wanttoeat', 'appetite', 'wanttoeat', 'appetite', 'wanttoeat'];
% tastequestions = [ tastegood; sweet; salty; spicy; intense; wantmore ];
% tastevector = repmat(tastequestions, 18, 1);

%%


% n_trials = 80; %sets the number of trials

%load('JoystickSpecification_Genius.mat');
load('JoystickSpecification.mat');

Screen('Preference', 'SkipSyncTests', 1);
screens = Screen('Screens'); %Define display screen
screenNumber = max(screens);
if do_fullscreen == 1
    w = Screen(screenNumber,'OpenWindow',[255 255 255]);
    HideCursor
else
    w = Screen('OpenWindow', 0, 255, [10 30 810 630]);
    Screen('Preference', 'SkipSyncTests', 1);
end
[ww, wh]=Screen('WindowSize', w);

%initialize output variables
%out_resp = zeros(n_trials,1); %stores the number of button presses

subj.time.trial = zeros(length(anticipationvector),1); %stores total trial time
% subj.time.trial = zeros(n_trials,1); %stores total trial time

%initialize settings
%s = RandStream('mt19937ar','Seed','shuffle'); %reseed for MATLAB2014
%RandStream.setGlobalStream(s);

%load jitters and initialize jitter counters
load('DelayJitter_mu_0.70_max_4_trials_180.mat');
jitter = Shuffle(DelayJitter);
%load('DelayJitter_mu_4_max_15_trials_48.mat');
%jitter_4s = Shuffle(DelayJitter);
count_jitter = 1;
%count_jitter_4s = 1;

%load condition matrix
part_file = sprintf('Order/cond_mat_%04d.mat',subj.num);
load(part_file);

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
          
%instructions while subject is waiting for the trigger
if lang_de == 1
    instruct.text = ['In der folgenden Aufgabe sehen Sie in zufälliger Abfolge entweder Bilder mit Essen ' ...
                     '\n\n oder Büromaterialien. Danach bitten wir Sie jeweils anzugeben, wie sehr Sie' ...
                     '\n\n das dargestellte Objekt als Belohnung in diesem Moment gern erhalten würden,' ...
                     '\n\n bzw. wie sehr Sie das dargestellte Objekt als Belohnung mögen.' ...
                     '\n\n Wie sehr Sie das Objekt erhalten wollen, bzw. mögen wird mittels verschiedener Skalen ' ...
                     '\n\n abgefragt werden: Bitte nutzen Sie die horizontale Skala, um anzugeben, wie sehr Sie ' ...
                     '\n\n die Belohnung in diesem Moment erhalten möchten und die vertikale Skala, um anzugeben, ' ...
                     '\n\n wie sehr Sie die dargestellte Belohnung in diesem Moment mögen.' ...
                     '\n\n Welche Skala jeweils nach einem Bild erscheint, wird zufällig ausgewählt. ' ...
                    ];

else
    instruct.text = [];
%     ['Today, you will work for rewards like you practiced.' ...
%     '\n\n You will always see the reward tree. Sometimes, only the rewards'...
%     '\n\n appear at first. Other times, only your avatar will appear at first. ' ... 
%     '\n\n Start pressing only AFTER you can see both your avatar and the rewards.' ...
%     '\n\n The faster you press the button, the more likely it is you will get the' ...
%     '\n\n rewards shown. The number of coins or fruit indicates ' ...
%     '\n\n the amount of the reward. The distance of the avatar to the tree' ...
%     '\n\n indicates how much effort is needed to obtain the reward.' ...
%     '\n\n Today, you will not see your avatar move, only the outcome.' ...
%     '\n\n If you win, a red or brown circle means you will receive milkshake.' ...
%     '\n\n A yellow circle with a number inside means you have earned that many coins.' ...
%     '\n\n The water drop indicates a rinse is coming. Please swallow' ...
%     '\n\n only after you have received the rinse at the end of the trial.' ...
%     '\n\n An open circle will appear when you should swallow.'];

end 

Screen('TextSize',w,28);
Screen('TextFont',w,'Arial');
[pos.x,pos.y,pos.bbox] = DrawFormattedText(w, instruct.text, 'center', 'center', [0 0 0],150);
[ons_resp, starttime] = Screen('Flip', w, []);

GetClicks;

%%%%%%%start of the experiment
time.on_trigger_loop = GetSecs;

if do_fmri_flag == 1
    KbQueueCreate();
    KbQueueFlush(); 
	KbQueueStart(); 
	[ons_resp, starttime] = Screen('Flip', w, []);
    [b,c] = KbQueueCheck;
    
    while c(keyQuit) == 0
        [b,c] = KbQueueCheck;
        if c(keyTrigger) || c(keyTrigger2) > 0
            count_trigger = count_trigger + 1;
            subj.trigger.all(count_trigger,1) = GetSecs;
            if count_trigger > dummy_volumes
                subj.trigger.fin = GetSecs;
                break
            end
        end
    end
end   

if do_fmri_flag == 0

    subj.trigger.fin = GetSecs;
end
    
KbQueueRelease();
subj.time.exp_on = GetSecs;



%%

for i=1:length(anticipationvector)
    
    image_path = sprintf('Stimuli/%s', design.rand.image_file{i,subj.sess});
    [Pic, map, alpha] = imread(image_path);
        
    %Texture_Pic = Screen('MakeTexture', w, Pic);
    
    %Screen('DrawTexture', w, Texture_Pic, [], [0 0 ww wh]);
    
    Screen('PutImage', w, Pic, [0 0 ww wh]);
    [ons_resp, starttime] = Screen('Flip', w);
    subj.onsets.image(i,1) = starttime - subj.trigger.fin;
    
    WaitSecs(pic_dur);
    
    fixation = '+';
    Screen('TextSize',w,64);
    Screen('TextFont',w,'Arial');
    DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);
    
    [ons_resp, starttime] = Screen('Flip', w);
    subj.onsets.fix1(i,1) = starttime - subj.trigger.fin;
    
    WaitSecs(min_ISI+jitter(count_jitter));
    count_jitter = count_jitter + 1;
    
    subj.time.scale_trigger = GetSecs;
    subj.onsets.scales.all(i,1) = subj.time.scale_trigger - subj.trigger.fin;
            
%     if design.rand.full_flip_coin(i,subj.sess) == 0
%         rating_type_num = 0;
%         output.rating.type_num(i,1) = rating_type_num;
%         subj.onsets.scales.LHS(i,1) = GetSecs - subj.trigger.fin;
%         if do_joystick == 1
%             LHS_vertical_joystick
%         elseif do_gamepad == 1
%             LHS_vertical_gamepad
%         else
%             LHS_vertical
%         end
%         subj.durations.scales.LHS(i,1) = GetSecs - (subj.onsets.scales.LHS(i,1) + subj.trigger.fin);
%         subj.durations.scales.all(i,1) = GetSecs - (subj.onsets.scales.all(i,1) + subj.trigger.fin);
%             
%     else
        rating_type_num = 1;
        output.rating.type_num(i,1) = rating_type_num;
        subj.onsets.scales.VAS(i,1) = GetSecs - subj.trigger.fin;
        if do_joystick == 1
            VAS_horz_joystick
        elseif do_gamepad == 1
            VAS_horz_gamepad
        else
            VAS_horz_TT_new
        end
        subj.durations.scales.VAS(i,1) = GetSecs - (subj.onsets.scales.VAS(i,1) + subj.trigger.fin) ;
        subj.durations.scales.all(i,1) = GetSecs - (subj.onsets.scales.all(i,1) + subj.trigger.fin);
%     end
       
    fixation = '+';
    Screen('TextSize',w,64);
    Screen('TextFont',w,'Arial');
    DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);
    
    [ons_resp, starttime] = Screen('Flip', w);
    subj.onsets.fix2(i,1) = starttime - subj.trigger.fin;
    
    if flag_resp == 1
        WaitSecs((max_dur_rating-subj.durations.scales.all(i,1))+jitter(count_jitter));
    else
        WaitSecs((0.5-feedback_delay)+jitter(count_jitter));
    end
    
    if flag_resp == 0
        output.rating.value(i,1) = rating;
        output.rating.label{i,1} = text_freerating;
        output.rating.subm(i,1) = 0;
        output.rating.type_num(i,1) = rating_type_num;
    end
    
    
    filename = sprintf('FCR_beh_%04d_%01d_temp',subj.num, subj.sess);
    save(fullfile('Data', [filename '.mat']),'design','output','subj','time');
    
    
    count_jitter = count_jitter + 1;
            
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
 