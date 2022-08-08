# Effort Allocation Task - TUE001 tVNS behavioral

To run this task, [Psychtoolbox including gstreamer](http://psychtoolbox.org/) has to be installed. Furthermore a game controller has to be connected as a HID device to the experimental computer. This version of the task is verified to run with the cabled version of the XBOX 360 Controller (for Windows). It might run out of the box with other controllers, but this was not tested. 
Task execution has been tested with Matlab version R2017a. Due to the utilization of the WinJoystickMex function from Psychtoolbox, the task can only be executed properly on a computer running the Windows operating system.


## Executing the task

Using the script shuffle_conditions_effort.m, condition files have to be generated first which define the respective condition (Difficulty (low, high) x Reward (money, food) x Size of reward (low, high)) in a randomized order for each of the 8 trials in the training phase and 48 trials in the experimental phase of the behavioral version of the task. Condition files are generated for the specified participant IDs and automatically saved in the folder 'conditions' within the working directory.

After this preparatory step the task itself can be started by executing EffortAllocation_task13.m which automatically calls every other script necessary.

To compute the payment as it was issued in our study, compute_win.m can be executed after the task itself has been finished.