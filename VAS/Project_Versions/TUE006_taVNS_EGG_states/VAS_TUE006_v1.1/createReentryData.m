clear all
close all

ID = input('ID (6 digits!): \n');
ses = input('session: \n');

load([pwd '\data\VAS_TUE006_' num2str(ID) '_' num2str(ses) '.mat'])

%% general settings
generalSettings.pilot = input('pilot session = 1; normal session = 0\n'); % pilot session = 1; normal session = 0
generalSettings.waiting_time = input('normal waiting time = 900\n'); % normal waiting time = 900; set different for pilot/debugging
generalSettings.with_EGG = input('0 = without EGG triggers, 1 = with EGG triggers\n'); % set 1 to run with EGG triggers, set 0 for pilot/debugging without EGG
generalSettings.with_saveUSB = input('0 = without USB save, 1 = with USB save\n'); %set 1 to automatically save data on USB stick 
generalSettings.studyID='TUE006';

%% settings
load([pwd filesep 'VASsettings_' generalSettings.studyID '.mat'])
VAS_rating_duration = settings.VAS_rating_duration;
VAS_time_limit = settings.VAS_time_limit;
VAS_rep_marker = 1;

if subj.shake == 1
    shake_pic = settings.shake.strawberry;
elseif subj.shake == 2
    shake_pic = settings.shake.chocolate;
elseif subj.shake == 3
    shake_pic = settings.shake.caramel;
end

set_index = find(settings.conditions.ID == subj.num & settings.conditions.Session == subj.sess);
if settings.conditions.ImageSet(set_index) == 1
    image_path = [pwd filesep 'Stimuli' filesep 'A'];
else
    image_path = [pwd filesep 'Stimuli' filesep 'B'];
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

image_list = dir(image_path);
image_list = image_list(arrayfun(@(x) ~strcmp(x.name(1),'.'),image_list));
image_names = {image_list.name}';
reward_index = find(not(cellfun('isempty',strfind(WillPay_Stimuli,reward_name))));


Screen('Preference', 'SkipSyncTests', 2);
load('JoystickSpecification.mat');
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

setup.screenNum = max(Screen('Screens')); %secondary monitor if there is one connected
setup.fullscreen = 1; %if 0 -> will create a small window ideal for debugging, set =1 for Experiment

color.white = WhiteIndex(setup.screenNum); %with intensity value for white on second screen
color.grey = color.white / 2;
color.black = BlackIndex(setup.screenNum);
color.red = [255 0 0];
color.scale_anchors = color.black;

PsychDefaultSetup(1);

% Define the keyboard keys that are listened for. 
keys.escape = KbName('ESCAPE');%returns the keycode of the indicated key.
keys.resp = KbName('Space');
keys.left = KbName('LeftArrow');
keys.right = KbName('RightArrow');
keys.down = KbName('DownArrow');
keys.quit=KbName('q');

if ~exist('money', 'var') 
    money = struct;
end

save([pwd '\Reentry\reentry_TUE006_' num2str(ID) '_S' num2str(ses) '.mat'],'timestamps','task_status','wtpt','subj','generalSettings','shake_pic','settings','color','keys','setup','output','money','jitter','load_questions', 'state_questions', 'fcqtr_questions','VAS_rep_marker','VAS_rating_duration','VAS_time_limit','WillPay_Stimuli','image_list','reward_index','JoystickSpecification','Joystick')



