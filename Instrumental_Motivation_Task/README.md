# Instrumental Motivation Task (IMT) 

## Introduction
The Instrumental Motivation Task is a cost-benefit paradigm that allows participants to work for food and monetary reward though effort in the form grip force. The output from this task allows for the estimation of effort vigor and maintenance. It is a task that can be used for investigating motivational processes.
The current version not only allows for grip force, it also enables the following major features:
* PET/fMRI Compatibility a the grip force device is MRI compatible and the main task does not require visual input and therefore does not require a mirror. 


## Implementation of the Instrumental Motivation Task 

The Script has to be run first in the Training mode (runINDEX = 1), and for a second time, in the Experiment mode (runINDEX = 2). 

The **Training** Mode is comprised of 3 sections. 
* 1. Calibration Phase:
This sets the minimum and maximum effort via the GripForce-Device which is used to calculate effort and points during later trials.
* 2. Cue Association Training
The participant learns the tone-reward associations as they are repeatedly paired. This is repeated until a set performance across two consecutive query blocks is reached for the four different association.  
* 3. Training of experimental task as it will be during the ‘Experiment’ Mode:
The task as it will be during the experiment is practiced (see Figure 1; cue phase, signal tone, bidding phase, and feedback). In addition, participants receive feedback whether their trial was valid (i.e., they pressed after the end of the signal tone) or invalid (i.e., they pressed before the end of the signal tone (threshold of set force is exceeded)). 

The **Experiment** Mode reminds the participant of the learned tone-cue associations and follows for each trial the following order: 
![image](Instrumental_Motivation_Task/Documentation/IMT_Trial.png)


## Script description 
 For a detailed script description please read ![file](Instrumental_Motivation_Task/README_IMT.docx)
