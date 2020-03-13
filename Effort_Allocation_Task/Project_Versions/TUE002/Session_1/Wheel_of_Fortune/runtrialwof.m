%% Run Trial wof

%reseed random number generator 
rng('shuffle');

%selects winn or loss amount based on pseduo-random-walk sequence values
if version == 'a'
    val_sel_vect_a = [output.wof.win_amnt_a(TempPieIndex,:)-1, ...
                      output.wof.win_amnt_a(TempPieIndex,:), ...
                      output.wof.win_amnt_a(TempPieIndex,:)+1];
    rand_sel = 0;
    while rand_sel == 0
        rand_sel = randsample(val_sel_vect_a, 1);
    end
    winloss = rand_sel;

elseif version == 'b'
    val_sel_vect_b = [output.wof.win_amnt_b(TempPieIndex,:)-1, ...
                      output.wof.win_amnt_b(TempPieIndex,:), ...
                      output.wof.win_amnt_b(TempPieIndex,:)+1];
    rand_sel = 0;
    while rand_sel == 0
        rand_sel = randsample(val_sel_vect_b, 1);
    end
    winloss = rand_sel;
end

%determins if run is a win or loss run 
if sign(winloss) == 1
    text                                    = 'Euro gewonnen!';
    output.wof.wof_outcomes(TempPieIndex,1) = 1;
elseif sign(winloss) == -1
    text                                    = 'Euro verloren!';
    output.wof.wof_outcomes(TempPieIndex,1) = -1;
end

%computing num of spinner positions 
spinner_row         = find(winloss == winloss2spin_end_pos(:,1));
spinner_end_pos     = randsample(winloss2spin_end_pos(spinner_row,2):winloss2spin_end_pos(spinner_row,3),1);
spintimes           = randsample([127,253,379],1);
spins               = spinner_end_pos + spintimes;

%saves number of spin positions - multiply this number by spinner frequency
%to get total time of spinning wheel 
output.wof.wof_outcomes(TempPieIndex,3) = spins;

%saves amount participant wins or loses to a matrix
output.wof.wof_outcomes(TempPieIndex,2)     = winloss;

%saves all variables to participant file
%save(fullfile('data', sprintf('WOF_%i.mat', subj.subjectID)));

%% initialize sound driver
InitializePsychSound;

% read wav files
[wav_spin, freq_spin]   = audioread('spin_sound.wav');
if sign(winloss) == 1
[wav, freq]             = audioread('win_sound.wav');
elseif sign(winloss) == -1
[wav, freq]             = audioread('lose_sound.wav');    
end

% open device
pamaster    = PsychPortAudio('Open', [], 1+8, [], freq);

% start hardware
PsychPortAudio('Start', pamaster);

%% Presents first screen showing wheel

%Screen('FillRect', w, color.light_grey);
pie_pic         = imread('wof_pie_chart.png');
Texture_pie     = Screen('MakeTexture', w, pie_pic);
Screen('DrawTexture',w,Texture_pie,[],pie_pos);

Screen('TextSize',w,txtsize_for_exclamation);
TempTextBound   = Screen('TextBounds', w, '!');
Screen('DrawText',w,'!',setup.xCen- TempTextBound(3) / 2 - cue_corr_w, wdh/2 - TempTextBound(4) / 2 + cue_corr_h, color.red);
Screen('TextSize', w, txtsize_for_header);
DrawFormattedText(w,'Klicken Sie um das Gluecksrad drehen zu lassen.', 'center', wdh/10, color.black);
t0              = Screen('Flip',w);

%waits for participant to click mouse (press key)
GetClicks(w);

%changes color of exclimation point
%Screen('FillRect', w, color.light_grey);
pie_pic         = imread('wof_pie_chart.png');
Texture_pie     = Screen('MakeTexture', w, pie_pic);
Screen('DrawTexture',w,Texture_pie,[],pie_pos);

Screen('TextSize',w,txtsize_for_exclamation);
TempTextBound   = Screen('TextBounds', w, '!');
Screen('DrawText',w,'!',setup.xCen - TempTextBound(3) / 2 - cue_corr_w, setup.yCen - TempTextBound(4) / 2  + cue_corr_h, color.black);

Screen('Flip',w);
WaitSecs(timings.time_to_start);

%records reaction time of participant to start the WoF game
%save(fullfile('data', sprintf('WOF_%i.mat',subj.subjectID)));

%%

%drawing the text "Spiel"
%Screen('FillRect', w, color.light_grey);
pie_pic         = imread('wof_pie_chart.png');
Texture_pie     = Screen('MakeTexture', w, pie_pic);
Screen('DrawTexture',w,Texture_pie,[],pie_pos);
Screen('TextSize',w,txtsize_for_header);
Screen('DrawText',w,'Spiel',setup.xCen,wdh/10,color.red);
Screen('Flip',w);
WaitSecs(timings.show_wheel);

imageArray      = Screen('GetImage', w, [], 'frontBuffer');
next_screen     = Screen('MakeTexture',w,imageArray);

%-----------------------------------------------------------------%
%makes the spinner spin around a few times till reaching the winning
%position. by moving 127 positions ('spins' by going through the loop 
%'looptimes'), the star makes it around the circle approximately 1 time
theta       = 0;
t0          =GetSecs;
looptimes   = spins;

%open slave device
pa_spin     = PsychPortAudio('OpenSlave', pamaster, [], size(wav_spin, 2));
% fill buffer
PsychPortAudio('FillBuffer', pa_spin, wav_spin');
% start hardware
PsychPortAudio('Start', pa_spin, 0);

for times = 1:looptimes
    [x_pos,y_pos] = pol2cart(theta+pi/2,radius);
    theta         = theta + step_size_theta;
    %Screen('FillRect', w, color.light_grey);
    Screen('DrawTexture',w,next_screen);
    Screen('TextSize', w, txtsize_for_star);
    Screen('DrawText',w,'*',setup.xCen+x_pos-fix_corr_w,setup.yCen-y_pos-fix_corr_h,color.red);
    t1            =Screen('Flip',w);
    
    if times == spins
         PsychPortAudio('Stop', pa_spin, 0);
         timings.display_chart = 3;
         %steps for presenting winloss sound       
         % open slave audio to play winloss sound
         pa_winloss = PsychPortAudio('OpenSlave', pamaster, [], size(wav, 2));
         % fill buffer
         PsychPortAudio('FillBuffer', pa_winloss, wav');
         % start hardware
         PsychPortAudio('Start', pa_winloss);
     else
        timings.display_chart = .01;
     end
    WaitSecs(timings.display_chart);
end


WaitSecs(timings.show_feedback-(t1-t0)-1.5); %t1-t0 is the duration of the spinning of the wheel
abwinloss = abs(winloss);

%Screen('FillRect', w, color.light_grey);
Screen('TextSize',w,txtsize_for_header);
Screen('DrawText',w,'Ergebnis',setup.xCen,wdh/10,color.red);
formatSpec = 'Sie haben %i %s';
DrawFormattedText(w, sprintf(formatSpec, abwinloss, text),...
    'center',setup.yCen,color.black,60,[],[],1.3);
Screen('Flip',w);
WaitSecs(1.5);

%turn off psychportaudio master so can be turned on again for next trial
PsychPortAudio('Stop', pamaster, 0);


