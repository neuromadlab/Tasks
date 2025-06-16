/************************************ 
 * Influenca_Standalone_Legacy Test *
 ************************************/

import { core, data, sound, util, visual, hardware } from './lib/psychojs-2022.2.3.js';
const { PsychoJS } = core;
const { TrialHandler, MultiStairHandler } = data;
const { Scheduler } = util;
//some handy aliases as in the psychopy scripts;
const { abs, sin, cos, PI: pi, sqrt } = Math;
const { round } = util;


// store info about the experiment session:
let expName = 'Influenca_Standalone_legacy';  // from the Builder filename that created this script
let expInfo = {
    'participant': '',
    'session number': '',
    'experimenter mode': '0',
};

// Start code blocks for 'Before Experiment'
// Run 'Before Experiment' code from setupCode
// Declaration of all global variables
// ----------------------------------------------------------------------------------------------------------

var introductionText, flagCircleSizeLeft, flagCircleSizeRight, mobile_device, used_device;
var score_n, round_n, level_n, nTrials, sceneSetupSheet;
var scenes_list, notepadImage_list, scoreboardImage_list, syringeTypeSheet_list;
var currentNotepadImage, currentScoreboardImage, currentSyringeTypeSheetPath;
var emptySyringes_list, fullSyringes_list, syringeColor_list;
var pathogen_list, rewardImageSize;
var nSyringes, leftSyringeIndex, rightSyringeIndex, count, leftFullSyringeImage, rightFullSyringeImage, leftEmptySyringeImage, rightEmptySyringeImage, leftSyringeColor, rightSyringeColor;
var currentTrial;
var leftSyringe_clicked, rightSyringe_clicked;
var correctChoicesList;
var rewardBgColor, correctCure, leftCuredInt, rightCuredInt, leftCuredNum, rightCuredNum;
var leftFeedbackImage, rightFeedbackImage, correctColor, currentCorrectCure;
var previousCorrectCure, trialText, leftProbability, rightProbability, scoreBoardText;
var correctlyDone, choice_name;
var allProbabilities, antiProbabilities;
var randomSceneFactor, scene_n, backgroundPath;
var window_height, window_width, xrange, yrange, size_xy;
var notepad_xy_ratio, scoreboard_yx_ratio;
var existing_participants, session_n;
var goodRun, totalCount, step, count, differences,totalDifferences, meanDifferences;
var alreadyPlayed, neverPlayed, cond_key, cond_touch;
var languageChoice;
var score_text, round_text1, round_text2, level_text, gallery_text, continueText, playText, endingStatement, beginningStatement;
var intro1, intro2, intro3, intro4, intro5, intro6, intro7, intro8, intro9, intro10;
var galleryText, galleriePath,endGameText;
var scoreboardAdjustingSizeX, scoreboardAdjustingSizeY, scoreboardAdjustingX, scoreboardAdjustingY, notepadAdjustingX;
var coinCircleSize, circleColor, score_endText;
var currentDate, currentDay, currentTime, timesPlayed, lastDayPlayed, lastTimePlayed, canPlay, cantPlay, cantPlayReason, cantPlayReasonText;
var session_number, minutes_formatFixed, timeToWait, experimenter_mode, trialsSheet, session_data;

//Assigning values to all time-restriction variables for the first playthrough
// ----------------------------------------------------------------------------------------------------------

lastDayPlayed = [0, 0, 0];
lastTimePlayed = "never before played";
timesPlayed = 0;
canPlay = 1;
cantPlay = 0;
cantPlayReason = "none";

//Which device (mobile vs. desktop) is currently being used?
// ----------------------------------------------------------------------------------------------------------

if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(navigator.userAgent) 
    || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(navigator.userAgent.substr(0,4))) { 
    mobile_device = true;
    used_device = "mobile"
}else{
    mobile_device = false;
    used_device = "desktop"
    }

//use keys for desktop and touch for mobile device
cond_key = !mobile_device;
cond_touch = mobile_device;


//Function for the random selection of an item from an item list using probabilities from a weights list
//input: items (list), weights (list)
//output: randomly selected item
// ----------------------------------------------------------------------------------------------------------


function weighted_random(items, weights) {
    var i;
    for (i = 1; i < weights.length; i++)
        weights[i] += weights[i - 1];
    var random = Math.random() * weights[weights.length - 1];
    for (i = 0; i < weights.length; i++)
        if (weights[i] > random)
            break;
    return items[i];
}

//Function for using Box-Muller transform to generate a pair of normally distributed random numbers
//output: pair of normally distributed random numbers
// ----------------------------------------------------------------------------------------------------------


function boxMullerTransform() {
    const u1 = Math.random();
    const u2 = Math.random();
    const z0 = Math.sqrt(-2.0 * Math.log(u1)) * Math.cos(2.0 * Math.PI * u2);
    const z1 = Math.sqrt(-2.0 * Math.log(u1)) * Math.sin(2.0 * Math.PI * u2);
    return { z0, z1 };
}

//Function to generate a normally distributed random number from mean and std using Box-Muller transform
//input: mean and standarddeviation
//output: normally distributed random number
// ----------------------------------------------------------------------------------------------------------


function getNormallyDistributedRandomNumber(mean, stddev) {
    const { z0, _ } = boxMullerTransform();
    return z0 * stddev + mean;
}







// init psychoJS:
const psychoJS = new PsychoJS({
  debug: true
});

// open window:
psychoJS.openWindow({
  fullscr: false,
  color: new util.Color([-.9, -.9, -.9]),
  units: 'height',
  waitBlanking: true
});
// schedule the experiment:
psychoJS.schedule(psychoJS.gui.DlgFromDict({
  dictionary: expInfo,
  title: expName
}));

const flowScheduler = new Scheduler(psychoJS);
const dialogCancelScheduler = new Scheduler(psychoJS);
psychoJS.scheduleCondition(function() { return (psychoJS.gui.dialogComponent.button === 'OK'); }, flowScheduler, dialogCancelScheduler);

// flowScheduler gets run if the participants presses OK
flowScheduler.add(updateInfo); // add timeStamp
flowScheduler.add(experimentInit);
flowScheduler.add(initializingRoutineBegin());
flowScheduler.add(initializingRoutineEachFrame());
flowScheduler.add(initializingRoutineEnd());
const choosingTheLanguageLoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(choosingTheLanguageLoopBegin(choosingTheLanguageLoopScheduler));
flowScheduler.add(choosingTheLanguageLoopScheduler);
flowScheduler.add(choosingTheLanguageLoopEnd);
flowScheduler.add(textAssignmentRoutineBegin());
flowScheduler.add(textAssignmentRoutineEachFrame());
flowScheduler.add(textAssignmentRoutineEnd());
const sendingMessageLoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(sendingMessageLoopBegin(sendingMessageLoopScheduler));
flowScheduler.add(sendingMessageLoopScheduler);
flowScheduler.add(sendingMessageLoopEnd);
const gameplayLoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(gameplayLoopBegin(gameplayLoopScheduler));
flowScheduler.add(gameplayLoopScheduler);
flowScheduler.add(gameplayLoopEnd);
flowScheduler.add(savingDataRoutineBegin());
flowScheduler.add(savingDataRoutineEachFrame());
flowScheduler.add(savingDataRoutineEnd());
flowScheduler.add(quitPsychoJS, '', true);

// quit if user presses Cancel in dialog box:
dialogCancelScheduler.add(quitPsychoJS, '', false);

psychoJS.start({
  expName: expName,
  expInfo: expInfo,
  resources: [
    {'name': 'resources/syringe_lab_2_full_9.png', 'path': 'resources/syringe_lab_2_full_9.png'},
    {'name': 'resources/Introduction_German/Intro_Deutsch_5.png', 'path': 'resources/Introduction_German/Intro_Deutsch_5.png'},
    {'name': 'resources/Gallerie/Score_6.png', 'path': 'resources/Gallerie/Score_6.png'},
    {'name': 'resources/syringe_lab_3_full_9.png', 'path': 'resources/syringe_lab_3_full_9.png'},
    {'name': 'resources/syringe_lab_4_empty_2.png', 'path': 'resources/syringe_lab_4_empty_2.png'},
    {'name': 'resources/Gallerie/Score_27.png', 'path': 'resources/Gallerie/Score_27.png'},
    {'name': 'resources/syringe_lab_2_empty_1.png', 'path': 'resources/syringe_lab_2_empty_1.png'},
    {'name': 'resources/lab_background_9.png', 'path': 'resources/lab_background_9.png'},
    {'name': 'resources/syringe_lab_4_empty_10.png', 'path': 'resources/syringe_lab_4_empty_10.png'},
    {'name': 'resources/Gallerie/Score_16.png', 'path': 'resources/Gallerie/Score_16.png'},
    {'name': 'resources/syringe_lab_3_full_3.png', 'path': 'resources/syringe_lab_3_full_3.png'},
    {'name': 'resources/syringe_lab_5_empty_6.png', 'path': 'resources/syringe_lab_5_empty_6.png'},
    {'name': 'resources/syringe_lab_5_empty_8.png', 'path': 'resources/syringe_lab_5_empty_8.png'},
    {'name': 'resources/Gallerie/Score_14.png', 'path': 'resources/Gallerie/Score_14.png'},
    {'name': 'resources/syringe_lab_4_full_8.png', 'path': 'resources/syringe_lab_4_full_8.png'},
    {'name': 'resources/syringe_lab_4_full_10.png', 'path': 'resources/syringe_lab_4_full_10.png'},
    {'name': 'resources/syringe_lab_1_empty_4.png', 'path': 'resources/syringe_lab_1_empty_4.png'},
    {'name': 'resources/syringe_lab_1_empty_2.png', 'path': 'resources/syringe_lab_1_empty_2.png'},
    {'name': 'resources/syringe_lab_3_full_6.png', 'path': 'resources/syringe_lab_3_full_6.png'},
    {'name': 'resources/Gallerie/Score_20.png', 'path': 'resources/Gallerie/Score_20.png'},
    {'name': 'resources/lab_background_13.png', 'path': 'resources/lab_background_13.png'},
    {'name': 'resources/lab_background_6.png', 'path': 'resources/lab_background_6.png'},
    {'name': 'resources/Gallerie/Score_7.png', 'path': 'resources/Gallerie/Score_7.png'},
    {'name': 'resources/syringe_lab_5_full_7.png', 'path': 'resources/syringe_lab_5_full_7.png'},
    {'name': 'resources/lab_background_24.png', 'path': 'resources/lab_background_24.png'},
    {'name': 'resources/alternative_screen2.png', 'path': 'resources/alternative_screen2.png'},
    {'name': 'resources/syringe_lab_2_full_1.png', 'path': 'resources/syringe_lab_2_full_1.png'},
    {'name': 'resources/syringe_lab_3_full_12.png', 'path': 'resources/syringe_lab_3_full_12.png'},
    {'name': 'resources/Gallerie/Score_23.png', 'path': 'resources/Gallerie/Score_23.png'},
    {'name': 'resources/syringe_lab_4_empty_7.png', 'path': 'resources/syringe_lab_4_empty_7.png'},
    {'name': 'resources/syringe_lab_3_empty_2.png', 'path': 'resources/syringe_lab_3_empty_2.png'},
    {'name': 'resources/syringe_lab_5_full_10.png', 'path': 'resources/syringe_lab_5_full_10.png'},
    {'name': 'resources/syringe_lab_4_empty_1.png', 'path': 'resources/syringe_lab_4_empty_1.png'},
    {'name': 'resources/Introduction_German/Intro_Deutsch_2.png', 'path': 'resources/Introduction_German/Intro_Deutsch_2.png'},
    {'name': 'resources/syringe_lab_2_full_8.png', 'path': 'resources/syringe_lab_2_full_8.png'},
    {'name': 'resources/syringe_lab_1_full_9.png', 'path': 'resources/syringe_lab_1_full_9.png'},
    {'name': 'resources/Introduction_German/Intro_Deutsch_9.png', 'path': 'resources/Introduction_German/Intro_Deutsch_9.png'},
    {'name': 'resources/syringe_lab_1_full_4.png', 'path': 'resources/syringe_lab_1_full_4.png'},
    {'name': 'resources/Gallerie/Score_22.png', 'path': 'resources/Gallerie/Score_22.png'},
    {'name': 'resources/lab_background_11.png', 'path': 'resources/lab_background_11.png'},
    {'name': 'resources/syringe_lab_1_empty_10.png', 'path': 'resources/syringe_lab_1_empty_10.png'},
    {'name': 'resources/syringe_lab_2_full_11.png', 'path': 'resources/syringe_lab_2_full_11.png'},
    {'name': 'resources/syringe_lab_5_full_12.png', 'path': 'resources/syringe_lab_5_full_12.png'},
    {'name': 'resources/lab_background_27.png', 'path': 'resources/lab_background_27.png'},
    {'name': 'resources/syringe_lab_1_empty_9.png', 'path': 'resources/syringe_lab_1_empty_9.png'},
    {'name': 'resources/Introduction_German/Intro_Deutsch_10.png', 'path': 'resources/Introduction_German/Intro_Deutsch_10.png'},
    {'name': 'resources/syringe_lab_1_full_5.png', 'path': 'resources/syringe_lab_1_full_5.png'},
    {'name': 'resources/lab_background_30.png', 'path': 'resources/lab_background_30.png'},
    {'name': 'resources/Introduction_German/info_button_normal.png', 'path': 'resources/Introduction_German/info_button_normal.png'},
    {'name': 'resources/Introduction_English/Intro_English_2.png', 'path': 'resources/Introduction_English/Intro_English_2.png'},
    {'name': 'resources/Gallerie/Score_12.png', 'path': 'resources/Gallerie/Score_12.png'},
    {'name': 'resources/lab_background_21.png', 'path': 'resources/lab_background_21.png'},
    {'name': 'resources/syringe_lab_2_empty_4.png', 'path': 'resources/syringe_lab_2_empty_4.png'},
    {'name': 'resources/variable_sheets/lab2_syringes.xlsx', 'path': 'resources/variable_sheets/lab2_syringes.xlsx'},
    {'name': 'resources/syringe_lab_5_empty_10.png', 'path': 'resources/syringe_lab_5_empty_10.png'},
    {'name': 'resources/Language_Images/germany_flag.png', 'path': 'resources/Language_Images/germany_flag.png'},
    {'name': 'resources/lab_background_22.png', 'path': 'resources/lab_background_22.png'},
    {'name': 'resources/Gallerie/Score_1.png', 'path': 'resources/Gallerie/Score_1.png'},
    {'name': 'resources/Gallerie/Score_3.png', 'path': 'resources/Gallerie/Score_3.png'},
    {'name': 'resources/syringe_lab_2_empty_10.png', 'path': 'resources/syringe_lab_2_empty_10.png'},
    {'name': 'resources/scoreboard_lab_2.png', 'path': 'resources/scoreboard_lab_2.png'},
    {'name': 'resources/notepad_5.png', 'path': 'resources/notepad_5.png'},
    {'name': 'resources/Gallerie/Score_17.png', 'path': 'resources/Gallerie/Score_17.png'},
    {'name': 'resources/lab_background_18.png', 'path': 'resources/lab_background_18.png'},
    {'name': 'resources/Gallerie/Score_0.png', 'path': 'resources/Gallerie/Score_0.png'},
    {'name': 'resources/syringe_lab_1_empty_8.png', 'path': 'resources/syringe_lab_1_empty_8.png'},
    {'name': 'resources/syringe_lab_1_full_10.png', 'path': 'resources/syringe_lab_1_full_10.png'},
    {'name': 'resources/Introduction_German/Intro_Deutsch_3.png', 'path': 'resources/Introduction_German/Intro_Deutsch_3.png'},
    {'name': 'resources/syringe_lab_3_empty_8.png', 'path': 'resources/syringe_lab_3_empty_8.png'},
    {'name': 'resources/syringe_lab_3_empty_6.png', 'path': 'resources/syringe_lab_3_empty_6.png'},
    {'name': 'resources/Introduction_German/Intro_Deutsch_8.png', 'path': 'resources/Introduction_German/Intro_Deutsch_8.png'},
    {'name': 'resources/syringe_lab_2_empty_5.png', 'path': 'resources/syringe_lab_2_empty_5.png'},
    {'name': 'resources/syringe_lab_3_full_1.png', 'path': 'resources/syringe_lab_3_full_1.png'},
    {'name': 'resources/syringe_lab_1_full_12.png', 'path': 'resources/syringe_lab_1_full_12.png'},
    {'name': 'resources/scoreboard_lab_5.png', 'path': 'resources/scoreboard_lab_5.png'},
    {'name': 'resources/syringe_lab_4_empty_8.png', 'path': 'resources/syringe_lab_4_empty_8.png'},
    {'name': 'resources/Gallerie/Score_9.png', 'path': 'resources/Gallerie/Score_9.png'},
    {'name': 'resources/syringe_lab_3_empty_1.png', 'path': 'resources/syringe_lab_3_empty_1.png'},
    {'name': 'resources/Gallerie/Score_28.png', 'path': 'resources/Gallerie/Score_28.png'},
    {'name': 'resources/syringe_lab_1_full_11.png', 'path': 'resources/syringe_lab_1_full_11.png'},
    {'name': 'resources/notepad_2.png', 'path': 'resources/notepad_2.png'},
    {'name': 'resources/lab_background_15.png', 'path': 'resources/lab_background_15.png'},
    {'name': 'resources/syringe_lab_3_full_5.png', 'path': 'resources/syringe_lab_3_full_5.png'},
    {'name': 'resources/syringe_lab_1_empty_3.png', 'path': 'resources/syringe_lab_1_empty_3.png'},
    {'name': 'resources/syringe_lab_5_empty_1.png', 'path': 'resources/syringe_lab_5_empty_1.png'},
    {'name': 'resources/syringe_lab_4_empty_6.png', 'path': 'resources/syringe_lab_4_empty_6.png'},
    {'name': 'resources/Introduction_English/Intro_English_7.jpg', 'path': 'resources/Introduction_English/Intro_English_7.jpg'},
    {'name': 'resources/syringe_lab_3_empty_12.png', 'path': 'resources/syringe_lab_3_empty_12.png'},
    {'name': 'resources/lab_background_1.png', 'path': 'resources/lab_background_1.png'},
    {'name': 'resources/syringe_lab_2_empty_3.png', 'path': 'resources/syringe_lab_2_empty_3.png'},
    {'name': 'resources/lab_background_19.png', 'path': 'resources/lab_background_19.png'},
    {'name': 'resources/Gallerie/Score_30.png', 'path': 'resources/Gallerie/Score_30.png'},
    {'name': 'resources/syringe_lab_5_empty_4.png', 'path': 'resources/syringe_lab_5_empty_4.png'},
    {'name': 'resources/Gallerie/Score_26.png', 'path': 'resources/Gallerie/Score_26.png'},
    {'name': 'resources/syringe_lab_3_full_10.png', 'path': 'resources/syringe_lab_3_full_10.png'},
    {'name': 'resources/syringe_lab_5_full_4.png', 'path': 'resources/syringe_lab_5_full_4.png'},
    {'name': 'resources/syringe_lab_4_empty_9.png', 'path': 'resources/syringe_lab_4_empty_9.png'},
    {'name': 'resources/syringe_lab_5_full_1.png', 'path': 'resources/syringe_lab_5_full_1.png'},
    {'name': 'resources/lab_background_4.png', 'path': 'resources/lab_background_4.png'},
    {'name': 'resources/syringe_lab_1_empty_12.png', 'path': 'resources/syringe_lab_1_empty_12.png'},
    {'name': 'resources/syringe_lab_5_full_3.png', 'path': 'resources/syringe_lab_5_full_3.png'},
    {'name': 'resources/syringe_lab_1_empty_5.png', 'path': 'resources/syringe_lab_1_empty_5.png'},
    {'name': 'resources/Introduction_English/Intro_English_6.jpg', 'path': 'resources/Introduction_English/Intro_English_6.jpg'},
    {'name': 'resources/Gallerie/Score_4.png', 'path': 'resources/Gallerie/Score_4.png'},
    {'name': 'resources/Gallerie/Score_18.png', 'path': 'resources/Gallerie/Score_18.png'},
    {'name': 'resources/Introduction_English/Intro_English_3.png', 'path': 'resources/Introduction_English/Intro_English_3.png'},
    {'name': 'resources/syringe_lab_2_empty_7.png', 'path': 'resources/syringe_lab_2_empty_7.png'},
    {'name': 'resources/Introduction_English/Intro_English_4.jpg', 'path': 'resources/Introduction_English/Intro_English_4.jpg'},
    {'name': 'resources/notepad_4.png', 'path': 'resources/notepad_4.png'},
    {'name': 'resources/syringe_lab_5_empty_5.png', 'path': 'resources/syringe_lab_5_empty_5.png'},
    {'name': 'resources/syringe_lab_4_full_4.png', 'path': 'resources/syringe_lab_4_full_4.png'},
    {'name': 'resources/variable_sheets/ExperimenterOutputSheet.xlsx', 'path': 'resources/variable_sheets/ExperimenterOutputSheet.xlsx'},
    {'name': 'resources/lab_background_10.png', 'path': 'resources/lab_background_10.png'},
    {'name': 'resources/lab_background_2.png', 'path': 'resources/lab_background_2.png'},
    {'name': 'resources/lab_background_20.png', 'path': 'resources/lab_background_20.png'},
    {'name': 'resources/Introduction_English/Intro_English_9.png', 'path': 'resources/Introduction_English/Intro_English_9.png'},
    {'name': 'resources/variable_sheets/lab1_syringes.xlsx', 'path': 'resources/variable_sheets/lab1_syringes.xlsx'},
    {'name': 'resources/syringe_lab_4_full_12.png', 'path': 'resources/syringe_lab_4_full_12.png'},
    {'name': 'resources/Gallerie/Score_25.png', 'path': 'resources/Gallerie/Score_25.png'},
    {'name': 'resources/syringe_lab_5_empty_2.png', 'path': 'resources/syringe_lab_5_empty_2.png'},
    {'name': 'resources/variable_sheets/lab3_syringes.xlsx', 'path': 'resources/variable_sheets/lab3_syringes.xlsx'},
    {'name': 'resources/syringe_lab_3_empty_4.png', 'path': 'resources/syringe_lab_3_empty_4.png'},
    {'name': 'resources/variable_sheets/pathogenSheet.xlsx', 'path': 'resources/variable_sheets/pathogenSheet.xlsx'},
    {'name': 'resources/syringe_lab_1_full_1.png', 'path': 'resources/syringe_lab_1_full_1.png'},
    {'name': 'resources/variable_sheets/lab4_syringes.xlsx', 'path': 'resources/variable_sheets/lab4_syringes.xlsx'},
    {'name': 'resources/scoreboard_lab_1.png', 'path': 'resources/scoreboard_lab_1.png'},
    {'name': 'resources/lab_background_12.png', 'path': 'resources/lab_background_12.png'},
    {'name': 'resources/variable_sheets/general_setup_sheet.xlsx', 'path': 'resources/variable_sheets/general_setup_sheet.xlsx'},
    {'name': 'resources/syringe_lab_4_empty_12.png', 'path': 'resources/syringe_lab_4_empty_12.png'},
    {'name': 'resources/Gallerie/Score_10.png', 'path': 'resources/Gallerie/Score_10.png'},
    {'name': 'resources/Gallerie/Score_21.png', 'path': 'resources/Gallerie/Score_21.png'},
    {'name': 'resources/Gallerie/Score_8.png', 'path': 'resources/Gallerie/Score_8.png'},
    {'name': 'resources/Introduction_German/Intro_Deutsch_7.png', 'path': 'resources/Introduction_German/Intro_Deutsch_7.png'},
    {'name': 'resources/syringe_lab_4_full_1.png', 'path': 'resources/syringe_lab_4_full_1.png'},
    {'name': 'resources/syringe_lab_2_empty_12.png', 'path': 'resources/syringe_lab_2_empty_12.png'},
    {'name': 'resources/syringe_lab_5_empty_9.png', 'path': 'resources/syringe_lab_5_empty_9.png'},
    {'name': 'resources/Introduction_English/Intro_English_5.jpg', 'path': 'resources/Introduction_English/Intro_English_5.jpg'},
    {'name': 'resources/syringe_lab_5_empty_11.png', 'path': 'resources/syringe_lab_5_empty_11.png'},
    {'name': 'resources/syringe_lab_2_full_3.png', 'path': 'resources/syringe_lab_2_full_3.png'},
    {'name': 'resources/syringe_lab_3_full_4.png', 'path': 'resources/syringe_lab_3_full_4.png'},
    {'name': 'resources/Gallerie/Score_11.png', 'path': 'resources/Gallerie/Score_11.png'},
    {'name': 'resources/scoreboard_lab_4.png', 'path': 'resources/scoreboard_lab_4.png'},
    {'name': 'resources/lab_background_16.png', 'path': 'resources/lab_background_16.png'},
    {'name': 'resources/syringe_lab_5_full_6.png', 'path': 'resources/syringe_lab_5_full_6.png'},
    {'name': 'resources/syringe_lab_5_full_2.png', 'path': 'resources/syringe_lab_5_full_2.png'},
    {'name': 'resources/syringe_lab_2_empty_8.png', 'path': 'resources/syringe_lab_2_empty_8.png'},
    {'name': 'resources/syringe_lab_4_empty_11.png', 'path': 'resources/syringe_lab_4_empty_11.png'},
    {'name': 'resources/syringe_lab_1_empty_6.png', 'path': 'resources/syringe_lab_1_empty_6.png'},
    {'name': 'resources/syringe_lab_3_empty_3.png', 'path': 'resources/syringe_lab_3_empty_3.png'},
    {'name': 'resources/syringe_lab_2_full_6.png', 'path': 'resources/syringe_lab_2_full_6.png'},
    {'name': 'resources/coin.png', 'path': 'resources/coin.png'},
    {'name': 'resources/syringe_lab_1_full_3.png', 'path': 'resources/syringe_lab_1_full_3.png'},
    {'name': 'resources/syringe_lab_3_empty_7.png', 'path': 'resources/syringe_lab_3_empty_7.png'},
    {'name': 'resources/Introduction_English/Intro_English_10.png', 'path': 'resources/Introduction_English/Intro_English_10.png'},
    {'name': 'resources/syringe_lab_3_full_7.png', 'path': 'resources/syringe_lab_3_full_7.png'},
    {'name': 'resources/lab_background_17.png', 'path': 'resources/lab_background_17.png'},
    {'name': 'resources/syringe_lab_5_full_5.png', 'path': 'resources/syringe_lab_5_full_5.png'},
    {'name': 'resources/Introduction_German/Intro_Deutsch_6.png', 'path': 'resources/Introduction_German/Intro_Deutsch_6.png'},
    {'name': 'resources/syringe_lab_4_empty_5.png', 'path': 'resources/syringe_lab_4_empty_5.png'},
    {'name': 'resources/Gallerie/Score_2.png', 'path': 'resources/Gallerie/Score_2.png'},
    {'name': 'resources/lab_background_14.png', 'path': 'resources/lab_background_14.png'},
    {'name': 'resources/lab_background_25.png', 'path': 'resources/lab_background_25.png'},
    {'name': 'resources/syringe_lab_4_full_7.png', 'path': 'resources/syringe_lab_4_full_7.png'},
    {'name': 'resources/syringe_lab_2_full_2.png', 'path': 'resources/syringe_lab_2_full_2.png'},
    {'name': 'resources/syringe_lab_3_full_8.png', 'path': 'resources/syringe_lab_3_full_8.png'},
    {'name': 'resources/syringe_lab_3_empty_9.png', 'path': 'resources/syringe_lab_3_empty_9.png'},
    {'name': 'resources/Introduction_English/Intro_English_8.png', 'path': 'resources/Introduction_English/Intro_English_8.png'},
    {'name': 'resources/syringe_lab_2_empty_9.png', 'path': 'resources/syringe_lab_2_empty_9.png'},
    {'name': 'resources/lab_background_5.png', 'path': 'resources/lab_background_5.png'},
    {'name': 'resources/syringe_lab_4_empty_4.png', 'path': 'resources/syringe_lab_4_empty_4.png'},
    {'name': 'resources/syringe_lab_2_full_7.png', 'path': 'resources/syringe_lab_2_full_7.png'},
    {'name': 'resources/syringe_lab_1_full_8.png', 'path': 'resources/syringe_lab_1_full_8.png'},
    {'name': 'resources/syringe_lab_1_empty_1.png', 'path': 'resources/syringe_lab_1_empty_1.png'},
    {'name': 'resources/syringe_lab_1_full_7.png', 'path': 'resources/syringe_lab_1_full_7.png'},
    {'name': 'resources/syringe_lab_2_full_5.png', 'path': 'resources/syringe_lab_2_full_5.png'},
    {'name': 'resources/syringe_lab_4_full_9.png', 'path': 'resources/syringe_lab_4_full_9.png'},
    {'name': 'resources/lab_background_26.png', 'path': 'resources/lab_background_26.png'},
    {'name': 'resources/wrong.png', 'path': 'resources/wrong.png'},
    {'name': 'resources/Gallerie/Score_24.png', 'path': 'resources/Gallerie/Score_24.png'},
    {'name': 'resources/syringe_lab_2_empty_11.png', 'path': 'resources/syringe_lab_2_empty_11.png'},
    {'name': 'resources/syringe_lab_5_full_8.png', 'path': 'resources/syringe_lab_5_full_8.png'},
    {'name': 'resources/syringe_lab_2_full_12.png', 'path': 'resources/syringe_lab_2_full_12.png'},
    {'name': 'resources/lab_background_23.png', 'path': 'resources/lab_background_23.png'},
    {'name': 'resources/syringe_lab_4_full_11.png', 'path': 'resources/syringe_lab_4_full_11.png'},
    {'name': 'resources/syringe_lab_4_full_2.png', 'path': 'resources/syringe_lab_4_full_2.png'},
    {'name': 'resources/variable_sheets/outputSheet.xlsx', 'path': 'resources/variable_sheets/outputSheet.xlsx'},
    {'name': 'resources/syringe_lab_2_full_4.png', 'path': 'resources/syringe_lab_2_full_4.png'},
    {'name': 'resources/Introduction_English/info_button_pressed.png', 'path': 'resources/Introduction_English/info_button_pressed.png'},
    {'name': 'resources/syringe_lab_1_empty_7.png', 'path': 'resources/syringe_lab_1_empty_7.png'},
    {'name': 'resources/notepad_3.png', 'path': 'resources/notepad_3.png'},
    {'name': 'resources/Introduction_English/info_button_normal.png', 'path': 'resources/Introduction_English/info_button_normal.png'},
    {'name': 'resources/lab_background_8.png', 'path': 'resources/lab_background_8.png'},
    {'name': 'resources/Gallerie/Score_19.png', 'path': 'resources/Gallerie/Score_19.png'},
    {'name': 'resources/syringe_lab_2_empty_2.png', 'path': 'resources/syringe_lab_2_empty_2.png'},
    {'name': 'resources/syringe_lab_4_full_3.png', 'path': 'resources/syringe_lab_4_full_3.png'},
    {'name': 'resources/lab_background_28.png', 'path': 'resources/lab_background_28.png'},
    {'name': 'resources/syringe_lab_4_full_6.png', 'path': 'resources/syringe_lab_4_full_6.png'},
    {'name': 'resources/Introduction_German/Intro_Deutsch_1.png', 'path': 'resources/Introduction_German/Intro_Deutsch_1.png'},
    {'name': 'resources/syringe_lab_3_full_11.png', 'path': 'resources/syringe_lab_3_full_11.png'},
    {'name': 'resources/gallery_background.png', 'path': 'resources/gallery_background.png'},
    {'name': 'resources/syringe_lab_3_empty_10.png', 'path': 'resources/syringe_lab_3_empty_10.png'},
    {'name': 'resources/Gallerie/Score_29.png', 'path': 'resources/Gallerie/Score_29.png'},
    {'name': 'resources/syringe_lab_1_full_6.png', 'path': 'resources/syringe_lab_1_full_6.png'},
    {'name': 'resources/variable_sheets/lab5_syringes.xlsx', 'path': 'resources/variable_sheets/lab5_syringes.xlsx'},
    {'name': 'resources/syringe_lab_5_empty_12.png', 'path': 'resources/syringe_lab_5_empty_12.png'},
    {'name': 'resources/Gallerie/Score_15.png', 'path': 'resources/Gallerie/Score_15.png'},
    {'name': 'resources/syringe_lab_5_empty_7.png', 'path': 'resources/syringe_lab_5_empty_7.png'},
    {'name': 'resources/syringe_lab_5_empty_3.png', 'path': 'resources/syringe_lab_5_empty_3.png'},
    {'name': 'resources/scoreboard_lab_3.png', 'path': 'resources/scoreboard_lab_3.png'},
    {'name': 'resources/syringe_lab_1_full_2.png', 'path': 'resources/syringe_lab_1_full_2.png'},
    {'name': 'resources/Introduction_German/Intro_Deutsch_4.png', 'path': 'resources/Introduction_German/Intro_Deutsch_4.png'},
    {'name': 'resources/syringe_lab_1_empty_11.png', 'path': 'resources/syringe_lab_1_empty_11.png'},
    {'name': 'resources/syringe_lab_5_full_11.png', 'path': 'resources/syringe_lab_5_full_11.png'},
    {'name': 'resources/lab_background_29.png', 'path': 'resources/lab_background_29.png'},
    {'name': 'resources/Gallerie/Score_5.png', 'path': 'resources/Gallerie/Score_5.png'},
    {'name': 'resources/syringe_lab_3_full_2.png', 'path': 'resources/syringe_lab_3_full_2.png'},
    {'name': 'resources/syringe_lab_2_empty_6.png', 'path': 'resources/syringe_lab_2_empty_6.png'},
    {'name': 'resources/Language_Images/uk_flag.png', 'path': 'resources/Language_Images/uk_flag.png'},
    {'name': 'resources/lab_background_7.png', 'path': 'resources/lab_background_7.png'},
    {'name': 'resources/lab_background_3.png', 'path': 'resources/lab_background_3.png'},
    {'name': 'resources/Introduction_English/Intro_English_1.png', 'path': 'resources/Introduction_English/Intro_English_1.png'},
    {'name': 'resources/Gallerie/Score_13.png', 'path': 'resources/Gallerie/Score_13.png'},
    {'name': 'resources/correct.png', 'path': 'resources/correct.png'},
    {'name': 'resources/notepad_1.png', 'path': 'resources/notepad_1.png'},
    {'name': 'resources/syringe_lab_4_full_5.png', 'path': 'resources/syringe_lab_4_full_5.png'},
    {'name': 'resources/syringe_lab_2_full_10.png', 'path': 'resources/syringe_lab_2_full_10.png'},
    {'name': 'resources/syringe_lab_4_empty_3.png', 'path': 'resources/syringe_lab_4_empty_3.png'},
    {'name': 'resources/syringe_lab_5_full_9.png', 'path': 'resources/syringe_lab_5_full_9.png'},
    {'name': 'resources/Introduction_English/TitleScreen.png', 'path': 'resources/Introduction_English/TitleScreen.png'},
    {'name': 'resources/syringe_lab_3_empty_5.png', 'path': 'resources/syringe_lab_3_empty_5.png'},
    {'name': 'resources/syringe_lab_3_empty_11.png', 'path': 'resources/syringe_lab_3_empty_11.png'}
  ]
});

psychoJS.experimentLogger.setLevel(core.Logger.ServerLevel.EXP);


var currentLoop;
var frameDur;
async function updateInfo() {
  currentLoop = psychoJS.experiment;  // right now there are no loops
  expInfo['date'] = util.MonotonicClock.getDateStr();  // add a simple timestamp
  expInfo['expName'] = expName;
  expInfo['psychopyVersion'] = '2022.2.3';
  expInfo['OS'] = window.navigator.platform;

  psychoJS.experiment.dataFileName = (("." + "/") + `data/${expInfo["participant"]}_${expName}_${expInfo["date"]}`);

  // store frame rate of monitor if we can measure it successfully
  expInfo['frameRate'] = psychoJS.window.getActualFrameRate();
  if (typeof expInfo['frameRate'] !== 'undefined')
    frameDur = 1.0 / Math.round(expInfo['frameRate']);
  else
    frameDur = 1.0 / 60.0; // couldn't get a reliable measure so guess

  // add info from the URL:
  util.addInfoFromUrl(expInfo);
  
  return Scheduler.Event.NEXT;
}


var initializingClock;
var existing_participants;
var neverPlayed;
var alreadyPlayed;
var session_n;
var score_n;
var round_n;
var session_number;
var scoreboardAdjustingSizeX;
var scoreboardAdjustingSizeY;
var scoreboardAdjustingX;
var scoreboardAdjustingY;
var notepadAdjustingX;
var level_n;
var notepad_xy_ratio;
var nTrials;
var allProbabilities;
var antiProbabilities;
var differences;
var goodRun;
var totalCount;
var currentDate;
var currentDay;
var currentTime;
var experimenter_mode;
var timeToWait;
var canPlay;
var cantPlay;
var cantPlayReason;
var timesPlayed;
var chooseLanguageClock;
var emptyBackground;
var germanFlag;
var englishFlag;
var languageText;
var languageChoiceClick;
var languageClickedButtonClock;
var emptyBackground_2;
var circleFlag;
var circleFlag_2;
var germanFlag_2;
var englishFlag_2;
var languageText_2;
var textAssignmentClock;
var timingIssueClock;
var emptyBackground_5;
var okayButton;
var buttonTextBlock;
var okayClick;
var informationTextbox;
var generalLoaderLoopClock;
var scenes_list;
var notepadImage_list;
var scoreboardImage_list;
var syringeTypeSheet_list;
var generalLoaderClock;
var syringeLoaderLoopClock;
var emptySyringes_list;
var fullSyringes_list;
var syringeColor_list;
var syringeLoaderClock;
var Rules1Clock;
var introductionScreen;
var continueButton1;
var continueTextBlock;
var continueClick_1;
var Rules2Clock;
var introductionScreen_2;
var continueButton2;
var continueTextBlock_2;
var continueClick_2;
var Rules3Clock;
var introductionScreen_3;
var continueButton3;
var continueTextBlock_3;
var continueClick_3;
var Rules4Clock;
var introductionScreen_4;
var continueButton4;
var continueTextBlock_4;
var continueClick_4;
var Rules5Clock;
var introductionScreen_5;
var continueButton5;
var continueTextBlock_5;
var continueClick_5;
var Rules6Clock;
var introductionScreen_6;
var continueButton6;
var continueTextBlock_6;
var continueClick_6;
var Rules7Clock;
var introductionScreen_7;
var continueButton7;
var continueTextBlock_7;
var continueClick_7;
var Rules8Clock;
var introductionScreen_8;
var continueButton8;
var continueTextBlock_8;
var continueClick_8;
var Rules9Clock;
var introductionScreen_9;
var continueButton9;
var continueTextBlock_9;
var continueClick_9;
var Rules10Clock;
var introductionScreen_10;
var continueButton10;
var continueTextBlock_10;
var continueClick_10;
var IntroductionClock;
var titleScreen;
var playButton;
var playTextBlock;
var playClick;
var IntroductionButtonPressedClock;
var titleScreen_2;
var playButton_2;
var playTextBlock_2;
var beginningScreenClock;
var emptyBackground_4;
var languageText_4;
var SetupTheSceneClock;
var backgroundImage;
var leftNotepad;
var rightNotepad;
var scoreboardImage;
var trialSetupClock;
var correctChoicesList;
var currentTrial;
var rewardBackgroundCircle;
var leftSyringe;
var rightSyringe;
var leftNoteText;
var rightNoteText;
var scoreBoardTextbox;
var syringeChoice;
var keyChoice;
var trialFeedbackClock;
var rewardBackgroundCircle_2;
var leftSyringe_2;
var rightSyringe_2;
var leftNoteText_2;
var rightNoteText_2;
var scoreBoardTextbox_2;
var leftLabFeedback_2;
var rightLabFeedback_2;
var trialOutputClock;
var leftNotepad_2;
var rightNotepad_2;
var leftSyringe_3;
var rightSyringe_3;
var coinCircle;
var rewardImage;
var leftNoteText_1;
var rightNoteText_1;
var continueButtonBackground;
var continueButtonText;
var scoreBoardTextbox_3;
var continueClick;
var buttonPressedTrialClock;
var leftSyringe_4;
var rightSyringe_4;
var coinCircle_2;
var rewardImage_2;
var leftNoteText_3;
var rightNoteText_3;
var continueButtonBackground_2;
var continueButtonText_2;
var scoreBoardTextbox_4;
var endingScreenClock;
var emptyBackground_3;
var languageText_3;
var deleteTheSceneClock;
var gallery;
var galleryTextBox;
var endGameButton;
var endGameTextBox;
var lastClickofGame;
var savingDataClock;
var globalClock;
var routineTimer;
async function experimentInit() {
  // Initialize components for Routine "initializing"
  initializingClock = new util.Clock();
  //Accessing participant information from Pavlovia shelf
  // ----------------------------------------------------------------------------------------------------------
  
  //get a list of all currently existing participants in the Pavlovia shelf
  //designer shelf using the key: "Influenca_session_tracker"
  existing_participants = await psychoJS.shelf.getDictionaryFieldNames({key: ["Influenca_session_tracker", "@designer"], defaultValue:[]});
  
  
  //participant is playing for the first time --> start at level 1, score = 0, show instructions
  if(!existing_participants.includes(expInfo['participant'])){
      
      //show instructions and skip the alternative introduction screen
      neverPlayed = 1;
      alreadyPlayed = 0; 
      
      session_n = 1; 
      score_n = 0;
  
      }else{ //participant has already played before, load saved data, skip instructions
          
          alreadyPlayed = 1; 
          neverPlayed = 0; 
          
          //access players' data from shelf and store in global variables
          session_data = await psychoJS.shelf.getDictionaryFieldValue({key: ["Influenca_session_tracker", "@designer"], fieldName: expInfo['participant'], defaultValue:'no sessions detected'})
          
          session_n = session_data[0] + 1; //raise session_n by 1 to start new level
          score_n = session_data[1]; 
          languageChoice = session_data[2];
          lastDayPlayed = session_data[3];
          lastTimePlayed = session_data[4];
          timesPlayed = session_data[5];
      }
  
  round_n = 1; //always start with round 1
  
  
  
  //Reset all participant data at session 5 --> start over from the beginning
  // ----------------------------------------------------------------------------------------------------------
  session_number = expInfo['session number']; 
  
  if (session_number == 5){
      alreadyPlayed = 0;
      neverPlayed = 1; 
      session_n = 1;
      score_n = 0;
      }
  
  
  //Assigning different sizes for all assets based on the current session and used device
  // ----------------------------------------------------------------------------------------------------------
  
  //force full screen on mobile devices
  if (mobile_device === true){
      psychoJS.window.fullscr = true;
      psychoJS.window.adjustScreenSize();
      }
  
  //declare standard sizes for all assets
  scoreboardAdjustingSizeX = 1;
  scoreboardAdjustingSizeY = 1;
  scoreboardAdjustingX = 0;
  scoreboardAdjustingY = 0;
  notepadAdjustingX = 0;
  
  //choose which level to play based on the current session_n, and adjust all asset sizes
  //each level consists of 6 distinct scenes
  
  if (session_n <= 6){
      level_n = 1;
      notepad_xy_ratio = 400/438;
      scoreboardAdjustingSizeY = 0.8;
      scoreboardAdjustingSizeX = 0.9;
      scoreboardAdjustingX = 0.008;
      scoreboardAdjustingY = 0;
  }
  if (session_n > 6 && session_n <= 12){
      level_n = 2;
      notepad_xy_ratio = 400/533;
      notepadAdjustingX = -0.01;
      scoreboardAdjustingSizeY = 0.8;
      scoreboardAdjustingSizeX = 0.9;
      scoreboardAdjustingX = 0.008;
  }
  if (session_n > 12 && session_n <= 18){
      level_n = 3;
      notepad_xy_ratio = 400/595;
      notepadAdjustingX = -0.01;
      scoreboardAdjustingSizeY = 0.85;
      scoreboardAdjustingSizeX = 0.95;
      scoreboardAdjustingX = 0.007;
  }
  if (session_n > 18 && session_n <= 24){
      level_n = 4;
      notepad_xy_ratio = 400/580;
      notepadAdjustingX = -0.007;
      scoreboardAdjustingSizeX = 0.9;
      scoreboardAdjustingX = 0.008;
  }
  if (session_n > 24){
      level_n = 5;
      notepad_xy_ratio = 400/581;
      notepadAdjustingX = -0.01;
      scoreboardAdjustingSizeY = 0.8;
      scoreboardAdjustingSizeX = 0.9;
      scoreboardAdjustingX = 0.008;
  }
  
  //Calculation of probabilities for the session
  // ----------------------------------------------------------------------------------------------------------
  
  nTrials = 150; //number of trials for each session
  
  //declare all-zero arrays for probabilities, antiprobabilities, and probability differences
  allProbabilities = new Array(nTrials).fill(0);
  antiProbabilities = new Array(nTrials).fill(0);
  differences = new Array(nTrials).fill(0);
  
  goodRun = false; //boolean to decide whether or not probabilities were created successfully
  totalCount = 0; //tracker to not get stuck in while loop
  var i;
  var d;
  
  while (((goodRun === false) && (totalCount < 100))) { //try until probabilities are satisfactory
      totalDifferences = 0; //reset total differences to zero for each new calculation
      for (i = 0; i < nTrials; i++) { //for all trials
          
          if(i === 0){ //initial probabilities
              allProbabilities[i] = weighted_random([0.2, 0.8], [0.5, 0.5]); //set randomly to 0.2 or 0.8
                      
          }else{
              step = getNormallyDistributedRandomNumber(0, 1) * 0.1; //generate a step from a normally distributed random number, multiplied by 0.1 to decrease step size
              
              count = 0; //tracker to avoid getting stuck in while loop
              
              //recalculate step size if probabilities would get out of bounds
              while (allProbabilities[i-1] + step - 0.03 * (allProbabilities[i-1] - 0.5) < 0 || allProbabilities[i-1] + step - 0.03 * (allProbabilities[i-1] - 0.5) > 1 && count < 100){
                  step = getNormallyDistributedRandomNumber(0, 1) * 0.1;
                  count = count + 1;            
              }
          
          //calculate and round probabilities
          allProbabilities[i] = Math.round((allProbabilities[i-1] + step - 0.03 * (allProbabilities[i-1] - 0.5))*100)/100;
          }
          //calculate and round anti probabilities (1 - probabilities)
          antiProbabilities[i] = Math.round((1 - allProbabilities[i])*100)/100;
          //calculate absolute differences between probabilities and anti probabilities
          differences[i] = Math.round((Math.abs(allProbabilities[i] - antiProbabilities[i]))*100)/100;
      }
      
      for(d = 0; d < nTrials; d++){ //for all trials
          totalDifferences = totalDifferences + differences[d]; //calculate the sum of all differences
      }
  
      meanDifferences = totalDifferences/nTrials //calculate mean of all differences
      
      if (meanDifferences >= 0.44 && meanDifferences <= 0.46){ //if mean of differences lies within 0.44 and 0.46
          goodRun = true; //probabilities are satisfactory --> will be accepted, otherwise: redo entire calculation
      }
  
      totalCount = totalCount + 1;
  }
  
  
  //Get the current date and time
  // ----------------------------------------------------------------------------------------------------------
  
  currentDate = new Date();
  currentDay = [parseInt(String(currentDate.getDate()).padStart(2, '0')), currentDate.getMonth()+1, currentDate.getFullYear()]; 
  currentTime = [currentDate.getHours(), currentDate.getMinutes()];
  
  //save level and score in shelf
  //psychoJS.shelf.setDictionaryFieldValue({key: ["Influenca_session_tracker", "@designer"], fieldName: expInfo['participant'], fieldValue: [session_n, score_n, languageChoice, currentDay, currentTime, timesPlayed]});
  
  
  experimenter_mode = expInfo['experimenter mode'];
  
  if(experimenter_mode == 1){
      timeToWait = 0.1;
      }
  else if (experimenter_mode == 0){
      timeToWait = 1;
      }
  
      
  
  if (timesPlayed >= 2 && lastDayPlayed[0] == currentDay[0] && lastDayPlayed[1] == currentDay[1] && lastDayPlayed[2] == currentDay[2]){ //if they have already played three times today
      canPlay = 0; //they cannot play again
      cantPlay = 1;
      cantPlayReason = "day";
      }
  
  else if(timesPlayed >= 2 && lastDayPlayed[0] != currentDay[0]){ //if they played more than twice but on another day, they can play again today
      timesPlayed = 0; //reset number of times played 
      canPlay = 1;
      cantPlay = 0;
      }
  
  if (canPlay != 0){ //if they haven't played three times yet, check if they've played at all today
      if (lastDayPlayed[0] == currentDay[0] && lastDayPlayed[1] == currentDay[1] && lastDayPlayed[2] == currentDay[2]){
          timesPlayed = timesPlayed + 1; //increase times played today
          
          //check time difference between current time and last time played
          var timeDifference = (currentTime[0] + currentTime[1]/60) - (lastTimePlayed[0] + lastTimePlayed[1]/60);
          
          if (timeDifference < timeToWait){ //has it been long enough?
              canPlay = 0;
              cantPlay = 1;
              cantPlayReason = "time";
              }
          }
      }
  // Initialize components for Routine "chooseLanguage"
  chooseLanguageClock = new util.Clock();
  emptyBackground = new visual.ImageStim({
    win : psychoJS.window,
    name : 'emptyBackground', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [2, 1],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  germanFlag = new visual.ImageStim({
    win : psychoJS.window,
    name : 'germanFlag', units : undefined, 
    image : 'resources/Language_Images/germany_flag.png', mask : undefined,
    ori : 0.0, pos : [(- 0.4), (- 0.15)], size : [0.3, 0.3],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  englishFlag = new visual.ImageStim({
    win : psychoJS.window,
    name : 'englishFlag', units : undefined, 
    image : 'resources/Language_Images/uk_flag.png', mask : undefined,
    ori : 0.0, pos : [0.4, (- 0.15)], size : [0.3, 0.3],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -2.0 
  });
  languageText = new visual.TextStim({
    win: psychoJS.window,
    name: 'languageText',
    text: 'Wähle eine Sprache aus - \nChoose a language',
    font: 'Open Sans',
    units: undefined, 
    pos: [0, 0.15], height: 0.07,  wrapWidth: undefined, ori: 0.0,
    languageStyle: 'LTR',
    color: new util.Color('black'),  opacity: undefined,
    depth: -3.0 
  });
  
  languageChoiceClick = new core.Mouse({
    win: psychoJS.window,
  });
  languageChoiceClick.mouseClock = new util.Clock();
  // Initialize components for Routine "languageClickedButton"
  languageClickedButtonClock = new util.Clock();
  emptyBackground_2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'emptyBackground_2', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [2, 1],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  circleFlag = new visual.Polygon({
    win: psychoJS.window, name: 'circleFlag', 
    edges: 100, size:[1.0, 1.0],
    ori: 0.0, pos: [0, 0],
    lineWidth: undefined, 
    colorSpace: 'rgb',
    lineColor: new util.Color('limegreen'),
    fillColor: new util.Color('limegreen'),
    opacity: undefined, depth: -2, interpolate: true,
  });
  
  circleFlag_2 = new visual.Polygon({
    win: psychoJS.window, name: 'circleFlag_2', 
    edges: 100, size:[1.0, 1.0],
    ori: 0.0, pos: [0, 0],
    lineWidth: undefined, 
    colorSpace: 'rgb',
    lineColor: new util.Color('limegreen'),
    fillColor: new util.Color('limegreen'),
    opacity: undefined, depth: -3, interpolate: true,
  });
  
  germanFlag_2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'germanFlag_2', units : undefined, 
    image : 'resources/Language_Images/germany_flag.png', mask : undefined,
    ori : 0.0, pos : [(- 0.4), (- 0.15)], size : [0.3, 0.3],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -4.0 
  });
  englishFlag_2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'englishFlag_2', units : undefined, 
    image : 'resources/Language_Images/uk_flag.png', mask : undefined,
    ori : 0.0, pos : [0.4, (- 0.15)], size : [0.3, 0.3],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -5.0 
  });
  languageText_2 = new visual.TextStim({
    win: psychoJS.window,
    name: 'languageText_2',
    text: 'Wähle eine Sprache aus - \nChoose a language',
    font: 'Open Sans',
    units: undefined, 
    pos: [0, 0.15], height: 0.07,  wrapWidth: undefined, ori: 0.0,
    languageStyle: 'LTR',
    color: new util.Color('black'),  opacity: undefined,
    depth: -6.0 
  });
  
  // Initialize components for Routine "textAssignment"
  textAssignmentClock = new util.Clock();
  // Initialize components for Routine "timingIssue"
  timingIssueClock = new util.Clock();
  emptyBackground_5 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'emptyBackground_5', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [2, 1],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  okayButton = new visual.ImageStim({
    win : psychoJS.window,
    name : 'okayButton', units : undefined, 
    image : 'resources/Introduction_English/info_button_normal.png', mask : undefined,
    ori : 0.0, pos : [0, (- 0.25)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  buttonTextBlock = new visual.TextBox({
    win: psychoJS.window,
    name: 'buttonTextBlock',
    text: 'okay',
    font: 'Arial',
    pos: [0.02, (- 0.25)], letterHeight: 0.03,
    size: [0.3, (0.065 * yrange)],  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  okayClick = new core.Mouse({
    win: psychoJS.window,
  });
  okayClick.mouseClock = new util.Clock();
  informationTextbox = new visual.TextBox({
    win: psychoJS.window,
    name: 'informationTextbox',
    text: '',
    font: 'Arial',
    pos: [0, 0.1], letterHeight: 0.065,
    size: [1, 1],  units: undefined, 
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -4.0 
  });
  
  // Initialize components for Routine "generalLoaderLoop"
  generalLoaderLoopClock = new util.Clock();
  //declare empty lists for all relevant images and the variable sheets for the scene setup
  scenes_list = [];
  notepadImage_list = [];
  scoreboardImage_list = [];
  syringeTypeSheet_list = [];
  
  // Initialize components for Routine "generalLoader"
  generalLoaderClock = new util.Clock();
  // Initialize components for Routine "syringeLoaderLoop"
  syringeLoaderLoopClock = new util.Clock();
  //declare empty lists for syringe images
  emptySyringes_list = [];
  fullSyringes_list = [];
  syringeColor_list = [];
  
  // Initialize components for Routine "syringeLoader"
  syringeLoaderClock = new util.Clock();
  // Initialize components for Routine "Rules1"
  Rules1Clock = new util.Clock();
  introductionScreen = new visual.ImageStim({
    win : psychoJS.window,
    name : 'introductionScreen', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [1.88, 0.94],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  continueButton1 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'continueButton1', units : undefined, 
    image : 'resources/Introduction_English/info_button_normal.png', mask : undefined,
    ori : 0.0, pos : [0, (- 0.4)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  continueTextBlock = new visual.TextBox({
    win: psychoJS.window,
    name: 'continueTextBlock',
    text: '',
    font: 'Arial',
    pos: [0.02, (- 0.4)], letterHeight: 0.03,
    size: [0.3, (0.06 * yrange)],  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  continueClick_1 = new core.Mouse({
    win: psychoJS.window,
  });
  continueClick_1.mouseClock = new util.Clock();
  // Initialize components for Routine "Rules2"
  Rules2Clock = new util.Clock();
  introductionScreen_2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'introductionScreen_2', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [1.88, 0.94],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  continueButton2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'continueButton2', units : undefined, 
    image : 'resources/Introduction_English/info_button_normal.png', mask : undefined,
    ori : 0.0, pos : [0, (- 0.4)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  continueTextBlock_2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'continueTextBlock_2',
    text: '',
    font: 'Arial',
    pos: [0.02, (- 0.4)], letterHeight: 0.03,
    size: [0.3, (0.06 * yrange)],  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  continueClick_2 = new core.Mouse({
    win: psychoJS.window,
  });
  continueClick_2.mouseClock = new util.Clock();
  // Initialize components for Routine "Rules3"
  Rules3Clock = new util.Clock();
  introductionScreen_3 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'introductionScreen_3', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [1.88, 0.94],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  continueButton3 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'continueButton3', units : undefined, 
    image : 'resources/Introduction_English/info_button_normal.png', mask : undefined,
    ori : 0.0, pos : [0, (- 0.4)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  continueTextBlock_3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'continueTextBlock_3',
    text: '',
    font: 'Arial',
    pos: [0.02, (- 0.4)], letterHeight: 0.03,
    size: [0.3, (0.06 * yrange)],  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  continueClick_3 = new core.Mouse({
    win: psychoJS.window,
  });
  continueClick_3.mouseClock = new util.Clock();
  // Initialize components for Routine "Rules4"
  Rules4Clock = new util.Clock();
  introductionScreen_4 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'introductionScreen_4', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [1.88, 0.94],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  continueButton4 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'continueButton4', units : undefined, 
    image : 'resources/Introduction_English/info_button_normal.png', mask : undefined,
    ori : 0.0, pos : [0.4, (- 0.4)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  continueTextBlock_4 = new visual.TextBox({
    win: psychoJS.window,
    name: 'continueTextBlock_4',
    text: '',
    font: 'Arial',
    pos: [0.42, (- 0.4)], letterHeight: 0.03,
    size: [0.3, (0.06 * yrange)],  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  continueClick_4 = new core.Mouse({
    win: psychoJS.window,
  });
  continueClick_4.mouseClock = new util.Clock();
  // Initialize components for Routine "Rules5"
  Rules5Clock = new util.Clock();
  introductionScreen_5 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'introductionScreen_5', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [1.88, 0.94],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  continueButton5 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'continueButton5', units : undefined, 
    image : 'resources/Introduction_English/info_button_normal.png', mask : undefined,
    ori : 0.0, pos : [0, (- 0.4)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  continueTextBlock_5 = new visual.TextBox({
    win: psychoJS.window,
    name: 'continueTextBlock_5',
    text: '',
    font: 'Arial',
    pos: [0.02, (- 0.4)], letterHeight: 0.03,
    size: [0.3, (0.06 * yrange)],  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  continueClick_5 = new core.Mouse({
    win: psychoJS.window,
  });
  continueClick_5.mouseClock = new util.Clock();
  // Initialize components for Routine "Rules6"
  Rules6Clock = new util.Clock();
  introductionScreen_6 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'introductionScreen_6', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [1.79, 0.92],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  continueButton6 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'continueButton6', units : undefined, 
    image : 'resources/Introduction_English/info_button_normal.png', mask : undefined,
    ori : 0.0, pos : [0, (- 0.4)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  continueTextBlock_6 = new visual.TextBox({
    win: psychoJS.window,
    name: 'continueTextBlock_6',
    text: '',
    font: 'Arial',
    pos: [0.02, (- 0.4)], letterHeight: 0.03,
    size: [0.3, (0.06 * yrange)],  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  continueClick_6 = new core.Mouse({
    win: psychoJS.window,
  });
  continueClick_6.mouseClock = new util.Clock();
  // Initialize components for Routine "Rules7"
  Rules7Clock = new util.Clock();
  introductionScreen_7 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'introductionScreen_7', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [1.88, 0.94],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  continueButton7 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'continueButton7', units : undefined, 
    image : 'resources/Introduction_English/info_button_normal.png', mask : undefined,
    ori : 0.0, pos : [0, (- 0.4)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  continueTextBlock_7 = new visual.TextBox({
    win: psychoJS.window,
    name: 'continueTextBlock_7',
    text: '',
    font: 'Arial',
    pos: [0.02, (- 0.4)], letterHeight: 0.03,
    size: [0.3, (0.06 * yrange)],  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  continueClick_7 = new core.Mouse({
    win: psychoJS.window,
  });
  continueClick_7.mouseClock = new util.Clock();
  // Initialize components for Routine "Rules8"
  Rules8Clock = new util.Clock();
  introductionScreen_8 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'introductionScreen_8', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [1.88, 0.94],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  continueButton8 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'continueButton8', units : undefined, 
    image : 'resources/Introduction_English/info_button_normal.png', mask : undefined,
    ori : 0.0, pos : [0.6, (- 0.4)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  continueTextBlock_8 = new visual.TextBox({
    win: psychoJS.window,
    name: 'continueTextBlock_8',
    text: '',
    font: 'Arial',
    pos: [0.62, (- 0.4)], letterHeight: 0.03,
    size: [0.3, (0.06 * yrange)],  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  continueClick_8 = new core.Mouse({
    win: psychoJS.window,
  });
  continueClick_8.mouseClock = new util.Clock();
  // Initialize components for Routine "Rules9"
  Rules9Clock = new util.Clock();
  introductionScreen_9 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'introductionScreen_9', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [1.88, 0.94],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  continueButton9 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'continueButton9', units : undefined, 
    image : 'resources/Introduction_English/info_button_normal.png', mask : undefined,
    ori : 0.0, pos : [0, (- 0.4)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  continueTextBlock_9 = new visual.TextBox({
    win: psychoJS.window,
    name: 'continueTextBlock_9',
    text: '',
    font: 'Arial',
    pos: [0.02, (- 0.4)], letterHeight: 0.03,
    size: [0.3, (0.06 * yrange)],  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  continueClick_9 = new core.Mouse({
    win: psychoJS.window,
  });
  continueClick_9.mouseClock = new util.Clock();
  // Initialize components for Routine "Rules10"
  Rules10Clock = new util.Clock();
  introductionScreen_10 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'introductionScreen_10', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [1.88, 0.94],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  continueButton10 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'continueButton10', units : undefined, 
    image : 'resources/Introduction_English/info_button_normal.png', mask : undefined,
    ori : 0.0, pos : [0, (- 0.4)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  continueTextBlock_10 = new visual.TextBox({
    win: psychoJS.window,
    name: 'continueTextBlock_10',
    text: '',
    font: 'Arial',
    pos: [0.02, (- 0.4)], letterHeight: 0.03,
    size: [0.3, (0.06 * yrange)],  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  continueClick_10 = new core.Mouse({
    win: psychoJS.window,
  });
  continueClick_10.mouseClock = new util.Clock();
  // Initialize components for Routine "Introduction"
  IntroductionClock = new util.Clock();
  titleScreen = new visual.ImageStim({
    win : psychoJS.window,
    name : 'titleScreen', units : undefined, 
    image : 'resources/Introduction_English/TitleScreen.png', mask : undefined,
    ori : 0.0, pos : [0, 0], size : [1.88, 0.94],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  playButton = new visual.ImageStim({
    win : psychoJS.window,
    name : 'playButton', units : undefined, 
    image : 'resources/Introduction_English/info_button_normal.png', mask : undefined,
    ori : 0.0, pos : [0, (- 0.4)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  playTextBlock = new visual.TextBox({
    win: psychoJS.window,
    name: 'playTextBlock',
    text: '',
    font: 'Arial',
    pos: [0.02, (- 0.4)], letterHeight: 0.03,
    size: [0.3, (0.06 * yrange)],  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  playClick = new core.Mouse({
    win: psychoJS.window,
  });
  playClick.mouseClock = new util.Clock();
  // Initialize components for Routine "IntroductionButtonPressed"
  IntroductionButtonPressedClock = new util.Clock();
  titleScreen_2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'titleScreen_2', units : undefined, 
    image : 'resources/Introduction_English/TitleScreen.png', mask : undefined,
    ori : 0.0, pos : [0, 0], size : [1.88, 0.94],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  playButton_2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'playButton_2', units : undefined, 
    image : 'resources/Introduction_English/info_button_pressed.png', mask : undefined,
    ori : 0.0, pos : [0, (- 0.4)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  playTextBlock_2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'playTextBlock_2',
    text: '',
    font: 'Arial',
    pos: [0.02, (- 0.4)], letterHeight: 0.03,
    size: [0.3, (0.06 * yrange)],  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  // Initialize components for Routine "beginningScreen"
  beginningScreenClock = new util.Clock();
  emptyBackground_4 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'emptyBackground_4', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [2, 1],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  languageText_4 = new visual.TextStim({
    win: psychoJS.window,
    name: 'languageText_4',
    text: '',
    font: 'Open Sans',
    units: undefined, 
    pos: [0, 0], height: 0.1,  wrapWidth: undefined, ori: 0.0,
    languageStyle: 'LTR',
    color: new util.Color('black'),  opacity: undefined,
    depth: -1.0 
  });
  
  // Initialize components for Routine "SetupTheScene"
  SetupTheSceneClock = new util.Clock();
  backgroundImage = new visual.ImageStim({
    win : psychoJS.window,
    name : 'backgroundImage', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [1.92, 0.96],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  leftNotepad = new visual.ImageStim({
    win : psychoJS.window,
    name : 'leftNotepad', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : 1.0,
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -2.0 
  });
  rightNotepad = new visual.ImageStim({
    win : psychoJS.window,
    name : 'rightNotepad', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : 1.0,
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -3.0 
  });
  scoreboardImage = new visual.ImageStim({
    win : psychoJS.window,
    name : 'scoreboardImage', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [((- 0.711) - scoreboardAdjustingX), (0.335 + scoreboardAdjustingY)], size : [(0.5 * scoreboardAdjustingSizeX), (0.3 * scoreboardAdjustingSizeY)],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -4.0 
  });
  // Initialize components for Routine "trialSetup"
  trialSetupClock = new util.Clock();
  // Run 'Begin Experiment' code from TrialSetupCode
  //declare empty list for all correct choices
  correctChoicesList = [];
  currentTrial = 0; //start with first trial = 0
  
  rewardBackgroundCircle = new visual.Polygon({
    win: psychoJS.window, name: 'rewardBackgroundCircle', 
    edges: 100, size:[0.2, 0.2],
    ori: 0.0, pos: [0, 0],
    lineWidth: 5.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('black'),
    fillColor: new util.Color('white'),
    opacity: undefined, depth: -1, interpolate: true,
  });
  
  leftSyringe = new visual.ImageStim({
    win : psychoJS.window,
    name : 'leftSyringe', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [(- 0.4), (- 0.2)], size : [0.25, 0.25],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -2.0 
  });
  rightSyringe = new visual.ImageStim({
    win : psychoJS.window,
    name : 'rightSyringe', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0.4, (- 0.2)], size : [0.25, 0.25],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -3.0 
  });
  leftNoteText = new visual.TextBox({
    win: psychoJS.window,
    name: 'leftNoteText',
    text: '',
    font: 'Arial',
    pos: [(- 0.386), 0.05], letterHeight: 0.07,
    size: [1, 1],  units: undefined, 
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -4.0 
  });
  
  rightNoteText = new visual.TextBox({
    win: psychoJS.window,
    name: 'rightNoteText',
    text: '',
    font: 'Arial',
    pos: [0.42, 0.05], letterHeight: 0.07,
    size: [1, 1],  units: undefined, 
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -5.0 
  });
  
  scoreBoardTextbox = new visual.TextBox({
    win: psychoJS.window,
    name: 'scoreBoardTextbox',
    text: '',
    font: 'Arial',
    pos: [(- 0.88), 0.405], letterHeight: 0.042,
    size: [0.5, 0.3],  units: undefined, 
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'top-left',
    editable: false,
    multiline: true,
    anchor: 'top-left',
    depth: -6.0 
  });
  
  syringeChoice = new core.Mouse({
    win: psychoJS.window,
  });
  syringeChoice.mouseClock = new util.Clock();
  keyChoice = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  // Initialize components for Routine "trialFeedback"
  trialFeedbackClock = new util.Clock();
  rewardBackgroundCircle_2 = new visual.Polygon({
    win: psychoJS.window, name: 'rewardBackgroundCircle_2', 
    edges: 100, size:[0.2, 0.2],
    ori: 0.0, pos: [0, 0],
    lineWidth: 5.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('black'),
    fillColor: new util.Color('white'),
    opacity: undefined, depth: -1, interpolate: true,
  });
  
  leftSyringe_2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'leftSyringe_2', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [(- 0.4), (- 0.2)], size : [0.25, 0.25],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -2.0 
  });
  rightSyringe_2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'rightSyringe_2', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0.4, (- 0.2)], size : [0.25, 0.25],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -3.0 
  });
  leftNoteText_2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'leftNoteText_2',
    text: '',
    font: 'Arial',
    pos: [(- 0.386), 0.05], letterHeight: 0.07,
    size: [1, 1],  units: undefined, 
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -4.0 
  });
  
  rightNoteText_2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'rightNoteText_2',
    text: '',
    font: 'Arial',
    pos: [0.42, 0.05], letterHeight: 0.07,
    size: [0.5, 0.5],  units: undefined, 
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -5.0 
  });
  
  scoreBoardTextbox_2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'scoreBoardTextbox_2',
    text: '',
    font: 'Arial',
    pos: [(- 0.88), 0.405], letterHeight: 0.042,
    size: [0.5, 0.3],  units: undefined, 
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'top-left',
    editable: false,
    multiline: true,
    anchor: 'top-left',
    depth: -6.0 
  });
  
  leftLabFeedback_2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'leftLabFeedback_2', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [(- 0.386), (- 0.03)], size : [0.09, 0.09],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -7.0 
  });
  rightLabFeedback_2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'rightLabFeedback_2', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0.42, (- 0.03)], size : [0.09, 0.09],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -8.0 
  });
  // Initialize components for Routine "trialOutput"
  trialOutputClock = new util.Clock();
  leftNotepad_2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'leftNotepad_2', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : 1.0,
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  rightNotepad_2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'rightNotepad_2', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : 1.0,
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -2.0 
  });
  leftSyringe_3 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'leftSyringe_3', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [(- 0.4), (- 0.2)], size : [0.25, 0.25],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -3.0 
  });
  rightSyringe_3 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'rightSyringe_3', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0.4, (- 0.2)], size : [0.25, 0.25],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -4.0 
  });
  coinCircle = new visual.Polygon({
    win: psychoJS.window, name: 'coinCircle', 
    edges: 100, size:[1.0, 1.0],
    ori: 0.0, pos: [0, 0],
    lineWidth: 1.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('white'),
    fillColor: new util.Color('white'),
    opacity: undefined, depth: -5, interpolate: true,
  });
  
  rewardImage = new visual.ImageStim({
    win : psychoJS.window,
    name : 'rewardImage', units : undefined, 
    image : 'resources/coin.png', mask : undefined,
    ori : 0.0, pos : [(- 0.0035), 0], size : 1.0,
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -6.0 
  });
  leftNoteText_1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'leftNoteText_1',
    text: '',
    font: 'Arial',
    pos: [(- 0.386), 0.05], letterHeight: 0.07,
    size: [1, 1],  units: undefined, 
    color: 'white', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -7.0 
  });
  
  rightNoteText_1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'rightNoteText_1',
    text: '',
    font: 'Arial',
    pos: [0.42, 0.05], letterHeight: 0.07,
    size: [0.5, 0.5],  units: undefined, 
    color: 'white', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -8.0 
  });
  
  continueButtonBackground = new visual.ImageStim({
    win : psychoJS.window,
    name : 'continueButtonBackground', units : undefined, 
    image : 'resources/Introduction_English/info_button_normal.png', mask : undefined,
    ori : 0.0, pos : [0, (- 0.35)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -9.0 
  });
  continueButtonText = new visual.TextBox({
    win: psychoJS.window,
    name: 'continueButtonText',
    text: '',
    font: 'Arial',
    pos: [0.02, (- 0.35)], letterHeight: 0.03,
    size: [0.35, 0.1],  units: undefined, 
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -10.0 
  });
  
  scoreBoardTextbox_3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'scoreBoardTextbox_3',
    text: '',
    font: 'Arial',
    pos: [(- 0.88), 0.405], letterHeight: 0.042,
    size: [0.5, 0.3],  units: undefined, 
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'top-left',
    editable: false,
    multiline: true,
    anchor: 'top-left',
    depth: -11.0 
  });
  
  continueClick = new core.Mouse({
    win: psychoJS.window,
  });
  continueClick.mouseClock = new util.Clock();
  // Initialize components for Routine "buttonPressedTrial"
  buttonPressedTrialClock = new util.Clock();
  leftSyringe_4 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'leftSyringe_4', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [(- 0.4), (- 0.2)], size : [0.25, 0.25],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  rightSyringe_4 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'rightSyringe_4', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0.4, (- 0.2)], size : [0.25, 0.25],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  coinCircle_2 = new visual.Polygon({
    win: psychoJS.window, name: 'coinCircle_2', 
    edges: 100, size:[1.0, 1.0],
    ori: 0.0, pos: [0, 0],
    lineWidth: 1.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('white'),
    fillColor: new util.Color('white'),
    opacity: undefined, depth: -2, interpolate: true,
  });
  
  rewardImage_2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'rewardImage_2', units : undefined, 
    image : 'resources/coin.png', mask : undefined,
    ori : 0.0, pos : [(- 0.0035), 0], size : 1.0,
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -3.0 
  });
  leftNoteText_3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'leftNoteText_3',
    text: '',
    font: 'Arial',
    pos: [(- 0.386), 0.05], letterHeight: 0.07,
    size: [1, 1],  units: undefined, 
    color: 'white', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -4.0 
  });
  
  rightNoteText_3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'rightNoteText_3',
    text: '',
    font: 'Arial',
    pos: [0.42, 0.05], letterHeight: 0.07,
    size: [0.5, 0.5],  units: undefined, 
    color: 'white', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -5.0 
  });
  
  continueButtonBackground_2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'continueButtonBackground_2', units : undefined, 
    image : 'resources/Introduction_English/info_button_pressed.png', mask : undefined,
    ori : 0.0, pos : [0, (- 0.35)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -6.0 
  });
  continueButtonText_2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'continueButtonText_2',
    text: '',
    font: 'Arial',
    pos: [0.02, (- 0.35)], letterHeight: 0.03,
    size: [0.35, 0.1],  units: undefined, 
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -7.0 
  });
  
  scoreBoardTextbox_4 = new visual.TextBox({
    win: psychoJS.window,
    name: 'scoreBoardTextbox_4',
    text: '',
    font: 'Arial',
    pos: [(- 0.88), 0.405], letterHeight: 0.042,
    size: [0.5, 0.3],  units: undefined, 
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'top-left',
    editable: false,
    multiline: true,
    anchor: 'top-left',
    depth: -8.0 
  });
  
  // Initialize components for Routine "endingScreen"
  endingScreenClock = new util.Clock();
  emptyBackground_3 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'emptyBackground_3', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [2, 1],
    color : new util.Color([0.0, 0.0, 0.0]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  languageText_3 = new visual.TextStim({
    win: psychoJS.window,
    name: 'languageText_3',
    text: '',
    font: 'Open Sans',
    units: undefined, 
    pos: [0, 0], height: 0.1,  wrapWidth: undefined, ori: 0.0,
    languageStyle: 'LTR',
    color: new util.Color('black'),  opacity: undefined,
    depth: -2.0 
  });
  
  // Initialize components for Routine "deleteTheScene"
  deleteTheSceneClock = new util.Clock();
  gallery = new visual.ImageStim({
    win : psychoJS.window,
    name : 'gallery', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : [1.88, 0.94],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : 0.0 
  });
  galleryTextBox = new visual.TextBox({
    win: psychoJS.window,
    name: 'galleryTextBox',
    text: '',
    font: 'Arial',
    pos: [0, 0.4], letterHeight: 0.04,
    size: [0.6, 0.3],  units: undefined, 
    color: 'white', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -1.0 
  });
  
  endGameButton = new visual.ImageStim({
    win : psychoJS.window,
    name : 'endGameButton', units : undefined, 
    image : 'resources/Introduction_English/info_button_normal.png', mask : undefined,
    ori : 0.0, pos : [0.6, (- 0.3)], size : [0.36, 0.12],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -2.0 
  });
  endGameTextBox = new visual.TextBox({
    win: psychoJS.window,
    name: 'endGameTextBox',
    text: '',
    font: 'Arial',
    pos: [0.62, (- 0.3)], letterHeight: 0.03,
    size: [0.3, (0.07 * yrange)],  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -3.0 
  });
  
  lastClickofGame = new core.Mouse({
    win: psychoJS.window,
  });
  lastClickofGame.mouseClock = new util.Clock();
  // Initialize components for Routine "savingData"
  savingDataClock = new util.Clock();
  // Create some handy timers
  globalClock = new util.Clock();  // to track the time since experiment started
  routineTimer = new util.CountdownTimer();  // to track time remaining of each (non-slip) routine
  
  return Scheduler.Event.NEXT;
}


var t;
var frameN;
var continueRoutine;
var initializingComponents;
function initializingRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'initializing' ---
    t = 0;
    initializingClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    // keep track of which components have finished
    initializingComponents = [];
    
    for (const thisComponent of initializingComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function initializingRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'initializing' ---
    // get current time
    t = initializingClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of initializingComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function initializingRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'initializing' ---
    for (const thisComponent of initializingComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "initializing" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var choosingTheLanguage;
function choosingTheLanguageLoopBegin(choosingTheLanguageLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    choosingTheLanguage = new TrialHandler({
      psychoJS: psychoJS,
      nReps: neverPlayed, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'choosingTheLanguage'
    });
    psychoJS.experiment.addLoop(choosingTheLanguage); // add the loop to the experiment
    currentLoop = choosingTheLanguage;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisChoosingTheLanguage of choosingTheLanguage) {
      snapshot = choosingTheLanguage.getSnapshot();
      choosingTheLanguageLoopScheduler.add(importConditions(snapshot));
      choosingTheLanguageLoopScheduler.add(chooseLanguageRoutineBegin(snapshot));
      choosingTheLanguageLoopScheduler.add(chooseLanguageRoutineEachFrame());
      choosingTheLanguageLoopScheduler.add(chooseLanguageRoutineEnd(snapshot));
      choosingTheLanguageLoopScheduler.add(languageClickedButtonRoutineBegin(snapshot));
      choosingTheLanguageLoopScheduler.add(languageClickedButtonRoutineEachFrame());
      choosingTheLanguageLoopScheduler.add(languageClickedButtonRoutineEnd(snapshot));
      choosingTheLanguageLoopScheduler.add(choosingTheLanguageLoopEndIteration(choosingTheLanguageLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


async function choosingTheLanguageLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(choosingTheLanguage);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function choosingTheLanguageLoopEndIteration(scheduler, snapshot) {
  // ------Prepare for next entry------
  return async function () {
    if (typeof snapshot !== 'undefined') {
      // ------Check if user ended loop early------
      if (snapshot.finished) {
        // Check for and save orphaned data
        if (psychoJS.experiment.isEntryEmpty()) {
          psychoJS.experiment.nextEntry(snapshot);
        }
        scheduler.stop();
      }
    return Scheduler.Event.NEXT;
    }
  };
}


var sendingMessage;
function sendingMessageLoopBegin(sendingMessageLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    sendingMessage = new TrialHandler({
      psychoJS: psychoJS,
      nReps: cantPlay, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'sendingMessage'
    });
    psychoJS.experiment.addLoop(sendingMessage); // add the loop to the experiment
    currentLoop = sendingMessage;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisSendingMessage of sendingMessage) {
      snapshot = sendingMessage.getSnapshot();
      sendingMessageLoopScheduler.add(importConditions(snapshot));
      sendingMessageLoopScheduler.add(timingIssueRoutineBegin(snapshot));
      sendingMessageLoopScheduler.add(timingIssueRoutineEachFrame());
      sendingMessageLoopScheduler.add(timingIssueRoutineEnd(snapshot));
      sendingMessageLoopScheduler.add(sendingMessageLoopEndIteration(sendingMessageLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


async function sendingMessageLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(sendingMessage);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function sendingMessageLoopEndIteration(scheduler, snapshot) {
  // ------Prepare for next entry------
  return async function () {
    if (typeof snapshot !== 'undefined') {
      // ------Check if user ended loop early------
      if (snapshot.finished) {
        // Check for and save orphaned data
        if (psychoJS.experiment.isEntryEmpty()) {
          psychoJS.experiment.nextEntry(snapshot);
        }
        scheduler.stop();
      }
    return Scheduler.Event.NEXT;
    }
  };
}


var gameplay;
function gameplayLoopBegin(gameplayLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    gameplay = new TrialHandler({
      psychoJS: psychoJS,
      nReps: canPlay, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'gameplay'
    });
    psychoJS.experiment.addLoop(gameplay); // add the loop to the experiment
    currentLoop = gameplay;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisGameplay of gameplay) {
      snapshot = gameplay.getSnapshot();
      gameplayLoopScheduler.add(importConditions(snapshot));
      const allSetupsLoopScheduler = new Scheduler(psychoJS);
      gameplayLoopScheduler.add(allSetupsLoopBegin(allSetupsLoopScheduler, snapshot));
      gameplayLoopScheduler.add(allSetupsLoopScheduler);
      gameplayLoopScheduler.add(allSetupsLoopEnd);
      gameplayLoopScheduler.add(generalLoaderRoutineBegin(snapshot));
      gameplayLoopScheduler.add(generalLoaderRoutineEachFrame());
      gameplayLoopScheduler.add(generalLoaderRoutineEnd(snapshot));
      const syringes_nLoopScheduler = new Scheduler(psychoJS);
      gameplayLoopScheduler.add(syringes_nLoopBegin(syringes_nLoopScheduler, snapshot));
      gameplayLoopScheduler.add(syringes_nLoopScheduler);
      gameplayLoopScheduler.add(syringes_nLoopEnd);
      gameplayLoopScheduler.add(syringeLoaderRoutineBegin(snapshot));
      gameplayLoopScheduler.add(syringeLoaderRoutineEachFrame());
      gameplayLoopScheduler.add(syringeLoaderRoutineEnd(snapshot));
      const firstTimeLoopScheduler = new Scheduler(psychoJS);
      gameplayLoopScheduler.add(firstTimeLoopBegin(firstTimeLoopScheduler, snapshot));
      gameplayLoopScheduler.add(firstTimeLoopScheduler);
      gameplayLoopScheduler.add(firstTimeLoopEnd);
      const oldPlayerLoopScheduler = new Scheduler(psychoJS);
      gameplayLoopScheduler.add(oldPlayerLoopBegin(oldPlayerLoopScheduler, snapshot));
      gameplayLoopScheduler.add(oldPlayerLoopScheduler);
      gameplayLoopScheduler.add(oldPlayerLoopEnd);
      gameplayLoopScheduler.add(beginningScreenRoutineBegin(snapshot));
      gameplayLoopScheduler.add(beginningScreenRoutineEachFrame());
      gameplayLoopScheduler.add(beginningScreenRoutineEnd(snapshot));
      gameplayLoopScheduler.add(SetupTheSceneRoutineBegin(snapshot));
      gameplayLoopScheduler.add(SetupTheSceneRoutineEachFrame());
      gameplayLoopScheduler.add(SetupTheSceneRoutineEnd(snapshot));
      const LabTrialsLoopScheduler = new Scheduler(psychoJS);
      gameplayLoopScheduler.add(LabTrialsLoopBegin(LabTrialsLoopScheduler, snapshot));
      gameplayLoopScheduler.add(LabTrialsLoopScheduler);
      gameplayLoopScheduler.add(LabTrialsLoopEnd);
      gameplayLoopScheduler.add(endingScreenRoutineBegin(snapshot));
      gameplayLoopScheduler.add(endingScreenRoutineEachFrame());
      gameplayLoopScheduler.add(endingScreenRoutineEnd(snapshot));
      gameplayLoopScheduler.add(deleteTheSceneRoutineBegin(snapshot));
      gameplayLoopScheduler.add(deleteTheSceneRoutineEachFrame());
      gameplayLoopScheduler.add(deleteTheSceneRoutineEnd(snapshot));
      gameplayLoopScheduler.add(gameplayLoopEndIteration(gameplayLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


var allSetups;
function allSetupsLoopBegin(allSetupsLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    allSetups = new TrialHandler({
      psychoJS: psychoJS,
      nReps: 1, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: 'resources/variable_sheets/general_setup_sheet.xlsx',
      seed: undefined, name: 'allSetups'
    });
    psychoJS.experiment.addLoop(allSetups); // add the loop to the experiment
    currentLoop = allSetups;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisAllSetup of allSetups) {
      snapshot = allSetups.getSnapshot();
      allSetupsLoopScheduler.add(importConditions(snapshot));
      allSetupsLoopScheduler.add(generalLoaderLoopRoutineBegin(snapshot));
      allSetupsLoopScheduler.add(generalLoaderLoopRoutineEachFrame());
      allSetupsLoopScheduler.add(generalLoaderLoopRoutineEnd(snapshot));
      allSetupsLoopScheduler.add(allSetupsLoopEndIteration(allSetupsLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


async function allSetupsLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(allSetups);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function allSetupsLoopEndIteration(scheduler, snapshot) {
  // ------Prepare for next entry------
  return async function () {
    if (typeof snapshot !== 'undefined') {
      // ------Check if user ended loop early------
      if (snapshot.finished) {
        // Check for and save orphaned data
        if (psychoJS.experiment.isEntryEmpty()) {
          psychoJS.experiment.nextEntry(snapshot);
        }
        scheduler.stop();
      }
    return Scheduler.Event.NEXT;
    }
  };
}


var syringes_n;
function syringes_nLoopBegin(syringes_nLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    syringes_n = new TrialHandler({
      psychoJS: psychoJS,
      nReps: 1, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: currentSyringeTypeSheetPath,
      seed: undefined, name: 'syringes_n'
    });
    psychoJS.experiment.addLoop(syringes_n); // add the loop to the experiment
    currentLoop = syringes_n;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisSyringes_n of syringes_n) {
      snapshot = syringes_n.getSnapshot();
      syringes_nLoopScheduler.add(importConditions(snapshot));
      syringes_nLoopScheduler.add(syringeLoaderLoopRoutineBegin(snapshot));
      syringes_nLoopScheduler.add(syringeLoaderLoopRoutineEachFrame());
      syringes_nLoopScheduler.add(syringeLoaderLoopRoutineEnd(snapshot));
      syringes_nLoopScheduler.add(syringes_nLoopEndIteration(syringes_nLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


async function syringes_nLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(syringes_n);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function syringes_nLoopEndIteration(scheduler, snapshot) {
  // ------Prepare for next entry------
  return async function () {
    if (typeof snapshot !== 'undefined') {
      // ------Check if user ended loop early------
      if (snapshot.finished) {
        // Check for and save orphaned data
        if (psychoJS.experiment.isEntryEmpty()) {
          psychoJS.experiment.nextEntry(snapshot);
        }
        scheduler.stop();
      }
    return Scheduler.Event.NEXT;
    }
  };
}


var firstTime;
function firstTimeLoopBegin(firstTimeLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    firstTime = new TrialHandler({
      psychoJS: psychoJS,
      nReps: neverPlayed, method: TrialHandler.Method.RANDOM,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'firstTime'
    });
    psychoJS.experiment.addLoop(firstTime); // add the loop to the experiment
    currentLoop = firstTime;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisFirstTime of firstTime) {
      snapshot = firstTime.getSnapshot();
      firstTimeLoopScheduler.add(importConditions(snapshot));
      firstTimeLoopScheduler.add(Rules1RoutineBegin(snapshot));
      firstTimeLoopScheduler.add(Rules1RoutineEachFrame());
      firstTimeLoopScheduler.add(Rules1RoutineEnd(snapshot));
      firstTimeLoopScheduler.add(Rules2RoutineBegin(snapshot));
      firstTimeLoopScheduler.add(Rules2RoutineEachFrame());
      firstTimeLoopScheduler.add(Rules2RoutineEnd(snapshot));
      firstTimeLoopScheduler.add(Rules3RoutineBegin(snapshot));
      firstTimeLoopScheduler.add(Rules3RoutineEachFrame());
      firstTimeLoopScheduler.add(Rules3RoutineEnd(snapshot));
      firstTimeLoopScheduler.add(Rules4RoutineBegin(snapshot));
      firstTimeLoopScheduler.add(Rules4RoutineEachFrame());
      firstTimeLoopScheduler.add(Rules4RoutineEnd(snapshot));
      firstTimeLoopScheduler.add(Rules5RoutineBegin(snapshot));
      firstTimeLoopScheduler.add(Rules5RoutineEachFrame());
      firstTimeLoopScheduler.add(Rules5RoutineEnd(snapshot));
      firstTimeLoopScheduler.add(Rules6RoutineBegin(snapshot));
      firstTimeLoopScheduler.add(Rules6RoutineEachFrame());
      firstTimeLoopScheduler.add(Rules6RoutineEnd(snapshot));
      firstTimeLoopScheduler.add(Rules7RoutineBegin(snapshot));
      firstTimeLoopScheduler.add(Rules7RoutineEachFrame());
      firstTimeLoopScheduler.add(Rules7RoutineEnd(snapshot));
      firstTimeLoopScheduler.add(Rules8RoutineBegin(snapshot));
      firstTimeLoopScheduler.add(Rules8RoutineEachFrame());
      firstTimeLoopScheduler.add(Rules8RoutineEnd(snapshot));
      firstTimeLoopScheduler.add(Rules9RoutineBegin(snapshot));
      firstTimeLoopScheduler.add(Rules9RoutineEachFrame());
      firstTimeLoopScheduler.add(Rules9RoutineEnd(snapshot));
      firstTimeLoopScheduler.add(Rules10RoutineBegin(snapshot));
      firstTimeLoopScheduler.add(Rules10RoutineEachFrame());
      firstTimeLoopScheduler.add(Rules10RoutineEnd(snapshot));
      firstTimeLoopScheduler.add(firstTimeLoopEndIteration(firstTimeLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


async function firstTimeLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(firstTime);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function firstTimeLoopEndIteration(scheduler, snapshot) {
  // ------Prepare for next entry------
  return async function () {
    if (typeof snapshot !== 'undefined') {
      // ------Check if user ended loop early------
      if (snapshot.finished) {
        // Check for and save orphaned data
        if (psychoJS.experiment.isEntryEmpty()) {
          psychoJS.experiment.nextEntry(snapshot);
        }
        scheduler.stop();
      }
    return Scheduler.Event.NEXT;
    }
  };
}


var oldPlayer;
function oldPlayerLoopBegin(oldPlayerLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    oldPlayer = new TrialHandler({
      psychoJS: psychoJS,
      nReps: alreadyPlayed, method: TrialHandler.Method.RANDOM,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'oldPlayer'
    });
    psychoJS.experiment.addLoop(oldPlayer); // add the loop to the experiment
    currentLoop = oldPlayer;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisOldPlayer of oldPlayer) {
      snapshot = oldPlayer.getSnapshot();
      oldPlayerLoopScheduler.add(importConditions(snapshot));
      oldPlayerLoopScheduler.add(IntroductionRoutineBegin(snapshot));
      oldPlayerLoopScheduler.add(IntroductionRoutineEachFrame());
      oldPlayerLoopScheduler.add(IntroductionRoutineEnd(snapshot));
      oldPlayerLoopScheduler.add(IntroductionButtonPressedRoutineBegin(snapshot));
      oldPlayerLoopScheduler.add(IntroductionButtonPressedRoutineEachFrame());
      oldPlayerLoopScheduler.add(IntroductionButtonPressedRoutineEnd(snapshot));
      oldPlayerLoopScheduler.add(oldPlayerLoopEndIteration(oldPlayerLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


async function oldPlayerLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(oldPlayer);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function oldPlayerLoopEndIteration(scheduler, snapshot) {
  // ------Prepare for next entry------
  return async function () {
    if (typeof snapshot !== 'undefined') {
      // ------Check if user ended loop early------
      if (snapshot.finished) {
        // Check for and save orphaned data
        if (psychoJS.experiment.isEntryEmpty()) {
          psychoJS.experiment.nextEntry(snapshot);
        }
        scheduler.stop();
      }
    return Scheduler.Event.NEXT;
    }
  };
}


var LabTrials;
function LabTrialsLoopBegin(LabTrialsLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    LabTrials = new TrialHandler({
      psychoJS: psychoJS,
      nReps: 1, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: 'resources/variable_sheets/outputSheet.xlsx',
      seed: undefined, name: 'LabTrials'
    });
    psychoJS.experiment.addLoop(LabTrials); // add the loop to the experiment
    currentLoop = LabTrials;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisLabTrial of LabTrials) {
      snapshot = LabTrials.getSnapshot();
      LabTrialsLoopScheduler.add(importConditions(snapshot));
      LabTrialsLoopScheduler.add(trialSetupRoutineBegin(snapshot));
      LabTrialsLoopScheduler.add(trialSetupRoutineEachFrame());
      LabTrialsLoopScheduler.add(trialSetupRoutineEnd(snapshot));
      LabTrialsLoopScheduler.add(trialFeedbackRoutineBegin(snapshot));
      LabTrialsLoopScheduler.add(trialFeedbackRoutineEachFrame());
      LabTrialsLoopScheduler.add(trialFeedbackRoutineEnd(snapshot));
      LabTrialsLoopScheduler.add(trialOutputRoutineBegin(snapshot));
      LabTrialsLoopScheduler.add(trialOutputRoutineEachFrame());
      LabTrialsLoopScheduler.add(trialOutputRoutineEnd(snapshot));
      LabTrialsLoopScheduler.add(buttonPressedTrialRoutineBegin(snapshot));
      LabTrialsLoopScheduler.add(buttonPressedTrialRoutineEachFrame());
      LabTrialsLoopScheduler.add(buttonPressedTrialRoutineEnd(snapshot));
      LabTrialsLoopScheduler.add(LabTrialsLoopEndIteration(LabTrialsLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


async function LabTrialsLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(LabTrials);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function LabTrialsLoopEndIteration(scheduler, snapshot) {
  // ------Prepare for next entry------
  return async function () {
    if (typeof snapshot !== 'undefined') {
      // ------Check if user ended loop early------
      if (snapshot.finished) {
        // Check for and save orphaned data
        if (psychoJS.experiment.isEntryEmpty()) {
          psychoJS.experiment.nextEntry(snapshot);
        }
        scheduler.stop();
      } else {
        psychoJS.experiment.nextEntry(snapshot);
      }
    return Scheduler.Event.NEXT;
    }
  };
}


async function gameplayLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(gameplay);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function gameplayLoopEndIteration(scheduler, snapshot) {
  // ------Prepare for next entry------
  return async function () {
    if (typeof snapshot !== 'undefined') {
      // ------Check if user ended loop early------
      if (snapshot.finished) {
        // Check for and save orphaned data
        if (psychoJS.experiment.isEntryEmpty()) {
          psychoJS.experiment.nextEntry(snapshot);
        }
        scheduler.stop();
      }
    return Scheduler.Event.NEXT;
    }
  };
}


var gotValidClick;
var chooseLanguageComponents;
function chooseLanguageRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'chooseLanguage' ---
    t = 0;
    chooseLanguageClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    emptyBackground.setImage('resources/alternative_screen2.png');
    // setup some python lists for storing info about the languageChoiceClick
    languageChoiceClick.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    chooseLanguageComponents = [];
    chooseLanguageComponents.push(emptyBackground);
    chooseLanguageComponents.push(germanFlag);
    chooseLanguageComponents.push(englishFlag);
    chooseLanguageComponents.push(languageText);
    chooseLanguageComponents.push(languageChoiceClick);
    
    for (const thisComponent of chooseLanguageComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


var prevButtonState;
var _mouseButtons;
function chooseLanguageRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'chooseLanguage' ---
    // get current time
    t = chooseLanguageClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *emptyBackground* updates
    if (t >= 0.0 && emptyBackground.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      emptyBackground.tStart = t;  // (not accounting for frame time here)
      emptyBackground.frameNStart = frameN;  // exact frame index
      
      emptyBackground.setAutoDraw(true);
    }

    
    // *germanFlag* updates
    if (t >= 0.0 && germanFlag.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      germanFlag.tStart = t;  // (not accounting for frame time here)
      germanFlag.frameNStart = frameN;  // exact frame index
      
      germanFlag.setAutoDraw(true);
    }

    
    // *englishFlag* updates
    if (t >= 0.0 && englishFlag.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      englishFlag.tStart = t;  // (not accounting for frame time here)
      englishFlag.frameNStart = frameN;  // exact frame index
      
      englishFlag.setAutoDraw(true);
    }

    
    // *languageText* updates
    if (t >= 0.0 && languageText.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      languageText.tStart = t;  // (not accounting for frame time here)
      languageText.frameNStart = frameN;  // exact frame index
      
      languageText.setAutoDraw(true);
    }

    // *languageChoiceClick* updates
    if (t >= 0.0 && languageChoiceClick.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      languageChoiceClick.tStart = t;  // (not accounting for frame time here)
      languageChoiceClick.frameNStart = frameN;  // exact frame index
      
      languageChoiceClick.status = PsychoJS.Status.STARTED;
      languageChoiceClick.mouseClock.reset();
      prevButtonState = languageChoiceClick.getPressed();  // if button is down already this ISN'T a new click
      }
    if (languageChoiceClick.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = languageChoiceClick.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [germanFlag, englishFlag]) {
            if (obj.contains(languageChoiceClick)) {
              gotValidClick = true;
              languageChoiceClick.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of chooseLanguageComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function chooseLanguageRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'chooseLanguage' ---
    for (const thisComponent of chooseLanguageComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "chooseLanguage" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var languageChoice;
var flagCircleSizeLeft;
var flagCircleSizeRight;
var languageClickedButtonComponents;
function languageClickedButtonRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'languageClickedButton' ---
    t = 0;
    languageClickedButtonClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    routineTimer.add(0.120000);
    // update component parameters for each repeat
    //Assignment of language preference
    // ----------------------------------------------------------------------------------------------------------
    
    if ((languageChoiceClick.clicked_name.slice((- 1))[0] === "germanFlag")) { //if player chose German
        languageChoice = "de"; //set to "de" = Deutsch
        flagCircleSizeLeft = (0.32, 0.32);
        flagCircleSizeRight = (0, 0);
        
        } else {
        languageChoice = "en"; //set to "en" = English
        flagCircleSizeRight = (0.32, 0.32);
        flagCircleSizeLeft = (0, 0);
    
    }
    
    emptyBackground_2.setImage('resources/alternative_screen2.png');
    circleFlag.setPos([(- 0.4), (- 0.15)]);
    circleFlag.setSize(flagCircleSizeLeft);
    circleFlag_2.setPos([0.4, (- 0.15)]);
    circleFlag_2.setSize(flagCircleSizeRight);
    // keep track of which components have finished
    languageClickedButtonComponents = [];
    languageClickedButtonComponents.push(emptyBackground_2);
    languageClickedButtonComponents.push(circleFlag);
    languageClickedButtonComponents.push(circleFlag_2);
    languageClickedButtonComponents.push(germanFlag_2);
    languageClickedButtonComponents.push(englishFlag_2);
    languageClickedButtonComponents.push(languageText_2);
    
    for (const thisComponent of languageClickedButtonComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


var frameRemains;
function languageClickedButtonRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'languageClickedButton' ---
    // get current time
    t = languageClickedButtonClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *emptyBackground_2* updates
    if (t >= 0.0 && emptyBackground_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      emptyBackground_2.tStart = t;  // (not accounting for frame time here)
      emptyBackground_2.frameNStart = frameN;  // exact frame index
      
      emptyBackground_2.setAutoDraw(true);
    }

    frameRemains = 0.12  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((emptyBackground_2.status === PsychoJS.Status.STARTED || emptyBackground_2.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      emptyBackground_2.setAutoDraw(false);
    }
    
    // *circleFlag* updates
    if (t >= 0.0 && circleFlag.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      circleFlag.tStart = t;  // (not accounting for frame time here)
      circleFlag.frameNStart = frameN;  // exact frame index
      
      circleFlag.setAutoDraw(true);
    }

    frameRemains = 0.12  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((circleFlag.status === PsychoJS.Status.STARTED || circleFlag.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      circleFlag.setAutoDraw(false);
    }
    
    // *circleFlag_2* updates
    if (t >= 0.0 && circleFlag_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      circleFlag_2.tStart = t;  // (not accounting for frame time here)
      circleFlag_2.frameNStart = frameN;  // exact frame index
      
      circleFlag_2.setAutoDraw(true);
    }

    frameRemains = 0.12  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((circleFlag_2.status === PsychoJS.Status.STARTED || circleFlag_2.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      circleFlag_2.setAutoDraw(false);
    }
    
    // *germanFlag_2* updates
    if (t >= 0.0 && germanFlag_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      germanFlag_2.tStart = t;  // (not accounting for frame time here)
      germanFlag_2.frameNStart = frameN;  // exact frame index
      
      germanFlag_2.setAutoDraw(true);
    }

    frameRemains = 0.12  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((germanFlag_2.status === PsychoJS.Status.STARTED || germanFlag_2.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      germanFlag_2.setAutoDraw(false);
    }
    
    // *englishFlag_2* updates
    if (t >= 0.0 && englishFlag_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      englishFlag_2.tStart = t;  // (not accounting for frame time here)
      englishFlag_2.frameNStart = frameN;  // exact frame index
      
      englishFlag_2.setAutoDraw(true);
    }

    frameRemains = 0.12  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((englishFlag_2.status === PsychoJS.Status.STARTED || englishFlag_2.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      englishFlag_2.setAutoDraw(false);
    }
    
    // *languageText_2* updates
    if (t >= 0.0 && languageText_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      languageText_2.tStart = t;  // (not accounting for frame time here)
      languageText_2.frameNStart = frameN;  // exact frame index
      
      languageText_2.setAutoDraw(true);
    }

    frameRemains = 0.12  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((languageText_2.status === PsychoJS.Status.STARTED || languageText_2.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      languageText_2.setAutoDraw(false);
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of languageClickedButtonComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine && routineTimer.getTime() > 0) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function languageClickedButtonRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'languageClickedButton' ---
    for (const thisComponent of languageClickedButtonComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var minutes_formatFixed;
var intro1;
var intro2;
var intro3;
var intro4;
var intro5;
var intro6;
var intro7;
var intro8;
var intro9;
var intro10;
var continueText;
var playText;
var score_text;
var score_endText;
var round_text1;
var round_text2;
var level_text;
var endGameText;
var endingStatement;
var beginningStatement;
var cantPlayReasonText;
var textAssignmentComponents;
function textAssignmentRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'textAssignment' ---
    t = 0;
    textAssignmentClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    if (lastTimePlayed[1] < 10){
        minutes_formatFixed = "0" + lastTimePlayed[1].toString();
        }
    else{
        minutes_formatFixed = lastTimePlayed[1].toString();
        }
    
    if (languageChoice == "de"){
        intro1 = "resources/Introduction_German/Intro_Deutsch_1.png";
        intro2 = "resources/Introduction_German/Intro_Deutsch_2.png";
        intro3 = "resources/Introduction_German/Intro_Deutsch_3.png";
        intro4 = "resources/Introduction_German/Intro_Deutsch_4.png";
        intro5 = "resources/Introduction_German/Intro_Deutsch_5.png";
        intro6 = "resources/Introduction_German/Intro_Deutsch_6.png";
        intro7 = "resources/Introduction_German/Intro_Deutsch_7.png";
        intro8 = "resources/Introduction_German/Intro_Deutsch_8.png";
        intro9 = "resources/Introduction_German/Intro_Deutsch_9.png";
        intro10 = "resources/Introduction_German/Intro_Deutsch_10.png";
        
        continueText = "Weiter";
        playText = "Spielen";
        score_text = "Score: ";
        score_endText = "Gesamtscore: ";
        round_text1 = "Runde ";
        round_text2 = " von 150";
        level_text = "Level: ";
        endGameText = "Spiel beenden";
        endingStatement = "Das Level ist nun zu Ende.";
        beginningStatement = "Level " + session_n.toString();
        
        if (cantPlayReason == "time"){
            cantPlayReasonText = "Sie haben heute um " + lastTimePlayed[0].toString() + ":" + minutes_formatFixed.toString() + " Uhr bereits gespielt." + "\n" + "Sie dürfen eine Stunde nach Ihrem letzten Spiel nochmal spielen!"
        }else if (cantPlayReason == "day"){
            cantPlayReasonText = "Es dürfen maximal drei Spiele am Tag gespielt werden. Morgen dürfen Sie wieder spielen.";
            }
            
        
    }else if (languageChoice == "en"){
        intro1 = "resources/Introduction_English/Intro_English_1.png";
        intro2 = "resources/Introduction_English/Intro_English_2.png";
        intro3 = "resources/Introduction_English/Intro_English_3.png";
        intro4 = "resources/Introduction_English/Intro_English_4.jpg";
        intro5 = "resources/Introduction_English/Intro_English_5.jpg";
        intro6 = "resources/Introduction_English/Intro_English_6.jpg";
        intro7 = "resources/Introduction_English/Intro_English_7.jpg";
        intro8 = "resources/Introduction_English/Intro_English_8.png";
        intro9 = "resources/Introduction_English/Intro_English_9.png";
        intro10 = "resources/Introduction_English/Intro_English_10.png"; 
    
        continueText = "Continue";
        playText = "Play";
        score_text = "Score: ";
        score_endText = "Total Score: ";
        round_text1 = "Round ";
        round_text2 = " of 150";
        level_text = "Level: ";
        endGameText = "End game";
        endingStatement = "The level is now over.";
        beginningStatement = "Level " + session_n.toString();
        
        if (cantPlayReason == "time"){
            cantPlayReasonText = "You've already played at " + lastTimePlayed[0].toString() + ":" + minutes_formatFixed.toString() + " today." + "\n" + "You can play again one hour after your last game!"
        }else if (cantPlayReason == "day"){
            cantPlayReasonText = "You can only play three games a day. Try again tomorrow.";
            }
    }
    
    // keep track of which components have finished
    textAssignmentComponents = [];
    
    for (const thisComponent of textAssignmentComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function textAssignmentRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'textAssignment' ---
    // get current time
    t = textAssignmentClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of textAssignmentComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function textAssignmentRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'textAssignment' ---
    for (const thisComponent of textAssignmentComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "textAssignment" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var timingIssueComponents;
function timingIssueRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'timingIssue' ---
    t = 0;
    timingIssueClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    emptyBackground_5.setImage('resources/alternative_screen2.png');
    // setup some python lists for storing info about the okayClick
    // current position of the mouse:
    okayClick.x = [];
    okayClick.y = [];
    okayClick.leftButton = [];
    okayClick.midButton = [];
    okayClick.rightButton = [];
    okayClick.time = [];
    okayClick.clicked_name = [];
    gotValidClick = false; // until a click is received
    informationTextbox.setText(cantPlayReasonText);
    // keep track of which components have finished
    timingIssueComponents = [];
    timingIssueComponents.push(emptyBackground_5);
    timingIssueComponents.push(okayButton);
    timingIssueComponents.push(buttonTextBlock);
    timingIssueComponents.push(okayClick);
    timingIssueComponents.push(informationTextbox);
    
    for (const thisComponent of timingIssueComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


var _mouseXYs;
function timingIssueRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'timingIssue' ---
    // get current time
    t = timingIssueClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *emptyBackground_5* updates
    if (t >= 0.0 && emptyBackground_5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      emptyBackground_5.tStart = t;  // (not accounting for frame time here)
      emptyBackground_5.frameNStart = frameN;  // exact frame index
      
      emptyBackground_5.setAutoDraw(true);
    }

    
    // *okayButton* updates
    if (t >= 0.0 && okayButton.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      okayButton.tStart = t;  // (not accounting for frame time here)
      okayButton.frameNStart = frameN;  // exact frame index
      
      okayButton.setAutoDraw(true);
    }

    
    // *buttonTextBlock* updates
    if (t >= 0.0 && buttonTextBlock.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      buttonTextBlock.tStart = t;  // (not accounting for frame time here)
      buttonTextBlock.frameNStart = frameN;  // exact frame index
      
      buttonTextBlock.setAutoDraw(true);
    }

    // *okayClick* updates
    if (t >= 0.0 && okayClick.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      okayClick.tStart = t;  // (not accounting for frame time here)
      okayClick.frameNStart = frameN;  // exact frame index
      
      okayClick.status = PsychoJS.Status.STARTED;
      okayClick.mouseClock.reset();
      prevButtonState = okayClick.getPressed();  // if button is down already this ISN'T a new click
      }
    if (okayClick.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = okayClick.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [okayButton]) {
            if (obj.contains(okayClick)) {
              gotValidClick = true;
              okayClick.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { 
            _mouseXYs = okayClick.getPos();
            okayClick.x.push(_mouseXYs[0]);
            okayClick.y.push(_mouseXYs[1]);
            okayClick.leftButton.push(_mouseButtons[0]);
            okayClick.midButton.push(_mouseButtons[1]);
            okayClick.rightButton.push(_mouseButtons[2]);
            okayClick.time.push(okayClick.mouseClock.getTime());
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    
    // *informationTextbox* updates
    if (t >= 0.0 && informationTextbox.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      informationTextbox.tStart = t;  // (not accounting for frame time here)
      informationTextbox.frameNStart = frameN;  // exact frame index
      
      informationTextbox.setAutoDraw(true);
    }

    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of timingIssueComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function timingIssueRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'timingIssue' ---
    for (const thisComponent of timingIssueComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    if (okayClick.x) {  psychoJS.experiment.addData('okayClick.x', okayClick.x[0])};
    if (okayClick.y) {  psychoJS.experiment.addData('okayClick.y', okayClick.y[0])};
    if (okayClick.leftButton) {  psychoJS.experiment.addData('okayClick.leftButton', okayClick.leftButton[0])};
    if (okayClick.midButton) {  psychoJS.experiment.addData('okayClick.midButton', okayClick.midButton[0])};
    if (okayClick.rightButton) {  psychoJS.experiment.addData('okayClick.rightButton', okayClick.rightButton[0])};
    if (okayClick.time) {  psychoJS.experiment.addData('okayClick.time', okayClick.time[0])};
    if (okayClick.clicked_name) {  psychoJS.experiment.addData('okayClick.clicked_name', okayClick.clicked_name[0])};
    
    // the Routine "timingIssue" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var generalLoaderLoopComponents;
function generalLoaderLoopRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'generalLoaderLoop' ---
    t = 0;
    generalLoaderLoopClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    //fill lists with all images/excel sheets
    scenes_list.push(scenes);
    notepadImage_list.push(notepads);
    scoreboardImage_list.push(scoreboards);
    syringeTypeSheet_list.push(syringeTypeSheet);
    // keep track of which components have finished
    generalLoaderLoopComponents = [];
    
    for (const thisComponent of generalLoaderLoopComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function generalLoaderLoopRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'generalLoaderLoop' ---
    // get current time
    t = generalLoaderLoopClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of generalLoaderLoopComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function generalLoaderLoopRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'generalLoaderLoop' ---
    for (const thisComponent of generalLoaderLoopComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "generalLoaderLoop" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var currentNotepadImage;
var currentScoreboardImage;
var currentSyringeTypeSheetPath;
var generalLoaderComponents;
function generalLoaderRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'generalLoader' ---
    t = 0;
    generalLoaderClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    //choose current images/sheets for scene setup based on your current level
    currentNotepadImage = notepadImage_list[(level_n - 1)].toString();
    currentScoreboardImage = scoreboardImage_list[(level_n - 1)].toString();
    currentSyringeTypeSheetPath = syringeTypeSheet_list[(level_n - 1)].toString();
    // keep track of which components have finished
    generalLoaderComponents = [];
    
    for (const thisComponent of generalLoaderComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function generalLoaderRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'generalLoader' ---
    // get current time
    t = generalLoaderClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of generalLoaderComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function generalLoaderRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'generalLoader' ---
    for (const thisComponent of generalLoaderComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "generalLoader" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var syringeLoaderLoopComponents;
function syringeLoaderLoopRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'syringeLoaderLoop' ---
    t = 0;
    syringeLoaderLoopClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    //fill lists with images for empty/full syringes, and the matched syringe colors
    emptySyringes_list.push(syringeEmpty);
    fullSyringes_list.push(syringeFull);
    syringeColor_list.push(syringeColor);
    // keep track of which components have finished
    syringeLoaderLoopComponents = [];
    
    for (const thisComponent of syringeLoaderLoopComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function syringeLoaderLoopRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'syringeLoaderLoop' ---
    // get current time
    t = syringeLoaderLoopClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of syringeLoaderLoopComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function syringeLoaderLoopRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'syringeLoaderLoop' ---
    for (const thisComponent of syringeLoaderLoopComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "syringeLoaderLoop" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var nSyringes;
var leftSyringeIndex;
var rightSyringeIndex;
var count;
var leftFullSyringeImage;
var rightFullSyringeImage;
var leftEmptySyringeImage;
var rightEmptySyringeImage;
var leftSyringeColor;
var rightSyringeColor;
var syringeLoaderComponents;
function syringeLoaderRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'syringeLoader' ---
    t = 0;
    syringeLoaderClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    //get number of syringes for your current level
    nSyringes = emptySyringes_list.length;
    
    //randomly choose left and right syringe
    leftSyringeIndex = Number.parseInt(Math.random() * (nSyringes - 0) + 0);
    rightSyringeIndex = Number.parseInt(Math.random() * (nSyringes - 0) + 0);
    count = 0; //tracker to avoid getting stuck in while loop
    //when left and right syringe are the same
    while (((leftSyringeIndex === rightSyringeIndex) && (count <= 100))) { 
        rightSyringeIndex = Number.parseInt(Math.random() * (nSyringes - 0) + 0); //choose a new syringe for the right side
        count = (count + 1);
    }
    
    //set all image paths
    leftFullSyringeImage = fullSyringes_list[leftSyringeIndex].toString();
    rightFullSyringeImage = fullSyringes_list[rightSyringeIndex].toString();
    leftEmptySyringeImage = emptySyringes_list[leftSyringeIndex].toString();
    rightEmptySyringeImage = emptySyringes_list[rightSyringeIndex].toString();
    leftSyringeColor = syringeColor_list[leftSyringeIndex].toString();
    rightSyringeColor = syringeColor_list[rightSyringeIndex].toString();
    
    // keep track of which components have finished
    syringeLoaderComponents = [];
    
    for (const thisComponent of syringeLoaderComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function syringeLoaderRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'syringeLoader' ---
    // get current time
    t = syringeLoaderClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of syringeLoaderComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function syringeLoaderRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'syringeLoader' ---
    for (const thisComponent of syringeLoaderComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "syringeLoader" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var Rules1Components;
function Rules1RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'Rules1' ---
    t = 0;
    Rules1Clock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    introductionScreen.setImage(intro1);
    continueTextBlock.setText(continueText);
    // setup some python lists for storing info about the continueClick_1
    continueClick_1.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    Rules1Components = [];
    Rules1Components.push(introductionScreen);
    Rules1Components.push(continueButton1);
    Rules1Components.push(continueTextBlock);
    Rules1Components.push(continueClick_1);
    
    for (const thisComponent of Rules1Components)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function Rules1RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'Rules1' ---
    // get current time
    t = Rules1Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *introductionScreen* updates
    if (t >= 0.0 && introductionScreen.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      introductionScreen.tStart = t;  // (not accounting for frame time here)
      introductionScreen.frameNStart = frameN;  // exact frame index
      
      introductionScreen.setAutoDraw(true);
    }

    
    // *continueButton1* updates
    if (t >= 0.0 && continueButton1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueButton1.tStart = t;  // (not accounting for frame time here)
      continueButton1.frameNStart = frameN;  // exact frame index
      
      continueButton1.setAutoDraw(true);
    }

    
    // *continueTextBlock* updates
    if (t >= 0.0 && continueTextBlock.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueTextBlock.tStart = t;  // (not accounting for frame time here)
      continueTextBlock.frameNStart = frameN;  // exact frame index
      
      continueTextBlock.setAutoDraw(true);
    }

    // *continueClick_1* updates
    if (t >= 0.0 && continueClick_1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueClick_1.tStart = t;  // (not accounting for frame time here)
      continueClick_1.frameNStart = frameN;  // exact frame index
      
      continueClick_1.status = PsychoJS.Status.STARTED;
      continueClick_1.mouseClock.reset();
      prevButtonState = continueClick_1.getPressed();  // if button is down already this ISN'T a new click
      }
    if (continueClick_1.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = continueClick_1.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [continueButton1]) {
            if (obj.contains(continueClick_1)) {
              gotValidClick = true;
              continueClick_1.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of Rules1Components)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function Rules1RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'Rules1' ---
    for (const thisComponent of Rules1Components) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "Rules1" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var Rules2Components;
function Rules2RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'Rules2' ---
    t = 0;
    Rules2Clock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    introductionScreen_2.setImage(intro2);
    continueTextBlock_2.setText(continueText);
    // setup some python lists for storing info about the continueClick_2
    continueClick_2.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    Rules2Components = [];
    Rules2Components.push(introductionScreen_2);
    Rules2Components.push(continueButton2);
    Rules2Components.push(continueTextBlock_2);
    Rules2Components.push(continueClick_2);
    
    for (const thisComponent of Rules2Components)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function Rules2RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'Rules2' ---
    // get current time
    t = Rules2Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *introductionScreen_2* updates
    if (t >= 0.0 && introductionScreen_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      introductionScreen_2.tStart = t;  // (not accounting for frame time here)
      introductionScreen_2.frameNStart = frameN;  // exact frame index
      
      introductionScreen_2.setAutoDraw(true);
    }

    
    // *continueButton2* updates
    if (t >= 0.0 && continueButton2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueButton2.tStart = t;  // (not accounting for frame time here)
      continueButton2.frameNStart = frameN;  // exact frame index
      
      continueButton2.setAutoDraw(true);
    }

    
    // *continueTextBlock_2* updates
    if (t >= 0.0 && continueTextBlock_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueTextBlock_2.tStart = t;  // (not accounting for frame time here)
      continueTextBlock_2.frameNStart = frameN;  // exact frame index
      
      continueTextBlock_2.setAutoDraw(true);
    }

    // *continueClick_2* updates
    if (t >= 0.0 && continueClick_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueClick_2.tStart = t;  // (not accounting for frame time here)
      continueClick_2.frameNStart = frameN;  // exact frame index
      
      continueClick_2.status = PsychoJS.Status.STARTED;
      continueClick_2.mouseClock.reset();
      prevButtonState = continueClick_2.getPressed();  // if button is down already this ISN'T a new click
      }
    if (continueClick_2.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = continueClick_2.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [continueButton2]) {
            if (obj.contains(continueClick_2)) {
              gotValidClick = true;
              continueClick_2.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of Rules2Components)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function Rules2RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'Rules2' ---
    for (const thisComponent of Rules2Components) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "Rules2" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var Rules3Components;
function Rules3RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'Rules3' ---
    t = 0;
    Rules3Clock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    introductionScreen_3.setImage(intro3);
    continueTextBlock_3.setText(continueText);
    // setup some python lists for storing info about the continueClick_3
    continueClick_3.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    Rules3Components = [];
    Rules3Components.push(introductionScreen_3);
    Rules3Components.push(continueButton3);
    Rules3Components.push(continueTextBlock_3);
    Rules3Components.push(continueClick_3);
    
    for (const thisComponent of Rules3Components)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function Rules3RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'Rules3' ---
    // get current time
    t = Rules3Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *introductionScreen_3* updates
    if (t >= 0.0 && introductionScreen_3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      introductionScreen_3.tStart = t;  // (not accounting for frame time here)
      introductionScreen_3.frameNStart = frameN;  // exact frame index
      
      introductionScreen_3.setAutoDraw(true);
    }

    
    // *continueButton3* updates
    if (t >= 0.0 && continueButton3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueButton3.tStart = t;  // (not accounting for frame time here)
      continueButton3.frameNStart = frameN;  // exact frame index
      
      continueButton3.setAutoDraw(true);
    }

    
    // *continueTextBlock_3* updates
    if (t >= 0.0 && continueTextBlock_3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueTextBlock_3.tStart = t;  // (not accounting for frame time here)
      continueTextBlock_3.frameNStart = frameN;  // exact frame index
      
      continueTextBlock_3.setAutoDraw(true);
    }

    // *continueClick_3* updates
    if (t >= 0.0 && continueClick_3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueClick_3.tStart = t;  // (not accounting for frame time here)
      continueClick_3.frameNStart = frameN;  // exact frame index
      
      continueClick_3.status = PsychoJS.Status.STARTED;
      continueClick_3.mouseClock.reset();
      prevButtonState = continueClick_3.getPressed();  // if button is down already this ISN'T a new click
      }
    if (continueClick_3.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = continueClick_3.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [continueButton3]) {
            if (obj.contains(continueClick_3)) {
              gotValidClick = true;
              continueClick_3.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of Rules3Components)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function Rules3RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'Rules3' ---
    for (const thisComponent of Rules3Components) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "Rules3" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var Rules4Components;
function Rules4RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'Rules4' ---
    t = 0;
    Rules4Clock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    introductionScreen_4.setImage(intro4);
    continueTextBlock_4.setText(continueText);
    // setup some python lists for storing info about the continueClick_4
    continueClick_4.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    Rules4Components = [];
    Rules4Components.push(introductionScreen_4);
    Rules4Components.push(continueButton4);
    Rules4Components.push(continueTextBlock_4);
    Rules4Components.push(continueClick_4);
    
    for (const thisComponent of Rules4Components)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function Rules4RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'Rules4' ---
    // get current time
    t = Rules4Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *introductionScreen_4* updates
    if (t >= 0.0 && introductionScreen_4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      introductionScreen_4.tStart = t;  // (not accounting for frame time here)
      introductionScreen_4.frameNStart = frameN;  // exact frame index
      
      introductionScreen_4.setAutoDraw(true);
    }

    
    // *continueButton4* updates
    if (t >= 0.0 && continueButton4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueButton4.tStart = t;  // (not accounting for frame time here)
      continueButton4.frameNStart = frameN;  // exact frame index
      
      continueButton4.setAutoDraw(true);
    }

    
    // *continueTextBlock_4* updates
    if (t >= 0.0 && continueTextBlock_4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueTextBlock_4.tStart = t;  // (not accounting for frame time here)
      continueTextBlock_4.frameNStart = frameN;  // exact frame index
      
      continueTextBlock_4.setAutoDraw(true);
    }

    // *continueClick_4* updates
    if (t >= 0.0 && continueClick_4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueClick_4.tStart = t;  // (not accounting for frame time here)
      continueClick_4.frameNStart = frameN;  // exact frame index
      
      continueClick_4.status = PsychoJS.Status.STARTED;
      continueClick_4.mouseClock.reset();
      prevButtonState = continueClick_4.getPressed();  // if button is down already this ISN'T a new click
      }
    if (continueClick_4.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = continueClick_4.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [continueButton4]) {
            if (obj.contains(continueClick_4)) {
              gotValidClick = true;
              continueClick_4.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of Rules4Components)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function Rules4RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'Rules4' ---
    for (const thisComponent of Rules4Components) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "Rules4" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var Rules5Components;
function Rules5RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'Rules5' ---
    t = 0;
    Rules5Clock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    introductionScreen_5.setImage(intro5);
    continueTextBlock_5.setText(continueText);
    // setup some python lists for storing info about the continueClick_5
    continueClick_5.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    Rules5Components = [];
    Rules5Components.push(introductionScreen_5);
    Rules5Components.push(continueButton5);
    Rules5Components.push(continueTextBlock_5);
    Rules5Components.push(continueClick_5);
    
    for (const thisComponent of Rules5Components)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function Rules5RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'Rules5' ---
    // get current time
    t = Rules5Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *introductionScreen_5* updates
    if (t >= 0.0 && introductionScreen_5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      introductionScreen_5.tStart = t;  // (not accounting for frame time here)
      introductionScreen_5.frameNStart = frameN;  // exact frame index
      
      introductionScreen_5.setAutoDraw(true);
    }

    
    // *continueButton5* updates
    if (t >= 0.0 && continueButton5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueButton5.tStart = t;  // (not accounting for frame time here)
      continueButton5.frameNStart = frameN;  // exact frame index
      
      continueButton5.setAutoDraw(true);
    }

    
    // *continueTextBlock_5* updates
    if (t >= 0.0 && continueTextBlock_5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueTextBlock_5.tStart = t;  // (not accounting for frame time here)
      continueTextBlock_5.frameNStart = frameN;  // exact frame index
      
      continueTextBlock_5.setAutoDraw(true);
    }

    // *continueClick_5* updates
    if (t >= 0.0 && continueClick_5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueClick_5.tStart = t;  // (not accounting for frame time here)
      continueClick_5.frameNStart = frameN;  // exact frame index
      
      continueClick_5.status = PsychoJS.Status.STARTED;
      continueClick_5.mouseClock.reset();
      prevButtonState = continueClick_5.getPressed();  // if button is down already this ISN'T a new click
      }
    if (continueClick_5.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = continueClick_5.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [continueButton5]) {
            if (obj.contains(continueClick_5)) {
              gotValidClick = true;
              continueClick_5.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of Rules5Components)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function Rules5RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'Rules5' ---
    for (const thisComponent of Rules5Components) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "Rules5" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var Rules6Components;
function Rules6RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'Rules6' ---
    t = 0;
    Rules6Clock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    introductionScreen_6.setImage(intro6);
    continueTextBlock_6.setText(continueText);
    // setup some python lists for storing info about the continueClick_6
    continueClick_6.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    Rules6Components = [];
    Rules6Components.push(introductionScreen_6);
    Rules6Components.push(continueButton6);
    Rules6Components.push(continueTextBlock_6);
    Rules6Components.push(continueClick_6);
    
    for (const thisComponent of Rules6Components)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function Rules6RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'Rules6' ---
    // get current time
    t = Rules6Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *introductionScreen_6* updates
    if (t >= 0.0 && introductionScreen_6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      introductionScreen_6.tStart = t;  // (not accounting for frame time here)
      introductionScreen_6.frameNStart = frameN;  // exact frame index
      
      introductionScreen_6.setAutoDraw(true);
    }

    
    // *continueButton6* updates
    if (t >= 0.0 && continueButton6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueButton6.tStart = t;  // (not accounting for frame time here)
      continueButton6.frameNStart = frameN;  // exact frame index
      
      continueButton6.setAutoDraw(true);
    }

    
    // *continueTextBlock_6* updates
    if (t >= 0.0 && continueTextBlock_6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueTextBlock_6.tStart = t;  // (not accounting for frame time here)
      continueTextBlock_6.frameNStart = frameN;  // exact frame index
      
      continueTextBlock_6.setAutoDraw(true);
    }

    // *continueClick_6* updates
    if (t >= 0.0 && continueClick_6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueClick_6.tStart = t;  // (not accounting for frame time here)
      continueClick_6.frameNStart = frameN;  // exact frame index
      
      continueClick_6.status = PsychoJS.Status.STARTED;
      continueClick_6.mouseClock.reset();
      prevButtonState = continueClick_6.getPressed();  // if button is down already this ISN'T a new click
      }
    if (continueClick_6.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = continueClick_6.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [continueButton6]) {
            if (obj.contains(continueClick_6)) {
              gotValidClick = true;
              continueClick_6.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of Rules6Components)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function Rules6RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'Rules6' ---
    for (const thisComponent of Rules6Components) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "Rules6" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var Rules7Components;
function Rules7RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'Rules7' ---
    t = 0;
    Rules7Clock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    introductionScreen_7.setImage(intro7);
    continueTextBlock_7.setText(continueText);
    // setup some python lists for storing info about the continueClick_7
    continueClick_7.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    Rules7Components = [];
    Rules7Components.push(introductionScreen_7);
    Rules7Components.push(continueButton7);
    Rules7Components.push(continueTextBlock_7);
    Rules7Components.push(continueClick_7);
    
    for (const thisComponent of Rules7Components)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function Rules7RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'Rules7' ---
    // get current time
    t = Rules7Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *introductionScreen_7* updates
    if (t >= 0.0 && introductionScreen_7.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      introductionScreen_7.tStart = t;  // (not accounting for frame time here)
      introductionScreen_7.frameNStart = frameN;  // exact frame index
      
      introductionScreen_7.setAutoDraw(true);
    }

    
    // *continueButton7* updates
    if (t >= 0.0 && continueButton7.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueButton7.tStart = t;  // (not accounting for frame time here)
      continueButton7.frameNStart = frameN;  // exact frame index
      
      continueButton7.setAutoDraw(true);
    }

    
    // *continueTextBlock_7* updates
    if (t >= 0.0 && continueTextBlock_7.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueTextBlock_7.tStart = t;  // (not accounting for frame time here)
      continueTextBlock_7.frameNStart = frameN;  // exact frame index
      
      continueTextBlock_7.setAutoDraw(true);
    }

    // *continueClick_7* updates
    if (t >= 0.0 && continueClick_7.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueClick_7.tStart = t;  // (not accounting for frame time here)
      continueClick_7.frameNStart = frameN;  // exact frame index
      
      continueClick_7.status = PsychoJS.Status.STARTED;
      continueClick_7.mouseClock.reset();
      prevButtonState = continueClick_7.getPressed();  // if button is down already this ISN'T a new click
      }
    if (continueClick_7.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = continueClick_7.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [continueButton7]) {
            if (obj.contains(continueClick_7)) {
              gotValidClick = true;
              continueClick_7.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of Rules7Components)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function Rules7RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'Rules7' ---
    for (const thisComponent of Rules7Components) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "Rules7" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var Rules8Components;
function Rules8RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'Rules8' ---
    t = 0;
    Rules8Clock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    introductionScreen_8.setImage(intro8);
    continueTextBlock_8.setText(continueText);
    // setup some python lists for storing info about the continueClick_8
    continueClick_8.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    Rules8Components = [];
    Rules8Components.push(introductionScreen_8);
    Rules8Components.push(continueButton8);
    Rules8Components.push(continueTextBlock_8);
    Rules8Components.push(continueClick_8);
    
    for (const thisComponent of Rules8Components)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function Rules8RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'Rules8' ---
    // get current time
    t = Rules8Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *introductionScreen_8* updates
    if (t >= 0.0 && introductionScreen_8.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      introductionScreen_8.tStart = t;  // (not accounting for frame time here)
      introductionScreen_8.frameNStart = frameN;  // exact frame index
      
      introductionScreen_8.setAutoDraw(true);
    }

    
    // *continueButton8* updates
    if (t >= 0.0 && continueButton8.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueButton8.tStart = t;  // (not accounting for frame time here)
      continueButton8.frameNStart = frameN;  // exact frame index
      
      continueButton8.setAutoDraw(true);
    }

    
    // *continueTextBlock_8* updates
    if (t >= 0.0 && continueTextBlock_8.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueTextBlock_8.tStart = t;  // (not accounting for frame time here)
      continueTextBlock_8.frameNStart = frameN;  // exact frame index
      
      continueTextBlock_8.setAutoDraw(true);
    }

    // *continueClick_8* updates
    if (t >= 0.0 && continueClick_8.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueClick_8.tStart = t;  // (not accounting for frame time here)
      continueClick_8.frameNStart = frameN;  // exact frame index
      
      continueClick_8.status = PsychoJS.Status.STARTED;
      continueClick_8.mouseClock.reset();
      prevButtonState = continueClick_8.getPressed();  // if button is down already this ISN'T a new click
      }
    if (continueClick_8.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = continueClick_8.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [continueButton8]) {
            if (obj.contains(continueClick_8)) {
              gotValidClick = true;
              continueClick_8.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of Rules8Components)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function Rules8RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'Rules8' ---
    for (const thisComponent of Rules8Components) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "Rules8" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var Rules9Components;
function Rules9RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'Rules9' ---
    t = 0;
    Rules9Clock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    introductionScreen_9.setImage(intro9);
    continueTextBlock_9.setText(continueText);
    // setup some python lists for storing info about the continueClick_9
    continueClick_9.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    Rules9Components = [];
    Rules9Components.push(introductionScreen_9);
    Rules9Components.push(continueButton9);
    Rules9Components.push(continueTextBlock_9);
    Rules9Components.push(continueClick_9);
    
    for (const thisComponent of Rules9Components)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function Rules9RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'Rules9' ---
    // get current time
    t = Rules9Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *introductionScreen_9* updates
    if (t >= 0.0 && introductionScreen_9.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      introductionScreen_9.tStart = t;  // (not accounting for frame time here)
      introductionScreen_9.frameNStart = frameN;  // exact frame index
      
      introductionScreen_9.setAutoDraw(true);
    }

    
    // *continueButton9* updates
    if (t >= 0.0 && continueButton9.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueButton9.tStart = t;  // (not accounting for frame time here)
      continueButton9.frameNStart = frameN;  // exact frame index
      
      continueButton9.setAutoDraw(true);
    }

    
    // *continueTextBlock_9* updates
    if (t >= 0.0 && continueTextBlock_9.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueTextBlock_9.tStart = t;  // (not accounting for frame time here)
      continueTextBlock_9.frameNStart = frameN;  // exact frame index
      
      continueTextBlock_9.setAutoDraw(true);
    }

    // *continueClick_9* updates
    if (t >= 0.0 && continueClick_9.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueClick_9.tStart = t;  // (not accounting for frame time here)
      continueClick_9.frameNStart = frameN;  // exact frame index
      
      continueClick_9.status = PsychoJS.Status.STARTED;
      continueClick_9.mouseClock.reset();
      prevButtonState = continueClick_9.getPressed();  // if button is down already this ISN'T a new click
      }
    if (continueClick_9.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = continueClick_9.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [continueButton9]) {
            if (obj.contains(continueClick_9)) {
              gotValidClick = true;
              continueClick_9.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of Rules9Components)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function Rules9RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'Rules9' ---
    for (const thisComponent of Rules9Components) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "Rules9" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var Rules10Components;
function Rules10RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'Rules10' ---
    t = 0;
    Rules10Clock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    introductionScreen_10.setImage(intro10);
    continueTextBlock_10.setText(playText);
    // setup some python lists for storing info about the continueClick_10
    continueClick_10.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    Rules10Components = [];
    Rules10Components.push(introductionScreen_10);
    Rules10Components.push(continueButton10);
    Rules10Components.push(continueTextBlock_10);
    Rules10Components.push(continueClick_10);
    
    for (const thisComponent of Rules10Components)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function Rules10RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'Rules10' ---
    // get current time
    t = Rules10Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *introductionScreen_10* updates
    if (t >= 0.0 && introductionScreen_10.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      introductionScreen_10.tStart = t;  // (not accounting for frame time here)
      introductionScreen_10.frameNStart = frameN;  // exact frame index
      
      introductionScreen_10.setAutoDraw(true);
    }

    
    // *continueButton10* updates
    if (t >= 0.0 && continueButton10.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueButton10.tStart = t;  // (not accounting for frame time here)
      continueButton10.frameNStart = frameN;  // exact frame index
      
      continueButton10.setAutoDraw(true);
    }

    
    // *continueTextBlock_10* updates
    if (t >= 0.0 && continueTextBlock_10.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueTextBlock_10.tStart = t;  // (not accounting for frame time here)
      continueTextBlock_10.frameNStart = frameN;  // exact frame index
      
      continueTextBlock_10.setAutoDraw(true);
    }

    // *continueClick_10* updates
    if (t >= 0.0 && continueClick_10.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueClick_10.tStart = t;  // (not accounting for frame time here)
      continueClick_10.frameNStart = frameN;  // exact frame index
      
      continueClick_10.status = PsychoJS.Status.STARTED;
      continueClick_10.mouseClock.reset();
      prevButtonState = continueClick_10.getPressed();  // if button is down already this ISN'T a new click
      }
    if (continueClick_10.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = continueClick_10.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [continueButton10]) {
            if (obj.contains(continueClick_10)) {
              gotValidClick = true;
              continueClick_10.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of Rules10Components)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function Rules10RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'Rules10' ---
    for (const thisComponent of Rules10Components) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "Rules10" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var IntroductionComponents;
function IntroductionRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'Introduction' ---
    t = 0;
    IntroductionClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    playTextBlock.setText(playText);
    // setup some python lists for storing info about the playClick
    playClick.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    IntroductionComponents = [];
    IntroductionComponents.push(titleScreen);
    IntroductionComponents.push(playButton);
    IntroductionComponents.push(playTextBlock);
    IntroductionComponents.push(playClick);
    
    for (const thisComponent of IntroductionComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function IntroductionRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'Introduction' ---
    // get current time
    t = IntroductionClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *titleScreen* updates
    if (t >= 0.0 && titleScreen.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      titleScreen.tStart = t;  // (not accounting for frame time here)
      titleScreen.frameNStart = frameN;  // exact frame index
      
      titleScreen.setAutoDraw(true);
    }

    
    // *playButton* updates
    if (t >= 0.0 && playButton.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      playButton.tStart = t;  // (not accounting for frame time here)
      playButton.frameNStart = frameN;  // exact frame index
      
      playButton.setAutoDraw(true);
    }

    
    // *playTextBlock* updates
    if (t >= 0.0 && playTextBlock.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      playTextBlock.tStart = t;  // (not accounting for frame time here)
      playTextBlock.frameNStart = frameN;  // exact frame index
      
      playTextBlock.setAutoDraw(true);
    }

    // *playClick* updates
    if (t >= 0.0 && playClick.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      playClick.tStart = t;  // (not accounting for frame time here)
      playClick.frameNStart = frameN;  // exact frame index
      
      playClick.status = PsychoJS.Status.STARTED;
      playClick.mouseClock.reset();
      prevButtonState = playClick.getPressed();  // if button is down already this ISN'T a new click
      }
    if (playClick.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = playClick.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [playButton]) {
            if (obj.contains(playClick)) {
              gotValidClick = true;
              playClick.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of IntroductionComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function IntroductionRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'Introduction' ---
    for (const thisComponent of IntroductionComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "Introduction" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var IntroductionButtonPressedComponents;
function IntroductionButtonPressedRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'IntroductionButtonPressed' ---
    t = 0;
    IntroductionButtonPressedClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    routineTimer.add(0.150000);
    // update component parameters for each repeat
    playTextBlock_2.setText(playText);
    // keep track of which components have finished
    IntroductionButtonPressedComponents = [];
    IntroductionButtonPressedComponents.push(titleScreen_2);
    IntroductionButtonPressedComponents.push(playButton_2);
    IntroductionButtonPressedComponents.push(playTextBlock_2);
    
    for (const thisComponent of IntroductionButtonPressedComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function IntroductionButtonPressedRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'IntroductionButtonPressed' ---
    // get current time
    t = IntroductionButtonPressedClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *titleScreen_2* updates
    if (t >= 0.0 && titleScreen_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      titleScreen_2.tStart = t;  // (not accounting for frame time here)
      titleScreen_2.frameNStart = frameN;  // exact frame index
      
      titleScreen_2.setAutoDraw(true);
    }

    frameRemains = 0.15  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((titleScreen_2.status === PsychoJS.Status.STARTED || titleScreen_2.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      titleScreen_2.setAutoDraw(false);
    }
    
    // *playButton_2* updates
    if (t >= 0.0 && playButton_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      playButton_2.tStart = t;  // (not accounting for frame time here)
      playButton_2.frameNStart = frameN;  // exact frame index
      
      playButton_2.setAutoDraw(true);
    }

    frameRemains = 0.15  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((playButton_2.status === PsychoJS.Status.STARTED || playButton_2.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      playButton_2.setAutoDraw(false);
    }
    
    // *playTextBlock_2* updates
    if (t >= 0.0 && playTextBlock_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      playTextBlock_2.tStart = t;  // (not accounting for frame time here)
      playTextBlock_2.frameNStart = frameN;  // exact frame index
      
      playTextBlock_2.setAutoDraw(true);
    }

    frameRemains = 0.15  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((playTextBlock_2.status === PsychoJS.Status.STARTED || playTextBlock_2.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      playTextBlock_2.setAutoDraw(false);
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of IntroductionButtonPressedComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine && routineTimer.getTime() > 0) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function IntroductionButtonPressedRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'IntroductionButtonPressed' ---
    for (const thisComponent of IntroductionButtonPressedComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var beginningScreenComponents;
function beginningScreenRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'beginningScreen' ---
    t = 0;
    beginningScreenClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    routineTimer.add(1.000000);
    // update component parameters for each repeat
    emptyBackground_4.setImage('resources/alternative_screen2.png');
    languageText_4.setText(beginningStatement);
    // keep track of which components have finished
    beginningScreenComponents = [];
    beginningScreenComponents.push(emptyBackground_4);
    beginningScreenComponents.push(languageText_4);
    
    for (const thisComponent of beginningScreenComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function beginningScreenRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'beginningScreen' ---
    // get current time
    t = beginningScreenClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *emptyBackground_4* updates
    if (t >= 0.0 && emptyBackground_4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      emptyBackground_4.tStart = t;  // (not accounting for frame time here)
      emptyBackground_4.frameNStart = frameN;  // exact frame index
      
      emptyBackground_4.setAutoDraw(true);
    }

    frameRemains = 0.0 + 1 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (emptyBackground_4.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      emptyBackground_4.setAutoDraw(false);
    }
    
    // *languageText_4* updates
    if (t >= 0.0 && languageText_4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      languageText_4.tStart = t;  // (not accounting for frame time here)
      languageText_4.frameNStart = frameN;  // exact frame index
      
      languageText_4.setAutoDraw(true);
    }

    frameRemains = 0.0 + 1 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (languageText_4.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      languageText_4.setAutoDraw(false);
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of beginningScreenComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine && routineTimer.getTime() > 0) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function beginningScreenRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'beginningScreen' ---
    for (const thisComponent of beginningScreenComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var backgroundPath;
var SetupTheSceneComponents;
function SetupTheSceneRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'SetupTheScene' ---
    t = 0;
    SetupTheSceneClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    // Run 'Begin Routine' code from LabSceneSetupCode
    //set background image path for the current session
    backgroundPath = ("resources/lab_background_" + session_n + ".png").toString();
    backgroundImage.setImage(backgroundPath);
    leftNotepad.setPos([((- 0.4) - notepadAdjustingX), 0]);
    leftNotepad.setSize([(0.35 * notepad_xy_ratio), 0.35]);
    leftNotepad.setImage(currentNotepadImage);
    rightNotepad.setPos([(0.4 - (notepadAdjustingX * 2)), 0]);
    rightNotepad.setSize([(0.35 * notepad_xy_ratio), 0.35]);
    rightNotepad.setImage(currentNotepadImage);
    scoreboardImage.setImage(currentScoreboardImage);
    // keep track of which components have finished
    SetupTheSceneComponents = [];
    SetupTheSceneComponents.push(backgroundImage);
    SetupTheSceneComponents.push(leftNotepad);
    SetupTheSceneComponents.push(rightNotepad);
    SetupTheSceneComponents.push(scoreboardImage);
    
    for (const thisComponent of SetupTheSceneComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function SetupTheSceneRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'SetupTheScene' ---
    // get current time
    t = SetupTheSceneClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *backgroundImage* updates
    if (t >= 0 && backgroundImage.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      backgroundImage.tStart = t;  // (not accounting for frame time here)
      backgroundImage.frameNStart = frameN;  // exact frame index
      
      backgroundImage.setAutoDraw(true);
    }

    frameRemains = 0  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((backgroundImage.status === PsychoJS.Status.STARTED || backgroundImage.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      backgroundImage.setAutoDraw(false);
    }
    
    // *leftNotepad* updates
    if (t >= 0.0 && leftNotepad.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      leftNotepad.tStart = t;  // (not accounting for frame time here)
      leftNotepad.frameNStart = frameN;  // exact frame index
      
      leftNotepad.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (leftNotepad.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      leftNotepad.setAutoDraw(false);
    }
    
    // *rightNotepad* updates
    if (t >= 0.0 && rightNotepad.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      rightNotepad.tStart = t;  // (not accounting for frame time here)
      rightNotepad.frameNStart = frameN;  // exact frame index
      
      rightNotepad.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (rightNotepad.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      rightNotepad.setAutoDraw(false);
    }
    
    // *scoreboardImage* updates
    if (t >= 0.0 && scoreboardImage.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      scoreboardImage.tStart = t;  // (not accounting for frame time here)
      scoreboardImage.frameNStart = frameN;  // exact frame index
      
      scoreboardImage.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (scoreboardImage.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      scoreboardImage.setAutoDraw(false);
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of SetupTheSceneComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function SetupTheSceneRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'SetupTheScene' ---
    for (const thisComponent of SetupTheSceneComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // Run 'End Routine' code from LabSceneSetupCode
    //automatically renew scene images at the start of each routine
    backgroundImage.setAutoDraw(true);
    leftNotepad.setAutoDraw(true);
    rightNotepad.setAutoDraw(true);
    scoreboardImage.setAutoDraw(true);
    
    // the Routine "SetupTheScene" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var rewardBgColor;
var leftCuredInt;
var rightCuredInt;
var leftCuredNum;
var rightCuredNum;
var correctCure;
var leftFeedbackImage;
var rightFeedbackImage;
var currentCorrectCure;
var previousCorrectCure;
var leftProbability;
var rightProbability;
var scoreBoardText;
var _keyChoice_allKeys;
var trialSetupComponents;
function trialSetupRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'trialSetup' ---
    t = 0;
    trialSetupClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    // Run 'Begin Routine' code from TrialSetupCode
    if ((currentTrial === 0)) { //for the very first trial
        rewardBgColor = "white"; //background color in circle is white
    } else { //for all other trials
        if ((correctCure == "left")) { //if left syringe is correct
            rewardBgColor = leftSyringeColor; //set background color to color of left syringe
        }else{
            if ((correctCure == "right")) { //if right syringe is correct
                rewardBgColor = rightSyringeColor; //set background color to color of right syringe
            }
        }
    }
    //choose random numbers for how many people would be cured on either side
    leftCuredInt = Number.parseInt(Math.random() * (99 - 1) + 1); //min 1, max 99
    rightCuredInt = Number.parseInt((100 - leftCuredInt)); //set right side based on left side, together = 100
    //generate strings to display the numbers on the notepads
    leftCuredNum = leftCuredInt.toString();
    rightCuredNum = (100 - leftCuredInt).toString();
    
    //choose the correct cure based on the calculated probabilities
    correctCure = weighted_random(["left", "right"], [allProbabilities[currentTrial], antiProbabilities[currentTrial]]);
    if ((correctCure === "left")) { //if the left syringe is correct
        //set feedback images accordingly
        leftFeedbackImage = "resources/correct.png";
        rightFeedbackImage = "resources/wrong.png";
    } else { //vice versa
        leftFeedbackImage = "resources/wrong.png";
        rightFeedbackImage = "resources/correct.png";
        correctColor = rightSyringeColor;
    }
    correctChoicesList.push(correctCure); //add the current correct choice
    currentCorrectCure = correctChoicesList[currentTrial];
    if ((currentTrial !== 0)) { //for all trials except the first one
        previousCorrectCure = correctChoicesList[(currentTrial - 1)]; //take previous correct cure from list
    } 
    
    leftProbability = util.round(allProbabilities[currentTrial], 2); 
    rightProbability = util.round(antiProbabilities[currentTrial], 2);
    
    currentTrial = (currentTrial + 1); //increase trial number for next trial
    //set scoreboard text based on level, round, and score
    scoreBoardText = (score_text + score_n.toString() + "\n" + round_text1 + round_n.toString() + round_text2 + "\n" + level_text + session_n.toString()).toString();
    rewardBackgroundCircle.setFillColor(new util.Color(rewardBgColor));
    leftSyringe.setImage(leftFullSyringeImage);
    rightSyringe.setImage(rightFullSyringeImage);
    leftNoteText.setText(leftCuredNum);
    rightNoteText.setText(rightCuredNum);
    scoreBoardTextbox.setText(scoreBoardText);
    // setup some python lists for storing info about the syringeChoice
    // current position of the mouse:
    syringeChoice.x = [];
    syringeChoice.y = [];
    syringeChoice.leftButton = [];
    syringeChoice.midButton = [];
    syringeChoice.rightButton = [];
    syringeChoice.time = [];
    syringeChoice.clicked_name = [];
    gotValidClick = false; // until a click is received
    keyChoice.keys = undefined;
    keyChoice.rt = undefined;
    _keyChoice_allKeys = [];
    // keep track of which components have finished
    trialSetupComponents = [];
    trialSetupComponents.push(rewardBackgroundCircle);
    trialSetupComponents.push(leftSyringe);
    trialSetupComponents.push(rightSyringe);
    trialSetupComponents.push(leftNoteText);
    trialSetupComponents.push(rightNoteText);
    trialSetupComponents.push(scoreBoardTextbox);
    trialSetupComponents.push(syringeChoice);
    trialSetupComponents.push(keyChoice);
    
    for (const thisComponent of trialSetupComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function trialSetupRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'trialSetup' ---
    // get current time
    t = trialSetupClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *rewardBackgroundCircle* updates
    if (t >= 0.0 && rewardBackgroundCircle.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      rewardBackgroundCircle.tStart = t;  // (not accounting for frame time here)
      rewardBackgroundCircle.frameNStart = frameN;  // exact frame index
      
      rewardBackgroundCircle.setAutoDraw(true);
    }

    
    // *leftSyringe* updates
    if (t >= 0.0 && leftSyringe.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      leftSyringe.tStart = t;  // (not accounting for frame time here)
      leftSyringe.frameNStart = frameN;  // exact frame index
      
      leftSyringe.setAutoDraw(true);
    }

    
    // *rightSyringe* updates
    if (t >= 0.0 && rightSyringe.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      rightSyringe.tStart = t;  // (not accounting for frame time here)
      rightSyringe.frameNStart = frameN;  // exact frame index
      
      rightSyringe.setAutoDraw(true);
    }

    
    // *leftNoteText* updates
    if (t >= 0.0 && leftNoteText.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      leftNoteText.tStart = t;  // (not accounting for frame time here)
      leftNoteText.frameNStart = frameN;  // exact frame index
      
      leftNoteText.setAutoDraw(true);
    }

    
    // *rightNoteText* updates
    if (t >= 0.0 && rightNoteText.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      rightNoteText.tStart = t;  // (not accounting for frame time here)
      rightNoteText.frameNStart = frameN;  // exact frame index
      
      rightNoteText.setAutoDraw(true);
    }

    
    // *scoreBoardTextbox* updates
    if (t >= 0.0 && scoreBoardTextbox.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      scoreBoardTextbox.tStart = t;  // (not accounting for frame time here)
      scoreBoardTextbox.frameNStart = frameN;  // exact frame index
      
      scoreBoardTextbox.setAutoDraw(true);
    }

    // *syringeChoice* updates
    if ((cond_touch) && syringeChoice.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      syringeChoice.tStart = t;  // (not accounting for frame time here)
      syringeChoice.frameNStart = frameN;  // exact frame index
      
      syringeChoice.status = PsychoJS.Status.STARTED;
      syringeChoice.mouseClock.reset();
      prevButtonState = syringeChoice.getPressed();  // if button is down already this ISN'T a new click
      }
    if (syringeChoice.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = syringeChoice.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [leftSyringe, rightSyringe]) {
            if (obj.contains(syringeChoice)) {
              gotValidClick = true;
              syringeChoice.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { 
            _mouseXYs = syringeChoice.getPos();
            syringeChoice.x.push(_mouseXYs[0]);
            syringeChoice.y.push(_mouseXYs[1]);
            syringeChoice.leftButton.push(_mouseButtons[0]);
            syringeChoice.midButton.push(_mouseButtons[1]);
            syringeChoice.rightButton.push(_mouseButtons[2]);
            syringeChoice.time.push(syringeChoice.mouseClock.getTime());
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    
    // *keyChoice* updates
    if ((cond_key) && keyChoice.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      keyChoice.tStart = t;  // (not accounting for frame time here)
      keyChoice.frameNStart = frameN;  // exact frame index
      
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { keyChoice.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { keyChoice.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { keyChoice.clearEvents(); });
    }

    if (keyChoice.status === PsychoJS.Status.STARTED) {
      let theseKeys = keyChoice.getKeys({keyList: ['left', 'right'], waitRelease: false});
      _keyChoice_allKeys = _keyChoice_allKeys.concat(theseKeys);
      if (_keyChoice_allKeys.length > 0) {
        keyChoice.keys = _keyChoice_allKeys[_keyChoice_allKeys.length - 1].name;  // just the last key pressed
        keyChoice.rt = _keyChoice_allKeys[_keyChoice_allKeys.length - 1].rt;
        // a response ends the routine
        continueRoutine = false;
      }
    }
    
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of trialSetupComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function trialSetupRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'trialSetup' ---
    for (const thisComponent of trialSetupComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // Run 'End Routine' code from TrialSetupCode
    //automatically renew background circle and reward images
    rewardBackgroundCircle.setAutoDraw(true);
    
    // store data for psychoJS.experiment (ExperimentHandler)
    if (syringeChoice.x) {  psychoJS.experiment.addData('syringeChoice.x', syringeChoice.x[0])};
    if (syringeChoice.y) {  psychoJS.experiment.addData('syringeChoice.y', syringeChoice.y[0])};
    if (syringeChoice.leftButton) {  psychoJS.experiment.addData('syringeChoice.leftButton', syringeChoice.leftButton[0])};
    if (syringeChoice.midButton) {  psychoJS.experiment.addData('syringeChoice.midButton', syringeChoice.midButton[0])};
    if (syringeChoice.rightButton) {  psychoJS.experiment.addData('syringeChoice.rightButton', syringeChoice.rightButton[0])};
    if (syringeChoice.time) {  psychoJS.experiment.addData('syringeChoice.time', syringeChoice.time[0])};
    if (syringeChoice.clicked_name) {  psychoJS.experiment.addData('syringeChoice.clicked_name', syringeChoice.clicked_name[0])};
    
    // update the trial handler
    if (currentLoop instanceof MultiStairHandler) {
      currentLoop.addResponse(keyChoice.corr, level);
    }
    psychoJS.experiment.addData('keyChoice.keys', keyChoice.keys);
    if (typeof keyChoice.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('keyChoice.rt', keyChoice.rt);
        routineTimer.reset();
        }
    
    keyChoice.stop();
    // the Routine "trialSetup" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var choice_name;
var leftSyringe_clicked;
var rightSyringe_clicked;
var trialFeedbackComponents;
function trialFeedbackRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'trialFeedback' ---
    t = 0;
    trialFeedbackClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    // Get reaction "left" or "right"
    if(mobile_device){
        if ((syringeChoice.clicked_name.slice((- 1))[0] === "leftSyringe")) {   
            choice_name = "left";
        } else if (syringeChoice.clicked_name.slice((- 1))[0] === "rightSyringe") {
            choice_name = "right";
        }
    } else {
        choice_name = keyChoice.keys;
    }
    
    if (choice_name === "left") { 
        leftSyringe_clicked = leftEmptySyringeImage; 
        rightSyringe_clicked = rightFullSyringeImage;
    } else if (choice_name === "right") {
        leftSyringe_clicked = leftFullSyringeImage; 
        rightSyringe_clicked = rightEmptySyringeImage;
    }
    
    console.log(choice_name);
    
    //if ((syringeChoice.clicked_name.slice((- 1))[0] === "leftSyringe")) { //if player chose the correct syringe
    //    leftSyringe_clicked = leftEmptySyringeImage; 
    //    rightSyringe_clicked = rightFullSyringeImage;
    //} else if (syringeChoice.clicked_name.slice((- 1))[0] === "rightSyringe") {
    //    leftSyringe_clicked = leftFullSyringeImage; 
    //    rightSyringe_clicked = rightEmptySyringeImage;
    //}
    
    
    
    
    
    rewardBackgroundCircle_2.setFillColor(new util.Color(rewardBgColor));
    leftSyringe_2.setImage(leftSyringe_clicked);
    rightSyringe_2.setImage(rightSyringe_clicked);
    leftNoteText_2.setText(leftCuredNum);
    rightNoteText_2.setText(rightCuredNum);
    scoreBoardTextbox_2.setText(scoreBoardText);
    leftLabFeedback_2.setImage(leftFeedbackImage);
    rightLabFeedback_2.setImage(rightFeedbackImage);
    // keep track of which components have finished
    trialFeedbackComponents = [];
    trialFeedbackComponents.push(rewardBackgroundCircle_2);
    trialFeedbackComponents.push(leftSyringe_2);
    trialFeedbackComponents.push(rightSyringe_2);
    trialFeedbackComponents.push(leftNoteText_2);
    trialFeedbackComponents.push(rightNoteText_2);
    trialFeedbackComponents.push(scoreBoardTextbox_2);
    trialFeedbackComponents.push(leftLabFeedback_2);
    trialFeedbackComponents.push(rightLabFeedback_2);
    
    for (const thisComponent of trialFeedbackComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function trialFeedbackRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'trialFeedback' ---
    // get current time
    t = trialFeedbackClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *rewardBackgroundCircle_2* updates
    if (t >= 0.0 && rewardBackgroundCircle_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      rewardBackgroundCircle_2.tStart = t;  // (not accounting for frame time here)
      rewardBackgroundCircle_2.frameNStart = frameN;  // exact frame index
      
      rewardBackgroundCircle_2.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (rewardBackgroundCircle_2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      rewardBackgroundCircle_2.setAutoDraw(false);
    }
    
    // *leftSyringe_2* updates
    if (t >= 0.0 && leftSyringe_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      leftSyringe_2.tStart = t;  // (not accounting for frame time here)
      leftSyringe_2.frameNStart = frameN;  // exact frame index
      
      leftSyringe_2.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (leftSyringe_2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      leftSyringe_2.setAutoDraw(false);
    }
    
    // *rightSyringe_2* updates
    if (t >= 0.0 && rightSyringe_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      rightSyringe_2.tStart = t;  // (not accounting for frame time here)
      rightSyringe_2.frameNStart = frameN;  // exact frame index
      
      rightSyringe_2.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (rightSyringe_2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      rightSyringe_2.setAutoDraw(false);
    }
    
    // *leftNoteText_2* updates
    if (t >= 0.0 && leftNoteText_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      leftNoteText_2.tStart = t;  // (not accounting for frame time here)
      leftNoteText_2.frameNStart = frameN;  // exact frame index
      
      leftNoteText_2.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (leftNoteText_2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      leftNoteText_2.setAutoDraw(false);
    }
    
    // *rightNoteText_2* updates
    if (t >= 0.0 && rightNoteText_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      rightNoteText_2.tStart = t;  // (not accounting for frame time here)
      rightNoteText_2.frameNStart = frameN;  // exact frame index
      
      rightNoteText_2.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (rightNoteText_2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      rightNoteText_2.setAutoDraw(false);
    }
    
    // *scoreBoardTextbox_2* updates
    if (t >= 0.0 && scoreBoardTextbox_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      scoreBoardTextbox_2.tStart = t;  // (not accounting for frame time here)
      scoreBoardTextbox_2.frameNStart = frameN;  // exact frame index
      
      scoreBoardTextbox_2.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (scoreBoardTextbox_2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      scoreBoardTextbox_2.setAutoDraw(false);
    }
    
    // *leftLabFeedback_2* updates
    if (t >= 0.0 && leftLabFeedback_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      leftLabFeedback_2.tStart = t;  // (not accounting for frame time here)
      leftLabFeedback_2.frameNStart = frameN;  // exact frame index
      
      leftLabFeedback_2.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (leftLabFeedback_2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      leftLabFeedback_2.setAutoDraw(false);
    }
    
    // *rightLabFeedback_2* updates
    if (t >= 0.0 && rightLabFeedback_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      rightLabFeedback_2.tStart = t;  // (not accounting for frame time here)
      rightLabFeedback_2.frameNStart = frameN;  // exact frame index
      
      rightLabFeedback_2.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (rightLabFeedback_2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      rightLabFeedback_2.setAutoDraw(false);
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of trialFeedbackComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


var correctlyDone;
var rewardImageSize;
var coinCircleSize;
var circleColor;
function trialFeedbackRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'trialFeedback' ---
    for (const thisComponent of trialFeedbackComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // Run 'End Routine' code from getFeedback
    if ((choice_name == correctCure)) { //if player chose the correct syringe
        correctlyDone = 1; //set to 1
        rewardImageSize = (0.1, 0.13);
        coinCircleSize = 0.129;
        circleColor = "white";
    } else {
        correctlyDone = 0; //or 0 if wrong
        rewardImageSize = (0, 0);
        coinCircleSize = 0;
        circleColor = rewardBgColor;
    }
    
    console.log(correctCure);
    console.log(correctlyDone);
    
    //automatically redraw all scene images
    //leftNotepad.setAutoDraw(false);
    //rightNotepad.setAutoDraw(false);
    leftLabFeedback_2.setAutoDraw(true);
    rightLabFeedback_2.setAutoDraw(true);
    
    // the Routine "trialFeedback" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var leftFeedbackColor;
var rightFeedbackColor;
var trialOutputComponents;
function trialOutputRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'trialOutput' ---
    t = 0;
    trialOutputClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    // Run 'Begin Routine' code from feedbackColors_saveData
    if ((correctCure === "left")) { //if left syringe was correct
        if ((correctlyDone === 1)) { //and player chose correctly
            leftFeedbackColor = "green"; //set text color of chosen side to green
            rightFeedbackColor = "black"; //right remains black
            score_n = Number.parseInt((score_n + leftCuredInt)); //add number of cured people to score
        } else { //if play chose wrong syringe
            leftFeedbackColor = "black";
            rightFeedbackColor = "red"; //set text color of chosen side to red
            score_n = Number.parseInt((score_n - rightCuredInt)); //substract number of people from score
        }
    } else { //vice verso for the right side
        if ((correctlyDone === 1)) {
            leftFeedbackColor = "black";
            rightFeedbackColor = "green";
            score_n = Number.parseInt((score_n + rightCuredInt));
        } else {
            leftFeedbackColor = "red";
            rightFeedbackColor = "black";
            score_n = Number.parseInt((score_n - leftCuredInt));
        }
    }
    
    scoreBoardText = score_text + score_n.toString() + "\n" + round_text1 + round_n.toString() + round_text2 + "\n" + level_text + session_n.toString();
    
    round_n = (round_n + 1); //increase round number for the next round
    
    //automatically draw notepad images
    //leftNotepad.setAutoDraw(true);
    //rightNotepad.setAutoDraw(true);
    leftSyringe_2.setAutoDraw(true);
    rightSyringe_2.setAutoDraw(true);
    //rewardBackgroundCircle.setAutoDraw(true);
    
    leftNotepad_2.setPos([((- 0.4) - notepadAdjustingX), 0]);
    leftNotepad_2.setSize([(0.35 * notepad_xy_ratio), 0.35]);
    leftNotepad_2.setImage(currentNotepadImage);
    rightNotepad_2.setPos([(0.4 - (notepadAdjustingX * 2)), 0]);
    rightNotepad_2.setSize([(0.35 * notepad_xy_ratio), 0.35]);
    rightNotepad_2.setImage(currentNotepadImage);
    leftSyringe_3.setImage(leftSyringe_clicked);
    rightSyringe_3.setImage(rightSyringe_clicked);
    coinCircle.setFillColor(new util.Color(circleColor));
    coinCircle.setSize([coinCircleSize, 0.14]);
    coinCircle.setLineColor(new util.Color(circleColor));
    rewardImage.setSize(rewardImageSize);
    leftNoteText_1.setColor(new util.Color(leftFeedbackColor));
    leftNoteText_1.setText(leftCuredNum);
    rightNoteText_1.setColor(new util.Color(rightFeedbackColor));
    rightNoteText_1.setText(rightCuredNum);
    continueButtonText.setText(continueText);
    scoreBoardTextbox_3.setText(scoreBoardText);
    // setup some python lists for storing info about the continueClick
    continueClick.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    trialOutputComponents = [];
    trialOutputComponents.push(leftNotepad_2);
    trialOutputComponents.push(rightNotepad_2);
    trialOutputComponents.push(leftSyringe_3);
    trialOutputComponents.push(rightSyringe_3);
    trialOutputComponents.push(coinCircle);
    trialOutputComponents.push(rewardImage);
    trialOutputComponents.push(leftNoteText_1);
    trialOutputComponents.push(rightNoteText_1);
    trialOutputComponents.push(continueButtonBackground);
    trialOutputComponents.push(continueButtonText);
    trialOutputComponents.push(scoreBoardTextbox_3);
    trialOutputComponents.push(continueClick);
    
    for (const thisComponent of trialOutputComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function trialOutputRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'trialOutput' ---
    // get current time
    t = trialOutputClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *leftNotepad_2* updates
    if (t >= 0.0 && leftNotepad_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      leftNotepad_2.tStart = t;  // (not accounting for frame time here)
      leftNotepad_2.frameNStart = frameN;  // exact frame index
      
      leftNotepad_2.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (leftNotepad_2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      leftNotepad_2.setAutoDraw(false);
    }
    
    // *rightNotepad_2* updates
    if (t >= 0.0 && rightNotepad_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      rightNotepad_2.tStart = t;  // (not accounting for frame time here)
      rightNotepad_2.frameNStart = frameN;  // exact frame index
      
      rightNotepad_2.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (rightNotepad_2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      rightNotepad_2.setAutoDraw(false);
    }
    
    // *leftSyringe_3* updates
    if (t >= 0.0 && leftSyringe_3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      leftSyringe_3.tStart = t;  // (not accounting for frame time here)
      leftSyringe_3.frameNStart = frameN;  // exact frame index
      
      leftSyringe_3.setAutoDraw(true);
    }

    
    // *rightSyringe_3* updates
    if (t >= 0.0 && rightSyringe_3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      rightSyringe_3.tStart = t;  // (not accounting for frame time here)
      rightSyringe_3.frameNStart = frameN;  // exact frame index
      
      rightSyringe_3.setAutoDraw(true);
    }

    
    // *coinCircle* updates
    if (t >= 0.0 && coinCircle.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      coinCircle.tStart = t;  // (not accounting for frame time here)
      coinCircle.frameNStart = frameN;  // exact frame index
      
      coinCircle.setAutoDraw(true);
    }

    
    // *rewardImage* updates
    if (t >= 0.0 && rewardImage.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      rewardImage.tStart = t;  // (not accounting for frame time here)
      rewardImage.frameNStart = frameN;  // exact frame index
      
      rewardImage.setAutoDraw(true);
    }

    
    // *leftNoteText_1* updates
    if (t >= 0.0 && leftNoteText_1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      leftNoteText_1.tStart = t;  // (not accounting for frame time here)
      leftNoteText_1.frameNStart = frameN;  // exact frame index
      
      leftNoteText_1.setAutoDraw(true);
    }

    
    // *rightNoteText_1* updates
    if (t >= 0.0 && rightNoteText_1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      rightNoteText_1.tStart = t;  // (not accounting for frame time here)
      rightNoteText_1.frameNStart = frameN;  // exact frame index
      
      rightNoteText_1.setAutoDraw(true);
    }

    
    // *continueButtonBackground* updates
    if (t >= 0.4 && continueButtonBackground.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueButtonBackground.tStart = t;  // (not accounting for frame time here)
      continueButtonBackground.frameNStart = frameN;  // exact frame index
      
      continueButtonBackground.setAutoDraw(true);
    }

    
    // *continueButtonText* updates
    if (t >= 0.4 && continueButtonText.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueButtonText.tStart = t;  // (not accounting for frame time here)
      continueButtonText.frameNStart = frameN;  // exact frame index
      
      continueButtonText.setAutoDraw(true);
    }

    
    // *scoreBoardTextbox_3* updates
    if (t >= 0.0 && scoreBoardTextbox_3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      scoreBoardTextbox_3.tStart = t;  // (not accounting for frame time here)
      scoreBoardTextbox_3.frameNStart = frameN;  // exact frame index
      
      scoreBoardTextbox_3.setAutoDraw(true);
    }

    // *continueClick* updates
    if (t >= 0.0 && continueClick.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueClick.tStart = t;  // (not accounting for frame time here)
      continueClick.frameNStart = frameN;  // exact frame index
      
      continueClick.status = PsychoJS.Status.STARTED;
      continueClick.mouseClock.reset();
      prevButtonState = continueClick.getPressed();  // if button is down already this ISN'T a new click
      }
    if (continueClick.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = continueClick.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [continueButtonBackground]) {
            if (obj.contains(continueClick)) {
              gotValidClick = true;
              continueClick.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of trialOutputComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function trialOutputRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'trialOutput' ---
    for (const thisComponent of trialOutputComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "trialOutput" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var buttonPressedTrialComponents;
function buttonPressedTrialRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'buttonPressedTrial' ---
    t = 0;
    buttonPressedTrialClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    routineTimer.add(0.150000);
    // update component parameters for each repeat
    leftSyringe_4.setImage(leftSyringe_clicked);
    rightSyringe_4.setImage(rightSyringe_clicked);
    coinCircle_2.setFillColor(new util.Color(circleColor));
    coinCircle_2.setSize([coinCircleSize, 0.14]);
    coinCircle_2.setLineColor(new util.Color(circleColor));
    rewardImage_2.setSize(rewardImageSize);
    leftNoteText_3.setColor(new util.Color(leftFeedbackColor));
    leftNoteText_3.setText(leftCuredNum);
    rightNoteText_3.setColor(new util.Color(rightFeedbackColor));
    rightNoteText_3.setText(rightCuredNum);
    continueButtonText_2.setText(continueText);
    scoreBoardTextbox_4.setText(scoreBoardText);
    // keep track of which components have finished
    buttonPressedTrialComponents = [];
    buttonPressedTrialComponents.push(leftSyringe_4);
    buttonPressedTrialComponents.push(rightSyringe_4);
    buttonPressedTrialComponents.push(coinCircle_2);
    buttonPressedTrialComponents.push(rewardImage_2);
    buttonPressedTrialComponents.push(leftNoteText_3);
    buttonPressedTrialComponents.push(rightNoteText_3);
    buttonPressedTrialComponents.push(continueButtonBackground_2);
    buttonPressedTrialComponents.push(continueButtonText_2);
    buttonPressedTrialComponents.push(scoreBoardTextbox_4);
    
    for (const thisComponent of buttonPressedTrialComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function buttonPressedTrialRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'buttonPressedTrial' ---
    // get current time
    t = buttonPressedTrialClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *leftSyringe_4* updates
    if (t >= 0.0 && leftSyringe_4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      leftSyringe_4.tStart = t;  // (not accounting for frame time here)
      leftSyringe_4.frameNStart = frameN;  // exact frame index
      
      leftSyringe_4.setAutoDraw(true);
    }

    frameRemains = 0.15  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((leftSyringe_4.status === PsychoJS.Status.STARTED || leftSyringe_4.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      leftSyringe_4.setAutoDraw(false);
    }
    
    // *rightSyringe_4* updates
    if (t >= 0.0 && rightSyringe_4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      rightSyringe_4.tStart = t;  // (not accounting for frame time here)
      rightSyringe_4.frameNStart = frameN;  // exact frame index
      
      rightSyringe_4.setAutoDraw(true);
    }

    frameRemains = 0.15  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((rightSyringe_4.status === PsychoJS.Status.STARTED || rightSyringe_4.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      rightSyringe_4.setAutoDraw(false);
    }
    
    // *coinCircle_2* updates
    if (t >= 0.0 && coinCircle_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      coinCircle_2.tStart = t;  // (not accounting for frame time here)
      coinCircle_2.frameNStart = frameN;  // exact frame index
      
      coinCircle_2.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0.15 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (coinCircle_2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      coinCircle_2.setAutoDraw(false);
    }
    
    // *rewardImage_2* updates
    if (t >= 0.0 && rewardImage_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      rewardImage_2.tStart = t;  // (not accounting for frame time here)
      rewardImage_2.frameNStart = frameN;  // exact frame index
      
      rewardImage_2.setAutoDraw(true);
    }

    frameRemains = 0.15  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((rewardImage_2.status === PsychoJS.Status.STARTED || rewardImage_2.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      rewardImage_2.setAutoDraw(false);
    }
    
    // *leftNoteText_3* updates
    if (t >= 0.0 && leftNoteText_3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      leftNoteText_3.tStart = t;  // (not accounting for frame time here)
      leftNoteText_3.frameNStart = frameN;  // exact frame index
      
      leftNoteText_3.setAutoDraw(true);
    }

    frameRemains = 0.15  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((leftNoteText_3.status === PsychoJS.Status.STARTED || leftNoteText_3.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      leftNoteText_3.setAutoDraw(false);
    }
    
    // *rightNoteText_3* updates
    if (t >= 0.0 && rightNoteText_3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      rightNoteText_3.tStart = t;  // (not accounting for frame time here)
      rightNoteText_3.frameNStart = frameN;  // exact frame index
      
      rightNoteText_3.setAutoDraw(true);
    }

    frameRemains = 0.15  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((rightNoteText_3.status === PsychoJS.Status.STARTED || rightNoteText_3.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      rightNoteText_3.setAutoDraw(false);
    }
    
    // *continueButtonBackground_2* updates
    if (t >= 0 && continueButtonBackground_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueButtonBackground_2.tStart = t;  // (not accounting for frame time here)
      continueButtonBackground_2.frameNStart = frameN;  // exact frame index
      
      continueButtonBackground_2.setAutoDraw(true);
    }

    frameRemains = 0.15  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((continueButtonBackground_2.status === PsychoJS.Status.STARTED || continueButtonBackground_2.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      continueButtonBackground_2.setAutoDraw(false);
    }
    
    // *continueButtonText_2* updates
    if (t >= 0 && continueButtonText_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      continueButtonText_2.tStart = t;  // (not accounting for frame time here)
      continueButtonText_2.frameNStart = frameN;  // exact frame index
      
      continueButtonText_2.setAutoDraw(true);
    }

    frameRemains = 0.15  - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if ((continueButtonText_2.status === PsychoJS.Status.STARTED || continueButtonText_2.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      continueButtonText_2.setAutoDraw(false);
    }
    
    // *scoreBoardTextbox_4* updates
    if (t >= 0.0 && scoreBoardTextbox_4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      scoreBoardTextbox_4.tStart = t;  // (not accounting for frame time here)
      scoreBoardTextbox_4.frameNStart = frameN;  // exact frame index
      
      scoreBoardTextbox_4.setAutoDraw(true);
    }

    frameRemains = 0.0 + 0.15 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (scoreBoardTextbox_4.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      scoreBoardTextbox_4.setAutoDraw(false);
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of buttonPressedTrialComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine && routineTimer.getTime() > 0) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function buttonPressedTrialRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'buttonPressedTrial' ---
    for (const thisComponent of buttonPressedTrialComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    //stop automatically drawing feedback images
    leftLabFeedback_2.setAutoDraw(false); 
    rightLabFeedback_2.setAutoDraw(false);
    leftSyringe_2.setAutoDraw(false);
    rightSyringe_2.setAutoDraw(false);
    rewardImage.setAutoDraw(false);
    backgroundImage.setAutoDraw(true);
    leftNotepad.setAutoDraw(true);
    rightNotepad.setAutoDraw(true);
    scoreboardImage.setAutoDraw(true);
    
    //add all relevant parameters to output data
    LabTrials.addData("LeftProbability", leftProbability.toString());
    LabTrials.addData("RightProbability", rightProbability.toString());
    LabTrials.addData("LeftCured", leftCuredNum.toString());
    LabTrials.addData("RightCured", rightCuredNum.toString());
    LabTrials.addData("Level", session_n.toString());
    LabTrials.addData("Round", (round_n-1).toString());
    LabTrials.addData("Score", score_n.toString());
    LabTrials.addData("correct Choice", correctCure.toString());
    LabTrials.addData("correctly done", correctlyDone.toString());
    LabTrials.addData("Left Color", leftSyringeColor.toString());
    LabTrials.addData("Right Color", rightSyringeColor.toString());
    LabTrials.addData("Device", used_device.toString());
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var galleryText;
var galleryPath;
var endingScreenComponents;
function endingScreenRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'endingScreen' ---
    t = 0;
    endingScreenClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    routineTimer.add(1.000000);
    // update component parameters for each repeat
    // Run 'Begin Routine' code from endingScript_2
    //stop all autodraws
    backgroundImage.setAutoDraw(false);
    leftNotepad.setAutoDraw(false);
    rightNotepad.setAutoDraw(false);
    scoreboardImage.setAutoDraw(false);
    leftSyringe.setAutoDraw(false);
    rightSyringe.setAutoDraw(false);
    rewardBackgroundCircle.setAutoDraw(false);
    rewardImage.setAutoDraw(false);
    
    galleryText = (score_endText + score_n.toString()).toString();
    galleryPath = ("resources/Gallerie/Score_" + session_n.toString() + ".png").toString();
    
    //save level and score in shelf
    //if(canPlay == 1){
    //    psychoJS.shelf.setDictionaryFieldValue({key: ["Influenca_session_tracker", "@designer"], fieldName: expInfo['participant'], fieldValue: [session_n, score_n, languageChoice, currentDay, currentTime, timesPlayed]});
    //    }
    emptyBackground_3.setImage('resources/alternative_screen2.png');
    languageText_3.setText(endingStatement);
    // keep track of which components have finished
    endingScreenComponents = [];
    endingScreenComponents.push(emptyBackground_3);
    endingScreenComponents.push(languageText_3);
    
    for (const thisComponent of endingScreenComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function endingScreenRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'endingScreen' ---
    // get current time
    t = endingScreenClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *emptyBackground_3* updates
    if (t >= 0.0 && emptyBackground_3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      emptyBackground_3.tStart = t;  // (not accounting for frame time here)
      emptyBackground_3.frameNStart = frameN;  // exact frame index
      
      emptyBackground_3.setAutoDraw(true);
    }

    frameRemains = 0.0 + 1 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (emptyBackground_3.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      emptyBackground_3.setAutoDraw(false);
    }
    
    // *languageText_3* updates
    if (t >= 0.0 && languageText_3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      languageText_3.tStart = t;  // (not accounting for frame time here)
      languageText_3.frameNStart = frameN;  // exact frame index
      
      languageText_3.setAutoDraw(true);
    }

    frameRemains = 0.0 + 1 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (languageText_3.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      languageText_3.setAutoDraw(false);
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of endingScreenComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine && routineTimer.getTime() > 0) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function endingScreenRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'endingScreen' ---
    for (const thisComponent of endingScreenComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var deleteTheSceneComponents;
function deleteTheSceneRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'deleteTheScene' ---
    t = 0;
    deleteTheSceneClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    gallery.setImage(galleryPath);
    galleryTextBox.setText(galleryText);
    endGameTextBox.setText(endGameText);
    // setup some python lists for storing info about the lastClickofGame
    lastClickofGame.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    deleteTheSceneComponents = [];
    deleteTheSceneComponents.push(gallery);
    deleteTheSceneComponents.push(galleryTextBox);
    deleteTheSceneComponents.push(endGameButton);
    deleteTheSceneComponents.push(endGameTextBox);
    deleteTheSceneComponents.push(lastClickofGame);
    
    for (const thisComponent of deleteTheSceneComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function deleteTheSceneRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'deleteTheScene' ---
    // get current time
    t = deleteTheSceneClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *gallery* updates
    if (t >= 0.0 && gallery.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      gallery.tStart = t;  // (not accounting for frame time here)
      gallery.frameNStart = frameN;  // exact frame index
      
      gallery.setAutoDraw(true);
    }

    
    // *galleryTextBox* updates
    if (t >= 0.0 && galleryTextBox.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      galleryTextBox.tStart = t;  // (not accounting for frame time here)
      galleryTextBox.frameNStart = frameN;  // exact frame index
      
      galleryTextBox.setAutoDraw(true);
    }

    
    // *endGameButton* updates
    if (t >= 0.0 && endGameButton.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      endGameButton.tStart = t;  // (not accounting for frame time here)
      endGameButton.frameNStart = frameN;  // exact frame index
      
      endGameButton.setAutoDraw(true);
    }

    
    // *endGameTextBox* updates
    if (t >= 0.0 && endGameTextBox.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      endGameTextBox.tStart = t;  // (not accounting for frame time here)
      endGameTextBox.frameNStart = frameN;  // exact frame index
      
      endGameTextBox.setAutoDraw(true);
    }

    // *lastClickofGame* updates
    if (t >= 0.0 && lastClickofGame.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      lastClickofGame.tStart = t;  // (not accounting for frame time here)
      lastClickofGame.frameNStart = frameN;  // exact frame index
      
      lastClickofGame.status = PsychoJS.Status.STARTED;
      lastClickofGame.mouseClock.reset();
      prevButtonState = lastClickofGame.getPressed();  // if button is down already this ISN'T a new click
      }
    if (lastClickofGame.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = lastClickofGame.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [endGameButton]) {
            if (obj.contains(lastClickofGame)) {
              gotValidClick = true;
              lastClickofGame.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of deleteTheSceneComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function deleteTheSceneRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'deleteTheScene' ---
    for (const thisComponent of deleteTheSceneComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "deleteTheScene" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var savingDataComponents;
function savingDataRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'savingData' ---
    t = 0;
    savingDataClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    // keep track of which components have finished
    savingDataComponents = [];
    
    for (const thisComponent of savingDataComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function savingDataRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'savingData' ---
    // get current time
    t = savingDataClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of savingDataComponents)
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
        break;
      }
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function savingDataRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'savingData' ---
    for (const thisComponent of savingDataComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "savingData" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


function importConditions(currentLoop) {
  return async function () {
    psychoJS.importAttributes(currentLoop.getCurrentTrial());
    return Scheduler.Event.NEXT;
    };
}


async function quitPsychoJS(message, isCompleted) {
  // Check for and save orphaned data
  if (psychoJS.experiment.isEntryEmpty()) {
    psychoJS.experiment.nextEntry();
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  //save level and score in shelf
  if(canPlay == 1){
      psychoJS.shelf.setDictionaryFieldValue({key: ["Influenca_session_tracker", "@designer"], fieldName: expInfo['participant'], fieldValue: [session_n, score_n, languageChoice, currentDay, currentTime, timesPlayed]});
      }
  
  if(canPlay == 0){
      psychoJS.shelf.setDictionaryFieldValue({key: ["Influenca_session_tracker", "@designer"], fieldName: expInfo['participant'], fieldValue: [session_n-1, score_n, languageChoice, lastDayPlayed, lastTimePlayed, timesPlayed-1]});
      }
  
  psychoJS.window.close();
  psychoJS.quit({message: message, isCompleted: isCompleted});
  
  return Scheduler.Event.QUIT;
}
