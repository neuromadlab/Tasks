# Guitart-Masip Task

## Output description

The most important variable from the Guitard_Masip.m script is output. This variable is also saved at the end of script execution as 

GMT_[Study_identifier]_[subject ID]_S[Session ID]_R[Run ID].mat 

e.g. GMT_TUE009_000001_S1_R1.mat for Subject 1, Session 1, Run 1, TUE009 Study 
This matlab data structure has 12 fields that are described in the following. 


### 1.	Pobabilities_matrix: 
Matrix with the probabilities (0, 0.2, 0.8) to determine feedback (win, neutral, lose) dependent on GMT conditions (go to win, go to avoid punishment, no go to win, no go to avoid punishment) and the given answer (Go, No Go). This matrix is fixed throughout the study and does not change per subject, session or trial. 
![image](https://user-images.githubusercontent.com/50832722/193059249-46cdc330-9582-47d7-96c2-17c455cf02f8.png)


### 2.	Cue_conditions: 
Assignment of the different stimuli (i.e. fractals) to the respective conditions. This assignment is randomly determined in the beginning of every session. Contains 8 fractals, with 4 values. 

1 = Go to win condition
2 = Go to avoid punishment condition
3 = No-Go to win condition
4 = No-Go to avoid punishment condition


### 3.	Time: 
Structure with 9 fields flagging different timepoints of the experiment

3.1	paradigm_onset: time of the beginning of the paradigm

Furthermore, different time points are saved for each trial:

3.2	Trial_onset: timepoint of trial start 
3.3	Cue: timepoint of stimulus (i.e. fractal) presentation
3.4	Fix1: timepoint of 1st fixation cross presentation
3.5	Target_image: timepoint of target circle presentation
3.6	Fix2: timepoint of 2nd fixation cross presentation
3.7	Feedback: timepoint of feedback presentation
3.8	Response: timepoint of reaction (button press)
3.9	RT: reaction time


### 4.	Number_responses: (0/1) 
Indicates whether a button was pressed or not. 

0 = no button pressed
1 = button pressed

### 5.	Key_pressed: (0/1/2) 	 
Indicates which button was pressed.

0 = no buttons pressed
1= left button pressed
2 = right button pressed

### 6.	Cue_presented: (1/2/3/4) 
Indicates which stimulus (i.e. fractal) was presented during the trial.

1 = Fractal 1 
2 = Fractal 2 
3 = Fractal 3 
4 = Fractal 4
5 = Fractal 5
6 = Fractal 6
7 = Fractal 7
8 = Fractal 8

### 7.	Cond_presented: (1/2/3/4) 
Indicated which condition was presented.

1 = Go_to_win		
2 = Go_to_avoid_punishment
3 = No_go_to_win
4 = No_go_to_avoid_punishment

### 8.	Reward_type: (1/2)
Indicate which reward was presented 

0 = Food
1 = Money

### 9.	response_side: (1/2) 
Indicates on which side the target circle was presented

1= left side
2 = right side

### 10.	Correct_answer: (0/1)	
Indicated whether the given response (no, left or right button) was correct for the given condition. 

0 = incorrect answer
1 = correct answer

### 11.	Probabilities: (1-8) 
Indicates for each trial which probabilities were used. This depends on the condition as well as the response. The index 1-8 refers to the row in the Pobabilities_matrix. 

### 12.	Feedback_cond: (1/2/3) 
Struct with only money-feedback and only food-feedback and both together. Indicates which feedback was presented.

1 = win (green arrow, points up)
2 = neutral (yellow line, horizontal)
3 = lose (red arrow, points down)

### 13.	Accuracies: 
Structure that saves overall as well as condition-specific accuracies

13.1	overall: proportion of correct answer across all trials and conditions
13.2	Go_to_win: proportion of correct answers in this condition
13.3	Go_to_avoid_punishment: proportion of correct answers in this condition
13.4	No_go_to_win: proportion of correct answers in in this condition
13.5	No_go_to_avoid_punishment proportion of correct answers in this condition

