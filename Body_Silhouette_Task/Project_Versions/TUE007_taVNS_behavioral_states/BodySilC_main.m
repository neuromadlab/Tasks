%%=================== Body Silhouette Coloring Task =======================
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
%==========================================================================

%% Prepare workspace
clear all
close all
sca
Screen('Preference', 'SkipSyncTests', 1);

%% Create Data and Backup Folder
%mkdir([pwd '/Data']) %mkdir only creates a new folder if it doesn't exist yet, you can also comment this section after you set up the folders if you prefer
%mkdir([pwd '/Backup'])

%% Enter subject data
subj.study_id = 'TUE007';
subj.id = input('Subject ID (6 digits!)\n','s');
subj.session = input('Session (1/2/3/4)\n');
subj.language = 'de'; %only German for Tue007 so far

if strcmpi(subj.language,'de')
    lang_de = 1;
    disp('Run in German.')
else
    lang_de = 0;
    disp('Run in English.')
end

%% Initiate settings
settings = load([pwd '\silhouette_settings.mat']); %includes brush, log_mask, arrow pic and silhouette pic

% Set brush size, the radius for the small brush is 6 pixels, for the large
% brush 12 pixels
settings.brush_size = 12; %12 for large, 6 for small
if settings.brush_size == 6
    brush = settings.brush.small;
    log_mask = settings.log_mask.small;
else
    brush = settings.brush.large;
    log_mask = settings.log_mask.large;
end

% Set color change speed
settings.colorSpeed = 0.5; %this variable is a factor how fast the color will increase/decrease per click, 1 is standard, 0-1 is slower, >1 is faster (not recommended)

%Preallocation of variables to increase speed 
ActivationCourse = zeros(100,3); %order of actions will be stored here
DeactivationCourse = zeros(100,3);
ActionCount = 1;

%Separate RGB array for activation and deactivation
ActivationSilhouette = settings.pic;
DeactivationSilhouette = settings.pic;
SettingsSilhouette = settings.pic;


%Initialise text
if lang_de == 1    
    text_Cont = ['Weiter mit Mausklick.'];
    text_Left = ['Links'];
    text_Right = ['Rechts'];
%     text_Button = ['W'];
    text_OutOfRange = ['Der gewaehlte Bereich liegt nicht auf der Silhouette.'];
else
    text_Cont = ['Continue with mouse click.']; %english translation
    text_Left = ['Left'];
    text_Right = ['Right'];
%     text_Button = ['C'];
    text_OutOfRange = ['The selected area is not in the silhouette.']; %english translation
end

%% Start Task
HideCursor()
[scr,scrRect] = Screen('OpenWindow',0,[1 1 1],[]); %open screen

% Screen settings
setup.ScrWidth = scrRect(3) - scrRect(1);
setup.ScrHeight = scrRect(4) - scrRect(2);
setup.ScrCenter = [setup.ScrWidth/2, setup.ScrHeight/2];

% Make textures to present silhouette pictures
texture.Activation = Screen('MakeTexture', scr, ActivationSilhouette); 
texture.Deactivation = Screen('MakeTexture', scr, DeactivationSilhouette);
texture.Settings = Screen('MakeTexture', scr, SettingsSilhouette);
texture.Continue = Screen('MakeTexture',scr, settings.arrow);

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
% Continue with Mouseclick
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
[x,y,button] = GetMouse; %wait for mouseclick
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

%% Silhouette side settings
if lang_de == 1
    text = ['Bitte klicken Sie auf die Koerperseite, die Sie als rechts wahrnehmen.'];
else
    text = ['Please mark on the silhouette the right side.']; %english translation
end
Screen('TextSize',scr,32);
Screen('TextFont',scr,'Arial');
DrawFormattedText(scr, text, 'center', setup.ScrCenter(2)-450, [255 255 255], 60, [], [], 1.2);
%DrawFormattedText(scr, text_Left, setup.ScrCenter(1)*0.5, 'center', [255 255 255], 60, [], [], 1.2);
%DrawFormattedText(scr, text_Right,setup.ScrCenter(1)*1.5, 'center', [255 255 255], 60, [], [], 1.2);
% Screen('FillRect', scr, [0 240 20], [setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50]) 
% DrawFormattedText(scr, text_Button, setup.ScrCenter(1)*1.5-15 , setup.ScrCenter(2)*1.5+10, [1 1 1], 60, [], [], 1.2);
Screen('DrawTexture', scr, texture.Continue, [],[setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
Screen('DrawTexture', scr, texture.Settings,[],[setup.ScrCenter(1)-106 setup.ScrCenter(2)-310 setup.ScrCenter(1)+106 setup.ScrCenter(2)+310])
Screen('Flip',scr)
WaitSecs(0.5)

settings.flag_left = NaN;
while true
    try
        [x,y,button] = GetMouse;

        DrawFormattedText(scr, text, 'center', setup.ScrCenter(2)-450, [255 255 255], 60, [], [], 1.2);
        %DrawFormattedText(scr, text_Left, setup.ScrCenter(1)*0.5, 'center', [255 255 255], 60, [], [], 1.2);
        %DrawFormattedText(scr, text_Right,setup.ScrCenter(1)*1.5, 'center', [255 255 255], 60, [], [], 1.2);
        Screen('DrawTexture', scr, texture.Settings,[],[setup.ScrCenter(1)-106 setup.ScrCenter(2)-310 setup.ScrCenter(1)+106 setup.ScrCenter(2)+310])
    %     Screen('FillRect', scr, [0 240 20], [setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
    %     DrawFormattedText(scr, text_Button, setup.ScrCenter(1)*1.5-15 , setup.ScrCenter(2)*1.5+10, [1 1 1], 60, [], [], 1.2);
        Screen('DrawTexture', scr, texture.Continue, [],[setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
        Screen('FrameOval', scr , [105 105 105] ,[x-settings.brush_size y-settings.brush_size x+settings.brush_size y+settings.brush_size])
        Screen('Flip', scr)

        while ~any(button) %wait for mouseclick
            [x,y,button] = GetMouse;

            DrawFormattedText(scr, text, 'center', setup.ScrCenter(2)-450, [255 255 255], 60, [], [], 1.2);
            %DrawFormattedText(scr, text_Left, setup.ScrCenter(1)*0.5, 'center', [255 255 255], 60, [], [], 1.2);
            %DrawFormattedText(scr, text_Right,setup.ScrCenter(1)*1.5, 'center', [255 255 255], 60, [], [], 1.2);
            Screen('DrawTexture', scr, texture.Settings,[],[setup.ScrCenter(1)-106 setup.ScrCenter(2)-310 setup.ScrCenter(1)+106 setup.ScrCenter(2)+310])
    %         Screen('FillRect', scr, [0 240 20], [setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
    %         DrawFormattedText(scr, text_Button, setup.ScrCenter(1)*1.5-15 , setup.ScrCenter(2)*1.5+10, [1 1 1], 60, [], [], 1.2);
            Screen('DrawTexture', scr, texture.Continue, [],[setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
            Screen('FrameOval', scr , [105 105 105] ,[x-settings.brush_size y-settings.brush_size x+settings.brush_size y+settings.brush_size])
            Screen('Flip', scr)
        end

        % Finish trial if participant clicked on 'continue'-box (=arrow)
        if x >= setup.ScrCenter(1)*1.5-50 && x <= setup.ScrCenter(1)*1.5+50 && y >= setup.ScrCenter(2)*1.5-50 && y <= setup.ScrCenter(2)*1.5+50
            if isnan(settings.flag_left)
                if lang_de == 1
                    text = ['Sie müssen eine Seite markieren.'];
                else
                    text = ['You have to mark a side.']; %english translation
                end
                DrawFormattedText(scr, text, 'center', (setup.ScrHeight/5), [255 255 255], 60, [], [], 1.2);
                DrawFormattedText(scr, text_Cont, 'center', (setup.ScrHeight/5*4.7), [255 255 255], 60, [], [], 1.2);
                Screen('Flip', scr)
                WaitSecs(0.5)
                [x,y,button] = GetMouse;
                while ~any(button)
                    [x,y,button] = GetMouse;
                end
                
                if lang_de == 1
                    text = ['Bitte klicken Sie auf die Körperseite, die Sie als rechts wahrnehmen.'];
                else
                    text = ['Please mark on the silhouette the right side.'];
                end
                
                continue
            end
                
            if lang_de == 1
                text = ['Ihre Seitenpraeferenz wurde gespeichert. Sie koennen nun mit der Aufgabe fortfahren.'];
            else
                text = ['Your side preference settings have been saved. You can move on to the task.']; %english translation
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

        % Calculate picture position (transformation of mouse position on
        % screen to corresponding point on the silhouette pic)
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

        if x_pic <= 106
            all_RGB = SettingsSilhouette(:,1:106,:);
            other_RGB = SettingsSilhouette(:,107:212,:);
        else
            all_RGB = SettingsSilhouette(:,107:212,:);
            other_RGB = SettingsSilhouette(:,1:106,:);
        end

        all_RGB = reshape(all_RGB,[65720,3]);
        all_RGB(all_RGB(:,2) == 255,2) = 131;
        all_RGB(all_RGB(:,3) == 255,3) = 0;
        
        other_RGB = reshape(other_RGB,[65720,3]);    
        other_RGB(other_RGB(:,1) == 255,2) = 255;
        other_RGB(other_RGB(:,1) == 255,3) = 255;

        if x_pic <= 106
            SettingsSilhouette(:,1:106,:) = reshape(all_RGB,[620,106,3]);
            SettingsSilhouette(:,107:212,:) = reshape(other_RGB,[620,106,3]);
            settings.flag_left = 1;
        else
            SettingsSilhouette(:,107:212,:) = reshape(all_RGB,[620,106,3]);
            SettingsSilhouette(:,1:106,:) = reshape(other_RGB,[620,106,3]);
            settings.flag_left = 0;            
        end
        
        texture.Settings = Screen('MakeTexture', scr, SettingsSilhouette); 
    catch
        sca
    end
end

if settings.flag_left == 1 %if flag_left
    ActivationSilhouette = flip(ActivationSilhouette,2);
    DeactivationSilhouette = flip(DeactivationSilhouette,2);
    
    if lang_de == 1
        text_Left = ['Rechts'];
        text_Right = ['Links'];
    else
        text_Left = ['Right'];
        text_Right = ['Left'];
    end
    
    texture.Activation = Screen('MakeTexture', scr, ActivationSilhouette); 
    texture.Deactivation = Screen('MakeTexture', scr, DeactivationSilhouette);
end       

%% Activation Silhouette
if lang_de == 1
    text = ['Bitte markieren Sie auf dieser Silhouette alle Koerperbereiche, die durch die Stimulation staerker aktiviert wurden.'];
else
    text = ['Please mark on the silhouette all of the areas on the body that were activated more by the stimulation.']; %english translation
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
    Screen('FrameOval', scr , [105 105 105] ,[x-settings.brush_size y-settings.brush_size x+settings.brush_size y+settings.brush_size])
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
        Screen('FrameOval', scr , [105 105 105] ,[x-settings.brush_size y-settings.brush_size x+settings.brush_size y+settings.brush_size])
        Screen('Flip', scr)
    end
       
    % Finish trial if participant clicked on 'continue'-box (=arrow)
    if x >= setup.ScrCenter(1)*1.5-50 && x <= setup.ScrCenter(1)*1.5+50 && y >= setup.ScrCenter(2)*1.5-50 && y <= setup.ScrCenter(2)*1.5+50
        if lang_de == 1
            text = ['Die aktuelle Silhouette wurde beendet. Sie koennen nun mit der naechsten Frage fortfahren.'];
        else
            text = ['You are now done with this silhouette. You can move on to the next question.']; %english translation
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
    
    % Calculate picture position (transformation of mouse position on
    % screen to corresponding point on the silhouette pic)
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
    
    % Check for borderline cases (where one part of the brush is still in the
    % pic and another part already outside of it), determine x and y max
    % and min borders
    error_marker = 0; %check for special errors
    if y_pic+settings.brush_size > 620
        y_upper = y_pic+settings.brush_size -620;
        if y_upper == 0
            error_marker = 1;
        end
    else
        y_upper = 0;
    end    
    if y_pic-settings.brush_size < 1
        y_lower = 1-(y_pic-settings.brush_size);
        if y_lower == 0
            error_marker = 1;
        end
    else
        y_lower = 0;
    end   
    if x_pic+settings.brush_size > 212
        x_upper = x_pic+settings.brush_size -212;
        if x_upper == 0
            error_marker = 1;
        end
    else
        x_upper = 0;
    end    
    if x_pic-settings.brush_size < 1
        x_lower = 1-(x_pic-settings.brush_size);
        if x_lower == 0
            error_marker = 1;
        end
    else
        x_lower = 0;
    end
    
    % Show out of range message if an error occured
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
    
    %Get RGB data for the selected part of the silhouette
    frame.R = ActivationSilhouette(y_pic-settings.brush_size+y_lower:y_pic+settings.brush_size-y_upper,x_pic-settings.brush_size+x_lower:x_pic+settings.brush_size-x_upper,1);
    frame.G = ActivationSilhouette(y_pic-settings.brush_size+y_lower:y_pic+settings.brush_size-y_upper,x_pic-settings.brush_size+x_lower:x_pic+settings.brush_size-x_upper,2);
    frame.B = ActivationSilhouette(y_pic-settings.brush_size+y_lower:y_pic+settings.brush_size-y_upper,x_pic-settings.brush_size+x_lower:x_pic+settings.brush_size-x_upper,3);
    
    %Fit log_mask and brush to the individual borders of the selected part
    %(so that only parts in the picture will be selected)
    i_log_mask = log_mask(1+y_upper:end-y_lower,1+x_lower:end-x_upper);
    i_brush = brush(1+y_upper:end-y_lower,1+x_lower:end-x_upper);
    
    %select the circular (=brush shape) data
    frame.R_log = frame.R(i_log_mask);
    frame.G_log = frame.G(i_log_mask);
    frame.B_log = frame.B(i_log_mask);

    frame.RGB_log = [frame.R_log, frame.G_log, frame.B_log];
    frame.brush_log = i_brush(i_brush~=0); %gaussian color increase parameter for circular shape

    if button(1) == 1 %left mouse button = more activation (increasing color intensity), color pattern: white -> yellow -> orange -> red
        for i = 1:length(frame.RGB_log) % run through each pixel
            i_RGB = frame.RGB_log(i,:);
            if i_RGB(1,1:2) == 255 & i_RGB(1,3) > 51
                frame.RGB_log(i,3) = i_RGB(3)-frame.brush_log(i)*20.4*settings.colorSpeed;
                if frame.RGB_log(i,3) < 51
                    frame.RGB_log(i,3) = 51;
                end
            elseif i_RGB(1,1:3) == 1
                continue
            elseif i_RGB(3) > 0
                frame.RGB_log(i,3) = i_RGB(3)-frame.brush_log(i)*1.7*settings.colorSpeed;
                frame.RGB_log(i,2) = i_RGB(2)-frame.brush_log(i)*3.8*settings.colorSpeed;                
                if frame.RGB_log(i,2) < 140
                    frame.RGB_log(i,2) = 140;
                end               
            elseif i_RGB(3) == 0 & i_RGB(2) >= 0
                frame.RGB_log(i,2) = i_RGB(2)-frame.brush_log(i)*4.6*settings.colorSpeed;                           
            end
        end
        
        ActivationCourse(ActionCount,:) = [x_pic, y_pic, 1]; %store performed action
        ActionCount = ActionCount+1; %add performed action

    elseif button(3) == 1 %right mouse button = less activation (decreasing color intensity) red -> orange -> yellow -> white
        for i = 1:length(frame.RGB_log) % run for each pixel
            i_RGB = frame.RGB_log(i,:);
            if i_RGB(1,1:2) == 255 & i_RGB(1,3) >= 51
                frame.RGB_log(i,3) = i_RGB(1,3)+frame.brush_log(i)*20.4*settings.colorSpeed;               
            elseif i_RGB(1,1:3) == 1
                continue
            elseif i_RGB(3) >= 0 & i_RGB(2) >= 140
                frame.RGB_log(i,3) = i_RGB(3)+frame.brush_log(i)*1.7*settings.colorSpeed;
                frame.RGB_log(i,2) = i_RGB(2)+frame.brush_log(i)*3.8*settings.colorSpeed;
                if frame.RGB_log(i,3) > 51
                    frame.RGB_log(i,3) = 51;
                end                              
            elseif i_RGB(3) == 0 & i_RGB(2) < 140
                frame.RGB_log(i,2) = i_RGB(2)+frame.brush_log(i)*4.6*settings.colorSpeed;              
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
    
    ActivationSilhouette(y_pic-settings.brush_size+y_lower:y_pic+settings.brush_size-y_upper,x_pic-settings.brush_size+x_lower:x_pic+settings.brush_size-x_upper,1) = frame.R;
    ActivationSilhouette(y_pic-settings.brush_size+y_lower:y_pic+settings.brush_size-y_upper,x_pic-settings.brush_size+x_lower:x_pic+settings.brush_size-x_upper,2)= frame.G;
    ActivationSilhouette(y_pic-settings.brush_size+y_lower:y_pic+settings.brush_size-y_upper,x_pic-settings.brush_size+x_lower:x_pic+settings.brush_size-x_upper,3)= frame.B;

    % Update texture
    texture.Activation = Screen('MakeTexture', scr, ActivationSilhouette);
end

%save current results
save([pwd '\Data\silhouette_' subj.study_id '_' num2str(subj.id) '_S' num2str(subj.session)], 'ActivationSilhouette', 'DeactivationSilhouette', 'ActivationCourse', 'DeactivationCourse', 'subj','settings')
save([pwd '\Backup\silhouette_' subj.study_id '_' num2str(subj.id) '_S' num2str(subj.session)], 'ActivationSilhouette', 'DeactivationSilhouette', 'ActivationCourse', 'DeactivationCourse', 'subj','settings')

%% Deactivation silhouette
if lang_de == 1
    text = ['Bitte markieren Sie auf dieser Silhouette alle Koerperbereiche, die durch die Stimulation staerker inaktiviert wurden.'];
else
    text = ['Please mark on the silhouette all of the areas on the body that were more deactivated by the stimulation.']; %english translation
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

ActionCount = 1; %reset ActionCount for deactivation part

while true
    [x,y,button] = GetMouse;

    DrawFormattedText(scr, text, 'center', setup.ScrCenter(2)-450, [255 255 255], 60, [], [], 1.2);
    DrawFormattedText(scr, text_Left, setup.ScrCenter(1)*0.5, 'center', [255 255 255], 60, [], [], 1.2);
    DrawFormattedText(scr, text_Right,setup.ScrCenter(1)*1.5, 'center', [255 255 255], 60, [], [], 1.2);
    Screen('DrawTexture', scr, texture.Deactivation,[],[setup.ScrCenter(1)-106 setup.ScrCenter(2)-310 setup.ScrCenter(1)+106 setup.ScrCenter(2)+310])
%     Screen('FillRect', scr, [0 240 20], [setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
%     DrawFormattedText(scr, text_Button, setup.ScrCenter(1)*1.5-15 , setup.ScrCenter(2)*1.5+10, [1 1 1], 60, [], [], 1.2);
    Screen('DrawTexture', scr, texture.Continue, [],[setup.ScrCenter(1)*1.5-50 setup.ScrCenter(2)*1.5-50 setup.ScrCenter(1)*1.5+50 setup.ScrCenter(2)*1.5+50])
    Screen('FrameOval', scr , [105 105 105] ,[x-settings.brush_size y-settings.brush_size x+settings.brush_size y+settings.brush_size])
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
        Screen('FrameOval', scr , [105 105 105] ,[x-settings.brush_size y-settings.brush_size x+settings.brush_size y+settings.brush_size])
        Screen('Flip', scr)
    end
    
    % Finish trial if participant clicked on the arrow button
    if x >= setup.ScrCenter(1)*1.5-50 && x <= setup.ScrCenter(1)*1.5+50 && y >= setup.ScrCenter(2)*1.5-50 && y <= setup.ScrCenter(2)*1.5+50
        if lang_de ==1
            text = ['Die Aufgabe wurde beendet. Vielen Dank!'];
        else
            text = ['You are now done with the task. Thank you!']; %english translation
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
    
    % determine brush borders / check for errors
    error_marker = 0;
    if y_pic+settings.brush_size > 620
        y_upper = y_pic+settings.brush_size -620;
        if y_upper == 0
            error_marker = 1;
        end
    else
        y_upper = 0;
    end    
    if y_pic-settings.brush_size < 1
        y_lower = 1-(y_pic-settings.brush_size);
        if y_lower == 0
            error_marker = 1;
        end
    else
        y_lower = 0;
    end   
    if x_pic+settings.brush_size > 212
        x_upper = x_pic+settings.brush_size -212;
        if x_upper == 0
            error_marker = 1;
        end
    else
        x_upper = 0;
    end    
    if x_pic-settings.brush_size < 1
        x_lower = 1-(x_pic-settings.brush_size);
        if x_lower == 0
            error_marker = 1;
        end
    else
        x_lower = 0;
    end
    
    % show 'out of range' message if error occured
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
    
    % Get RGB values for selected part of the picture
    frame.R = DeactivationSilhouette(y_pic-settings.brush_size+y_lower:y_pic+settings.brush_size-y_upper,x_pic-settings.brush_size+x_lower:x_pic+settings.brush_size-x_upper,1);
    frame.G = DeactivationSilhouette(y_pic-settings.brush_size+y_lower:y_pic+settings.brush_size-y_upper,x_pic-settings.brush_size+x_lower:x_pic+settings.brush_size-x_upper,2);
    frame.B = DeactivationSilhouette(y_pic-settings.brush_size+y_lower:y_pic+settings.brush_size-y_upper,x_pic-settings.brush_size+x_lower:x_pic+settings.brush_size-x_upper,3);
    
    % Cut log_mask and brush depending on current border values
    i_log_mask = log_mask(1+y_upper:end-y_lower,1+x_lower:end-x_upper);
    i_brush = brush(1+y_upper:end-y_lower,1+x_lower:end-x_upper);
    
    % Get all RGB values from inside the circular mask
    frame.R_log = frame.R(i_log_mask);
    frame.G_log = frame.G(i_log_mask);
    frame.B_log = frame.B(i_log_mask);

    frame.RGB_log = [frame.R_log, frame.G_log, frame.B_log];
    frame.brush_log = i_brush(i_brush~=0); %gaussian color increase parameters for circular brush shape
    
    if button(1) == 1 %more deactivation (increasing color intensity), color pattern: white -> light green -> light blue -> dark blue
        for i = 1:length(frame.RGB_log) % run for each pixel
            i_RGB = frame.RGB_log(i,:);
            if i_RGB(1,2) == 255 & i_RGB(1,1) > 153
                frame.RGB_log(i,3) = i_RGB(3)-frame.brush_log(i)*3.4*settings.colorSpeed;
                frame.RGB_log(i,1) = i_RGB(1)-frame.brush_log(i)*3.4*settings.colorSpeed;
                if frame.RGB_log(i,1) < 153
                    frame.RGB_log(i,1) = 153;
                end
                if frame.RGB_log(i,3) < 153
                    frame.RGB_log(i,3) = 153;
                end
            elseif i_RGB(1,1:3) == 1
                continue
            elseif i_RGB(3) == 255 & i_RGB(1) <= 102
                frame.RGB_log(i,2) = i_RGB(2)-frame.brush_log(i)*3.4*settings.colorSpeed;
                frame.RGB_log(i,1) = i_RGB(1)-frame.brush_log(i)*1.7*settings.colorSpeed;
                if frame.RGB_log(i,2) < 153
                    frame.RGB_log(i,2) = 153;
                end  
                if frame.RGB_log(i,1) < 51
                    frame.RGB_log(i,1) = 51;
                end 
            elseif i_RGB(1) >= 102 & i_RGB(3) <= 255
                frame.RGB_log(i,3) = i_RGB(3)+frame.brush_log(i)*3.4*settings.colorSpeed;   
                frame.RGB_log(i,1) = i_RGB(1)-frame.brush_log(i)*1.7*settings.colorSpeed;                              
                if frame.RGB_log(i,1) < 102
                    frame.RGB_log(i,1) = 102;
                end   
            end
        end
        
        DeactivationCourse(ActionCount,:) = [x_pic, y_pic, 1]; %store action
        ActionCount = ActionCount+1; % add action

    elseif button(3) == 1 %less deactivation (decreasing color intensity), color pattern: dark blue -> light blue -> light green -> white
        for i = 1:length(frame.RGB_log) %run for each pixel
            i_RGB = frame.RGB_log(i,:);
            if i_RGB(1,2) == 255 & i_RGB(1,1) >= 153
                frame.RGB_log(i,3) = i_RGB(3)+frame.brush_log(i)*3.4*settings.colorSpeed;
                frame.RGB_log(i,1) = i_RGB(1)+frame.brush_log(i)*3.4*settings.colorSpeed;                
            elseif i_RGB(1,1:3) == 1
                continue
            elseif i_RGB(3) == 255 & i_RGB(1) < 102 | i_RGB(2) <255
                frame.RGB_log(i,2) = i_RGB(2)+frame.brush_log(i)*3.4*settings.colorSpeed;
                frame.RGB_log(i,1) = i_RGB(1)+frame.brush_log(i)*1.7*settings.colorSpeed;
                if frame.RGB_log(i,1) > 102
                    frame.RGB_log(i,1) = 102;
                end 
            elseif i_RGB(1) <=153 & i_RGB(3) <= 255
                frame.RGB_log(i,3) = i_RGB(3)-frame.brush_log(i)*3.4*settings.colorSpeed;   
                frame.RGB_log(i,1) = i_RGB(1)+frame.brush_log(i)*1.7*settings.colorSpeed;                              
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
    
    DeactivationSilhouette(y_pic-settings.brush_size+y_lower:y_pic+settings.brush_size-y_upper,x_pic-settings.brush_size+x_lower:x_pic+settings.brush_size-x_upper,1) = frame.R;
    DeactivationSilhouette(y_pic-settings.brush_size+y_lower:y_pic+settings.brush_size-y_upper,x_pic-settings.brush_size+x_lower:x_pic+settings.brush_size-x_upper,2)= frame.G;
    DeactivationSilhouette(y_pic-settings.brush_size+y_lower:y_pic+settings.brush_size-y_upper,x_pic-settings.brush_size+x_lower:x_pic+settings.brush_size-x_upper,3)= frame.B;
    
    % update texture
    texture.Deactivation = Screen('MakeTexture', scr, DeactivationSilhouette);

end

%% Close Screen
sca
ShowCursor()

%% Save results
save([pwd '\Data\silhouette_' subj.study_id '_' num2str(subj.id) '_S' num2str(subj.session)], 'ActivationSilhouette', 'DeactivationSilhouette', 'ActivationCourse', 'DeactivationCourse', 'subj','settings')
save([pwd '\Backup\silhouette_' subj.study_id '_' num2str(subj.id) '_S' num2str(subj.session)], 'ActivationSilhouette', 'DeactivationSilhouette', 'ActivationCourse', 'DeactivationCourse', 'subj','settings')
