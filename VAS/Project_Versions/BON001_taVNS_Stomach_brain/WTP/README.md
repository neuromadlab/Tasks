**Willingness too pay**
==================

This file should help you to get started with the experiment code and give you a general overview about the settings and routines of the experiment. In order to follow the explanations it is recommended to open the `.psyexp`-file in the [PsychoPy Builder](https://psychopy.org/builder/).

Note that the experiment is written with the PsychoPy Builder v2023.2.3. If you want to make changes to the experiment and reupload it, you might also need to use this or a newer version of the Builder.
Also note that, the **PsychoPy version is v2022.2.3**. Please stick to this version, to prevent errors (see *Experiment settings* below).

If you need instructions regarding Pavlovia, please refer to the [neuroMADLAB wiki](https://neuromadlab.synology.me/mediawiki/index.php?title=Pavlovia).

As running the experiment offline based on the Python script does not represent the outcome of the online experiment based on JavaScript, we purely focus on the JavaScript code. Thus, **the experiment can only be run online via Pavlovia**.

---
# Experiment settings
_In the PsychPy Builder click on the gear wheel in the menue bar in order to open and edit the experiment settings._
* **Basic**: Under *Use PsychoPy version*, the version 2022.2.3 must be chosen. The *Enable Escape key* checkbox should be deactivated such that participants can't quit the experiment by (accidentally) hitting the Esc-key. Experiment info comprises the fields `participantID`, `studyID` and `session number`. By default the first is empty and the second is filled out. The participantID should be defined in the link (see wiki) and the studyID can be changed either in the settings before (re)uploading the experiment or it can be also defined via the link.
* **Screen**: The *Full-screen window* checkbox should be activated for obvious reasons. One just might deactivate it when testing the experiment.
* **Online**: In the *Additional Resources* field the files which are downloaded in the beginning of the experiment are defined. Here every image and csv-file which is used in the experiment is listed.
* **Data**: Under *Data filename* the name of the output csv-file is defined. If the `participantID ` is specified in the link, it unfortunately does not appear in the filename, which is one of many reasons why the raw output csv-files should be preprocessed. The *Save csv file (trial-by-trial)* checkbox needs to be activated to get the expected output csv-files. Also it is recommended to set the *Logging level* to *error* in order to keep the log-file sizes minimal (in principle we do not need the log-files, but deactivating them does not work - at least for the used Builder version).


# Routine overview

`global_experiment_settings`
----------------------------
Some global variables are defined here as well as a statement which checks whether a mobile device is used. Also the `stimuli/activities.csv`-file is directly loaded in which has `N` activities listed. Since each activity is presented once in an *alone*-condition and once in the *together*-condition, `N_TRIALS` is defined s.t. it is double the amount of activities.

`jitter_settings`
----------------------------
From the jitter-csv-file the jitter times are imported, shuffled and stored in the `jitter` list.

`language_choice`
----------------------------
By clicking on either the image of the flag of Germany or the flag of the United Kingdom, participants can choose their preferred language. Important here is the *code_languagechoice* component where according to the chosen language all the following **texts** are defined.

`trial_definer`
----------------------------
After defining some helper functions, the following four lists are created. `ActivityIDs` gets filled with two times the activityIDs (i.e. [activityID_1,...,activityID_N,activityID_1,...,activityID_N]). `Activities` is filled in the same way with the activity names. `Conditions` is filled with N times the identifier "alone" and afterwards N times the identifier "together". `RANDIS` is a list of random shuffled indices (i.e. numbers 0 to N_TRIALS).

`instructions`
----------------------------
Participants should read the instructions and can continue by clicking with the mouse on the *textbox_continuebutton* component.

`trial_settings`
----------------------------
This routine starts in the beginning of each trial. The variable *idx* is sequentially incremented at the end of the routine and is used to get jitter from the previously shuffled jitter list and to read out a random index from the list `RANDIS`. With this random index, the activity and condition is chosen in each trial from the lists created in the *trial_definer* routine.

`fixation`
----------------------------
In each trial a fixation cross is shown before stimulus onset. The `fixation_duration` is set for each trial in the previous routine using the specified `ISI + jitter`.

`stimulus_rating`
----------------------------
In this routine a horizontal slider is displayed with manually added labels (*textbox_l01* and *textbox_l02*). The *textbox_slidertext* component asks the participant to give a reaction, the *textbox_activitytext* displays the activity and the current condition chosen in *trial_settings*. Also the *image_icon* is set according to the condition, i.e. according to specifications in *trial_settings*.

The *code_updateState* component comprises an EachFrame-statement which constantly looks for rating changes and updates the value displayed by the *textbox_slidertext* component. If we directly try to get the rating from the slider, the rating is only updated after the pointer has been dragged and not during the dragging. So in order to get constant values, we track the x-position of the mouse/the finger and interpolate the rating by comparing this x-position to the positional variables of the slider. If a rating was given, this is tracked by the `rating_done`-variable and `ratingGiven`-boolean, which activates the submitbutton. Since we need the mouse to get the rating, we cannot directly enable it to end the routine since this would allow the participant to click in the region of the submitbutton even before it is displayed, i.e. a rating was given. So in the EachFrame-statement of the code component we manually enforce the end of a routine if a rating was given and the submitbutton was pressed.

`end`
----------------------------
In the end only some texts are set for the last experiment frames.
