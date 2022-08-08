%%cd
('N:\SeSyN\Paradigms\024\Code, Deconstructing Risk, MRI Compatible, 3');
cd('C:\Users\PC\Documents\MATLAB\Wheel_of_fortune\');
load Wheel_of_Fortune_matr_sel.mat

addpath('charts')
load('MyColors','colors');
addpath('export_fig')


wof_data_sel(:,1) = []; % elminate first column that counts pies
%wof_data_sel(:,15:17) = []; % eliminate last three columns that give mean, variance and skewness

first_line = wof_data_sel(1,1:16);

wof_data_sel(1,:) = []; % eliminate first row that gives amounts

for count = 1:size(wof_data_sel,1) %should now be from 1 to 60
    curr_line = wof_data_sel(count,1:size(wof_data_sel,2));
    
    amounts = first_line(curr_line~=0);
    amount_cell = cell(1,length(amounts));
    for i = 1:length(amounts)
        amount_cell{i} = num2str(amounts(i));
    end
    
    %draw pie
    %%cd('N:\SeSyN\Paradigms\024\Code, Deconstructing Risk, MRI Compatible, 3\charts');
    cd('C:\Users\PC\Documents\MATLAB\Wheel_of_fortune\charts');
    mypie(curr_line(curr_line~=0), amount_cell);
    %colormap(summer)
    colormap(colors)
    %set(gca, 'Color', 'w')
    %set(gca, 'Color', 'cm')
    set(gcf,'color',[204/255 204/255 204/255]);
    export_fig(sprintf('wof_pie_chart_%i.png',count),'-m3');
    
end
    

 