%%===================TUE006 Body Silhouette==============
%Script for coloring body silhouettes depending on stimulation perception
%(-20/01/2021-)
% 
%coded with: Matlab R2020a, Psychtoolbox 3.0, gstreamer 1.0
% 
%author: Sophie Mueller
%
%based on/inspired by: Nummenmaa L., Glerean E., Hari R., Hietanen, J.K. (2014)
% Bodily maps of emotions, Proceedings of the National Academy of Sciences of United States of America doi:10.1073/pnas.1321664111
% http://www.pnas.org/content/111/2/646.abstract
% 
%input via Mouse
% 
% Output: activation silhouette & deactivation silhouette (both RGB
% arrays), order of performed actions
%========================================================

%% Prepare workspace
% clear all
% close all
% sca
% Screen('Preference', 'SkipSyncTests', 1);

% %% Enter subject data
% subj.study_id = 'TUE006';
% subj.id = input('Subject ID (6 digits!)\n','s');
% subj.session = input('Session (1/2/3/4)\n');
% subj.condition = input('Condition (1/2/3/4)\n');
% subj.language = input('Language (de/en): \n','s');   

% if strcmpi(subj.language,'de')
%     lang_de = 1;
%     disp('Run in German.')
% else
%     lang_de = 0;
%     disp('Run in English.')
% end

lang_de = settings.lang_de;

%% Initiate settings
silhouetteSettings = load([pwd '\silhouette_settings.mat']); %includes brush, log_mask and pic

silhouetteSettings.brush_size = 12; %12 for large, 6 for small

if silhouetteSettings.brush_size == 6
    brush = silhouetteSettings.brush.small;
    log_mask = silhouetteSettings.log_mask.small;
else
    brush = silhouetteSettings.brush.large;
    log_mask = silhouetteSettings.log_mask.large;
end

silhouetteSettings.colorSpeed = 0.5; %this variable is a factor how fast the color will increase/decrease per click, 1 is standard, 0-1 is slower, >1 is faster (not recommended)

%Preallocation of variables to increase speed
ActivationCourse = zeros(100,3); %order of actions will be stored here
DeactivationCourse = zeros(100,3);

ActionCount = 1;

%Seperate RGB array for activation and Deactivation
ActivationSilhouette = silhouetteSettings.pic;
DeactivationSilhouette = silhouetteSettings.pic;

%Initialise text
if lang_de == 1    
    text_Cont = ['Weiter mit Mausklick.'];
    text_Left = ['Links'];
    text_Right = ['Rechts'];
    text_Button = ['W'];
    text_OutOfRange = ['Der gewaehlte Bereich liegt nicht auf der Silhouette.'];
else
    text_Cont = ['Continue with mouse click.']; %english translation
    text_Left = ['Left'];
    text_Right = ['Right'];
    text_Button = ['C'];
    text_OutOfRange = ['The selected area is not in the silhouette.']; %english translation
end

%% Start Task
% HideCursor()
[scr,scrRect] = Screen('OpenWindow',0,[1 1 1],[]); %open screen

% Screen settings
setup.ScrWidth = scrRect(3) - scrRect(1);
setup.ScrHeight = scrRect(4) - scrRect(2);
setup.ScrCenter = [setup.ScrWidth/2, setup.ScrHeight/2];
texture.Activation = Screen('MakeTexture', scr, ActivationSilhouette); 
texture.Deactivation = Screen('MakeTexture', scr, DeactivationSilhouette);
texture.Continue = Screen('MakeTexture',scr, silhouetteSettings.arrow);

% Instructions screen
if lang_de == 1
    text = ['In der folgenden Aufgabe geht es um Ihre persoenlichen Wahrnehmungen der Stimulation an Ihrem Koerper. Bitte waehlen Sie alle Bereiche auf der Koerpersilhouette aus, die fuer die jeweilige Frage zutreffen. Die Silhouette bezieht sich immer auf die Koerpervorderseite.'];
else
    text = ['The following task will test how you perceive the stimulation on your body. Please select all areas on the silhouette that answer or apply to each question. The silhouette always corresponds to the front side of the body.']; %english translation
end
Screen('TextSize',scr,32);
Screen('TextFont',scr,'Arial');
DrawFormattedText(scr, text, 'center', (setup.ScrHeight/5), [255 255 255], 60, [], [], 1.2);
DrawFormattedText(scr, text_Cont, 'center', (setup.ScrHeight/5*4.7), [255 255 255], 60, [], [], 1.2);
Screen('Flip',scr);
WaitSecs(0.5)
[x,y,button] = GetMouse;
while ~any(button)
    [x,y,button] = GetMouse;
end

% Instructions screen
if lang_de == 1
    text = ['Je haeufiger bzw. laenger Sie auf einen Bereich mit der linken Maustaste klicken, desto staerker wird dieser eingefaerbt. Um die Faerbung abzuschwaechen, koennen Sie mit der rechten Maustaste auf einen Bereich klicken. So koennen Sie Fehler bei der Eingabe korrigieren.'];
else
    text = ['The more often or the longer you click on a particular area, the stronger that area will be colored in. In case you made a mistake and need to fade out the color, you can click the area with the right mouse button.']; %english translation
end
Screen('TextSize',scr,32);
Screen('TextFont',scr,'Arial');
DrawFormattedText(scr, text, 'center', (setup.ScrHeight/5), [255 255 255], 60, [], [], 1.2);
DrawFormattedText(scr, text_Cont, 'center', (setup.ScrHeight/5*4.7), [255 255 255], 60, [], [], 1.2);
Screen('Flip',scr);
WaitSecs(0.5)
[x,y,button] = GetMouse;
while ~any(button)
    [x,y,button] = GetMouse;
end

% Instructions screen
if lang_de == 1
    text = ['Wenn Sie alle gewuenschten Markierungen zu einer Frage vorgenommen haben, druecken Sie mit der Maus auf den Pfeil-Knopf, um zur naechsten Frage zu gelangen. Bitte fahren Sie fort, sobald Sie bereit sind, mit der Aufgabe zu beginnen.'];
else
    text = ['When you are done marking the silhouette and answering each question, you can click on the arrow button with the mouse to go to the next question. Please continue as soon as you are ready to start the task.']; %english translation
end
Screen('TextSize',scr,32);
Screen('TextFont',scr,'Arial');
DrawFormattedText(scr, text, 'center', (setup.ScrHeight/5), [255 255 255], 60, [], [], 1.2);
DrawFormattedText(scr, text_Cont, 'center', (setup.ScrHeight/5*4.7), [255 255 255], 60, [], [], 1.2);
% Screen('FillRect', scr, [0 240 20], [setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
% DrawFormattedText(scr, text_Button, setup.ScrCenter(1)*1.5-15 , setup.ScrCenter(2)*1.5+10, [1 1 1], 60, [], [], 1.2);
Screen('DrawTexture', scr, texture.Continue, [],[setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
Screen('Flip',scr);
WaitSecs(0.5)
[x,y,button] = GetMouse;
while ~any(button)
    [x,y,button] = GetMouse;
end

%% Activation Silhouette
if lang_de == 1
    text = ['Bitte markieren Sie auf dieser Silhouette alle Koerperbereiche, die durch die Stimulation staerker aktiviert wurden. Bitte beachten Sie die Seitenangaben (rechts/links).'];
else
    text = ['Please mark on the silhouette all of the areas on the body that were activated more by the stimulation. Please note the side annotations (right/left).']; %english translation
end
Screen('TextSize',scr,32);
Screen('TextFont',scr,'Arial');
DrawFormattedText(scr, text, 'center', setup.ScrCenter(2)-450, [255 255 255], 60, [], [], 1.2);
DrawFormattedText(scr, text_Left, setup.ScrCenter(1)*0.5, 'center', [255 255 255], 60, [], [], 1.2);
DrawFormattedText(scr, text_Right,setup.ScrCenter(1)*1.5, 'center', [255 255 255], 60, [], [], 1.2);
% Screen('FillRect', scr, [0 240 20], [setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50]) 
% DrawFormattedText(scr, text_Button, setup.ScrCenter(1)*1.5-15 , setup.ScrCenter(2)*1.5+10, [1 1 1], 60, [], [], 1.2);
Screen('DrawTexture', scr, texture.Continue, [],[setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
Screen('DrawTexture', scr, texture.Activation,[],[setup.ScrCenter(1)-106 setup.ScrCenter(2)-310 setup.ScrCenter(1)+106 setup.ScrCenter(2)+310])
Screen('Flip',scr)
WaitSecs(0.5)

while true
    [x,y,button] = GetMouse;
    
    DrawFormattedText(scr, text, 'center', setup.ScrCenter(2)-450, [255 255 255], 60, [], [], 1.2);
    DrawFormattedText(scr, text_Left, setup.ScrCenter(1)*0.5, 'center', [255 255 255], 60, [], [], 1.2);
    DrawFormattedText(scr, text_Right,setup.ScrCenter(1)*1.5, 'center', [255 255 255], 60, [], [], 1.2);
    Screen('DrawTexture', scr, texture.Activation,[],[setup.ScrCenter(1)-106 setup.ScrCenter(2)-310 setup.ScrCenter(1)+106 setup.ScrCenter(2)+310])
%     Screen('FillRect', scr, [0 240 20], [setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
%     DrawFormattedText(scr, text_Button, setup.ScrCenter(1)*1.5-15 , setup.ScrCenter(2)*1.5+10, [1 1 1], 60, [], [], 1.2);
    Screen('DrawTexture', scr, texture.Continue, [],[setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
    Screen('FrameOval', scr , [105 105 105] ,[x-silhouetteSettings.brush_size y-silhouetteSettings.brush_size x+silhouetteSettings.brush_size y+silhouetteSettings.brush_size])
    Screen('Flip', scr)
    
    while ~any(button) %wait for mouseclick
        [x,y,button] = GetMouse;
        
        DrawFormattedText(scr, text, 'center', setup.ScrCenter(2)-450, [255 255 255], 60, [], [], 1.2);
        DrawFormattedText(scr, text_Left, setup.ScrCenter(1)*0.5, 'center', [255 255 255], 60, [], [], 1.2);
        DrawFormattedText(scr, text_Right,setup.ScrCenter(1)*1.5, 'center', [255 255 255], 60, [], [], 1.2);
        Screen('DrawTexture', scr, texture.Activation,[],[setup.ScrCenter(1)-106 setup.ScrCenter(2)-310 setup.ScrCenter(1)+106 setup.ScrCenter(2)+310])
%         Screen('FillRect', scr, [0 240 20], [setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
%         DrawFormattedText(scr, text_Button, setup.ScrCenter(1)*1.5-15 , setup.ScrCenter(2)*1.5+10, [1 1 1], 60, [], [], 1.2);
        Screen('DrawTexture', scr, texture.Continue, [],[setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
        Screen('FrameOval', scr , [105 105 105] ,[x-silhouetteSettings.brush_size y-silhouetteSettings.brush_size x+silhouetteSettings.brush_size y+silhouetteSettings.brush_size])
        Screen('Flip', scr)
    end
       
    % Finish trial if participant clicked 'continue'-box
    if x >= setup.ScrCenter(1)*1.5-50 && x <= setup.ScrCenter(1)*1.5+50 && y >= setup.ScrCenter(2)*1.5-50 && y <= setup.ScrCenter(2)*1.5+50
        if lang_de == 1
            text = ['Die aktuelle Silhouette wurde beendet. Sie koennen nun mit der naechsten Frage fortfahren.'];
        else
            text = ['You are now done with this slhouette. You can move on to the next question.']; %english translation
        end
        DrawFormattedText(scr, text, 'center', (setup.ScrHeight/5), [255 255 255], 60, [], [], 1.2);
        DrawFormattedText(scr, text_Cont, 'center', (setup.ScrHeight/5*4.7), [255 255 255], 60, [], [], 1.2);
        Screen('Flip', scr)
        WaitSecs(0.5)
        [x,y,button] = GetMouse;
        while ~any(button)
            [x,y,button] = GetMouse;
        end
        break
    end
    
    % Calculate picture position 
    y_pic = 310-(setup.ScrCenter(2)-y);
    x_pic = 106 - (setup.ScrCenter(1)-x);
    
    % Show warning if participant clicked outside of the silhouette's range
    if y_pic > 620 || y_pic <1 || x_pic > 212 || x_pic <1   
        DrawFormattedText(scr, text_OutOfRange, 'center', (setup.ScrHeight/5), [255 255 255], 60, [], [], 1.2);
        DrawFormattedText(scr, text_Cont, 'center', (setup.ScrHeight/5*4.7), [255 255 255], 60, [], [], 1.2);
        Screen('Flip', scr)
        WaitSecs(0.5)
        [x,y,button] = GetMouse;
        while ~any(button)
            [x,y,button] = GetMouse;
        end
        WaitSecs(0.5)
        continue               
    end
    
    error_marker = 0;
    if y_pic+silhouetteSettings.brush_size > 620
        y_upper = y_pic+silhouetteSettings.brush_size -620;
        if y_upper == 0
            error_marker = 1;
        end
    else
        y_upper = 0;
    end    
    if y_pic-silhouetteSettings.brush_size < 1
        y_lower = 1-(y_pic-silhouetteSettings.brush_size);
        if y_lower == 0
            error_marker = 1;
        end
    else
        y_lower = 0;
    end   
    if x_pic+silhouetteSettings.brush_size > 212
        x_upper = x_pic+silhouetteSettings.brush_size -212;
        if x_upper == 0
            error_marker = 1;
        end
    else
        x_upper = 0;
    end    
    if x_pic-silhouetteSettings.brush_size < 1
        x_lower = 1-(x_pic-silhouetteSettings.brush_size);
        if x_lower == 0
            error_marker = 1;
        end
    else
        x_lower = 0;
    end
    
    if error_marker > 0   
        DrawFormattedText(scr, text_OutOfRange, 'center', (setup.ScrHeight/5), [255 255 255], 60, [], [], 1.2);
        DrawFormattedText(scr, text_Cont, 'center', (setup.ScrHeight/5*4.7), [255 255 255], 60, [], [], 1.2);
        Screen('Flip', scr)
        WaitSecs(0.5)
        [x,y,button] = GetMouse;
        while ~any(button)
            [x,y,button] = GetMouse;
        end
        WaitSecs(0.5)        
        continue               
    end
    
    frame.R = ActivationSilhouette(y_pic-silhouetteSettings.brush_size+y_lower:y_pic+silhouetteSettings.brush_size-y_upper,x_pic-silhouetteSettings.brush_size+x_lower:x_pic+silhouetteSettings.brush_size-x_upper,1);
    frame.G = ActivationSilhouette(y_pic-silhouetteSettings.brush_size+y_lower:y_pic+silhouetteSettings.brush_size-y_upper,x_pic-silhouetteSettings.brush_size+x_lower:x_pic+silhouetteSettings.brush_size-x_upper,2);
    frame.B = ActivationSilhouette(y_pic-silhouetteSettings.brush_size+y_lower:y_pic+silhouetteSettings.brush_size-y_upper,x_pic-silhouetteSettings.brush_size+x_lower:x_pic+silhouetteSettings.brush_size-x_upper,3);
    
    i_log_mask = log_mask(1+y_upper:end-y_lower,1+x_lower:end-x_upper);
    i_brush = brush(1+y_upper:end-y_lower,1+x_lower:end-x_upper);
    
    frame.R_log = frame.R(i_log_mask);
    frame.G_log = frame.G(i_log_mask);
    frame.B_log = frame.B(i_log_mask);

    frame.RGB_log = [frame.R_log, frame.G_log, frame.B_log];
    frame.brush_log = i_brush(i_brush~=0);

    if button(1) == 1 %more activation (increasing color intensity)
        for i = 1:length(frame.RGB_log) % run through each pixel
            i_RGB = frame.RGB_log(i,:);
            if i_RGB(1,1:2) == 255 & i_RGB(1,3) > 51
                frame.RGB_log(i,3) = i_RGB(3)-frame.brush_log(i)*20.4*silhouetteSettings.colorSpeed;
                if frame.RGB_log(i,3) < 51
                    frame.RGB_log(i,3) = 51;
                end
            elseif i_RGB(1,1:3) == 1
                continue
            elseif i_RGB(3) > 0
                frame.RGB_log(i,3) = i_RGB(3)-frame.brush_log(i)*1.7*silhouetteSettings.colorSpeed;
                frame.RGB_log(i,2) = i_RGB(2)-frame.brush_log(i)*3.8*silhouetteSettings.colorSpeed;                
                if frame.RGB_log(i,2) < 140
                    frame.RGB_log(i,2) = 140;
                end               
            elseif i_RGB(3) == 0 & i_RGB(2) >= 0
                frame.RGB_log(i,2) = i_RGB(2)-frame.brush_log(i)*4.6*silhouetteSettings.colorSpeed;                           
            end
        end
        
        ActivationCourse(ActionCount,:) = [x_pic, y_pic, 1]; %store performed action
        ActionCount = ActionCount+1; %add performed action

    elseif button(3) == 1 %less activation (decreasing color intensity)
        for i = 1:length(frame.RGB_log) % run for each pixel
            i_RGB = frame.RGB_log(i,:);
            if i_RGB(1,1:2) == 255 & i_RGB(1,3) >= 51
                frame.RGB_log(i,3) = i_RGB(1,3)+frame.brush_log(i)*20.4*silhouetteSettings.colorSpeed;               
            elseif i_RGB(1,1:3) == 1
                continue
            elseif i_RGB(3) >= 0 & i_RGB(2) >= 140
                frame.RGB_log(i,3) = i_RGB(3)+frame.brush_log(i)*1.7*silhouetteSettings.colorSpeed;
                frame.RGB_log(i,2) = i_RGB(2)+frame.brush_log(i)*3.8*silhouetteSettings.colorSpeed;
                if frame.RGB_log(i,3) > 51
                    frame.RGB_log(i,3) = 51;
                end                              
            elseif i_RGB(3) == 0 & i_RGB(2) < 140
                frame.RGB_log(i,2) = i_RGB(2)+frame.brush_log(i)*4.6*silhouetteSettings.colorSpeed;              
                if frame.RGB_log(i,2) > 140
                    frame.RGB_log(i,2) = 140;
                end                
            end
        end
        
        ActivationCourse(ActionCount,:) = [x_pic, y_pic, -1]; %store performed action
        ActionCount = ActionCount+1; %add performed action

    end
    
    % put the changed part back into the whole silhouette
    frame.R(i_log_mask) = frame.RGB_log(:,1);
    frame.G(i_log_mask)= frame.RGB_log(:,2);
    frame.B(i_log_mask)= frame.RGB_log(:,3);
    
    ActivationSilhouette(y_pic-silhouetteSettings.brush_size+y_lower:y_pic+silhouetteSettings.brush_size-y_upper,x_pic-silhouetteSettings.brush_size+x_lower:x_pic+silhouetteSettings.brush_size-x_upper,1) = frame.R;
    ActivationSilhouette(y_pic-silhouetteSettings.brush_size+y_lower:y_pic+silhouetteSettings.brush_size-y_upper,x_pic-silhouetteSettings.brush_size+x_lower:x_pic+silhouetteSettings.brush_size-x_upper,2)= frame.G;
    ActivationSilhouette(y_pic-silhouetteSettings.brush_size+y_lower:y_pic+silhouetteSettings.brush_size-y_upper,x_pic-silhouetteSettings.brush_size+x_lower:x_pic+silhouetteSettings.brush_size-x_upper,3)= frame.B;

    % Update texture
    texture.Activation = Screen('MakeTexture', scr, ActivationSilhouette);
end

%save current results
save([pwd '\data\silhouette_' subj.studyID '_' subj.subjectID '_S' subj.sessionID], 'ActivationSilhouette', 'DeactivationSilhouette', 'ActivationCourse', 'DeactivationCourse', 'subj','silhouetteSettings')
save([pwd '\Backup\silhouette_' subj.studyID '_' subj.subjectID '_S' subj.sessionID datestr(now,'_yymmdd_HHMM')], 'ActivationSilhouette', 'DeactivationSilhouette', 'ActivationCourse', 'DeactivationCourse', 'subj','silhouetteSettings')

%% Deactivation silhouette
if lang_de == 1
    text = ['Bitte markieren Sie auf dieser Silhouette alle Koerperbereiche, die durch die Stimulation weniger aktiviert wurden.'];
else
    text = ['Please mark on the silhouette all of the areas on the body that were activated less by the stimulation.']; %english translation
end
Screen('TextSize',scr,32);
Screen('TextFont',scr,'Arial');
DrawFormattedText(scr, text, 'center', setup.ScrCenter(2)-450, [255 255 255], 60, [], [], 1.2);
DrawFormattedText(scr, text_Left, setup.ScrCenter(1)*0.5, 'center', [255 255 255], 60, [], [], 1.2);
DrawFormattedText(scr, text_Right,setup.ScrCenter(1)*1.5, 'center', [255 255 255], 60, [], [], 1.2);
% Screen('FillRect', scr, [0 240 20], [setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
% DrawFormattedText(scr, text_Button, setup.ScrCenter(1)*1.5-15 , setup.ScrCenter(2)*1.5+10, [1 1 1], 60, [], [], 1.2);
Screen('DrawTexture', scr, texture.Continue, [],[setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
Screen('DrawTexture', scr, texture.Deactivation,[],[setup.ScrCenter(1)-106 setup.ScrCenter(2)-310 setup.ScrCenter(1)+106 setup.ScrCenter(2)+310])
Screen('Flip',scr)
WaitSecs(0.5)

ActionCount = 1; %reset ActionCount for Deactivation part

while true
    [x,y,button] = GetMouse;

    DrawFormattedText(scr, text, 'center', setup.ScrCenter(2)-450, [255 255 255], 60, [], [], 1.2);
    DrawFormattedText(scr, text_Left, setup.ScrCenter(1)*0.5, 'center', [255 255 255], 60, [], [], 1.2);
    DrawFormattedText(scr, text_Right,setup.ScrCenter(1)*1.5, 'center', [255 255 255], 60, [], [], 1.2);
    Screen('DrawTexture', scr, texture.Deactivation,[],[setup.ScrCenter(1)-106 setup.ScrCenter(2)-310 setup.ScrCenter(1)+106 setup.ScrCenter(2)+310])
%     Screen('FillRect', scr, [0 240 20], [setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
%     DrawFormattedText(scr, text_Button, setup.ScrCenter(1)*1.5-15 , setup.ScrCenter(2)*1.5+10, [1 1 1], 60, [], [], 1.2);
    Screen('DrawTexture', scr, texture.Continue, [],[setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
    Screen('FrameOval', scr , [105 105 105] ,[x-silhouetteSettings.brush_size y-silhouetteSettings.brush_size x+silhouetteSettings.brush_size y+silhouetteSettings.brush_size])
    Screen('Flip', scr)
    
    while ~any(button) %wait for click
        [x,y,button] = GetMouse;
        
        DrawFormattedText(scr, text, 'center', setup.ScrCenter(2)-450, [255 255 255], 60, [], [], 1.2);
        DrawFormattedText(scr, text_Left, setup.ScrCenter(1)*0.5, 'center', [255 255 255], 60, [], [], 1.2);
        DrawFormattedText(scr, text_Right,setup.ScrCenter(1)*1.5, 'center', [255 255 255], 60, [], [], 1.2);
        Screen('DrawTexture', scr, texture.Deactivation,[],[setup.ScrCenter(1)-106 setup.ScrCenter(2)-310 setup.ScrCenter(1)+106 setup.ScrCenter(2)+310])
%         Screen('FillRect', scr, [0 240 20], [setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
%         DrawFormattedText(scr, text_Button, setup.ScrCenter(1)*1.5-15 , setup.ScrCenter(2)*1.5+10, [1 1 1], 60, [], [], 1.2);
        Screen('DrawTexture', scr, texture.Continue, [],[setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
        Screen('FrameOval', scr , [105 105 105] ,[x-silhouetteSettings.brush_size y-silhouetteSettings.brush_size x+silhouetteSettings.brush_size y+silhouetteSettings.brush_size])
        Screen('Flip', scr)
    end
    
    % Finish trial if participant clicked "Continue"
    if x >= setup.ScrCenter(1)*1.5-50 && x <= setup.ScrCenter(1)*1.5+50 && y >= setup.ScrCenter(2)*1.5-50 && y <= setup.ScrCenter(2)*1.5+50
        if lang_de ==1
            text = ['Die Aufgabe wurde beendet. Der naechste Fragebogen wird geladen. Das kann einen Moment dauern.'];
        else
            text = ['You are now done with the task. The next questionnaire will now load. This can take a moment.']; %english translation]; %english translation
        end
        DrawFormattedText(scr, text, 'center', (setup.ScrHeight/5), [255 255 255], 60, [], [], 1.2);
        DrawFormattedText(scr, text_Cont, 'center', (setup.ScrHeight/5*4.7), [255 255 255], 60, [], [], 1.2);
        Screen('Flip', scr)
        WaitSecs(0.5)
        [x,y,button] = GetMouse;
        while ~any(button)
            [x,y,button] = GetMouse;
        end
        break
    end
    
    % Calculate position in picture
    y_pic = 310-(setup.ScrCenter(2)-y);
    x_pic = 106 - (setup.ScrCenter(1)-x);
    
    % Show warning if participant click outside of the silhouette's range
    if y_pic > 620 || y_pic <1 || x_pic > 212 || x_pic <1          
        DrawFormattedText(scr, text_OutOfRange, 'center', (setup.ScrHeight/5), [255 255 255], 60, [], [], 1.2);
        DrawFormattedText(scr, text_Cont, 'center', (setup.ScrHeight/5*4.7), [255 255 255], 60, [], [], 1.2);
        Screen('Flip', scr)
        WaitSecs(0.5)
        [x,y,button] = GetMouse;
        while ~any(button)
            [x,y,button] = GetMouse;
        end
        WaitSecs(0.5)
        continue               
    end
    
    error_marker = 0;
    if y_pic+silhouetteSettings.brush_size > 620
        y_upper = y_pic+silhouetteSettings.brush_size -620;
        if y_upper == 0
            error_marker = 1;
        end
    else
        y_upper = 0;
    end    
    if y_pic-silhouetteSettings.brush_size < 1
        y_lower = 1-(y_pic-silhouetteSettings.brush_size);
        if y_lower == 0
            error_marker = 1;
        end
    else
        y_lower = 0;
    end   
    if x_pic+silhouetteSettings.brush_size > 212
        x_upper = x_pic+silhouetteSettings.brush_size -212;
        if x_upper == 0
            error_marker = 1;
        end
    else
        x_upper = 0;
    end    
    if x_pic-silhouetteSettings.brush_size < 1
        x_lower = 1-(x_pic-silhouetteSettings.brush_size);
        if x_lower == 0
            error_marker = 1;
        end
    else
        x_lower = 0;
    end
    
    if error_marker > 0   
        DrawFormattedText(scr, text_OutOfRange, 'center', (setup.ScrHeight/5), [255 255 255], 60, [], [], 1.2);
        DrawFormattedText(scr, text_Cont, 'center', (setup.ScrHeight/5*4.7), [255 255 255], 60, [], [], 1.2);
        Screen('Flip', scr)
        WaitSecs(0.5)
        [x,y,button] = GetMouse;
        while ~any(button)
            [x,y,button] = GetMouse;
        end
        WaitSecs(0.5)        
        continue               
    end
    
    frame.R = DeactivationSilhouette(y_pic-silhouetteSettings.brush_size+y_lower:y_pic+silhouetteSettings.brush_size-y_upper,x_pic-silhouetteSettings.brush_size+x_lower:x_pic+silhouetteSettings.brush_size-x_upper,1);
    frame.G = DeactivationSilhouette(y_pic-silhouetteSettings.brush_size+y_lower:y_pic+silhouetteSettings.brush_size-y_upper,x_pic-silhouetteSettings.brush_size+x_lower:x_pic+silhouetteSettings.brush_size-x_upper,2);
    frame.B = DeactivationSilhouette(y_pic-silhouetteSettings.brush_size+y_lower:y_pic+silhouetteSettings.brush_size-y_upper,x_pic-silhouetteSettings.brush_size+x_lower:x_pic+silhouetteSettings.brush_size-x_upper,3);
    
    i_log_mask = log_mask(1+y_upper:end-y_lower,1+x_lower:end-x_upper);
    i_brush = brush(1+y_upper:end-y_lower,1+x_lower:end-x_upper);
    
    frame.R_log = frame.R(i_log_mask);
    frame.G_log = frame.G(i_log_mask);
    frame.B_log = frame.B(i_log_mask);

    frame.RGB_log = [frame.R_log, frame.G_log, frame.B_log];
    frame.brush_log = i_brush(i_brush~=0);
    
    if button(1) == 1 %more Deactivation (increasing color intensity)
        for i = 1:length(frame.RGB_log) % run for each pixel
            i_RGB = frame.RGB_log(i,:);
            if i_RGB(1,2) == 255 & i_RGB(1,1) > 153
                frame.RGB_log(i,3) = i_RGB(3)-frame.brush_log(i)*3.4*silhouetteSettings.colorSpeed;
                frame.RGB_log(i,1) = i_RGB(1)-frame.brush_log(i)*3.4*silhouetteSettings.colorSpeed;
                if frame.RGB_log(i,1) < 153
                    frame.RGB_log(i,1) = 153;
                end
                if frame.RGB_log(i,3) < 153
                    frame.RGB_log(i,3) = 153;
                end
            elseif i_RGB(1,1:3) == 1
                continue
            elseif i_RGB(3) == 255 & i_RGB(1) <= 102
                frame.RGB_log(i,2) = i_RGB(2)-frame.brush_log(i)*3.4*silhouetteSettings.colorSpeed;
                frame.RGB_log(i,1) = i_RGB(1)-frame.brush_log(i)*1.7*silhouetteSettings.colorSpeed;
                if frame.RGB_log(i,2) < 153
                    frame.RGB_log(i,2) = 153;
                end  
                if frame.RGB_log(i,1) < 51
                    frame.RGB_log(i,1) = 51;
                end 
            elseif i_RGB(1) >= 102 & i_RGB(3) <= 255
                frame.RGB_log(i,3) = i_RGB(3)+frame.brush_log(i)*3.4*silhouetteSettings.colorSpeed;   
                frame.RGB_log(i,1) = i_RGB(1)-frame.brush_log(i)*1.7*silhouetteSettings.colorSpeed;                              
                if frame.RGB_log(i,1) < 102
                    frame.RGB_log(i,1) = 102;
                end   
            end
        end
        
        DeactivationCourse(ActionCount,:) = [x_pic, y_pic, 1]; %store action
        ActionCount = ActionCount+1; % add action

    elseif button(3) == 1 %less Deactivation (decreasing color intensity)
        for i = 1:length(frame.RGB_log) %run for each pixel
            i_RGB = frame.RGB_log(i,:);
            if i_RGB(1,2) == 255 & i_RGB(1,1) >= 153
                frame.RGB_log(i,3) = i_RGB(3)+frame.brush_log(i)*3.4*silhouetteSettings.colorSpeed;
                frame.RGB_log(i,1) = i_RGB(1)+frame.brush_log(i)*3.4*silhouetteSettings.colorSpeed;                
            elseif i_RGB(1,1:3) == 1
                continue
            elseif i_RGB(3) == 255 & i_RGB(1) < 102 | i_RGB(2) <255
                frame.RGB_log(i,2) = i_RGB(2)+frame.brush_log(i)*3.4*silhouetteSettings.colorSpeed;
                frame.RGB_log(i,1) = i_RGB(1)+frame.brush_log(i)*1.7*silhouetteSettings.colorSpeed;
                if frame.RGB_log(i,1) > 102
                    frame.RGB_log(i,1) = 102;
                end 
            elseif i_RGB(1) <=153 & i_RGB(3) <= 255
                frame.RGB_log(i,3) = i_RGB(3)-frame.brush_log(i)*3.4*silhouetteSettings.colorSpeed;   
                frame.RGB_log(i,1) = i_RGB(1)+frame.brush_log(i)*1.7*silhouetteSettings.colorSpeed;                              
                if frame.RGB_log(i,1) > 153
                    frame.RGB_log(i,1) = 153;
                end   
                if frame.RGB_log(i,3) < 153
                    frame.RGB_log(i,3) = 153;
                end 
            end
        end
        
        DeactivationCourse(ActionCount,:) = [x_pic, y_pic, -1]; %store action
        ActionCount = ActionCount+1; %add action

    end
    
    % put manipulated part back into whole silhouette
    frame.R(i_log_mask) = frame.RGB_log(:,1);
    frame.G(i_log_mask)= frame.RGB_log(:,2);
    frame.B(i_log_mask)= frame.RGB_log(:,3);
    
    DeactivationSilhouette(y_pic-silhouetteSettings.brush_size+y_lower:y_pic+silhouetteSettings.brush_size-y_upper,x_pic-silhouetteSettings.brush_size+x_lower:x_pic+silhouetteSettings.brush_size-x_upper,1) = frame.R;
    DeactivationSilhouette(y_pic-silhouetteSettings.brush_size+y_lower:y_pic+silhouetteSettings.brush_size-y_upper,x_pic-silhouetteSettings.brush_size+x_lower:x_pic+silhouetteSettings.brush_size-x_upper,2)= frame.G;
    DeactivationSilhouette(y_pic-silhouetteSettings.brush_size+y_lower:y_pic+silhouetteSettings.brush_size-y_upper,x_pic-silhouetteSettings.brush_size+x_lower:x_pic+silhouetteSettings.brush_size-x_upper,3)= frame.B;
    
    % update texture
    texture.Deactivation = Screen('MakeTexture', scr, DeactivationSilhouette);

end

%% Close Screen
% sca
Screen('Close', scr)
%ShowCursor()

%% Save results
save([pwd '\Data\silhouette_' subj.studyID '_' subj.subjectID '_S' subj.sessionID], 'ActivationSilhouette', 'DeactivationSilhouette', 'ActivationCourse', 'DeactivationCourse', 'subj','silhouetteSettings')
save([pwd '\Backup\silhouette_' subj.studyID '_' subj.subjectID '_S' subj.sessionID datestr(now,'_yymmdd_HHMM')], 'ActivationSilhouette', 'DeactivationSilhouette', 'ActivationCourse', 'DeactivationCourse', 'subj','silhouetteSettings')
