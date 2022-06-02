function savedata(filename,table,data_dir)

% give the subfolder where data is saved a name
directory_name = 'Processed';
    
% directory separater for different OS
if isunix || ismac
    
    sep = '/';
    
elseif ispc
    
    sep = '\';
end

directory_name = [directory_name sep];

% create within data folder two subfolders:
% folder with date wihtin folder 'Processed'
cd(data_dir);
mkdir(directory_name);
files.save_directory = [data_dir directory_name];
cd(files.save_directory);
mkdir(datestr(now, 'yyyymmdd'));
files.save_directory = [files.save_directory datestr(now, 'yyyymmdd')];
cd(files.save_directory);

% create filename
full_filename = [files.save_directory sep filename];

writetable(table, [full_filename '_' datestr(now, 'yyyymmdd') '.csv']);
end