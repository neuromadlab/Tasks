winloss2spin_end_pos = zeros(16,2);
opts = [-8:-1,1:8]';
save('Spinner','winloss2spin_end_pos');
winloss2spin_end_pos(:,1) = opts;
%127 is num of positions for 360°
% 127x2 = 254
%127/16 = 7.9375
 save('Spinner.mat', 'winloss2spin_end_pos')