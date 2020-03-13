%% Call PANAS_VAS_mouse

%item p01 active
trial.question  = 'aktiv'; 

Effort_VAS

output.PANAS.rating_active_runstart(1,i_trial)  = startTime; %Start time of rating
output.PANAS.rating_active(1,i_trial)           = rating;
output.PANAS.rating_active_label{1,i_trial}     = rating_label;
output.PANAS.rating_active_subm(1,i_trial)      = rating_subm;
output.PANAS.rating_active_t_button(i_trial,5)  = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;

%item p02 interested
trial.question  = 'interessiert'; 

Effort_VAS

output.PANAS.rating_interested_runstart(1,i_trial)  = startTime; %Start time of rating
output.PANAS.rating_interested(1,i_trial)           = rating;
output.PANAS.rating_interested_label{1,i_trial}     = rating_label;
output.PANAS.rating_interested_subm(1,i_trial)      = rating_subm;
output.PANAS.rating_interested_t_button(i_trial,5)  = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;

%item p03 excited
trial.question = 'freudig erregt'; 

Effort_VAS

output.PANAS.rating_excited_runstart(1,i_trial)     = startTime; %Start time of rating
output.PANAS.rating_excited(1,i_trial)              = rating;
output.PANAS.rating_excited_label{1,i_trial}        = rating_label;
output.PANAS.rating_excited_subm(1,i_trial)         = rating_subm;
output.PANAS.rating_excited_t_button(i_trial,5)     = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_label = nan;
rating_subm = nan;

%item p04 strong
trial.question = 'stark'; 

Effort_VAS

output.PANAS.rating_strong_runstart(1,i_trial)  = startTime; %Start time of rating
output.PANAS.rating_strong(1,i_trial)           = rating;
output.PANAS.rating_strong_label{1,i_trial}     = rating_label;
output.PANAS.rating_strong_subm(1,i_trial)      = rating_subm;
output.PANAS.rating_strong_t_button(i_trial,5)  = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;

%item p05 inspired
trial.question = 'angeregt'; 

Effort_VAS

output.PANAS.rating_inspired_runstart(1,i_trial)    = startTime; %Start time of rating
output.PANAS.rating_inspired(1,i_trial)             = rating;
output.PANAS.rating_inspired_label{1,i_trial}       = rating_label;
output.PANAS.rating_inspired_subm(1,i_trial)        = rating_subm;
output.PANAS.rating_inspired_t_button(i_trial,5)    = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;

%item p06 proud
trial.question = 'stolz'; 

Effort_VAS

output.PANAS.rating_proud_runstart(1,i_trial)   = startTime; %Start time of rating
output.PANAS.rating_proud(1,i_trial)            = rating;
output.PANAS.rating_proud_label{1,i_trial}      = rating_label;
output.PANAS.rating_proud_subm(1,i_trial)       = rating_subm;
output.PANAS.rating_proud_t_button(i_trial,5)   = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;

%item p07 enthusiastic
trial.question = 'begeistert'; 

Effort_VAS

output.PANAS.rating_enthusiastic_runstart(1,i_trial)    = startTime; %Start time of rating
output.PANAS.rating_enthusiastic(1,i_trial)             = rating;
output.PANAS.rating_enthusiastic_label{1,i_trial}       = rating_label;
output.PANAS.rating_enthusiastic_subm(1,i_trial)        = rating_subm;
output.PANAS.rating_enthusiastic_t_button(i_trial,5)    = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;

%item p08 alert
trial.question = 'wach'; 

Effort_VAS

output.PANAS.rating_alert_runstart(1,i_trial)   = startTime; %Start time of rating
output.PANAS.rating_alert(1,i_trial)            = rating;
output.PANAS.rating_alert_label{1,i_trial}      = rating_label;
output.PANAS.rating_alert_subm(1,i_trial)       = rating_subm;
output.PANAS.rating_alert_t_button(i_trial,5)   = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;

%item p09 determined
trial.question = 'entschlossen'; 

Effort_VAS

output.PANAS.rating_determined_runstart(1,i_trial)  = startTime; %Start time of rating
output.PANAS.rating_determined(1,i_trial)           = rating;
output.PANAS.rating_determined_label{1,i_trial}     = rating_label;
output.PANAS.rating_determined_subm(1,i_trial)      = rating_subm;
output.PANAS.rating_determined_t_button(i_trial,5)  = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;

%item p10 attentive
trial.question = 'aufmerksam'; 

Effort_VAS

output.PANAS.rating_attentive_runstart(1,i_trial)   = startTime; %Start time of rating
output.PANAS.rating_attentive(1,i_trial)            = rating;
output.PANAS.rating_attentive_label{1,i_trial}      = rating_label;
output.PANAS.rating_attentive_subm(1,i_trial)       = rating_subm;
output.PANAS.rating_attentive_t_button(i_trial,5)   = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;

%item n01 distressed
trial.question = 'bekuemmert'; 

Effort_VAS

output.PANAS.rating_distressed_runstart(1,i_trial)  = startTime; %Start time of rating
output.PANAS.rating_distressed(1,i_trial)           = rating;
output.PANAS.rating_distressed_label{1,i_trial}     = rating_label;
output.PANAS.rating_distressed_subm(1,i_trial)      = rating_subm;
output.PANAS.rating_distressed_t_button(i_trial,5)  = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;

%item n02 upset
trial.question = 'veraergert'; 

Effort_VAS

output.PANAS.rating_upset_runstart(1,i_trial)   = startTime; %Start time of rating
output.PANAS.rating_upset(1,i_trial)            = rating;
output.PANAS.rating_upset_label{1,i_trial}      = rating_label;
output.PANAS.rating_upset_subm(1,i_trial)       = rating_subm;
output.PANAS.rating_upset_t_button(i_trial,5)   = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;

%item n03 guilty
trial.question = 'schuldig'; 

Effort_VAS

output.PANAS.rating_guilty_runstart(1,i_trial)  = startTime; %Start time of rating
output.PANAS.rating_guilty(1,i_trial)           = rating;
output.PANAS.rating_guilty_label{1,i_trial}     = rating_label;
output.PANAS.rating_guilty_subm(1,i_trial)      = rating_subm;
output.PANAS.rating_guilty_t_button(i_trial,5)  = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;

%item n04 scared
trial.question = 'erschrocken'; 

Effort_VAS

output.PANAS.rating_scared_runstart(1,i_trial)  = startTime; %Start time of rating
output.PANAS.rating_scared(1,i_trial)           = rating;
output.PANAS.rating_scared_label{1,i_trial}     = rating_label;
output.PANAS.rating_scared_subm(1,i_trial)      = rating_subm;
output.PANAS.rating_scared_t_button(i_trial,5)  = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;

%item n05 hostile
trial.question = 'feindselig'; 

Effort_VAS

output.PANAS.rating_hostile_runstart(1,i_trial)     = startTime; %Start time of rating
output.PANAS.rating_hostile(1,i_trial)              = rating;
output.PANAS.rating_hostile_label{1,i_trial}        = rating_label;
output.PANAS.rating_hostile_subm(1,i_trial)         = rating_subm;
output.PANAS.rating_hostile_t_button(i_trial,5)     = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;

%item n06 irritible
trial.question = 'gereizt'; 

Effort_VAS

output.PANAS.rating_irritible_runstart(1,i_trial)   = startTime; %Start time of rating
output.PANAS.rating_irritible(1,i_trial)            = rating;
output.PANAS.rating_irritible_label{1,i_trial}      = rating_label;
output.PANAS.rating_irritible_subm(1,i_trial)       = rating_subm;
output.PANAS.rating_irritible_t_button(i_trial,5)   = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;


%item n07 ashamed
trial.question = 'beschaemt'; 

Effort_VAS

output.PANAS.rating_ashamed_runstart(1,i_trial)     = startTime; %Start time of rating
output.PANAS.rating_ashamed(1,i_trial)              = rating;
output.PANAS.rating_ashamed_label{1,i_trial}        = rating_label;
output.PANAS.rating_ashamed_subm(1,i_trial)         = rating_subm;
output.PANAS.rating_ashamed_t_button(i_trial,5)     = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;



%item n08 nervous
trial.question = 'nervoes'; 

Effort_VAS

output.PANAS.rating_nervous_runstart(1,i_trial)     = startTime; %Start time of rating
output.PANAS.rating_nervous(1,i_trial)              = rating;
output.PANAS.rating_nervous_label{1,i_trial}        = rating_label;
output.PANAS.rating_nervous_subm(1,i_trial)         = rating_subm;
output.PANAS.rating_nervous_t_button(i_trial,5)     = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;


%item n09 jittery
trial.question = 'durcheinander'; 

Effort_VAS

output.PANAS.rating_jittery_runstart(1,i_trial) = startTime; %Start time of rating
output.PANAS.rating_jittery(1,i_trial)          = rating;
output.PANAS.rating_jittery_label{1,i_trial}    = rating_label;
output.PANAS.rating_jittery_subm(1,i_trial)     = rating_subm;
output.PANAS.rating_jittery_t_button(i_trial,5) = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;



%item n10 afraid
trial.question = 'aengstlich'; 

Effort_VAS

output.PANAS.rating_afraid_runstart(1,i_trial)  = startTime; %Start time of rating
output.PANAS.rating_afraid(1,i_trial)           = rating;
output.PANAS.rating_afraid_label{1,i_trial}     = rating_label;
output.PANAS.rating_afraid_subm(1,i_trial)      = rating_subm;
output.PANAS.rating_afraid_t_button(i_trial,5)  = t_rating_ref; %Time of rating submission

%Reset variables
rating          = nan;
rating_label    = nan;
rating_subm     = nan;
