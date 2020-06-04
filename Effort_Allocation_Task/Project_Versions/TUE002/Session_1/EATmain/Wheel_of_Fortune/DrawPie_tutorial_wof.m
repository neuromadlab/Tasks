Screen('FillRect', wd, bgcol);

% Screen('DrawTexture',wd,curr_block_pie{trial},[],pie_pos);

%     pie_pic = imread(sprintf('pie_chart_%i.png',count));
%     pie{count} = Screen('MakeTexture',wd,pie_pic);
pie_pic = imread(fullfile(FolderCharts, sprintf('wof_pie_chart_%i.png', TempPieIndex)));
Screen('PutImage',wd,pie_pic,pie_pos);

%Texture_pie = Screen('MakeTexture', wd, pie_pic);
%Screen('DrawTexture',wd,Texture_pie,[],pie_pos);