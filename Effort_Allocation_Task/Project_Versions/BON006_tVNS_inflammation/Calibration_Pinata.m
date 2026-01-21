
%% After Calibration with GFD check Max Effort by Pinata game

% Idea: Try to test whether a higher max force can actually be reached.
% If not, try a lower max force.
%[w,wRect] = Screen('OpenWindow',setup.screenNum,color.white,[0 0 800 600]);

pinata.checks = [120, 110, 100, 90, 80, 70] ; % How much percent from max effort to go up/or below 
pinata.check_duration = 10; % Time per trial to reach pinata
pinata.flag = 0; % initialise pinata win flat to zero
pinata.trial_count = 0; % initialise pinata trial count to zero 
pinata.fix_cross = 1; 

gf_sr_counter = 1; % Logs each call to MexFile
debug = 0; 

if debug == 1
    restforceL = 20000;
    restforceR = 20000;
    restforce = 20000; 
gripforce_valueL = 20000; 
gripforce_valueR = 20000; 
gripforce_value = 20000; 

else 

    % determine the usable range of the force-input-device for each side
    forceRangeR = input_device.maxEffortR - input_device.minEffortR;
    % forceRangeL = input_device.maxEffortL - input_device.minEffortL;
    % set the restforce for each side as 5% above minimum per side
    restforceR = input_device.minEffortR + 0.05*forceRangeR;
    %restforceL = input_device.minEffortL + 0.05*forceRangeL;
    
    if (settings.do_fmri == 1) && (settings.debug == 0)
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
    else
        [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec);
    end
    %gripforce_valueL = Joystick.X;
    gripforce_valueR = Joystick.Y;
    %gripforce_value = max(Joystick.X, Joystick.Y);

end 
i_step_gr           = 1;  % Enummarate over loops
% delta_pos_force     = input_device.maxEffortR - input_device.minEffortR; % replaced by forceRangeL & forceRangeR
clckforce           = input_device.minEffortR + 0.85* ...
    abs(input_device.maxEffortR - input_device.minEffortR);
ForceMatR           = restforceR;
%ForceMatL           = restforceL;
%effort_vector       = [];
%effort_vectorL       = [];
effort_vectorR       = [];
LowerBoundBar       = setup.ScrHeight - Tube.offset; % height at which the bar starts
UpperBoundBar       = Tube.height + Ball.width; % highest allowed position of bar
BarBoundAbs         = LowerBoundBar - UpperBoundBar; % the usable Y-range of the tube for a bar, in pixel
%BarBound2Scale      = BarBoundAbs/delta_pos_force; % a scale-factor between range of tube and force
BarBound2ScaleR     = BarBoundAbs/forceRangeR; % scale-factor right
%BarBound2ScaleL     = BarBoundAbs/forceRangeL; % scale-factor left

%% Start Pinata winning 

while pinata.flag == 0
    %% Entire Pinata Calibration 
   Screen('Flip', w);

    for trial = 1:length(pinata.checks)

        %%
        % Trial Pinata 
        t_trial_onset = GetSecs;

        t_collectMax_onset = GetSecs;
        onset_start = 0;

        % Get current pinata threshold
        pinata.maxEffort = input_device.maxEffortR/100 * pinata.checks(trial) ; % Increase Max Effort by Pinata 

        % Get current Pinata Threshold position (always show the same!)
        input_device.percentEffort = input_device.minEffortR + forceRangeR * 1;

        % "Shown" pinata threshold
        Threshold.yposition        = LowerBoundBar - (input_device.percentEffort - input_device.minEffortR) * BarBound2ScaleR;  
        
        % "Actual" pinata threshold
        Threshold.yposition_pinata        = LowerBoundBar - (pinata.maxEffort - input_device.minEffortR) * BarBound2ScaleR;  

        % Drawing parameters for Reward details
        Coin.width                  = round(setup.ScrWidth * .15);
        % Location of reward incentive

        Coin.TopImg                 = Threshold.yposition - Coin.width  ;
        Coin.BottomImg              = Coin.TopImg + Coin.width ;

        Coin.RightImg           = setup.xCen + (Tube.width/2) - 20;
        Coin.LeftImg            =  Coin.RightImg-Coin.width;

        Coin.loc                    = [Coin.LeftImg Coin.TopImg Coin.RightImg Coin.BottomImg];

        % Draw Tube + Pinata + Threshold

        Screen('DrawTexture', w, stim.pinata,[], Coin.loc);

        % Draw Tube
        Screen('DrawLine',effort_scr,color.black,Tube.XCor1, Tube.height, Tube.XCor1, Tube.YBottom ,6);
        Screen('DrawLine',effort_scr,color.black,Tube.XCor2, Tube.height, Tube.XCor2, Tube.YBottom ,6);
        Screen('DrawLine',effort_scr,color.black,Tube.XCor1, Tube.YBottom, Tube.XCor2, Tube.YBottom,6);
        Screen('CopyWindow',effort_scr,w);

        % Pinata
         Screen('DrawTexture', w, stim.pinata,[], Coin.loc);
        %Screen('CopyWindow',effort_scr,w);

        % Threshold
        Screen('DrawLine',w,color.red,Tube.XCor1, Threshold.yposition, Tube.XCor2, Threshold.yposition,3);
        

        % Flip to clear
        Screen('Flip', w);

        %% Pinata trial
        while (pinata.check_duration  > (GetSecs - t_collectMax_onset)) && pinata.flag == 0

            % Draw Tube + Pinata + Threshold

        
            % Draw Tube
            Screen('DrawLine',effort_scr,color.black,Tube.XCor1, Tube.height, Tube.XCor1, Tube.YBottom ,6);
            Screen('DrawLine',effort_scr,color.black,Tube.XCor2, Tube.height, Tube.XCor2, Tube.YBottom ,6);
            Screen('DrawLine',effort_scr,color.black,Tube.XCor1, Tube.YBottom, Tube.XCor2, Tube.YBottom,6);

            % Pinata
            Screen('DrawTexture', effort_scr, stim.pinata,[], Coin.loc);
            Screen('CopyWindow',effort_scr,w);

            % Threshold
            Screen('DrawLine',effort_scr,color.red,Tube.XCor1, Threshold.yposition, Tube.XCor2, Threshold.yposition,3);
            Screen('CopyWindow',effort_scr,w);


            % Track Ball position and translate into payout
            Ball.DrawFactor = 0;
            % BarBound2ScaleR - scalefactor between range of tube and force
            % ForceMat - the last measured force (right)

            % First time ForceMax = restforce, then later ForceMat is
            % adjusted
            if (ForceMatR > restforceR)
                Ball_ypositionR = LowerBoundBar - BarBound2ScaleR * (ForceMatR - restforceR);
                %Ball_ypositionL = LowerBoundBar - BarBound2ScaleL * (ForceMatL - restforceL);
                % the minimum is a "higher" position on screen
                Ball_yposition = Ball_ypositionR; % take value of right grip force device always for trials
            else
                Ball_yposition = Tube.YBottom;
            end

            Ball.position       = [(setup.xCen-Ball.width/2) (Ball_yposition - Ball.width - Ball.DrawFactor)...
                (setup.xCen+Ball.width/2) (Ball_yposition - Ball.DrawFactor)];

            % Ball above threshold
            % -> change color, WIN PINATA
            if  Ball_yposition < Threshold.yposition_pinata
                
                % Ball.color = color.royalblue;
                Screen('Flip', w, []);

                % Draw Text
                text = 'Pinata won!';
                
                [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text, 'center', 'center', [0 0 0],150);
                
                Screen('Flip', w, []);
                WaitSecs(3)
                pinata.flag  = 1;
                
            else
                Ball.color = color.darkblue;
            end

            Screen('FillOval',w,Ball.color,Ball.position);
            [time.img, starttime] = Screen('Flip', w);

        
        
            %% Track Ball position
            [b,c] = KbQueueCheck;
             % 
             % gripforce_valueL = gripforce_valueL + 50;
             %    gripforce_valueR = gripforce_valueR + 50 ;
             %     gripforce_value = gripforce_value + 50;
             % 
             % 

            if windows
                if settings.do_fmri == 1 && settings.debug == 0
                    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec.Handle);
                else
                    [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(GripForceSpec);
                end
                %gripforce_valueL = Joystick.X;
                gripforce_valueR = Joystick.Y;
                %gripforce_value = max(Joystick.X, Joystick.Y);

            elseif linux
                axisState       = Gamepad('GetAxis', grip_force_idx, grip_force_axis);
                gripforce_value = axisState;
            end

            % Get timestamps of MexFile call to get accurate sampling rate
            if settings.do_fmri == 1
                pinata.grip_force_sampling_rate(trial,gf_sr_counter) = GetSecs;
                gf_sr_counter                                              = gf_sr_counter + 1;
            end

            % Getting values from Grip Force Device -> maximum of Joystick.X or Joystick.Y
            % Here Update of Ball position is prepared 
            ForceMatR       = gripforce_valueR;
            %ForceMatL       = gripforce_valueL;
            %effort_vector           = [effort_vector, gripforce_value];
            %effort_vectorL          = [effort_vectorL, gripforce_valueL];
            effort_vectorR          = [effort_vectorR, gripforce_valueR];
            % Store for timestamps and actual frequency every 100ms
            t_step                   = GetSecs;
            t_vector(1,i_step_gr)    = t_step - t_trial_onset;
            i_step_gr                = i_step_gr + 1;



        end
        %% Fixation cross after pinata trial 
        if pinata.fix_cross > 0
            fix = '+';
            Screen('TextSize',w,64);
            Screen('TextFont',w,'Arial');
            [pos.text.x,pos.text.y,pos.text.bbox] = DrawFormattedText(w, fix, 'center', 'center', color.black,80);
            [time.fix, starttime]                 = Screen('Flip', w);

            WaitSecs(pinata.fix_cross);
            stim.pinata                 = Screen('MakeTexture', w, img.pinata);
            effort_scr      = Screen('OpenOffscreenwindow',w,color.white);

        end

        
          
        if pinata.flag  == 1
    

            pinata.won.trial = trial; % Save trial that pinata was won 
            pinata.won.percentage = pinata.checks(trial); % save pinata threshold
            input_device.maxEffort_beforePinata = input_device.maxEffortR; % save original Max Effort
            if pinata.won.percentage == 80
                input_device.maxEffortR = (input_device.maxEffort_beforePinata/100) * 90;
            elseif pinata.won.percentage == 70
                 input_device.maxEffortR = (input_device.maxEffort_beforePinata/100) * 80;
            else
            input_device.maxEffortR = pinata.maxEffort; % Adjust Max Force with Pinata threshold
            end
            
            break; 
        end 

        if debug == 1
            restforceL = 20000;
            restforceR = 20000;
            restforce = 20000;
            gripforce_valueL = 20000;
            gripforce_valueR = 20000;
            gripforce_value = 20000;

        
        end 

    end 
    %%
    % If Pinata wasnt won after all trials 
    if trial == length(pinata.checks) && pinata.flag == 0

        Screen('Flip', w, []);

        
        % Draw Text
        text = 'Experimenter: Technical issue, restarting.';

        [pos.x,pos.y,pos.bbox] = DrawFormattedText(w, text, 'center', 'center', [0 0 0],150);

        Screen('Flip', w, []);
        GetClicks(setup.screenNum);
        ShowCursor;

        WaitSecs(3)
        pinata.flag  = 1;

    end
end 

% Create & Save temporary output data
collectPinata.filename = sprintf('%s\\data\\pinata_%s_%s_S%s_R%s', pwd, subj.study, subj.subjectID, subj.sessionID, subj.runID);

save(fullfile([collectPinata.filename '.mat']), 'pinata');









 
















