%=========================================================================%
%=============== TUE009 Save all Data ====================================%
% Save Data from Local (Tablet VAS fMRI sessions only) to NAS
%========================================================================%
clear
dir_gen = 'C:/Users/norag/'; %Set here basic path from laptop you are using for local data saving

% Paths on local laptop to task data
VASstate_dir_local  = [dir_gen,'OneDrive\Desktop\IRTG05\Data'];

VASstate_dir_local_bu  = [dir_gen,'OneDrive\Desktop\IRTG05\Backup'];

% Console input: Ask ID of participant/session you want to save
subjectID=input('Subject ID: ','s');
sessionID=input('Session ID [C1/C2/S1/S2]: ','s');
tID=input('Run ID [1/2/3]: ','s')
subjectID= pad(subjectID,6,'left','0');

% Paths in NAS you want to save data to
VASstate_dir_NAS = [dir_gen,'SynologyDrive\Tasks\VAS\Data\IRTG05\VASstate'];


VASstate_dir_NAS_bu = [dir_gen,'SynologyDrive\Tasks\VAS\Data\IRTG05\VASstate\Backup'];


% Copy tasks


%% VAS state
disp('Copying VAS state ...')
if str2double(sessionID) < 6
    runs = 2;
else 
    runs = 3;
end

for t = 1:runs
copyfile([VASstate_dir_local filesep 'VASstate_IRTG05_' subjectID '_' sessionID '_R' tID '.mat'],[VASstate_dir_NAS])
copyfile([VASstate_dir_local_bu filesep 'VASstate_IRTG05_' subjectID '_' sessionID '_R' tID '*'],[VASstate_dir_NAS_bu])
end
disp('...Done')


