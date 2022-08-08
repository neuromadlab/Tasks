%Screen('FillRect', w, color.light_grey);

%pie_pic = imread(fullfile(FolderCharts, sprintf('wof_pie_chart_%i.png', TempPieIndex)));
pie_pic = imread('wof_pie_chart.png');

Texture_pie = Screen('MakeTexture', w, pie_pic);
Screen('DrawTexture',w,Texture_pie,[],pie_pos);

