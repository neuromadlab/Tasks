/******************************* 
 * Willingness2Pay_Legacy Test *
 *******************************/

import { core, data, sound, util, visual, hardware } from './lib/psychojs-2022.2.3.js';
const { PsychoJS } = core;
const { TrialHandler, MultiStairHandler } = data;
const { Scheduler } = util;
//some handy aliases as in the psychopy scripts;
const { abs, sin, cos, PI: pi, sqrt } = Math;
const { round } = util;


// store info about the experiment session:
let expName = 'willingness2pay_legacy';  // from the Builder filename that created this script
let expInfo = {
    'participantID': '',
    'studyID': 'BON001',
    'session number': '',
};

// Start code blocks for 'Before Experiment'
// Function takes number n and translates it to a string with "," 
// for german (lng_ch=languagechoice="ger) and "." for english presentation; 
// Rounded to .50
var getNiceValue = function (n, lng_ch) {
    let dot = ".";
    let stringRep = n.toString();
    let stringRep_new = "";
    let cutout = 0;
    let rest = "";
    let breaked = false;
    if (lng_ch === "ger"){
        dot = ",";
    }
    for (let i = 0; i < stringRep.length; i++) {
        if(stringRep[i] === "."){
            stringRep_new = stringRep_new + dot;
            rest = stringRep.slice((i+1)); // everything behind decimal point
            // two or more digits behind decimal point
            if(rest.length >= 2){
                cutout = Number(rest.slice(0,2));
                if(cutout > 25 && cutout < 75){
                    stringRep_new = stringRep_new + "50";
                } else {
                    stringRep_new = Math.round(n).toString() + dot + "00";
                }
            // one digit behind decimal point
            } else {
                cutout = Number(rest.slice(0,1));
                if(cutout > 2.5 && cutout < 7.5){
                    stringRep_new = stringRep_new + "50";
                } else {
                    stringRep_new = Math.round(n).toString() + dot + "00";
                }
            }
            breaked = true;
            break
        }
        stringRep_new = stringRep_new + stringRep[i];
    }
    // no digit after decimal point (no decimal point found)
    if(!breaked){
        stringRep_new = stringRep_new + dot + "00";
    }
    return stringRep_new;
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
flowScheduler.add(global_experiment_settingsRoutineBegin());
flowScheduler.add(global_experiment_settingsRoutineEachFrame());
flowScheduler.add(global_experiment_settingsRoutineEnd());
flowScheduler.add(jitter_settingsRoutineBegin());
flowScheduler.add(jitter_settingsRoutineEachFrame());
flowScheduler.add(jitter_settingsRoutineEnd());
flowScheduler.add(language_choiceRoutineBegin());
flowScheduler.add(language_choiceRoutineEachFrame());
flowScheduler.add(language_choiceRoutineEnd());
flowScheduler.add(trial_definerRoutineBegin());
flowScheduler.add(trial_definerRoutineEachFrame());
flowScheduler.add(trial_definerRoutineEnd());
flowScheduler.add(instructionsRoutineBegin());
flowScheduler.add(instructionsRoutineEachFrame());
flowScheduler.add(instructionsRoutineEnd());
const trialsLoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(trialsLoopBegin(trialsLoopScheduler));
flowScheduler.add(trialsLoopScheduler);
flowScheduler.add(trialsLoopEnd);
flowScheduler.add(endRoutineBegin());
flowScheduler.add(endRoutineEachFrame());
flowScheduler.add(endRoutineEnd());
flowScheduler.add(quitPsychoJS, '', true);

// quit if user presses Cancel in dialog box:
dialogCancelScheduler.add(quitPsychoJS, '', false);

psychoJS.start({
  expName: expName,
  expInfo: expInfo,
  resources: [
    {'name': 'stimuli/single-icon.png', 'path': 'stimuli/single-icon.png'},
    {'name': 'DelayJitter/DelayJitter.csv', 'path': 'DelayJitter/DelayJitter.csv'},
    {'name': 'buttons/germany_flag.png', 'path': 'buttons/germany_flag.png'},
    {'name': 'stimuli/friends-icon.png', 'path': 'stimuli/friends-icon.png'},
    {'name': 'buttons/tilt_phone.png', 'path': 'buttons/tilt_phone.png'},
    {'name': 'stimuli/activities.csv', 'path': 'stimuli/activities.csv'},
    {'name': 'buttons/uk_flag.png', 'path': 'buttons/uk_flag.png'}
  ]
});

psychoJS.experimentLogger.setLevel(core.Logger.ServerLevel.ERROR);


var currentLoop;
var frameDur;
async function updateInfo() {
  currentLoop = psychoJS.experiment;  // right now there are no loops
  expInfo['date'] = util.MonotonicClock.getDateStr();  // add a simple timestamp
  expInfo['expName'] = expName;
  expInfo['psychopyVersion'] = '2022.2.3';
  expInfo['OS'] = window.navigator.platform;

  psychoJS.experiment.dataFileName = (("." + "/") + `data/${expInfo["participantID"]}_${expName}_${expInfo["date"]}`);

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


var global_experiment_settingsClock;
var ActivityList;
var N;
var N_TRIALS;
var mobile_device;
var opacity1;
var opacity2;
var ISI;
var low_tick;
var up_tick;
var slider_center_x;
var slider_center_y;
var slider_xy;
var slider_ticks;
var l01_text;
var l02_text;
var continuebutton_edgethickness;
var continuebutton_fillcolor;
var continuebutton_bordercolor;
var submitbutton_size;
var submitbutton_edgethickness;
var submitbutton_fillcolor;
var submitbutton_bordercolor;
var img_source_alone;
var img_source_together;
var img_size_alone;
var img_size_together;
var image_ukflag_opacity;
var image_germanyflag_opacity;
var submitbutton_opacity;
var idx;
var jitter_settingsClock;
var jitterList;
var jitter;
var language_choiceClock;
var image_germanyflag;
var image_ukflag;
var textbox_languagechoice;
var mouse_languagechoice;
var textbox_sourceflag;
var trial_definerClock;
var instructionsClock;
var textbox_instructions;
var image_icon_alone;
var image_icon_together;
var mouse_instructions;
var polygon_continuebutton;
var textbox_continuebutton;
var trial_settingsClock;
var fixationClock;
var fixation_cross;
var stimulus_ratingClock;
var textbox_slidertext;
var textbox_activitytext;
var image_icon;
var slider;
var textbox_l01;
var textbox_l02;
var textbox_currentValue;
var polygon_submitbutton;
var textbox_submitbutton;
var mouse;
var endClock;
var textbox_end;
var textbox_wait;
var globalClock;
var routineTimer;
async function experimentInit() {
  // Initialize components for Routine "global_experiment_settings"
  global_experiment_settingsClock = new util.Clock();
  // Run 'Begin Experiment' code from code_global_settings
  // Read in activities file
  ActivityList = new TrialHandler({
    psychoJS: psychoJS,
    nReps: 1, method: TrialHandler.Method.SEQUENTIAL,
    extraInfo: expInfo, originPath: undefined,
    trialList: "stimuli/activities.csv",
    seed: undefined, name: 'ActivityList'
  });
  
  // Define number of trials
  N = ActivityList.trialList.length;
  N_TRIALS = 2*N; // Each activity presented in alone- and in together condition
  
  // Detect if mobile device is used 
  // (only works reliable for mobile phones, not for tablets)
  mobile_device = false;
  if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(navigator.userAgent) 
      || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(navigator.userAgent.substr(0,4))) { 
      mobile_device = true;
  }
  
  // Define opacities
  opacity1 = 0.75; // default opacity of buttons
  opacity2 = 1; // opacity if hovered over button
  
  // inter stimulus interval in s (lower bound)
  ISI = 0.1; 
  
  // Slider settings
  low_tick = 0;
  up_tick = 100;
  slider_center_x = 0;
  slider_center_y = -0.05;
  slider_xy = [slider_center_x,slider_center_y];
  slider_ticks = [low_tick,up_tick];
  l01_text = low_tick.toString() + "€";
  l02_text = up_tick.toString() + "€";
  
  // Buttons settings
  continuebutton_edgethickness = 2;
  continuebutton_fillcolor = [0.9,0.9,0.9];
  continuebutton_bordercolor = [-1,-1,-1];
  submitbutton_size = [0.35, 0.12];
  submitbutton_edgethickness = 2;
  submitbutton_fillcolor = [0.9,0.9,0.9];
  submitbutton_bordercolor = [-1,-1,-1];
  
  // Trial icons
  img_source_alone = "stimuli/single-icon.png";
  img_source_together = "stimuli/friends-icon.png";
  img_size_alone = [0.0645,0.15];
  img_size_together = [0.15,0.1125];
  
  // initial opacities
  if (mobile_device){
      opacity1 = 1; // no hovereffect for touchscreen
  }
  image_ukflag_opacity = opacity1;
  image_germanyflag_opacity = opacity1;
  submitbutton_opacity = opacity1;
  
  // current trial index
  idx = 0;
  // Initialize components for Routine "jitter_settings"
  jitter_settingsClock = new util.Clock();
  // Run 'Begin Experiment' code from code_jitter
  // Load jitter file
  jitterList = new TrialHandler({
      psychoJS: psychoJS,
      nReps: 1, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: "DelayJitter/DelayJitter.csv",
      seed: undefined, name: 'jitterList'
  });
  
  // Init jitter shuffle variables
  jitter = []; // Storage for shuffled jitter
  const N_jitter = jitterList.trialList.length; // Number of jitter entries
  var n = jitterList.trialList.length; // Number of unshuffled jitter entries 
  var rand_i = 0; // random sampled index
  
  // Shuffle jitter
  for (var i = 0; (i < N_jitter); i += 1) {
      rand_i = Number.parseInt((n * Math.random()));
      jitter.push(jitterList.trialList[rand_i]['delay']);
      jitterList.trialList.splice(rand_i, 1);
      n -= 1;
  }
  // Initialize components for Routine "language_choice"
  language_choiceClock = new util.Clock();
  image_germanyflag = new visual.ImageStim({
    win : psychoJS.window,
    name : 'image_germanyflag', units : undefined, 
    image : 'buttons/germany_flag.png', mask : undefined,
    ori : 0.0, pos : [(- 0.3), (- 0.22)], size : [0.3, 0.3],
    color : new util.Color([1,1,1]), opacity : 1.0,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  image_ukflag = new visual.ImageStim({
    win : psychoJS.window,
    name : 'image_ukflag', units : undefined, 
    image : 'buttons/uk_flag.png', mask : undefined,
    ori : 0.0, pos : [0.3, (- 0.22)], size : [0.3, 0.3],
    color : new util.Color([1,1,1]), opacity : 1.0,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -2.0 
  });
  textbox_languagechoice = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_languagechoice',
    text: 'Choose your preferred language',
    font: 'Arial',
    pos: [0, 0.2], letterHeight: 0.1,
    size: [0.95, 0.5],  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
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
    font: 'Arial',
    pos: [0, 0], letterHeight: 0.015,
    size: [0.3, 0.04],  units: undefined, 
    color: [0.6549, 0.6549, 0.6549], colorSpace: 'rgb',
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
  
  // Initialize components for Routine "trial_definer"
  trial_definerClock = new util.Clock();
  // Initialize components for Routine "instructions"
  instructionsClock = new util.Clock();
  textbox_instructions = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_instructions',
    text: '',
    font: 'Arial',
    pos: [(- 0.15), 0.1], letterHeight: 0.035,
    size: 1.0,  units: undefined, 
    color: [(- 1.0), (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -1.0 
  });
  
  image_icon_alone = new visual.ImageStim({
    win : psychoJS.window,
    name : 'image_icon_alone', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : 1.0,
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -2.0 
  });
  image_icon_together = new visual.ImageStim({
    win : psychoJS.window,
    name : 'image_icon_together', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : 1.0,
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -3.0 
  });
  mouse_instructions = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_instructions.mouseClock = new util.Clock();
  polygon_continuebutton = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_continuebutton', 
    width: [1.0, 1.0][0], height: [1.0, 1.0][1],
    ori: 0.0, pos: [0, 0],
    lineWidth: continuebutton_edgethickness, 
    colorSpace: 'rgb',
    lineColor: new util.Color(continuebutton_bordercolor),
    fillColor: new util.Color(continuebutton_fillcolor),
    opacity: 1.0, depth: -5, interpolate: true,
  });
  
  textbox_continuebutton = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_continuebutton',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: 0.04,
    size: 1.0,  units: undefined, 
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: 1.0,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -6.0 
  });
  
  // Initialize components for Routine "trial_settings"
  trial_settingsClock = new util.Clock();
  // Initialize components for Routine "fixation"
  fixationClock = new util.Clock();
  fixation_cross = new visual.ShapeStim ({
    win: psychoJS.window, name: 'fixation_cross', 
    vertices: 'cross', size:[0.025, 0.025],
    ori: 0.0, pos: [0, 0],
    lineWidth: 1.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('white'),
    fillColor: new util.Color('black'),
    opacity: undefined, depth: 0, interpolate: true,
  });
  
  // Initialize components for Routine "stimulus_rating"
  stimulus_ratingClock = new util.Clock();
  textbox_slidertext = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_slidertext',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: 0.035,
    size: 1.0,  units: undefined, 
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
    depth: -1.0 
  });
  
  textbox_activitytext = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_activitytext',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: 0.065,
    size: 1.0,  units: undefined, 
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
    depth: -2.0 
  });
  
  image_icon = new visual.ImageStim({
    win : psychoJS.window,
    name : 'image_icon', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0.0, pos : [0, 0], size : 1.0,
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -3.0 
  });
  slider = new visual.Slider({
    win: psychoJS.window, name: 'slider',
    startValue: undefined,
    size: 1.0, pos: slider_xy, ori: 0.0, units: 'height',
    labels: undefined, fontSize: 0.05, ticks: slider_ticks,
    granularity: 0.0, style: ["SLIDER"],
    color: new util.Color([0.7804, 0.8118, 0.8118]), markerColor: new util.Color([(- 1.0), (- 1.0), 0.0902]), lineColor: new util.Color([0.7804, 0.8118, 0.8118]), 
    opacity: undefined, fontFamily: 'Open Sans', bold: true, italic: false, depth: -4, 
    flip: false,
  });
  
  textbox_l01 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l01',
    text: l01_text,
    font: 'Arial',
    pos: [0, 0], letterHeight: 0.05,
    size: [0.4, 0.2],  units: undefined, 
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: true,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-left',
    editable: false,
    multiline: true,
    anchor: 'center-left',
    depth: -5.0 
  });
  
  textbox_l02 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l02',
    text: l02_text,
    font: 'Arial',
    pos: [0, 0], letterHeight: 0.05,
    size: [0.4, 0.2],  units: undefined, 
    color: 'black', colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: true,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center-right',
    editable: false,
    multiline: true,
    anchor: 'center-right',
    depth: -6.0 
  });
  
  textbox_currentValue = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_currentValue',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: 0.05,
    size: [0.3, 0.1],  units: undefined, 
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
  
  polygon_submitbutton = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbutton', 
    width: submitbutton_size[0], height: submitbutton_size[1],
    ori: 0.0, pos: [0, 0],
    lineWidth: submitbutton_edgethickness, 
    colorSpace: 'rgb',
    lineColor: new util.Color(submitbutton_bordercolor),
    fillColor: new util.Color(submitbutton_fillcolor),
    opacity: 1.0, depth: -8, interpolate: true,
  });
  
  textbox_submitbutton = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbutton',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: 0.075,
    size: submitbutton_size,  units: undefined, 
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
    depth: -9.0 
  });
  
  mouse = new core.Mouse({
    win: psychoJS.window,
  });
  mouse.mouseClock = new util.Clock();
  // Initialize components for Routine "end"
  endClock = new util.Clock();
  textbox_end = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_end',
    text: '',
    font: 'Arial',
    pos: [0, 0.1], letterHeight: 0.05,
    size: [0.9, 0.5],  units: undefined, 
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
    depth: 0.0 
  });
  
  textbox_wait = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_wait',
    text: '',
    font: 'Arial',
    pos: [0, (- 0.1)], letterHeight: 0.03,
    size: [0.7, 0.5],  units: undefined, 
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
    depth: -1.0 
  });
  
  // Create some handy timers
  globalClock = new util.Clock();  // to track the time since experiment started
  routineTimer = new util.CountdownTimer();  // to track time remaining of each (non-slip) routine
  
  return Scheduler.Event.NEXT;
}


var t;
var frameN;
var continueRoutine;
var global_experiment_settingsComponents;
function global_experiment_settingsRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'global_experiment_settings' ---
    t = 0;
    global_experiment_settingsClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    // keep track of which components have finished
    global_experiment_settingsComponents = [];
    
    for (const thisComponent of global_experiment_settingsComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function global_experiment_settingsRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'global_experiment_settings' ---
    // get current time
    t = global_experiment_settingsClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of global_experiment_settingsComponents)
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


function global_experiment_settingsRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'global_experiment_settings' ---
    for (const thisComponent of global_experiment_settingsComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "global_experiment_settings" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var jitter_settingsComponents;
function jitter_settingsRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'jitter_settings' ---
    t = 0;
    jitter_settingsClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    // keep track of which components have finished
    jitter_settingsComponents = [];
    
    for (const thisComponent of jitter_settingsComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function jitter_settingsRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'jitter_settings' ---
    // get current time
    t = jitter_settingsClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of jitter_settingsComponents)
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


function jitter_settingsRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'jitter_settings' ---
    for (const thisComponent of jitter_settingsComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "jitter_settings" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var window_height;
var window_width;
var xrange;
var yrange;
var last_xrange;
var sourcetext_xy;
var gotValidClick;
var language_choiceComponents;
function language_choiceRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'language_choice' ---
    t = 0;
    language_choiceClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    // Window size
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = (window_width / window_height);
    yrange = (window_height / window_width);
    last_xrange = xrange;
    
    // Positional arguments
    sourcetext_xy = [0.3*Math.max(1,xrange), -0.48*Math.max(1,yrange)];
    // setup some python lists for storing info about the mouse_languagechoice
    mouse_languagechoice.clicked_name = [];
    gotValidClick = false; // until a click is received
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
    if (!mobile_device){
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
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = (window_width / window_height);
    if(xrange != last_xrange){
        // Size changed
        last_xrange = xrange;
        yrange = (window_height / window_width);
        sourcetext_xy = [0.3*Math.max(1,xrange), -0.48*Math.max(1,yrange)];
    }
    
    // *image_germanyflag* updates
    if (t >= 0.0 && image_germanyflag.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      image_germanyflag.tStart = t;  // (not accounting for frame time here)
      image_germanyflag.frameNStart = frameN;  // exact frame index
      
      image_germanyflag.setAutoDraw(true);
    }

    
    if (image_germanyflag.status === PsychoJS.Status.STARTED){ // only update if being drawn
      image_germanyflag.setOpacity(image_germanyflag_opacity , false);
    }
    
    // *image_ukflag* updates
    if (t >= 0.0 && image_ukflag.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      image_ukflag.tStart = t;  // (not accounting for frame time here)
      image_ukflag.frameNStart = frameN;  // exact frame index
      
      image_ukflag.setAutoDraw(true);
    }

    
    if (image_ukflag.status === PsychoJS.Status.STARTED){ // only update if being drawn
      image_ukflag.setOpacity(image_ukflag_opacity , false);
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
          for (const obj of [image_germanyflag, image_ukflag,]) {
            if (obj.contains(mouse_languagechoice)) {
              gotValidClick = true;
              mouse_languagechoice.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    
    // *textbox_sourceflag* updates
    if (t >= 0.0 && textbox_sourceflag.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_sourceflag.tStart = t;  // (not accounting for frame time here)
      textbox_sourceflag.frameNStart = frameN;  // exact frame index
      
      textbox_sourceflag.setAutoDraw(true);
    }

    
    if (textbox_sourceflag.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_sourceflag.setPos(sourcetext_xy, false);
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


var languagechoice;
var instructions_text;
var continuebutton_text;
var stimulus_text;
var alone_text;
var together_text;
var submitbutton_text;
var end_text;
var end_text2;
function language_choiceRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'language_choice' ---
    for (const thisComponent of language_choiceComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // If clicked on the german (uk) flag, the languagechoice is set to german (english)
    if ((mouse_languagechoice.clicked_name[0] === "image_germanyflag")) {
        languagechoice = "ger";
    } else {
        languagechoice = "uk";
    }
    // Store chosen language
    expInfo["language"] = languagechoice;
    // Set texts according to languagechoice
    if ((languagechoice === "ger")) {
        // instructions routine
        instructions_text = "Im Folgenden werden Sie einige Fragen zu Freizeitaktivit\u00e4ten beantworten. Wir bitten Sie anzugeben, wie viel Sie bereit sind für die jeweils pr\u00e4sentierte Freizeitaktivit\u00e4t auszugeben, wenn Sie diese alleine unternehmen bzw. wie viel Sie bereit sind auszugeben, wenn Sie die Aktivität mit jemand anderem zusammen unternehmen.\nDie jeweilige Frage wird zusätzlich durch eins der hier auf der rechten Seite dargestellten Icons gekennzeichnet.\n\nUm Ihre Antworten einzugeben k\u00f6nnen Sie einen Regler \u00fcber eine Skala verschieben. Danach können Sie Ihre Eingabe bestätigen.";
        continuebutton_text = "Klicken Sie hier, wenn Sie die Instruktionen gelesen haben";
        // stimulus_rating routine
        stimulus_text = "Wie viel sind Sie bereit, für die folgende Freizeitaktivit\u00e4t auszugeben:";
        alone_text = "alleine";
        together_text = "zusammen";
        submitbutton_text = "Weiter";
        // end routine
        end_text = "Das Experiment ist nun beendet.\nVielen Dank f\u00fcr Ihre Teilnahme.";
        end_text2 = "Bitte schliessen Sie das Experiment nicht bevor das Fenster mit der Nachricht 'Thank you for your patience.' erscheint. \nDies kann einen Moment dauern.";
    } else {
        // instructions routine
        instructions_text =  "We will now ask you a few questions about free time activities. We will ask you to indicate how much you are willing to spend on the free time activity presented if you undertake it alone or how much you are willing to spend if you undertake the activity together with someone else.\nThe respective question is also indicated by one oft he icons shown here on the right.\n\nTo answer the questions, you can move the point on the scale. After this you can confirm your selection.";
        continuebutton_text = "Click here when you have read the instructions";
        // stimulus_rating routine
        stimulus_text = "How much are you willing to spend on the following free time activity:";
        alone_text = "alone";
        together_text = "together";
        submitbutton_text = "Submit";
        // end routine
        end_text = "The experiment is over.\nThank you for your participation.";
        end_text2 = "Please do not close the experiment before the window with the message 'Thank you for your patience.' appears. \nThis may take a moment.";
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


var activityCol;
var ActivityIDs;
var Activities;
var Conditions;
var RANDIS;
var trial_definerComponents;
function trial_definerRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'trial_definer' ---
    t = 0;
    trial_definerClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    //// Helper functions: 
    // Repeat each element count times
    function repeatArray(arr, count) {
      return arr.flatMap(item => Array(count).fill(item));
    }
    // Shuffle array with Fisher–Yates shuffle
    function shuffleArray(arr) {
      for (let i = arr.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [arr[i], arr[j]] = [arr[j], arr[i]];
      }
      return arr;
    }
    // Create random array with values 0 to n
    function createRandomArray(n) {
      const initialArray = Array.from({ length: n }, (_, index) => index);
      return shuffleArray(initialArray);
    }
    
    //// Load relevant items
    if ((languagechoice === "ger")) {
        activityCol = "activityGer";
    } else {
        activityCol = "activityUK";
    } 
    ActivityIDs = [];
    Activities = [];
    for (var i = 0; (i < N_TRIALS); i += 1) {
        ActivityIDs.push(ActivityList.trialList[(i%N)]['activityID']);
        Activities.push(ActivityList.trialList[(i%N)][activityCol]);
    }
    Conditions = repeatArray(["alone", "together"], N);
    
    //// Create random index list
    RANDIS = createRandomArray(N_TRIALS);
    // keep track of which components have finished
    trial_definerComponents = [];
    
    for (const thisComponent of trial_definerComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function trial_definerRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'trial_definer' ---
    // get current time
    t = trial_definerClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of trial_definerComponents)
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


function trial_definerRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'trial_definer' ---
    for (const thisComponent of trial_definerComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "trial_definer" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var button_instructions_xy;
var button_instructions_size;
var instructions_size;
var img_xy_alone;
var img_xy_together;
var instructionsComponents;
function instructionsRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'instructions' ---
    t = 0;
    instructionsClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_instructions
    // Window size
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = (window_width / window_height);
    yrange = (window_height / window_width);
    last_xrange = xrange;
    
    // Positional + size arguments
    button_instructions_xy = [0, (- 0.3)*Math.max(1,yrange)];
    button_instructions_size  = [0.5*Math.max(1,Math.sqrt(Math.sqrt(xrange))), 0.1*Math.max(1,yrange)];
    instructions_size = [0.6*Math.max(1,Math.sqrt(xrange)), 0.6*Math.max(1,Math.sqrt(yrange))];
    img_xy_alone = [0.325*Math.max(1,Math.sqrt(xrange)),0.2];
    img_xy_together = [0.325*Math.max(1,Math.sqrt(xrange)),0];
    textbox_instructions.setText(instructions_text);
    image_icon_alone.setSize(img_size_alone);
    image_icon_alone.setImage(img_source_alone);
    image_icon_together.setSize(img_size_together);
    image_icon_together.setImage(img_source_together);
    // setup some python lists for storing info about the mouse_instructions
    mouse_instructions.clicked_name = [];
    gotValidClick = false; // until a click is received
    textbox_continuebutton.setText(continuebutton_text);
    // keep track of which components have finished
    instructionsComponents = [];
    instructionsComponents.push(textbox_instructions);
    instructionsComponents.push(image_icon_alone);
    instructionsComponents.push(image_icon_together);
    instructionsComponents.push(mouse_instructions);
    instructionsComponents.push(polygon_continuebutton);
    instructionsComponents.push(textbox_continuebutton);
    
    for (const thisComponent of instructionsComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


var continuebutton_opacity;
function instructionsRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'instructions' ---
    // get current time
    t = instructionsClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Hovereffect for continuebutton
    if (!mobile_device){
        if (polygon_continuebutton.contains(mouse_instructions)) {
            continuebutton_opacity = opacity2;
        } else {
            continuebutton_opacity = opacity1;
        }
    }
    
    // Window size
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = (window_width / window_height);
    if(xrange != last_xrange){
        // Size changed
        last_xrange = xrange;
        yrange = (window_height / window_width);
        button_instructions_xy = [0, (- 0.3)*Math.max(1,yrange)];
        button_instructions_size  = [0.5*Math.max(1,Math.sqrt(Math.sqrt(xrange))), 0.1*Math.max(1,yrange)];
        instructions_size = [0.6*Math.max(1,Math.sqrt(xrange)), 0.6*Math.max(1,Math.sqrt(yrange))];
        img_xy_alone = [0.325*Math.max(1,Math.sqrt(xrange)),0.2];
        img_xy_together = [0.325*Math.max(1,Math.sqrt(xrange)),0];
    }
    
    // *textbox_instructions* updates
    if (t >= 0.0 && textbox_instructions.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_instructions.tStart = t;  // (not accounting for frame time here)
      textbox_instructions.frameNStart = frameN;  // exact frame index
      
      textbox_instructions.setAutoDraw(true);
    }

    
    if (textbox_instructions.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_instructions.setSize(instructions_size, false);
    }
    
    // *image_icon_alone* updates
    if (t >= 0.0 && image_icon_alone.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      image_icon_alone.tStart = t;  // (not accounting for frame time here)
      image_icon_alone.frameNStart = frameN;  // exact frame index
      
      image_icon_alone.setAutoDraw(true);
    }

    
    if (image_icon_alone.status === PsychoJS.Status.STARTED){ // only update if being drawn
      image_icon_alone.setPos(img_xy_alone, false);
    }
    
    // *image_icon_together* updates
    if (t >= 0.0 && image_icon_together.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      image_icon_together.tStart = t;  // (not accounting for frame time here)
      image_icon_together.frameNStart = frameN;  // exact frame index
      
      image_icon_together.setAutoDraw(true);
    }

    
    if (image_icon_together.status === PsychoJS.Status.STARTED){ // only update if being drawn
      image_icon_together.setPos(img_xy_together, false);
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
          for (const obj of [polygon_continuebutton,]) {
            if (obj.contains(mouse_instructions)) {
              gotValidClick = true;
              mouse_instructions.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    
    // *polygon_continuebutton* updates
    if (t >= 0.0 && polygon_continuebutton.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_continuebutton.tStart = t;  // (not accounting for frame time here)
      polygon_continuebutton.frameNStart = frameN;  // exact frame index
      
      polygon_continuebutton.setAutoDraw(true);
    }

    
    if (polygon_continuebutton.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_continuebutton.setOpacity(continuebutton_opacity, false);
      polygon_continuebutton.setPos(button_instructions_xy, false);
      polygon_continuebutton.setSize(button_instructions_size, false);
    }
    
    // *textbox_continuebutton* updates
    if (t >= 0.0 && textbox_continuebutton.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_continuebutton.tStart = t;  // (not accounting for frame time here)
      textbox_continuebutton.frameNStart = frameN;  // exact frame index
      
      textbox_continuebutton.setAutoDraw(true);
    }

    
    if (textbox_continuebutton.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_continuebutton.setPos(button_instructions_xy, false);
      textbox_continuebutton.setSize(button_instructions_size, false);
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


var trials;
function trialsLoopBegin(trialsLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    trials = new TrialHandler({
      psychoJS: psychoJS,
      nReps: N_TRIALS, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'trials'
    });
    psychoJS.experiment.addLoop(trials); // add the loop to the experiment
    currentLoop = trials;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    for (const thisTrial of trials) {
      snapshot = trials.getSnapshot();
      trialsLoopScheduler.add(importConditions(snapshot));
      trialsLoopScheduler.add(trial_settingsRoutineBegin(snapshot));
      trialsLoopScheduler.add(trial_settingsRoutineEachFrame());
      trialsLoopScheduler.add(trial_settingsRoutineEnd(snapshot));
      trialsLoopScheduler.add(fixationRoutineBegin(snapshot));
      trialsLoopScheduler.add(fixationRoutineEachFrame());
      trialsLoopScheduler.add(fixationRoutineEnd(snapshot));
      trialsLoopScheduler.add(stimulus_ratingRoutineBegin(snapshot));
      trialsLoopScheduler.add(stimulus_ratingRoutineEachFrame());
      trialsLoopScheduler.add(stimulus_ratingRoutineEnd(snapshot));
      trialsLoopScheduler.add(trialsLoopEndIteration(trialsLoopScheduler, snapshot));
    }
    
    return Scheduler.Event.NEXT;
  }
}


async function trialsLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(trials);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function trialsLoopEndIteration(scheduler, snapshot) {
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


var fixation_duration;
var rand_i;
var activityID;
var activity;
var condition;
var activity_text;
var img_source;
var img_size;
var trial_settingsComponents;
function trial_settingsRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'trial_settings' ---
    t = 0;
    trial_settingsClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    //// Set fixation duration
    fixation_duration = ISI + jitter[idx];
    
    //// Define trial content
    // get random index
    rand_i = RANDIS[idx];
    // get activity + condition
    activityID = ActivityIDs[rand_i];
    activity = Activities[rand_i];
    condition = Conditions[rand_i];
    // Set texts + icons
    if (condition == "alone"){
        activity_text = activity + " - " + alone_text;
        img_source = img_source_alone;
        img_size = img_size_alone;
    } else {
        activity_text = activity + " - " + together_text;
        img_source = img_source_together;
        img_size = img_size_together;
    }
    
    
    // keep track of which components have finished
    trial_settingsComponents = [];
    
    for (const thisComponent of trial_settingsComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function trial_settingsRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'trial_settings' ---
    // get current time
    t = trial_settingsClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of trial_settingsComponents)
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


function trial_settingsRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'trial_settings' ---
    for (const thisComponent of trial_settingsComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // Increment trial index
    idx += 1;
    
    //// Save trial data
    expInfo['fixation_dur'] = fixation_duration;
    expInfo['activityID'] = activityID;
    expInfo['condition'] = condition;
    // the Routine "trial_settings" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var fixationComponents;
function fixationRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'fixation' ---
    t = 0;
    fixationClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
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

    frameRemains = 0.0 + fixation_duration - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (fixation_cross.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      fixation_cross.setAutoDraw(false);
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
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function fixationRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'fixation' ---
    for (const thisComponent of fixationComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // the Routine "fixation" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var slidertext_size;
var slidertext_xy;
var activitytext_size;
var activitytext_xy;
var currentvalue_xy;
var img_xy;
var slider_w;
var slider_h;
var slider_size;
var low_x;
var up_x;
var slider_label1_xy;
var slider_label2_xy;
var submitbutton_xy;
var stimulus_ratingComponents;
function stimulus_ratingRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'stimulus_rating' ---
    t = 0;
    stimulus_ratingClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    var ratingGiven = false //track if ratings have been given to all sliders
    var mousePos = [0,0];
    
    var value_text = "";
    
    // Window size
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = (window_width / window_height);
    yrange = (window_height / window_width);
    last_xrange = xrange;
    
    // Positional and size arguments
    slidertext_size = [0.8*Math.max(1,Math.sqrt(xrange)), 0.2];
    slidertext_xy = [0, 0.35*Math.max(1,Math.sqrt(yrange))];
    activitytext_size = [0.8*Math.max(1,Math.sqrt(xrange)), 0.2];
    activitytext_xy = [0, 0.25*Math.max(1,Math.sqrt(yrange))];
    currentvalue_xy = [0, -0.15*Math.max(1,Math.sqrt(Math.sqrt(yrange)))];
    img_xy = [0, 0.1*Math.max(1,Math.sqrt(yrange))];
    slider_w = 0.75*Math.max(1,Math.sqrt(xrange));
    slider_h = 0.08;
    slider_size = [slider_w, slider_h];
    low_x = slider_center_x-slider_w/2;
    up_x = slider_center_x+slider_w/2;
    slider_label1_xy = [slider_xy[0] - (slider_size[0] / 2) - 0.05, slider_xy[1] - (slider_size[1]/2) - 0.04];
    slider_label2_xy = [slider_xy[0] + (slider_size[0] / 2) + 0.05, slider_xy[1] - (slider_size[1]/2) - 0.04];
    submitbutton_xy = [0, (- 0.3)*Math.max(1,yrange)];
    
    textbox_slidertext.setText(stimulus_text);
    textbox_activitytext.setText(activity_text);
    image_icon.setSize(img_size);
    image_icon.setImage(img_source);
    slider.reset()
    textbox_submitbutton.setText(submitbutton_text);
    // setup some python lists for storing info about the mouse
    // current position of the mouse:
    mouse.x = [];
    mouse.y = [];
    mouse.leftButton = [];
    mouse.midButton = [];
    mouse.rightButton = [];
    mouse.time = [];
    mouse.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    stimulus_ratingComponents = [];
    stimulus_ratingComponents.push(textbox_slidertext);
    stimulus_ratingComponents.push(textbox_activitytext);
    stimulus_ratingComponents.push(image_icon);
    stimulus_ratingComponents.push(slider);
    stimulus_ratingComponents.push(textbox_l01);
    stimulus_ratingComponents.push(textbox_l02);
    stimulus_ratingComponents.push(textbox_currentValue);
    stimulus_ratingComponents.push(polygon_submitbutton);
    stimulus_ratingComponents.push(textbox_submitbutton);
    stimulus_ratingComponents.push(mouse);
    
    for (const thisComponent of stimulus_ratingComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


var cond_submitbutton;
var mousePos;
var xval;
var rating;
var value_text;
var rating_done;
var ratingGiven;
var button_pressed;
var _mouseXYs;
function stimulus_ratingRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'stimulus_rating' ---
    // get current time
    t = stimulus_ratingClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Run 'Each Frame' code from code_updateState
    //// Continuebutton display condition
    cond_submitbutton = ratingGiven;
    
    // Calculate rating by mouse position
    // (needed to get real-time-feedback; slider.getRating() 
    //  only updates after marker was dragged)
    if(slider.isMarkerDragging()){
        mousePos = mouse.getPos();
        xval = mousePos[0];
        if(xval>up_x){ // xpos of mouse > upper slider limit
            rating = up_tick;
        }else{
        if(xval<low_x){ // xpos of mouse < lower slider limit
            rating = low_tick;
        }else{
            // interpolate rating from mouse pos
            rating = (xval-low_x)*(up_tick-low_tick)/(up_x-low_x); 
        }}
        value_text = getNiceValue(rating,languagechoice) + "€";
    }
    // check if rating has been given before allowing the participant to press submit
    // use "slider.getRating();" since it only changes if dragging process is done
    rating_done = slider.getRating();
    if (rating_done != null){
        ratingGiven = true;
    }
    
    // Hovereffect for submitbutton
    if (!mobile_device && cond_submitbutton){
        if (polygon_submitbutton.contains(mouse)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    
    // Check if continuebutton was pressed and end routine if true
    if(ratingGiven && polygon_submitbutton.contains(mouse)){
        button_pressed = mouse.getPressed()[0];
        if(button_pressed == 1){
            continueRoutine = false;
        }
    }
    
    // Window size
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = (window_width / window_height);
    if(xrange != last_xrange){
        // Size changed
        last_xrange = xrange;
        yrange = (window_height / window_width);
        slidertext_size = [0.8*Math.max(1,Math.sqrt(xrange)), 0.2];
        slidertext_xy = [0, 0.35*Math.max(1,Math.sqrt(yrange))];
        activitytext_size = [0.8*Math.max(1,Math.sqrt(xrange)), 0.2];
        activitytext_xy = [0, 0.25*Math.max(1,Math.sqrt(yrange))];
        currentvalue_xy = [0, -0.15*Math.max(1,Math.sqrt(Math.sqrt(yrange)))];
        img_xy = [0, 0.1*Math.max(1,Math.sqrt(yrange))];
        slider_w = 0.75*Math.max(1,Math.sqrt(xrange));
        slider_h = 0.08;
        slider_size = [slider_w, slider_h];
        low_x = slider_center_x-slider_w/2;
        up_x = slider_center_x+slider_w/2;
        slider_label1_xy = [slider_xy[0] - (slider_size[0] / 2) - 0.05, slider_xy[1] - (slider_size[1]/2) - 0.04];
        slider_label2_xy = [slider_xy[0] + (slider_size[0] / 2) + 0.05, slider_xy[1] - (slider_size[1]/2) - 0.04];
        submitbutton_xy = [0, (- 0.3)*Math.max(1,yrange)];
    }
    
    
    // *textbox_slidertext* updates
    if (t >= 0.0 && textbox_slidertext.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_slidertext.tStart = t;  // (not accounting for frame time here)
      textbox_slidertext.frameNStart = frameN;  // exact frame index
      
      textbox_slidertext.setAutoDraw(true);
    }

    
    if (textbox_slidertext.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_slidertext.setPos(slidertext_xy, false);
      textbox_slidertext.setSize(slidertext_size, false);
    }
    
    // *textbox_activitytext* updates
    if (t >= 0.0 && textbox_activitytext.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_activitytext.tStart = t;  // (not accounting for frame time here)
      textbox_activitytext.frameNStart = frameN;  // exact frame index
      
      textbox_activitytext.setAutoDraw(true);
    }

    
    if (textbox_activitytext.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_activitytext.setPos(activitytext_xy, false);
      textbox_activitytext.setSize(activitytext_size, false);
    }
    
    // *image_icon* updates
    if (t >= 0.0 && image_icon.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      image_icon.tStart = t;  // (not accounting for frame time here)
      image_icon.frameNStart = frameN;  // exact frame index
      
      image_icon.setAutoDraw(true);
    }

    
    if (image_icon.status === PsychoJS.Status.STARTED){ // only update if being drawn
      image_icon.setPos(img_xy, false);
    }
    
    // *slider* updates
    if (t >= 0.0 && slider.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      slider.tStart = t;  // (not accounting for frame time here)
      slider.frameNStart = frameN;  // exact frame index
      
      slider.setAutoDraw(true);
    }

    
    if (slider.status === PsychoJS.Status.STARTED){ // only update if being drawn
      slider.setSize(slider_size, false);
    }
    
    // *textbox_l01* updates
    if (t >= 0.0 && textbox_l01.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l01.tStart = t;  // (not accounting for frame time here)
      textbox_l01.frameNStart = frameN;  // exact frame index
      
      textbox_l01.setAutoDraw(true);
    }

    
    if (textbox_l01.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_l01.setPos(slider_label1_xy, false);
    }
    
    // *textbox_l02* updates
    if (t >= 0.0 && textbox_l02.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l02.tStart = t;  // (not accounting for frame time here)
      textbox_l02.frameNStart = frameN;  // exact frame index
      
      textbox_l02.setAutoDraw(true);
    }

    
    if (textbox_l02.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_l02.setPos(slider_label2_xy, false);
    }
    
    // *textbox_currentValue* updates
    if (t >= 0.0 && textbox_currentValue.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_currentValue.tStart = t;  // (not accounting for frame time here)
      textbox_currentValue.frameNStart = frameN;  // exact frame index
      
      textbox_currentValue.setAutoDraw(true);
    }

    
    if (textbox_currentValue.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_currentValue.setPos(currentvalue_xy, false);
      textbox_currentValue.setText(value_text, false);
    }
    
    // *polygon_submitbutton* updates
    if ((cond_submitbutton) && polygon_submitbutton.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbutton.tStart = t;  // (not accounting for frame time here)
      polygon_submitbutton.frameNStart = frameN;  // exact frame index
      
      polygon_submitbutton.setAutoDraw(true);
    }

    
    if (polygon_submitbutton.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_submitbutton.setOpacity(submitbutton_opacity, false);
      polygon_submitbutton.setPos(submitbutton_xy, false);
    }
    
    // *textbox_submitbutton* updates
    if ((cond_submitbutton) && textbox_submitbutton.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbutton.tStart = t;  // (not accounting for frame time here)
      textbox_submitbutton.frameNStart = frameN;  // exact frame index
      
      textbox_submitbutton.setAutoDraw(true);
    }

    
    if (textbox_submitbutton.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_submitbutton.setPos(submitbutton_xy, false);
    }
    // *mouse* updates
    if (t >= 0.0 && mouse.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse.tStart = t;  // (not accounting for frame time here)
      mouse.frameNStart = frameN;  // exact frame index
      
      mouse.status = PsychoJS.Status.STARTED;
      mouse.mouseClock.reset();
      prevButtonState = mouse.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse.getPressed();
      // check if the mouse was inside our 'clickable' objects
      gotValidClick = false;
      for (const obj of [polygon_submitbutton,]) {
        if (obj.contains(mouse)) {
          gotValidClick = true;
          mouse.clicked_name.push(obj.name)
        }
      }
      _mouseXYs = mouse.getPos();
      mouse.x.push(_mouseXYs[0]);
      mouse.y.push(_mouseXYs[1]);
      mouse.leftButton.push(_mouseButtons[0]);
      mouse.midButton.push(_mouseButtons[1]);
      mouse.rightButton.push(_mouseButtons[2]);
      mouse.time.push(mouse.mouseClock.getTime());
    }
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of stimulus_ratingComponents)
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


function stimulus_ratingRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'stimulus_rating' ---
    for (const thisComponent of stimulus_ratingComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // Save rating+RT
    rating = Number(getNiceValue(slider.getRating(),"uk"));
    expInfo['willi2pay'] = rating;
    expInfo['Trial_RT'] = t;
    
    // Reset
    value_text = "";
    ratingGiven = false;
    // store data for psychoJS.experiment (ExperimentHandler)
    psychoJS.experiment.addData('mouse.x', mouse.x);
    psychoJS.experiment.addData('mouse.y', mouse.y);
    psychoJS.experiment.addData('mouse.leftButton', mouse.leftButton);
    psychoJS.experiment.addData('mouse.midButton', mouse.midButton);
    psychoJS.experiment.addData('mouse.rightButton', mouse.rightButton);
    psychoJS.experiment.addData('mouse.time', mouse.time);
    psychoJS.experiment.addData('mouse.clicked_name', mouse.clicked_name);
    
    // the Routine "stimulus_rating" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var endComponents;
function endRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'end' ---
    t = 0;
    endClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    routineTimer.add(8.000000);
    // update component parameters for each repeat
    textbox_end.setText(end_text);
    textbox_wait.setText(end_text2);
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

    frameRemains = 0.0 + 8 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
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

    frameRemains = 0.0 + 8 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (textbox_wait.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      textbox_wait.setAutoDraw(false);
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
