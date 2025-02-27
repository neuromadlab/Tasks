%% Instructions IMT English
% =========================================================================
% TUE008 Version
% Corinna Schulz, August 2022
% =========================================================================

%% general

instr.text_coins1     = '1 money point per force unit';
instr.text_coins10    = '10 money points per force unit';
instr.text_cookies1   = '1 food point per force unit';
instr.text_cookies10  = '10 food points per force unit';

instr.press_GFD = 'To start squeeze the grip force device.';
instr.continue_GFD = 'Continue by squeezing the grip force device.';

%% =========================================================================
% RunLabel I: training section
% =========================================================================
instr.train_welcome_text = ['Welcome.' ...
                            '\n\nThis is a simple game in which you play for money and snacks.' ...
                            '\nYou can first familiarize yourself with the functions and practice.' ...
                            '\nThe actual game will start at a later time.'];

%% Calibration phase: estimation of max and min force 
instr.train_effort     = ['On the screen you will see an open container with a blue ball in it.' ...
            '\nWhen you squeeze the device in your hand, the ball moves up.' ...
            '\nThe harder you squeeze, the higher the ball rises.' ...
            '\nIn the next rounds, you should familiarize yourself with the device.'...
            '\nPlease do not change the position of the device in your hand during the experiment.' ...
              ];

instr.first_round_train  = ['Try to get the ball as high up as possible in the next 10 seconds.'];

instr.middle_round_train = ['Hold the device loosely in your hand for the next 10 seconds without squeezing. '];                  

instr.last_round_train   = ['Try once again to get the ball up as high as possible in the following 10 seconds.'];

%% Conditioning phase


instr.intro_reward         = ['You can win different amounts in each round. ' ...
                            '\nYou will be playing for money as well as for calories, '...
                            '\nwhich you can exchange for a snack after completing the task.'... 
                            '\nThe current reward remains constant during one trial' ... 
                            ];
                     
instr.reward_money         = ['In some rounds you can win money points. '... 
                            '\nAfter completing the task, you will receive the corresponding equivalent in cash. '...
                            '\n\nThe following conditions exist:\n\n\n', instr.text_coins1 '\n\n' instr.text_coins10 ];
                        
instr.reward_kcal         = ['In some rounds you can win calories. '...
                            ' \nAfter completing the task, you will receive the corresponding equivalent as a snack. '...
                            '\n\nThe following conditions exist:\n\n\n', instr.text_cookies1 '\n\n' instr.text_cookies10];

instr.tones     = ['Later, in the scanner, you will not have a screen.' ...
                            '\nThus, you will firstly learn to associate which tones are associate with money or food trials,'...
                            '\nand which tones with little or many points.']; 

instr.start_conditioning = ['Now you will get to know the tones which will indicate during the experiment'...
    '\nfor which rewards you can bid. ' ...
    '\nFirst, you will hear a tone.'...
    '\nShortly after you will see a picture indicating which reward is associated with the tone.'...
    '\nTry to learn which tone is associated with each reward condition.']; 

instr.start_practice_conditioning = ['After some time there will also be query trials' ...
    '\nin which you will be asked to indicate using the arrows on the keyboard which condition a tone indicated.' ...
    '\nDuring the query trials you will again hear first a tone.' ...
    '\nHowever, during the query trials no picture will appear. Sometimes you will be asked to indicate'...
    '\nwhether it was a food (left arrow) or money (right arrow) reward. '...
    '\nSometimes you will be asked to indicate whether it was a '...
    '\n1x (downward arrow) or a 10x (upward arrow) reward'...
    '\n\n\n For this part of the training you can put the grip force device away.']; 

instr.start_queries = 'Start Query trials';

instr.test = 'Test';

instr.query_reward = 'Food?                                      Money?';
instr.query_magnitude = ['10-multiplication?'...
                    '\n\n '...
                    '\n\n1-multiplication?'];

instr.cue_feedback_correct = ['Correct!'];
instr.cue_feedback_wrong = ['Incorrect']; 

instr.done_conditioning = ['Well done. You have learned to associate the tones with their rewards!'...
    '\nPlease take the grip force device again in your hand.']; 

instr.not_yet_there = ['This was already good but we will practice more,'... 
    '\nso that you are very confident in associating '...
    '\nthe rewards with the tones in the scanner.']; 

%% Full Training phase
instr.train_bidding = 'Now you will practice the actual task.'; 

instr.train_bidding_recap = ['Each trail starts with a tone. Followingly, you can indicate in the bidding phase' ...
    '\n how willing you are to exert effort for this reward.' ...
    '\nEach bidding phase lasts approximately 3 seconds.' ...
    '\nAttention: The bidding phase starts immediately after the end of the tone! '...
    '\nThe longer and stronger you are squeezing the device the more force units you are collecting.' ...
    '\nThe force units will be translated depending on the condition.'...
    ];


instr.time_strategy = ['The entire experiment in the scanner will take about 20 minutes.' ...
                      '\nTherefore, it might not always be possible to exert maximal force all the time.'...
                      '\nOne way to deal with this is to also take breaks during the rounds'...
                      '\nin order to be able to apply more pressure afterwards.' ...
                      '\nPlease remember to hold your hand as calm as possible.']; 

%% =========================================================================
% Experiment in Scanner
% =========================================================================

instr.intro = 'The experimental task is about to start.';
instr.signal_tone = 'Important! Only press after this signal tone!'; 
instr.signal_example = 'Now you will hear the signal tone.';
instr.intro_scanner = 'Now you will be shortly reminded of the tone conditions.';
instr.intro_scanner_start = 'Start of task.'; 

instr.end_exp = ['The task is over.'...
    'Please continue to lay down camly until we will enter your room.']; 


