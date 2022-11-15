# Effort Allocation Task 


To run this task, [Psychtoolbox including gstreamer](http://psychtoolbox.org/) has to be installed. Furthermore a game controller has to be connected as a HID device to the experimental computer. This version of the task is verified to run with the cabled version of the XBOX 360 Controller (for Windows). It might run out of the box with other controllers, but this was not tested. 
Task execution has been tested with Matlab version R2017a. Due to the utilization of the WinJoystickMex function from Psychtoolbox, the task can only be executed properly on a computer running the Windows operating system.


## Executing the task

Using the script Create_Cond_48T_Cert.m, condition files have to be generated first which define the respective condition (Difficulty (low, high) x Reward (money, food) x Size of reward (low, high)) in a randomized order for each of the 8 trials in the training phase and 48 trials in the experimental phase of the behavioral version of the task. Condition files are generated for the specified participant IDs and automatically saved in the folder 'conditions' within the working directory.

After this preparatory step the task itself can be started by executing EAT_main.m which automatically calls every other script necessary.


## Documentation
For further information on the Effort Allocation Task as it is implemented here, please refer to Neuser et al. (2020, *NatComm*, DOI: [10.1038/s41467-020-17344-9](https://doi.org/10.1038/s41467-020-17344-9))


