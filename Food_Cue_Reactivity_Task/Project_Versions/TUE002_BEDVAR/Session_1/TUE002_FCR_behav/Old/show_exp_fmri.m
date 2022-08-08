%%===================Food evaluation paradigm===================
%For a description of the set of images, see Charbonnier (2015) Appetite

%Coded by: Nils Kroemer 
%Coded with: Matlab R2014a using Psychtoolbox 3.0.11

%========================================================
clear

%paradigm settings
pic_dur = 3; %sets duration for the display of the pictures
do_fullscreen = 1; %will show window as fullscreen (default second monitor, if connected)
do_joystick = 1;
do_fmri_flag = 1; %will include trigger
    dummy_volumes = 2; %will have to be set according to the sequence
    keyTrigger=KbName('s');
    keyTrigger2=KbName('5');
    keyQuit=KbName('q');
    keyResp=KbName('1');
    keyResp2=KbName('1!');
    count_trigger = 0;
    
do_scales = 1; %will run scale in prob_scales*100% of trials
    feedback_delay = 0.25; %for scales
    preset = 1; %will skip separate initialization of scales
    max_dur_rating = 4; %after the specified seconds, the rating screen will terminate
    color_scale_background = [255 255 255]; %white
    color_scale_anchors = [0 0 0]; %black
    
screen_offset_y = 0.0001; %relative offset; positive values move the screen towards to top, negative towards the bottom
scale_offset_y = 0.25;

%debugging settings
subjn = 0002;
scan_id = '014_90002';
n_trials = 80; %sets the number of trials
sess = 2;
%load('JoystickSpecification_Genius.mat');
load('JoystickSpecification.mat');

%Screen('Preference', 'SkipSyncTests', 1);
screens = Screen('Screens'); %Define display screen
screenNumber = max(screens);
if do_fullscreen == 1
    w = Screen(screenNumber,'OpenWindow',[255 255 255]);
    HideCursor
else
    w = Screen('OpenWindow', 0, 255, [10 30 610 430]);
    Screen('Preference', 'SkipSyncTests', 1);
end
[ww, wh]=Screen('WindowSize', w);

%initialize output variables
%out_resp = zeros(n_trials,1); %stores the number of button presses

subj.time.trial = zeros(n_trials,1); %stores total trial time

%initialize settings
%s = RandStream('mt19937ar','Seed','shuffle'); %reseed for MATLAB2014
%RandStream.setGlobalStream(s);

%load jitters and initialize jitter counters
load('DelayJitter_mu_3_max_12_trials_160.mat');
jitter_3s = Shuffle(DelayJitter);
%load('DelayJitter_mu_4_max_15_trials_48.mat');
%jitter_4s = Shuffle(DelayJitter);
count_jitter_3s = 1;
%count_jitter_4s = 1;

%load condition matrix
part_file = sprintf('Order/cond_mat_%04d.mat',subjn);
load(part_file);

RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock))); %resets the seed for the random number generator
  
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
text_inst = ['tb written'];

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


Screen('TextSize',w,16);
Screen('TextFont',w,'Arial');
[positionx,positiony,bbox] = DrawFormattedText(w, text_inst, 'center', 'center', [0 0 0],150);

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

KbQueueRelease();
subj.time.exp_on = GetSecs;

for i=1:n_trials
    
    image_path = sprintf('Stimuli/%d.jpg', design.rand.rand_image_mat(i,sess));
    [Pic, map, alpha] = imread(image_path);
        
    %Texture_Pic = Screen('MakeTexture', w, Pic);
    
    %Screen('DrawTexture', w, Texture_Pic, [], [0 0 ww wh]);
    
    Screen('PutImage', w, Pic, [0 0 ww wh]);
    [ons_resp, starttime] = Screen('Flip', w);
    subj.onsets.image(i,1) = starttime - subj.trigger.fin;
    
    WaitSecs(pic_dur);
    
    fixation = '+';
    Screen('TextSize',w,48);
    Screen('TextFont',w,'Arial');
    DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);
    
    [ons_resp, starttime] = Screen('Flip', w);
    subj.onsets.fix1(i,1) = starttime - subj.trigger.fin;
    
    WaitSecs(2+jitter_3s(count_jitter_3s));
    count_jitter_3s = count_jitter_3s + 1;
    
    subj.time.scale_trigger = GetSecs;
    subj.onsets.scales.all(i,1) = subj.time.scale_trigger - subj.trigger.fin;
            
    if design.rand.full_flip_coin(i,sess) == 0
        rating_type_num = 0;
        output.rating.type_num(i,1) = rating_type_num;
        subj.onsets.scales.LHS(i,1) = GetSecs - subj.trigger.fin;
        if do_joystick == 1;
            LHS_vertical_joystick
        else
            LHS_vertical
        end
        subj.durations.scales.LHS(i,1) = GetSecs - (subj.onsets.scales.LHS(i,1) + subj.trigger.fin);
        subj.durations.scales.all(i,1) = GetSecs - (subj.onsets.scales.all(i,1) + subj.trigger.fin);
            
    else
        rating_type_num = 1;
        output.rating.type_num(i,1) = rating_type_num;
        subj.onsets.scales.VAS(i,1) = GetSecs - subj.trigger.fin;
        if do_joystick == 1;
            VAS_horz_joystick
        else
            VAS_horz
        end
        subj.durations.scales.VAS(i,1) = GetSecs - (subj.onsets.scales.VAS(i,1) + subj.trigger.fin) ;
        subj.durations.scales.all(i,1) = GetSecs - (subj.onsets.scales.all(i,1) + subj.trigger.fin);
    end
       
    fixation = '+';
    Screen('TextSize',w,48);
    Screen('TextFont',w,'Arial');
    DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);
    
    [ons_resp, starttime] = Screen('Flip', w);
    subj.onsets.fix2(i,1) = starttime - subj.trigger.fin;
    
    if flag_resp == 1
        WaitSecs((5-subj.durations.scales.all(i,1))+jitter_3s(count_jitter_3s));
    else
        WaitSecs((1-feedback_delay)+jitter_3s(count_jitter_3s));
    end
    
    if flag_resp == 0
        output.rating.value(i,1) = rating;
        output.rating.label{i,1} = text_freerating;
        output.rating.subm(i,1) = 0;
        output.rating.type_num(i,1) = rating_type_num;
    end
    
    count_jitter_3s = count_jitter_3s + 1;
            
end

%last fixation
fixation = '+';
Screen('TextSize',w,48);
DrawFormattedText(w, fixation, 'center', (y_cent - screen_offset_y * wh/2), [0 0 0],80);
[ons_resp, starttime] = Screen('Flip', w);
subj.onsets.fix_fin(i,1) = starttime - subj.trigger.fin;

WaitSecs(15-(1+jitter_3s(count_jitter_3s-1)));

%subj.onsets.fix_fin = GetSecs - subj.trigger.fin;

filename = sprintf('FOOD_eval_fMRI_%04d_%01d',subjn, sess);
save(fullfile('Data', [filename '.mat']));
save(fullfile('Backup', [filename datestr(now,'_yymmdd_HHMM') '.mat']));

ShowCursor

Screen('CloseAll');
 