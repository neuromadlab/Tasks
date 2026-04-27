# food_choice_v4

Experiment name: food_choice_v4

    

*Summary:*
The Food Choice Task is about answering an Ecological Momentary Assessment and then conduct a choice task: 20 images of food are presented 3 times, in pairs, and the participant has to choose one of them.

     

*Description:*
Participant responses are given with the mouse or onscreen touch input, depending on the chosen device.

At first, the food ratings that the participant created with the food_rating_task are read from the shelf. If there are none for this participant, the tasks ends with a notification. If the task runs in "pilot"-mode or locally (not over the Pavlovia website), then a screen which indicates the location in large red letters is shown for 3 seconds and a fix test-set of food ratings is used instead of shelf-data.

The food ratings are then used to filter out 20 images for the choice task: the 20 images with a liking-rating closest to the moderate range (middlepoint at 17.82), are chosen. Only images with positive ratings are wanted, so only when there are not 20 of those available, the set will be filled up with negative ones.

The participants starts by choosing the language and then selecting the used device (mobile/desktop/tablet). If a mobile or tablet was selected, the participant is asked to use it in landscape format.

The first part is the Ecological Momentary Assessment: after instructions the participant is presented several questions that need to be answered by selecting a spot on a rating-scale (slider) or selecting a checkbox. Everything is continued by pressing on a submit button.

The second part is the actual food choice, beginning with instructions that are also continued by pressing on a submit button. A 5 seconds countdown gives time to get prepared. Then the participant will be presented 3x20 images in total (30 pairs), as the 20 chosen images are paired in couples for a first block and again coupled for a second and third block, with the condition that each couple is uniqe, never the same 2 images in more than one couple. For each pair, the participant first sees for 1 second a fixation cross and then for maximal 4 seconds both images, one to the left, one to the right. The participant is supposed to choose one of the two images by clicking on it, within a timelimit of 4 seconds, where a red exclamation mark appears as a reminder 1 second before end. Exceeding the timelimit results in a miss, and the task continues with the next image pair.

    

## Experiment settings

**shelf - food ratings**

The experiment needs a set of food ratings for the current participant as input, with an expected range in [-100, 100]. In case it runs from  the pavlovia server in "running"-mode, the food ratings are taken from the shelf. Be aware that the experiment ends immediately when there is no food rating of/for the current participant.
In case the experiment runs in "pilot"-mode or locally in your browser, a fix test set is used as food rating, additionally the location (LOCAL or PILOT) will be displayed in big red letters for 3 seconds in order to indicate the test situation. You can alter this behavior in the routine `shelf_extract`.

    

**files**

The folder ./stimuli/Food_Stimuli holds all images that are available for choosing a subset for the choice task, filenames are expected to be numbers.
The file ./stimuli/imageList.xlsx holds a list of all these images (!!not used anymore!!).
The file ./stimuli/instructions.xlsx holds all instructions for the task.
The file ./stimuli/emaQuestions.xlsx holds the questions for the EMA (Ecological Momentary Assessment), and some setup infos which are explained later on in an own section.

It is necessary to have all these files to be listed in the list of "Additional resources". For this, open the experiment settings (gearwheel-button in the upper toolbar), open the "Online"-tab and update the list if necessary.

You may also have a look at the various other settings in this window e.g. the "Enable escape key"-checkbox (Basic tab) or the "Show mouse"-checkbox (Screen tab).

    

When you update the instructions.xlsx, reload the list via the `instructionReadLoop` in the Routine flow at the bottom of the gui.

For this, click on the loop-box, then a new window opens, there is a small "specify file"-button beneath the Conditions-entry. In case you want a new list or damaged the formating of the old one, there is also an "open/create.."-button, which creates the special formatted file.

This procedured applies also to the emaQuestions.xlsx which is read in via the `questionloop`.

    

**EMA  questions**

Each line of the table in emaQuestions.xlsx gives 4 variables that are used within the `questionLoop`:

1. the german question text 

2. the english question text

3. the question type (details in next section)

4. the question expectation (not yet implemented, aims on skipping a follow-up question if the expectation is met)

**ema questions type**

The question type variable controls which of the question types is used, that are prepared in the code. The question text will always be above a variation of a slider or a checkbox. The types are:

1. slider with anchors (not at all, very) / (überhaupt nicht, sehr) and output in range [0,100]

2. checkboxes with labels (<0.5h, 1h, 1.5h, 2h, 2.5h, >3h) and output [1, 2, 3, 4, 5, 6]

3. checkboxes with labels (Yes, No) / (Ja, Nein) and output [1, 2]

4. slider with anchors (very poor, very good) / (sehr schlecht, sehr gut) and an output in range [0,100]

5. checkboxes with labels (Yes, No) / (Ja, Nein) and output [1, 2], a reminder text appears between the checkboxes if "No" is checked: ("Please catch up" / "Bitte holen Sie das nach")

6. checkboxes with labels (0=never, 1, 2, 3, 4, 5=always) / (0=nie,1,2,3,4,5=immer) and output [1, 2, 3, 4, 5, 6], 

7. checkboxes with labels (Strongly disagree, Moderately disagree, Mildly disagree, Mildly agree, Moderately agree, Strongly agree) / (Stimme überhaupt nicht zu, Stimme nicht zu, Stimme eher nicht zu, Stimme eher zu, Stimme zu, Stimme vollständig zu) and output [0, 1, 2, 3, 4, 5]

8. checkboxes with labels (Less, same amount, More) / (Weniger, Gleiche Menge, Mehr) and output [1, 2, 3]

9. NOT IMPLEMENTED YET - planned: checkboxes with labels (0, 1, 2, 3, 4, 5, 6, 7 or more) and output [0, 1, 2, 3, 4, 5, 6, 7]

10. checkboxes with labesl (<5, 5-14, 15-29, 30-44, 45-59, 60-89, >=90) and output [1, 2, 3, 4, 5, 6, 7]

    

## Output

**logfile**

The important output file is a *.csv file, named after the scheme:
experimentName_studyName_participantNumber_SsessionNumber_date
e.g.: food_choice_dev_BON006_test_S1_2025-04-28_05h50.47.650

Some maybe not self explaining columns in the data table are listed here:

    

For the EMA questions:

`VAS_questionNr` - a simple counter, starting at 1

`VAS_response` - the response on the slider / checkbox, please refer to the previous section "ema questions type" for an detailed explanation of the possible results for the different question types.

`emaQuestions_type` - the number denotes one of the types in section "ema questions type".

`emaQuestions_expectation` - not yet implemented

    

For the food/image choice:

`fixationDuration` - duration of fixation cross in seconds

`imgCounterL` / `imgCounterR` - these are counters which count each usage of a specific image individually, regardless of the side.

`leftImage` / `rightImage` - these are the names (numbers) of the images, without path or file-extension.

`choice` - denotes the chosen side: "right" or "left" or "missed"

`optionRight` - 1 for right option was chosen, 0 for left option, or "missed"

`choiceRT` - the response time of the choice in seconds, -1 for missed choice

`trialCounter` - starts at 1 and counts each new choice

`blockCounter` - gives the number of the blocks, 1, 2 or 3 (each 20 images)

`validChoice` - 1 if a valid choice was made, 0 for a missed choice

    

## Experiment overview

The following sections will help you to get started with the experiment code and give you a general overview about the settings and routines of the experiment. In order to follow the explanations it is recommended to open the `.psyexp`-file in the [PsychoPy Builder](https://psychopy.org/builder/).

If you need instructions regarding Pavlovia, please refer to the [NeuromadlabWiki](https://neuromadlab.synology.me/mediawiki/index.php?title=Pavlovia).

The experiment was created with v2024.2.4 of the PsychoPy Builder, with a reference to the code of the reward_choice_task. Disclaimer: as this code bases on an already existing code which has a mixed up use of camelCase and snake_case, there will be a furter use of mixed cases.

The task was tested on

- Desktop PC - Windows 10 - Firefox Browser

- Smartphone - Nokia G50 - DuckDuckGo & Chrome Browser

- Smartphone - Samsung

    

## Routine overview

**shelf_extract** - code to test for the execution location, see `code_testForLocation`. In case of pilot or local test runs, the location is displayed in red letters and a fix debug-set of food ratings is used, see `code_debug`. Otherwise, in case of real run, nothing is shown and the food rating of the actual participant is loaded from the shelf, see `code_shelfExtract`. The `food_ratings` array origins from here.

**Berghain** - In case the food rating shall be extracted from the shelf and is not found, this routine shows an info box and ends the experiment. The flags to control this are set in the routine `shelf_extract`.

**filter_images** - this code creates the `filteredLikings` array, which holds the subset of 20 of the original 60 `food_ratings`.  To achieve this, for all images the 4  different ratings are first sorted alphabetically. Then the images together with their ratings are sorted ascending according to their liking rating. Finally, for each image the distance of the liking-rating to the `moderateAnchor = 17.82` is determined and the images are sorted according to this distance, separate lists for positive and negative likings.
The 20 images with positive liking ratings and the lowest distance are chosen for the array `filteredLikings`, which is used for the choice task. For cases where not enough  positive liking ratings are present, we fill up with negative ratings.

**global_vars** - code to define some globally required variables and the function `shuffle_array(arr)` (reversed Fisher-Yates algorithm).

**language_choice** - a routine that lets the participant choose between german and english by clicking on a german or an english flag-symbol. At the end some globally used text-variables are set to the chosen language and the variable `languagechoice` is set for later use in several routines.

**device_selection** - a routine that lets the participant choose which device he/she is currently using, by clicking on the respective icons ("PC/Laptop" / "Smartphone" / "Tablet"). The result is stored in the variable `device` for later use.

**mobileLandscape** - in case of using a mobile device, the participant is asked to use and stay in landscape format. In the other case this routine will be skipped. Compliance is optional and pressing the submit button continues this routine.

**load_instructions** - a psychojs standard read-file loop, to read-in the instruction texts.

**load_imageList** - depreceated, not used anymore

**emaInstructions** - uses variable `languagechoice` to take the according text for the instructions for the EMA part. There is also javascript specific code to handle a linebreak issue.

    

**questionloop** - this loop constitutes the EMA block, by iterating over all questions. In each iteration the `emaController` routine sets the flag to condition the use of the correct routine for the next question, one of the `emaTypeX` routines.

**emaController** - the variable `emaType` is an important flag: this variable having a specific number is the condition for the `emaTypeXconditionLoop's` in order to run a single time or not at all. Such, the right of the `emaTypeX` routines for the current question type is chosen. The variable `emaSkipNext` flags if the current question shall be skipped. This flag has to be set by the `emaSkipper` at the end of the loop during an earlier iteration.

**emaTypeX** - each type realizes a different question type, slider vs. checkbox, with various labels. Refer to the previous section "ema questions type" in "Experiment settings" for details. Each stores its result in the variable `emaResponse`. 

**emaSkipper** - currently, this routine just stores the response for the current question. ToDo: parse the `emaQuestions_expectation`, if the expectation is not -1 and the `emaResponse` meets the expectation, set the flag `emaSkipNext` to skip the next question.

    

**instructions** - uses variable `languagechoice` to take the according text for the instructions for the choice part. There is also javascript specific code to handle a linebreak issue.

**choicePreparations** - here, the array `filteredLikings` (which was created in the beginning and holds a set of 20 images and their ratings) is translated into the array `imgSet`, holding 60 images.
First, an array `subset` is prepared, where each of the 20 images from `filteredLikings` gets an individual counter attached, to track its usage.

During the choice task, each two images of will be used as pair and each image will be presented 3 times, but never with the same pairing.

In order to achieve this, the `subSet` is shuffled randomly, and only concated to the final array `imgSet` if each image pair in `subSet` is not already present in `imgSet`. This  is repeated until `imgSet` holds 60 images and unique pairs.

The variable `choiceLoopCount` holds the number of iterations of the `loop_choice`.

**countdown** - just showing a countdown from 5 to 0, to give participants time to prepare, especially to localize the trigger-buttons in case of using a keyboard.

    

**loop_choice** - this loop constitutes the actual choice task, it iterates through the pairs of `imgSet` to present each pair, so the range of this loop is half the size of imgSet.

**fixation** -  just shows a fixation cross for 1 second

**choice** - the `code_choice` constructs the paths to load both images, increases their usage counter, logs this info, and handles datalogging when the participant selects a side/image.

**end** - the end routine shall prevent the participant from closing the experiment too early (prior to data transmission to the server).