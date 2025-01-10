% RL_task/prepareCues - part of BON002
% Version 0.2.3
% Author: Paul Jung
% Mail: jung.science@web.de
% Date: 20.11.2023
% 
% Here we specify manually the cues for the RL_task
%--------------------------------------------------------------------------
close all; clear; clc

% For the main task, specify 16x2 files (.png expected), two consecutive 
% files will be paired
cues.files = {
    'planet_space_1_1.png'
    'planet_space_1_2.png'
    'planet_space_1_3.png'
    'planet_space_1_4.png'

    'planet_space_1_5.png'
    'planet_space_1_7.png'
    'planet_space_1_8.png'
    'planet_space_1_11.png'

    'planet_space_2_1.png'
    'planet_space_2_3.png'
    'planet_space_2_4.png'
    'planet_space_2_5.png'

    'planet_space_2_6.png'
    'planet_space_2_8.png'
    'planet_space_2_11.png'
    'planet_space_2_10.png'

    'planet_space_3_1.png'
    'planet_space_3_2.png'
    'planet_space_3_3.png'
    'planet_space_3_4.png'

    'planet_space_3_5.png'
    'planet_space_3_6.png'
    'planet_space_3_7.png'
    'planet_space_3_9.png'

    'planet_space_5_1.png'
    'planet_space_5_2.png'
    'planet_space_5_3.png'
    'planet_space_5_4.png'

    'planet_space_5_6.png'
    'planet_space_5_9.png'
    'planet_space_5_11.png'
    'planet_space_5_12.png'
    };
cues.pairs = reshape(cues.files, 2, [])'; % pair the cues

% now specify 1x2 different files for 10 training runs
cues.trainingFiles = {
    'planet_space_1_6.png'
    'planet_space_5_8.png'
    'planet_space_3_11.png'
    'planet_space_5_10.png'
    'planet_space_3_8.png'
    'planet_space_5_7.png'
    };
% pair the training cues
cues.trainingPairs = reshape(cues.trainingFiles, 2, [])';

cues.path = '.\supplementaryFiles\Cues\'; % relative to RL-task script
save("cues", 'cues');
