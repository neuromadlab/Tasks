%%===================TUE006 Stimulation VAS===================
%tVNS stimulation strength VAS, run with main_VAS.m script
%(-26/11/2020-)
% 
%coded with: Matlab R2020a, Psychtoolbox 3.0, gstreamer 1.0
% 
%author: Vanessa Teckentrup, Sophie Müller, Alessandro Petrella
%
%based on: Effort VAS script by Monja P. Neuser, Nils B. Kroemer
%(-11/07/2017-)
% 
%input via XBox USB-Controller
%========================================================

VAS_rating_duration = 30;
VAS_time_limit = 0;

%Instruction text   
if settings.lang_de == 1
    text = ['Visuelle Analog-Skala zur Bestimmung der Stimulations-Staerke'];
else
    text = ['Visual analog scale to determine stimulation strength']; %english translation
end
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 60, [], [], 1.2);
Screen('Flip',w);

%GetClicks(setup.screenNum);
while Joystick.Button(1) ~= 1
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(0.5);
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

%Instruction text 
if settings.lang_de == 1
    text = ['Wir moechten im Folgenden die fuer Sie passende Staerke der Stimulation bestimmen. Dazu wird allmaehlich die Stimulationsstaerke erhoeht. Bitte bewerten Sie fuer jede Stufe, wie schmerzhaft Sie die Stimulation empfinden \n(von  0 [= keine Empfindung] bis 10 [= staerkste vorstellbare Empfindung]).'];
else
    text = ['Now we would like to calibrate the stimulation strength. To do this, we will start at a very low intensity and gradually increase it. Please rate how the stimulation feels at each step \n(from 0 [=no sensation] to 10 [=strongest imaginable sensation]).']; %english translation
end
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 60, [], [], 1.2);
Screen('Flip',w);

%GetClicks(setup.screenNum);
while Joystick.Button(1) ~= 1
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(0.5);
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

if settings.lang_de == 1
    text = ['Um Ihre Antworten einzugeben koennen Sie wieder den Regler ueber eine Skala verschieben. Bewegen Sie den Regler mit dem linken Joystick des Controllers und bestaetigen Sie Ihre Eingabe mit der A-Taste (gruen, rechter Daumen).\nBitte lassen Sie im Anschluss den Joystick wieder los, sodass er in die Mittelposition zurueckgehen kann.'];
else
    text = ['To respond, move the point on the scale with the joystick on the left side of the controller. When the point as at the spot that corresponds to your answer, confirm your response by pressing the A button (green, right thumb).\nAfter responding, please let go of the joystick so that it can go back to the middle position.']; %english translation
end
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 60, [], [], 1.2);
Screen('Flip',w);

%GetClicks(setup.screenNum);
while Joystick.Button(1) ~= 1
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(0.5);
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

if settings.lang_de == 1
    text = ['Die optimale Wirkung wird erzielt, wenn die Stimulation deutlich wahrnehmbar ist. Die Stimulation soll fuer Sie nicht unangenehm sein, muss aber als ein Prickeln oder leichtes Stechen auf der Haut an der Stimulationsstelle spuerbar sein. '];
else
    text = ['The optimal effect occurs when you clearly feel the stimulation. The stimulation should not be uncomfortable, but it should feel like a prickling of a light stinging on the skin at the spot where we are stimulating.']; %english translation
end
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 60, [], [], 1.2);
Screen('Flip',w);

%GetClicks(setup.screenNum);
while Joystick.Button(1) ~= 1
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(0.5);
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

if settings.lang_de == 1
    text = ['Wenn Sie bereit sind zu beginnen, druecken Sie bitte erneut die A-Taste.'];
else
    text = ['When you are ready to begin, press the A button again.']; %english translation
end
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 60, [], [], 1.2);
%[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);

%GetClicks(setup.screenNum);
while Joystick.Button(1) ~= 1
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(0.5);
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

%VAS rating duration
VAS_rating_duration = 30;
VAS_time_limit = 0;


%%==============call VAS_exhaustion_wanting===================

i_level = 1; % counter
trial.question = 'pain';
max_stimulation_intensity = 12;

%for i_level = 1:max_stimulation_intensity 
while Joystick.Button(4) ~= 1   
    
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    if Joystick.Button(4) == 1
        break
    end
    if settings.lang_de == 1
        text = ['Die Stimulations-Intensitaet wird eingestellt...'];
    else
        text = ['The stimulation intensity is being set...']; %english translation
    end
    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
%    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
    Screen('Flip',w);
    
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    
    %WaitSecs(1);
    %GetClicks(setup.screenNum);
    if Joystick.Button(1) == 1
        
        output.rating.pain(i_level,1) = GetSecs; %Start time of rating
        Effort_VAS
    
        output.rating.pain(i_level,2) = rating; %rating value
        output.rating.pain(i_level,3) = i_level; %rating label code (index of state_questions cell array)
        output.rating.pain(i_level,4) = rating_subm;  % answer submitted by pressing A
        output.rating.pain(i_level,5) = t_rating_ref; %Time of rating submission
    
        %Reset variables
        rating = nan;
        rating_label = nan;
        rating_subm = nan;

        output.filename = sprintf('%s\\data\\VAS_%s_%s_%s_temp', pwd, subj.studyID, subj.subjectID, subj.sessionID);

        save([output.filename '.mat'], 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter')

        i_level = i_level + 1;
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
        
    end
    
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
    
end

[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

%%Store output
output.time = datetime;
output.filename = sprintf('VAS_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);

save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter');
save(fullfile('Backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));


%Instruction text    
if settings.lang_de == 1
    text = ['Die Einstellung der Stimulations-Staerke ist abgeschlossen.'];
else
    text = ['We are now done adjusting the strength of the stimulation.']; %english translation
end
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);

%GetClicks(setup.screenNum);
while Joystick.Button(1) ~= 1
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(0.5);
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

Screen('Flip',w);
