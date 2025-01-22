
do_gamepad = 1; %do not set to 0, this is not implemented yet
xbox_buffer = zeros(1,50); %will buffer the history of 50 button press status

    while ((GetSecs-t_resp_onset) < resp_latency)		% insert response latency
		
        [b,c] = KbQueueCheck;
      
        if do_gamepad == 1
            [Joystick.X, Joystick.Y, Joystick.Z, Joystick.Button] = WinJoystickMex(JoystickSpecification);
            for buffer_i = 2:50 %buffer_size
                xbox_buffer(buffer_i) = Joystick.Button(1);
                if xbox_buffer(buffer_i)==1 && xbox_buffer(buffer_i-1)==0
                    count_joystick = 1;
                    t_button = GetSecs;
                else
                    count_joystick = 0;
                end
                if buffer_i == 50
                    buffer_i = 2;
                    xbox_buffer(1)=xbox_buffer(50);
                end
        
        if c(keyResp) > 0 || count_joystick == 1
             resp=resp+1;
             if c(keyResp) > 0
                t_button = c(keyResp);
             end
             RT_resp(i,resp) = t_button-starttime;
             if resp == 1
                 t_first_resp = GetSecs - t_exp_on;
             end
        end
        
        
            end
        end
   end
  