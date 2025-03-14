**Activity Rating**
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
Some global variables are defined here as well as a statement which checks whether a mobile device is used. Also the `activity_ratings` list is initialized here which is filled with activity-rating tuples during the trials and uploaded to the shelf in the last routine.

`jitter_settings`
----------------------------
From the jitter-csv-file the jitter times are imported, shuffled and stored in the `jitter` list.

`language_choice`
----------------------------
By clicking on either the image of the flag of Germany or the flag of the United Kingdom, participants can choose their preferred language. Important here is the *code_languagechoice* component where according to the chosen language all the following **texts** are defined.

`mobile_instructions`
----------------------------
Here the participants that use a mobile device are asked to use their device in landscape format s.t. visibility of texts and labels during the trials can be guaranteed (but landscape format isn't enforced as portrait format works also fine on most devices).
Since the detection for mobile devices does not work reliably for tablets, also devices which have a bigger window height than width are defined as mobile devices here. For devices that are not detected to be a mobile device, the routine is skipped.

`instructions`
----------------------------
Participants should read the instructions and can continue by clicking with the mouse on the *textbox_continuebutton* component.

`trial_settings`
----------------------------
This routine starts in the beginning of each trial. The variable *idx* is sequentially incremented at the end of the routine and is used to get jitter from the previously shuffled jitter list. As the trials do not need to be shuffled or preprocessed otherwise, they are directly read in in the loop. For that to work, the csv-file containing the activities is specified in the *Conditions* of the loop properties (opened by clicking on the loop in the Routine Flow).

`fixation`
----------------------------
In each trial a fixation cross is shown before stimulus onset. The `fixation_duration` is set for each trial in the previous routine using the specified `ISI + jitter`.

`stimulus_rating`
----------------------------
In this routine a vertical slider is displayed with manually added labels (*textbox_l01* to *textbox_l11*) and slider ticks (*t01* to *t11*). The *textbox_slidertext* component asks the participant to give a reaction, the *textbox_activitytext* displays the activity.

The *code_updateState* component comprises an EachFrame-statement which constantly looks if a rating was given via the *slider*. If so, the `ratingGiven`-boolean is set to *true*. This boolean also controls the conditions for the submitbutton (& corresponding mouse component) activation and for a reminder text which asks the participant to use the slider if no rating was given within 10 seconds. Since the routine comprises many elements which need to fit on the screen, their positional arguments are all updated here if there was a window size change.
In the EndRoutine-section of the code component the data is stored and also pushed to the `activity_ratings`-list.

If a rating was given, the *mouse_nextTrial* component becomes available and the submitbutton visible s.t. the trial can be manually ended by the participant.

`end`
----------------------------
In the end only some texts are set for the last experiment frames.
Also the `activity_ratings`-list is uploaded to the Shelf with an "@designer"-key. This makes the activity ratings usable for other experiments that can retrieve them from the Shelf.
