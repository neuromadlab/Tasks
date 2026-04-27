/*********************** 
 * Food_Rating_V2 *
 ***********************/

import { core, data, sound, util, visual, hardware } from './lib/psychojs-2024.2.4.js';
const { PsychoJS } = core;
const { TrialHandler, MultiStairHandler } = data;
const { Scheduler } = util;
//some handy aliases as in the psychopy scripts;
const { abs, sin, cos, PI: pi, sqrt } = Math;
const { round } = util;


// store info about the experiment session:
let expName = 'food_rating_v2';  // from the Builder filename that created this script
let expInfo = {
    'participantID': 'pilot1',
    'sessionID': '1',
};

// Start code blocks for 'Before Experiment'
// the studyID is initiated here in order to make it available
// for the filename
const studyID = "BON006";

// Run 'Before Experiment' code from code_shuffle

var n;
var prelast;
var i;
function shuffle_array(arr) {
    var i, j, n, prelast;
    n = arr.length;
    prelast = (n - 2);
    i = 0;
    while ((i <= prelast)) {
        j = Number.parseInt((i + (Math.random() * (n - i))));
        [arr[i], arr[j]] = [arr[j], arr[i]];
        i += 1;
    }
    return arr.slice(0);
}

// init psychoJS:
const psychoJS = new PsychoJS({
  debug: true
});

// open window:
psychoJS.openWindow({
  fullscr: true,
  color: new util.Color([1.0, 1.0, 1.0]),
  units: 'height',
  waitBlanking: true,
  backgroundImage: '',
  backgroundFit: 'none',
});
// schedule the experiment:
psychoJS.schedule(psychoJS.gui.DlgFromDict({
  dictionary: expInfo,
  title: expName
}));

const flowScheduler = new Scheduler(psychoJS);
const dialogCancelScheduler = new Scheduler(psychoJS);
psychoJS.scheduleCondition(function() { return (psychoJS.gui.dialogComponent.button === 'OK'); },flowScheduler, dialogCancelScheduler);

// flowScheduler gets run if the participants presses OK
flowScheduler.add(updateInfo); // add timeStamp
flowScheduler.add(experimentInit);
flowScheduler.add(global_varsRoutineBegin());
flowScheduler.add(global_varsRoutineEachFrame());
flowScheduler.add(global_varsRoutineEnd());
flowScheduler.add(mobile_detectionRoutineBegin());
flowScheduler.add(mobile_detectionRoutineEachFrame());
flowScheduler.add(mobile_detectionRoutineEnd());
flowScheduler.add(language_choiceRoutineBegin());
flowScheduler.add(language_choiceRoutineEachFrame());
flowScheduler.add(language_choiceRoutineEnd());
const instructionReadLoopLoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(instructionReadLoopLoopBegin(instructionReadLoopLoopScheduler));
flowScheduler.add(instructionReadLoopLoopScheduler);
flowScheduler.add(instructionReadLoopLoopEnd);


const imageListReadLoopLoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(imageListReadLoopLoopBegin(imageListReadLoopLoopScheduler));
flowScheduler.add(imageListReadLoopLoopScheduler);
flowScheduler.add(imageListReadLoopLoopEnd);


flowScheduler.add(instructionsRoutineBegin());
flowScheduler.add(instructionsRoutineEachFrame());
flowScheduler.add(instructionsRoutineEnd());
flowScheduler.add(instructions_2RoutineBegin());
flowScheduler.add(instructions_2RoutineEachFrame());
flowScheduler.add(instructions_2RoutineEnd());
flowScheduler.add(preparationRoutineBegin());
flowScheduler.add(preparationRoutineEachFrame());
flowScheduler.add(preparationRoutineEnd());
const images_block1_loopLoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(images_block1_loopLoopBegin(images_block1_loopLoopScheduler));
flowScheduler.add(images_block1_loopLoopScheduler);
flowScheduler.add(images_block1_loopLoopEnd);











flowScheduler.add(reRandomizeRoutineBegin());
flowScheduler.add(reRandomizeRoutineEachFrame());
flowScheduler.add(reRandomizeRoutineEnd());
const images_block2_loopLoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(images_block2_loopLoopBegin(images_block2_loopLoopScheduler));
flowScheduler.add(images_block2_loopLoopScheduler);
flowScheduler.add(images_block2_loopLoopEnd);











flowScheduler.add(fixationRoutineBegin());
flowScheduler.add(fixationRoutineEachFrame());
flowScheduler.add(fixationRoutineEnd());
flowScheduler.add(instructions_3RoutineBegin());
flowScheduler.add(instructions_3RoutineEachFrame());
flowScheduler.add(instructions_3RoutineEnd());
flowScheduler.add(ratingRoutineBegin());
flowScheduler.add(ratingRoutineEachFrame());
flowScheduler.add(ratingRoutineEnd());
flowScheduler.add(endRoutineBegin());
flowScheduler.add(endRoutineEachFrame());
flowScheduler.add(endRoutineEnd());
flowScheduler.add(quitPsychoJS, 'Thank you for your patience.', true);

// quit if user presses Cancel in dialog box:
dialogCancelScheduler.add(quitPsychoJS, 'Thank you for your patience.', false);

psychoJS.start({
  expName: expName,
  expInfo: expInfo,
  resources: [
    // resources:
    {'name': 'stimuli/instructions.xlsx', 'path': 'stimuli/instructions.xlsx'},
    {'name': 'stimuli/imageList.xlsx', 'path': 'stimuli/imageList.xlsx'},
    {'name': 'buttons/germany_flag.png', 'path': 'buttons/germany_flag.png'},
    {'name': 'buttons/uk_flag.png', 'path': 'buttons/uk_flag.png'},
    {'name': 'default.png', 'path': 'https://pavlovia.org/assets/default/default.png'},
    {'name': 'buttons/germany_flag.png', 'path': 'buttons/germany_flag.png'},
    {'name': 'buttons/uk_flag.png', 'path': 'buttons/uk_flag.png'},
    {'name': 'stimuli/Food_Stimuli/1.jpg', 'path': 'stimuli/Food_Stimuli/1.jpg'},
    {'name': 'stimuli/Food_Stimuli/3.jpg', 'path': 'stimuli/Food_Stimuli/3.jpg'},
    {'name': 'stimuli/Food_Stimuli/4.jpg', 'path': 'stimuli/Food_Stimuli/4.jpg'},
    {'name': 'stimuli/Food_Stimuli/8.jpg', 'path': 'stimuli/Food_Stimuli/8.jpg'},
    {'name': 'stimuli/Food_Stimuli/12.jpg', 'path': 'stimuli/Food_Stimuli/12.jpg'},
    {'name': 'stimuli/Food_Stimuli/14.jpg', 'path': 'stimuli/Food_Stimuli/14.jpg'},
    {'name': 'stimuli/Food_Stimuli/20.jpg', 'path': 'stimuli/Food_Stimuli/20.jpg'},
    {'name': 'stimuli/Food_Stimuli/24.jpg', 'path': 'stimuli/Food_Stimuli/24.jpg'},
    {'name': 'stimuli/Food_Stimuli/26.jpg', 'path': 'stimuli/Food_Stimuli/26.jpg'},
    {'name': 'stimuli/Food_Stimuli/30.jpg', 'path': 'stimuli/Food_Stimuli/30.jpg'},
    {'name': 'stimuli/Food_Stimuli/33.jpg', 'path': 'stimuli/Food_Stimuli/33.jpg'},
    {'name': 'stimuli/Food_Stimuli/34.jpg', 'path': 'stimuli/Food_Stimuli/34.jpg'},
    {'name': 'stimuli/Food_Stimuli/36.jpg', 'path': 'stimuli/Food_Stimuli/36.jpg'},
    {'name': 'stimuli/Food_Stimuli/38.jpg', 'path': 'stimuli/Food_Stimuli/38.jpg'},
    {'name': 'stimuli/Food_Stimuli/52.jpg', 'path': 'stimuli/Food_Stimuli/52.jpg'},
    {'name': 'stimuli/Food_Stimuli/58.jpg', 'path': 'stimuli/Food_Stimuli/58.jpg'},
    {'name': 'stimuli/Food_Stimuli/61.jpg', 'path': 'stimuli/Food_Stimuli/61.jpg'},
    {'name': 'stimuli/Food_Stimuli/62.jpg', 'path': 'stimuli/Food_Stimuli/62.jpg'},
    {'name': 'stimuli/Food_Stimuli/72.jpg', 'path': 'stimuli/Food_Stimuli/72.jpg'},
    {'name': 'stimuli/Food_Stimuli/76.jpg', 'path': 'stimuli/Food_Stimuli/76.jpg'},
    {'name': 'stimuli/Food_Stimuli/81.jpg', 'path': 'stimuli/Food_Stimuli/81.jpg'},
    {'name': 'stimuli/Food_Stimuli/103.jpg', 'path': 'stimuli/Food_Stimuli/103.jpg'},
    {'name': 'stimuli/Food_Stimuli/104.jpg', 'path': 'stimuli/Food_Stimuli/104.jpg'},
    {'name': 'stimuli/Food_Stimuli/114.jpg', 'path': 'stimuli/Food_Stimuli/114.jpg'},
    {'name': 'stimuli/Food_Stimuli/115.jpg', 'path': 'stimuli/Food_Stimuli/115.jpg'},
    {'name': 'stimuli/Food_Stimuli/121.jpg', 'path': 'stimuli/Food_Stimuli/121.jpg'},
    {'name': 'stimuli/Food_Stimuli/131.jpg', 'path': 'stimuli/Food_Stimuli/131.jpg'},
    {'name': 'stimuli/Food_Stimuli/136.jpg', 'path': 'stimuli/Food_Stimuli/136.jpg'},
    {'name': 'stimuli/Food_Stimuli/138.jpg', 'path': 'stimuli/Food_Stimuli/138.jpg'},
    {'name': 'stimuli/Food_Stimuli/141.jpg', 'path': 'stimuli/Food_Stimuli/141.jpg'},
    {'name': 'stimuli/Food_Stimuli/142.jpg', 'path': 'stimuli/Food_Stimuli/142.jpg'},
    {'name': 'stimuli/Food_Stimuli/144.jpg', 'path': 'stimuli/Food_Stimuli/144.jpg'},
    {'name': 'stimuli/Food_Stimuli/157.jpg', 'path': 'stimuli/Food_Stimuli/157.jpg'},
    {'name': 'stimuli/Food_Stimuli/167.jpg', 'path': 'stimuli/Food_Stimuli/167.jpg'},
    {'name': 'stimuli/Food_Stimuli/170.jpg', 'path': 'stimuli/Food_Stimuli/170.jpg'},
    {'name': 'stimuli/Food_Stimuli/171.jpg', 'path': 'stimuli/Food_Stimuli/171.jpg'},
    {'name': 'stimuli/Food_Stimuli/180.jpg', 'path': 'stimuli/Food_Stimuli/180.jpg'},
    {'name': 'stimuli/Food_Stimuli/181.jpg', 'path': 'stimuli/Food_Stimuli/181.jpg'},
    {'name': 'stimuli/Food_Stimuli/183.jpg', 'path': 'stimuli/Food_Stimuli/183.jpg'},
    {'name': 'stimuli/Food_Stimuli/189.jpg', 'path': 'stimuli/Food_Stimuli/189.jpg'},
    {'name': 'stimuli/Food_Stimuli/190.jpg', 'path': 'stimuli/Food_Stimuli/190.jpg'},
    {'name': 'stimuli/Food_Stimuli/192.jpg', 'path': 'stimuli/Food_Stimuli/192.jpg'},
    {'name': 'stimuli/Food_Stimuli/199.jpg', 'path': 'stimuli/Food_Stimuli/199.jpg'},
    {'name': 'stimuli/Food_Stimuli/202.jpg', 'path': 'stimuli/Food_Stimuli/202.jpg'},
    {'name': 'stimuli/Food_Stimuli/203.jpg', 'path': 'stimuli/Food_Stimuli/203.jpg'},
    {'name': 'stimuli/Food_Stimuli/224.jpg', 'path': 'stimuli/Food_Stimuli/224.jpg'},
    {'name': 'stimuli/Food_Stimuli/228.jpg', 'path': 'stimuli/Food_Stimuli/228.jpg'},
    {'name': 'stimuli/Food_Stimuli/241.jpg', 'path': 'stimuli/Food_Stimuli/241.jpg'},
    {'name': 'stimuli/Food_Stimuli/256.jpg', 'path': 'stimuli/Food_Stimuli/256.jpg'},
    {'name': 'stimuli/Food_Stimuli/259.jpg', 'path': 'stimuli/Food_Stimuli/259.jpg'},
    {'name': 'stimuli/Food_Stimuli/263.jpg', 'path': 'stimuli/Food_Stimuli/263.jpg'},
    {'name': 'stimuli/Food_Stimuli/272.jpg', 'path': 'stimuli/Food_Stimuli/272.jpg'},
    {'name': 'stimuli/Food_Stimuli/300.jpg', 'path': 'stimuli/Food_Stimuli/300.jpg'},
    {'name': 'stimuli/Food_Stimuli/321.jpg', 'path': 'stimuli/Food_Stimuli/321.jpg'},
    {'name': 'stimuli/Food_Stimuli/322.jpg', 'path': 'stimuli/Food_Stimuli/322.jpg'},
    {'name': 'stimuli/Food_Stimuli/323.jpg', 'path': 'stimuli/Food_Stimuli/323.jpg'},
    {'name': 'stimuli/Food_Stimuli/326.jpg', 'path': 'stimuli/Food_Stimuli/326.jpg'},
    {'name': 'stimuli/Food_Stimuli/328.jpg', 'path': 'stimuli/Food_Stimuli/328.jpg'},
    {'name': 'stimuli/Food_Stimuli/331.jpg', 'path': 'stimuli/Food_Stimuli/331.jpg'},
    {'name': 'stimuli/Food_Stimuli/337.jpg', 'path': 'stimuli/Food_Stimuli/337.jpg'},
    {'name': 'stimuli/imageList.xlsx', 'path': 'stimuli/imageList.xlsx'},
    {'name': 'stimuli/instructions.xlsx', 'path': 'stimuli/instructions.xlsx'},
  ]
});

psychoJS.experimentLogger.setLevel(core.Logger.ServerLevel.INFO);


var currentLoop;
var frameDur;
async function updateInfo() {
  currentLoop = psychoJS.experiment;  // right now there are no loops
  expInfo['date'] = util.MonotonicClock.getDateStr();  // add a simple timestamp
  expInfo['expName'] = expName;
  expInfo['psychopyVersion'] = '2024.2.4';
  expInfo['OS'] = window.navigator.platform;


  // store frame rate of monitor if we can measure it successfully
  expInfo['frameRate'] = psychoJS.window.getActualFrameRate();
  if (typeof expInfo['frameRate'] !== 'undefined')
    frameDur = 1.0 / Math.round(expInfo['frameRate']);
  else
    frameDur = 1.0 / 60.0; // couldn't get a reliable measure so guess

  // add info from the URL:
  util.addInfoFromUrl(expInfo);
  

  
  psychoJS.experiment.dataFileName = (("." + "/") + `data/${expName}_${studyID}_${expInfo["participantID"]}_S${expInfo["sessionID"]}_${expInfo["date"]}`);
  psychoJS.experiment.field_separator = '\t';


  return Scheduler.Event.NEXT;
}


var global_varsClock;
var opacity1;
var opacity2;
var reminder_text;
var sliderH_text;
var sliderH_leftAnchor_text;
var sliderH_rightAnchor_text;
var window_height;
var window_width;
var xrange;
var mobile_detectionClock;
var mobile_device;
var language_choiceClock;
var languagechoice;
var image_germanyflag;
var image_ukflag;
var textbox_languagechoice;
var mouse_languagechoice;
var textbox_sourceflag;
var load_instructionsClock;
var load_imageListClock;
var imageList;
var instructionsClock;
var submitbutton_opacity;
var textbox_instructions;
var mouse_instructions;
var polygon_submitbutton;
var textbox_submitbutton;
var instructions_2Clock;
var textbox_instructions_2;
var mouse_instructions_2;
var polygon_submitbutton_2;
var textbox_submitbutton_2;
var preparationClock;
var img_count;
var img_path;
var image_conditions;
var globalTrialCounter;
var submitbutton_size;
var submitbutton_xy;
var submitbutton_fillcolor;
var submitbutton_bordercolor;
var submitbutton_edgethickness;
var likingColor;
var wantingColor;
var sustainColor;
var healthColor;
var slider_labelcolor;
var slider_markercolor;
var slider_linecolor;
var colorSpace;
var labelH_letter_height;
var labelV_letter_height;
var fixationClock;
var fixation_cross;
var prep_trial12Clock;
var slider_verticalClock;
var imgV_h;
var imgV_w;
var imgV_center_x;
var imgV_center_y;
var reminderV_text_x;
var reminderV_text_y;
var slidertextV_letter_height;
var slidertextV_center_x;
var slidertextV_center_y;
var sliderV_w;
var sliderV_h;
var sliderV_center_x;
var sliderV_center_y;
var sliderV_ticks;
var label_xpos;
var l01_ypos;
var l02_ypos;
var l03_ypos;
var l04_ypos;
var l05_ypos;
var l06_ypos;
var l07_ypos;
var l08_ypos;
var l09_ypos;
var l10_ypos;
var l11_ypos;
var l01_pos;
var l02_pos;
var l03_pos;
var l04_pos;
var l05_pos;
var l06_pos;
var l07_pos;
var l08_pos;
var l09_pos;
var l10_pos;
var l11_pos;
var ratingGiven;
var textbox_reminderV;
var imageV;
var textbox_sliderV;
var slider_V;
var polygon_submitbuttonV;
var textbox_submitbuttonV;
var mouseV;
var textbox_l01;
var textbox_l02;
var textbox_l03;
var textbox_l04;
var textbox_l05;
var textbox_l06;
var textbox_l07;
var textbox_l08;
var textbox_l09;
var textbox_l10;
var textbox_l11;
var slider_horizontalClock;
var imgH_h;
var imgH_w;
var imgH_center_x;
var imgH_center_y;
var reminderH_text_x;
var reminderH_text_y;
var slidertextH_center_x;
var slidertextH_center_y;
var sliderH_wanting_w;
var sliderH_w;
var sliderH_h;
var sliderH_center_x;
var sliderH_center_y;
var sliderH_label1_pos;
var sliderH_label2_pos;
var textbox_reminderH;
var imageH;
var textbox_sliderH;
var slider_H;
var textbox_sliderH_leftAnchor;
var textbox_sliderH_rightAnchor;
var polygon_submitbuttonH;
var textbox_submitbuttonH;
var mouseH;
var reRandomizeClock;
var prep_trial34Clock;
var instructions_3Clock;
var textbox_instructions_3;
var mouse_instructions_3;
var polygon_submitbutton_3;
var textbox_submitbutton_3;
var ratingClock;
var j;
var ratingX;
var ratingY;
var ratingW;
var ratingH;
var ratingBackColor;
var rating_letterHeight;
var ratingCond;
var polygon_target1;
var polygon_target2;
var polygon_target3;
var polygon_target4;
var textbox_cond1;
var textbox_cond2;
var textbox_cond3;
var textbox_cond4;
var mouseR;
var textbox_submitbuttonR;
var textbox_target1;
var textbox_target2;
var textbox_target3;
var textbox_target4;
var endClock;
var textbox_end;
var textbox_wait;
var globalClock;
var routineTimer;
async function experimentInit() {
  // Initialize components for Routine "global_vars"
  global_varsClock = new util.Clock();
  // Run 'Begin Experiment' code from code_global
  opacity1 = 0.75;
  opacity2 = 1;
  reminder_text = "init";
  sliderH_text = "init";
  sliderH_leftAnchor_text = "init";
  sliderH_rightAnchor_text = "init";
  window_height = psychoJS.window.size[1];
  window_width = psychoJS.window.size[0];
  xrange = (window_width / window_height);
  
  // these infos are added to the experiment here, and not before experiment,
  // because they shall not appear in the input dialog at start.
  expInfo["studyID"] = studyID;
  
  // Initialize components for Routine "mobile_detection"
  mobile_detectionClock = new util.Clock();
  // Run 'Begin Experiment' code from code_mobile
  // Detect if mobile device is used 
  // (only works reliable for mobile phones, not for tablets)
  mobile_device = false;
  if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(navigator.userAgent) 
    || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(navigator.userAgent.substr(0,4))) { 
    mobile_device = true;
  }
  // Initialize components for Routine "language_choice"
  language_choiceClock = new util.Clock();
  languagechoice = null;
  
  image_germanyflag = new visual.ImageStim({
    win : psychoJS.window,
    name : 'image_germanyflag', units : undefined, 
    image : 'buttons/germany_flag.png', mask : undefined,
    anchor : 'center',
    ori : 0.0, 
    pos : [(- 0.3), (- 0.22)], 
    draggable: false,
    size : [0.3, 0.3],
    color : new util.Color([1,1,1]), opacity : 1.0,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  image_ukflag = new visual.ImageStim({
    win : psychoJS.window,
    name : 'image_ukflag', units : undefined, 
    image : 'buttons/uk_flag.png', mask : undefined,
    anchor : 'center',
    ori : 0.0, 
    pos : [0.3, (- 0.22)], 
    draggable: false,
    size : [0.3, 0.3],
    color : new util.Color([1,1,1]), opacity : 1.0,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -2.0 
  });
  textbox_languagechoice = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_languagechoice',
    text: 'Choose your preferred language',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0, 0.2], 
    draggable: false,
    letterHeight: 0.1,
    lineSpacing: 1.0,
    size: [0.95, 0.5],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -3.0 
  });
  
  mouse_languagechoice = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_languagechoice.mouseClock = new util.Clock();
  textbox_sourceflag = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_sourceflag',
    text: 'Icons from https://www.countryflags.com/',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.015,
    lineSpacing: 1.0,
    size: [0.3, 0.04],  units: undefined, 
    ori: 0.0,
    color: [0.6549, 0.6549, 0.6549], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -5.0 
  });
  
  // Initialize components for Routine "load_instructions"
  load_instructionsClock = new util.Clock();
  // Initialize components for Routine "load_imageList"
  load_imageListClock = new util.Clock();
  // Run 'Begin Experiment' code from code
  imageList = [];
  
  // Initialize components for Routine "instructions"
  instructionsClock = new util.Clock();
  // Run 'Begin Experiment' code from code_instructions
  submitbutton_opacity = null;
  
  textbox_instructions = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_instructions',
    text: '',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0, 0.1], 
    draggable: false,
    letterHeight: 0.035,
    lineSpacing: 1.0,
    size: 1.0,  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  mouse_instructions = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_instructions.mouseClock = new util.Clock();
  polygon_submitbutton = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbutton', 
    width: [1.0, 1.0][0], height: [1.0, 1.0][1],
    ori: 0.0, 
    pos: [0, 0], 
    draggable: false, 
    anchor: 'center', 
    lineWidth: 2.0, 
    lineColor: new util.Color([(- 1), (- 1), (- 1)]), 
    fillColor: new util.Color([0.9, 0.9, 0.9]), 
    colorSpace: 'rgb', 
    opacity: 1.0, 
    depth: -4, 
    interpolate: true, 
  });
  
  textbox_submitbutton = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbutton',
    text: '',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: 1.0,  units: undefined, 
    ori: 0.0,
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -5.0 
  });
  
  // Initialize components for Routine "instructions_2"
  instructions_2Clock = new util.Clock();
  // Run 'Begin Experiment' code from code_instructions_2
  submitbutton_opacity = null;
  
  textbox_instructions_2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_instructions_2',
    text: '',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0, 0.1], 
    draggable: false,
    letterHeight: 0.035,
    lineSpacing: 1.0,
    size: 1.0,  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  mouse_instructions_2 = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_instructions_2.mouseClock = new util.Clock();
  polygon_submitbutton_2 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbutton_2', 
    width: [1.0, 1.0][0], height: [1.0, 1.0][1],
    ori: 0.0, 
    pos: [0, 0], 
    draggable: false, 
    anchor: 'center', 
    lineWidth: 2.0, 
    lineColor: new util.Color([(- 1), (- 1), (- 1)]), 
    fillColor: new util.Color([0.9, 0.9, 0.9]), 
    colorSpace: 'rgb', 
    opacity: 1.0, 
    depth: -4, 
    interpolate: true, 
  });
  
  textbox_submitbutton_2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbutton_2',
    text: '',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: 1.0,  units: undefined, 
    ori: 0.0,
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -5.0 
  });
  
  // Initialize components for Routine "preparation"
  preparationClock = new util.Clock();
  // Run 'Begin Experiment' code from code_prepConditions
  img_count = 0;
  img_path = "stimuli/Food_Stimuli/";
  image_conditions = [];
  
  // Run 'Begin Experiment' code from code_commonVars
  globalTrialCounter = 0;
  submitbutton_size = [0.24, 0.08];
  submitbutton_xy = [0, (- 0.41)];
  submitbutton_fillcolor = [0.9, 0.9, 0.9];
  submitbutton_bordercolor = [(- 1), (- 1), (- 1)];
  submitbutton_opacity = opacity1;
  submitbutton_edgethickness = 2;
  likingColor = [0.8, 0.8, 0.8];
  wantingColor = [0.5, (- 1), 0.5];
  sustainColor = [(- 1), 1, (- 1)];
  healthColor = [(- 0.2157), 0.1686, 0.8588];
  slider_labelcolor = likingColor;
  slider_markercolor = [(- 1), (- 1), (- 1)];
  slider_linecolor = [0.9, 0.9, 0.9];
  colorSpace = "rgb";
  labelH_letter_height = 0.035;
  labelV_letter_height = (0.025 * Math.min(1, Math.max(xrange, 0.75)));
  if (mobile_device) {
      labelH_letter_height = 0.05;
      labelV_letter_height = (0.035 * Math.min(1, Math.max(xrange, 0.75)));
      submitbutton_size[0] = (submitbutton_size[0] * 1.1);
  }
  
  // Initialize components for Routine "fixation"
  fixationClock = new util.Clock();
  fixation_cross = new visual.ShapeStim ({
    win: psychoJS.window, name: 'fixation_cross', 
    vertices: 'cross', size:[0.025, 0.025],
    ori: 0.0, 
    pos: [0, 0], 
    draggable: false, 
    anchor: 'center', 
    lineWidth: 1.0, 
    lineColor: new util.Color('white'), 
    fillColor: new util.Color('black'), 
    colorSpace: 'rgb', 
    opacity: undefined, 
    depth: -1, 
    interpolate: true, 
  });
  
  // Initialize components for Routine "prep_trial12"
  prep_trial12Clock = new util.Clock();
  // Initialize components for Routine "slider_vertical"
  slider_verticalClock = new util.Clock();
  // dimension/position for image
  imgV_h = 0.35;
  imgV_w = (imgV_h * 1.494); // depending on image height and aspect ratio
  imgV_center_x = ((- 0.23) * Math.max(1, xrange));
  imgV_center_y = 0.15;
  
  // dimension/position for reminder text
  reminderV_text_x = (imgV_center_x + (imgV_w / 4));
  reminderV_text_y = (- 0.3);
  
  // dimension/position for slider Text
  slidertextV_letter_height = 0.03;
  slidertextV_center_x = (imgV_center_x - (imgV_w / 2));
  slidertextV_center_y = (- 0.1);
  
  // dimension/position for slider
  // these values are horizontal, but the slider will be rotated by 90 degree
  sliderV_w = 0.65;
  sliderV_h = 0.03;
  sliderV_center_x = 0.17;
  sliderV_center_y = 0;
  
  // increase some values if on mobile
  if (mobile_device) {
      imgV_h = (imgV_h * 1.2);
      imgV_center_y = 0.17;
      slidertextV_letter_height = 0.037;
      slidertextV_center_y = (- 0.14);
      sliderV_w = 0.9;
      sliderV_h = 0.04;
      sliderV_center_x = 0.25;
  }
  
  // position of vertical slider anchors
  sliderV_ticks = [(- 100), (- 62.8), (- 41.6), (- 17.6), (- 6), 0, 6.2, 17.8, 44.4, 65.8, 100];
  label_xpos = (sliderV_center_x + sliderV_h);
  l01_ypos = (sliderV_center_y + (((sliderV_w / 2) * sliderV_ticks[10]) / 100));
  l02_ypos = (sliderV_center_y + (((sliderV_w / 2) * sliderV_ticks[9]) / 100));
  l03_ypos = (sliderV_center_y + (((sliderV_w / 2) * sliderV_ticks[8]) / 100));
  l04_ypos = (sliderV_center_y + (((sliderV_w / 2) * sliderV_ticks[7]) / 100));
  l05_ypos = (sliderV_center_y + (((sliderV_w / 2) * sliderV_ticks[6]) / 100));
  l06_ypos = (sliderV_center_y + (((sliderV_w / 2) * sliderV_ticks[5]) / 100));
  l07_ypos = (sliderV_center_y + (((sliderV_w / 2) * sliderV_ticks[4]) / 100));
  l08_ypos = (sliderV_center_y + (((sliderV_w / 2) * sliderV_ticks[3]) / 100));
  l09_ypos = (sliderV_center_y + (((sliderV_w / 2) * sliderV_ticks[2]) / 100));
  l10_ypos = (sliderV_center_y + (((sliderV_w / 2) * sliderV_ticks[1]) / 100));
  l11_ypos = (sliderV_center_y + (((sliderV_w / 2) * sliderV_ticks[0]) / 100));
  l01_pos = [label_xpos, l01_ypos];
  l02_pos = [label_xpos, l02_ypos];
  l03_pos = [label_xpos, l03_ypos];
  l04_pos = [label_xpos, l04_ypos];
  l05_pos = [label_xpos, l05_ypos];
  l06_pos = [(sliderV_center_x - (3.3 * sliderV_h)), l06_ypos]; // label "neutral" on the left of the slider
  l07_pos = [label_xpos, l07_ypos];
  l08_pos = [label_xpos, l08_ypos];
  l09_pos = [label_xpos, l09_ypos];
  l10_pos = [label_xpos, l10_ypos];
  l11_pos = [label_xpos, l11_ypos];
  
  if (mobile_device) {
      l06_pos = [(sliderV_center_x - (3.5 * sliderV_h)), l06_ypos];
  }
  
  // Run 'Begin Experiment' code from code_ratingDetectionV
  ratingGiven = false;
  
  textbox_reminderV = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_reminderV',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [reminderV_text_x, reminderV_text_y], 
    draggable: false,
    letterHeight: 0.03,
    lineSpacing: 1.0,
    size: [0.7, 0.1],  units: undefined, 
    ori: 0.0,
    color: [0.7255, (- 0.8431), (- 0.5294)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -3.0 
  });
  
  imageV = new visual.ImageStim({
    win : psychoJS.window,
    name : 'imageV', units : undefined, 
    image : 'default.png', mask : undefined,
    anchor : 'center',
    ori : 0.0, 
    pos : [imgV_center_x, imgV_center_y], 
    draggable: false,
    size : [imgV_w, imgV_h],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -4.0 
  });
  textbox_sliderV = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_sliderV',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [slidertextV_center_x, slidertextV_center_y], 
    draggable: false,
    letterHeight: slidertextV_letter_height,
    lineSpacing: 1.0,
    size: [0.5, 0.15],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: [1.0, 1.0, 1.0], borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-left',
    depth: -5.0 
  });
  
  slider_V = new visual.Slider({
    win: psychoJS.window, name: 'slider_V',
    startValue: 50,
    size: [sliderV_w, sliderV_h], pos: [sliderV_center_x, sliderV_center_y], ori: -90.0, units: psychoJS.window.units,
    labels: undefined, fontSize: 0.05, ticks: [0, 100],
    granularity: 0.0, style: ["SLIDER"],
    color: new util.Color(slider_labelcolor), markerColor: new util.Color(slider_markercolor), lineColor: new util.Color(slider_linecolor), 
    opacity: undefined, fontFamily: 'Open Sans', bold: true, italic: false, depth: -6, 
    flip: false,
  });
  
  polygon_submitbuttonV = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbuttonV', 
    width: submitbutton_size[0], height: submitbutton_size[1],
    ori: 0.0, 
    pos: submitbutton_xy, 
    draggable: false, 
    anchor: 'center', 
    lineWidth: submitbutton_edgethickness, 
    lineColor: new util.Color(submitbutton_bordercolor), 
    fillColor: new util.Color(submitbutton_fillcolor), 
    colorSpace: 'rgb', 
    opacity: 1.0, 
    depth: -7, 
    interpolate: true, 
  });
  
  textbox_submitbuttonV = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbuttonV',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: submitbutton_xy, 
    draggable: false,
    letterHeight: 0.07,
    lineSpacing: 1.0,
    size: submitbutton_size,  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: submitbutton_bordercolor,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -8.0 
  });
  
  mouseV = new core.Mouse({
    win: psychoJS.window,
  });
  mouseV.mouseClock = new util.Clock();
  textbox_l01 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l01',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: l01_pos, 
    draggable: false,
    letterHeight: labelV_letter_height,
    lineSpacing: 1.0,
    size: [0.5, 0.1],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-left',
    depth: -10.0 
  });
  
  textbox_l02 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l02',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: l02_pos, 
    draggable: false,
    letterHeight: labelV_letter_height,
    lineSpacing: 1.0,
    size: [0.5, 0.1],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-left',
    depth: -11.0 
  });
  
  textbox_l03 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l03',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: l03_pos, 
    draggable: false,
    letterHeight: labelV_letter_height,
    lineSpacing: 1.0,
    size: [0.5, 0.1],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-left',
    depth: -12.0 
  });
  
  textbox_l04 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l04',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: l04_pos, 
    draggable: false,
    letterHeight: labelV_letter_height,
    lineSpacing: 1.0,
    size: [0.5, 0.1],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-left',
    depth: -13.0 
  });
  
  textbox_l05 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l05',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: l05_pos, 
    draggable: false,
    letterHeight: labelV_letter_height,
    lineSpacing: 1.0,
    size: [0.5, 0.1],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-left',
    depth: -14.0 
  });
  
  textbox_l06 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l06',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: l06_pos, 
    draggable: false,
    letterHeight: labelV_letter_height,
    lineSpacing: 1.0,
    size: [0.5, 0.1],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-left',
    depth: -15.0 
  });
  
  textbox_l07 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l07',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: l07_pos, 
    draggable: false,
    letterHeight: labelV_letter_height,
    lineSpacing: 1.0,
    size: [0.5, 0.1],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-left',
    depth: -16.0 
  });
  
  textbox_l08 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l08',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: l08_pos, 
    draggable: false,
    letterHeight: labelV_letter_height,
    lineSpacing: 1.0,
    size: [0.5, 0.1],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-left',
    depth: -17.0 
  });
  
  textbox_l09 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l09',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: l09_pos, 
    draggable: false,
    letterHeight: labelV_letter_height,
    lineSpacing: 1.0,
    size: [0.5, 0.1],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-left',
    depth: -18.0 
  });
  
  textbox_l10 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l10',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: l10_pos, 
    draggable: false,
    letterHeight: labelV_letter_height,
    lineSpacing: 1.0,
    size: [0.5, 0.1],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-left',
    depth: -19.0 
  });
  
  textbox_l11 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l11',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: l11_pos, 
    draggable: false,
    letterHeight: labelV_letter_height,
    lineSpacing: 1.0,
    size: [0.5, 0.1],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-left',
    depth: -20.0 
  });
  
  // Initialize components for Routine "slider_horizontal"
  slider_horizontalClock = new util.Clock();
  // Run 'Begin Experiment' code from code_sliderHorizontal
  submitbutton_opacity = opacity1;
  imgH_h = 0.35;
  imgH_w = (imgH_h * 1.494);
  imgH_center_x = 0;
  imgH_center_y = 0.1;
  reminderH_text_x = 0;
  reminderH_text_y = 0.4;
  slidertextH_center_x = 0;
  slidertextH_center_y = (- 0.13);
  sliderH_wanting_w = 0.8;
  sliderH_w = (sliderH_wanting_w * Math.max(1, xrange));
  sliderH_h = 0.045;
  sliderH_center_x = 0;
  sliderH_center_y = (- 0.3);
  sliderH_label1_pos = [0, 0];
  sliderH_label2_pos = [0, 0];
  sliderH_label1_pos[0] = (sliderH_center_x - ((sliderH_wanting_w / 2) * Math.max(1, xrange)));
  sliderH_label1_pos[1] = ((sliderH_center_y - (sliderH_h * Math.min(1, xrange))) - 0.01);
  sliderH_label2_pos[0] = (sliderH_center_x + ((sliderH_wanting_w / 2) * Math.max(1, xrange)));
  sliderH_label2_pos[1] = ((sliderH_center_y - (sliderH_h * Math.min(1, xrange))) - 0.01);
  sliderH_label1_pos[0] = (sliderH_label1_pos[0] * 0.9);
  sliderH_label2_pos[0] = (sliderH_label2_pos[0] * 0.9);
  if (mobile_device) {
      imgH_h = (imgH_h * 1.2);
      imgH_center_y = 0.15;
      slidertextH_center_y = (- 0.12);
      sliderH_center_y = (- 0.25);
  }
  
  // Run 'Begin Experiment' code from code_ratingDetectionH
  ratingGiven = false;
  
  textbox_reminderH = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_reminderH',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [reminderH_text_x, reminderH_text_y], 
    draggable: false,
    letterHeight: 0.03,
    lineSpacing: 1.0,
    size: [0.8, 0.1],  units: undefined, 
    ori: 0.0,
    color: [0.7255, (- 0.8431), (- 0.5294)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -3.0 
  });
  
  imageH = new visual.ImageStim({
    win : psychoJS.window,
    name : 'imageH', units : undefined, 
    image : 'default.png', mask : undefined,
    anchor : 'center',
    ori : 0.0, 
    pos : [imgH_center_x, imgH_center_y], 
    draggable: false,
    size : [imgH_w, imgH_h],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -4.0 
  });
  textbox_sliderH = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_sliderH',
    text: '',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [slidertextH_center_x, slidertextH_center_y], 
    draggable: false,
    letterHeight: 0.03,
    lineSpacing: 1.0,
    size: [0.8, 0.15],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: [1.0, 1.0, 1.0], borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -5.0 
  });
  
  slider_H = new visual.Slider({
    win: psychoJS.window, name: 'slider_H',
    startValue: 50,
    size: 1.0, pos: [sliderH_center_x, sliderH_center_y], ori: 0.0, units: psychoJS.window.units,
    labels: undefined, fontSize: 0.05, ticks: [0, 100],
    granularity: 0.0, style: ["SLIDER"],
    color: new util.Color('white'), markerColor: new util.Color(slider_markercolor), lineColor: new util.Color(slider_linecolor), 
    opacity: undefined, fontFamily: 'Open Sans', bold: true, italic: false, depth: -6, 
    flip: false,
  });
  
  textbox_sliderH_leftAnchor = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_sliderH_leftAnchor',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: labelH_letter_height,
    lineSpacing: 1.0,
    size: [0.25, 0.1],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -7.0 
  });
  
  textbox_sliderH_rightAnchor = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_sliderH_rightAnchor',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: labelH_letter_height,
    lineSpacing: 1.0,
    size: [0.25, 0.1],  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-right',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -8.0 
  });
  
  polygon_submitbuttonH = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbuttonH', 
    width: submitbutton_size[0], height: submitbutton_size[1],
    ori: 0.0, 
    pos: submitbutton_xy, 
    draggable: false, 
    anchor: 'center', 
    lineWidth: submitbutton_edgethickness, 
    lineColor: new util.Color(submitbutton_bordercolor), 
    fillColor: new util.Color(submitbutton_fillcolor), 
    colorSpace: 'rgb', 
    opacity: 1.0, 
    depth: -9, 
    interpolate: true, 
  });
  
  textbox_submitbuttonH = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbuttonH',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: submitbutton_xy, 
    draggable: false,
    letterHeight: 0.07,
    lineSpacing: 1.0,
    size: submitbutton_size,  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: submitbutton_bordercolor,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -10.0 
  });
  
  mouseH = new core.Mouse({
    win: psychoJS.window,
  });
  mouseH.mouseClock = new util.Clock();
  // Initialize components for Routine "reRandomize"
  reRandomizeClock = new util.Clock();
  // Initialize components for Routine "prep_trial34"
  prep_trial34Clock = new util.Clock();
  // Initialize components for Routine "instructions_3"
  instructions_3Clock = new util.Clock();
  // Run 'Begin Experiment' code from code_instructions_3
  submitbutton_opacity = null;
  
  textbox_instructions_3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_instructions_3',
    text: '',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0, 0.1], 
    draggable: false,
    letterHeight: 0.035,
    lineSpacing: 1.0,
    size: 1.0,  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  mouse_instructions_3 = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_instructions_3.mouseClock = new util.Clock();
  polygon_submitbutton_3 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbutton_3', 
    width: [1.0, 1.0][0], height: [1.0, 1.0][1],
    ori: 0.0, 
    pos: [0, 0], 
    draggable: false, 
    anchor: 'center', 
    lineWidth: 2.0, 
    lineColor: new util.Color([(- 1), (- 1), (- 1)]), 
    fillColor: new util.Color([0.9, 0.9, 0.9]), 
    colorSpace: 'rgb', 
    opacity: 1.0, 
    depth: -4, 
    interpolate: true, 
  });
  
  textbox_submitbutton_3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbutton_3',
    text: '',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: 1.0,  units: undefined, 
    ori: 0.0,
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -5.0 
  });
  
  // Initialize components for Routine "rating"
  ratingClock = new util.Clock();
  // Run 'Begin Experiment' code from code_rating
  j = 0;
  ratingX = 0;
  ratingY = [0.4, 0.3, 0.2, 0.1, (- 0.1), (- 0.2), (- 0.3), (- 0.4)];
  ratingW = 0.8;
  ratingH = 0.08;
  ratingBackColor = [0.8549, 0.8549, 0.8549];
  rating_letterHeight = 0.03;
  ratingCond = ["", "", "", ""];
  
  polygon_target1 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_target1', 
    width: [ratingW, ratingH][0], height: [ratingW, ratingH][1],
    ori: 0.0, 
    pos: [0, 0], 
    draggable: false, 
    anchor: 'center', 
    lineWidth: 1.0, 
    lineColor: new util.Color([(- 1.0), (- 1.0), (- 1.0)]), 
    fillColor: undefined, 
    colorSpace: 'rgb', 
    opacity: undefined, 
    depth: -1, 
    interpolate: true, 
  });
  
  polygon_target2 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_target2', 
    width: [ratingW, ratingH][0], height: [ratingW, ratingH][1],
    ori: 0.0, 
    pos: [0, 0], 
    draggable: false, 
    anchor: 'center', 
    lineWidth: 1.0, 
    lineColor: new util.Color([(- 1.0), (- 1.0), (- 1.0)]), 
    fillColor: undefined, 
    colorSpace: 'rgb', 
    opacity: undefined, 
    depth: -2, 
    interpolate: true, 
  });
  
  polygon_target3 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_target3', 
    width: [ratingW, ratingH][0], height: [ratingW, ratingH][1],
    ori: 0.0, 
    pos: [ratingX, ratingY[2]], 
    draggable: false, 
    anchor: 'center', 
    lineWidth: 1.0, 
    lineColor: new util.Color([(- 1.0), (- 1.0), (- 1.0)]), 
    fillColor: undefined, 
    colorSpace: 'rgb', 
    opacity: undefined, 
    depth: -3, 
    interpolate: true, 
  });
  
  polygon_target4 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_target4', 
    width: [ratingW, ratingH][0], height: [ratingW, ratingH][1],
    ori: 0.0, 
    pos: [0, 0], 
    draggable: false, 
    anchor: 'center', 
    lineWidth: 1.0, 
    lineColor: new util.Color([(- 1.0), (- 1.0), (- 1.0)]), 
    fillColor: undefined, 
    colorSpace: 'rgb', 
    opacity: undefined, 
    depth: -4, 
    interpolate: true, 
  });
  
  textbox_cond1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_cond1',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [ratingX, ratingY[4]], 
    draggable: false,
    letterHeight: rating_letterHeight,
    lineSpacing: 1.0,
    size: [ratingW, ratingH],  units: undefined, 
    ori: 0.0,
    color: 'black', colorSpace: 'rgb',
    fillColor: 'white', borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -5.0 
  });
  
  textbox_cond2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_cond2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [ratingX, ratingY[5]], 
    draggable: false,
    letterHeight: rating_letterHeight,
    lineSpacing: 1.0,
    size: [ratingW, ratingH],  units: undefined, 
    ori: 0.0,
    color: 'black', colorSpace: 'rgb',
    fillColor: 'white', borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -6.0 
  });
  
  textbox_cond3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_cond3',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [ratingX, ratingY[6]], 
    draggable: false,
    letterHeight: rating_letterHeight,
    lineSpacing: 1.0,
    size: [ratingW, ratingH],  units: undefined, 
    ori: 0.0,
    color: 'black', colorSpace: 'rgb',
    fillColor: 'white', borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -7.0 
  });
  
  textbox_cond4 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_cond4',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [ratingX, ratingY[7]], 
    draggable: false,
    letterHeight: rating_letterHeight,
    lineSpacing: 1.0,
    size: [ratingW, ratingH],  units: undefined, 
    ori: 0.0,
    color: 'black', colorSpace: 'rgb',
    fillColor: 'white', borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -8.0 
  });
  
  mouseR = new core.Mouse({
    win: psychoJS.window,
  });
  mouseR.mouseClock = new util.Clock();
  textbox_submitbuttonR = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbuttonR',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.07,
    lineSpacing: 1.0,
    size: submitbutton_size,  units: undefined, 
    ori: 0.0,
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: submitbutton_bordercolor,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -10.0 
  });
  
  textbox_target1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_target1',
    text: '1.',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [(ratingX - (ratingW / 2)), ratingY[0]], 
    draggable: false,
    letterHeight: rating_letterHeight,
    lineSpacing: 1.0,
    size: [0.1, ratingH],  units: undefined, 
    ori: 0.0,
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-right',
    depth: -11.0 
  });
  
  textbox_target2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_target2',
    text: '2.',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [(ratingX - (ratingW / 2)), ratingY[1]], 
    draggable: false,
    letterHeight: rating_letterHeight,
    lineSpacing: 1.0,
    size: [0.1, ratingH],  units: undefined, 
    ori: 0.0,
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-right',
    depth: -12.0 
  });
  
  textbox_target3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_target3',
    text: '3.',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [(ratingX - (ratingW / 2)), ratingY[2]], 
    draggable: false,
    letterHeight: rating_letterHeight,
    lineSpacing: 1.0,
    size: [0.1, ratingH],  units: undefined, 
    ori: 0.0,
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-right',
    depth: -13.0 
  });
  
  textbox_target4 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_target4',
    text: '4.',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [(ratingX - (ratingW / 2)), ratingY[3]], 
    draggable: false,
    letterHeight: rating_letterHeight,
    lineSpacing: 1.0,
    size: [0.1, ratingH],  units: undefined, 
    ori: 0.0,
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center-right',
    depth: -14.0 
  });
  
  // Initialize components for Routine "end"
  endClock = new util.Clock();
  textbox_end = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_end',
    text: '',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0, 0.1], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [0.9, 0.5],  units: undefined, 
    ori: 0.0,
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -1.0 
  });
  
  textbox_wait = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_wait',
    text: '',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0, (- 0.1)], 
    draggable: false,
    letterHeight: 0.03,
    lineSpacing: 1.0,
    size: [0.7, 0.5],  units: undefined, 
    ori: 0.0,
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -2.0 
  });
  
  // Create some handy timers
  globalClock = new util.Clock();  // to track the time since experiment started
  routineTimer = new util.CountdownTimer();  // to track time remaining of each (non-slip) routine
  
  return Scheduler.Event.NEXT;
}


var t;
var frameN;
var continueRoutine;
var global_varsMaxDurationReached;
var global_varsMaxDuration;
var global_varsComponents;
function global_varsRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'global_vars' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    global_varsClock.reset();
    routineTimer.reset();
    global_varsMaxDurationReached = false;
    // update component parameters for each repeat
    global_varsMaxDuration = null
    // keep track of which components have finished
    global_varsComponents = [];
    
    for (const thisComponent of global_varsComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function global_varsRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'global_vars' ---
    // get current time
    t = global_varsClock.getTime();
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
    for (const thisComponent of global_varsComponents)
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


function global_varsRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'global_vars' ---
    for (const thisComponent of global_varsComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "global_vars" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var mobile_detectionMaxDurationReached;
var mobile_detectionMaxDuration;
var mobile_detectionComponents;
function mobile_detectionRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'mobile_detection' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    mobile_detectionClock.reset();
    routineTimer.reset();
    mobile_detectionMaxDurationReached = false;
    // update component parameters for each repeat
    mobile_detectionMaxDuration = null
    // keep track of which components have finished
    mobile_detectionComponents = [];
    
    for (const thisComponent of mobile_detectionComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function mobile_detectionRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'mobile_detection' ---
    // get current time
    t = mobile_detectionClock.getTime();
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
    for (const thisComponent of mobile_detectionComponents)
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


function mobile_detectionRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'mobile_detection' ---
    for (const thisComponent of mobile_detectionComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "mobile_detection" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var language_choiceMaxDurationReached;
var yrange;
var last_xrange;
var sourcetext_xy;
var gotValidClick;
var language_choiceMaxDuration;
var language_choiceComponents;
function language_choiceRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'language_choice' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    language_choiceClock.reset();
    routineTimer.reset();
    language_choiceMaxDurationReached = false;
    // update component parameters for each repeat
    // Window size
    // in js: 1=height; 0=width
    window_height = psychoJS.window.size[1];
    window_width = psychoJS.window.size[0];
    
    xrange = (window_width / window_height);
    yrange = (window_height / window_width);
    last_xrange = xrange;
    
    // Positional arguments
    sourcetext_xy = [(0.3 * Math.max(1, xrange)), ((- 0.48) * Math.max(1, yrange))];
    
    // setup some python lists for storing info about the mouse_languagechoice
    mouse_languagechoice.clicked_name = [];
    gotValidClick = false; // until a click is received
    language_choiceMaxDuration = null
    // keep track of which components have finished
    language_choiceComponents = [];
    language_choiceComponents.push(image_germanyflag);
    language_choiceComponents.push(image_ukflag);
    language_choiceComponents.push(textbox_languagechoice);
    language_choiceComponents.push(mouse_languagechoice);
    language_choiceComponents.push(textbox_sourceflag);
    
    for (const thisComponent of language_choiceComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


var image_ukflag_opacity;
var image_germanyflag_opacity;
var prevButtonState;
var _mouseButtons;
function language_choiceRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'language_choice' ---
    // get current time
    t = language_choiceClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Hovereffect for both countryflag-images
    if ((! mobile_device)) {
        if (image_ukflag.contains(mouse_languagechoice)) {
            image_ukflag_opacity = opacity2;
        } else {
            image_ukflag_opacity = opacity1;
        }
        if (image_germanyflag.contains(mouse_languagechoice)) {
            image_germanyflag_opacity = opacity2;
        } else {
            image_germanyflag_opacity = opacity1;
        }
    }
    
    // Window size
    window_height = psychoJS.window.size[1];
    window_width = psychoJS.window.size[0];
    xrange = (window_width / window_height);
    
    if ((xrange !== last_xrange)) {
        // Size changed
        last_xrange = xrange;
        yrange = (window_height / window_width);
        sourcetext_xy = [(0.3 * Math.max(1, xrange)), ((- 0.48) * Math.max(1, yrange))];
    }
    
    
    if (image_germanyflag.status === PsychoJS.Status.STARTED){ // only update if being drawn
      image_germanyflag.setOpacity(image_germanyflag_opacity , false);
    }
    
    // *image_germanyflag* updates
    if (t >= 0.0 && image_germanyflag.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      image_germanyflag.tStart = t;  // (not accounting for frame time here)
      image_germanyflag.frameNStart = frameN;  // exact frame index
      
      image_germanyflag.setAutoDraw(true);
    }
    
    
    if (image_ukflag.status === PsychoJS.Status.STARTED){ // only update if being drawn
      image_ukflag.setOpacity(image_ukflag_opacity , false);
    }
    
    // *image_ukflag* updates
    if (t >= 0.0 && image_ukflag.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      image_ukflag.tStart = t;  // (not accounting for frame time here)
      image_ukflag.frameNStart = frameN;  // exact frame index
      
      image_ukflag.setAutoDraw(true);
    }
    
    
    // *textbox_languagechoice* updates
    if (t >= 0.0 && textbox_languagechoice.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_languagechoice.tStart = t;  // (not accounting for frame time here)
      textbox_languagechoice.frameNStart = frameN;  // exact frame index
      
      textbox_languagechoice.setAutoDraw(true);
    }
    
    // *mouse_languagechoice* updates
    if (t >= 0.5 && mouse_languagechoice.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_languagechoice.tStart = t;  // (not accounting for frame time here)
      mouse_languagechoice.frameNStart = frameN;  // exact frame index
      
      mouse_languagechoice.status = PsychoJS.Status.STARTED;
      mouse_languagechoice.mouseClock.reset();
      prevButtonState = mouse_languagechoice.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_languagechoice.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_languagechoice.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          mouse_languagechoice.clickableObjects = eval([image_germanyflag, image_ukflag])
          ;// make sure the mouse's clickable objects are an array
          if (!Array.isArray(mouse_languagechoice.clickableObjects)) {
              mouse_languagechoice.clickableObjects = [mouse_languagechoice.clickableObjects];
          }
          // iterate through clickable objects and check each
          for (const obj of mouse_languagechoice.clickableObjects) {
              if (obj.contains(mouse_languagechoice)) {
                  gotValidClick = true;
                  mouse_languagechoice.clicked_name.push(obj.name);
              }
          }
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          mouse_languagechoice.clickableObjects = eval([image_germanyflag, image_ukflag])
          ;// make sure the mouse's clickable objects are an array
          if (!Array.isArray(mouse_languagechoice.clickableObjects)) {
              mouse_languagechoice.clickableObjects = [mouse_languagechoice.clickableObjects];
          }
          // iterate through clickable objects and check each
          for (const obj of mouse_languagechoice.clickableObjects) {
              if (obj.contains(mouse_languagechoice)) {
                  gotValidClick = true;
                  mouse_languagechoice.clicked_name.push(obj.name);
              }
          }
          if (gotValidClick === true) { // end routine on response
            continueRoutine = false;
          }
        }
      }
    }
    
    if (textbox_sourceflag.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_sourceflag.setPos(sourcetext_xy, false);
    }
    
    // *textbox_sourceflag* updates
    if (t >= 0.0 && textbox_sourceflag.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_sourceflag.tStart = t;  // (not accounting for frame time here)
      textbox_sourceflag.frameNStart = frameN;  // exact frame index
      
      textbox_sourceflag.setAutoDraw(true);
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
    for (const thisComponent of language_choiceComponents)
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


var submitbutton_text;
var text_wanting;
var labels_wanting;
var categoryWanting;
var text_healthiness;
var labels_healthiness;
var categoryHealthiness;
var text_sustainability;
var labels_sustainability;
var categorySustainability;
var text_liking;
var labels_liking;
var categoryLiking;
function language_choiceRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'language_choice' ---
    for (const thisComponent of language_choiceComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // If clicked on the german (uk) flag, the language choice is set 
    // to german (english)
    if ((mouse_languagechoice.clicked_name[0] === "image_germanyflag")) {
        languagechoice = "ger";
    } else {
        languagechoice = "uk";
    }
    
    // Store chosen language
    expInfo["language"] = languagechoice;
    
    // set some widely used text-options
    if ((languagechoice === "ger")) {
        submitbutton_text = "Weiter";
        reminder_text = "Bitte geben Sie \u00fcber den Slider eine Reaktion ab, um fortfahren zu k\u00f6nnen!";
        // text & labels for conditions
        text_wanting = "Wie sehr wollen Sie das in diesem Durchgang Gezeigte essen?";
        labels_wanting = ["\u00dcberhaupt nicht", "Sehr stark"];
        categoryWanting = "Verlangen";
        text_healthiness = "Wie gesund sch\u00e4tzen Sie dieses Essen ein ?";
        labels_healthiness = ["\u00dcberhaupt nicht", "Sehr"];
        categoryHealthiness = "Gesundheit";
        text_sustainability = "Wie \u00f6kologisch nachhaltig sch\u00e4tzen Sie dieses Essen ein?";
        labels_sustainability = ["\u00dcberhaupt nicht", "Sehr"];
        categorySustainability = "\u00f6kologische Nachhaltigkeit";
        text_liking = "Bitte bewerten Sie das Pr\u00e4sentierte im Vergleich zu allen bisher in ihrem Leben erfahrenen Empfindungen.";
        labels_liking = ["am allerst\u00e4rksten gemochte \nEmpfindung, die vorstellbar ist",
        "extrem gern", "sehr gern", "gern", "ein bisschen gern", "neutral",
        "ein bisschen ungern", "ungern", "sehr ungern", "extrem ungern",
        "am allerst\u00e4rksten zuwidere \nEmpfindung, die vorstellbar ist"];
        categoryLiking = "Geschmack";
    } else {
        submitbutton_text = "Submit";
        reminder_text = "Please give a reaction via the slider to be able to continue!";
        // text & labels for conditions
        text_wanting = "How much do you want to eat the item in this trial?";
        labels_wanting = ["Not at all", "Very much"];
        categoryWanting = "wanting";
        text_healthiness = "How healthy do you think this food is?";
        labels_healthiness = ["Not at all", "Very"];
        categoryHealthiness = "healthiness";
        text_sustainability = "How environmentally sustainable do you think this food is?";
        labels_sustainability = ["Not at all", "Very"];
        categorySustainability = "environmental sustainability";
        text_liking = "Please rate the reward in comparison with all of the sensations you have experienced in your life.";
        labels_liking = ["most liked sensation imaginable", "like extremely",
        "like very much", "like moderately", "like slightly", "neutral",
        "slightly dislike", "moderately dislike", "dislike very much",
        "extremely dislike", "most disliked sensation imaginable"];
        categoryLiking = "liking";
    }
    
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "language_choice" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var instructionReadLoop;
function instructionReadLoopLoopBegin(instructionReadLoopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    instructionReadLoop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: 1, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: 'stimuli/instructions.xlsx',
      seed: undefined, name: 'instructionReadLoop'
    });
    psychoJS.experiment.addLoop(instructionReadLoop); // add the loop to the experiment
    currentLoop = instructionReadLoop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisInstructionReadLoop of instructionReadLoop) {
      snapshot = instructionReadLoop.getSnapshot();
      instructionReadLoopLoopScheduler.add(importConditions(snapshot));
      instructionReadLoopLoopScheduler.add(load_instructionsRoutineBegin(snapshot));
      instructionReadLoopLoopScheduler.add(load_instructionsRoutineEachFrame());
      instructionReadLoopLoopScheduler.add(load_instructionsRoutineEnd(snapshot));
      instructionReadLoopLoopScheduler.add(instructionReadLoopLoopEndIteration(instructionReadLoopLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


async function instructionReadLoopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(instructionReadLoop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function instructionReadLoopLoopEndIteration(scheduler, snapshot) {
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


var imageListReadLoop;
function imageListReadLoopLoopBegin(imageListReadLoopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    imageListReadLoop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: 1, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: 'stimuli/imageList.xlsx',
      seed: undefined, name: 'imageListReadLoop'
    });
    psychoJS.experiment.addLoop(imageListReadLoop); // add the loop to the experiment
    currentLoop = imageListReadLoop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisImageListReadLoop of imageListReadLoop) {
      snapshot = imageListReadLoop.getSnapshot();
      imageListReadLoopLoopScheduler.add(importConditions(snapshot));
      imageListReadLoopLoopScheduler.add(load_imageListRoutineBegin(snapshot));
      imageListReadLoopLoopScheduler.add(load_imageListRoutineEachFrame());
      imageListReadLoopLoopScheduler.add(load_imageListRoutineEnd(snapshot));
      imageListReadLoopLoopScheduler.add(imageListReadLoopLoopEndIteration(imageListReadLoopLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


async function imageListReadLoopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(imageListReadLoop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function imageListReadLoopLoopEndIteration(scheduler, snapshot) {
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


var images_block1_loop;
function images_block1_loopLoopBegin(images_block1_loopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    images_block1_loop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: img_count, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'images_block1_loop'
    });
    psychoJS.experiment.addLoop(images_block1_loop); // add the loop to the experiment
    currentLoop = images_block1_loop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisImages_block1_loop of images_block1_loop) {
      snapshot = images_block1_loop.getSnapshot();
      images_block1_loopLoopScheduler.add(importConditions(snapshot));
      images_block1_loopLoopScheduler.add(fixationRoutineBegin(snapshot));
      images_block1_loopLoopScheduler.add(fixationRoutineEachFrame());
      images_block1_loopLoopScheduler.add(fixationRoutineEnd(snapshot));
      const conditions12_loopLoopScheduler = new Scheduler(psychoJS);
      images_block1_loopLoopScheduler.add(conditions12_loopLoopBegin(conditions12_loopLoopScheduler, snapshot));
      images_block1_loopLoopScheduler.add(conditions12_loopLoopScheduler);
      images_block1_loopLoopScheduler.add(conditions12_loopLoopEnd);
      images_block1_loopLoopScheduler.add(images_block1_loopLoopEndIteration(images_block1_loopLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


var conditions12_loop;
function conditions12_loopLoopBegin(conditions12_loopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    conditions12_loop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: 2, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'conditions12_loop'
    });
    psychoJS.experiment.addLoop(conditions12_loop); // add the loop to the experiment
    currentLoop = conditions12_loop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisConditions12_loop of conditions12_loop) {
      snapshot = conditions12_loop.getSnapshot();
      conditions12_loopLoopScheduler.add(importConditions(snapshot));
      conditions12_loopLoopScheduler.add(prep_trial12RoutineBegin(snapshot));
      conditions12_loopLoopScheduler.add(prep_trial12RoutineEachFrame());
      conditions12_loopLoopScheduler.add(prep_trial12RoutineEnd(snapshot));
      const vertical_optionLoopScheduler = new Scheduler(psychoJS);
      conditions12_loopLoopScheduler.add(vertical_optionLoopBegin(vertical_optionLoopScheduler, snapshot));
      conditions12_loopLoopScheduler.add(vertical_optionLoopScheduler);
      conditions12_loopLoopScheduler.add(vertical_optionLoopEnd);
      const horizontal_optionLoopScheduler = new Scheduler(psychoJS);
      conditions12_loopLoopScheduler.add(horizontal_optionLoopBegin(horizontal_optionLoopScheduler, snapshot));
      conditions12_loopLoopScheduler.add(horizontal_optionLoopScheduler);
      conditions12_loopLoopScheduler.add(horizontal_optionLoopEnd);
      conditions12_loopLoopScheduler.add(conditions12_loopLoopEndIteration(conditions12_loopLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


var vertical_option;
function vertical_optionLoopBegin(vertical_optionLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    vertical_option = new TrialHandler({
      psychoJS: psychoJS,
      nReps: vertical_option, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'vertical_option'
    });
    psychoJS.experiment.addLoop(vertical_option); // add the loop to the experiment
    currentLoop = vertical_option;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisVertical_option of vertical_option) {
      snapshot = vertical_option.getSnapshot();
      vertical_optionLoopScheduler.add(importConditions(snapshot));
      vertical_optionLoopScheduler.add(slider_verticalRoutineBegin(snapshot));
      vertical_optionLoopScheduler.add(slider_verticalRoutineEachFrame());
      vertical_optionLoopScheduler.add(slider_verticalRoutineEnd(snapshot));
      vertical_optionLoopScheduler.add(vertical_optionLoopEndIteration(vertical_optionLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


async function vertical_optionLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(vertical_option);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function vertical_optionLoopEndIteration(scheduler, snapshot) {
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


var horizontal_option;
function horizontal_optionLoopBegin(horizontal_optionLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    horizontal_option = new TrialHandler({
      psychoJS: psychoJS,
      nReps: horizontal_option, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'horizontal_option'
    });
    psychoJS.experiment.addLoop(horizontal_option); // add the loop to the experiment
    currentLoop = horizontal_option;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisHorizontal_option of horizontal_option) {
      snapshot = horizontal_option.getSnapshot();
      horizontal_optionLoopScheduler.add(importConditions(snapshot));
      horizontal_optionLoopScheduler.add(slider_horizontalRoutineBegin(snapshot));
      horizontal_optionLoopScheduler.add(slider_horizontalRoutineEachFrame());
      horizontal_optionLoopScheduler.add(slider_horizontalRoutineEnd(snapshot));
      horizontal_optionLoopScheduler.add(horizontal_optionLoopEndIteration(horizontal_optionLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


async function horizontal_optionLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(horizontal_option);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function horizontal_optionLoopEndIteration(scheduler, snapshot) {
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


async function conditions12_loopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(conditions12_loop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function conditions12_loopLoopEndIteration(scheduler, snapshot) {
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


async function images_block1_loopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(images_block1_loop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function images_block1_loopLoopEndIteration(scheduler, snapshot) {
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


var images_block2_loop;
function images_block2_loopLoopBegin(images_block2_loopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    images_block2_loop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: img_count, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'images_block2_loop'
    });
    psychoJS.experiment.addLoop(images_block2_loop); // add the loop to the experiment
    currentLoop = images_block2_loop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisImages_block2_loop of images_block2_loop) {
      snapshot = images_block2_loop.getSnapshot();
      images_block2_loopLoopScheduler.add(importConditions(snapshot));
      images_block2_loopLoopScheduler.add(fixationRoutineBegin(snapshot));
      images_block2_loopLoopScheduler.add(fixationRoutineEachFrame());
      images_block2_loopLoopScheduler.add(fixationRoutineEnd(snapshot));
      const conditions34_loopLoopScheduler = new Scheduler(psychoJS);
      images_block2_loopLoopScheduler.add(conditions34_loopLoopBegin(conditions34_loopLoopScheduler, snapshot));
      images_block2_loopLoopScheduler.add(conditions34_loopLoopScheduler);
      images_block2_loopLoopScheduler.add(conditions34_loopLoopEnd);
      images_block2_loopLoopScheduler.add(images_block2_loopLoopEndIteration(images_block2_loopLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


var conditions34_loop;
function conditions34_loopLoopBegin(conditions34_loopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    conditions34_loop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: 2, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'conditions34_loop'
    });
    psychoJS.experiment.addLoop(conditions34_loop); // add the loop to the experiment
    currentLoop = conditions34_loop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisConditions34_loop of conditions34_loop) {
      snapshot = conditions34_loop.getSnapshot();
      conditions34_loopLoopScheduler.add(importConditions(snapshot));
      conditions34_loopLoopScheduler.add(prep_trial34RoutineBegin(snapshot));
      conditions34_loopLoopScheduler.add(prep_trial34RoutineEachFrame());
      conditions34_loopLoopScheduler.add(prep_trial34RoutineEnd(snapshot));
      const vertical_option2LoopScheduler = new Scheduler(psychoJS);
      conditions34_loopLoopScheduler.add(vertical_option2LoopBegin(vertical_option2LoopScheduler, snapshot));
      conditions34_loopLoopScheduler.add(vertical_option2LoopScheduler);
      conditions34_loopLoopScheduler.add(vertical_option2LoopEnd);
      const horizontal_option2LoopScheduler = new Scheduler(psychoJS);
      conditions34_loopLoopScheduler.add(horizontal_option2LoopBegin(horizontal_option2LoopScheduler, snapshot));
      conditions34_loopLoopScheduler.add(horizontal_option2LoopScheduler);
      conditions34_loopLoopScheduler.add(horizontal_option2LoopEnd);
      conditions34_loopLoopScheduler.add(conditions34_loopLoopEndIteration(conditions34_loopLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


var vertical_option2;
function vertical_option2LoopBegin(vertical_option2LoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    vertical_option2 = new TrialHandler({
      psychoJS: psychoJS,
      nReps: vertical_option, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'vertical_option2'
    });
    psychoJS.experiment.addLoop(vertical_option2); // add the loop to the experiment
    currentLoop = vertical_option2;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisVertical_option2 of vertical_option2) {
      snapshot = vertical_option2.getSnapshot();
      vertical_option2LoopScheduler.add(importConditions(snapshot));
      vertical_option2LoopScheduler.add(slider_verticalRoutineBegin(snapshot));
      vertical_option2LoopScheduler.add(slider_verticalRoutineEachFrame());
      vertical_option2LoopScheduler.add(slider_verticalRoutineEnd(snapshot));
      vertical_option2LoopScheduler.add(vertical_option2LoopEndIteration(vertical_option2LoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


async function vertical_option2LoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(vertical_option2);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function vertical_option2LoopEndIteration(scheduler, snapshot) {
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


var horizontal_option2;
function horizontal_option2LoopBegin(horizontal_option2LoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    horizontal_option2 = new TrialHandler({
      psychoJS: psychoJS,
      nReps: horizontal_option, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'horizontal_option2'
    });
    psychoJS.experiment.addLoop(horizontal_option2); // add the loop to the experiment
    currentLoop = horizontal_option2;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisHorizontal_option2 of horizontal_option2) {
      snapshot = horizontal_option2.getSnapshot();
      horizontal_option2LoopScheduler.add(importConditions(snapshot));
      horizontal_option2LoopScheduler.add(slider_horizontalRoutineBegin(snapshot));
      horizontal_option2LoopScheduler.add(slider_horizontalRoutineEachFrame());
      horizontal_option2LoopScheduler.add(slider_horizontalRoutineEnd(snapshot));
      horizontal_option2LoopScheduler.add(horizontal_option2LoopEndIteration(horizontal_option2LoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


async function horizontal_option2LoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(horizontal_option2);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function horizontal_option2LoopEndIteration(scheduler, snapshot) {
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


async function conditions34_loopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(conditions34_loop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function conditions34_loopLoopEndIteration(scheduler, snapshot) {
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


async function images_block2_loopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(images_block2_loop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function images_block2_loopLoopEndIteration(scheduler, snapshot) {
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


var load_instructionsMaxDurationReached;
var load_instructionsMaxDuration;
var load_instructionsComponents;
function load_instructionsRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'load_instructions' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    load_instructionsClock.reset();
    routineTimer.reset();
    load_instructionsMaxDurationReached = false;
    // update component parameters for each repeat
    load_instructionsMaxDuration = null
    // keep track of which components have finished
    load_instructionsComponents = [];
    
    for (const thisComponent of load_instructionsComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function load_instructionsRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'load_instructions' ---
    // get current time
    t = load_instructionsClock.getTime();
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
    for (const thisComponent of load_instructionsComponents)
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


function load_instructionsRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'load_instructions' ---
    for (const thisComponent of load_instructionsComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "load_instructions" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var load_imageListMaxDurationReached;
var load_imageListMaxDuration;
var load_imageListComponents;
function load_imageListRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'load_imageList' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    load_imageListClock.reset();
    routineTimer.reset();
    load_imageListMaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code
    imageList.push(imageNr);
    
    load_imageListMaxDuration = null
    // keep track of which components have finished
    load_imageListComponents = [];
    
    for (const thisComponent of load_imageListComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function load_imageListRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'load_imageList' ---
    // get current time
    t = load_imageListClock.getTime();
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
    for (const thisComponent of load_imageListComponents)
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


function load_imageListRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'load_imageList' ---
    for (const thisComponent of load_imageListComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "load_imageList" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var instructionsMaxDurationReached;
var button_instructions_xy;
var button_instructions_size;
var instructions_size;
var instructions_text;
var instructionsMaxDuration;
var instructionsComponents;
function instructionsRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'instructions' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    instructionsClock.reset();
    routineTimer.reset();
    instructionsMaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_instructions
    window_height = psychoJS.window.size[1];
    window_width = psychoJS.window.size[0];
    xrange = (window_width / window_height);
    yrange = (window_height / window_width);
    last_xrange = xrange;
    button_instructions_xy = [0, ((- 0.3) * Math.max(1, yrange))];
    button_instructions_size = [(0.5 * Math.max(1, Math.sqrt(Math.sqrt(xrange)))), (0.1 * Math.max(1, yrange))];
    instructions_size = [(0.9 * Math.max(1, Math.sqrt(xrange))), (0.6 * Math.max(1, Math.sqrt(yrange)))];
    if ((languagechoice === "ger")) {
        instructions_text = instr_ger;
    } else {
        instructions_text = instr_eng;
    }
    
    // make up for wrong line-breaks when reading file with javascript
    instructions_text = instructions_text.split('\\n').join('\n');
    textbox_instructions.setText(instructions_text);
    // setup some python lists for storing info about the mouse_instructions
    mouse_instructions.clicked_name = [];
    gotValidClick = false; // until a click is received
    textbox_submitbutton.setText(submitbutton_text);
    psychoJS.experiment.addData('instructions.started', globalClock.getTime());
    instructionsMaxDuration = null
    // keep track of which components have finished
    instructionsComponents = [];
    instructionsComponents.push(textbox_instructions);
    instructionsComponents.push(mouse_instructions);
    instructionsComponents.push(polygon_submitbutton);
    instructionsComponents.push(textbox_submitbutton);
    
    for (const thisComponent of instructionsComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function instructionsRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'instructions' ---
    // get current time
    t = instructionsClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Run 'Each Frame' code from code_instructions
    if ((! mobile_device)) {
        if (polygon_submitbutton.contains(mouse_instructions)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    window_height = psychoJS.window.size[1];
    window_width = psychoJS.window.size[0];
    xrange = (window_width / window_height);
    if ((xrange !== last_xrange)) {
        last_xrange = xrange;
        yrange = (window_height / window_width);
        button_instructions_xy = [0, ((- 0.3) * Math.max(1, yrange))];
        button_instructions_size = [(0.5 * Math.max(1, Math.sqrt(Math.sqrt(xrange)))), (0.1 * Math.max(1, yrange))];
        instructions_size = [(0.6 * Math.max(1, Math.sqrt(xrange))), (0.6 * Math.max(1, Math.sqrt(yrange)))];
    }
    
    
    if (textbox_instructions.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_instructions.setSize(instructions_size, false);
    }
    
    // *textbox_instructions* updates
    if (t >= 0.0 && textbox_instructions.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_instructions.tStart = t;  // (not accounting for frame time here)
      textbox_instructions.frameNStart = frameN;  // exact frame index
      
      textbox_instructions.setAutoDraw(true);
    }
    
    // *mouse_instructions* updates
    if (t >= 0.5 && mouse_instructions.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_instructions.tStart = t;  // (not accounting for frame time here)
      mouse_instructions.frameNStart = frameN;  // exact frame index
      
      mouse_instructions.status = PsychoJS.Status.STARTED;
      mouse_instructions.mouseClock.reset();
      prevButtonState = mouse_instructions.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_instructions.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_instructions.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          mouse_instructions.clickableObjects = eval([polygon_submitbutton])
          ;// make sure the mouse's clickable objects are an array
          if (!Array.isArray(mouse_instructions.clickableObjects)) {
              mouse_instructions.clickableObjects = [mouse_instructions.clickableObjects];
          }
          // iterate through clickable objects and check each
          for (const obj of mouse_instructions.clickableObjects) {
              if (obj.contains(mouse_instructions)) {
                  gotValidClick = true;
                  mouse_instructions.clicked_name.push(obj.name);
              }
          }
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          mouse_instructions.clickableObjects = eval([polygon_submitbutton])
          ;// make sure the mouse's clickable objects are an array
          if (!Array.isArray(mouse_instructions.clickableObjects)) {
              mouse_instructions.clickableObjects = [mouse_instructions.clickableObjects];
          }
          // iterate through clickable objects and check each
          for (const obj of mouse_instructions.clickableObjects) {
              if (obj.contains(mouse_instructions)) {
                  gotValidClick = true;
                  mouse_instructions.clicked_name.push(obj.name);
              }
          }
          if (gotValidClick === true) { // end routine on response
            continueRoutine = false;
          }
        }
      }
    }
    
    if (polygon_submitbutton.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_submitbutton.setOpacity(submitbutton_opacity, false);
      polygon_submitbutton.setPos(button_instructions_xy, false);
      polygon_submitbutton.setSize(button_instructions_size, false);
    }
    
    // *polygon_submitbutton* updates
    if (t >= 0.0 && polygon_submitbutton.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbutton.tStart = t;  // (not accounting for frame time here)
      polygon_submitbutton.frameNStart = frameN;  // exact frame index
      
      polygon_submitbutton.setAutoDraw(true);
    }
    
    
    if (textbox_submitbutton.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_submitbutton.setPos(button_instructions_xy, false);
      textbox_submitbutton.setSize(button_instructions_size, false);
    }
    
    // *textbox_submitbutton* updates
    if (t >= 0.0 && textbox_submitbutton.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbutton.tStart = t;  // (not accounting for frame time here)
      textbox_submitbutton.frameNStart = frameN;  // exact frame index
      
      textbox_submitbutton.setAutoDraw(true);
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
    for (const thisComponent of instructionsComponents)
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


function instructionsRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'instructions' ---
    for (const thisComponent of instructionsComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    psychoJS.experiment.addData('instructions.stopped', globalClock.getTime());
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "instructions" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var instructions_2MaxDurationReached;
var instructions2_text;
var instructions_2MaxDuration;
var instructions_2Components;
function instructions_2RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'instructions_2' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    instructions_2Clock.reset();
    routineTimer.reset();
    instructions_2MaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_instructions_2
    window_height = psychoJS.window.size[1];
    window_width = psychoJS.window.size[0];
    xrange = (window_width / window_height);
    yrange = (window_height / window_width);
    last_xrange = xrange;
    button_instructions_xy = [0, ((- 0.3) * Math.max(1, yrange))];
    button_instructions_size = [(0.5 * Math.max(1, Math.sqrt(Math.sqrt(xrange)))), (0.1 * Math.max(1, yrange))];
    instructions_size = [(0.9 * Math.max(1, Math.sqrt(xrange))), (0.6 * Math.max(1, Math.sqrt(yrange)))];
    if ((languagechoice === "ger")) {
        instructions2_text = instr2_ger;
    } else {
        instructions2_text = instr2_eng;
    }
    
    // make up for wrong line-breaks when reading file with javascript
    instructions2_text = instructions2_text.split('\\n').join('\n');
    textbox_instructions_2.setText(instructions2_text);
    // setup some python lists for storing info about the mouse_instructions_2
    mouse_instructions_2.clicked_name = [];
    gotValidClick = false; // until a click is received
    textbox_submitbutton_2.setText(submitbutton_text);
    psychoJS.experiment.addData('instructions_2.started', globalClock.getTime());
    instructions_2MaxDuration = null
    // keep track of which components have finished
    instructions_2Components = [];
    instructions_2Components.push(textbox_instructions_2);
    instructions_2Components.push(mouse_instructions_2);
    instructions_2Components.push(polygon_submitbutton_2);
    instructions_2Components.push(textbox_submitbutton_2);
    
    for (const thisComponent of instructions_2Components)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function instructions_2RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'instructions_2' ---
    // get current time
    t = instructions_2Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Run 'Each Frame' code from code_instructions_2
    if ((! mobile_device)) {
        if (polygon_submitbutton.contains(mouse_instructions)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    window_height = psychoJS.window.size[1];
    window_width = psychoJS.window.size[0];
    xrange = (window_width / window_height);
    if ((xrange !== last_xrange)) {
        last_xrange = xrange;
        yrange = (window_height / window_width);
        button_instructions_xy = [0, ((- 0.3) * Math.max(1, yrange))];
        button_instructions_size = [(0.5 * Math.max(1, Math.sqrt(Math.sqrt(xrange)))), (0.1 * Math.max(1, yrange))];
        instructions_size = [(0.6 * Math.max(1, Math.sqrt(xrange))), (0.6 * Math.max(1, Math.sqrt(yrange)))];
    }
    
    
    if (textbox_instructions_2.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_instructions_2.setSize(instructions_size, false);
    }
    
    // *textbox_instructions_2* updates
    if (t >= 0.0 && textbox_instructions_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_instructions_2.tStart = t;  // (not accounting for frame time here)
      textbox_instructions_2.frameNStart = frameN;  // exact frame index
      
      textbox_instructions_2.setAutoDraw(true);
    }
    
    // *mouse_instructions_2* updates
    if (t >= 0.5 && mouse_instructions_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_instructions_2.tStart = t;  // (not accounting for frame time here)
      mouse_instructions_2.frameNStart = frameN;  // exact frame index
      
      mouse_instructions_2.status = PsychoJS.Status.STARTED;
      mouse_instructions_2.mouseClock.reset();
      prevButtonState = mouse_instructions_2.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_instructions_2.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_instructions_2.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          mouse_instructions_2.clickableObjects = eval([polygon_submitbutton_2])
          ;// make sure the mouse's clickable objects are an array
          if (!Array.isArray(mouse_instructions_2.clickableObjects)) {
              mouse_instructions_2.clickableObjects = [mouse_instructions_2.clickableObjects];
          }
          // iterate through clickable objects and check each
          for (const obj of mouse_instructions_2.clickableObjects) {
              if (obj.contains(mouse_instructions_2)) {
                  gotValidClick = true;
                  mouse_instructions_2.clicked_name.push(obj.name);
              }
          }
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          mouse_instructions_2.clickableObjects = eval([polygon_submitbutton_2])
          ;// make sure the mouse's clickable objects are an array
          if (!Array.isArray(mouse_instructions_2.clickableObjects)) {
              mouse_instructions_2.clickableObjects = [mouse_instructions_2.clickableObjects];
          }
          // iterate through clickable objects and check each
          for (const obj of mouse_instructions_2.clickableObjects) {
              if (obj.contains(mouse_instructions_2)) {
                  gotValidClick = true;
                  mouse_instructions_2.clicked_name.push(obj.name);
              }
          }
          if (gotValidClick === true) { // end routine on response
            continueRoutine = false;
          }
        }
      }
    }
    
    if (polygon_submitbutton_2.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_submitbutton_2.setOpacity(submitbutton_opacity, false);
      polygon_submitbutton_2.setPos(button_instructions_xy, false);
      polygon_submitbutton_2.setSize(button_instructions_size, false);
    }
    
    // *polygon_submitbutton_2* updates
    if (t >= 0.0 && polygon_submitbutton_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbutton_2.tStart = t;  // (not accounting for frame time here)
      polygon_submitbutton_2.frameNStart = frameN;  // exact frame index
      
      polygon_submitbutton_2.setAutoDraw(true);
    }
    
    
    if (textbox_submitbutton_2.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_submitbutton_2.setPos(button_instructions_xy, false);
      textbox_submitbutton_2.setSize(button_instructions_size, false);
    }
    
    // *textbox_submitbutton_2* updates
    if (t >= 0.0 && textbox_submitbutton_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbutton_2.tStart = t;  // (not accounting for frame time here)
      textbox_submitbutton_2.frameNStart = frameN;  // exact frame index
      
      textbox_submitbutton_2.setAutoDraw(true);
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
    for (const thisComponent of instructions_2Components)
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


function instructions_2RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'instructions_2' ---
    for (const thisComponent of instructions_2Components) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    psychoJS.experiment.addData('instructions_2.stopped', globalClock.getTime());
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "instructions_2" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var preparationMaxDurationReached;
var images;
var conditions;
var shuffled_conditions;
var temp;
var preparationMaxDuration;
var preparationComponents;
function preparationRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'preparation' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    preparationClock.reset();
    routineTimer.reset();
    preparationMaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_prepConditions
    img_count = imageList.length;
    images = imageList;
    conditions = ["liking", "wanting", "healthiness", "sustainability"];
    shuffled_conditions = [];
    temp = [];
    images = shuffle_array(images);
    i = 0;
    while ((i < img_count)) {
        shuffled_conditions = shuffle_array(conditions);
        temp = [images[i]];
        temp.push(shuffled_conditions[0]);
        temp.push(shuffled_conditions[1]);
        temp.push(shuffled_conditions[2]);
        temp.push(shuffled_conditions[3]);
        image_conditions.push(temp);
        i += 1;
    }
    /*
    # debug prints:
    print(image_conditions)
    
    print(images)
    i = 0
    while i < img_count:
    print(image_conditions[i])
    i += 1*/
    
    preparationMaxDuration = null
    // keep track of which components have finished
    preparationComponents = [];
    
    for (const thisComponent of preparationComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function preparationRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'preparation' ---
    // get current time
    t = preparationClock.getTime();
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
    for (const thisComponent of preparationComponents)
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


function preparationRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'preparation' ---
    for (const thisComponent of preparationComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "preparation" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var fixationMaxDurationReached;
var myStart;
var fixationMaxDuration;
var fixationComponents;
function fixationRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'fixation' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    fixationClock.reset(routineTimer.getTime());
    routineTimer.add(1.000000);
    fixationMaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_fixation
    myStart = globalClock.getTime();
    
    psychoJS.experiment.addData('fixation.started', globalClock.getTime());
    fixationMaxDuration = null
    // keep track of which components have finished
    fixationComponents = [];
    fixationComponents.push(fixation_cross);
    
    for (const thisComponent of fixationComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


var frameRemains;
function fixationRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'fixation' ---
    // get current time
    t = fixationClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *fixation_cross* updates
    if (t >= 0.0 && fixation_cross.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      fixation_cross.tStart = t;  // (not accounting for frame time here)
      fixation_cross.frameNStart = frameN;  // exact frame index
      
      fixation_cross.setAutoDraw(true);
    }
    
    frameRemains = 0.0 + 1.0 - psychoJS.window.monitorFramePeriod * 0.75;// most of one frame period left
    if (fixation_cross.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      fixation_cross.setAutoDraw(false);
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
    for (const thisComponent of fixationComponents)
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


var myEnd;
var myDur;
function fixationRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'fixation' ---
    for (const thisComponent of fixationComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    psychoJS.experiment.addData('fixation.stopped', globalClock.getTime());
    // Run 'End Routine' code from code_fixation
    myEnd = globalClock.getTime();
    myDur = (myEnd - myStart);
    psychoJS.experiment.addData("isiDur", myDur);
    
    if (fixationMaxDurationReached) {
        fixationClock.add(fixationMaxDuration);
    } else {
        fixationClock.add(1.000000);
    }
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var prep_trial12MaxDurationReached;
var ili;
var cli;
var img_index;
var img_file;
var liking_option;
var wanting_option;
var sustain_option;
var health_option;
var condi;
var cond;
var sliderV_text;
var prep_trial12MaxDuration;
var prep_trial12Components;
function prep_trial12RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'prep_trial12' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    prep_trial12Clock.reset();
    routineTimer.reset();
    prep_trial12MaxDurationReached = false;
    // update component parameters for each repeat
    // The "conditions12_loop" iterates twice in order to
    // present 2 conditions for the current image.
    // The "vertical_option" & "horizontal_option" loops
    // only iterate if the respective condition is up.
    
    globalTrialCounter = (globalTrialCounter + 1);
    psychoJS.experiment.addData("globalTrialCounter", globalTrialCounter);
    psychoJS.experiment.addData("blockNum", 1);
    
    // get current indize
    ili = images_block1_loop.thisN; // current image loop index
    cli = conditions12_loop.thisN; // current condition loop index
    
    // extract infos for current image
    img_index = image_conditions[ili][0];
    img_file = ((img_path + img_index.toString()) + ".jpg");
    
    // this options declare which slider/condition is used
    liking_option = 0;
    wanting_option = 0;
    sustain_option = 0;
    health_option = 0;
    vertical_option = 0;
    horizontal_option = 1; // standard for all but liking condition
    
    condi = (cli + 1); // real index of current condition in image_conditions structure
    psychoJS.experiment.addData("imageRepitition", condi); // counter for image repititions
    cond = image_conditions[ili][condi]; // get the current condition
    
    // make settings depending on the current condition
    if ((cond === "liking")) {
        liking_option = 1;
        vertical_option = 1;
        horizontal_option = 0;
        sliderV_text = text_liking;
        slider_labelcolor = likingColor;
        psychoJS.experiment.addData("conditionNr", 1);
    } else {
        if ((cond === "wanting")) {
            wanting_option = 1;
            sliderH_text = text_wanting;
            sliderH_leftAnchor_text = labels_wanting[0];
            sliderH_rightAnchor_text = labels_wanting[1];
            slider_labelcolor = wantingColor;
            psychoJS.experiment.addData("conditionNr", 2);
        } else {
            if ((cond === "sustainability")) {
                sustain_option = 1;
                sliderH_text = text_sustainability;
                sliderH_leftAnchor_text = labels_sustainability[0];
                sliderH_rightAnchor_text = labels_sustainability[1];
                slider_labelcolor = sustainColor;
                psychoJS.experiment.addData("conditionNr", 3);
            } else {
                if ((cond === "healthiness")) {
                    health_option = 1;
                    sliderH_text = text_healthiness;
                    sliderH_leftAnchor_text = labels_healthiness[0];
                    sliderH_rightAnchor_text = labels_healthiness[1];
                    slider_labelcolor = healthColor;
                    psychoJS.experiment.addData("conditionNr", 4);
                }
            }
        }
    }
    psychoJS.experiment.addData("condition", cond);
    psychoJS.experiment.addData("image", img_index);
    psychoJS.experiment.addData("sliderType", horizontal_option); // 1 for horizontal slider
    
    prep_trial12MaxDuration = null
    // keep track of which components have finished
    prep_trial12Components = [];
    
    for (const thisComponent of prep_trial12Components)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function prep_trial12RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'prep_trial12' ---
    // get current time
    t = prep_trial12Clock.getTime();
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
    for (const thisComponent of prep_trial12Components)
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


function prep_trial12RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'prep_trial12' ---
    for (const thisComponent of prep_trial12Components) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "prep_trial12" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var slider_verticalMaxDurationReached;
var slider_verticalMaxDuration;
var slider_verticalComponents;
function slider_verticalRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'slider_vertical' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    slider_verticalClock.reset();
    routineTimer.reset();
    slider_verticalMaxDurationReached = false;
    // update component parameters for each repeat
    // to compute some reaction time later on
    myStart = globalClock.getTime();
    psychoJS.experiment.addData("sliderStarted", myStart);
    
    textbox_reminderV.setText(reminder_text);
    imageV.setImage(img_file);
    textbox_sliderV.setText(sliderV_text);
    slider_V.reset()
    textbox_submitbuttonV.setText(submitbutton_text);
    // setup some python lists for storing info about the mouseV
    // current position of the mouse:
    mouseV.x = [];
    mouseV.y = [];
    mouseV.leftButton = [];
    mouseV.midButton = [];
    mouseV.rightButton = [];
    mouseV.time = [];
    mouseV.clicked_name = [];
    gotValidClick = false; // until a click is received
    textbox_l01.setText(labels_liking[0]);
    textbox_l02.setText(labels_liking[1]);
    textbox_l03.setText(labels_liking[2]);
    textbox_l04.setText(labels_liking[3]);
    textbox_l05.setText(labels_liking[4]);
    textbox_l06.setText(labels_liking[5]);
    textbox_l07.setText(labels_liking[6]);
    textbox_l08.setText(labels_liking[7]);
    textbox_l09.setText(labels_liking[8]);
    textbox_l10.setText(labels_liking[9]);
    textbox_l11.setText(labels_liking[10]);
    psychoJS.experiment.addData('slider_vertical.started', globalClock.getTime());
    slider_verticalMaxDuration = null
    // keep track of which components have finished
    slider_verticalComponents = [];
    slider_verticalComponents.push(textbox_reminderV);
    slider_verticalComponents.push(imageV);
    slider_verticalComponents.push(textbox_sliderV);
    slider_verticalComponents.push(slider_V);
    slider_verticalComponents.push(polygon_submitbuttonV);
    slider_verticalComponents.push(textbox_submitbuttonV);
    slider_verticalComponents.push(mouseV);
    slider_verticalComponents.push(textbox_l01);
    slider_verticalComponents.push(textbox_l02);
    slider_verticalComponents.push(textbox_l03);
    slider_verticalComponents.push(textbox_l04);
    slider_verticalComponents.push(textbox_l05);
    slider_verticalComponents.push(textbox_l06);
    slider_verticalComponents.push(textbox_l07);
    slider_verticalComponents.push(textbox_l08);
    slider_verticalComponents.push(textbox_l09);
    slider_verticalComponents.push(textbox_l10);
    slider_verticalComponents.push(textbox_l11);
    
    for (const thisComponent of slider_verticalComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


var ratingDone;
var buttonPressed;
var condReactionReminderText;
var _mouseXYs;
function slider_verticalRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'slider_vertical' ---
    // get current time
    t = slider_verticalClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Hovereffect for submitbutton
    if ((! mobile_device)) {
        if (polygon_submitbuttonV.contains(mouseV)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    
    // Run 'Each Frame' code from code_ratingDetectionV
    ratingDone = slider_V.getRating();
    if ((ratingDone !== undefined)) {
        ratingGiven = true;
    }
    if ((ratingGiven && textbox_submitbuttonV.contains(mouseV))) {
        buttonPressed = mouseV.getPressed()[0];
        if ((buttonPressed === 1)) {
            continueRoutine = false;
        }
    }
    
    // Run 'Each Frame' code from code_reminderV
    condReactionReminderText = ((! ratingGiven) && (t >= 10.0));
    
    
    // *textbox_reminderV* updates
    if ((condReactionReminderText) && textbox_reminderV.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_reminderV.tStart = t;  // (not accounting for frame time here)
      textbox_reminderV.frameNStart = frameN;  // exact frame index
      
      textbox_reminderV.setAutoDraw(true);
    }
    
    
    // *imageV* updates
    if (t >= 0.0 && imageV.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      imageV.tStart = t;  // (not accounting for frame time here)
      imageV.frameNStart = frameN;  // exact frame index
      
      imageV.setAutoDraw(true);
    }
    
    
    // *textbox_sliderV* updates
    if (t >= 0.0 && textbox_sliderV.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_sliderV.tStart = t;  // (not accounting for frame time here)
      textbox_sliderV.frameNStart = frameN;  // exact frame index
      
      textbox_sliderV.setAutoDraw(true);
    }
    
    
    // *slider_V* updates
    if (t >= 0.0 && slider_V.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      slider_V.tStart = t;  // (not accounting for frame time here)
      slider_V.frameNStart = frameN;  // exact frame index
      
      slider_V.setAutoDraw(true);
    }
    
    
    if (polygon_submitbuttonV.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_submitbuttonV.setOpacity(submitbutton_opacity, false);
    }
    
    // *polygon_submitbuttonV* updates
    if ((ratingGiven) && polygon_submitbuttonV.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbuttonV.tStart = t;  // (not accounting for frame time here)
      polygon_submitbuttonV.frameNStart = frameN;  // exact frame index
      
      polygon_submitbuttonV.setAutoDraw(true);
    }
    
    
    // *textbox_submitbuttonV* updates
    if ((ratingGiven) && textbox_submitbuttonV.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbuttonV.tStart = t;  // (not accounting for frame time here)
      textbox_submitbuttonV.frameNStart = frameN;  // exact frame index
      
      textbox_submitbuttonV.setAutoDraw(true);
    }
    
    // *mouseV* updates
    if (t >= 0.0 && mouseV.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouseV.tStart = t;  // (not accounting for frame time here)
      mouseV.frameNStart = frameN;  // exact frame index
      
      mouseV.status = PsychoJS.Status.STARTED;
      mouseV.mouseClock.reset();
      prevButtonState = mouseV.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouseV.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouseV.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          mouseV.clickableObjects = eval(textbox_submitbuttonV)
          ;// make sure the mouse's clickable objects are an array
          if (!Array.isArray(mouseV.clickableObjects)) {
              mouseV.clickableObjects = [mouseV.clickableObjects];
          }
          // iterate through clickable objects and check each
          for (const obj of mouseV.clickableObjects) {
              if (obj.contains(mouseV)) {
                  gotValidClick = true;
                  mouseV.clicked_name.push(obj.name);
              }
          }
          if (!gotValidClick) {
              mouseV.clicked_name.push(null);
          }
          _mouseXYs = mouseV.getPos();
          mouseV.x.push(_mouseXYs[0]);
          mouseV.y.push(_mouseXYs[1]);
          mouseV.leftButton.push(_mouseButtons[0]);
          mouseV.midButton.push(_mouseButtons[1]);
          mouseV.rightButton.push(_mouseButtons[2]);
          mouseV.time.push(mouseV.mouseClock.getTime());
        }
      }
    }
    
    // *textbox_l01* updates
    if (t >= 0.0 && textbox_l01.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l01.tStart = t;  // (not accounting for frame time here)
      textbox_l01.frameNStart = frameN;  // exact frame index
      
      textbox_l01.setAutoDraw(true);
    }
    
    
    // *textbox_l02* updates
    if (t >= 0.0 && textbox_l02.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l02.tStart = t;  // (not accounting for frame time here)
      textbox_l02.frameNStart = frameN;  // exact frame index
      
      textbox_l02.setAutoDraw(true);
    }
    
    
    // *textbox_l03* updates
    if (t >= 0.0 && textbox_l03.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l03.tStart = t;  // (not accounting for frame time here)
      textbox_l03.frameNStart = frameN;  // exact frame index
      
      textbox_l03.setAutoDraw(true);
    }
    
    
    // *textbox_l04* updates
    if (t >= 0.0 && textbox_l04.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l04.tStart = t;  // (not accounting for frame time here)
      textbox_l04.frameNStart = frameN;  // exact frame index
      
      textbox_l04.setAutoDraw(true);
    }
    
    
    // *textbox_l05* updates
    if (t >= 0.0 && textbox_l05.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l05.tStart = t;  // (not accounting for frame time here)
      textbox_l05.frameNStart = frameN;  // exact frame index
      
      textbox_l05.setAutoDraw(true);
    }
    
    
    // *textbox_l06* updates
    if (t >= 0.0 && textbox_l06.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l06.tStart = t;  // (not accounting for frame time here)
      textbox_l06.frameNStart = frameN;  // exact frame index
      
      textbox_l06.setAutoDraw(true);
    }
    
    
    // *textbox_l07* updates
    if (t >= 0.0 && textbox_l07.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l07.tStart = t;  // (not accounting for frame time here)
      textbox_l07.frameNStart = frameN;  // exact frame index
      
      textbox_l07.setAutoDraw(true);
    }
    
    
    // *textbox_l08* updates
    if (t >= 0.0 && textbox_l08.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l08.tStart = t;  // (not accounting for frame time here)
      textbox_l08.frameNStart = frameN;  // exact frame index
      
      textbox_l08.setAutoDraw(true);
    }
    
    
    // *textbox_l09* updates
    if (t >= 0.0 && textbox_l09.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l09.tStart = t;  // (not accounting for frame time here)
      textbox_l09.frameNStart = frameN;  // exact frame index
      
      textbox_l09.setAutoDraw(true);
    }
    
    
    // *textbox_l10* updates
    if (t >= 0.0 && textbox_l10.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l10.tStart = t;  // (not accounting for frame time here)
      textbox_l10.frameNStart = frameN;  // exact frame index
      
      textbox_l10.setAutoDraw(true);
    }
    
    
    // *textbox_l11* updates
    if (t >= 0.0 && textbox_l11.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l11.tStart = t;  // (not accounting for frame time here)
      textbox_l11.frameNStart = frameN;  // exact frame index
      
      textbox_l11.setAutoDraw(true);
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
    for (const thisComponent of slider_verticalComponents)
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


var rating;
function slider_verticalRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'slider_vertical' ---
    for (const thisComponent of slider_verticalComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    psychoJS.experiment.addData('slider_vertical.stopped', globalClock.getTime());
    cond = image_conditions[ili][condi]; // get the current condition
    rating = slider_V.getRating(); // get the rating for this condition
    
    // the liking condition is currently the only which uses the vertical slider,
    // but as the selector code is elsewhere, we check it here.
    if (cond === "liking") {
        // range of the slider is [0, 100] and rating shall be in [-100, 100]
        rating = (rating - 50) * 2;
        }
    
    
    // replace the condition with a condition-rating tuppel
    image_conditions[ili][condi] = [cond, rating];
    
    // save data for both sliders under common var-names
    psychoJS.experiment.addData("sliderStopped", globalClock.getTime());
    psychoJS.experiment.addData("sliderRating", rating);
    psychoJS.experiment.addData("ratingRT", slider_V.getRT());
    
    // save the time of confirmation relative to routine-start
    myEnd = globalClock.getTime();
    myDur = (myEnd - myStart);
    psychoJS.experiment.addData("confirmRT", myDur);
    psychoJS.experiment.addData("confirm", 1);
    
    // Run 'End Routine' code from code_ratingDetectionV
    ratingGiven = false;
    
    psychoJS.experiment.addData('slider_V.response', slider_V.getRating());
    psychoJS.experiment.addData('slider_V.rt', slider_V.getRT());
    // store data for psychoJS.experiment (ExperimentHandler)
    psychoJS.experiment.addData('mouseV.x', mouseV.x);
    psychoJS.experiment.addData('mouseV.y', mouseV.y);
    psychoJS.experiment.addData('mouseV.leftButton', mouseV.leftButton);
    psychoJS.experiment.addData('mouseV.midButton', mouseV.midButton);
    psychoJS.experiment.addData('mouseV.rightButton', mouseV.rightButton);
    psychoJS.experiment.addData('mouseV.time', mouseV.time);
    psychoJS.experiment.addData('mouseV.clicked_name', mouseV.clicked_name);
    
    // the Routine "slider_vertical" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var slider_horizontalMaxDurationReached;
var slider_horizontalMaxDuration;
var slider_horizontalComponents;
function slider_horizontalRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'slider_horizontal' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    slider_horizontalClock.reset();
    routineTimer.reset();
    slider_horizontalMaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_sliderHorizontal
    myStart = globalClock.getTime();
    psychoJS.experiment.addData("sliderStarted", myStart);
    
    textbox_reminderH.setText(reminder_text);
    imageH.setImage(img_file);
    textbox_sliderH.setText(sliderH_text);
    slider_H.reset()
    slider_H.setColor(slider_labelcolor, colorSpace='rgb')
    textbox_sliderH_leftAnchor.setText(sliderH_leftAnchor_text);
    textbox_sliderH_rightAnchor.setText(sliderH_rightAnchor_text);
    textbox_submitbuttonH.setText(submitbutton_text);
    // setup some python lists for storing info about the mouseH
    // current position of the mouse:
    mouseH.x = [];
    mouseH.y = [];
    mouseH.leftButton = [];
    mouseH.midButton = [];
    mouseH.rightButton = [];
    mouseH.time = [];
    mouseH.clicked_name = [];
    gotValidClick = false; // until a click is received
    psychoJS.experiment.addData('slider_horizontal.started', globalClock.getTime());
    slider_horizontalMaxDuration = null
    // keep track of which components have finished
    slider_horizontalComponents = [];
    slider_horizontalComponents.push(textbox_reminderH);
    slider_horizontalComponents.push(imageH);
    slider_horizontalComponents.push(textbox_sliderH);
    slider_horizontalComponents.push(slider_H);
    slider_horizontalComponents.push(textbox_sliderH_leftAnchor);
    slider_horizontalComponents.push(textbox_sliderH_rightAnchor);
    slider_horizontalComponents.push(polygon_submitbuttonH);
    slider_horizontalComponents.push(textbox_submitbuttonH);
    slider_horizontalComponents.push(mouseH);
    
    for (const thisComponent of slider_horizontalComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function slider_horizontalRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'slider_horizontal' ---
    // get current time
    t = slider_horizontalClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Run 'Each Frame' code from code_sliderHorizontal
    if ((! mobile_device)) {
        if (textbox_submitbuttonH.contains(mouseH)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    window_height = psychoJS.window.size[1];
    window_width = psychoJS.window.size[0];
    xrange = (window_width / window_height);
    sliderH_w = (sliderH_wanting_w * Math.max(1, xrange));
    sliderH_h = 0.045;
    sliderH_label1_pos[0] = (sliderH_center_x - ((sliderH_wanting_w / 2) * Math.max(1, xrange)));
    sliderH_label1_pos[1] = ((sliderH_center_y - (sliderH_h * Math.min(1, xrange))) - 0.01);
    sliderH_label2_pos[0] = (sliderH_center_x + ((sliderH_wanting_w / 2) * Math.max(1, xrange)));
    sliderH_label2_pos[1] = ((sliderH_center_y - (sliderH_h * Math.min(1, xrange))) - 0.01);
    sliderH_label1_pos[0] = (sliderH_label1_pos[0] * 0.9);
    sliderH_label2_pos[0] = (sliderH_label2_pos[0] * 0.9);
    
    // Run 'Each Frame' code from code_ratingDetectionH
    ratingDone = slider_H.getRating();
    if ((ratingDone !== undefined)) {
        ratingGiven = true;
    }
    if ((ratingGiven && textbox_submitbuttonH.contains(mouseH))) {
        buttonPressed = mouseH.getPressed()[0];
        if ((buttonPressed === 1)) {
            continueRoutine = false;
        }
    }
    
    // Run 'Each Frame' code from code_reminderH
    condReactionReminderText = ((! ratingGiven) && (t >= 10.0));
    
    
    // *textbox_reminderH* updates
    if ((condReactionReminderText) && textbox_reminderH.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_reminderH.tStart = t;  // (not accounting for frame time here)
      textbox_reminderH.frameNStart = frameN;  // exact frame index
      
      textbox_reminderH.setAutoDraw(true);
    }
    
    
    // *imageH* updates
    if (t >= 0.0 && imageH.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      imageH.tStart = t;  // (not accounting for frame time here)
      imageH.frameNStart = frameN;  // exact frame index
      
      imageH.setAutoDraw(true);
    }
    
    
    // *textbox_sliderH* updates
    if (t >= 0.0 && textbox_sliderH.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_sliderH.tStart = t;  // (not accounting for frame time here)
      textbox_sliderH.frameNStart = frameN;  // exact frame index
      
      textbox_sliderH.setAutoDraw(true);
    }
    
    
    if (slider_H.status === PsychoJS.Status.STARTED){ // only update if being drawn
      slider_H.setSize([sliderH_w, sliderH_h], false);
    }
    
    // *slider_H* updates
    if (t >= 0.0 && slider_H.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      slider_H.tStart = t;  // (not accounting for frame time here)
      slider_H.frameNStart = frameN;  // exact frame index
      
      slider_H.setAutoDraw(true);
    }
    
    
    if (textbox_sliderH_leftAnchor.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_sliderH_leftAnchor.setPos(sliderH_label1_pos, false);
    }
    
    // *textbox_sliderH_leftAnchor* updates
    if (t >= 0.0 && textbox_sliderH_leftAnchor.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_sliderH_leftAnchor.tStart = t;  // (not accounting for frame time here)
      textbox_sliderH_leftAnchor.frameNStart = frameN;  // exact frame index
      
      textbox_sliderH_leftAnchor.setAutoDraw(true);
    }
    
    
    if (textbox_sliderH_rightAnchor.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_sliderH_rightAnchor.setPos(sliderH_label2_pos, false);
    }
    
    // *textbox_sliderH_rightAnchor* updates
    if (t >= 0.0 && textbox_sliderH_rightAnchor.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_sliderH_rightAnchor.tStart = t;  // (not accounting for frame time here)
      textbox_sliderH_rightAnchor.frameNStart = frameN;  // exact frame index
      
      textbox_sliderH_rightAnchor.setAutoDraw(true);
    }
    
    
    if (polygon_submitbuttonH.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_submitbuttonH.setOpacity(submitbutton_opacity, false);
    }
    
    // *polygon_submitbuttonH* updates
    if ((ratingGiven) && polygon_submitbuttonH.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbuttonH.tStart = t;  // (not accounting for frame time here)
      polygon_submitbuttonH.frameNStart = frameN;  // exact frame index
      
      polygon_submitbuttonH.setAutoDraw(true);
    }
    
    
    // *textbox_submitbuttonH* updates
    if ((ratingGiven) && textbox_submitbuttonH.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbuttonH.tStart = t;  // (not accounting for frame time here)
      textbox_submitbuttonH.frameNStart = frameN;  // exact frame index
      
      textbox_submitbuttonH.setAutoDraw(true);
    }
    
    // *mouseH* updates
    if (t >= 0.0 && mouseH.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouseH.tStart = t;  // (not accounting for frame time here)
      mouseH.frameNStart = frameN;  // exact frame index
      
      mouseH.status = PsychoJS.Status.STARTED;
      mouseH.mouseClock.reset();
      prevButtonState = mouseH.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouseH.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouseH.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          mouseH.clickableObjects = eval(textbox_submitbuttonH)
          ;// make sure the mouse's clickable objects are an array
          if (!Array.isArray(mouseH.clickableObjects)) {
              mouseH.clickableObjects = [mouseH.clickableObjects];
          }
          // iterate through clickable objects and check each
          for (const obj of mouseH.clickableObjects) {
              if (obj.contains(mouseH)) {
                  gotValidClick = true;
                  mouseH.clicked_name.push(obj.name);
              }
          }
          if (!gotValidClick) {
              mouseH.clicked_name.push(null);
          }
          _mouseXYs = mouseH.getPos();
          mouseH.x.push(_mouseXYs[0]);
          mouseH.y.push(_mouseXYs[1]);
          mouseH.leftButton.push(_mouseButtons[0]);
          mouseH.midButton.push(_mouseButtons[1]);
          mouseH.rightButton.push(_mouseButtons[2]);
          mouseH.time.push(mouseH.mouseClock.getTime());
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
    for (const thisComponent of slider_horizontalComponents)
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


function slider_horizontalRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'slider_horizontal' ---
    for (const thisComponent of slider_horizontalComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    psychoJS.experiment.addData('slider_horizontal.stopped', globalClock.getTime());
    // Run 'End Routine' code from code_sliderHorizontal
    cond = image_conditions[ili][condi];
    rating = slider_H.getRating();
    image_conditions[ili][condi] = [cond, rating];
    psychoJS.experiment.addData("sliderStopped", globalClock.getTime());
    psychoJS.experiment.addData("sliderRating", rating);
    psychoJS.experiment.addData("ratingRT", slider_H.getRT());
    myEnd = globalClock.getTime();
    myDur = (myEnd - myStart);
    psychoJS.experiment.addData("confirmRT", myDur);
    psychoJS.experiment.addData("confirm", 1);
    
    // Run 'End Routine' code from code_ratingDetectionH
    ratingGiven = false;
    
    psychoJS.experiment.addData('slider_H.response', slider_H.getRating());
    psychoJS.experiment.addData('slider_H.rt', slider_H.getRT());
    // store data for psychoJS.experiment (ExperimentHandler)
    psychoJS.experiment.addData('mouseH.x', mouseH.x);
    psychoJS.experiment.addData('mouseH.y', mouseH.y);
    psychoJS.experiment.addData('mouseH.leftButton', mouseH.leftButton);
    psychoJS.experiment.addData('mouseH.midButton', mouseH.midButton);
    psychoJS.experiment.addData('mouseH.rightButton', mouseH.rightButton);
    psychoJS.experiment.addData('mouseH.time', mouseH.time);
    psychoJS.experiment.addData('mouseH.clicked_name', mouseH.clicked_name);
    
    // the Routine "slider_horizontal" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var reRandomizeMaxDurationReached;
var reRandomizeMaxDuration;
var reRandomizeComponents;
function reRandomizeRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'reRandomize' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    reRandomizeClock.reset();
    routineTimer.reset();
    reRandomizeMaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_reRandomize
    image_conditions = shuffle_array(image_conditions);
    
    reRandomizeMaxDuration = null
    // keep track of which components have finished
    reRandomizeComponents = [];
    
    for (const thisComponent of reRandomizeComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function reRandomizeRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'reRandomize' ---
    // get current time
    t = reRandomizeClock.getTime();
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
    for (const thisComponent of reRandomizeComponents)
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


function reRandomizeRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'reRandomize' ---
    for (const thisComponent of reRandomizeComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "reRandomize" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var prep_trial34MaxDurationReached;
var prep_trial34MaxDuration;
var prep_trial34Components;
function prep_trial34RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'prep_trial34' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    prep_trial34Clock.reset();
    routineTimer.reset();
    prep_trial34MaxDurationReached = false;
    // update component parameters for each repeat
    // The "conditions34_loop" iterates twice in order to
    // present 2 conditions for the current image.
    // The "vertical_option" & "horizontal_option" loops
    // only iterate if the respective condition is up.
    
    globalTrialCounter = (globalTrialCounter + 1);
    psychoJS.experiment.addData("globalTrialCounter", globalTrialCounter);
    psychoJS.experiment.addData("blockNum", 2);
    
    // get current indize
    ili = images_block2_loop.thisN; // current image loop index
    cli = conditions34_loop.thisN; // current condition loop index
    
    // extract infos for current image
    img_index = image_conditions[ili][0];
    img_file = ((img_path + img_index.toString()) + ".jpg");
    
    // this options declare which slider/condition is used
    liking_option = 0;
    wanting_option = 0;
    sustain_option = 0;
    health_option = 0;
    vertical_option = 0;
    horizontal_option = 1; // standard for all but liking condition
    
    
    condi = ((cli + 1) + 2); // real index of current condition in image_conditions structure
    psychoJS.experiment.addData("imageRepitition", condi); // counter for image repititions
    cond = image_conditions[ili][condi]; // get the current condition
    
    // make settings depending on the current condition
    if ((cond === "liking")) {
        liking_option = 1;
        vertical_option = 1;
        horizontal_option = 0;
        sliderV_text = text_liking;
        slider_labelcolor = likingColor;
        psychoJS.experiment.addData("conditionNr", 1);
    } else {
        if ((cond === "wanting")) {
            wanting_option = 1;
            sliderH_text = text_wanting;
            sliderH_leftAnchor_text = labels_wanting[0];
            sliderH_rightAnchor_text = labels_wanting[1];
            slider_labelcolor = wantingColor;
            psychoJS.experiment.addData("conditionNr", 2);
        } else {
            if ((cond === "sustainability")) {
                sustain_option = 1;
                sliderH_text = text_sustainability;
                sliderH_leftAnchor_text = labels_sustainability[0];
                sliderH_rightAnchor_text = labels_sustainability[1];
                slider_labelcolor = sustainColor;
                psychoJS.experiment.addData("conditionNr", 3);
            } else {
                if ((cond === "healthiness")) {
                    health_option = 1;
                    sliderH_text = text_healthiness;
                    sliderH_leftAnchor_text = labels_healthiness[0];
                    sliderH_rightAnchor_text = labels_healthiness[1];
                    slider_labelcolor = healthColor;
                    psychoJS.experiment.addData("conditionNr", 4);
                }
            }
        }
    }
    
    psychoJS.experiment.addData("condition", cond);
    psychoJS.experiment.addData("image", img_index);
    psychoJS.experiment.addData("sliderType", horizontal_option); // 1 for horizontal slider
    
    prep_trial34MaxDuration = null
    // keep track of which components have finished
    prep_trial34Components = [];
    
    for (const thisComponent of prep_trial34Components)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function prep_trial34RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'prep_trial34' ---
    // get current time
    t = prep_trial34Clock.getTime();
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
    for (const thisComponent of prep_trial34Components)
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


function prep_trial34RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'prep_trial34' ---
    for (const thisComponent of prep_trial34Components) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "prep_trial34" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var instructions_3MaxDurationReached;
var instructions3_text;
var instructions_3MaxDuration;
var instructions_3Components;
function instructions_3RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'instructions_3' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    instructions_3Clock.reset();
    routineTimer.reset();
    instructions_3MaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_instructions_3
    window_height = psychoJS.window.size[1];
    window_width = psychoJS.window.size[0];
    xrange = (window_width / window_height);
    yrange = (window_height / window_width);
    last_xrange = xrange;
    button_instructions_xy = [0, ((- 0.3) * Math.max(1, yrange))];
    button_instructions_size = [(0.5 * Math.max(1, Math.sqrt(Math.sqrt(xrange)))), (0.1 * Math.max(1, yrange))];
    instructions_size = [(0.6 * Math.max(1, Math.sqrt(xrange))), (0.6 * Math.max(1, Math.sqrt(yrange)))];
    if ((languagechoice === "ger")) {
        instructions3_text = instr3_ger;
    } else {
        instructions3_text = instr3_eng;
    }
    
    // make up for wrong line-breaks when reading file with javascript
    instructions3_text = instructions3_text.split('\\n').join('\n');
    textbox_instructions_3.setText(instructions3_text);
    // setup some python lists for storing info about the mouse_instructions_3
    mouse_instructions_3.clicked_name = [];
    gotValidClick = false; // until a click is received
    textbox_submitbutton_3.setText(submitbutton_text);
    psychoJS.experiment.addData('instructions_3.started', globalClock.getTime());
    instructions_3MaxDuration = null
    // keep track of which components have finished
    instructions_3Components = [];
    instructions_3Components.push(textbox_instructions_3);
    instructions_3Components.push(mouse_instructions_3);
    instructions_3Components.push(polygon_submitbutton_3);
    instructions_3Components.push(textbox_submitbutton_3);
    
    for (const thisComponent of instructions_3Components)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function instructions_3RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'instructions_3' ---
    // get current time
    t = instructions_3Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Run 'Each Frame' code from code_instructions_3
    if ((! mobile_device)) {
        if (polygon_submitbutton.contains(mouse_instructions)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    window_height = psychoJS.window.size[1];
    window_width = psychoJS.window.size[0];
    xrange = (window_width / window_height);
    if ((xrange !== last_xrange)) {
        last_xrange = xrange;
        yrange = (window_height / window_width);
        button_instructions_xy = [0, ((- 0.3) * Math.max(1, yrange))];
        button_instructions_size = [(0.5 * Math.max(1, Math.sqrt(Math.sqrt(xrange)))), (0.1 * Math.max(1, yrange))];
        instructions_size = [(0.6 * Math.max(1, Math.sqrt(xrange))), (0.6 * Math.max(1, Math.sqrt(yrange)))];
    }
    
    
    if (textbox_instructions_3.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_instructions_3.setSize(instructions_size, false);
    }
    
    // *textbox_instructions_3* updates
    if (t >= 0.0 && textbox_instructions_3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_instructions_3.tStart = t;  // (not accounting for frame time here)
      textbox_instructions_3.frameNStart = frameN;  // exact frame index
      
      textbox_instructions_3.setAutoDraw(true);
    }
    
    // *mouse_instructions_3* updates
    if (t >= 0.5 && mouse_instructions_3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_instructions_3.tStart = t;  // (not accounting for frame time here)
      mouse_instructions_3.frameNStart = frameN;  // exact frame index
      
      mouse_instructions_3.status = PsychoJS.Status.STARTED;
      mouse_instructions_3.mouseClock.reset();
      prevButtonState = mouse_instructions_3.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_instructions_3.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_instructions_3.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          mouse_instructions_3.clickableObjects = eval([polygon_submitbutton_3])
          ;// make sure the mouse's clickable objects are an array
          if (!Array.isArray(mouse_instructions_3.clickableObjects)) {
              mouse_instructions_3.clickableObjects = [mouse_instructions_3.clickableObjects];
          }
          // iterate through clickable objects and check each
          for (const obj of mouse_instructions_3.clickableObjects) {
              if (obj.contains(mouse_instructions_3)) {
                  gotValidClick = true;
                  mouse_instructions_3.clicked_name.push(obj.name);
              }
          }
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          mouse_instructions_3.clickableObjects = eval([polygon_submitbutton_3])
          ;// make sure the mouse's clickable objects are an array
          if (!Array.isArray(mouse_instructions_3.clickableObjects)) {
              mouse_instructions_3.clickableObjects = [mouse_instructions_3.clickableObjects];
          }
          // iterate through clickable objects and check each
          for (const obj of mouse_instructions_3.clickableObjects) {
              if (obj.contains(mouse_instructions_3)) {
                  gotValidClick = true;
                  mouse_instructions_3.clicked_name.push(obj.name);
              }
          }
          if (gotValidClick === true) { // end routine on response
            continueRoutine = false;
          }
        }
      }
    }
    
    if (polygon_submitbutton_3.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_submitbutton_3.setOpacity(submitbutton_opacity, false);
      polygon_submitbutton_3.setPos(button_instructions_xy, false);
      polygon_submitbutton_3.setSize(button_instructions_size, false);
    }
    
    // *polygon_submitbutton_3* updates
    if (t >= 0.0 && polygon_submitbutton_3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbutton_3.tStart = t;  // (not accounting for frame time here)
      polygon_submitbutton_3.frameNStart = frameN;  // exact frame index
      
      polygon_submitbutton_3.setAutoDraw(true);
    }
    
    
    if (textbox_submitbutton_3.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_submitbutton_3.setPos(button_instructions_xy, false);
      textbox_submitbutton_3.setSize(button_instructions_size, false);
    }
    
    // *textbox_submitbutton_3* updates
    if (t >= 0.0 && textbox_submitbutton_3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbutton_3.tStart = t;  // (not accounting for frame time here)
      textbox_submitbutton_3.frameNStart = frameN;  // exact frame index
      
      textbox_submitbutton_3.setAutoDraw(true);
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
    for (const thisComponent of instructions_3Components)
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


function instructions_3RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'instructions_3' ---
    for (const thisComponent of instructions_3Components) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    psychoJS.experiment.addData('instructions_3.stopped', globalClock.getTime());
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "instructions_3" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var ratingMaxDurationReached;
var ratingTargets;
var rTargetOccupation;
var ratingResults;
var ratingRTs;
var ratingTexts;
var isDragging;
var focus;
var focusI;
var inTarget;
var ratingTextsOldPos;
var ratingMaxDuration;
var ratingComponents;
function ratingRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'rating' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    ratingClock.reset();
    routineTimer.reset();
    ratingMaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_rating
    ratingTargets = [polygon_target1, polygon_target2, polygon_target3, polygon_target4];
    rTargetOccupation = [0, 0, 0, 0];
    ratingGiven = false;
    ratingResults = ["", "", "", ""];
    ratingRTs = [(- 1), (- 1), (- 1), (- 1)];
    myStart = globalClock.getTime();
    ratingCond[0] = [categoryWanting, wantingColor];
    ratingCond[1] = [categoryHealthiness, healthColor];
    ratingCond[2] = [categorySustainability, sustainColor];
    ratingCond[3] = [categoryLiking, likingColor];
    ratingCond = shuffle_array(ratingCond);
    ratingTexts = [textbox_cond1, textbox_cond2, textbox_cond3, textbox_cond4];
    isDragging = false;
    focus = null;
    focusI = null;
    inTarget = false;
    ratingTextsOldPos = [textbox_cond1.pos, textbox_cond2.pos, textbox_cond3.pos, textbox_cond4.pos];
    submitbutton_xy = [0, (- 0.1)];
    submitbutton_opacity = 1;
    
    polygon_target1.setPos([ratingX, ratingY[0]]);
    polygon_target2.setPos([ratingX, ratingY[1]]);
    polygon_target4.setPos([ratingX, ratingY[3]]);
    textbox_cond1.setFillColor(new util.Color(ratingCond[0][1]));
    textbox_cond1.setText(ratingCond[0][0]);
    textbox_cond2.setFillColor(new util.Color(ratingCond[1][1]));
    textbox_cond2.setText(ratingCond[1][0]);
    textbox_cond3.setFillColor(new util.Color(ratingCond[2][1]));
    textbox_cond3.setText(ratingCond[2][0]);
    textbox_cond4.setFillColor(new util.Color(ratingCond[3][1]));
    textbox_cond4.setText(ratingCond[3][0]);
    // setup some python lists for storing info about the mouseR
    gotValidClick = false; // until a click is received
    textbox_submitbuttonR.setPos(submitbutton_xy);
    textbox_submitbuttonR.setText(submitbutton_text);
    psychoJS.experiment.addData('rating.started', globalClock.getTime());
    ratingMaxDuration = null
    // keep track of which components have finished
    ratingComponents = [];
    ratingComponents.push(polygon_target1);
    ratingComponents.push(polygon_target2);
    ratingComponents.push(polygon_target3);
    ratingComponents.push(polygon_target4);
    ratingComponents.push(textbox_cond1);
    ratingComponents.push(textbox_cond2);
    ratingComponents.push(textbox_cond3);
    ratingComponents.push(textbox_cond4);
    ratingComponents.push(mouseR);
    ratingComponents.push(textbox_submitbuttonR);
    ratingComponents.push(textbox_target1);
    ratingComponents.push(textbox_target2);
    ratingComponents.push(textbox_target3);
    ratingComponents.push(textbox_target4);
    
    for (const thisComponent of ratingComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function ratingRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'rating' ---
    // get current time
    t = ratingClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Run 'Each Frame' code from code_rating
    if ((! isDragging)) {
        i = 0;
        while ((i < ratingTexts.length)) {
            if (mouseR.isPressedIn(ratingTexts[i])) {
                focus = ratingTexts[i];
                focusI = i;
                focus.pos = mouseR.getPos();
                isDragging = true;
                j = 0;
                while ((j < ratingTargets.length)) {
                    if (ratingTargets[j].contains(mouseR)) {
                        rTargetOccupation[j] = 0;
                    }
                    j += 1;
                }
            }
            i += 1;
        }
    } else {
        focus.pos = mouseR.getPos();
        if ((! mouseR.isPressedIn(focus))) {
            isDragging = false;
            inTarget = false;
            i = 0;
            while ((i < ratingTargets.length)) {
                if (((rTargetOccupation[i] === 0) && ratingTargets[i].contains(mouseR))) {
                    focus.pos = ratingTargets[i].pos;
                    inTarget = true;
                    rTargetOccupation[i] = 1;
                    ratingResults[i] = ratingCond[focusI];
                    ratingRTs[i] = (globalClock.getTime() - myStart);
                }
                i += 1;
            }
            if ((! inTarget)) {
                focus.pos = ratingTextsOldPos[focusI];
                focusI = null;
                focus = null;
            }
        }
    }
    ratingGiven = true;
    submitbutton_opacity = 1;
    for (var rTarget, _pj_c = 0, _pj_a = rTargetOccupation, _pj_b = _pj_a.length; (_pj_c < _pj_b); _pj_c += 1) {
        rTarget = _pj_a[_pj_c];
        if ((rTarget === 0)) {
            ratingGiven = false;
            submitbutton_opacity = 0;
        }
    }
    if ((ratingGiven && textbox_submitbuttonR.contains(mouseR))) {
        buttonPressed = mouseR.getPressed()[0];
        if ((buttonPressed === 1)) {
            psychoJS.experiment.addData("ratingResult_1", ratingResults[0][0]);
            psychoJS.experiment.addData("ratingResult_2", ratingResults[1][0]);
            psychoJS.experiment.addData("ratingResult_3", ratingResults[2][0]);
            psychoJS.experiment.addData("ratingResult_4", ratingResults[3][0]);
            psychoJS.experiment.addData("ratingRT_1", ratingRTs[0]);
            psychoJS.experiment.addData("ratingRT_2", ratingRTs[1]);
            psychoJS.experiment.addData("ratingRT_3", ratingRTs[2]);
            psychoJS.experiment.addData("ratingRT_4", ratingRTs[3]);
            continueRoutine = false;
        }
    }
    
    
    // *polygon_target1* updates
    if (t >= 0.0 && polygon_target1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_target1.tStart = t;  // (not accounting for frame time here)
      polygon_target1.frameNStart = frameN;  // exact frame index
      
      polygon_target1.setAutoDraw(true);
    }
    
    
    // *polygon_target2* updates
    if (t >= 0.0 && polygon_target2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_target2.tStart = t;  // (not accounting for frame time here)
      polygon_target2.frameNStart = frameN;  // exact frame index
      
      polygon_target2.setAutoDraw(true);
    }
    
    
    // *polygon_target3* updates
    if (t >= 0.0 && polygon_target3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_target3.tStart = t;  // (not accounting for frame time here)
      polygon_target3.frameNStart = frameN;  // exact frame index
      
      polygon_target3.setAutoDraw(true);
    }
    
    
    // *polygon_target4* updates
    if (t >= 0.0 && polygon_target4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_target4.tStart = t;  // (not accounting for frame time here)
      polygon_target4.frameNStart = frameN;  // exact frame index
      
      polygon_target4.setAutoDraw(true);
    }
    
    
    // *textbox_cond1* updates
    if (t >= 0.0 && textbox_cond1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_cond1.tStart = t;  // (not accounting for frame time here)
      textbox_cond1.frameNStart = frameN;  // exact frame index
      
      textbox_cond1.setAutoDraw(true);
    }
    
    
    // *textbox_cond2* updates
    if (t >= 0.0 && textbox_cond2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_cond2.tStart = t;  // (not accounting for frame time here)
      textbox_cond2.frameNStart = frameN;  // exact frame index
      
      textbox_cond2.setAutoDraw(true);
    }
    
    
    // *textbox_cond3* updates
    if (t >= 0.0 && textbox_cond3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_cond3.tStart = t;  // (not accounting for frame time here)
      textbox_cond3.frameNStart = frameN;  // exact frame index
      
      textbox_cond3.setAutoDraw(true);
    }
    
    
    // *textbox_cond4* updates
    if (t >= 0.0 && textbox_cond4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_cond4.tStart = t;  // (not accounting for frame time here)
      textbox_cond4.frameNStart = frameN;  // exact frame index
      
      textbox_cond4.setAutoDraw(true);
    }
    
    
    if (textbox_submitbuttonR.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_submitbuttonR.setOpacity(submitbutton_opacity, false);
    }
    
    // *textbox_submitbuttonR* updates
    if ((ratingGiven) && textbox_submitbuttonR.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbuttonR.tStart = t;  // (not accounting for frame time here)
      textbox_submitbuttonR.frameNStart = frameN;  // exact frame index
      
      textbox_submitbuttonR.setAutoDraw(true);
    }
    
    
    // *textbox_target1* updates
    if (t >= 0.0 && textbox_target1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_target1.tStart = t;  // (not accounting for frame time here)
      textbox_target1.frameNStart = frameN;  // exact frame index
      
      textbox_target1.setAutoDraw(true);
    }
    
    
    // *textbox_target2* updates
    if (t >= 0.0 && textbox_target2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_target2.tStart = t;  // (not accounting for frame time here)
      textbox_target2.frameNStart = frameN;  // exact frame index
      
      textbox_target2.setAutoDraw(true);
    }
    
    
    // *textbox_target3* updates
    if (t >= 0.0 && textbox_target3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_target3.tStart = t;  // (not accounting for frame time here)
      textbox_target3.frameNStart = frameN;  // exact frame index
      
      textbox_target3.setAutoDraw(true);
    }
    
    
    // *textbox_target4* updates
    if (t >= 0.0 && textbox_target4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_target4.tStart = t;  // (not accounting for frame time here)
      textbox_target4.frameNStart = frameN;  // exact frame index
      
      textbox_target4.setAutoDraw(true);
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
    for (const thisComponent of ratingComponents)
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


function ratingRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'rating' ---
    for (const thisComponent of ratingComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    psychoJS.experiment.addData('rating.stopped', globalClock.getTime());
    // Run 'End Routine' code from code_rating
    ratingGiven = false;
    
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "rating" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var endMaxDurationReached;
var end_text;
var end_text2;
var endMaxDuration;
var endComponents;
function endRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'end' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    endClock.reset(routineTimer.getTime());
    routineTimer.add(2.000000);
    endMaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_end
    if ((languagechoice === "ger")) {
        end_text = "Das Experiment ist nun beendet.\nVielen Dank f\u00fcr Ihre Teilnahme.";
        end_text2 = "Bitte schliessen Sie das Experiment nicht bevor das Fenster mit der Nachricht 'Thank you for your patience.' erscheint. \nDies kann einen Moment dauern.";
    } else {
        end_text = "The experiment is over.\nThank you for your participation.";
        end_text2 = "Please do not close the experiment before the window with the message 'Thank you for your patience.' appears. \nThis may take a moment.";
    }
    
    textbox_end.setText(end_text);
    textbox_wait.setText(end_text2);
    // Write food ratings to shelf "food_ratings" 
    // Since the field is globally visible (Shelf->Scope->Designer) we have to specify that
    psychoJS.shelf.setDictionaryFieldValue({
        key: ["food_ratings", "@designer"], 
        fieldName: expInfo['participantID'], 
        fieldValue: image_conditions});
        // the combined array image_conditions holds the food ratings
    psychoJS.experiment.addData('end.started', globalClock.getTime());
    endMaxDuration = null
    // keep track of which components have finished
    endComponents = [];
    endComponents.push(textbox_end);
    endComponents.push(textbox_wait);
    
    for (const thisComponent of endComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function endRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'end' ---
    // get current time
    t = endClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *textbox_end* updates
    if (t >= 0.0 && textbox_end.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_end.tStart = t;  // (not accounting for frame time here)
      textbox_end.frameNStart = frameN;  // exact frame index
      
      textbox_end.setAutoDraw(true);
    }
    
    frameRemains = 0.0 + 2 - psychoJS.window.monitorFramePeriod * 0.75;// most of one frame period left
    if (textbox_end.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      textbox_end.setAutoDraw(false);
    }
    
    
    // *textbox_wait* updates
    if (t >= 0.0 && textbox_wait.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_wait.tStart = t;  // (not accounting for frame time here)
      textbox_wait.frameNStart = frameN;  // exact frame index
      
      textbox_wait.setAutoDraw(true);
    }
    
    frameRemains = 0.0 + 2 - psychoJS.window.monitorFramePeriod * 0.75;// most of one frame period left
    if (textbox_wait.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      textbox_wait.setAutoDraw(false);
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
    for (const thisComponent of endComponents)
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


function endRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'end' ---
    for (const thisComponent of endComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    psychoJS.experiment.addData('end.stopped', globalClock.getTime());
    if (endMaxDurationReached) {
        endClock.add(endMaxDuration);
    } else {
        endClock.add(2.000000);
    }
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
  psychoJS.window.close();
  psychoJS.quit({message: message, isCompleted: isCompleted});
  
  return Scheduler.Event.QUIT;
}
