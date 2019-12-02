colors = zeros(63,3);

colors(1,1) = 9; % changing the value of each cell


save('MyColors.mat','colors');


colors(1,1) = 12;

save('MyColors.mat','colors');


% figuring out the number of spaces to get back to the top

step_size_theta = 0.05;

radius = 360;
theta = 0;

[x_pos,y_pos] = pol2cart(theta+pi/2,radius);

y_pos_array = zeros(700,1);

for i=1:700
    [x_pos,y_pos] = pol2cart(theta+pi/2,radius);
    theta = theta + stepsizetheta;
    y_pos_array(i) = y_pos;
end

