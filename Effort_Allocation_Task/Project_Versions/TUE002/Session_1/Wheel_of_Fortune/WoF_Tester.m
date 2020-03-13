%% WoF Tester

% Clear workspace
close all;
clear all; 
sca;

 
%% Settings


%debug - disable for experiment
PsychDebugWindowConfiguration

%KbName('UnifyKeyNames');
Screen('Preference','TextEncodingLocale');


% Basic screen setup 
    setup.screenNum = max(Screen('Screens')); %secondary monitor if there is one connected
    setup.fullscreen = 1; %if 0 -> will create a small window ideal for debugging, set =1 for Experiment
    
% Basic gamepad settings
    %do_gamepad when behavioral EAT is used
    do_gamepad = 0;
    xbox_buffer = zeros(1,50); %will buffer the history of 50 button press status

        
% Get operating system and set OS flags
system_info = Screen('Computer');
windows = system_info.windows;
mac = system_info.osx;
linux = system_info.linux;

subj.subjectID = 1;
subj.order = 'a' ;

%% Setup PTB with some default values
PsychDefaultSetup(1); %unifies key names on all operating systems
imagingmode=kPsychNeedFastBackingStore;	% flip takes ages without this


% Define colors
color.white = WhiteIndex(setup.screenNum); %with intensity value for white on second screen
color.grey = color.white / 2;
color.black = BlackIndex(setup.screenNum);
color.red = [255 0 0];
color.darkblue = [0 0 139];
color.royalblue = [65 105 225]; %light blue, above threshold
color.gold = [255,215,0];
color.scale_anchors = [205 201 201];
bgcol 		= [204 204 204];	% this is just in grayscale (each value separately);
%the value 204 is important and is chosen so that it matches the background
%colour of the pie charts, as it appears when you save them with non-transparent export_fig
txtcolor 	= color.black;
fixcol   	= color.black; % fixation cross color

% Define the keyboard keys that are listened for.
% Actually not needed for the task
keys.escape = KbName('ESCAPE');%returns the keycode of the indicated key.
keys.resp = KbName('Space');
keys.left = KbName('LeftArrow');
keys.right = KbName('RightArrow');
keys.down = KbName('DownArrow');



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

% Query the frame duration
setup.ifi = Screen('GetFlipInterval', w);

% Query the maximum priority level - optional
setup.topPriorityLevel = MaxPriority(w);


% Setup overlay screen
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

VAS_rating_duration = 3.2;
VAS_time_limit = 1;

% Initialize counter
count_joy = 1; %Indexes Joystick position
count_jitter = 1; %Not used in the script


%% Wheel of fortune setup

%versions a and b have different versions of the random walk of wins
%accross trials
version = sprintf(subj.order);


%creates matrix to store exact win/loss values
wof_outcomes = zeros(14,3);

%load matrix with info on sequence of pies & wins/losses
load Wheel_of_Fortune_matr_sel.mat
win_amnt_a = wof_data_sel(2:15,18);
win_amnt_b = wof_data_sel(2:15,19);
amounts = wof_data_sel(1, 2:17);
data = wof_data_sel(2:15, 2:17);

%load matrix for amount of spinning necessary for each win or loss value
load('Spinner.mat', 'winloss2spin_end_pos');

%adding path for soundfiles
addpath('sounds');

%adding path for charts
addpath('charts');

%times
time_wait = 1;
time_show_pie_feedback_phase = 5; 
time_show_feedback = 5;

%textsizes
txtsize_for_exclamation = 70; 
txtsize_for_header = 30;

%                    SCREEN LAYOUT
[wdw, wdh]=Screen('WindowSize', w);	% Get screen size
%................... Presentation coordinates
xfrac=.8; 										% fraction of x width to use
yfrac=.6; 										% fraction of y height to use
xl0=xfrac*wdw; 								% width to use in pixels
yl0=yfrac*wdh; 								% height to use in pixels
x0=(1-xfrac)/2*wdw; 							% zero point along width
y0=(1-yfrac)/2*wdh;							% zero point along height


% THE PIES
pieh = yl0; %height of a pie
piew = yl0; %width of a pie
pie_pos = [wdw/2-piew/2 wdh/2-pieh/2 wdw/2+piew/2 wdh/2+pieh/2];
radius = yl0/2;
%Distance in radians between consecutive instances of the asterisk when the
%wheel is 'spinning'
step_size_theta = 0.05;

%Other graphics positions
tmp			= imread('fixation.jpg');
fixation	= Screen('MakeTexture',w,tmp);
circlew = piew/5;
circleh = pieh/5;
circle_pos = [wdw/2-circlew/2 wdh/2-circleh/2 wdw/2+circlew/2 wdh/2+circleh/2];
fixation_pos = [wdw/2-circlew/5 wdh/2-circleh/5 wdw/2+circlew/5 wdh/2+circleh/5];

%correction for fixation sign; same correction used for the little star
%displayed when the lotterie is played out
fix_corr_w = 1/370*xl0; %how much more to the left
fix_corr_h = 1/350*xl0; %how much higher

%correction for exclamation sign
cue_corr_w = 1/300*xl0; %how much more to the left
cue_corr_h = 0*1/80*xl0; %how much higher

TempPieIndex = 1; %defines practice WoF trial 

runtrialwof

Screen('CloseAll');
