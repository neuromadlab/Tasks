%%===================TUE006 VAS questionnaires===================
%Questionnaires for Mood-VAS and FCQ-T-r, run with main_VAS.m script
%(-26/11/2020-)
% 
%coded with: Matlab R2020a, Psychtoolbox 3.0, gstreamer 1.0
% 
%author: Vanessa Teckentrup, Sophie Mueller, Alessandro Petrella
%
%based on: Effort VAS script by Monja P. Neuser, Nils B. Kroemer
%(-11/07/2017-)
% 
%input via XBox USB-Controller
%========================================================

VAS_rating_duration = 30;
VAS_time_limit = 0;

% Start VAS
if settings.lang_de == 1
    text = ['Der Fragebogen beginnt nun.'];
else
    text = ['The questionnaire will now begin.']; %english translation
end
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text_Cont, 'center', (setup.ScrHeight/5*4.7), color.black, 50, [], [], 1.2);
Screen('Flip',w);
while Joystick.Button(1) ~= 1
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
end
WaitSecs(0.5);
[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);

%% Mood VAS
% run mood VAS 
state_questions = {  'hungry', 'hungrig', 'State';
                     'thirsty', 'durstig', 'State';    
                     'tired', 'muede', 'State';
                     'full', 'satt', 'State';
                   %  'awake', 'wach', 'State';
                     'active', 'aktiv', 'PA';
                     'distressed', 'bedrueckt', 'NA';
                     'interested', 'interessiert', 'PA';
                     'excited', 'freudig erregt', 'PA';
                     'upset', 'veraergert', 'NA';
                     'strong', 'stark', 'PA';
                     'guilty', 'schuldig', 'NA';
                     'scared', 'veraengstigt', 'NA';
                     'hostile', 'feindselig', 'NA';
                     'inspired', 'angeregt', 'PA';
                     'proud', 'stolz', 'PA';
                     'irritable', 'reizbar', 'NA';
                     'enthusiastic', 'begeistert', 'PA';
                     'ashamed', 'beschaemt', 'NA';
                     'alert', 'hellwach', 'PA';
                     'nervous', 'nervoes', 'NA';
                     'determined', 'entschlossen', 'PA';
                     'attentive', 'aufmerksam', 'PA';
                     'jittery', 'unruhig', 'NA';
                     'afraid', 'aengstlich', 'NA';
                     'content', 'zufrieden', 'MDBF';
                     'rested', 'ausgeruht', 'MDBF';
                     'restless', 'ruhelos', 'MDBF';
                     'bad', 'schlecht', 'MDBF';
                     'floppy', 'schlapp', 'MDBF';
                     'calm', 'gelassen', 'MDBF';
                     'good', 'gut', 'MDBF';
                     'unwell', 'unwohl', 'MDBF';
                     'relaxed', 'entspannt', 'MDBF';};

if generalSettings.with_EGG == 1                 
    % write EGG trigger (start VAS)                 
    io64(LPT_IO_EGG,settings.EGG.port_address,255-settings.EGG.trigger.start_VAS);
end

for i_state = 1:length(state_questions)
    
%     if rep == 3 & i_state == 12
%         error('provoziert')
%     end
    
    scale_type = 'adjective';
    question_type = 'mood';
    trial.question = state_questions{i_state,settings.lang_de+1};
    
    Effort_VAS
    
    output.rating.state{(rep-1)*length(state_questions)+i_state,1} = rep; %Repetition
    output.rating.state{(rep-1)*length(state_questions)+i_state,2} = startTime; %Start time of rating
    output.rating.state{(rep-1)*length(state_questions)+i_state,3} = rating; %rating value
    output.rating.state{(rep-1)*length(state_questions)+i_state,4} = i_state; %rating label code (index of state_questions cell array)
    output.rating.state{(rep-1)*length(state_questions)+i_state,5} = rating_subm;  % answer submitted by pressing A
    output.rating.state{(rep-1)*length(state_questions)+i_state,6} = t_rating_ref; %Time of rating submission

    %Reset variables
    rating = nan;
    rating_label = nan;
    rating_subm = nan;

    %%Store output
    output.time = datetime;
    output.filename = sprintf('VAS_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);

    save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter');

end

if generalSettings.with_EGG == 1
    % write EGG trigger (end VAS)
    io64(LPT_IO_EGG,settings.EGG.port_address,255-settings.EGG.trigger.end_VAS);
end

%%Store output
output.time = datetime;
output.filename = sprintf('VAS_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);

save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter');
save(fullfile('Backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));

%% FCQTR VAS
if rep ~=8 %no food craving for final run
    %run VAS for fcqtr questions 
    fcqtr_questions = {'When I crave something, I know I won´t be able to stop eating once I start.','Wenn ich ein starkes Verlangen nach etwas verspuere, weiss ich, dass ich nicht mehr aufhoeren kann zu essen, wenn ich erst mal angefangen habe.';
                     'If I eat what I am craving, I often lose control and eat too much.','Wenn ich das esse, wonach ich ein starkes Verlangen verspuere, verliere ich oft die Kontrolle und esse zu viel.';
                     'Food cravings always make me think of ways to get what I want to eat.','Wenn ich ein starkes Verlangen nach bestimmten Nahrungsmitteln verspuere, denke ich ausnahmslos darueber nach, wie ich das bekomme, was ich essen will.';
                     'I feel like I have food on my mind all the time.','Ich habe das Gefuehl, dass ich die ganze Zeit nur Essen im Kopf habe.';
                     'I find myself constantly preoccupied with food.','Ich ertappe mich dabei, wie ich mich gedanklich staendig mit Essen beschaeftige.';
                     'Whenever I have cravings, I find myself making plans to eat.','Immer wenn ich ein starkes Verlangen nach bestimmten Nahrungsmitteln verspuere, merke ich, dass ich gleich plane etwas zu essen.';
                     'I crave food when I feel bored, angry, or sad.','Ich verspuere ein starkes Verlangen nach bestimmten Nahrungsmitteln, wenn ich mich gelangweilt, wuetend oder traurig fuehle';
                     'I have no will power to resist my food cravings','Ich habe nicht die Willensstaerke, um meinen Essensgeluesten widerstehen zu koennen.';
                     'Once I start eating, I have trouble stopping.','Wenn ich einmal anfange zu essen, faellt es mir schwer wieder aufzuhoeren.';
                     'I cant stop thinking about eating no matter how hard I try.','Ich kann nicht aufhoeren ueber das Essen nachzudenken, wie sehr ich mich auch bemuehe.';
                     'If I give in to a food craving, all control is lost.','Wenn ich dem starken Verlangen nach bestimmten Nahrungsmitteln nachgebe, verliere ich jegliche Kontrolle.';
                     'Whenever I have a food craving, I keep thinking about eating until I actually eat the food.','Immer wenn ich ein starkes Verlangen nach bestimmten Nahrungsmitteln verspuere, denke ich so lange weiter ans Essen bis ich diese tatsaechlich esse.';
                     'If I am craving something, thoughts of eating it consume me.','Wenn ich ein starkes Verlangen nach bestimmten Nahrungsmitteln verspuere, verzehren mich die Gedanken daran, diese zu essen geradezu.';
                     'My emotions often make me want to eat.','Meine Emotionen bringen mich oft dazu, etwas essen zu wollen.';
                     'It is hard for me to resist the temptation of eating appetizing food that are in my reach.','Wenn sich appetitliche Nahrungsmittel in meiner Reichweite befinden, faellt es mir schwer, der Versuchung zu widerstehen, sie zu essen.';};

    if generalSettings.with_EGG == 1
        % write EGG trigger (start fqctr)             
        io64(LPT_IO_EGG,settings.EGG.port_address,255-settings.EGG.trigger.start_fcqtr);  
    end

    for i_fcqtr = 1:length(fcqtr_questions)
        question_type = 'fcqtr';
        scale_type = 'fcqtr';
        trial.question = fcqtr_questions{i_fcqtr,settings.lang_de+1};

        Effort_VAS

        output.rating.fcqtr{(rep-1)*length(fcqtr_questions)+i_fcqtr,1} = rep; %Repetition
        output.rating.fcqtr{(rep-1)*length(fcqtr_questions)+i_fcqtr,2} = startTime; %Start time of rating
        output.rating.fcqtr{(rep-1)*length(fcqtr_questions)+i_fcqtr,3} = rating; %rating value
        output.rating.fcqtr{(rep-1)*length(fcqtr_questions)+i_fcqtr,4} = i_fcqtr; %rating label code (index of state_questions cell array)
        output.rating.fcqtr{(rep-1)*length(fcqtr_questions)+i_fcqtr,5} = rating_subm;  % answer submitted by pressing A
        output.rating.fcqtr{(rep-1)*length(fcqtr_questions)+i_fcqtr,6} = t_rating_ref; %Time of rating submission

        %Reset variables
        rating = nan;
        rating_label = nan;
        rating_subm = nan;

        %%Store output
        output.time = datetime;
        output.filename = sprintf('VAS_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);

        save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter');

    end

    if generalSettings.with_EGG == 1
        %write EGG trigger (end fcqtr)
        io64(LPT_IO_EGG,settings.EGG.port_address,255-settings.EGG.trigger.end_fcqtr);
    end

    %%Store output
    output.time = datetime;
    output.filename = sprintf('VAS_%s_%s_%s', subj.studyID, subj.subjectID, subj.sessionID);

    save(fullfile('data', [output.filename '.mat']), 'output', 'subj', 'load_questions', 'state_questions', 'fcqtr_questions', 'jitter');
    save(fullfile('Backup', [output.filename datestr(now,'_yymmdd_HHMM') '.mat']));

        %Information text on screen
        if settings.lang_de == 1
            text = ['Der Fragebogen wurde beendet. \nBitte bleiben Sie weiterhin ruhig liegen.'];
        else
            text = ['The questionnaire is now over. \nPlease continue lying still.']; %english translation
        end
        
        Screen('TextSize',w,32);
        Screen('TextFont',w,'Arial');
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, text, 'center', (setup.ScrHeight/5), color.black, 50, [], [], 1.2);
        Screen('Flip',w);
        WaitSecs(3)
        Screen('Flip',w);
end
    
