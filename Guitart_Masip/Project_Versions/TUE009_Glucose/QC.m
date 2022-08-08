%%=================Guitart-Masip task quality control====================
close all;
clear; 
% Load output file
subj.study = input('Subject study: ','s');
subj.subjectID = input('Subject ID: ','s');
subj.subjectID = pad(subj.subjectID,6,'left','0');
subj.sessionID = input('Session [1/2/3/4]: ','s');
filename = ['GMT_', subj.study, '_', subj.subjectID, '_S', subj.sessionID, '.mat'];
backup_folder = [pwd, '\Data'];
cd(backup_folder)
load(filename);

% Check iterations
if length(output.cue_presented) == output.trials
    fprintf('Alle Iterationen sind abgeschlossen.\n');
else
    fprintf('Nur %d von %d Iterationen wurden abgeschlossen\n',length(output.cue_presented),output.trials);
end

% Check key presses
if sum(output.number_responses) == 0
    fprintf('Der Patient hat nicht einmal geklickt\n');
else
    fprintf('Der Patient hat %d mal geklickt\n', sum(output.number_responses));
end

% Recover payout
payout_money = sum(2 - output.feedback_cond.money) * 0.05;
payout_food = sum(2 - output.feedback_cond.food);
fprintf('Die Auszahlung beträgt: %.2f € and %d cookies\n', payout_money, payout_food);