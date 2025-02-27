%% instructions while subject is waiting for the trigger

if settings.lang_de == 1
    
    if strcmp(subj.study, 'TUE005')
        
        if settings.do_fmri == 0
        
        if (subj.run == 1 || subj.run == 2)
            
            instruct.text_p1 = ['In der folgenden Aufgabe sehen Sie in zufaelliger Abfolge Bilder mit Essen. ' ...
                         '\n\n Danach bitten wir Sie jeweils anzugeben, wie sehr Sie das dargestellte Essen ' ...
                         '\n\n als Belohnung in diesem Moment gern erhalten wuerden, bzw. wie sehr Sie das ' ...
                         '\n\n dargestellte Essen als Belohnung moegen. Wie sehr Sie das Objekt erhalten wollen, ' ...
                         '\n\n bzw. moegen wird mittels verschiedener Skalen abgefragt werden: Bitte nutzen Sie die ' ...
                         '\n\n horizontale Skala, um anzugeben, wie sehr Sie die Belohnung in diesem Moment erhalten ' ...
                         '\n\n moechten und die vertikale Skala, um anzugeben, wie sehr Sie die dargestellte Belohnung ' ...
                         '\n\n in diesem Moment moegen. Welche Skala jeweils nach einem Bild erscheint, wird zufaellig ' ...
                         '\n\n ausgewaehlt. ' ...
                         '\n\n Bevor Sie weiterklicken, wenden Sie Sich bitte noch kurz an die Versuchsleitung. '
                         ];
                     
                             
        instruct.text_p2 = ['Die Bilder koennen teilweise mehrfach gezeigt werden. ' ...
                             '\n\n' ...
                            '\n\nBitte verwenden Sie die Maus um den Regler auf der Skala zu bewegen ' ...
                            '\n\n und klicken Sie mit einer Maustaste zur Eingabe Ihrer Bewertung. ' ...
                            '\n\n Bitte nutzen Sie dafuer Ihre nicht-dominante Hand. '];
            
        else
            
            instruct.text_p1 = ['In der folgenden Aufgabe sehen Sie in zufaelliger Abfolge Bilder mit Bueromaterialien. ' ...
                         '\n\n Danach bitten wir Sie jeweils anzugeben, wie sehr Sie die dargestellten Materialien ' ...
                         '\n\n als Belohnung in diesem Moment gern erhalten wuerden, bzw. wie sehr Sie die ' ...
                         '\n\n dargestellten Materialien als Belohnung moegen. Wie sehr Sie das Objekt erhalten wollen, ' ...
                         '\n\n bzw. moegen wird mittels verschiedener Skalen abgefragt werden: Bitte nutzen Sie die ' ...
                         '\n\n horizontale Skala, um anzugeben, wie sehr Sie die Belohnung in diesem Moment erhalten ' ...
                         '\n\n moechten und die vertikale Skala, um anzugeben, wie sehr Sie die dargestellte Belohnung ' ...
                         '\n\n in diesem Moment moegen. Welche Skala jeweils nach einem Bild erscheint, wird zufaellig ' ...
                         '\n\n ausgewaehlt. ' ...
                         '\n\n ' ... 
                         '\n\n Klicken Sie bitte weiter. '];
                     
            instruct.text_p2 = ['Die Bilder koennen teilweise mehrfach gezeigt werden. ' ...
                             '\n\n' ...
                            '\n\nBitte verwenden Sie das Touchpad um den Regler auf der Skala zu bewegen ' ...
                            '\n\n und klicken Sie zur Eingabe Ihrer Bewertung. '];         
        
        
        end
        
        else 
            
            instruct.text_p1 = ['In der folgenden Aufgabe sehen Sie auf dem Bildschirm in Blocks '...
                '\n\n Bilder mit Essen oder Bueromaterialien.' ...
                '\n\nStellen Sie sich vor, die dargestellten Optionen sind verf�gbar,' ...
                '\n\n wie beispielsweise bei einem Buffet.' ...
                '\n\n Geben Sie in den darauffolgenden Gebots-Phasen an, wie viel Anstrengung' ...
                '\n\n Sie bereit w�ren auszugeben, um Zugang zu den Optionen zu bekommen.' ...
                '\n\n Die Dauer der Gebots-Phasen betr�gt ungef�hr 5 Sekunden '...
                '\n\n Versuchen Sie  den Ball auf der H�he zu halten, die Sie zu bieten beabsichtigen.'];                
            
            instruct.text_p2 = [];
            %instruct.text_p2 = ['Weiter mit Druck'];
            
            instruct.text_lottery1 = ['Die Lotterie hat ergeben, dass die oben angezeigten Optionen zu erspielen sind.'...
                                      '\n\n'...
                                      '\n\n Am Ende des heutigen Termins k�nnen Sie noch einmal einen Durchgang'...
                                      '\n\n spielen und Punkte gewinnen, die Sie im Anschluss f�r Belohnungen eintauschen k�nnen.'];
            
            instruct.text_lottery2 = ['Die Lotterie hat ergeben, dass die oben angezeigten Optionen zu erspielen sind.'...
                                      '\n\n'...
                                      'Leider reicht Ihr Gebot nicht aus. Sie k�nnen diesmal nichts gewinnen.'];
            
        end
        
        else
                   
        instruct.text_p1 = ['In der folgenden Aufgabe sehen Sie in zufaelliger Abfolge entweder Bilder mit Essen ' ...
                         '\n\n oder Bueromaterialien. Danach bitten wir Sie jeweils anzugeben, wie sehr Sie' ...
                         '\n\n das dargestellte Objekt als Belohnung in diesem Moment gern erhalten wuerden,' ...
                         '\n\n bzw. wie sehr Sie das dargestellte Objekt als Belohnung moegen.' ...
                         '\n\n Wie sehr Sie das Objekt erhalten wollen, bzw. moegen wird mittels verschiedener Skalen ' ...
                         '\n\n abgefragt werden: Bitte nutzen Sie die horizontale Skala, um anzugeben, wie sehr Sie ' ...
                         '\n\n die Belohnung in diesem Moment erhalten moechten und die vertikale Skala, um anzugeben, ' ...
                         '\n\n wie sehr Sie die dargestellte Belohnung in diesem Moment moegen.' ...
                         '\n\n Welche Skala jeweils nach einem Bild erscheint, wird zufaellig ausgewaehlt. '];
    
        instruct.text_p2 = [];
    end
    
else
    instruct.text_p1 = [];
%     ['Today, you will work for rewards like you practiced.' ...
%     '\n\n You will always see the reward tree. Sometimes, only the rewards'...
%     '\n\n appear at first. Other times, only your avatar will appear at first. ' ... 
%     '\n\n Start pressing only AFTER you can see both your avatar and the rewards.' ...
%     '\n\n The faster you press the button, the more likely it is you will get the' ...
%     '\n\n rewards shown. The number of coins or fruit indicates ' ...
%     '\n\n the amount of the reward. The distance of the avatar to the tree' ...
%     '\n\n indicates how much effort is needed to obtain the reward.' ...
%     '\n\n Today, you will not see your avatar move, only the outcome.' ...
%     '\n\n If you win, a red or brown circle means you will receive milkshake.' ...
%     '\n\n A yellow circle with a number inside means you have earned that many coins.' ...
%     '\n\n The water drop indicates a rinse is coming. Please swallow' ...
%     '\n\n only after you have received the rinse at the end of the trial.' ...
%     '\n\n An open circle will appear when you should swallow.'];

end 