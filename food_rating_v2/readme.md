# Food Rating Task (v2)

Experiment name: food_rating_v2

    

*Summary:*
The Food Rating Task is about rating 60 images of food on 4 different scales: liking, wanting, healthiness, and sustainability. After that, the participant is supposed to order the 4 categories according to personal importance.

     

*Description:*
Participant responses are given with the mouse or onscreen touch input, depending on  a routine for mobile detection. Starting with a language choice and instructions, which are continued by pressing on a submit button, all images are randomized and rated on 2 scales in the first block, then re-randomized, and then shown with the remaining 2 scales in the second block. Each image is shown with the respective scale/slider, a submit button appears only after the slider has been moved / a rating has been set, and optionally a reminder text appears after 10 seconds when no rating has been given yet. After clicking on submit, the second scale is presented with the same image without interruption. There will be a fixation-cross displayed for 1 second between each image (so, after 2 scales), with no extra interruption or visible distinction between the 2 blocks. For the second block the images are randomized again and presented like in the first block with the remaining scales. Which of the 4 scales is  shown when, is randomized for each image individually over both blocks. "liking" is a vertical slider in range [-100, 100], where "wanting, healthiness, and sustainability" are horizontal sliders, in range [0, 100], all with different colors, labels, and texts. After all images have been rated, there will be a 1s fixation-cross and then instructions for the last  task. The 4 categories of the scales are presented in the lower half of the window, as keywords in colored boxes with the same colors the sliders had, and with a randomized starting order. The participant is supposed to drag and drop this boxes/ categories into 4 empty frames on the upper half with respect to personal importance, top being the most important. Dropping a category over an occupied frame or any free space, will make the category snap back to its original position. When all 4 categories are in place, the last submit button appears, which ends the experiment.

    

## Experiment settings

The folder ./stimuli/Food_Stimuli holds the images to be rated, filenames are expected to be numbers.
The file ./stimuli/imageList.xlsx holds a list of all the images to be rated.
The file ./stimuli/instructions.xlsx holds all instructions for the task.

On changes, it is necessary to have all files to be listed in the list of "Additional resources". For this, open the experiment settings (gearwheel-button in the upper toolbar), open the "Online"-tab and update the list.

You may also have a look at the various other settings in this window e.g. the "Enable escape key"-checkbox (Basic tab) or the "Show mouse"-checkbox (Screen tab).

    

When you update the imageList.xlsx, reload the list via the `imageListReadLoop` in the Routine flow at the bottom of the gui.

When you update the instructions.xlsx, reload the list via the `instructionReadLoop` in the Routine flow at the bottom of the gui.

For this, click on the loop-box, then a new window opens, there is a small "specify file"-button beneath the Conditions-entry. In case you want a new list or damaged the formating of the old one, there is also an "open/create.."-button, which creates the special formatted file.

    

## Output

**shelf**

The participant name and the food ratings on the 4 scales are stored on the pavlovia shelf for later use by other tasks under the key name "food_ratings".

**logfile**

The important output file is a *.csv file, named after the scheme:
experimentName_studyName_participantNumber_SsessionNumber_date
e.g.: food_rating_dev_BON006_ID_S1_2025-04-28_05h50.47.650

Some maybe not self explaining columns in the data table are listed here:

    

For the food/image rating:

`isiDur` - duration of fixation cross in seconds

`globalTrialCounter` - starts at 1 and counts each new scale presentation

`blockNum` - gives the number of the earlier described blocks, 1 or 2 

`imageRepition` - shows the number of repititions of this specific image

`conditionNr` - number-code for the conditions (1-liking, 2-wanting, 3-sustainability, 4- healthiness)

`condition` - the actual names of the conditions/scales

`image` - the filename of the image, without path or file-ending, number expected

`sliderType` - 0 for vertical slider (liking), 1 for horizontal slider

`sliderStarted` - onset of the slider and image in seconds since experiment start

`sliderStopped` - offset of the slider and image in seconds since experiment start

`sliderRating` - the actual rating for the image on this line [0, 100] for wanting, sustainability and healthiness, [-100, 100] for liking.

`ratingRT` - the response time for setting the first value on the slider in seconds

`confirmRT` - the duration between trial onset and pressing the submit-button in seconds

`confirm` - 1 if the participant pressed the submit-button (currently mandatory), 0 else

    

For the condition rating at the end of the experiment:

`ratingResult_1` - name of the first important condition (condition rating at end)

`ratingResult_2` - name of the 2nd important condition

`ratingResult_3` - name of the 3rd important condition

`ratingResult_4` - name of the 4th imporant condition

`ratingRT_1` - time between onset of rating and drop of 1st condition in seconds (-1 for error)

`ratingRT_2` - time between onset of rating and drop of 2nd condition in seconds

`ratingRT_3` -  time between onset of rating and drop of 3rd condition in seconds

`ratingRT_4` - time between onset of rating and drop of 4th condition in seconds

`rating.stopped` - time between onset of rating and submit

    

## Experiment overview

The following sections will help you to get started with the experiment code and give you a general overview about the settings and routines of the experiment. In order to follow the explanations it is recommended to open the `.psyexp`-file in the [PsychoPy Builder](https://psychopy.org/builder/).

If you need instructions regarding Pavlovia, please refer to the [NeuromadlabWiki](https://neuromadlab.synology.me/mediawiki/index.php?title=Pavlovia).

The experiment was created with v2024.2.4 of the PsychoPy Builder, with a strong reference to the code of the reward_rating_task. Disclaimer: as this code bases on an already existing code which has a mixed up use of camelCase and snake_case, there will be a furter use of mixed cases. While many comments are inside the python code, the javascript code is the important one, and the only one that will be maintained functional.

The task was tested on

- Desktop PC - Windows 10 - Firefox Browser

- Smartphone - Nokia G50 - DuckDuckGo & Chrome Browser

- Smartphone - Samsung

*Reference for food pictures:*
Charbonnier, L., van Meer, F., van der Laan, L. N., Viergever, M. A., & Smeets, P. A. M. (2016). Standardized food images: A photographing protocol and image database. Appetite, 96, 166-173. doi:10.1016/j.appet.2015.08.041

*Reference for scales:*
Liking ratings range from -100 (most disliked sensation imaginable) to +100 (most liked sensation imaginable); Lim, J., Wood, A., & Green, B. G. (2009). Derivation and evaluation of a labeled hedonic scale. Chem Senses, 34(9), 739-751. doi:10.1093/chemse/bjp054
Other ratings range from 0 to 100; enviromental suistainability from Kelly J. et al (2013). Written Messages Improve Edible Food Waste Behaviors in a University Dining Facility. Journal of the Academy of Nutrition and Dietetics. Volume 113, Issue 1, January 2013, Pages 63-69. doi:10.1016/j.jand.2012.09.015

    

## Routine overview

**global_vars** - code to define some globally required variables

**mobile_detection** - code to determine automatically if it is a mobile phone (not perfectly working, better let the participant choose) and sets the variable `mobile_device` for later use.

**language_choice** - a routine that lets the participant choose between german and english by clicking on a german or an english flag-symbol. At the end some globally used text-variables are set to the choosen language and the variable `languagechoice` is set for later use in the instruction routines.

**load_instructions** - a psychojs standard read-file loop, to read-in the instruction texts.

**load_imageList** - an almost standard read-file loop, to read-in the imagelist. The image names (numbers) are accumulated in the variable `imageList`

**instructions** - uses variable `languagechoice` to take the according text for the instructions. There is also javascript specific code to handle a linebreak issue.

**preparations** - holds a function to shuffle an array:  `shuffle_array(arr)`, and inits several  display related common variables and the `globalTrialCounter`. Most important, here are the combined `image_condititions` created: an array of subarrays where each image (order randomized) gets its own 4-set of conditions appended (order randomized for each image). Thus it's possible to present each image with a randomized order of conditions but assure that each is shown exactly with the 4 conditions, no repititions, no omissions. This array determines the order of presentation of images and conditions in the following two blocks

    

**images_block1_loop** - this loop constitutes the first block, by iterating over all images. Each iteration shows an fixation cross for 1 second, followed by an image with 2 conditions.

**fixation** - just shows a fixation cross for 1 second

**conditions12_loop** - this loop iterates twice, in order to show the image with the first and the second condition/scale.

**prep_trial12** - this code component is the central part of the loop/block which controls everything. The index of the current iteration of the images_block1_loop, the image loop index, short: `ili`, controls which image is used. The index of the current iteration of the conditions12_loop, the conditions loop index, short `cli` is used to determine the condition to be shown with the image.
The condition then controls: which condition-flag is set to choose the horizontal or vertical scale (`vertical_option` vs. `horizontal_option`), the color of the scale, the text for the question, and the text for the labels (only horizontal scale).
Additionally, logfile entries are made for several major variables: `globalTrialCounter`,  `blockNum`, `imageRepition`, `conditionNr`, `condition`, `image`, `sliderType` (refer to the output paragraph for descriptions).

**slider_vertical** / **slider_horizontal** - these components create the vertical / horizontal scales. Each is surrounded by a condition-loop `vertical_option` / `horizontal_option`,  who are only running one single time if the respective option flag was set in the prep_trial code. Such, the selected condition determines by a condition/option flag which scale type is used in each of the 2 runs o fthe condition12_loop.

The code_sliderX component, among other stuff, replaces the condition in the `image_conditions` array by a tuppel of condition and its rating, and such builds up a structure which holds all food ratings. Furthermore here are the logentries set for `sliderStarted`, `sliderStopped`, `sliderRating`, `ratingRT`, `confirmRT`, `confirm` (refer to the output paragraph for descriptions).

The code_ratingDetectionX component sets the `ratingGiven` variable to true when the slider control has been moved, which is also the onset condition for the submit-button. Furthermore it ends the routine if the submit-button has been pressed.

The code_reminderX component checks if no rating has been given and the timelimit of 10 seconds has been expired. If booth are true, the onset condition for showing the reminder text is set to true.

**slider_vertical** - shows a vertical slider on the right, with 11 labels. On the left, the image is shown, with a question-text underneath it.
The red reminder text is shown below that, if the condition is met, and the submit-button appears at the very bottom. For the liking-condition, the return values of the slider components (native: 0 - 100) are scaled in code to the range [-100, 100].

**slider_horizontal** - shows the image aprox in the middle, underneath it the question text, and under that the slider with 2 labels. The red reminder text is shown above that, if the condition is met, and the submit-button appears at the very bottom.

    

**reRandomize** - this code component just randomizes the image_conditions array again, preceeding the 2nd block.

**images_block2_loop** - this loop constitutes the 2nd block and presents all the images with its 3rd and 4th conditions/scale. It is nearly identical to the first one, so the description here is shorter. The important changes in the prep_trial34 code component are: 

* the indize `ili` and `cli` are taken from other loops

* `cli` is shifted further in order to point to conditions 3 & 4 in the `image_conditions` array

* the logentry for `blockNum` is now 2

Apart from the loop-names, all other routines are the same (2nd usage of same routine - changing one affects all usages.)

    

**instruction_3** - this are the instructions for the last part, the importance of conditions rating.

**rating** - the participant is supposed to drag and drop texts (elements of array `ratingTexts`) into target-polygons (elements of array `ratingTargets`). The texts are keywords which describe the conditions, and their order is randomized at start. Array `rTargetOccupation` stores if a target is already occupied, dropping a text over any other space than a free target, results in the text snapping back to its original position, which was stored in array `ratingTextsOldPos`. After a text is inside a target, it is entered into array `ratingResults`, where the order of the texts gives their importance, with the top one being the most important.
The array `ratingRTs` stores the duration between start of rating and the drop of each text.

**end** - the end routine shall prevent the participant from closing the experiment to early  (prior to data transmission to the server).