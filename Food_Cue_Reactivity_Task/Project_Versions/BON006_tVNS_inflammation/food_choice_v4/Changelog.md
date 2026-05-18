# Changelog vor food_choice_v4

(version and date correspond to the respective tag in the gitlab history. E.g. tag v1.2 marks the version that has all the changes of v1.2)

**v1.1**   (09.04.2025 - 04:31am)

First version to run with participant S000001

**v1.2**    (28.04.2025 - 04:47am)

* added algorithm to choose unique image pairs

* **switched output for emaType11 (yes=1 & no=2)**

* rearranged emaQuestions (put "haben sie heute schon ihren Vagusnerv stimuliert?" to the end.)

* changed variable names in logfile
  
  * changed emaResponse to VAS_response
  
  * change entries for leftImage & rightImage: without path, just the numbers
  
  * change variable name: emaQuestionsReadLoop to questionloop

* adapted output filenames (expName_studyID_participantID_SsessionID_date.csv)

* conditioned continuation for ema type 10 & 11 (they don't continue until there is an entry in the text input field)

* added variables to logfile
  
  * added emaQuestionNumber
  
  * validChoice (1 if particpant made a choice, 0 if missed)
  
  * optionRight (1 for choosing right, 0 for choosing left)
  
  * data of fixation routine
  
  * trialCounter
  
  * blockCounter

**v2**    (08.05.2025)

* added imgCounterL & imgCounterR to output (the usage of each image is counted separately)
* added variable to logfile:  fixationDuration

**v2.1**   (12.05.2025)

* textual input via iframe approach abandoned
* changed the one question type11 to type3
* changed question type10 to have checkboxes: type 10: Checkbox[ <5, 5-14, 15-29, 30-44, 45-59, 60-89, >/=90 ] with output [1,2,3,4,5,6,7]

**v3**     (22.05.25)

* added functionality to show the execution location

* changed participantID to participant (to prevent issues with online functionality)

* changed sessionID to session (to prevent issues with online functionality)

**v4**     (19.06.25)

* changed selection of choice images: the 20 nearest likings to the moderate anchor 17.82
* assuming the range of likings in [-100, 100] (from food_rating_v2)
