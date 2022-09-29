# REWARD RATING TASK

## Introduction

This reward rating task can be divided into two phases: the anticipatory facet and the consummatory facet. 
In the anticipatory facet, participants see or hear cues of primary rewards (food, music, erotic content). 
After each cue, they rate wanting on visual analog scales. Each cue is presented twice and wanting and liking ratings for each item are 
separated in time to facilitate the distinction between the two concepts. 
Then, in the consummatory facet, participants are presented with a choice between two previously rated stimuli. 
After a series of choices, one will be randomly selected for the participant to receive. 
Immediately after receiving the reward, participants are asked to rate liking of the reward. 
Crucially, during the consummatory phase of 30s, participants can freely adjust the liking rating as it evolves over time.
![image](https://user-images.githubusercontent.com/50832722/193062051-c0aa88dd-4af4-4060-8414-bc4a0f02b7e0.png)

## Reward_Rating_main.m
There are three general blocks in which the script can be divided: 
-	Experiment preparation and customization: Parts 1 – 7
-	Experiment run: Parts 8 – 9
-	Saving experiment data: Part 11

### Part 1: General settings and preparation

In this section, the following points are taken into consideration: 
-	Project and subject information: Request subject and session information from experimenter. Convert this information to the appropriate formats (e.g. num2str, abbreviations etc.). Participants ID are filled with zeros at the front of the number until the ID consists of a total of 6 numbers.
-	Request language: German or English.
-	Request start phase: I or II. If the user wants to start the task in phase II, a generic output from phase I will be used for the execution of phase II. This generic phase I output is stored as a file named output_phase_I_generic.mat
-	Request erotic category: men, women, both
-	Controller selection: Xbox gamepad (joystick)
-	Set up folder for backups and final data
-	Screen preparation
-	Get operating system and path information
The settings that are found at the beginning of the Reward Rating Test and that can be used to customize the script are elaborated in order of appearance:
![image](https://user-images.githubusercontent.com/50832722/193062247-879b55a1-6964-44f0-829c-6cc30b9d3c4a.png)

### Part 2: Set task parameters
- Display settings, in order of appearance:
![image](https://user-images.githubusercontent.com/50832722/193062410-faa912db-e533-4d6f-b371-d4fa6a6489df.png)
- Define all screen settings, get center coordinates and specify image scaling according to the screen settings
- Load gamepad controller specifications and query
-	Define fixation cross

### Part 3: Load instructions and stimuli
In this section, the supplementary file texts.mat is loaded, which contains all the instructions and texts that appear in the experiment both in German and English.
Erotic, music, and food stimuli are loaded. Erotic stimuli are loaded depending on the previous male/female/both choice. 
The textures for all stimuli are made and the audio data is stored such that every stimulus is prepared for the later use with Psychotoolbox. 
The supplementary files needed for this section are stimuli.mat, stimuli_female.mat, and stimuli_male.mat.  

### Part 4: Phase 1 settings
In this part, all the settings related to Phase I are defined:
-	The order of stimuli presentation is obtained using a pseudorandom method. 
Each stimuli will be presented twice, as it will be rated using the wanting scale and the liking scale. 
The wanting and liking ratings will appear in a random order. 
The only constrain that must be fulfilled for the order selection is that the same item cannot appear consecutively, 
meaning that the same item cannot be rated twice in a row. For achieving that, a random seed is set, a random shuffle is performed and, 
after making sure that the resulting sequence fulfills the constrain, two different vectors are obtained : a vector for the stimuli order and a vector for the question (rating: liking or wanting) order.
-	Picture frames and positions are defined based on the screen settings and stimulus image size.

### Part 5: Phase 2 and 3 settings
This section of the code sets the position of the stimuli in Phase II based on the screen settings, 
it also defines the number of trials using the variable n_trials and the time constrain using the variable time_limit, 
which will be the time given to take the decision in each iteration during phase II. 

In addition, this section includes the settings that can be modified for Phase III. 
The number of reward trials is defined by n_reward_trials, and con_trials contains the trials where these rewards will be presented. 
If the number of trials in Phase II or the number of reward trials want to be changed, 
the easiest way to do it is to set the number of total trials as a multiple of the number of reward trials. If it is not the case, the code should be adapted. 
The time given for rating the rewards (Phase III) is specified with the variable sampling_time_phase_III, which is currently set to 30 seconds.

Exclude_food is a list containing the non-available food items for the reward phase. It can be modified in this section, too.

### Part 6: Input device settings
The joystick specifications are loaded, and the variables needed in the VAS and LHS scale scripts are defined.

### Part 7: Load jitters and initialize jitter counters 
This part of the code loads the jitters used for the fixation cross and scale slider and initializes the respective jitter counts.

### Part 8: Start of experiment and Phase I
-	The starting time of the experiment is stored. 
-	Phase I will only start if the user chose to start in that phase in Part 1. 

Phase I: Rating
-	Display instructions screen
-	Fixation cross
-	Stimuli rating loop: currently, there is an option to break the loop by holding any key of the keyboard pressed
1.	Identify question type based on the question order vector obtained in Part 4: wanting or liking.
2.	Identify stimulus category and label based on the stimuli order vector obtained in Part 4.
3.	Display stimulus image and rating scale using Effort_VAS function. In this task, the Effort_VAS function was modified so that it includes a section to start playing the music stimuli right after displaying the scale, and to stop it after getting the rating value.
4.	Fixation cross and saving how much time passed between experiment onset and fixation cross onset. 
5.	Save output data and save a backup temporary file. More information in Output description section.
6.	Define input for stimuli presentation order function for Phase II.
7.	Currently, another backup file is saved here.

### Part 9: Phase II and III
Phase II: Choosing
-	Stimuli presentation order is defined considering if the Phase I was performed and using the choose_pairs_trials_random function. More information about this function in the Supporting files section.
-	Display instructions screens for the choice phase and explaining the reward trials that are interleaved. 
-	Fixation cross.
-	Initialize all variables and vectors used in the trial loop
-	Choosing loop:
1.	For loop with two iterations to select the right and left stimulus that will be displayed on the screen, identifying their category and corresponding image based on the chosen_pairs vectors obtained in the first part of this section. If one of the stimulus is a music sample, the sound starts playing here.
2.	Display stimulus pictures on the screen.
3.	While loop used to get the decision of the user. Pressing the B button on the controller means that the item  on the right is chosen, and pressing the X button means that the item on the left is chosen. 
4.	If no button is pressed during the time given for choosing one stimulus, the submission will be defined as 0.
5.	Music stimulus stops playing.
6.	Second fixation cross of Phase II. Saving how much time passed between experiment onset and fixation cross onset.
7.	Store a variable with the category of the chosen item.
8.	Save output data and create a temporary backup file.
9.	Phase III: Present a previously chosen reward item at multiple timepoints during the task. Currently, this is set to happen every time the iteration corresponds to a multiple of a third of the total iteration number. In those reward trials a randomly chosen item is presented for a longer time (e.g., 30 s) and participants can continuously rate their liking while they consume the reward. Food items are only presented in the last of the reward trials since they are given to the participants to eat them.
a.	Choose items from the ones chosen in up until now. Exclude previous rewards and non-available food items depending on trial number. The list of excluded food items can be modified in Part 5.
b.	Display scale and stimulus, and get the rating response using Effort_VAS. Music stimuli can be started and stopped inside the Effort_VAS file, too. 
c.	Fixation cross
d.	Store output and create backup temporary file

### Part 10: End of experiment
Show screen with end text and save the experiment end time and length.

