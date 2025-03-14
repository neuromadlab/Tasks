%=========================================================================%
%=============== TUE010 Save all Data ====================================%
% Save Data from Local (Tablet) to NAS
%========================================================================%
clear
dir_gen = 'C:\Users\Forschung - Admin\'; %Set here basic path from laptop you are using for local data saving

% Paths on local laptop to task data
%EAT_dir_local  = [dir_gen,'Desktop\IRTG05\EAT\data'];
SM_dir_local  = [dir_gen,'Desktop\IRTG05\Data'];
%VASstate_dir_local  = [dir_gen,'OneDrive\Desktop\IRTG05\Data'];

% Paths on local laptop to task data of backup data (bu)
%EAT_dir_local_bu  = [dir_gen,'Desktop\TUE008\EAT\Backup'];
SM_dir_local_bu  = [dir_gen,'Desktop\IRTG05\Backup'];
%VASstate_dir_local_bu  = [dir_gen,'OneDrive\Desktop\IRTG05\Backup'];

% Console input: Ask ID of participant/session you want to save
subjectID=input('Subject ID: ','s');
sessionID=input('Session ID [1/2]: ','s');
tID=input('Runs [1/2]: ','s');
subjectID= pad(subjectID,6,'left','0');

% Paths in NAS you want to save data to
%FCR_dir_NAS = [dir_gen,'SynologyDrive\Tasks\FCR\Data\FCR_Images\TUE008'];
SM_dir_NAS = [dir_gen,'SynologyDrive\Tasks\Slot_Machine\Data\IRTG05'];
%EAT_dir_NAS = [dir_gen,'SynologyDrive\Tasks\Effort\Data\TUE010'];
%EAT_training_dir_NAS = [dir_gen,'SynologyDrive\Tasks\Effort\Data\TUE008\Training'];
%VASstate_dir_NAS = [dir_gen,'SynologyDrive\Tasks\VAS\Data\TUE010\VASstate'];
%Taste_dir_NAS = [dir_gen,'SynologyDrive\Tasks\Taste_Test\Data\Ratings\TUE008']; 

% Paths in NAS you want to save data to (Backup)
%FCR_dir_NAS_bu = [dir_gen,'SynologyDrive\Tasks\FCR\Data\FCR_Images\TUE008\Backup'];
SM_dir_NAS_bu = [dir_gen,'SynologyDrive\Tasks\Slot_Machine\Data\IRTG05\Backup'];
%EAT_dir_NAS_bu = [dir_gen,'SynologyDrive\Tasks\Effort\Data\TUE010\Backup'];
%VASstate_dir_NAS_bu = [dir_gen, 'SynologyDrive\Tasks\VAS\Data\TUE010\VASstate\Backup'];
%Taste_dir_NAS_bu = [dir_gen,'SynologyDrive\Tasks\Taste_Test\Data\Ratings\TUE008\Backup']; 


% Copy tasks
%% FCR
%disp('Copying FCR...')
%copyfile([FCR_dir_local filesep 'FCRbeh_TUE008_' subjectID '_S1.mat'],[FCR_dir_NAS filesep])
%copyfile([FCR_dir_local_bu filesep 'FCRbeh_TUE008_' subjectID '_*'],[FCR_dir_NAS_bu filesep])
%p('...Done')


%% Slot-Machine Task
disp('Copying SM...')
copyfile([SM_dir_local filesep 'SM_IRTG05_' subjectID '_S' sessionID '_R' tID '.mat'], SM_dir_NAS)
copyfile([SM_dir_local_bu filesep 'SM_IRTG05_' subjectID '_S' sessionID '_R' tID '*'], SM_dir_NAS_bu)
disp('...Done')


%% grEAT
%disp('Copying grEAT...')
%copyfile([EAT_dir_local filesep 'ExpEAT_TUE008_' subjectID '_S1_R1.mat'],[EAT_dir_NAS])
%copyfile([EAT_dir_local filesep 'TrainEAT_TUE008_' subjectID '_S1_R1.mat'],[EAT_training_dir_NAS])
%copyfile([EAT_dir_local_bu filesep 'ExpEAT_TUE008_' subjectID '_S1_R*'],[EAT_dir_NAS_bu])
%copyfile([EAT_dir_local_bu filesep 'TrainEAT_TUE008_' subjectID '_S1_R*'],[EAT_dir_NAS_bu])
%disp('...Done')

%% VAS state
%disp('Copying VAS state ...')
%copyfile([VASstate_dir_local filesep 'VASstate_IRTG05_' subjectID '_' sessionID '_R' tID '.mat'], [VASstate_dir_NAS])
%copyfile([VASstate_dir_local_bu filesep 'VASstate_IRTG05_' subjectID '_' sessionID '_R' tID '*'], [VASstate_dir_NAS_bu])
%disp('...Done')

%% Taste Test
%disp('Copying Taste Test...')
%copyfile([Taste_dir_local filesep 'TT_TUE008_' subjectID '_S1_R1.mat'],[Taste_dir_NAS])
%copyfile([Taste_dir_local_bu filesep 'TT_TUE008_' subjectID '_S1_R1*'],[Taste_dir_NAS_bu])
%disp('...Done')
