
# Food Cue reactivity

## Setting up the Experiment

(1)	Determine the task settings for each session 
Before you start a new experiment, a few things need to be adjusted to accommodate the needs of your experiment. Use the “Create_SettingsStruc.m” file to create for each session the settings that will be loaded later during the experiment. 

(2)	Randomize your experiment 
Use the “FCR_randomization.m” to create the randomizations for the stimulus presentation, the scale presentation and condition order for all sessions. Further, the jitter (time delays) which are used between stimuli presentations are created. 

(3)	Adapting FCR_main.m 
FCR_main is the script running the experiment. You need to adapt some general settings according to your study (e.g. study name, possible sessions, path to your jitter file,...). 

## Output description
The most important variable from the FCR_all script is output. This variable is also saved at the end of script execution as  
- “FCRbeh_[Study_identifier]_[subject ID]_S[Session ID]_R[Run ID].mat” 
e.g. FCRbeh_TUE007_000001_S1_R1.mat for Subject 1, Session 1, Run 1, TUE007 Study 

The field output.data is saved at the end of every session (i.e. every code run). In each session FCR stimuli are presented at least twice (once for LIKING, once for WANTING scale assessment). The order of the presented stimuli as well as Liking and Wanting is randomized. 

The first 1-5 columns are determined from the set-up/the randomization of the experiment. 
Colum 6-9 contain data collected during the FCR. 

### 1.	Row_index 
Index of presented stimuli: Number of trials (e.g. 80) times the Runs (e.g. 2 for Liking and Wanting). 

### 2.	Repetition 
Index of runs that are shown in the current session. Total number of runs is determined by the number of sessions, times two. The first session could be repetition 1 and 2, session two will then continue with repetition 3 and 4, and so on.  

### 3.	Img_index
Index of stimuli presented. Numbers starting with 99 indicate “Non-Food-Items”, all other numbers correspond to the Food-Items. 

### 4.	Food_category_sweet 
Indicates whether the stimuli shown was “salty” (0) or “sweet” (1). 

### 5.	Caloric_category_high
Indicates whether the stimuli shown was “low caloric” (0) or “high caloric” (1). 

### 6.	Rating_type 
Whether the “liking” (0) or “wanting” (1) scale was shown.

### 7.	Rating_RT
Reaction Time; time between the start of the stimulus/image presentation and submission of the scale rating via the button press. If no button was pressed to confirm the answer no RT is recorded.

### 8.	Rating_value 
Answer of the participant on the horizontal (for ‘wanting’) and the vertical (for ‘liking’) scale. If the rating was not confirmed via a button press, the most recent value for the rating is recorded. 
Liking ratings can range from -100 to +100
Wanting ratings can range from 0 to +100.

### 9.	Rating_submitted 
Records whether the participant did submit the rating (1) or not (0) via the Joystick Button A. 

Further for each session two identifier variables are saved Subj and timestamps:
![image](https://user-images.githubusercontent.com/50832722/193069281-3221bfef-afa5-4742-83aa-e74cd60e26bb.png)
