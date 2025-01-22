screen_offset_y = 0.35; %relative offset; positive values move the screen towards to top, negative towards the bottom
scale_offset_y = 0.05;

do_scales = 1; %will run scale in prob_scales*100% of trials
    prob_scales = 1; %sets the probability to trigger rating scales after one trial
    feedback_delay = 0.5; %for scales
    preset = 1; %will skip separate initialization of scales
    max_dur_rating = 5; %after the specified seconds, the rating will terminate
    color_scale_background = [255 255 255]; %white
    color_scale_anchors = [0 0 0]; %black

    if do_gamepad == 1
        VAS_horz_gamepad

        if flag_resp == 0
            output.rating(i,1) = ((Slider_x_pos - (ww/2-Scale_width/2))/ Scale_width)*100; %rescaling of scale_width independent of screen resolution [0-100]
            output.rating_label{i,1} = text_freerating;
            output.rating_subm(i,1) = 0;
        end
    
    end