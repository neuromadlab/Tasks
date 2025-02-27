% ================== Instrumental Motivation Task ========================
% Script needed for IMT_main.m
% Script adapted from TrainEAT! (author: Monja P. Neuser, Vanessa Teckentrup, Nils B. Kroemer)
%
% Input: fiber optic response grip force device
%
% Current adaptions for TUE008
% author: Corinna Schulz, 2022, Matlab R2021b using Psychtoolbox 3.0.16
% ========================================================================

%% Training Part I: Estimation
% outside of the scanner (requires visuals) but already with
% GFD. Here the min and max effort values are determined. 

%% Clear data vectors / initialize start values

% Load GFC settings .mat
load('./GripForceSpec.mat')

% Get operating system and set OS flags
system_info     = Screen('Computer');
windows         = system_info.windows;
mac             = system_info.osx;
linux           = system_info.linux;

% initialize grip force specific values
if windows

    initrestforce    = getfield(GripForceSpec, 'restforce'); %normal holding force
    initmaxforce     = getfield(GripForceSpec, 'maxpossibleforce'); %upper limit of GFD
    clckforce        = settings.clckforce; 

    hndl_found = 0;
    GripForceSpec.Handle = 0;
    while hndl_found == 0
        hndl_found = 1;
        try
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        catch
            GripForceSpec.Handle = GripForceSpec.Handle + 1;
            hndl_found = 0;
        end
    end
    gripforce_value = Joystick.Y;
end

% Other GFD variables
i_step_gr           = 1;  % Enummarate over loops
delta_pos_force     = initrestforce - initmaxforce;
ForceMat            = initrestforce;
effort_vector       = [];

% Other Visual drawing variables 
LowerBoundBar       = setup.ScrHeight - Tube.offset - Ball.width;
UpperBoundBar       = Tube.height + Ball.width;
BarBoundAbs         = LowerBoundBar - UpperBoundBar;
BarBound2Scale      = BarBoundAbs/delta_pos_force;
max_Boundary_yposition  = LowerBoundBar;

%% Prepare output structures to determine max effort across training
collectMax.maxEffort = nan(1,3);  %stores maxEffort of 3 practice trials
collectMax.values_per_trial = [];

% Prepare output struct to determin min force across training
collectMax.minEffort = nan(1,3);  %stores minEffort of 4 practice trials

%% Start Training Part I (estimation phase)
% basic instructions
Screen('TextSize',w,32);
Screen('TextFont',w,'Arial');
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.train_welcome_text, 'center', Text.height, color.black, 60);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.press_GFD, 'center', Text.height_cont, color.black, 50);
Screen('Flip',w);

WaitSecs(2)

while gripforce_value > clckforce
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    gripforce_value = Joystick.Y;
end

[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.train_effort, 'center', Text.height, color.black, 60);
[pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.press_GFD, 'center', Text.height_cont, color.black, 50);
Screen('Flip',w);

WaitSecs(2)


[Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    gripforce_value = Joystick.Y;

while gripforce_value > clckforce
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    gripforce_value = Joystick.Y;
end

for i_collectMax = 1:settings.calibration_trials
    %% instructions
    Screen('TextSize',w,32);
    Screen('TextFont',w,'Arial');

    if i_collectMax == 1
        % first round instructions: press as much as possible
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.first_round_train, 'center', Text.height, color.black, 60);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.press_GFD, 'center', Text.height_cont, color.black, 50);
        Screen('Flip',w);

    elseif i_collectMax == 2
        % second round instructions: press as little as possible
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.middle_round_train, 'center', Text.height, color.black, 60);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.press_GFD, 'center', Text.height_cont, color.black, 50);
        Screen('Flip',w);

    elseif i_collectMax == 3
        % last round instructions: press as much as possible again
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.last_round_train, 'center', Text.height, color.black, 60);
        [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, instr.press_GFD, 'center', Text.height_cont, color.black, 50);
        Screen('Flip',w);

    end 
    
    WaitSecs(2) %forces to rest on instruction for a bit, such that not accidently pressed GFD from previous trial 
    
    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    gripforce_value = Joystick.Y;

    while gripforce_value > clckforce
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
        gripforce_value = Joystick.Y;
    end
    
    Screen('Flip',w);

    
    %% Show fixation cross at the beginning of each trial
    fix = '+';
    Screen('TextSize',w,64);
    Screen('TextFont',w,'Arial');
    [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', color.black,80);
    timings.train.fix(i_collectMax) = Screen('Flip', w);

    WaitSecs(2); %Show screen for 1s

    %% Actual training trial start (recortstart time)
    t_collectMax_onset = GetSecs;
    t_buttonN_1        = t_collectMax_onset;

    % Loop during 10 sec duration (training trial length)
    while (timings.calibration_length   > (GetSecs - t_collectMax_onset)) 

        % Draw graphical display
        % Draw Tube
        Screen('DrawLine',effort_scr,color.black,Tube.XCor1 , Tube.height,  Tube.XCor1 , Tube.YBottom,6);
        Screen('DrawLine',effort_scr,color.black,Tube.XCor2 , Tube.height,  Tube.XCor2 , Tube.YBottom,6);
        Screen('DrawLine',effort_scr,color.black,Tube.XCor1 , Tube.YBottom, Tube.XCor2 , Tube.YBottom,6);
        Screen('CopyWindow',effort_scr,w);

        % Draw upper bound blue line
        if ForceMat < initrestforce
            Boundary_yposition = BarBound2Scale*ForceMat + UpperBoundBar - initmaxforce * BarBound2Scale;
        else
            Boundary_yposition = LowerBoundBar;
        end

        max_Boundary_yposition = min(max_Boundary_yposition, Boundary_yposition);
        Screen('DrawLine',w,color.darkblue,Tube.XCor1, max_Boundary_yposition, Tube.XCor2, max_Boundary_yposition,3);

        % Draw Ball
        Ball.position = [(setup.xCen-Ball.width/2) (Boundary_yposition) (setup.xCen+Ball.width/2) (Boundary_yposition + Ball.width)];
        Ball.color = color.darkblue;
        Screen('FillOval',w,Ball.color,Ball.position);
        Screen('Flip', w);

        [b,c] = KbQueueCheck;
        % Continuously log
        if windows
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
            gripforce_value = Joystick.Y;
        end
        % Getting values from Grip Force Device -> Joystick.Y
        ForceMat                = gripforce_value;

        % Saving force over time
        effort_vector           = [effort_vector, gripforce_value];

        % Store for timestamps and actual force every 100ms
        t_step                      = GetSecs;
        t_vector(1,i_step_gr)       = t_step;
        i_step_gr                   = i_step_gr + 1;

    end

    % End of trial
    count_joy = 1;

    %% Prepare Output
    t_ref_vector          = t_vector - t_collectMax_onset;


    % Copy Output Values into Output Matrix
    % Name of struct = collectMax; to disentangle from practice trials (!different array size)
    collectMax.values_per_trial = [collectMax.values_per_trial, ...
                                    [ones(1,length(effort_vector)) * subj.id; ... % Subj_ID
                                    (1:length(effort_vector)) ; ...               % time Effort vector
                                    t_ref_vector ; ...                            % time referenced trial start
                                    effort_vector ]];                             % Force over time
    % Store maxEffort for each training trial in a vector, take the minimum, because lower values indicate
    % higher forces, as well as minEffort for each training trial (highest
    % value)
    collectMax.maxEffort(1, i_collectMax) = min(effort_vector);                 % Max Effort value
    collectMax.maxEffort                  = collectMax.maxEffort(collectMax.maxEffort ~= 0); 
    collectMax.minEffort(1, i_collectMax) = max(effort_vector); 

    % Create & Save temporary output data
    collectMax.filename_temp = sprintf('%s\\Backup\\effort_%s_%s_s%s_temp', pwd, subj.study, subj.subjectID, subj.sessionID);
    save([collectMax.filename_temp '.mat'], 'collectMax', 'subj')

    %% Clear Variables to initiate new trial

    i_resp          = 1;
    t_vector        = [];
    effort_vector   = [];

    i_step_gr       = 1;
    ForceMat        = initrestforce;

    WaitSecs(3);

end

% Prepare Individual maxEffort as input for Trials
% effort_vals = collectMax.values_per_trial(4,:);

% For final Max Effort select strongest Force (min value) of all 3
% calibration trials 
input_device.maxEffort = min(collectMax.maxEffort);
input_device.minEffort = max(collectMax.minEffort);

% Flip to clear screen
Screen('Flip',w);

%% End of TRAINING save final 
% Create & Save temporary output data
collectMax.filename = sprintf('%s\\Data\\effort_%s_%s_s%s', pwd, subj.study, subj.subjectID, subj.sessionID);
save([collectMax.filename '.mat'], 'collectMax', 'input_device')
delete([collectMax.filename_temp '.mat']);
