/************************************ 
 * Activity_Rating_Task_Legacy Test *
 ************************************/

import { core, data, sound, util, visual, hardware } from './lib/psychojs-2022.2.3.js';
const { PsychoJS } = core;
const { TrialHandler, MultiStairHandler } = data;
const { Scheduler } = util;
//some handy aliases as in the psychopy scripts;
const { abs, sin, cos, PI: pi, sqrt } = Math;
const { round } = util;


// store info about the experiment session:
let expName = 'activity_rating_task_legacy';  // from the Builder filename that created this script
let expInfo = {
    'participantID': '',
    'studyID': 'BON001',
    'session number': '',
};

// Start code blocks for 'Before Experiment'
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
flowScheduler.add(mobile_instructionsRoutineBegin());
flowScheduler.add(mobile_instructionsRoutineEachFrame());
flowScheduler.add(mobile_instructionsRoutineEnd());
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
    {'name': 'stimuli/activities.csv', 'path': 'stimuli/activities.csv'},
    {'name': 'DelayJitter/DelayJitter.csv', 'path': 'DelayJitter/DelayJitter.csv'},
    {'name': 'buttons/tilt_phone.png', 'path': 'buttons/tilt_phone.png'},
    {'name': 'buttons/uk_flag.png', 'path': 'buttons/uk_flag.png'},
    {'name': 'buttons/germany_flag.png', 'path': 'buttons/germany_flag.png'}
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

  psychoJS.experiment.dataFileName = (("." + "/") + `data/${"VASsocialrating"}_${expInfo["studyID"]}_${expInfo["participantID"]}`);

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
var mobile_device;
var opacity1;
var opacity2;
var ISI;
var slider_liking_ticks;
var label_letter_height;
var label_size;
var activity_ratings;
var continuebutton_size;
var continuebutton_edgethickness;
var continuebutton_fillcolor;
var continuebutton_bordercolor;
var submitbutton_size;
var submitbutton_edgethickness;
var submitbutton_fillcolor;
var submitbutton_bordercolor;
var languagechoice;
var image_ukflag_opacity;
var image_germanyflag_opacity;
var submitbutton_opacity;
var idx;
var fixation_duration;
var slidertext_letter_height;
var activitytext_letter_height;
var tick_size;
var jitter_settingsClock;
var jitterList;
var rand_i;
var jitter;
var N_jitter;
var n;
var language_choiceClock;
var image_germanyflag;
var image_ukflag;
var textbox_languagechoice;
var mouse_languagechoice;
var textbox_sourceflag;
var mobile_instructionsClock;
var textbox_mobile_instructions;
var image_tiltphone;
var mouse_mobilephone;
var polygon_continuebutton1;
var textbox_continuebutton1;
var textbox_sourceicon;
var instructionsClock;
var textbox_instructions;
var mouse_instructions;
var polygon_continuebutton;
var textbox_continuebutton;
var trial_settingsClock;
var fixationClock;
var fixation_cross;
var stimulus_ratingClock;
var textbox_slidertext;
var textbox_activitytext;
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
var t01;
var t02;
var t03;
var t04;
var t05;
var t06;
var t07;
var t08;
var t09;
var t10;
var t11;
var slider;
var textbox_reaction_reminder;
var polygon_submitbutton;
var textbox_submitbutton;
var mouse_nextTrial;
var endClock;
var textbox_end;
var textbox_wait;
var globalClock;
var routineTimer;
async function experimentInit() {
  // Initialize components for Routine "global_experiment_settings"
  global_experiment_settingsClock = new util.Clock();
  // Run 'Begin Experiment' code from code_global_settings
  // Detect if mobile device is used
  mobile_device = false;
  if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(navigator.userAgent) 
      || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(navigator.userAgent.substr(0,4))) { 
      // Detect mobile phones (and tablets? --> Does not seem like it - at least for iPads)
      mobile_device = true;
  }
  
  opacity1 = 0.75; // default opacity of buttons
  opacity2 = 1; // opacity if hovered over button
  ISI = 0.1; // inter stimulus interval in s (lower bound)
  
  // Vertical (liking) slider label setting 
  slider_liking_ticks = [(- 100), (- 62.8), (- 41.6), (- 17.6), (- 6), 0, 6.2, 17.8, 44.4, 65.8, 100];
  label_letter_height = 0.03;
  label_size = (0.3, 0.2);
  
  // List for shelf: [(activityID,rating),...]
  activity_ratings = []
  
  // Text buttons settings
  continuebutton_size = [0.6, 0.1];
  continuebutton_edgethickness = 2;
  continuebutton_fillcolor = [0.9,0.9,0.9];
  continuebutton_bordercolor = [-1,-1,-1];
  submitbutton_size = [0.35, 0.12]
  submitbutton_edgethickness = 2;
  submitbutton_fillcolor = [0.9,0.9,0.9];
  submitbutton_bordercolor = [-1,-1,-1];
  
  // initial variables: language_choice
  languagechoice = "no_choice_yet";
  
  // initial opacities
  if (mobile_device){
      opacity1 = 1; // no hovereffect for touchscreen
  }
  image_ukflag_opacity = opacity1;
  image_germanyflag_opacity = opacity1;
  submitbutton_opacity = opacity1;
  
  // current trial index
  idx = 0;
  // initial length of 'fixation' routine
  fixation_duration = 0;
  // Slidertext settings (Texts which explains what participant has to do)
  slidertext_letter_height = 0.035;
  // Activitytext settings (Current activity to be rated)
  activitytext_letter_height = 0.08;
  //Custom slider ticks
  tick_size = [0.02,0.01];
  // Initialize components for Routine "jitter_settings"
  jitter_settingsClock = new util.Clock();
  // Run 'Begin Experiment' code from code_jitter
  //// Load, Shuffle & Store jitter times
  // Load jitter file
  jitterList = new TrialHandler({
      psychoJS: psychoJS,
      nReps: 1, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: "DelayJitter/DelayJitter.csv",
      seed: undefined, name: 'jitterList'
  });
  // Shuffle jitter
  rand_i = 0;
  jitter = [];
  N_jitter = jitterList.trialList.length;
  n = jitterList.trialList.length;
  for (var i = 0, _pj_a = N_jitter; (i < _pj_a); i += 1) {
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
  
  // Initialize components for Routine "mobile_instructions"
  mobile_instructionsClock = new util.Clock();
  textbox_mobile_instructions = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_mobile_instructions',
    text: '',
    font: 'Arial',
    pos: [0, 0.15], letterHeight: 0.035,
    size: [0.95, 0.5],  units: undefined, 
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
  
  image_tiltphone = new visual.ImageStim({
    win : psychoJS.window,
    name : 'image_tiltphone', units : undefined, 
    image : 'buttons/tilt_phone.png', mask : undefined,
    ori : 0.0, pos : [0, (- 0.1)], size : [0.15, 0.15],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -2.0 
  });
  mouse_mobilephone = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_mobilephone.mouseClock = new util.Clock();
  polygon_continuebutton1 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_continuebutton1', 
    width: continuebutton_size[0], height: continuebutton_size[1],
    ori: 0.0, pos: [0, 0],
    lineWidth: continuebutton_edgethickness, 
    colorSpace: 'rgb',
    lineColor: new util.Color(continuebutton_bordercolor),
    fillColor: new util.Color(continuebutton_fillcolor),
    opacity: undefined, depth: -4, interpolate: true,
  });
  
  textbox_continuebutton1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_continuebutton1',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: 0.03,
    size: continuebutton_size,  units: undefined, 
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
  
  textbox_sourceicon = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_sourceicon',
    text: 'Icon from https://icons8.com',
    font: 'Arial',
    pos: [0, 0], letterHeight: 0.015,
    size: [0.2, 0.03],  units: undefined, 
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
    depth: -6.0 
  });
  
  // Initialize components for Routine "instructions"
  instructionsClock = new util.Clock();
  textbox_instructions = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_instructions',
    text: '',
    font: 'Arial',
    pos: [0, 0.1], letterHeight: 0.035,
    size: [0.9, 0.7],  units: undefined, 
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
    depth: -1.0 
  });
  
  mouse_instructions = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_instructions.mouseClock = new util.Clock();
  polygon_continuebutton = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_continuebutton', 
    width: continuebutton_size[0], height: continuebutton_size[1],
    ori: 0.0, pos: [0, 0],
    lineWidth: continuebutton_edgethickness, 
    colorSpace: 'rgb',
    lineColor: new util.Color(continuebutton_bordercolor),
    fillColor: new util.Color(continuebutton_fillcolor),
    opacity: 1.0, depth: -3, interpolate: true,
  });
  
  textbox_continuebutton = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_continuebutton',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: 0.04,
    size: continuebutton_size,  units: undefined, 
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
    depth: -4.0 
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
    pos: [0, 0], letterHeight: slidertext_letter_height,
    size: [0.5, 0.5],  units: undefined, 
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
    depth: -1.0 
  });
  
  textbox_activitytext = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_activitytext',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: activitytext_letter_height,
    size: [0.65, 0.5],  units: undefined, 
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
    depth: -2.0 
  });
  
  textbox_l01 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l01',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: label_letter_height,
    size: label_size,  units: undefined, 
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
    depth: -3.0 
  });
  
  textbox_l02 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l02',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: label_letter_height,
    size: label_size,  units: undefined, 
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
    depth: -4.0 
  });
  
  textbox_l03 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l03',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: label_letter_height,
    size: label_size,  units: undefined, 
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
  
  textbox_l04 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l04',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: label_letter_height,
    size: label_size,  units: undefined, 
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
    depth: -6.0 
  });
  
  textbox_l05 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l05',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: label_letter_height,
    size: label_size,  units: undefined, 
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
    depth: -7.0 
  });
  
  textbox_l06 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l06',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: label_letter_height,
    size: label_size,  units: undefined, 
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
    depth: -8.0 
  });
  
  textbox_l07 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l07',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: label_letter_height,
    size: label_size,  units: undefined, 
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
    depth: -9.0 
  });
  
  textbox_l08 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l08',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: label_letter_height,
    size: label_size,  units: undefined, 
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
    depth: -10.0 
  });
  
  textbox_l09 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l09',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: label_letter_height,
    size: label_size,  units: undefined, 
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
    depth: -11.0 
  });
  
  textbox_l10 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l10',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: label_letter_height,
    size: label_size,  units: undefined, 
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
    depth: -12.0 
  });
  
  textbox_l11 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_l11',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: label_letter_height,
    size: label_size,  units: undefined, 
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
    depth: -13.0 
  });
  
  t01 = new visual.ShapeStim ({
    win: psychoJS.window, name: 't01', 
    vertices: [[-tick_size[0]/2.0, 0], [+tick_size[0]/2.0, 0]],
    ori: 0.0, pos: [0, 0],
    lineWidth: 1.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('black'),
    fillColor: new util.Color('black'),
    opacity: undefined, depth: -14, interpolate: true,
  });
  
  t02 = new visual.ShapeStim ({
    win: psychoJS.window, name: 't02', 
    vertices: [[-tick_size[0]/2.0, 0], [+tick_size[0]/2.0, 0]],
    ori: 0.0, pos: [0, 0],
    lineWidth: 1.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('black'),
    fillColor: new util.Color('black'),
    opacity: undefined, depth: -15, interpolate: true,
  });
  
  t03 = new visual.ShapeStim ({
    win: psychoJS.window, name: 't03', 
    vertices: [[-tick_size[0]/2.0, 0], [+tick_size[0]/2.0, 0]],
    ori: 0.0, pos: [0, 0],
    lineWidth: 1.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('black'),
    fillColor: new util.Color('black'),
    opacity: undefined, depth: -16, interpolate: true,
  });
  
  t04 = new visual.ShapeStim ({
    win: psychoJS.window, name: 't04', 
    vertices: [[-tick_size[0]/2.0, 0], [+tick_size[0]/2.0, 0]],
    ori: 0.0, pos: [0, 0],
    lineWidth: 1.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('black'),
    fillColor: new util.Color('black'),
    opacity: undefined, depth: -17, interpolate: true,
  });
  
  t05 = new visual.ShapeStim ({
    win: psychoJS.window, name: 't05', 
    vertices: [[-tick_size[0]/2.0, 0], [+tick_size[0]/2.0, 0]],
    ori: 0.0, pos: [0, 0],
    lineWidth: 1.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('black'),
    fillColor: new util.Color('black'),
    opacity: undefined, depth: -18, interpolate: true,
  });
  
  t06 = new visual.ShapeStim ({
    win: psychoJS.window, name: 't06', 
    vertices: [[-tick_size[0]/2.0, 0], [+tick_size[0]/2.0, 0]],
    ori: 0.0, pos: [0, 0],
    lineWidth: 1.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('black'),
    fillColor: new util.Color('black'),
    opacity: undefined, depth: -19, interpolate: true,
  });
  
  t07 = new visual.ShapeStim ({
    win: psychoJS.window, name: 't07', 
    vertices: [[-tick_size[0]/2.0, 0], [+tick_size[0]/2.0, 0]],
    ori: 0.0, pos: [0, 0],
    lineWidth: 1.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('black'),
    fillColor: new util.Color('black'),
    opacity: undefined, depth: -20, interpolate: true,
  });
  
  t08 = new visual.ShapeStim ({
    win: psychoJS.window, name: 't08', 
    vertices: [[-tick_size[0]/2.0, 0], [+tick_size[0]/2.0, 0]],
    ori: 0.0, pos: [0, 0],
    lineWidth: 1.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('black'),
    fillColor: new util.Color('black'),
    opacity: undefined, depth: -21, interpolate: true,
  });
  
  t09 = new visual.ShapeStim ({
    win: psychoJS.window, name: 't09', 
    vertices: [[-tick_size[0]/2.0, 0], [+tick_size[0]/2.0, 0]],
    ori: 0.0, pos: [0, 0],
    lineWidth: 1.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('black'),
    fillColor: new util.Color('black'),
    opacity: undefined, depth: -22, interpolate: true,
  });
  
  t10 = new visual.ShapeStim ({
    win: psychoJS.window, name: 't10', 
    vertices: [[-tick_size[0]/2.0, 0], [+tick_size[0]/2.0, 0]],
    ori: 0.0, pos: [0, 0],
    lineWidth: 1.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('black'),
    fillColor: new util.Color('black'),
    opacity: undefined, depth: -23, interpolate: true,
  });
  
  t11 = new visual.ShapeStim ({
    win: psychoJS.window, name: 't11', 
    vertices: [[-tick_size[0]/2.0, 0], [+tick_size[0]/2.0, 0]],
    ori: 0.0, pos: [0, 0],
    lineWidth: 1.0, 
    colorSpace: 'rgb',
    lineColor: new util.Color('black'),
    fillColor: new util.Color('black'),
    opacity: undefined, depth: -24, interpolate: true,
  });
  
  slider = new visual.Slider({
    win: psychoJS.window, name: 'slider',
    startValue: undefined,
    size: 1.0, pos: [0, 0], ori: 180.0, units: 'height',
    labels: undefined, fontSize: 0.05, ticks: [0, 100],
    granularity: 0.0, style: ["SLIDER"],
    color: new util.Color([0.9, 0.9, 0.9]), markerColor: new util.Color([(- 1.0), (- 1.0), 0.0902]), lineColor: new util.Color([0.9, 0.9, 0.9]), 
    opacity: undefined, fontFamily: 'Open Sans', bold: true, italic: false, depth: -25, 
    flip: false,
  });
  
  textbox_reaction_reminder = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_reaction_reminder',
    text: '',
    font: 'Arial',
    pos: [0, 0], letterHeight: 0.03,
    size: [0.5, 0.3],  units: undefined, 
    color: [0.0902, (- 1.0), (- 1.0)], colorSpace: 'rgb',
    fillColor: undefined, borderColor: undefined,
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -26.0 
  });
  
  polygon_submitbutton = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbutton', 
    width: submitbutton_size[0], height: submitbutton_size[1],
    ori: 0.0, pos: [0, 0],
    lineWidth: submitbutton_edgethickness, 
    colorSpace: 'rgb',
    lineColor: new util.Color(submitbutton_bordercolor),
    fillColor: new util.Color(submitbutton_fillcolor),
    opacity: 1.0, depth: -27, interpolate: true,
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
    depth: -28.0 
  });
  
  mouse_nextTrial = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_nextTrial.mouseClock = new util.Clock();
  // Initialize components for Routine "end"
  endClock = new util.Clock();
  textbox_end = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_end',
    text: '',
    font: 'Arial',
    pos: [0, 0.1], letterHeight: 0.05,
    size: [0.8, 0.5],  units: undefined, 
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
var pos_sourcetext;
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
    // Set variable size elements
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = (window_width / window_height);
    yrange = (window_height / window_width);
    last_xrange = xrange;
    pos_sourcetext = [0.3*Math.max(1,xrange), -0.48*Math.max(1,yrange)];
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
    
    // Set variable size elements
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = (window_width / window_height);
    if(xrange != last_xrange){
        // Size changed
        last_xrange = xrange;
        yrange = (window_height / window_width);
        pos_sourcetext = [0.3*Math.max(1,xrange), -0.48*Math.max(1,yrange)];
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
      textbox_sourceflag.setPos(pos_sourcetext, false);
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


var mobile_instructions_text;
var instructions_text;
var continuebutton_text;
var stimulus_text;
var l01;
var l02;
var l03;
var l04;
var l05;
var l06;
var l07;
var l08;
var l09;
var l10;
var l11;
var reminder_text_liking;
var submitbutton_text;
var enforceLandscape_text;
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
        // mobile_instructions routine
        mobile_instructions_text = "Falls Sie das Experiment an einem Mobilger\u00e4t durchf\u00fchren, verwenden Sie bitte das Querformat und bleiben Sie bitte im Vollbildmodus. Andernfalls kann es zu Darstellungsfehlern kommen.\nSie k\u00f6nnen fortfahren, wenn Ihr Mobiltelefon im Querformat ist."; 
        // instructions routine
        instructions_text = "Willkommen! \n\nIm Folgenden bitten wir Sie, einige Freizeitaktivitäten zu bewerten. Bitte geben Sie jeweils an, wie gern Sie die angezeigte Freizeitaktivität im Vergleich zu allen Ihnen vorstellbaren Freizeitaktivitäten mögen. Sollten Sie die angezeigte Aktivität noch nie gemacht haben, schätzen Sie bitte, wie sehr Sie die Aktivität mögen würden. \n\nUm Ihre Antworten einzugeben, können Sie einen Regler über eine Skala verschieben. Danach können Sie Ihre Eingabe bestätigen.";
        continuebutton_text = "Klicken Sie hier, wenn Sie die Instruktionen gelesen haben";
        // stimulus_rating routine
        stimulus_text = "Bitte bewerten Sie wie gern Sie die folgende Freizeitaktivit\u00e4t im Vergleich zu allen Ihnen vorstellbaren Freizeitaktivit\u00e4ten m\u00f6gen: ";
        l01 = "am allerst\u00e4rksten \ngemochte Aktivit\u00e4t, \ndie vorstellbar ist";
        l02 = "extrem gern";
        l03 = "sehr gern";
        l04 = "gern";
        l05 = "ein bisschen gern";
        l06 = "neutral";
        l07 = "ein bisschen ungern";
        l08 = "ungern";
        l09 = "sehr ungern";
        l10 = "extrem ungern";
        l11 = "am allerst\u00e4rksten \nzuwidere Aktivit\u00e4t, \ndie vorstellbar ist";
        reminder_text_liking = 'Bitte geben Sie \u00fcber den Slider eine Reaktion ab, um fortfahren zu k\u00f6nnen!';
        submitbutton_text = "Weiter";
        enforceLandscape_text = "Bitte wechseln Sie ins Querformat.";
        // end routine
        end_text = "Das Experiment ist nun beendet.\nVielen Dank f\u00fcr Ihre Teilnahme.";
        end_text2 = "Bitte schliessen Sie das Experiment nicht bevor das Fenster mit der Nachricht 'Thank you for your patience.' erscheint. \nDies kann einen Moment dauern.";
    } else {
        // mobile_instructions routine
        mobile_instructions_text = "If you are conducting the experiment on a mobile device, please use landscape format and stay in full screen mode. Otherwise, display problems may occur.\nYou can continue if your device is in landscape format.";
        // instructions routine
        instructions_text =  "Welcome! \n\nWe will now ask you to rate some free time activities. Please indicate how much you like the displayed free time activity in comparison with all of the imaginable free time activities. In case you have never done the displayed activity, please estimate how much you would like the activity. \n\nTo answer the questions, you can move the point on the scale. After this you can confirm your selection.";
        continuebutton_text = "Click here when you have read the instructions";
        // stimulus_rating routine
        stimulus_text = "Please rate how much you like the following free time activity in comparison with all of the imaginable free time activities: ";
        l01 = "most liked activity \nimaginable";
        l02 = "like extremely";
        l03 = "like very much";
        l04 = "like moderately";
        l05 = "like slightly";
        l06 = "neutral";
        l07 = "slightly dislike";
        l08 = "moderately dislike";
        l09 = "dislike very much";
        l10 = "extremely dislike";
        l11 = "most disliked activity \nimaginable";
        reminder_text_liking = 'Please give a reaction via the slider to be able to continue!';
        submitbutton_text = "Submit";
        enforceLandscape_text = "Please change to landscape format.";
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


var continuebutton_xy;
var mobile_instructionsComponents;
function mobile_instructionsRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'mobile_instructions' ---
    t = 0;
    mobile_instructionsClock.reset(); // clock
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    // update component parameters for each repeat
    // Since tablet detection does not work properly, we at least want to include 
    // people in the mobile-device-group who hold their device in portrait format
    // (likely not using a PC or notebook)
    if(!mobile_device){
        window_height = window.innerHeight;
        window_width = window.innerWidth;
        if (window_height > window_width){
            mobile_device = true;
        }
    }
    // Skip if no mobile device was detected
    if (!mobile_device){
        continueRoutine = false;
    }
    // Set variable size elements
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = window_width/window_height;
    last_xrange = xrange;
    yrange = window_height/window_width;
    continuebutton_xy = [0,-0.3*Math.max(1,Math.sqrt(yrange))];
    pos_sourcetext = [0.3*Math.max(1,xrange), -0.48*Math.max(1,yrange)];
    textbox_mobile_instructions.setText(mobile_instructions_text);
    // setup some python lists for storing info about the mouse_mobilephone
    mouse_mobilephone.clicked_name = [];
    gotValidClick = false; // until a click is received
    textbox_continuebutton1.setText(continuebutton_text);
    // keep track of which components have finished
    mobile_instructionsComponents = [];
    mobile_instructionsComponents.push(textbox_mobile_instructions);
    mobile_instructionsComponents.push(image_tiltphone);
    mobile_instructionsComponents.push(mouse_mobilephone);
    mobile_instructionsComponents.push(polygon_continuebutton1);
    mobile_instructionsComponents.push(textbox_continuebutton1);
    mobile_instructionsComponents.push(textbox_sourceicon);
    
    for (const thisComponent of mobile_instructionsComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


function mobile_instructionsRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'mobile_instructions' ---
    // get current time
    t = mobile_instructionsClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Set variable size elements
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = window_width/window_height;
    if (xrange != last_xrange){
        // Size changed
        last_xrange = xrange;
        yrange = window_height/window_width;
        continuebutton_xy = [0,-0.3*Math.max(1,Math.sqrt(yrange))];
        pos_sourcetext = [0.3*Math.max(1,xrange), -0.48*Math.max(1,yrange)];
    }
    
    // *textbox_mobile_instructions* updates
    if (t >= 0.0 && textbox_mobile_instructions.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_mobile_instructions.tStart = t;  // (not accounting for frame time here)
      textbox_mobile_instructions.frameNStart = frameN;  // exact frame index
      
      textbox_mobile_instructions.setAutoDraw(true);
    }

    
    // *image_tiltphone* updates
    if (t >= 0.0 && image_tiltphone.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      image_tiltphone.tStart = t;  // (not accounting for frame time here)
      image_tiltphone.frameNStart = frameN;  // exact frame index
      
      image_tiltphone.setAutoDraw(true);
    }

    // *mouse_mobilephone* updates
    if (t >= 0.0 && mouse_mobilephone.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_mobilephone.tStart = t;  // (not accounting for frame time here)
      mouse_mobilephone.frameNStart = frameN;  // exact frame index
      
      mouse_mobilephone.status = PsychoJS.Status.STARTED;
      mouse_mobilephone.mouseClock.reset();
      prevButtonState = mouse_mobilephone.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_mobilephone.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_mobilephone.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [polygon_continuebutton1,]) {
            if (obj.contains(mouse_mobilephone)) {
              gotValidClick = true;
              mouse_mobilephone.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
    }
    
    // *polygon_continuebutton1* updates
    if (t >= 0.0 && polygon_continuebutton1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_continuebutton1.tStart = t;  // (not accounting for frame time here)
      polygon_continuebutton1.frameNStart = frameN;  // exact frame index
      
      polygon_continuebutton1.setAutoDraw(true);
    }

    
    if (polygon_continuebutton1.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_continuebutton1.setPos(continuebutton_xy, false);
    }
    
    // *textbox_continuebutton1* updates
    if (t >= 0.0 && textbox_continuebutton1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_continuebutton1.tStart = t;  // (not accounting for frame time here)
      textbox_continuebutton1.frameNStart = frameN;  // exact frame index
      
      textbox_continuebutton1.setAutoDraw(true);
    }

    
    if (textbox_continuebutton1.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_continuebutton1.setPos(continuebutton_xy, false);
    }
    
    // *textbox_sourceicon* updates
    if (t >= 0.0 && textbox_sourceicon.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_sourceicon.tStart = t;  // (not accounting for frame time here)
      textbox_sourceicon.frameNStart = frameN;  // exact frame index
      
      textbox_sourceicon.setAutoDraw(true);
    }

    
    if (textbox_sourceicon.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_sourceicon.setPos(pos_sourcetext, false);
    }
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    for (const thisComponent of mobile_instructionsComponents)
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


function mobile_instructionsRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'mobile_instructions' ---
    for (const thisComponent of mobile_instructionsComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "mobile_instructions" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


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
    // Set variable size elements
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = window_width/window_height;
    last_xrange = xrange;
    yrange = window_height/window_width;
    continuebutton_xy = [0,-0.3*Math.max(1,Math.sqrt(yrange))];
    textbox_instructions.setText(instructions_text);
    // setup some python lists for storing info about the mouse_instructions
    mouse_instructions.clicked_name = [];
    gotValidClick = false; // until a click is received
    textbox_continuebutton.setText(continuebutton_text);
    // keep track of which components have finished
    instructionsComponents = [];
    instructionsComponents.push(textbox_instructions);
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
    
    // Set variable size elements
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = window_width/window_height;
    if (xrange != last_xrange){
        // Size changed
        last_xrange = xrange;
        yrange = window_height/window_width;
        continuebutton_xy = [0,-0.3*Math.max(1,Math.sqrt(yrange))];
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
      polygon_continuebutton.setPos(continuebutton_xy, false);
    }
    
    // *textbox_continuebutton* updates
    if (t >= 0.0 && textbox_continuebutton.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_continuebutton.tStart = t;  // (not accounting for frame time here)
      textbox_continuebutton.frameNStart = frameN;  // exact frame index
      
      textbox_continuebutton.setAutoDraw(true);
    }

    
    if (textbox_continuebutton.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_continuebutton.setPos(continuebutton_xy, false);
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
      nReps: 1, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: 'stimuli/activities.csv',
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


var activityCol;
var activity;
var activityID;
var activity_text;
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
    // Set fixation duration
    fixation_duration = ISI + jitter[idx];
    
    // Define trial content
    if ((languagechoice === "ger")) {
        activityCol = "activityGer";
    } else {
        activityCol = "activityUK";
    }   
    activity = trials.trialList[idx][activityCol];
    activityID = trials.trialList[idx]["activityID"];
    activity_text = activity;
    
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
    
    // Save trial data
    expInfo['activityID'] = activityID
    expInfo['fixation_dur'] = fixation_duration;
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


var ratingGiven;
var slidertext_xy;
var activitytext_xy;
var submitbutton_xy;
var reminder_xy;
var slider_liking_center_x;
var slider_liking_center_y;
var slider_liking_w;
var slider_liking_h;
var slider_size;
var slider_xy;
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
var tick_shift;
var tick01_pos;
var tick02_pos;
var tick03_pos;
var tick04_pos;
var tick05_pos;
var tick06_pos;
var tick07_pos;
var tick08_pos;
var tick09_pos;
var tick10_pos;
var tick11_pos;
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
    ratingGiven = false //track if ratings have been given to slider
    
    // Set variable size elements
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = window_width/window_height;
    last_xrange = xrange;
    yrange = window_height/window_width;
    
    slidertext_xy = [-0.45*Math.max(1,Math.sqrt(xrange)), 0.35*Math.max(1,Math.sqrt(yrange))];
    activitytext_xy = [-0.45*Math.max(1,Math.sqrt(xrange)), 0.15*Math.max(1,Math.sqrt(yrange))];
    submitbutton_xy = [-0.2*Math.max(1,Math.sqrt(xrange)), -0.3*Math.max(1,Math.sqrt(yrange))];
    reminder_xy = [-0.2*Math.max(1,Math.sqrt(xrange)), -0.15*Math.max(1,Math.sqrt(yrange))];
    
    slider_liking_center_x = 0.17*Math.max(1,Math.sqrt(xrange));
    slider_liking_center_y = 0;
    slider_liking_w = 0.04*Math.max(1,Math.sqrt(xrange));
    slider_liking_h = 0.8*Math.max(1,Math.sqrt(yrange));
    slider_size = [slider_liking_w,slider_liking_h];
    slider_xy = [slider_liking_center_x,slider_liking_center_y];
    label_xpos = slider_liking_center_x + slider_liking_w/2 + tick_size[0]/2 + 0.01;//(slider_liking_center_x + slider_liking_w + 0.25);
    l01_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[10]) / 100));
    l02_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[9]) / 100));
    l03_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[8]) / 100));
    l04_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[7]) / 100));
    l05_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[6]) / 100));
    l06_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[5]) / 100));
    l07_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[4]) / 100));
    l08_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[3]) / 100));
    l09_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[2]) / 100));
    l10_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[1]) / 100));
    l11_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[0]) / 100));
    l01_pos = [label_xpos, l01_ypos];
    l02_pos = [label_xpos, l02_ypos];
    l03_pos = [label_xpos, l03_ypos];
    l04_pos = [label_xpos, l04_ypos];
    l05_pos = [label_xpos, l05_ypos];
    l06_pos = [slider_liking_center_x - (slider_liking_w/2 + tick_size[0]/2 + 0.01),l06_ypos];// label "neutral" on the left of the slider
    l07_pos = [label_xpos, l07_ypos];
    l08_pos = [label_xpos, l08_ypos];
    l09_pos = [label_xpos, l09_ypos];
    l10_pos = [label_xpos, l10_ypos];
    l11_pos = [label_xpos, l11_ypos];
    tick_shift = slider_liking_w/2;
    tick01_pos = [slider_liking_center_x + tick_shift, l01_ypos];
    tick02_pos = [slider_liking_center_x + tick_shift, l02_ypos];
    tick03_pos = [slider_liking_center_x + tick_shift, l03_ypos];
    tick04_pos = [slider_liking_center_x + tick_shift, l04_ypos];
    tick05_pos = [slider_liking_center_x + tick_shift, l05_ypos];
    tick06_pos = [slider_liking_center_x - tick_shift, l06_ypos];
    tick07_pos = [slider_liking_center_x + tick_shift, l07_ypos];
    tick08_pos = [slider_liking_center_x + tick_shift, l08_ypos];
    tick09_pos = [slider_liking_center_x + tick_shift, l09_ypos];
    tick10_pos = [slider_liking_center_x + tick_shift, l10_ypos];
    tick11_pos = [slider_liking_center_x + tick_shift, l11_ypos];
    textbox_slidertext.setText(stimulus_text);
    textbox_activitytext.setText(activity_text);
    textbox_l01.setText(l01);
    textbox_l02.setText(l02);
    textbox_l03.setText(l03);
    textbox_l04.setText(l04);
    textbox_l05.setText(l05);
    textbox_l06.setText(l06);
    textbox_l07.setText(l07);
    textbox_l08.setText(l08);
    textbox_l09.setText(l09);
    textbox_l10.setText(l10);
    textbox_l11.setText(l11);
    slider.reset()
    textbox_submitbutton.setText(submitbutton_text);
    // setup some python lists for storing info about the mouse_nextTrial
    mouse_nextTrial.clicked_name = [];
    gotValidClick = false; // until a click is received
    // keep track of which components have finished
    stimulus_ratingComponents = [];
    stimulus_ratingComponents.push(textbox_slidertext);
    stimulus_ratingComponents.push(textbox_activitytext);
    stimulus_ratingComponents.push(textbox_l01);
    stimulus_ratingComponents.push(textbox_l02);
    stimulus_ratingComponents.push(textbox_l03);
    stimulus_ratingComponents.push(textbox_l04);
    stimulus_ratingComponents.push(textbox_l05);
    stimulus_ratingComponents.push(textbox_l06);
    stimulus_ratingComponents.push(textbox_l07);
    stimulus_ratingComponents.push(textbox_l08);
    stimulus_ratingComponents.push(textbox_l09);
    stimulus_ratingComponents.push(textbox_l10);
    stimulus_ratingComponents.push(textbox_l11);
    stimulus_ratingComponents.push(t01);
    stimulus_ratingComponents.push(t02);
    stimulus_ratingComponents.push(t03);
    stimulus_ratingComponents.push(t04);
    stimulus_ratingComponents.push(t05);
    stimulus_ratingComponents.push(t06);
    stimulus_ratingComponents.push(t07);
    stimulus_ratingComponents.push(t08);
    stimulus_ratingComponents.push(t09);
    stimulus_ratingComponents.push(t10);
    stimulus_ratingComponents.push(t11);
    stimulus_ratingComponents.push(slider);
    stimulus_ratingComponents.push(textbox_reaction_reminder);
    stimulus_ratingComponents.push(polygon_submitbutton);
    stimulus_ratingComponents.push(textbox_submitbutton);
    stimulus_ratingComponents.push(mouse_nextTrial);
    
    for (const thisComponent of stimulus_ratingComponents)
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
    return Scheduler.Event.NEXT;
  }
}


var cond_submitbutton;
var cond_reaction_reminder_text;
function stimulus_ratingRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'stimulus_rating' ---
    // get current time
    t = stimulus_ratingClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Run 'Each Frame' code from code_updateState
    // check if rating has been given before allowing the participant to press submit
    if (slider.getRating() != null){
        ratingGiven = true;
    }
    
    // Continuebutton display conditions
    cond_submitbutton = ratingGiven;
    // Remindertext appearance condition
    cond_reaction_reminder_text = ((! ratingGiven) && (t >= 10));
    
    // Hovereffect for submitbutton
    if (!mobile_device){
        if (polygon_submitbutton.contains(mouse_nextTrial)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    
    // Set variable size elements
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = window_width/window_height;
    if (xrange != last_xrange){
        // Size changed
        last_xrange = xrange;
        yrange = window_height/window_width;
        
        slidertext_xy = [-0.45*Math.max(1,Math.sqrt(xrange)), 0.35*Math.max(1,Math.sqrt(yrange))];
        activitytext_xy = [-0.45*Math.max(1,Math.sqrt(xrange)), 0.15*Math.max(1,Math.sqrt(yrange))];
        submitbutton_xy = [-0.2*Math.max(1,Math.sqrt(xrange)), -0.3*Math.max(1,Math.sqrt(yrange))];
        reminder_xy = [-0.2*Math.max(1,Math.sqrt(xrange)), -0.15*Math.max(1,Math.sqrt(yrange))];
        
        slider_liking_center_x = 0.17*Math.max(1,Math.sqrt(xrange));
        slider_liking_center_y = 0;
        slider_liking_w = 0.04*Math.max(1,Math.sqrt(xrange));
        slider_liking_h = 0.8*Math.max(1,Math.sqrt(yrange));
        slider_size = [slider_liking_w,slider_liking_h];
        slider_xy = [slider_liking_center_x,slider_liking_center_y];
        label_xpos = slider_liking_center_x + slider_liking_w/2 + tick_size[0]/2 + 0.01;//(slider_liking_center_x + slider_liking_w + 0.25);
        l01_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[10]) / 100));
        l02_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[9]) / 100));
        l03_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[8]) / 100));
        l04_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[7]) / 100));
        l05_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[6]) / 100));
        l06_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[5]) / 100));
        l07_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[4]) / 100));
        l08_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[3]) / 100));
        l09_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[2]) / 100));
        l10_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[1]) / 100));
        l11_ypos = (slider_liking_center_y + (((slider_liking_h / 2) * slider_liking_ticks[0]) / 100));
        l01_pos = [label_xpos, l01_ypos];
        l02_pos = [label_xpos, l02_ypos];
        l03_pos = [label_xpos, l03_ypos];
        l04_pos = [label_xpos, l04_ypos];
        l05_pos = [label_xpos, l05_ypos];
        l06_pos = [slider_liking_center_x - (slider_liking_w/2 + tick_size[0]/2 + 0.01),l06_ypos];//[(slider_liking_center_x - 2*slider_liking_w), l06_ypos]; // label "neutral" on the left of the slider
        l07_pos = [label_xpos, l07_ypos];
        l08_pos = [label_xpos, l08_ypos];
        l09_pos = [label_xpos, l09_ypos];
        l10_pos = [label_xpos, l10_ypos];
        l11_pos = [label_xpos, l11_ypos];
        tick_shift = slider_liking_w/2;
        tick01_pos = [slider_liking_center_x + tick_shift, l01_ypos];
        tick02_pos = [slider_liking_center_x + tick_shift, l02_ypos];
        tick03_pos = [slider_liking_center_x + tick_shift, l03_ypos];
        tick04_pos = [slider_liking_center_x + tick_shift, l04_ypos];
        tick05_pos = [slider_liking_center_x + tick_shift, l05_ypos];
        tick06_pos = [slider_liking_center_x - tick_shift, l06_ypos];
        tick07_pos = [slider_liking_center_x + tick_shift, l07_ypos];
        tick08_pos = [slider_liking_center_x + tick_shift, l08_ypos];
        tick09_pos = [slider_liking_center_x + tick_shift, l09_ypos];
        tick10_pos = [slider_liking_center_x + tick_shift, l10_ypos];
        tick11_pos = [slider_liking_center_x + tick_shift, l11_ypos];
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
    }
    
    // *textbox_l01* updates
    if (t >= 0.0 && textbox_l01.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l01.tStart = t;  // (not accounting for frame time here)
      textbox_l01.frameNStart = frameN;  // exact frame index
      
      textbox_l01.setAutoDraw(true);
    }

    
    if (textbox_l01.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_l01.setPos(l01_pos, false);
    }
    
    // *textbox_l02* updates
    if (t >= 0.0 && textbox_l02.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l02.tStart = t;  // (not accounting for frame time here)
      textbox_l02.frameNStart = frameN;  // exact frame index
      
      textbox_l02.setAutoDraw(true);
    }

    
    if (textbox_l02.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_l02.setPos(l02_pos, false);
    }
    
    // *textbox_l03* updates
    if (t >= 0.0 && textbox_l03.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l03.tStart = t;  // (not accounting for frame time here)
      textbox_l03.frameNStart = frameN;  // exact frame index
      
      textbox_l03.setAutoDraw(true);
    }

    
    if (textbox_l03.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_l03.setPos(l03_pos, false);
    }
    
    // *textbox_l04* updates
    if (t >= 0.0 && textbox_l04.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l04.tStart = t;  // (not accounting for frame time here)
      textbox_l04.frameNStart = frameN;  // exact frame index
      
      textbox_l04.setAutoDraw(true);
    }

    
    if (textbox_l04.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_l04.setPos(l04_pos, false);
    }
    
    // *textbox_l05* updates
    if (t >= 0.0 && textbox_l05.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l05.tStart = t;  // (not accounting for frame time here)
      textbox_l05.frameNStart = frameN;  // exact frame index
      
      textbox_l05.setAutoDraw(true);
    }

    
    if (textbox_l05.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_l05.setPos(l05_pos, false);
    }
    
    // *textbox_l06* updates
    if (t >= 0.0 && textbox_l06.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l06.tStart = t;  // (not accounting for frame time here)
      textbox_l06.frameNStart = frameN;  // exact frame index
      
      textbox_l06.setAutoDraw(true);
    }

    
    if (textbox_l06.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_l06.setPos(l06_pos, false);
    }
    
    // *textbox_l07* updates
    if (t >= 0.0 && textbox_l07.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l07.tStart = t;  // (not accounting for frame time here)
      textbox_l07.frameNStart = frameN;  // exact frame index
      
      textbox_l07.setAutoDraw(true);
    }

    
    if (textbox_l07.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_l07.setPos(l07_pos, false);
    }
    
    // *textbox_l08* updates
    if (t >= 0.0 && textbox_l08.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l08.tStart = t;  // (not accounting for frame time here)
      textbox_l08.frameNStart = frameN;  // exact frame index
      
      textbox_l08.setAutoDraw(true);
    }

    
    if (textbox_l08.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_l08.setPos(l08_pos, false);
    }
    
    // *textbox_l09* updates
    if (t >= 0.0 && textbox_l09.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l09.tStart = t;  // (not accounting for frame time here)
      textbox_l09.frameNStart = frameN;  // exact frame index
      
      textbox_l09.setAutoDraw(true);
    }

    
    if (textbox_l09.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_l09.setPos(l09_pos, false);
    }
    
    // *textbox_l10* updates
    if (t >= 0.0 && textbox_l10.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l10.tStart = t;  // (not accounting for frame time here)
      textbox_l10.frameNStart = frameN;  // exact frame index
      
      textbox_l10.setAutoDraw(true);
    }

    
    if (textbox_l10.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_l10.setPos(l10_pos, false);
    }
    
    // *textbox_l11* updates
    if (t >= 0.0 && textbox_l11.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_l11.tStart = t;  // (not accounting for frame time here)
      textbox_l11.frameNStart = frameN;  // exact frame index
      
      textbox_l11.setAutoDraw(true);
    }

    
    if (textbox_l11.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_l11.setPos(l11_pos, false);
    }
    
    // *t01* updates
    if (t >= 0.0 && t01.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      t01.tStart = t;  // (not accounting for frame time here)
      t01.frameNStart = frameN;  // exact frame index
      
      t01.setAutoDraw(true);
    }

    
    if (t01.status === PsychoJS.Status.STARTED){ // only update if being drawn
      t01.setPos(tick01_pos, false);
    }
    
    // *t02* updates
    if (t >= 0.0 && t02.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      t02.tStart = t;  // (not accounting for frame time here)
      t02.frameNStart = frameN;  // exact frame index
      
      t02.setAutoDraw(true);
    }

    
    if (t02.status === PsychoJS.Status.STARTED){ // only update if being drawn
      t02.setPos(tick02_pos, false);
    }
    
    // *t03* updates
    if (t >= 0.0 && t03.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      t03.tStart = t;  // (not accounting for frame time here)
      t03.frameNStart = frameN;  // exact frame index
      
      t03.setAutoDraw(true);
    }

    
    if (t03.status === PsychoJS.Status.STARTED){ // only update if being drawn
      t03.setPos(tick03_pos, false);
    }
    
    // *t04* updates
    if (t >= 0.0 && t04.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      t04.tStart = t;  // (not accounting for frame time here)
      t04.frameNStart = frameN;  // exact frame index
      
      t04.setAutoDraw(true);
    }

    
    if (t04.status === PsychoJS.Status.STARTED){ // only update if being drawn
      t04.setPos(tick04_pos, false);
    }
    
    // *t05* updates
    if (t >= 0.0 && t05.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      t05.tStart = t;  // (not accounting for frame time here)
      t05.frameNStart = frameN;  // exact frame index
      
      t05.setAutoDraw(true);
    }

    
    if (t05.status === PsychoJS.Status.STARTED){ // only update if being drawn
      t05.setPos(tick05_pos, false);
    }
    
    // *t06* updates
    if (t >= 0.0 && t06.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      t06.tStart = t;  // (not accounting for frame time here)
      t06.frameNStart = frameN;  // exact frame index
      
      t06.setAutoDraw(true);
    }

    
    if (t06.status === PsychoJS.Status.STARTED){ // only update if being drawn
      t06.setPos(tick06_pos, false);
    }
    
    // *t07* updates
    if (t >= 0.0 && t07.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      t07.tStart = t;  // (not accounting for frame time here)
      t07.frameNStart = frameN;  // exact frame index
      
      t07.setAutoDraw(true);
    }

    
    if (t07.status === PsychoJS.Status.STARTED){ // only update if being drawn
      t07.setPos(tick07_pos, false);
    }
    
    // *t08* updates
    if (t >= 0.0 && t08.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      t08.tStart = t;  // (not accounting for frame time here)
      t08.frameNStart = frameN;  // exact frame index
      
      t08.setAutoDraw(true);
    }

    
    if (t08.status === PsychoJS.Status.STARTED){ // only update if being drawn
      t08.setPos(tick08_pos, false);
    }
    
    // *t09* updates
    if (t >= 0.0 && t09.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      t09.tStart = t;  // (not accounting for frame time here)
      t09.frameNStart = frameN;  // exact frame index
      
      t09.setAutoDraw(true);
    }

    
    if (t09.status === PsychoJS.Status.STARTED){ // only update if being drawn
      t09.setPos(tick09_pos, false);
    }
    
    // *t10* updates
    if (t >= 0.0 && t10.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      t10.tStart = t;  // (not accounting for frame time here)
      t10.frameNStart = frameN;  // exact frame index
      
      t10.setAutoDraw(true);
    }

    
    if (t10.status === PsychoJS.Status.STARTED){ // only update if being drawn
      t10.setPos(tick10_pos, false);
    }
    
    // *t11* updates
    if (t >= 0.0 && t11.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      t11.tStart = t;  // (not accounting for frame time here)
      t11.frameNStart = frameN;  // exact frame index
      
      t11.setAutoDraw(true);
    }

    
    if (t11.status === PsychoJS.Status.STARTED){ // only update if being drawn
      t11.setPos(tick11_pos, false);
    }
    
    // *slider* updates
    if (t >= 0.0 && slider.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      slider.tStart = t;  // (not accounting for frame time here)
      slider.frameNStart = frameN;  // exact frame index
      
      slider.setAutoDraw(true);
    }

    
    if (slider.status === PsychoJS.Status.STARTED){ // only update if being drawn
      slider.setPos(slider_xy, false);
      slider.setSize(slider_size, false);
    }
    
    // *textbox_reaction_reminder* updates
    if ((cond_reaction_reminder_text) && textbox_reaction_reminder.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_reaction_reminder.tStart = t;  // (not accounting for frame time here)
      textbox_reaction_reminder.frameNStart = frameN;  // exact frame index
      
      textbox_reaction_reminder.setAutoDraw(true);
    }

    
    if (textbox_reaction_reminder.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_reaction_reminder.setPos(reminder_xy, false);
      textbox_reaction_reminder.setText(reminder_text_liking, false);
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
    // *mouse_nextTrial* updates
    if ((cond_submitbutton) && mouse_nextTrial.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_nextTrial.tStart = t;  // (not accounting for frame time here)
      mouse_nextTrial.frameNStart = frameN;  // exact frame index
      
      mouse_nextTrial.status = PsychoJS.Status.STARTED;
      mouse_nextTrial.mouseClock.reset();
      prevButtonState = [0, 0, 0];  // if now button is down we will treat as 'new' click
      }
    if (mouse_nextTrial.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_nextTrial.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          for (const obj of [polygon_submitbutton,]) {
            if (obj.contains(mouse_nextTrial)) {
              gotValidClick = true;
              mouse_nextTrial.clicked_name.push(obj.name)
            }
          }
          if (gotValidClick === true) { // abort routine on response
            continueRoutine = false;
          }
        }
      }
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


var rating;
function stimulus_ratingRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'stimulus_rating' ---
    for (const thisComponent of stimulus_ratingComponents) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    }
    // Save rating+RT
    rating = Math.round(slider.getRating());
    trials.addData("rating", rating);
    trials.addData("Trial_RT", t);
    
    // For Shelf:
    activity_ratings.push([activityID, rating]);
    psychoJS.experiment.addData('slider.response', slider.getRating());
    psychoJS.experiment.addData('slider.rt', slider.getRT());
    // store data for psychoJS.experiment (ExperimentHandler)
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
    // Write activity ratings to shelf "activity_ratings" 
    // Since the field is globally visible (Shelf->Scope->Designer) we have to specify that
    psychoJS.shelf.setDictionaryFieldValue({key: ["activity_ratings", "@designer"], fieldName: expInfo['participantID'], fieldValue : activity_ratings});
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
