# Slot Machine Task
## Background
The Slot Machine Task (SM) is a reinforcement learning task adapted from Behrens et al., 2008. For each trial, participants decide between two slot machines (blue or red), determined by their expectation of the correct result and the reward associated with each outcome. On the top part of the screen, participants can see the amount of money they can win/lose from each machine and how much money they currently have.
First, participants are presented with two slot machines. To choose a slot machine, they need to press the right or left button of the mouse pad. The slot machine will then start moving and a sign saying either "You win!" or "You lose!" will appear after a few seconds. Points will then be detracted to the total amount on the top of the screen. There are several blocks in the task, and in some versions participants alternate blocks in which they are playing for money and blocks in which they are playing for food. Participants know that in each trial, one of the slot machines leads to a win and the other one to a loss, with different probabilities throughout the block. However, they are not informed that the probability with which each slot machine leads to a win/loss changes during the trial. One slot machine might be more advantageous at the beginning of the block and then become disadvantageous in the middle of the block. Participants need to adapt their choices accordingly in order to win as many points as possible.

References: Task based on Behrens et al. (2008)

## Location
D:\SynologyDrive\BON_general\Tasks\Slot_Machine
or
D:\SynologyDrive\TUE_general\Tasks\Slot_Machine

##How to set up the SM
The most recent file directories of the current SM version can be found on GitHub and on the NAS (BON_general\Tasks\Slot_Machine\Project_version\BON002\v1.0). The script for ‘SM_task_v8’ contains the code for the BON002 project. In lines 21-ff you can change the task settings based on your environment and needs:
- 21 settings.debug = use 0 when in the scanner (waits for triggers)
- 54 SMsettings.settings.do_fullscreen = 1 for full screen, 0 for smaller window
- 78 Screen('Preference', 'SkipSyncTests', 1); change this based on your environment. If you are in the MRI you will need a flipped screen
- 87 setup.screenNum = max(Screen('Screens')); %secondary monitor if there is one connected other settings: 0 - debugging window, 1- fullscreen, 2 - medium size

## Project Versions
### BON002
in BON002, SM consists of 4 blocks with only monetary rewards:

- the task happens on a laptop outside of the scanner
- participants complete the task BEFORE receiving taVNS stimulation
