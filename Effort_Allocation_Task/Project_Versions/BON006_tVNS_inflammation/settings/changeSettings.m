% 26.07.2024
clear
clc

% this loop shortens the text of variable instr.vas_nr1 and puts the
% remaining text into the new variable instr.vas_nr2.
for i = 1:6
    file = ['EAT_Settings_BON006_S' num2str(i) '.mat'];
load(file)

instr.vas_nr1 = 'Nach jedem Durchgang werden Ihnen nacheinander zwei Fragen angezeigt:\n\n"Wie stark haben Sie sich in diesem Durchgang verausgabt?" \n "Wie sehr wollten Sie die Belohnung in diesem Durchgang erhalten?"';
instr.vas_nr2 = ['Sie koennen zum Antworten den Regler auf einer Skala (ueberhaupt nicht - sehr) verschieben.  Nutzen Sie dazu bitte den linken Joystick auf dem Controller. Ihre Antwort müssen Sie dann mit der gruenen A-Taste auf dem Controller bestaetigen. ' ...
    'Bitte beachten Sie, dass Sie fuer die Antworten nur eine begrenzte Zeit zur Verfuegung haben.  Ueberlegen Sie deshalb nicht zu lange, sondern antworten Sie spontan.  Es gibt dabei kein "Richtig" oder "Falsch".'];

instr_en.vas_nr1 = 'After each trial, you will be asked two questions:\n\n"How much did you exert yourself in this trial?" \n " How much did you want the reward shown in this trial?"';
instr_en.vas_nr2 = ['You can respond by pushing a point on a scale from left (not at all) to right (a lot). The point on the scale can be moved with the left joystick on the controller. You must then confirm your response by pressing the green A button on ' ...
    'the controller.\nPlease be aware that you have a limited amount of time to respond to the questions. Do not think about the answers for too long, but instead answer spontaneously. There is no "right" or "wrong" answer'];

save(file)
end