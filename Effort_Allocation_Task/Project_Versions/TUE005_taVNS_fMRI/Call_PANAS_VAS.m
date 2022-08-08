%% Call PANAS_VAS_mouse
%Coded by: Emily Corwin-Renner

%Importantly, the order of the items does not go from p01-10 and then
%n01-10. Instead, positive and negative items are presented in an
%intermixed pattern. 
%--------------------------------------------------------------------------------------------------
%item p01 active
trial.question = 'activ'; 

Effort_VAS

output.PANAS.archive.rating_active(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_active(i_trial,2) = rating;
output.PANAS.archive.rating_active(i_trial,3) = rating_subm;
output.PANAS.archive.rating_active(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item n01 distressed
trial.question = 'bekuemmert'; 

Effort_VAS

output.PANAS.archive.rating_distressed(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_distressed(i_trial,2) = rating;
output.PANAS.archive.rating_distressed(i_trial,3) = rating_subm;
output.PANAS.archive.rating_distressed(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;


%--------------------------------------------------------------------------------------------------
%item p02 interested
trial.question = 'interessiert'; 

Effort_VAS

output.PANAS.archive.rating_interested(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_interested(i_trial,2) = rating;
output.PANAS.archive.rating_interested(i_trial,3) = rating_subm;
output.PANAS.archive.rating_interested(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item p03 excited
trial.question = 'freudig erregt'; 

Effort_VAS

output.PANAS.archive.rating_excited(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_excited(i_trial,2) = rating;
output.PANAS.archive.rating_excited(i_trial,3) = rating_subm;
output.PANAS.archive.rating_excited(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item n02 upset
trial.question = 'veraergert'; 

Effort_VAS

output.PANAS.archive.rating_upset(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_upset(i_trial,2) = rating;
output.PANAS.archive.rating_upset(i_trial,3) = rating_subm;
output.PANAS.archive.rating_upset(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item p04 strong
trial.question = 'stark'; 

Effort_VAS

output.PANAS.archive.rating_strong(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_strong(i_trial,2) = rating;
output.PANAS.archive.rating_strong(i_trial,3) = rating_subm;
output.PANAS.archive.rating_strong(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item n03 guilty
trial.question = 'schuldig'; 

Effort_VAS

output.PANAS.archive.rating_guilty(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_guilty(i_trial,2) = rating;
output.PANAS.archive.rating_guilty(i_trial,3) = rating_subm;
output.PANAS.archive.rating_guilty(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item n04 scared
trial.question = 'erschrocken'; 

Effort_VAS

output.PANAS.archive.rating_scared(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_scared(i_trial,2) = rating;
output.PANAS.archive.rating_scared(i_trial,3) = rating_subm;
output.PANAS.archive.rating_scared(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item n05 hostile
trial.question = 'feindselig'; 

Effort_VAS

output.PANAS.archive.rating_hostile(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_hostile(i_trial,2) = rating;
output.PANAS.archive.rating_hostile(i_trial,3) = rating_subm;
output.PANAS.archive.rating_hostile(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;


%--------------------------------------------------------------------------------------------------
%item p05 inspired
trial.question = 'angeregt'; 

Effort_VAS

output.PANAS.archive.rating_inspired(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_inspired(i_trial,2) = rating;
output.PANAS.archive.rating_inspired(i_trial,3) = rating_subm;
output.PANAS.archive.rating_inspired(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item p06 proud
trial.question = 'stolz'; 

Effort_VAS

output.PANAS.archive.rating_proud(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_proud(i_trial,2) = rating;
output.PANAS.archive.rating_proud(i_trial,3) = rating_subm;
output.PANAS.archive.rating_proud(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item n06 irritible
trial.question = 'gereizt'; 

Effort_VAS

output.PANAS.archive.rating_irritible(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_irritible(i_trial,2) = rating;
output.PANAS.archive.rating_irritible(i_trial,3) = rating_subm;
output.PANAS.archive.rating_irritible(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item p07 enthusiastic
trial.question = 'begeistert'; 

Effort_VAS

output.PANAS.archive.rating_enthusiastic(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_enthusiastic(i_trial,2) = rating;
output.PANAS.archive.rating_enthusiastic(i_trial,3) = rating_subm;
output.PANAS.archive.rating_enthusiastic(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item n07 ashamed
trial.question = 'beschaemt'; 

Effort_VAS

output.PANAS.archive.rating_ashamed(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_ashamed(i_trial,2) = rating;
output.PANAS.archive.rating_ashamed(i_trial,3) = rating_subm;
output.PANAS.archive.rating_ashamed(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item p08 alert
trial.question = 'wach'; 

Effort_VAS

output.PANAS.archive.rating_alert(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_alert(i_trial,2) = rating;
output.PANAS.archive.rating_alert(i_trial,3) = rating_subm;
output.PANAS.archive.rating_alert(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item n08 nervous
trial.question = 'nervoes'; 

Effort_VAS

output.PANAS.archive.rating_nervous(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_nervous(i_trial,2) = rating;
output.PANAS.archive.rating_nervous(i_trial,3) = rating_subm;
output.PANAS.archive.rating_nervous(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item p09 determined
trial.question = 'entschlossen'; 

Effort_VAS

output.PANAS.archive.rating_determined(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_determined(i_trial,2) = rating;
output.PANAS.archive.rating_determined(i_trial,3) = rating_subm;
output.PANAS.archive.rating_determined(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item p10 attentive
trial.question = 'aufmerksam'; 

Effort_VAS

output.PANAS.archive.rating_attentive(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_attentive(i_trial,2) = rating;
output.PANAS.archive.rating_attentive(i_trial,3) = rating_subm;
output.PANAS.archive.rating_attentive(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item n09 jittery
trial.question = 'durcheinander'; 

Effort_VAS

output.PANAS.archive.rating_jittery(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_jittery(i_trial,2) = rating;
output.PANAS.archive.rating_jittery(i_trial,3) = rating_subm;
output.PANAS.archive.rating_jittery(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
%item n10 afraid
trial.question = 'aengstlich'; 

Effort_VAS

output.PANAS.archive.rating_afraid(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_afraid(i_trial,2) = rating;
output.PANAS.archive.rating_afraid(i_trial,3) = rating_subm;
output.PANAS.archive.rating_afraid(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;

%--------------------------------------------------------------------------------------------------
% extra item happy
trial.question = 'gluecklich'; 

Effort_VAS

output.PANAS.archive.rating_happy(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_happy(i_trial,2) = rating;
output.PANAS.archive.rating_happy(i_trial,3) = rating_subm;
output.PANAS.archive.rating_happy(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;


%--------------------------------------------------------------------------------------------------
% extra item unhappy
trial.question = 'ungluecklich'; 

Effort_VAS

output.PANAS.archive.rating_unhappy(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_unhappy(i_trial,2) = rating;
output.PANAS.archive.rating_unhappy(i_trial,3) = rating_subm;
output.PANAS.archive.rating_unhappy(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;


