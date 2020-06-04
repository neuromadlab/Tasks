% fprintf('............ Setting up the screen   \n');

%................... colours (in RBG)
bgcol 		= [204 204 204];	% this is just in grayscale (each value separately);
%the value 204 is important and is chosen so that it matches the background
%colour of the pie charts, as it appears when you save them with non-transparent export_fig
black 		= [0 0 0];
white       = [255 255 255];
red         = [255 20 20];
lightcolor  = 245; %grayscale
yellow      = [255 255 20];
green 		= [0 135 00];
blue        = [0 0 150];
txtcolor 	= black;
fixcol   	= black; % fixation cross color

txtsize_for_sure_amount = 24;
txtsize_for_exclamation = 70; %Beamer
txtsize_for_fixation = 36;
txtsize_for_options = 16; %LCD
txtsize_for_header = 30;

KbName('UnifyKeyNames');

%................... open a screen
AssertOpenGL;
imagingmode=kPsychNeedFastBackingStore;	% flip takes ages without this
Screen('Preference','Verbosity',0);

screenNumber = 0;

if debug;
   Screen('Preference','SkipSyncTests',2); % ONLY do this for quick debugging; large mac: 1920 x 1200
    %wd=Screen('OpenWindow',0,bgcol(2),[400 400 800 800],[],2,[],[],imagingmode); % make small PTB screen on my large screen
    %wd=Screen('OpenWindow',0,bgcol(2),[200 200 1400 1000],[],2,[],[],imagingmode); % make small PTB screen on my large screen
     %wd=Screen('OpenWindow',0,bgcol(2),[50 200 1050 1000],[],2,[],[],imagingmode); % make small PTB screen on my large screen
     %wd=Screen('OpenWindow',0,bgcol(2),[50 200 1050 1000],[],2,[],[],[]); % make small PTB screen on my large screen
%     wd=Screen('OpenWindow',0,bgcol(2),[50 50 900 800],[],2,[],[],imagingmode); % make small PTB screen on my large screen
	wd=Screen('OpenWindow', screenNumber,bgcol(2),[0 20 600 400],[],2,[],[],imagingmode); % make small PTB screen on my laptop screen
else
	% normal das erste:
% 		wd=Screen('OpenWindow', screenNumber,bgcol(2),[],[],2,[],[],imagingmode);			% Get Screen. This is always size of the display.
%     wd=Screen('OpenWindow',0,bgcol(2),[],[],2,[],[],[]);			% Get Screen. This is always size of the display.
 % wd=Screen('OpenWindow',1,bgcol(2),[0 0 800 600],[],2,[],[],[]);			% Get Screen. This is always size of the display.
wd=Screen('OpenWindow',screenNumber,bgcol(2),[0 0 800 600],[],2,[],[],[]);			% Get Screen. This is always size of the display.
end
KbName('UnifyKeyNames'); % need this for KbName to behave

ListenChar(2);
%%%%%HideCursor;

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


%.................... Instructions positions
%%%%%addpath('instr_funcs');
yposm = 'center'; 
syposb = .8*wdh; 
ypost = .25*wdh; 
ypostt=.13*wdh;
% yposb = .5*wdh; 
% ypost = .125*wdh; 
% ypostt=.065*wdh;

%-------------------------------THE PIES----------------------------------%
pieh = yl0; %height of a pie
piew = yl0; %width of a pie
pie_pos = [wdw/2-piew/2 wdh/2-pieh/2 wdw/2+piew/2 wdh/2+pieh/2];

%load pies and make textures
FolderCharts = 'charts';
% cd('N:\SeSyN\Paradigms\024\deconstr_risk_PTB\charts\')
%for count = 1:num_pies
%    pie_pic = imread(fullfile(FolderCharts,sprintf('pie_chart_%i.png',count)));
%    exp_pie{count} = Screen('MakeTexture',wd,pie_pic);
%end


for count = 1:num_tut_pies
    pie_pic = imread(fullfile(FolderCharts,sprintf('wof_pie_chart_%i.png',count)));
    tut_pie{count} = Screen('MakeTexture',wd,pie_pic);
end

pie = 1:num_pies;

%randomize pies
% pie_90 = {pie(rand_90)};
% pie_120 = {pie(rand_120)};
% pie_150 = {pie(rand_150)};
% pies = [pie_90 pie_120 pie_150];
pies = pie_pic;

%Distance in radians between consecutive instances of the asterisk when
%winning lottery is displayed

step_size_theta = 0.05;

% cd('N:\SeSyN\Paradigms\024\deconstr_risk_PTB\')


%-------------------------Other graphics positions------------------------%

% tmp = imread('sure_amount_offer.jpg');
% sure_amount_offer = Screen('MakeTexture',wd,tmp);
%
% tmp = imread('sure_amount_take.jpg');
% sure_amount_take = Screen('MakeTexture',wd,tmp);

tmp			= imread('fixation.jpg');
fixation	= Screen('MakeTexture',wd,tmp);
circlew = piew/5;
circleh = pieh/5;
circle_pos = [wdw/2-circlew/2 wdh/2-circleh/2 wdw/2+circlew/2 wdh/2+circleh/2];
fixation_pos = [wdw/2-circlew/5 wdh/2-circleh/5 wdw/2+circlew/5 wdh/2+circleh/5];

%-------------------------------------------------------------------------%
%--------------------LOAD INSTRUCTIONS AND MAKE TEXTURES------------------%
%-------------------------------------------------------------------------%

% %load the arrows
% tmp = imread('arrows.tif');
% %tmp(tmp==255)=bgcol(2);
% arrow=Screen('MakeTexture',wd,tmp);
% arrowsquare(1,:)=[wdw*.84 wdh*.92 wdw*.98 wdh*.98];if doinstr
	
	%load the instruction slides
% 	if(strcmpi(instr_lang, 'de'))
% 		D = dir(fullfile('DRISK_instructions_de', '*.PNG'));
% 		num_instr_pages = length(D(not([D.isdir])));
% 		
% 		for count = 1:num_instr_pages
% 			instructions{count} = imread(fullfile('DRISK_instructions_de', sprintf('Folie%i.png',count)));
% 			instructions_texture{count} = Screen('MakeTexture',wd,instructions{count});
% 		end
% 		
% 	else
% 		D = dir(fullfile('DRISK_instructions_en', '*.PNG'));
% 		num_instr_pages = length(D(not([D.isdir])));
% 		
% 		for count = 1:num_instr_pages
% 			instructions{count} = imread(fullfile('DRISK_instructions_en', sprintf('Folie%i.png',count)));
% 			instructions_texture{count} = Screen('MakeTexture',wd,instructions{count});
% 		end
% 	end
% end


%%

abortkey = 'ESCAPE';