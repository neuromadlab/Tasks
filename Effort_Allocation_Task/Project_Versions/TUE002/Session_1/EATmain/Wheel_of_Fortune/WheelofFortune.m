%% Setup 

subjn = '00_999888';

%versions a and b have different versions of the random walk of wins
%accross trials
version = 'b';


ListenChar(0);

%% Creating & Loading things

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

%% setting parameters


%times
time_wait = 1;
time_show_pie_feedback_phase = 5; 
time_show_feedback = 5;

% Colors (in RBG)
bgcol 		= [204 204 204];	% this is just in grayscale (each value separately);
%the value 204 is important and is chosen so that it matches the background
%colour of the pie charts, as it appears when you save them with non-transparent export_fig
black 		= [0 0 0];
white       = [255 255 255];
red         = [255 20 20];
lightcohlor  = 245; %grayscale
yellow      = [255 255 20];
green 		= [0 135 00];
blue        = [0 0 150];
txtcolor 	= black;
fixcol   	= black; % fixation cross color

%textsizes
txtsize_for_exclamation = 70; 
txtsize_for_header = 30;

KbName('UnifyKeyNames');

%................... open a screen
AssertOpenGL;
imagingmode=kPsychNeedFastBackingStore;	% flip takes ages without this
Screen('Preference','Verbosity',0);

screenNumber = 0;
% wd=Screen('OpenWindow', screenNumber,bgcol(2),[],[],2,[],[],imagingmode);			% Get Screen. This is always size of the display.
% wd=Screen('OpenWindow',0,bgcol(2),[],[],2,[],[],[]);			% Get Screen. This is always size of the display.
% wd=Screen('OpenWindow',1,bgcol(2),[0 0 800 600],[],2,[],[],[]);			% Get Screen. This is always size of the display.

wd=Screen('OpenWindow',screenNumber,bgcol(2),[0 0 800 600],[],2,[],[],[]);			% Get Screen. This is always size of the display.

KbName('UnifyKeyNames'); % need this for KbName to behave

ListenChar(2);

%---------------------------------------------------------------------------
%                    SCREEN LAYOUT
%---------------------------------------------------------------------------
[wdw, wdh]=Screen('WindowSize', wd);	% Get screen size

%................... Presentation coordinates
xfrac=.8; 										% fraction of x width to use
yfrac=.6; 										% fraction of y height to use
xl0=xfrac*wdw; 								% width to use in pixels
yl0=yfrac*wdh; 								% height to use in pixels
x0=(1-xfrac)/2*wdw; 							% zero point along width
y0=(1-yfrac)/2*wdh;							% zero point along height

%-------------------------------THE PIES----------------------------------%
pieh = yl0; %height of a pie
piew = yl0; %width of a pie
pie_pos = [wdw/2-piew/2 wdh/2-pieh/2 wdw/2+piew/2 wdh/2+pieh/2];

radius = yl0/2;

%Distance in radians between consecutive instances of the asterisk when the
%wheel is 'spinning'
step_size_theta = 0.05;


%-------------------------Other graphics positions------------------------%


tmp			= imread('fixation.jpg');
fixation	= Screen('MakeTexture',wd,tmp);
circlew = piew/5;
circleh = pieh/5;
circle_pos = [wdw/2-circlew/2 wdh/2-circleh/2 wdw/2+circlew/2 wdh/2+circleh/2];
fixation_pos = [wdw/2-circlew/5 wdh/2-circleh/5 wdw/2+circlew/5 wdh/2+circleh/5];

%% Position Corrections 
%correction for fixation sign; same correction used for the little star
%displayed when the lotterie is played out
fix_corr_w = 1/82*xl0; %how much more to the left
fix_corr_h = 1/49*xl0; %how much higher

%correction for exclamation sign
cue_corr_w = 1/32*xl0; %how much more to the left
cue_corr_h = 1/20*xl0; %how much higher

%% Trials
%practice trial
TempPieIndex = 1;
runtrialwof;


%real trials
TempPieIndex = 2;
runtrialwof;

% TempPieIndex = 3;
% runtrialwof;
% 
% TempPieIndex = 4;
% runtrialwof;
% 
% TempPieIndex = 5;
% runtrialwof;
% 
% TempPieIndex = 6;
% runtrialwof;
% 
% TempPieIndex = 7;
% runtrialwof;
% 
% TempPieIndex = 8;
% runtrialwof;
% 
% TempPieIndex = 9;
% runtrialwof;
% 
% TempPieIndex = 10;
% runtrialwof; 
% 
% TempPieIndex = 11;
% runtrialwof; 
% 
% TempPieIndex = 12;
% runtrialwof; 
% 
% TempPieIndex = 13;
% runtrialwof; 
%    
% TempPieIndex = 14;
% runtrialwof; 

%% Compute WoF earnings

Wof_result = sum(wof_outcomes(2:14,2));

if Wof_result <1
    Wof_win = 1;
else 
   Wof_win = Wof_result;
end

%present total winning at end
finalwintext = 'Euro gewonnen.';
prestext = sprintf('Sie haben beim Gl?cksraddrehspiel \n insgesamt %i %s',Wof_win,finalwintext);

Screen('TextSize', wd, txtsize_for_header);
DrawFormattedText(wd, prestext, 'center', wdh/10, black);
Screen('Flip',wd);
WaitSecs(time_show_feedback);
   %%
Screen('Close', wd);
ListenChar;
