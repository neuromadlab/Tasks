# Pulsed Reinforcement Learning Task

## Background
The pulsed taVNS reinforcement learning task (puRL for short) is a task that is used to study the effects of pulsed vagus nerve stimulation on different phases of reward learning, more specifically feedback and action. It was developed originally for the BON002 study, and it consists of 4 blocks of a 2-armed bandit reinforcement learning paradigm completed in the MRI. Participants select one of two planets to try and earn as many points as possible. To choose a planet they need to press one of the two arrows on the keyboard (training version) or one of the two grip force devices they hold in their hands (MRI version), and keep pressing until a red circle is completed around the chosen planet. Planets are presented in pairs that remain stable throughout the block, and each block contains two pairs of planets with different probability contingencies. One pair has a 75%-25% probability and it’s defined as “easy” pair, the other pair has a 65%-35% probability and it’s the “hard” pair. Depending on their choice, participants receive a short (1s) stimulation through the taVNS device. During each stimulation is delivered at different times:

- During two blocks (called “feedback” blocks), stimulation is delivered every time the participant receives positive feedback (i.e. “You win!”), while a low intensity unperceivable stimulation is delivered when they receive negative feedback (i.e. “You lost”).

- During two blocks (called “action” blocks), stimulation is delivered every time the participant chooses the planet that should lead to a reward. Stimulation is delivered while the participant is pressing the grip force device, also in those trials where the chosen planet did not actually lead to a reward.

## How to set up puRL
The most recent file directories of the current EAT version can be found on GitHub and on the NAS (BON_general\Tasks\puRL\Project_version\BON002\v1.1.0). The script for ‘puRL_task’ contains the code for the BON002 project. In lines 16-22 you can change the task settings based on your environment and needs:

- doDebug = use 1 for debugging - smaller window etc., 0 otherwise

- doJoystick = use 1 for when you are using a joystick (e.g. grip force)

- doScanner = use 1 if you’re at the MRI

- doTVNS = use 1 if you’re using the tVNS device (use 0 during training)

- doTTL = use 1 when you want to send triggers to the Biopac (e.g. for the EGG)

in BON002, purl consists of 3 parts:

- a training outside of the scanner, in which participants only complete 10 trials, do not receive any stimulation and use the arrows to choose planets. This usually happens on a laptop

- a training inside the MRI scanner, in which participants complete 4 trials suing the grip force device. Before the trials, they also calibrate the grip force device. No stimulation is given in this training

- the complete task inside the scanner, with a duration of 30 min, four blocks (2 action, 2 feedback) and stimulation.
