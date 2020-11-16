%% Call PANAS_VAS_mouse
%Coded by: Emily Corwin-Renner

%Importantly, the order of the items does not go from p01-10 and then
%n01-10. Instead, positive and negative items are presented in an
%intermixed pattern. 

%% ------------------------------------------------------------------------------------------------
PANAS_items = {'aktiv','active',...
               'bekuemmert','distressed',...
               'interessiert','interested',...
               'freudig erregt','excited',...
               'veraergert','upset',...
               'stark','strong',...
               'schuldig','guilty',...
               'erschrocken','scared',...
               'feindselig','hostile',...
               'angeregt','inspired',...
               'stolz','proud',...
               'gereizt','irritable',...
               'begeistert','enthusiastic',...
               'beschaemt','ashamed',...
               'wach','alert',...
               'nervoes','nervous',...
               'entschlossen','determined',...
               'aufmerksam','attentive',...
               'durcheinander','jittery',...
               'aengstlich','afraid',...
               'gluecklich','happy',...
               'ungluecklich','unhappy'};
           
if strcmp(settings.lang_de,'1')
    PANAS_items = PANAS_items(1:2:end);
elseif strcmp(settings.lang_de,'2')
    PANAS_items = PANAS_items(2:2:end);

end

%% --------------------------------------------------------------------------------------------------
%item p01 active
trial.question = PANAS_items{1}; 

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
trial.question = PANAS_items{2}; 


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
trial.question = PANAS_items{3}; 

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
trial.question = PANAS_items{4}; 

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
trial.question = PANAS_items{5}; 

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
trial.question = PANAS_items{6}; 

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
trial.question = PANAS_items{7}; 

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
trial.question = PANAS_items{8}; 

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
trial.question = PANAS_items{9}; 

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
trial.question = PANAS_items{10}; 

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
trial.question = PANAS_items{11}; 

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
trial.question = PANAS_items{12}; 

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
trial.question = PANAS_items{13}; 

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
trial.question = PANAS_items{14}; 

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
trial.question = PANAS_items{15}; 

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
trial.question = PANAS_items{16}; 

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
trial.question = PANAS_items{17}; 

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
trial.question = PANAS_items{18}; 

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
trial.question = PANAS_items{19}; 

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
trial.question = PANAS_items{20}; 

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
trial.question = PANAS_items{21}; 

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
trial.question = PANAS_items{22}; 

Effort_VAS

output.PANAS.archive.rating_unhappy(i_trial,1) = startTime; %Start time of rating
output.PANAS.archive.rating_unhappy(i_trial,2) = rating;
output.PANAS.archive.rating_unhappy(i_trial,3) = rating_subm;
output.PANAS.archive.rating_unhappy(i_trial,4) = t_rating_ref; %Time of rating submission

%Reset variables
rating = nan;
rating_subm = nan;


