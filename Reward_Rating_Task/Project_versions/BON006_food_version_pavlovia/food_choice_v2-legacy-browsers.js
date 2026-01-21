/*********************** 
 * Food_Choice_V2 *
 ***********************/


// store info about the experiment session:
let expName = 'food_choice_v2';  // from the Builder filename that created this script
let expInfo = {
    'participantID': 'me',
    'sessionID': '0',
};

// Start code blocks for 'Before Experiment'
// Coders hint: Always put a function definition in its own exclusive
// code-component in psychopy builder!
//
// Otherwise, when there is other code outside with variables of same name, then 
// the respective function variables wouldn't get the 'var' keyword when
// auto-translated to javascript! (and so wouldn't have function scope!)
// As a result they may very likely interfere with the outside variables.

// Fisher-Yates shuffle (reversed)

var n;
var prelast;
var i;
function shuffle_array(arr) {
    var i, j, n, prelast;
    n = arr.length;
    prelast = (n - 2); // second last element is at index n-2 if we start at 0
    i = 0;
    while ((i <= prelast)) {
        // random(): 0.0 <= x < 1
        // random integer such that i ≤ j ≤ n-1
        j = Number.parseInt((i + (Math.random() * (n - i))));
        [arr[i], arr[j]] = [arr[j], arr[i]];
        i += 1;
    }
    return arr.slice(0); // return a real copy, not a reference!
}

// Run 'Before Experiment' code from code_expInfoHandling
// the studyID is initiated here in order to make it available
// for the filename
const studyID = "BON006";


function printImgSet(arr) {
    console.log("showing Array for debugging")
    for (let i=0; i<arr.length; i++) {
        console.log(arr[i][0])
    }
}
let imgSet = []; // the images used for the choice task
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
flowScheduler.add(shelf_extractRoutineBegin());
flowScheduler.add(shelf_extractRoutineEachFrame());
flowScheduler.add(shelf_extractRoutineEnd());
flowScheduler.add(filter_imagesRoutineBegin());
flowScheduler.add(filter_imagesRoutineEachFrame());
flowScheduler.add(filter_imagesRoutineEnd());
flowScheduler.add(global_varsRoutineBegin());
flowScheduler.add(global_varsRoutineEachFrame());
flowScheduler.add(global_varsRoutineEnd());
flowScheduler.add(language_choiceRoutineBegin());
flowScheduler.add(language_choiceRoutineEachFrame());
flowScheduler.add(language_choiceRoutineEnd());
flowScheduler.add(device_selectionRoutineBegin());
flowScheduler.add(device_selectionRoutineEachFrame());
flowScheduler.add(device_selectionRoutineEnd());
flowScheduler.add(mobileLandscapeRoutineBegin());
flowScheduler.add(mobileLandscapeRoutineEachFrame());
flowScheduler.add(mobileLandscapeRoutineEnd());
const instructionReadLoopLoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(instructionReadLoopLoopBegin(instructionReadLoopLoopScheduler));
flowScheduler.add(instructionReadLoopLoopScheduler);
flowScheduler.add(instructionReadLoopLoopEnd);


const imageListReadLoopLoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(imageListReadLoopLoopBegin(imageListReadLoopLoopScheduler));
flowScheduler.add(imageListReadLoopLoopScheduler);
flowScheduler.add(imageListReadLoopLoopEnd);


flowScheduler.add(emaInstructionsRoutineBegin());
flowScheduler.add(emaInstructionsRoutineEachFrame());
flowScheduler.add(emaInstructionsRoutineEnd());
const questionloopLoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(questionloopLoopBegin(questionloopLoopScheduler));
flowScheduler.add(questionloopLoopScheduler);
flowScheduler.add(questionloopLoopEnd);






























flowScheduler.add(instructionsRoutineBegin());
flowScheduler.add(instructionsRoutineEachFrame());
flowScheduler.add(instructionsRoutineEnd());
flowScheduler.add(instructions_2RoutineBegin());
flowScheduler.add(instructions_2RoutineEachFrame());
flowScheduler.add(instructions_2RoutineEnd());
flowScheduler.add(choicePreparationsRoutineBegin());
flowScheduler.add(choicePreparationsRoutineEachFrame());
flowScheduler.add(choicePreparationsRoutineEnd());
flowScheduler.add(countdownRoutineBegin());
flowScheduler.add(countdownRoutineEachFrame());
flowScheduler.add(countdownRoutineEnd());
const loop_choiceLoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(loop_choiceLoopBegin(loop_choiceLoopScheduler));
flowScheduler.add(loop_choiceLoopScheduler);
flowScheduler.add(loop_choiceLoopEnd);



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
    {'name': 'stimuli/emaQuestions.xlsx', 'path': 'stimuli/emaQuestions.xlsx'},
    {'name': 'buttons/germany_flag.png', 'path': 'buttons/germany_flag.png'},
    {'name': 'buttons/uk_flag.png', 'path': 'buttons/uk_flag.png'},
    {'name': 'buttons/laptop.png', 'path': 'buttons/laptop.png'},
    {'name': 'buttons/smartphone.png', 'path': 'buttons/smartphone.png'},
    {'name': 'buttons/tablet.png', 'path': 'buttons/tablet.png'},
    {'name': 'buttons/tilt_phone.png', 'path': 'buttons/tilt_phone.png'},
    {'name': 'default.png', 'path': 'https://pavlovia.org/assets/default/default.png'},
    {'name': 'stimuli/emaQuestions.xlsx', 'path': 'stimuli/emaQuestions.xlsx'},
    {'name': 'stimuli/instructions.xlsx', 'path': 'stimuli/instructions.xlsx'},
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
    {'name': 'buttons/germany_flag.png', 'path': 'buttons/germany_flag.png'},
    {'name': 'buttons/uk_flag.png', 'path': 'buttons/uk_flag.png'},
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


var shelf_extractClock;
var doShelfExtract;
var continueFoodRating;
var block_experiment;
var food_ratings;
var existingParticipants;
var textbox_blockExperiment;
var filter_imagesClock;
var filteredLikings;
var global_varsClock;
var opacity1;
var opacity2;
var window_height;
var window_width;
var xrange;
var submitbutton_opacity;
var submitbuttonSize;
var submitbuttonXY;
var sliderW;
var sliderH;
var sliderY;
var anchorY;
var checkBox1x;
var checkBox2x;
var checkBox3x;
var checkBox4x;
var checkBox5x;
var checkBox6x;
var checkBox7x;
var checkBox8x;
var emaLabel1;
var emaLabel2;
var emaLabel3;
var emaLabel4;
var emaLabel5;
var emaLabel6;
var emaLabel7;
var emaLabel8;
var language_choiceClock;
var languagechoice;
var image_germanyflag;
var image_ukflag;
var textbox_languagechoice;
var mouse_languagechoice;
var textbox_sourceflag;
var device_selectionClock;
var mobile_device;
var device;
var textbox_deviceselection;
var button_PC;
var button_smartphone;
var button_tablet;
var image_PC;
var image_smartphone;
var image_tablet;
var textbox_PC;
var textbox_smartphone;
var textbox_tablet;
var mouse_deviceselection;
var textbox_sourceicons;
var mobileLandscapeClock;
var requestLandscapeText;
var textbox_requestLandscape;
var image_tiltphone;
var textbox_sourcetilt;
var polygon_landscape;
var textbox_submitLandscape;
var mouse_landscape;
var load_instructionsClock;
var load_imageListClock;
var emaInstructionsClock;
var textbox_instructions;
var mouse_instructions;
var polygon_submitbutton;
var textbox_submitbutton;
var emaControllerClock;
var emaType;
var emaSkipNext;
var emaQuestion;
var emaResponse;
var emaType1Clock;
var ratingGiven;
var textbox_emaType1;
var slider_emaType1;
var textbox_emaType1LeftAnchor;
var textbox_emaType1RightAnchor;
var polygon_submitbuttonType1;
var textbox_submitbuttonType1;
var mouse_type1;
var emaType2Clock;
var textbox_emaType2;
var slider_emaType2;
var polygon_submitbuttonType2;
var textbox_submitbuttonType2;
var mouse_type2;
var textbox_emaType2Box1;
var textbox_emaType2Box2;
var textbox_emaType2Box3;
var textbox_emaType2Box4;
var textbox_emaType2Box5;
var textbox_emaType2Box6;
var textbox_emaType2Label1;
var textbox_emaType2Label2;
var textbox_emaType2Label3;
var textbox_emaType2Label4;
var textbox_emaType2Label5;
var textbox_emaType2Label6;
var emaType3Clock;
var type3sliderW;
var textbox_emaType3;
var slider_emaType3;
var polygon_submitbuttonType3;
var textbox_submitbuttonType3;
var mouse_type3;
var textbox_emaType3Box1;
var textbox_emaType3Box2;
var textbox_emaType3Label1;
var textbox_emaType3Label2;
var emaType4Clock;
var textbox_emaType4;
var slider_emaType4;
var textbox_emaType4LeftAnchor;
var textbox_emaType4RightAnchor;
var polygon_submitbuttonType4;
var textbox_submitbuttonType4;
var mouse_type4;
var emaType5Clock;
var type5sliderW;
var reminderText;
var reminderCond;
var textbox_emaType5;
var slider_emaType5;
var polygon_submitbuttonType5;
var textbox_submitbuttonType5;
var mouse_type5;
var textbox_emaType5Box1;
var textbox_emaType5Box2;
var textbox_emaType5Label1;
var textbox_emaType5Label2;
var textbox_reminder;
var emaType6Clock;
var textbox_emaType6;
var slider_emaType6;
var polygon_submitbuttonType6;
var textbox_submitbuttonType6;
var mouse_type6;
var textbox_emaType6Box1;
var textbox_emaType6Box2;
var textbox_emaType6Box3;
var textbox_emaType6Box4;
var textbox_emaType6Box5;
var textbox_emaType6Box6;
var textbox_emaType6Label1;
var textbox_emaType6Label2;
var textbox_emaType6Label3;
var textbox_emaType6Label4;
var textbox_emaType6Label5;
var textbox_emaType6Label6;
var emaType7Clock;
var type7labelLetterHeight;
var type7anchorSize;
var type7anchorY;
var textbox_emaType7;
var slider_emaType7;
var polygon_submitbuttonType7;
var textbox_submitbuttonType7;
var mouse_type7;
var textbox_emaType7Box1;
var textbox_emaType7Box2;
var textbox_emaType7Box3;
var textbox_emaType7Box4;
var textbox_emaType7Box5;
var textbox_emaType7Box6;
var textbox_emaType7Label1;
var textbox_emaType7Label2;
var textbox_emaType7Label3;
var textbox_emaType7Label4;
var textbox_emaType7Label5;
var textbox_emaType7Label6;
var emaType8Clock;
var textbox_emaType8;
var slider_emaType8;
var polygon_submitbuttonType8;
var textbox_submitbuttonType8;
var mouse_type8;
var textbox_emaType8Box1;
var textbox_emaType8Box2;
var textbox_emaType8Box3;
var textbox_emaType8Label1;
var textbox_emaType8Label2;
var textbox_emaType8Label3;
var emaType10Clock;
var textbox_emaType10;
var slider_emaType10;
var polygon_submitbuttonType10;
var textbox_submitbuttonType10;
var mouse_type10;
var textbox_emaType10Box1;
var textbox_emaType10Box2;
var textbox_emaType10Box3;
var textbox_emaType10Box4;
var textbox_emaType10Box5;
var textbox_emaType10Box6;
var textbox_emaType10Box7;
var textbox_emaType10Label1;
var textbox_emaType10Label2;
var textbox_emaType10Label3;
var textbox_emaType10Label4;
var textbox_emaType10Label5;
var textbox_emaType10Label6;
var textbox_emaType10Label7;
var emaSkipperClock;
var instructionsClock;
var textbox_instructions_2;
var mouse_instructions_2;
var polygon_submitbutton_2;
var textbox_submitbutton_2;
var instructions_2Clock;
var textbox_instructions_3;
var mouse_instructions_3;
var polygon_submitbutton_3;
var textbox_submitbutton_3;
var choicePreparationsClock;
var countdownClock;
var countdownNum;
var countdownText;
var textbox_countdown;
var fixationClock;
var fixation_cross;
var choiceClock;
var choiceTimeLimit;
var imgLeft;
var imgRight;
var imgLeftSize;
var imgLeftPos;
var imgRightSize;
var imgRightPos;
var keys;
var image_choiceLeft;
var image_choiceRight;
var mouse_choice;
var reminder;
var key_choice;
var globalClock;
var routineTimer;
async function experimentInit() {
  // Initialize components for Routine "shelf_extract"
  shelf_extractClock = new util.Clock();
  // testcode to determine if running online or locally
  if (window.location.href.includes("pavlovia")) {
      console.log("Running online via Pavlovia");
      doShelfExtract = true; // read food_rating from shelf
  } else {
      console.log("Running locally");
      doShelfExtract = false; // using fix test-set for food_rating
  }
  continueFoodRating = true;
  if(doShelfExtract){
      //// Code component to extract information from the shelf:
      //// https://www.psychopy.org/online/shelf.html
  
      // Info: food ratings of participant
      block_experiment = false; // block if no rating is found on shelf
      food_ratings = [];
      existingParticipants = await psychoJS.shelf.getDictionaryFieldNames({
          key: ["food_ratings", "@designer"]});
      continueFoodRating = existingParticipants.includes(expInfo['participantID']);
      if(continueFoodRating){
          food_ratings = await psychoJS.shelf.getDictionaryFieldValue({
              key: ["food_ratings", "@designer"], 
              fieldName:expInfo['participantID'], 
              defaultValue:'no food ratings detected'});
      }
  }
  
  textbox_blockExperiment = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_blockExperiment',
    text: 'You cannot run this experiment yet, since there is no record of your food ratings. Please finish the Food Rating experiment first or contact the experiment operator.',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [0.8, 0.5],  units: undefined, 
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
  
  if(!doShelfExtract){
  
  // this food rating is for debug, when you can't read from shelf
  food_ratings = [
  [115,
  ["sustainability", 39.69183952519388],
  ["wanting", 58.43395187397196],
  ["liking", 8.991625658292325],
  ["healthiness", 39.889125631313135]],
  [300,
  ["liking", 8.34412665747098],
  ["sustainability", 61.4425489998827],
  ["healthiness", 67.16382726274355],
  ["wanting", 23.366477272727277]],
  [114,
  ["wanting", 23.563763378846524],
  ["sustainability", 68.64346741425871],
  ["healthiness", 72.78645682816554],
  ["liking", 81.51169900170449]],
  [337,
  ["healthiness", 67.90364733850113],
  ["sustainability", 31.257891414141415],
  ["wanting", 27.361504929234282],
  ["liking", 67.91418293417195]],
  [1,
  ["sustainability",70.12310756577385],
  ["healthiness", 20.703124247416106],
  ["liking", 13.52412689743826],
  ["wanting", 26.375078161557518]],
  [199,
  ["wanting", 72.98374669720428],
  ["healthiness", 23.317156686927333],
  ["sustainability", 75.30184809607688],
  ["liking", 14.387464387464387]],
  [328,
  ["liking", 14.603294643272669],
  ["sustainability", 23.267836101127394],
  ["healthiness", 25.388651393880746],
  ["wanting", 70.46835542929293]], [157, ["sustainability", 76.88012941919192], ["healthiness", 18.237057328224182], ["liking", 80.32461201126767], ["wanting", 25.832544191919194]], [58, ["liking", 64.35293019625803], ["healthiness", 30.37010581806453], ["wanting", 71.8493544092082], ["sustainability", 32.54024545953732]], [72, ["liking", 78.70586039251606], ["sustainability", 30.4687507525839], ["healthiness", 69.72853535353536], ["wanting", 24.698151903923115]], [52, ["wanting", 69.97514204545455], ["liking", 13.41621176953412], ["healthiness", 70.22174873737373], ["sustainability", 25.53661691420006]], [62, ["sustainability", 33.28006553529489], ["healthiness", 67.65704064658193], ["wanting", 73.18102904040404], ["liking", 78.05836139169472]], [26, ["sustainability", 32.98413825757576], ["healthiness", 69.23532196969697], ["liking", 9.423294403305388], ["wanting", 18.483664020143376]], [259, ["wanting", 30.567391924183777], ["sustainability", 64.50047047451288], ["healthiness", 76.53488155567285], ["liking", 10.502462149139802]], [138, ["healthiness", 26.128471469638328], ["sustainability", 70.86292764153144], ["wanting", 34.41445782329097], ["liking", 67.59043343376126]], [144, ["wanting", 31.80042538377974], ["liking", 78.49003013670779], ["sustainability", 19.420770202020204], ["healthiness", 72.2439266214467]], [3, ["sustainability", 34.01988561105247], ["wanting", 69.33396314129685], ["liking", 21.294139607483924], ["healthiness", 26.62168485347671]], [104, ["healthiness", 36.04205973220594], ["sustainability", 72.2439266214467], ["wanting", 76.09098499471492], ["liking", 12.444959151603847]], [141, ["wanting", 34.611743929410224], ["liking", 69.85668817003247], ["healthiness", 30.715357444503088], ["sustainability", 80.38194745478005]], [24, ["sustainability", 33.773278919133276], ["liking", 74.71294302628733], ["healthiness", 26.769650373796022], ["wanting", 70.17242438865429]], [203, ["sustainability", 22.577336611169756], ["healthiness", 75.203206924477], ["liking", 11.581629894974215], ["wanting", 18.631629540462686]], [121, ["liking", 80.64836562837661], ["healthiness", 22.232084984731195], ["sustainability", 71.4547821969697], ["wanting", 23.711725136246347]], [103, ["sustainability", 70.36971425769305], ["healthiness", 28.1506455907918], ["wanting", 72.68781565656566], ["liking", 13.200381513725834]], [20, ["sustainability", 68.84074975745847], ["liking", 45.79124414456649], ["wanting", 26.62168485347671], ["healthiness", 70.61632094961224]], [256, ["liking", 64.35293019625803], ["sustainability", 31.109925893822098], ["wanting", 24.204938520084728], ["healthiness", 69.82717652513524]], [34, ["wanting", 70.56699660089281], ["sustainability", 26.128471469638328], ["healthiness", 30.81399861610297], ["liking", 64.46084944086041]], [170, ["sustainability", 67.60771629786251], ["liking", 66.07960105961203], ["wanting", 27.657432206953413], ["healthiness", 76.48555720695342]], [33, ["liking", 18.70413537080204], ["sustainability", 62.18236907564029], ["healthiness", 26.572364267676768], ["wanting", 71.55342336856958]], [171, ["wanting", 42.5524786566243], ["healthiness", 71.35614102536981], ["liking", 27.2295622095732], ["sustainability", 26.818970959595962]], [131, ["liking", 24.0999740999741], ["wanting", 36.78187980796351], ["healthiness", 72.34256779304658], ["sustainability", 22.33072991925057]], [189, ["liking", 10.502462149139802], ["healthiness", 61.09730113636363], ["wanting", 76.14030934343434], ["sustainability", 21.88683712121212]], [180, ["liking", 12.01329863998728], ["wanting", 31.01128472222222], ["sustainability", 73.82220794456174], ["healthiness", 21.492264908973617]], [181, ["healthiness", 58.28598635365264], ["sustainability", 34.167851131371776], ["liking", 64.56876456876456], ["wanting", 27.11489823731509]], [76, ["wanting", 64.10590578811338], ["sustainability", 33.28006553529489], ["liking", 4.0274556741333285], ["healthiness", 27.904038898872606]], [272, ["sustainability", 55.32670605062234], ["liking", 24.747473100795446], ["healthiness", 71.80003006048877], ["wanting", 25.339330808080806]], [183, ["sustainability", 39.54387776779406], ["liking", 10.718292404948087], ["wanting", 72.2439266214467], ["healthiness", 29.63028574230695]], [142, ["sustainability", 42.70044041402412], ["liking", 13.52412689743826], ["wanting", 70.27107308609317], ["healthiness", 24.00765617688497]], [322, ["healthiness", 31.94839090409905], ["liking", 19.243719243719244], ["sustainability", 76.28827486375364], ["wanting", 26.62168485347671]], [228, ["healthiness", 34.315812888771596], ["liking", 5.969952676597373], ["sustainability", 78.50773509102638], ["wanting", 27.460149863753657]], [8, ["sustainability", 39.29727107587487], ["healthiness", 75.79506147991528], ["wanting", 70.71496212121212], ["liking", 63.48959682293015]], [331, ["sustainability", 29.137072358468565], ["healthiness", 71.01089316185075], ["liking", 17.948721242076548], ["wanting", 28.7918244949495]], [30, ["wanting", 23.366477272727277], ["healthiness", 71.40545784825026], ["liking", 8.128288168266195], ["sustainability", 29.728930676826327]], [321, ["liking", 72.7704377904268], ["wanting", 28.545217803030305], ["sustainability", 72.39188461592703], ["healthiness", 26.375078161557518]], [38, ["healthiness", 67.85432298978169], ["sustainability", 33.0334588433757], ["liking", 61.007511830850646], ["wanting", 30.764678030303028]], [323, ["liking", 74.17335915337013], ["wanting", 28.298611111111114], ["healthiness", 74.95660023255782], ["sustainability", 27.312184343434343]], [136, ["wanting", 69.67921100481593], ["healthiness", 28.545217803030305], ["liking", 64.1370958237515], ["sustainability", 30.222144060664707]], [190, ["healthiness", 62.23169342435971], ["sustainability", 38.36016489399804], ["liking", 58.63334196667529], ["wanting", 34.562419580690786]], [326, ["wanting", 69.92581769673511], ["sustainability", 42.30587196470511], ["healthiness", 66.62128953018573], ["liking", 22.589137609126624]], [192, ["wanting", 68.59414306553927], ["healthiness", 36.92984532828283], ["liking", 81.29586462919795], ["sustainability", 26.375078161557518]], [36, ["wanting", 71.30681667665039], ["liking", 11.581629894974215], ["sustainability", 68.44617754521995], ["healthiness", 25.980509712238508]], [263, ["liking", 11.797460150782497], ["healthiness", 38.45880606559792], ["wanting", 70.71496212121212], ["sustainability", 28.545217803030305]], [61, ["liking", 6.401621421610438], ["sustainability", 75.74573713119584], ["wanting", 70.76428646993156], ["healthiness", 35.992739146406]], [81, ["wanting", 33.378710469814266], ["liking", 72.66252266252266], ["healthiness", 72.8850979997654], ["sustainability", 28.594538388830244]], [12, ["healthiness", 29.186396707188], ["sustainability", 73.87152476744218], ["wanting", 72.8850979997654], ["liking", 76.87127851795617]], [224, ["liking", 21.509969863292213], ["wanting", 29.926216782945573], ["healthiness", 24.45154521200392], ["sustainability", 71.75071323760832]], [14, ["sustainability", 67.90364733850113], ["wanting", 28.545217803030305], ["healthiness", 29.383679050387755], ["liking", 66.40335056002272]], [4, ["healthiness", 70.86292764153144], ["sustainability", 35.84477738900618], ["wanting", 32.14567701021831], ["liking", 72.0150236617013]], [241, ["wanting", 70.76428646993156], ["sustainability", 44.13075997973933], ["healthiness", 32.09635266149887], ["liking", 79.02961400962498]], [167, ["sustainability", 79.74076855062235], ["healthiness", 22.42937109085045], ["wanting", 30.271464646464647], ["liking", 81.08003025669142]], [202, ["healthiness", 71.4547821969697], ["wanting", 16.51081048478984], ["sustainability", 31.257891414141415], ["liking", 82.48294750293651]]];
  
  }
  
  // Initialize components for Routine "filter_images"
  filter_imagesClock = new util.Clock();
  filteredLikings = []
  
  // Initialize components for Routine "global_vars"
  global_varsClock = new util.Clock();
  // Define opacities for hover buttons
  opacity1 = 0.75; // default opacity of buttons
  opacity2 = 1; // opacity if hovered over button
  
  // Window size
  // in js: 1=height; 0=width
  window_height = psychoJS.window.size[1];
  window_width = psychoJS.window.size[0];
  xrange = (window_width / window_height);
  
  // general parameters
  submitbutton_opacity = opacity1;
  submitbuttonSize = [0.3, 0.1];
  submitbuttonXY = [0, (- 0.4)];
  
  //// the next entries rule for all emaTypes
  // some positions
  sliderW = 0.9;
  sliderH = 0.1;
  sliderY = (- 0.1);
  anchorY = (sliderY - 0.1);
  
  // these values must be computed for each emaType separately
  checkBox1x = 0;
  checkBox2x = 0;
  checkBox3x = 0;
  checkBox4x = 0;
  checkBox5x = 0;
  checkBox6x = 0;
  checkBox7x = 0;
  checkBox8x = 0;
  
  // labels must be set for each emaType separately
  emaLabel1 = "tba";
  emaLabel2 = "tba";
  emaLabel3 = "tba";
  emaLabel4 = "tba";
  emaLabel5 = "tba";
  emaLabel6 = "tba";
  emaLabel7 = "tba";
  emaLabel8 = "tba";
  
  // these info is added to the experiment here, and not before experiment,
  // because it shall not appear in the input dialog at start.
  expInfo["studyID"] = studyID;
  
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
  
  // Initialize components for Routine "device_selection"
  device_selectionClock = new util.Clock();
  mobile_device = false;
  device = "none";
  
  textbox_deviceselection = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_deviceselection',
    text: '',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0, 0.2], 
    draggable: false,
    letterHeight: 0.07,
    lineSpacing: 1.0,
    size: [0.95, 0.4],  units: undefined, 
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
  
  button_PC = new visual.Polygon({
    win: psychoJS.window, name: 'button_PC', 
    edges: 100, size:[0.25, 0.25],
    ori: 0.0, 
    pos: [(- 0.3), (- 0.2)], 
    draggable: false, 
    anchor: 'center', 
    lineWidth: 1.0, 
    lineColor: new util.Color([1.0, 0.7882, 0.5373]), 
    fillColor: new util.Color([1.0, 0.8431, 0.6078]), 
    colorSpace: 'rgb', 
    opacity: 1.0, 
    depth: -2, 
    interpolate: true, 
  });
  
  button_smartphone = new visual.Polygon({
    win: psychoJS.window, name: 'button_smartphone', 
    edges: 100, size:[0.25, 0.25],
    ori: 0.0, 
    pos: [0, (- 0.2)], 
    draggable: false, 
    anchor: 'center', 
    lineWidth: 1.0, 
    lineColor: new util.Color([1.0, 0.7882, 0.5373]), 
    fillColor: new util.Color([1.0, 0.8431, 0.6078]), 
    colorSpace: 'rgb', 
    opacity: 1.0, 
    depth: -3, 
    interpolate: true, 
  });
  
  button_tablet = new visual.Polygon({
    win: psychoJS.window, name: 'button_tablet', 
    edges: 100, size:[0.25, 0.25],
    ori: 0.0, 
    pos: [0.3, (- 0.2)], 
    draggable: false, 
    anchor: 'center', 
    lineWidth: 1.0, 
    lineColor: new util.Color([1.0, 0.7882, 0.5373]), 
    fillColor: new util.Color([1.0, 0.8431, 0.6078]), 
    colorSpace: 'rgb', 
    opacity: 1.0, 
    depth: -4, 
    interpolate: true, 
  });
  
  image_PC = new visual.ImageStim({
    win : psychoJS.window,
    name : 'image_PC', units : undefined, 
    image : 'buttons/laptop.png', mask : undefined,
    anchor : 'center',
    ori : 0.0, 
    pos : [(- 0.3), (- 0.2)], 
    draggable: false,
    size : [0.2, 0.2],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -5.0 
  });
  image_smartphone = new visual.ImageStim({
    win : psychoJS.window,
    name : 'image_smartphone', units : undefined, 
    image : 'buttons/smartphone.png', mask : undefined,
    anchor : 'center',
    ori : 0.0, 
    pos : [0, (- 0.2)], 
    draggable: false,
    size : [0.2, 0.2],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -6.0 
  });
  image_tablet = new visual.ImageStim({
    win : psychoJS.window,
    name : 'image_tablet', units : undefined, 
    image : 'buttons/tablet.png', mask : undefined,
    anchor : 'center',
    ori : 0.0, 
    pos : [0.3, (- 0.2)], 
    draggable: false,
    size : [0.2, 0.2],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -7.0 
  });
  textbox_PC = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_PC',
    text: '',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [(- 0.3), (- 0.35)], 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: [0.3, 0.1],  units: undefined, 
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
    depth: -8.0 
  });
  
  textbox_smartphone = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_smartphone',
    text: '',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0, (- 0.35)], 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: [0.3, 0.1],  units: undefined, 
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
    depth: -9.0 
  });
  
  textbox_tablet = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_tablet',
    text: '',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0.3, (- 0.35)], 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: [0.3, 0.1],  units: undefined, 
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
    depth: -10.0 
  });
  
  mouse_deviceselection = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_deviceselection.mouseClock = new util.Clock();
  textbox_sourceicons = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_sourceicons',
    text: 'Icons from https://icons8.com/',
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
    depth: -12.0 
  });
  
  // Initialize components for Routine "mobileLandscape"
  mobileLandscapeClock = new util.Clock();
  requestLandscapeText = "tba";
  
  textbox_requestLandscape = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_requestLandscape',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0.15], 
    draggable: false,
    letterHeight: 0.035,
    lineSpacing: 1.0,
    size: [0.9, 0.3],  units: undefined, 
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
  
  image_tiltphone = new visual.ImageStim({
    win : psychoJS.window,
    name : 'image_tiltphone', units : undefined, 
    image : 'buttons/tilt_phone.png', mask : undefined,
    anchor : 'center',
    ori : 0.0, 
    pos : [0.0, (- 0.1)], 
    draggable: false,
    size : [0.15, 0.15],
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -2.0 
  });
  textbox_sourcetilt = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_sourcetilt',
    text: 'Icon from https://icons8.com',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0.35, (- 0.4)], 
    draggable: false,
    letterHeight: 0.015,
    lineSpacing: 1.0,
    size: [0.2, 0.1],  units: undefined, 
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
    depth: -3.0 
  });
  
  polygon_landscape = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_landscape', 
    width: submitbuttonSize[0], height: submitbuttonSize[1],
    ori: 0.0, 
    pos: [0, (- 0.3)], 
    draggable: false, 
    anchor: 'center', 
    lineWidth: 1.0, 
    lineColor: new util.Color('black'), 
    fillColor: new util.Color('white'), 
    colorSpace: 'rgb', 
    opacity: undefined, 
    depth: -4, 
    interpolate: true, 
  });
  
  textbox_submitLandscape = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitLandscape',
    text: '',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0, (- 0.3)], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: submitbuttonSize,  units: undefined, 
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
    depth: -5.0 
  });
  
  mouse_landscape = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_landscape.mouseClock = new util.Clock();
  // Initialize components for Routine "load_instructions"
  load_instructionsClock = new util.Clock();
  // Initialize components for Routine "load_imageList"
  load_imageListClock = new util.Clock();
  // Initialize components for Routine "emaInstructions"
  emaInstructionsClock = new util.Clock();
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
    size: [0.9, 0.6],  units: undefined, 
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
    width: submitbuttonSize[0], height: submitbuttonSize[1],
    ori: 0.0, 
    pos: submitbuttonXY, 
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
    pos: submitbuttonXY, 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: submitbuttonSize,  units: undefined, 
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
  
  // Initialize components for Routine "emaController"
  emaControllerClock = new util.Clock();
  // declare some variables
  emaType = 0;
  emaSkipNext = false;
  emaQuestion = "no question";
  emaResponse = "no response";
  
  // Initialize components for Routine "emaType1"
  emaType1Clock = new util.Clock();
  // track if ratings have been given to all sliders
  ratingGiven = false;
  
  textbox_emaType1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType1',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0.2], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [0.9, 0.4],  units: undefined, 
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
  
  slider_emaType1 = new visual.Slider({
    win: psychoJS.window, name: 'slider_emaType1',
    startValue: 50,
    size: [sliderW, 0.1], pos: [0, sliderY], ori: 0.0, units: psychoJS.window.units,
    labels: undefined, fontSize: 0.05, ticks: [0, 100],
    granularity: 0.0, style: ["SLIDER"],
    color: new util.Color('lightgrey'), markerColor: new util.Color('red'), lineColor: new util.Color('lightgrey'), 
    opacity: undefined, fontFamily: 'Open Sans', bold: true, italic: false, depth: -3, 
    flip: false,
  });
  
  textbox_emaType1LeftAnchor = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType1LeftAnchor',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [((- sliderW) / 2), anchorY], 
    draggable: false,
    letterHeight: 0.035,
    lineSpacing: 1.0,
    size: [0.25, 0.1],  units: undefined, 
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
    depth: -4.0 
  });
  
  textbox_emaType1RightAnchor = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType1RightAnchor',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [(sliderW / 2), anchorY], 
    draggable: false,
    letterHeight: 0.035,
    lineSpacing: 1.0,
    size: [0.25, 0.1],  units: undefined, 
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
    depth: -5.0 
  });
  
  polygon_submitbuttonType1 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbuttonType1', 
    width: submitbuttonSize[0], height: submitbuttonSize[1],
    ori: 0.0, 
    pos: submitbuttonXY, 
    draggable: false, 
    anchor: 'center', 
    lineWidth: 2.0, 
    lineColor: new util.Color([(- 1), (- 1), (- 1)]), 
    fillColor: new util.Color([0.9, 0.9, 0.9]), 
    colorSpace: 'rgb', 
    opacity: 1.0, 
    depth: -6, 
    interpolate: true, 
  });
  
  textbox_submitbuttonType1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbuttonType1',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: submitbuttonXY, 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: submitbuttonSize,  units: undefined, 
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
    depth: -7.0 
  });
  
  mouse_type1 = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_type1.mouseClock = new util.Clock();
  // Initialize components for Routine "emaType2"
  emaType2Clock = new util.Clock();
  // track if ratings have been given to all sliders
  ratingGiven = false;
  
  textbox_emaType2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0.2], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [0.9, 0.4],  units: undefined, 
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
  
  slider_emaType2 = new visual.Slider({
    win: psychoJS.window, name: 'slider_emaType2',
    startValue: undefined,
    size: [sliderW, sliderH], pos: [0, sliderY], ori: 0.0, units: psychoJS.window.units,
    labels: [1, 2, 3, 4, 5, 6], fontSize: 0.05, ticks: [],
    granularity: 1, style: ["RADIO"],
    color: new util.Color('white'), markerColor: new util.Color('red'), lineColor: new util.Color('white'), 
    opacity: undefined, fontFamily: 'Open Sans', bold: true, italic: false, depth: -3, 
    flip: false,
  });
  
  polygon_submitbuttonType2 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbuttonType2', 
    width: submitbuttonSize[0], height: submitbuttonSize[1],
    ori: 0.0, 
    pos: submitbuttonXY, 
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
  
  textbox_submitbuttonType2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbuttonType2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: submitbuttonXY, 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: submitbuttonSize,  units: undefined, 
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
  
  mouse_type2 = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_type2.mouseClock = new util.Clock();
  textbox_emaType2Box1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType2Box1',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType2Box2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType2Box2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType2Box3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType2Box3',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -9.0 
  });
  
  textbox_emaType2Box4 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType2Box4',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType2Box5 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType2Box5',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -11.0 
  });
  
  textbox_emaType2Box6 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType2Box6',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -12.0 
  });
  
  textbox_emaType2Label1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType2Label1',
    text: '<0.5h',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -13.0 
  });
  
  textbox_emaType2Label2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType2Label2',
    text: '1h',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -14.0 
  });
  
  textbox_emaType2Label3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType2Label3',
    text: '1.5h',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -15.0 
  });
  
  textbox_emaType2Label4 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType2Label4',
    text: '2h',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -16.0 
  });
  
  textbox_emaType2Label5 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType2Label5',
    text: '2.5h',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -17.0 
  });
  
  textbox_emaType2Label6 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType2Label6',
    text: '>3h',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -18.0 
  });
  
  // Initialize components for Routine "emaType3"
  emaType3Clock = new util.Clock();
  type3sliderW = 0.5;
  
  // track if ratings have been given to all sliders
  ratingGiven = false;
  
  textbox_emaType3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType3',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0.2], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [0.9, 0.4],  units: undefined, 
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
  
  slider_emaType3 = new visual.Slider({
    win: psychoJS.window, name: 'slider_emaType3',
    startValue: undefined,
    size: [type3sliderW, sliderH], pos: [0, sliderY], ori: 0.0, units: psychoJS.window.units,
    labels: [1, 2], fontSize: 0.05, ticks: [],
    granularity: 1, style: ["RADIO"],
    color: new util.Color('white'), markerColor: new util.Color('red'), lineColor: new util.Color('white'), 
    opacity: undefined, fontFamily: 'Open Sans', bold: true, italic: false, depth: -3, 
    flip: false,
  });
  
  polygon_submitbuttonType3 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbuttonType3', 
    width: submitbuttonSize[0], height: submitbuttonSize[1],
    ori: 0.0, 
    pos: submitbuttonXY, 
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
  
  textbox_submitbuttonType3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbuttonType3',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: submitbuttonXY, 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: submitbuttonSize,  units: undefined, 
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
  
  mouse_type3 = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_type3.mouseClock = new util.Clock();
  textbox_emaType3Box1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType3Box1',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType3Box2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType3Box2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType3Label1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType3Label1',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -9.0 
  });
  
  textbox_emaType3Label2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType3Label2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -10.0 
  });
  
  // Initialize components for Routine "emaType4"
  emaType4Clock = new util.Clock();
  // track if ratings have been given to all sliders
  ratingGiven = false;
  
  textbox_emaType4 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType4',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0.2], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [0.9, 0.4],  units: undefined, 
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
  
  slider_emaType4 = new visual.Slider({
    win: psychoJS.window, name: 'slider_emaType4',
    startValue: 50,
    size: [sliderW, 0.1], pos: [0, sliderY], ori: 0.0, units: psychoJS.window.units,
    labels: undefined, fontSize: 0.05, ticks: [0, 100],
    granularity: 0.0, style: ["SLIDER"],
    color: new util.Color('lightgrey'), markerColor: new util.Color('red'), lineColor: new util.Color('lightgrey'), 
    opacity: undefined, fontFamily: 'Open Sans', bold: true, italic: false, depth: -3, 
    flip: false,
  });
  
  textbox_emaType4LeftAnchor = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType4LeftAnchor',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [((- sliderW) / 2), anchorY], 
    draggable: false,
    letterHeight: 0.035,
    lineSpacing: 1.0,
    size: [0.25, 0.1],  units: undefined, 
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
    depth: -4.0 
  });
  
  textbox_emaType4RightAnchor = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType4RightAnchor',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [(sliderW / 2), anchorY], 
    draggable: false,
    letterHeight: 0.035,
    lineSpacing: 1.0,
    size: [0.25, 0.1],  units: undefined, 
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
    depth: -5.0 
  });
  
  polygon_submitbuttonType4 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbuttonType4', 
    width: submitbuttonSize[0], height: submitbuttonSize[1],
    ori: 0.0, 
    pos: submitbuttonXY, 
    draggable: false, 
    anchor: 'center', 
    lineWidth: 2.0, 
    lineColor: new util.Color([(- 1), (- 1), (- 1)]), 
    fillColor: new util.Color([0.9, 0.9, 0.9]), 
    colorSpace: 'rgb', 
    opacity: 1.0, 
    depth: -6, 
    interpolate: true, 
  });
  
  textbox_submitbuttonType4 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbuttonType4',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: submitbuttonXY, 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: submitbuttonSize,  units: undefined, 
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
    depth: -7.0 
  });
  
  mouse_type4 = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_type4.mouseClock = new util.Clock();
  // Initialize components for Routine "emaType5"
  emaType5Clock = new util.Clock();
  type5sliderW = 0.7;
  reminderText = "tba";
  
  // track if ratings have been given to all sliders
  ratingGiven = false;
  reminderCond = false;
  textbox_emaType5 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType5',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0.2], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [0.9, 0.4],  units: undefined, 
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
  
  slider_emaType5 = new visual.Slider({
    win: psychoJS.window, name: 'slider_emaType5',
    startValue: undefined,
    size: [type5sliderW, sliderH], pos: [0, sliderY], ori: 0.0, units: psychoJS.window.units,
    labels: [1, 2], fontSize: 0.05, ticks: [],
    granularity: 1, style: ["RADIO"],
    color: new util.Color('white'), markerColor: new util.Color('red'), lineColor: new util.Color('white'), 
    opacity: undefined, fontFamily: 'Open Sans', bold: true, italic: false, depth: -3, 
    flip: false,
  });
  
  polygon_submitbuttonType5 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbuttonType5', 
    width: submitbuttonSize[0], height: submitbuttonSize[1],
    ori: 0.0, 
    pos: submitbuttonXY, 
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
  
  textbox_submitbuttonType5 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbuttonType5',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: submitbuttonXY, 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: submitbuttonSize,  units: undefined, 
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
  
  mouse_type5 = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_type5.mouseClock = new util.Clock();
  textbox_emaType5Box1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType5Box1',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType5Box2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType5Box2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType5Label1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType5Label1',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -9.0 
  });
  
  textbox_emaType5Label2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType5Label2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -10.0 
  });
  
  textbox_reminder = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_reminder',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, sliderY], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [0.5, 0.5],  units: undefined, 
    ori: 0.0,
    color: [1.0, (- 1.0), (- 1.0)], colorSpace: 'rgb',
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
    depth: -11.0 
  });
  
  // Initialize components for Routine "emaType6"
  emaType6Clock = new util.Clock();
  // track if ratings have been given to all sliders
  ratingGiven = false;
  
  textbox_emaType6 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType6',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0.2], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [0.9, 0.4],  units: undefined, 
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
  
  slider_emaType6 = new visual.Slider({
    win: psychoJS.window, name: 'slider_emaType6',
    startValue: undefined,
    size: [sliderW, sliderH], pos: [0, sliderY], ori: 0.0, units: psychoJS.window.units,
    labels: [1, 2, 3, 4, 5, 6], fontSize: 0.05, ticks: [],
    granularity: 1, style: ["RADIO"],
    color: new util.Color('white'), markerColor: new util.Color('red'), lineColor: new util.Color('white'), 
    opacity: undefined, fontFamily: 'Open Sans', bold: true, italic: false, depth: -3, 
    flip: false,
  });
  
  polygon_submitbuttonType6 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbuttonType6', 
    width: submitbuttonSize[0], height: submitbuttonSize[1],
    ori: 0.0, 
    pos: submitbuttonXY, 
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
  
  textbox_submitbuttonType6 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbuttonType6',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: submitbuttonXY, 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: submitbuttonSize,  units: undefined, 
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
  
  mouse_type6 = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_type6.mouseClock = new util.Clock();
  textbox_emaType6Box1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType6Box1',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType6Box2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType6Box2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType6Box3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType6Box3',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -9.0 
  });
  
  textbox_emaType6Box4 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType6Box4',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType6Box5 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType6Box5',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -11.0 
  });
  
  textbox_emaType6Box6 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType6Box6',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -12.0 
  });
  
  textbox_emaType6Label1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType6Label1',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -13.0 
  });
  
  textbox_emaType6Label2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType6Label2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -14.0 
  });
  
  textbox_emaType6Label3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType6Label3',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -15.0 
  });
  
  textbox_emaType6Label4 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType6Label4',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -16.0 
  });
  
  textbox_emaType6Label5 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType6Label5',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -17.0 
  });
  
  textbox_emaType6Label6 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType6Label6',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -18.0 
  });
  
  // Initialize components for Routine "emaType7"
  emaType7Clock = new util.Clock();
  type7labelLetterHeight = 0.03;
  type7anchorSize = [(sliderH * 1.5), (sliderH * 2)];
  type7anchorY = (sliderY - 0.1);
  
  // track if ratings have been given to all sliders
  ratingGiven = false;
  
  textbox_emaType7 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType7',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0.2], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [0.9, 0.4],  units: undefined, 
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
  
  slider_emaType7 = new visual.Slider({
    win: psychoJS.window, name: 'slider_emaType7',
    startValue: undefined,
    size: [sliderW, sliderH], pos: [0, sliderY], ori: 0.0, units: psychoJS.window.units,
    labels: [0, 1, 2, 3, 4, 5], fontSize: 0.05, ticks: [],
    granularity: 1, style: ["RADIO"],
    color: new util.Color('white'), markerColor: new util.Color('red'), lineColor: new util.Color('white'), 
    opacity: undefined, fontFamily: 'Open Sans', bold: true, italic: false, depth: -3, 
    flip: false,
  });
  
  polygon_submitbuttonType7 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbuttonType7', 
    width: submitbuttonSize[0], height: submitbuttonSize[1],
    ori: 0.0, 
    pos: submitbuttonXY, 
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
  
  textbox_submitbuttonType7 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbuttonType7',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: submitbuttonXY, 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: submitbuttonSize,  units: undefined, 
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
  
  mouse_type7 = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_type7.mouseClock = new util.Clock();
  textbox_emaType7Box1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType7Box1',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType7Box2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType7Box2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType7Box3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType7Box3',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -9.0 
  });
  
  textbox_emaType7Box4 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType7Box4',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType7Box5 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType7Box5',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -11.0 
  });
  
  textbox_emaType7Box6 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType7Box6',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -12.0 
  });
  
  textbox_emaType7Label1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType7Label1',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: type7labelLetterHeight,
    lineSpacing: 1.0,
    size: type7anchorSize,  units: undefined, 
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
    depth: -13.0 
  });
  
  textbox_emaType7Label2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType7Label2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: type7labelLetterHeight,
    lineSpacing: 1.0,
    size: type7anchorSize,  units: undefined, 
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
    depth: -14.0 
  });
  
  textbox_emaType7Label3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType7Label3',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: type7labelLetterHeight,
    lineSpacing: 1.0,
    size: type7anchorSize,  units: undefined, 
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
    depth: -15.0 
  });
  
  textbox_emaType7Label4 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType7Label4',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: type7labelLetterHeight,
    lineSpacing: 1.0,
    size: type7anchorSize,  units: undefined, 
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
    depth: -16.0 
  });
  
  textbox_emaType7Label5 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType7Label5',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: type7labelLetterHeight,
    lineSpacing: 1.0,
    size: type7anchorSize,  units: undefined, 
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
    depth: -17.0 
  });
  
  textbox_emaType7Label6 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType7Label6',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: type7labelLetterHeight,
    lineSpacing: 1.0,
    size: type7anchorSize,  units: undefined, 
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
    depth: -18.0 
  });
  
  // Initialize components for Routine "emaType8"
  emaType8Clock = new util.Clock();
  // track if ratings have been given to all sliders
  ratingGiven = false;
  
  textbox_emaType8 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType8',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0.2], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [0.9, 0.4],  units: undefined, 
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
  
  slider_emaType8 = new visual.Slider({
    win: psychoJS.window, name: 'slider_emaType8',
    startValue: undefined,
    size: [sliderW, sliderH], pos: [0, sliderY], ori: 0.0, units: psychoJS.window.units,
    labels: [1, 2, 3], fontSize: 0.05, ticks: [],
    granularity: 1, style: ["RADIO"],
    color: new util.Color('white'), markerColor: new util.Color('red'), lineColor: new util.Color('white'), 
    opacity: undefined, fontFamily: 'Open Sans', bold: true, italic: false, depth: -3, 
    flip: false,
  });
  
  polygon_submitbuttonType8 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbuttonType8', 
    width: submitbuttonSize[0], height: submitbuttonSize[1],
    ori: 0.0, 
    pos: submitbuttonXY, 
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
  
  textbox_submitbuttonType8 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbuttonType8',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: submitbuttonXY, 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: submitbuttonSize,  units: undefined, 
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
  
  mouse_type8 = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_type8.mouseClock = new util.Clock();
  textbox_emaType8Box1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType8Box1',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType8Box2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType8Box2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType8Box3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType8Box3',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -9.0 
  });
  
  textbox_emaType8Label1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType8Label1',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -10.0 
  });
  
  textbox_emaType8Label2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType8Label2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -11.0 
  });
  
  textbox_emaType8Label3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType8Label3',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -12.0 
  });
  
  // Initialize components for Routine "emaType10"
  emaType10Clock = new util.Clock();
  // track if ratings have been given to all sliders
  ratingGiven = false;
  
  textbox_emaType10 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType10',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0.2], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [0.9, 0.4],  units: undefined, 
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
  
  slider_emaType10 = new visual.Slider({
    win: psychoJS.window, name: 'slider_emaType10',
    startValue: undefined,
    size: [sliderW, sliderH], pos: [0, sliderY], ori: 0.0, units: psychoJS.window.units,
    labels: [1, 2, 3, 4, 5, 6, 7], fontSize: 0.05, ticks: [],
    granularity: 1, style: ["RADIO"],
    color: new util.Color('white'), markerColor: new util.Color('red'), lineColor: new util.Color('white'), 
    opacity: undefined, fontFamily: 'Open Sans', bold: true, italic: false, depth: -3, 
    flip: false,
  });
  
  polygon_submitbuttonType10 = new visual.Rect ({
    win: psychoJS.window, name: 'polygon_submitbuttonType10', 
    width: submitbuttonSize[0], height: submitbuttonSize[1],
    ori: 0.0, 
    pos: submitbuttonXY, 
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
  
  textbox_submitbuttonType10 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_submitbuttonType10',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: submitbuttonXY, 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: submitbuttonSize,  units: undefined, 
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
  
  mouse_type10 = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_type10.mouseClock = new util.Clock();
  textbox_emaType10Box1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType10Box1',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType10Box2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType10Box2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType10Box3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType10Box3',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -9.0 
  });
  
  textbox_emaType10Box4 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType10Box4',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
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
  
  textbox_emaType10Box5 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType10Box5',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -11.0 
  });
  
  textbox_emaType10Box6 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType10Box6',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -12.0 
  });
  
  textbox_emaType10Box7 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType10Box7',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [sliderH, sliderH],  units: undefined, 
    ori: 0.0,
    color: undefined, colorSpace: 'rgb',
    fillColor: undefined, borderColor: 'Black',
    languageStyle: 'LTR',
    bold: false, italic: false,
    opacity: undefined,
    padding: 0.0,
    alignment: 'center',
    overflow: 'visible',
    editable: false,
    multiline: true,
    anchor: 'center',
    depth: -13.0 
  });
  
  textbox_emaType10Label1 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType10Label1',
    text: '<5',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -14.0 
  });
  
  textbox_emaType10Label2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType10Label2',
    text: '5-14',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -15.0 
  });
  
  textbox_emaType10Label3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType10Label3',
    text: '15-29',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -16.0 
  });
  
  textbox_emaType10Label4 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType10Label4',
    text: '30-44',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -17.0 
  });
  
  textbox_emaType10Label5 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType10Label5',
    text: '45-59',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -18.0 
  });
  
  textbox_emaType10Label6 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType10Label6',
    text: '60-89',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -19.0 
  });
  
  textbox_emaType10Label7 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_emaType10Label7',
    text: '>=90',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0], 
    draggable: false,
    letterHeight: sliderH/2,
    lineSpacing: 1.0,
    size: [(sliderH * 2), sliderH],  units: undefined, 
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
    depth: -20.0 
  });
  
  // Initialize components for Routine "emaSkipper"
  emaSkipperClock = new util.Clock();
  // Initialize components for Routine "instructions"
  instructionsClock = new util.Clock();
  textbox_instructions_2 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_instructions_2',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0.1], 
    draggable: false,
    letterHeight: 0.035,
    lineSpacing: 1.0,
    size: [0.9, 0.6],  units: undefined, 
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
    width: submitbuttonSize[0], height: submitbuttonSize[1],
    ori: 0.0, 
    pos: submitbuttonXY, 
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
    pos: submitbuttonXY, 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: submitbuttonSize,  units: undefined, 
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
  textbox_instructions_3 = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_instructions_3',
    text: '',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0.1], 
    draggable: false,
    letterHeight: 0.035,
    lineSpacing: 1.0,
    size: [0.9, 0.6],  units: undefined, 
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
    width: submitbuttonSize[0], height: submitbuttonSize[1],
    ori: 0.0, 
    pos: submitbuttonXY, 
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
    pos: submitbuttonXY, 
    draggable: false,
    letterHeight: 0.04,
    lineSpacing: 1.0,
    size: submitbuttonSize,  units: undefined, 
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
  
  // Initialize components for Routine "choicePreparations"
  choicePreparationsClock = new util.Clock();
  // Initialize components for Routine "countdown"
  countdownClock = new util.Clock();
  countdownNum = 5;
  countdownText = countdownNum.toString();
  
  textbox_countdown = new visual.TextBox({
    win: psychoJS.window,
    name: 'textbox_countdown',
    text: '',
    placeholder: 'Type here...',
    font: 'Arial',
    pos: [0, 0], 
    draggable: false,
    letterHeight: 0.05,
    lineSpacing: 1.0,
    size: [0.5, 0.5],  units: undefined, 
    ori: 0.0,
    color: 'red', colorSpace: 'rgb',
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
    depth: 0, 
    interpolate: true, 
  });
  
  // Initialize components for Routine "choice"
  choiceClock = new util.Clock();
  choiceTimeLimit = 4; // stimulus-onset in seconds
  
  // prepare image parameter
  imgLeft = "tba";
  imgRight = "tba";
  imgLeftSize = [0.52, 0.35];
  imgLeftPos = [(- 0.33), 0];
  imgRightSize = imgLeftSize;
  imgRightPos = [0.33, 0];
  keys = [];
  
  image_choiceLeft = new visual.ImageStim({
    win : psychoJS.window,
    name : 'image_choiceLeft', units : undefined, 
    image : 'default.png', mask : undefined,
    anchor : 'center',
    ori : 0.0, 
    pos : imgLeftPos, 
    draggable: false,
    size : imgLeftSize,
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -1.0 
  });
  image_choiceRight = new visual.ImageStim({
    win : psychoJS.window,
    name : 'image_choiceRight', units : undefined, 
    image : 'default.png', mask : undefined,
    anchor : 'center',
    ori : 0.0, 
    pos : imgRightPos, 
    draggable: false,
    size : imgRightSize,
    color : new util.Color([1,1,1]), opacity : undefined,
    flipHoriz : false, flipVert : false,
    texRes : 128.0, interpolate : true, depth : -2.0 
  });
  mouse_choice = new core.Mouse({
    win: psychoJS.window,
  });
  mouse_choice.mouseClock = new util.Clock();
  reminder = new visual.TextBox({
    win: psychoJS.window,
    name: 'reminder',
    text: '!',
    placeholder: 'Type here...',
    font: 'Open Sans',
    pos: [0, 0.05], 
    draggable: false,
    letterHeight: 0.2,
    lineSpacing: 1.0,
    size: [0.1, 0.2],  units: undefined, 
    ori: 0.0,
    color: [1.0, (- 1.0), (- 1.0)], colorSpace: 'rgb',
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
    depth: -4.0 
  });
  
  key_choice = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  // Create some handy timers
  globalClock = new util.Clock();  // to track the time since experiment started
  routineTimer = new util.CountdownTimer();  // to track time remaining of each (non-slip) routine
  
  return Scheduler.Event.NEXT;
}


var t;
var frameN;
var continueRoutine;
var shelf_extractMaxDurationReached;
var shelf_extractMaxDuration;
var shelf_extractComponents;
function shelf_extractRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'shelf_extract' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    shelf_extractClock.reset();
    routineTimer.reset();
    shelf_extractMaxDurationReached = false;
    // update component parameters for each repeat
    if(continueFoodRating || !doShelfExtract){
        // the shelf extract happens before this routine, and the rest just ends
        // the experiment in case of no existing food rating.
        continueRoutine = false;
    }
    shelf_extractMaxDuration = null
    // keep track of which components have finished
    shelf_extractComponents = [];
    shelf_extractComponents.push(textbox_blockExperiment);
    
    shelf_extractComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


function shelf_extractRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'shelf_extract' ---
    // get current time
    t = shelf_extractClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *textbox_blockExperiment* updates
    if ((!continueFoodRating) && textbox_blockExperiment.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_blockExperiment.tStart = t;  // (not accounting for frame time here)
      textbox_blockExperiment.frameNStart = frameN;  // exact frame index
      
      textbox_blockExperiment.setAutoDraw(true);
    }
    
    if (textbox_blockExperiment.status === PsychoJS.Status.STARTED && t >= (textbox_blockExperiment.tStart + 10)) {
      textbox_blockExperiment.setAutoDraw(false);
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
    shelf_extractComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function shelf_extractRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'shelf_extract' ---
    shelf_extractComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    if(!continueFoodRating){ // in case there is no food rating
        quitPsychoJS('Thank you for your participation', false);
    }
    
    // the Routine "shelf_extract" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var filter_imagesMaxDurationReached;
var likingThreshold;
var filter_imagesMaxDuration;
var filter_imagesComponents;
function filter_imagesRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'filter_images' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    filter_imagesClock.reset();
    routineTimer.reset();
    filter_imagesMaxDurationReached = false;
    // update component parameters for each repeat
    // Sort each subset of food_ratings alphabetically by the first element
    food_ratings.forEach(subset => {
      subset.sort((a, b) => {
        if (Array.isArray(a) && Array.isArray(b)) {
          return a[0].localeCompare(b[0]); // Compare strings alphabetically
        }
        return 0;
      });
    });
    //console.log(food_ratings);
    
    // sort for liking values
    food_ratings.sort((a, b) => {
      const likingA = a.find(entry => entry[0] === 'liking')[1];
      const likingB = b.find(entry => entry[0] === 'liking')[1];
      return likingA - likingB; // Sort in ascending order
    });
    //console.log(food_ratings);
    
    // Filter rows with 'liking' above 50
    likingThreshold = 50;
    do {
        filteredLikings = food_ratings.filter(row => {
          const liking = row.find(entry => entry[0] === 'liking')[1];
          return liking > likingThreshold;
        });
        
        if (filteredLikings.length < 20) {
            likingThreshold -= 1;
        }
    } while (filteredLikings.length < 20)
    // TODO: debug, comment out or delete
    //console.log(filteredLikings.length)
    //console.log("foobar")
    //console.log(filteredLikings)
    
    psychoJS.experiment.addData('filter_images.started', globalClock.getTime());
    filter_imagesMaxDuration = null
    // keep track of which components have finished
    filter_imagesComponents = [];
    
    filter_imagesComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


function filter_imagesRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'filter_images' ---
    // get current time
    t = filter_imagesClock.getTime();
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
    filter_imagesComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function filter_imagesRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'filter_images' ---
    filter_imagesComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('filter_images.stopped', globalClock.getTime());
    // the Routine "filter_images" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


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
    psychoJS.experiment.addData('global_vars.started', globalClock.getTime());
    global_varsMaxDuration = null
    // keep track of which components have finished
    global_varsComponents = [];
    
    global_varsComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
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
    global_varsComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
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
    global_varsComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('global_vars.stopped', globalClock.getTime());
    // the Routine "global_vars" was not non-slip safe, so reset the non-slip timer
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
    
    language_choiceComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
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
    
    // window size
    window_height = psychoJS.window.size[1];
    window_width = psychoJS.window.size[0];
    xrange = (window_width / window_height);
    
    if ((xrange !== last_xrange)) {
        // size changed
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
    language_choiceComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


var submitbutton_text;
function language_choiceRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'language_choice' ---
    language_choiceComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    // If clicked on the german (uk) flag, the language choice is set to german (english)
    if ((mouse_languagechoice.clicked_name[0] === "image_germanyflag")) {
        languagechoice = "ger";
    } else {
        languagechoice = "uk";
    }
    
    // store chosen language
    expInfo["language"] = languagechoice;
    
    // set widely used text options
    if ((languagechoice === "ger")) {
        submitbutton_text = "Weiter";
    } else {
        submitbutton_text = "Submit";
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


var device_selectionMaxDurationReached;
var pos_sourcetext;
var device_text;
var device_list;
var device_selectionMaxDuration;
var device_selectionComponents;
function device_selectionRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'device_selection' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    device_selectionClock.reset();
    routineTimer.reset();
    device_selectionMaxDurationReached = false;
    // update component parameters for each repeat
    // window size
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = (window_width / window_height);
    yrange = (window_height / window_width);
    last_xrange = xrange;
    pos_sourcetext = [(0.3 * Math.max(1, xrange)), ((- 0.48) * Math.max(1, yrange))];
    
    // define texts
    if ((languagechoice === "ger")) {
        device_text = "Bitte w\u00e4hlen Sie das Ger\u00e4t aus, welches Sie gerade benutzen.";
        device_list = ["PC/Laptop", "Smartphone", "Tablet"];
    } else {
        device_text = "Please select the device you are currently using.";
        device_list = ["PC/Laptop", "Smartphone", "Tablet"];
    }
    
    textbox_deviceselection.setText(device_text);
    textbox_PC.setText(device_list[0]);
    textbox_smartphone.setText(device_list[1]);
    textbox_tablet.setText(device_list[2]);
    // setup some python lists for storing info about the mouse_deviceselection
    mouse_deviceselection.clicked_name = [];
    gotValidClick = false; // until a click is received
    device_selectionMaxDuration = null
    // keep track of which components have finished
    device_selectionComponents = [];
    device_selectionComponents.push(textbox_deviceselection);
    device_selectionComponents.push(button_PC);
    device_selectionComponents.push(button_smartphone);
    device_selectionComponents.push(button_tablet);
    device_selectionComponents.push(image_PC);
    device_selectionComponents.push(image_smartphone);
    device_selectionComponents.push(image_tablet);
    device_selectionComponents.push(textbox_PC);
    device_selectionComponents.push(textbox_smartphone);
    device_selectionComponents.push(textbox_tablet);
    device_selectionComponents.push(mouse_deviceselection);
    device_selectionComponents.push(textbox_sourceicons);
    
    device_selectionComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


var button_PC_opacity;
var button_smartphone_opacity;
var button_tablet_opacity;
function device_selectionRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'device_selection' ---
    // get current time
    t = device_selectionClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Run 'Each Frame' code from code_deviceselection
    // hovereffect
    if ((! mobile_device)) {
        if (button_PC.contains(mouse_deviceselection)) {
            button_PC_opacity = opacity2;
        } else {
            button_PC_opacity = opacity1;
        }
        if (button_smartphone.contains(mouse_deviceselection)) {
            button_smartphone_opacity = opacity2;
        } else {
            button_smartphone_opacity = opacity1;
        }
        if (button_tablet.contains(mouse_deviceselection)) {
            button_tablet_opacity = opacity2;
        } else {
            button_tablet_opacity = opacity1;
        }
    }
    
    // window size
    window_height = window.innerHeight;
    window_width = window.innerWidth;
    xrange = (window_width / window_height);
    if ((xrange !== last_xrange)) {
        // size changed
        last_xrange = xrange;
        yrange = (window_height / window_width);
        pos_sourcetext = [(0.3 * Math.max(1, xrange)), ((- 0.48) * Math.max(1, yrange))];
    }
    
    
    // *textbox_deviceselection* updates
    if (t >= 0.0 && textbox_deviceselection.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_deviceselection.tStart = t;  // (not accounting for frame time here)
      textbox_deviceselection.frameNStart = frameN;  // exact frame index
      
      textbox_deviceselection.setAutoDraw(true);
    }
    
    
    if (button_PC.status === PsychoJS.Status.STARTED){ // only update if being drawn
      button_PC.setOpacity(button_PC_opacity, false);
    }
    
    // *button_PC* updates
    if (t >= 0.0 && button_PC.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      button_PC.tStart = t;  // (not accounting for frame time here)
      button_PC.frameNStart = frameN;  // exact frame index
      
      button_PC.setAutoDraw(true);
    }
    
    
    if (button_smartphone.status === PsychoJS.Status.STARTED){ // only update if being drawn
      button_smartphone.setOpacity(button_smartphone_opacity, false);
    }
    
    // *button_smartphone* updates
    if (t >= 0.0 && button_smartphone.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      button_smartphone.tStart = t;  // (not accounting for frame time here)
      button_smartphone.frameNStart = frameN;  // exact frame index
      
      button_smartphone.setAutoDraw(true);
    }
    
    
    if (button_tablet.status === PsychoJS.Status.STARTED){ // only update if being drawn
      button_tablet.setOpacity(button_tablet_opacity, false);
    }
    
    // *button_tablet* updates
    if (t >= 0.0 && button_tablet.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      button_tablet.tStart = t;  // (not accounting for frame time here)
      button_tablet.frameNStart = frameN;  // exact frame index
      
      button_tablet.setAutoDraw(true);
    }
    
    
    // *image_PC* updates
    if (t >= 0.0 && image_PC.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      image_PC.tStart = t;  // (not accounting for frame time here)
      image_PC.frameNStart = frameN;  // exact frame index
      
      image_PC.setAutoDraw(true);
    }
    
    
    // *image_smartphone* updates
    if (t >= 0.0 && image_smartphone.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      image_smartphone.tStart = t;  // (not accounting for frame time here)
      image_smartphone.frameNStart = frameN;  // exact frame index
      
      image_smartphone.setAutoDraw(true);
    }
    
    
    // *image_tablet* updates
    if (t >= 0.0 && image_tablet.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      image_tablet.tStart = t;  // (not accounting for frame time here)
      image_tablet.frameNStart = frameN;  // exact frame index
      
      image_tablet.setAutoDraw(true);
    }
    
    
    // *textbox_PC* updates
    if (t >= 0.0 && textbox_PC.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_PC.tStart = t;  // (not accounting for frame time here)
      textbox_PC.frameNStart = frameN;  // exact frame index
      
      textbox_PC.setAutoDraw(true);
    }
    
    
    // *textbox_smartphone* updates
    if (t >= 0.0 && textbox_smartphone.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_smartphone.tStart = t;  // (not accounting for frame time here)
      textbox_smartphone.frameNStart = frameN;  // exact frame index
      
      textbox_smartphone.setAutoDraw(true);
    }
    
    
    // *textbox_tablet* updates
    if (t >= 0.0 && textbox_tablet.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_tablet.tStart = t;  // (not accounting for frame time here)
      textbox_tablet.frameNStart = frameN;  // exact frame index
      
      textbox_tablet.setAutoDraw(true);
    }
    
    // *mouse_deviceselection* updates
    if (t >= 0.0 && mouse_deviceselection.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_deviceselection.tStart = t;  // (not accounting for frame time here)
      mouse_deviceselection.frameNStart = frameN;  // exact frame index
      
      mouse_deviceselection.status = PsychoJS.Status.STARTED;
      mouse_deviceselection.mouseClock.reset();
      prevButtonState = mouse_deviceselection.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_deviceselection.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_deviceselection.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          mouse_deviceselection.clickableObjects = eval([button_PC, button_smartphone, button_tablet])
          ;// make sure the mouse's clickable objects are an array
          if (!Array.isArray(mouse_deviceselection.clickableObjects)) {
              mouse_deviceselection.clickableObjects = [mouse_deviceselection.clickableObjects];
          }
          // iterate through clickable objects and check each
          for (const obj of mouse_deviceselection.clickableObjects) {
              if (obj.contains(mouse_deviceselection)) {
                  gotValidClick = true;
                  mouse_deviceselection.clicked_name.push(obj.name);
              }
          }
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          mouse_deviceselection.clickableObjects = eval([button_PC, button_smartphone, button_tablet])
          ;// make sure the mouse's clickable objects are an array
          if (!Array.isArray(mouse_deviceselection.clickableObjects)) {
              mouse_deviceselection.clickableObjects = [mouse_deviceselection.clickableObjects];
          }
          // iterate through clickable objects and check each
          for (const obj of mouse_deviceselection.clickableObjects) {
              if (obj.contains(mouse_deviceselection)) {
                  gotValidClick = true;
                  mouse_deviceselection.clicked_name.push(obj.name);
              }
          }
          if (gotValidClick === true) { // end routine on response
            continueRoutine = false;
          }
        }
      }
    }
    
    if (textbox_sourceicons.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_sourceicons.setPos(pos_sourcetext, false);
    }
    
    // *textbox_sourceicons* updates
    if (t >= 0.0 && textbox_sourceicons.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_sourceicons.tStart = t;  // (not accounting for frame time here)
      textbox_sourceicons.frameNStart = frameN;  // exact frame index
      
      textbox_sourceicons.setAutoDraw(true);
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
    device_selectionComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function device_selectionRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'device_selection' ---
    device_selectionComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    // get chosen device
    if ((mouse_deviceselection.clicked_name[0] === "button_PC")) {
        mobile_device = false;
        device = "PC/Laptop";
    } else {
        mobile_device = true;
        if ((mouse_deviceselection.clicked_name[0] === "button_smartphone")) {
            device = "Smartphone";
        } else {
            device = "Tablet";
        }
    }
    
    // store chosen device
    expInfo["device"] = device;
    
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "device_selection" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var mobileLandscapeMaxDurationReached;
var mobileLandscapeMaxDuration;
var mobileLandscapeComponents;
function mobileLandscapeRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'mobileLandscape' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    mobileLandscapeClock.reset();
    routineTimer.reset();
    mobileLandscapeMaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_landscape
    // prepare text
    if ((languagechoice === "ger")) {
        requestLandscapeText = "Falls Sie das Experiment an einem Mobilger\u00e4t durchf\u00fchren, verwenden Sie bitte das Querformat und bleiben Sie bitte im Vollbildmodus. Andernfalls kann es zu Darstellungsfehlern kommen.";
    } else {
        requestLandscapeText = "If you are conducting the experiment on a mobile device, please use landscape format and stay in full screen mode. Otherwise, display problems may occur.";
    }
    
    // only run routine if a mobile device is used
    if ((! mobile_device)) {
        continueRoutine = false;
    }
    
    textbox_requestLandscape.setText(requestLandscapeText);
    textbox_submitLandscape.setText(submitbutton_text);
    // setup some python lists for storing info about the mouse_landscape
    // current position of the mouse:
    mouse_landscape.x = [];
    mouse_landscape.y = [];
    mouse_landscape.leftButton = [];
    mouse_landscape.midButton = [];
    mouse_landscape.rightButton = [];
    mouse_landscape.time = [];
    mouse_landscape.clicked_name = [];
    gotValidClick = false; // until a click is received
    psychoJS.experiment.addData('mobileLandscape.started', globalClock.getTime());
    mobileLandscapeMaxDuration = null
    // keep track of which components have finished
    mobileLandscapeComponents = [];
    mobileLandscapeComponents.push(textbox_requestLandscape);
    mobileLandscapeComponents.push(image_tiltphone);
    mobileLandscapeComponents.push(textbox_sourcetilt);
    mobileLandscapeComponents.push(polygon_landscape);
    mobileLandscapeComponents.push(textbox_submitLandscape);
    mobileLandscapeComponents.push(mouse_landscape);
    
    mobileLandscapeComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


var _mouseXYs;
function mobileLandscapeRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'mobileLandscape' ---
    // get current time
    t = mobileLandscapeClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *textbox_requestLandscape* updates
    if (t >= 0.0 && textbox_requestLandscape.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_requestLandscape.tStart = t;  // (not accounting for frame time here)
      textbox_requestLandscape.frameNStart = frameN;  // exact frame index
      
      textbox_requestLandscape.setAutoDraw(true);
    }
    
    
    // *image_tiltphone* updates
    if (t >= 0.0 && image_tiltphone.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      image_tiltphone.tStart = t;  // (not accounting for frame time here)
      image_tiltphone.frameNStart = frameN;  // exact frame index
      
      image_tiltphone.setAutoDraw(true);
    }
    
    
    // *textbox_sourcetilt* updates
    if (t >= 0.0 && textbox_sourcetilt.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_sourcetilt.tStart = t;  // (not accounting for frame time here)
      textbox_sourcetilt.frameNStart = frameN;  // exact frame index
      
      textbox_sourcetilt.setAutoDraw(true);
    }
    
    
    // *polygon_landscape* updates
    if (t >= 0.0 && polygon_landscape.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_landscape.tStart = t;  // (not accounting for frame time here)
      polygon_landscape.frameNStart = frameN;  // exact frame index
      
      polygon_landscape.setAutoDraw(true);
    }
    
    
    // *textbox_submitLandscape* updates
    if (t >= 0.0 && textbox_submitLandscape.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitLandscape.tStart = t;  // (not accounting for frame time here)
      textbox_submitLandscape.frameNStart = frameN;  // exact frame index
      
      textbox_submitLandscape.setAutoDraw(true);
    }
    
    // *mouse_landscape* updates
    if (t >= 0.0 && mouse_landscape.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_landscape.tStart = t;  // (not accounting for frame time here)
      mouse_landscape.frameNStart = frameN;  // exact frame index
      
      mouse_landscape.status = PsychoJS.Status.STARTED;
      mouse_landscape.mouseClock.reset();
      prevButtonState = mouse_landscape.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_landscape.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_landscape.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          // check if the mouse was inside our 'clickable' objects
          gotValidClick = false;
          mouse_landscape.clickableObjects = eval(polygon_landscape)
          ;// make sure the mouse's clickable objects are an array
          if (!Array.isArray(mouse_landscape.clickableObjects)) {
              mouse_landscape.clickableObjects = [mouse_landscape.clickableObjects];
          }
          // iterate through clickable objects and check each
          for (const obj of mouse_landscape.clickableObjects) {
              if (obj.contains(mouse_landscape)) {
                  gotValidClick = true;
                  mouse_landscape.clicked_name.push(obj.name);
              }
          }
          if (!gotValidClick) {
              mouse_landscape.clicked_name.push(null);
          }
          _mouseXYs = mouse_landscape.getPos();
          mouse_landscape.x.push(_mouseXYs[0]);
          mouse_landscape.y.push(_mouseXYs[1]);
          mouse_landscape.leftButton.push(_mouseButtons[0]);
          mouse_landscape.midButton.push(_mouseButtons[1]);
          mouse_landscape.rightButton.push(_mouseButtons[2]);
          mouse_landscape.time.push(mouse_landscape.mouseClock.getTime());
          if (gotValidClick === true) { // end routine on response
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
    mobileLandscapeComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function mobileLandscapeRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'mobileLandscape' ---
    mobileLandscapeComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('mobileLandscape.stopped', globalClock.getTime());
    // store data for psychoJS.experiment (ExperimentHandler)
    psychoJS.experiment.addData('mouse_landscape.x', mouse_landscape.x);
    psychoJS.experiment.addData('mouse_landscape.y', mouse_landscape.y);
    psychoJS.experiment.addData('mouse_landscape.leftButton', mouse_landscape.leftButton);
    psychoJS.experiment.addData('mouse_landscape.midButton', mouse_landscape.midButton);
    psychoJS.experiment.addData('mouse_landscape.rightButton', mouse_landscape.rightButton);
    psychoJS.experiment.addData('mouse_landscape.time', mouse_landscape.time);
    psychoJS.experiment.addData('mouse_landscape.clicked_name', mouse_landscape.clicked_name);
    
    // the Routine "mobileLandscape" was not non-slip safe, so reset the non-slip timer
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
    instructionReadLoop.forEach(function() {
      snapshot = instructionReadLoop.getSnapshot();
    
      instructionReadLoopLoopScheduler.add(importConditions(snapshot));
      instructionReadLoopLoopScheduler.add(load_instructionsRoutineBegin(snapshot));
      instructionReadLoopLoopScheduler.add(load_instructionsRoutineEachFrame());
      instructionReadLoopLoopScheduler.add(load_instructionsRoutineEnd(snapshot));
      instructionReadLoopLoopScheduler.add(instructionReadLoopLoopEndIteration(instructionReadLoopLoopScheduler, snapshot));
    });
    
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
    imageListReadLoop.forEach(function() {
      snapshot = imageListReadLoop.getSnapshot();
    
      imageListReadLoopLoopScheduler.add(importConditions(snapshot));
      imageListReadLoopLoopScheduler.add(load_imageListRoutineBegin(snapshot));
      imageListReadLoopLoopScheduler.add(load_imageListRoutineEachFrame());
      imageListReadLoopLoopScheduler.add(load_imageListRoutineEnd(snapshot));
      imageListReadLoopLoopScheduler.add(imageListReadLoopLoopEndIteration(imageListReadLoopLoopScheduler, snapshot));
    });
    
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


var questionloop;
function questionloopLoopBegin(questionloopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    questionloop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: 1, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: 'stimuli/emaQuestions.xlsx',
      seed: undefined, name: 'questionloop'
    });
    psychoJS.experiment.addLoop(questionloop); // add the loop to the experiment
    currentLoop = questionloop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    questionloop.forEach(function() {
      snapshot = questionloop.getSnapshot();
    
      questionloopLoopScheduler.add(importConditions(snapshot));
      questionloopLoopScheduler.add(emaControllerRoutineBegin(snapshot));
      questionloopLoopScheduler.add(emaControllerRoutineEachFrame());
      questionloopLoopScheduler.add(emaControllerRoutineEnd(snapshot));
      const emaType1conditionLoopLoopScheduler = new Scheduler(psychoJS);
      questionloopLoopScheduler.add(emaType1conditionLoopLoopBegin(emaType1conditionLoopLoopScheduler, snapshot));
      questionloopLoopScheduler.add(emaType1conditionLoopLoopScheduler);
      questionloopLoopScheduler.add(emaType1conditionLoopLoopEnd);
      const emaType2conditionLoopLoopScheduler = new Scheduler(psychoJS);
      questionloopLoopScheduler.add(emaType2conditionLoopLoopBegin(emaType2conditionLoopLoopScheduler, snapshot));
      questionloopLoopScheduler.add(emaType2conditionLoopLoopScheduler);
      questionloopLoopScheduler.add(emaType2conditionLoopLoopEnd);
      const emaType3ConditionLoopLoopScheduler = new Scheduler(psychoJS);
      questionloopLoopScheduler.add(emaType3ConditionLoopLoopBegin(emaType3ConditionLoopLoopScheduler, snapshot));
      questionloopLoopScheduler.add(emaType3ConditionLoopLoopScheduler);
      questionloopLoopScheduler.add(emaType3ConditionLoopLoopEnd);
      const emaType4conditionLoopLoopScheduler = new Scheduler(psychoJS);
      questionloopLoopScheduler.add(emaType4conditionLoopLoopBegin(emaType4conditionLoopLoopScheduler, snapshot));
      questionloopLoopScheduler.add(emaType4conditionLoopLoopScheduler);
      questionloopLoopScheduler.add(emaType4conditionLoopLoopEnd);
      const emaType5ConditionsLoopLoopScheduler = new Scheduler(psychoJS);
      questionloopLoopScheduler.add(emaType5ConditionsLoopLoopBegin(emaType5ConditionsLoopLoopScheduler, snapshot));
      questionloopLoopScheduler.add(emaType5ConditionsLoopLoopScheduler);
      questionloopLoopScheduler.add(emaType5ConditionsLoopLoopEnd);
      const emaType6ConditionLoopLoopScheduler = new Scheduler(psychoJS);
      questionloopLoopScheduler.add(emaType6ConditionLoopLoopBegin(emaType6ConditionLoopLoopScheduler, snapshot));
      questionloopLoopScheduler.add(emaType6ConditionLoopLoopScheduler);
      questionloopLoopScheduler.add(emaType6ConditionLoopLoopEnd);
      const emaType7ConditionLoopLoopScheduler = new Scheduler(psychoJS);
      questionloopLoopScheduler.add(emaType7ConditionLoopLoopBegin(emaType7ConditionLoopLoopScheduler, snapshot));
      questionloopLoopScheduler.add(emaType7ConditionLoopLoopScheduler);
      questionloopLoopScheduler.add(emaType7ConditionLoopLoopEnd);
      const emaType8ConditionLoopLoopScheduler = new Scheduler(psychoJS);
      questionloopLoopScheduler.add(emaType8ConditionLoopLoopBegin(emaType8ConditionLoopLoopScheduler, snapshot));
      questionloopLoopScheduler.add(emaType8ConditionLoopLoopScheduler);
      questionloopLoopScheduler.add(emaType8ConditionLoopLoopEnd);
      const emaType10ConditionLoopLoopScheduler = new Scheduler(psychoJS);
      questionloopLoopScheduler.add(emaType10ConditionLoopLoopBegin(emaType10ConditionLoopLoopScheduler, snapshot));
      questionloopLoopScheduler.add(emaType10ConditionLoopLoopScheduler);
      questionloopLoopScheduler.add(emaType10ConditionLoopLoopEnd);
      questionloopLoopScheduler.add(emaSkipperRoutineBegin(snapshot));
      questionloopLoopScheduler.add(emaSkipperRoutineEachFrame());
      questionloopLoopScheduler.add(emaSkipperRoutineEnd(snapshot));
      questionloopLoopScheduler.add(questionloopLoopEndIteration(questionloopLoopScheduler, snapshot));
    });
    
    return Scheduler.Event.NEXT;
  }
}


var emaType1conditionLoop;
function emaType1conditionLoopLoopBegin(emaType1conditionLoopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    emaType1conditionLoop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: emaType == 1, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'emaType1conditionLoop'
    });
    psychoJS.experiment.addLoop(emaType1conditionLoop); // add the loop to the experiment
    currentLoop = emaType1conditionLoop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    emaType1conditionLoop.forEach(function() {
      snapshot = emaType1conditionLoop.getSnapshot();
    
      emaType1conditionLoopLoopScheduler.add(importConditions(snapshot));
      emaType1conditionLoopLoopScheduler.add(emaType1RoutineBegin(snapshot));
      emaType1conditionLoopLoopScheduler.add(emaType1RoutineEachFrame());
      emaType1conditionLoopLoopScheduler.add(emaType1RoutineEnd(snapshot));
      emaType1conditionLoopLoopScheduler.add(emaType1conditionLoopLoopEndIteration(emaType1conditionLoopLoopScheduler, snapshot));
    });
    
    return Scheduler.Event.NEXT;
  }
}


async function emaType1conditionLoopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(emaType1conditionLoop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function emaType1conditionLoopLoopEndIteration(scheduler, snapshot) {
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


var emaType2conditionLoop;
function emaType2conditionLoopLoopBegin(emaType2conditionLoopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    emaType2conditionLoop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: emaType == 2, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'emaType2conditionLoop'
    });
    psychoJS.experiment.addLoop(emaType2conditionLoop); // add the loop to the experiment
    currentLoop = emaType2conditionLoop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    emaType2conditionLoop.forEach(function() {
      snapshot = emaType2conditionLoop.getSnapshot();
    
      emaType2conditionLoopLoopScheduler.add(importConditions(snapshot));
      emaType2conditionLoopLoopScheduler.add(emaType2RoutineBegin(snapshot));
      emaType2conditionLoopLoopScheduler.add(emaType2RoutineEachFrame());
      emaType2conditionLoopLoopScheduler.add(emaType2RoutineEnd(snapshot));
      emaType2conditionLoopLoopScheduler.add(emaType2conditionLoopLoopEndIteration(emaType2conditionLoopLoopScheduler, snapshot));
    });
    
    return Scheduler.Event.NEXT;
  }
}


async function emaType2conditionLoopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(emaType2conditionLoop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function emaType2conditionLoopLoopEndIteration(scheduler, snapshot) {
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


var emaType3ConditionLoop;
function emaType3ConditionLoopLoopBegin(emaType3ConditionLoopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    emaType3ConditionLoop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: emaType == 3, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'emaType3ConditionLoop'
    });
    psychoJS.experiment.addLoop(emaType3ConditionLoop); // add the loop to the experiment
    currentLoop = emaType3ConditionLoop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    emaType3ConditionLoop.forEach(function() {
      snapshot = emaType3ConditionLoop.getSnapshot();
    
      emaType3ConditionLoopLoopScheduler.add(importConditions(snapshot));
      emaType3ConditionLoopLoopScheduler.add(emaType3RoutineBegin(snapshot));
      emaType3ConditionLoopLoopScheduler.add(emaType3RoutineEachFrame());
      emaType3ConditionLoopLoopScheduler.add(emaType3RoutineEnd(snapshot));
      emaType3ConditionLoopLoopScheduler.add(emaType3ConditionLoopLoopEndIteration(emaType3ConditionLoopLoopScheduler, snapshot));
    });
    
    return Scheduler.Event.NEXT;
  }
}


async function emaType3ConditionLoopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(emaType3ConditionLoop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function emaType3ConditionLoopLoopEndIteration(scheduler, snapshot) {
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


var emaType4conditionLoop;
function emaType4conditionLoopLoopBegin(emaType4conditionLoopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    emaType4conditionLoop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: emaType == 4, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'emaType4conditionLoop'
    });
    psychoJS.experiment.addLoop(emaType4conditionLoop); // add the loop to the experiment
    currentLoop = emaType4conditionLoop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    emaType4conditionLoop.forEach(function() {
      snapshot = emaType4conditionLoop.getSnapshot();
    
      emaType4conditionLoopLoopScheduler.add(importConditions(snapshot));
      emaType4conditionLoopLoopScheduler.add(emaType4RoutineBegin(snapshot));
      emaType4conditionLoopLoopScheduler.add(emaType4RoutineEachFrame());
      emaType4conditionLoopLoopScheduler.add(emaType4RoutineEnd(snapshot));
      emaType4conditionLoopLoopScheduler.add(emaType4conditionLoopLoopEndIteration(emaType4conditionLoopLoopScheduler, snapshot));
    });
    
    return Scheduler.Event.NEXT;
  }
}


async function emaType4conditionLoopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(emaType4conditionLoop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function emaType4conditionLoopLoopEndIteration(scheduler, snapshot) {
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


var emaType5ConditionsLoop;
function emaType5ConditionsLoopLoopBegin(emaType5ConditionsLoopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    emaType5ConditionsLoop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: emaType == 5, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'emaType5ConditionsLoop'
    });
    psychoJS.experiment.addLoop(emaType5ConditionsLoop); // add the loop to the experiment
    currentLoop = emaType5ConditionsLoop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    emaType5ConditionsLoop.forEach(function() {
      snapshot = emaType5ConditionsLoop.getSnapshot();
    
      emaType5ConditionsLoopLoopScheduler.add(importConditions(snapshot));
      emaType5ConditionsLoopLoopScheduler.add(emaType5RoutineBegin(snapshot));
      emaType5ConditionsLoopLoopScheduler.add(emaType5RoutineEachFrame());
      emaType5ConditionsLoopLoopScheduler.add(emaType5RoutineEnd(snapshot));
      emaType5ConditionsLoopLoopScheduler.add(emaType5ConditionsLoopLoopEndIteration(emaType5ConditionsLoopLoopScheduler, snapshot));
    });
    
    return Scheduler.Event.NEXT;
  }
}


async function emaType5ConditionsLoopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(emaType5ConditionsLoop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function emaType5ConditionsLoopLoopEndIteration(scheduler, snapshot) {
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


var emaType6ConditionLoop;
function emaType6ConditionLoopLoopBegin(emaType6ConditionLoopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    emaType6ConditionLoop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: emaType == 6, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'emaType6ConditionLoop'
    });
    psychoJS.experiment.addLoop(emaType6ConditionLoop); // add the loop to the experiment
    currentLoop = emaType6ConditionLoop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    emaType6ConditionLoop.forEach(function() {
      snapshot = emaType6ConditionLoop.getSnapshot();
    
      emaType6ConditionLoopLoopScheduler.add(importConditions(snapshot));
      emaType6ConditionLoopLoopScheduler.add(emaType6RoutineBegin(snapshot));
      emaType6ConditionLoopLoopScheduler.add(emaType6RoutineEachFrame());
      emaType6ConditionLoopLoopScheduler.add(emaType6RoutineEnd(snapshot));
      emaType6ConditionLoopLoopScheduler.add(emaType6ConditionLoopLoopEndIteration(emaType6ConditionLoopLoopScheduler, snapshot));
    });
    
    return Scheduler.Event.NEXT;
  }
}


async function emaType6ConditionLoopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(emaType6ConditionLoop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function emaType6ConditionLoopLoopEndIteration(scheduler, snapshot) {
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


var emaType7ConditionLoop;
function emaType7ConditionLoopLoopBegin(emaType7ConditionLoopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    emaType7ConditionLoop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: emaType == 7, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'emaType7ConditionLoop'
    });
    psychoJS.experiment.addLoop(emaType7ConditionLoop); // add the loop to the experiment
    currentLoop = emaType7ConditionLoop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    emaType7ConditionLoop.forEach(function() {
      snapshot = emaType7ConditionLoop.getSnapshot();
    
      emaType7ConditionLoopLoopScheduler.add(importConditions(snapshot));
      emaType7ConditionLoopLoopScheduler.add(emaType7RoutineBegin(snapshot));
      emaType7ConditionLoopLoopScheduler.add(emaType7RoutineEachFrame());
      emaType7ConditionLoopLoopScheduler.add(emaType7RoutineEnd(snapshot));
      emaType7ConditionLoopLoopScheduler.add(emaType7ConditionLoopLoopEndIteration(emaType7ConditionLoopLoopScheduler, snapshot));
    });
    
    return Scheduler.Event.NEXT;
  }
}


async function emaType7ConditionLoopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(emaType7ConditionLoop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function emaType7ConditionLoopLoopEndIteration(scheduler, snapshot) {
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


var emaType8ConditionLoop;
function emaType8ConditionLoopLoopBegin(emaType8ConditionLoopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    emaType8ConditionLoop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: emaType == 8, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'emaType8ConditionLoop'
    });
    psychoJS.experiment.addLoop(emaType8ConditionLoop); // add the loop to the experiment
    currentLoop = emaType8ConditionLoop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    emaType8ConditionLoop.forEach(function() {
      snapshot = emaType8ConditionLoop.getSnapshot();
    
      emaType8ConditionLoopLoopScheduler.add(importConditions(snapshot));
      emaType8ConditionLoopLoopScheduler.add(emaType8RoutineBegin(snapshot));
      emaType8ConditionLoopLoopScheduler.add(emaType8RoutineEachFrame());
      emaType8ConditionLoopLoopScheduler.add(emaType8RoutineEnd(snapshot));
      emaType8ConditionLoopLoopScheduler.add(emaType8ConditionLoopLoopEndIteration(emaType8ConditionLoopLoopScheduler, snapshot));
    });
    
    return Scheduler.Event.NEXT;
  }
}


async function emaType8ConditionLoopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(emaType8ConditionLoop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function emaType8ConditionLoopLoopEndIteration(scheduler, snapshot) {
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


var emaType10ConditionLoop;
function emaType10ConditionLoopLoopBegin(emaType10ConditionLoopLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    emaType10ConditionLoop = new TrialHandler({
      psychoJS: psychoJS,
      nReps: emaType == 10, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'emaType10ConditionLoop'
    });
    psychoJS.experiment.addLoop(emaType10ConditionLoop); // add the loop to the experiment
    currentLoop = emaType10ConditionLoop;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    emaType10ConditionLoop.forEach(function() {
      snapshot = emaType10ConditionLoop.getSnapshot();
    
      emaType10ConditionLoopLoopScheduler.add(importConditions(snapshot));
      emaType10ConditionLoopLoopScheduler.add(emaType10RoutineBegin(snapshot));
      emaType10ConditionLoopLoopScheduler.add(emaType10RoutineEachFrame());
      emaType10ConditionLoopLoopScheduler.add(emaType10RoutineEnd(snapshot));
      emaType10ConditionLoopLoopScheduler.add(emaType10ConditionLoopLoopEndIteration(emaType10ConditionLoopLoopScheduler, snapshot));
    });
    
    return Scheduler.Event.NEXT;
  }
}


async function emaType10ConditionLoopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(emaType10ConditionLoop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function emaType10ConditionLoopLoopEndIteration(scheduler, snapshot) {
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


async function questionloopLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(questionloop);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function questionloopLoopEndIteration(scheduler, snapshot) {
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


var loop_choice;
function loop_choiceLoopBegin(loop_choiceLoopScheduler, snapshot) {
  return async function() {
    TrialHandler.fromSnapshot(snapshot); // update internal variables (.thisN etc) of the loop
    
    // set up handler to look after randomisation of conditions etc
    loop_choice = new TrialHandler({
      psychoJS: psychoJS,
      nReps: choiceLoopCount, method: TrialHandler.Method.SEQUENTIAL,
      extraInfo: expInfo, originPath: undefined,
      trialList: undefined,
      seed: undefined, name: 'loop_choice'
    });
    psychoJS.experiment.addLoop(loop_choice); // add the loop to the experiment
    currentLoop = loop_choice;  // we're now the current loop
    
    // Schedule all the trials in the trialList:
    loop_choice.forEach(function() {
      snapshot = loop_choice.getSnapshot();
    
      loop_choiceLoopScheduler.add(importConditions(snapshot));
      loop_choiceLoopScheduler.add(fixationRoutineBegin(snapshot));
      loop_choiceLoopScheduler.add(fixationRoutineEachFrame());
      loop_choiceLoopScheduler.add(fixationRoutineEnd(snapshot));
      loop_choiceLoopScheduler.add(choiceRoutineBegin(snapshot));
      loop_choiceLoopScheduler.add(choiceRoutineEachFrame());
      loop_choiceLoopScheduler.add(choiceRoutineEnd(snapshot));
      loop_choiceLoopScheduler.add(loop_choiceLoopEndIteration(loop_choiceLoopScheduler, snapshot));
    });
    
    return Scheduler.Event.NEXT;
  }
}


async function loop_choiceLoopEnd() {
  // terminate loop
  psychoJS.experiment.removeLoop(loop_choice);
  // update the current loop from the ExperimentHandler
  if (psychoJS.experiment._unfinishedLoops.length>0)
    currentLoop = psychoJS.experiment._unfinishedLoops.at(-1);
  else
    currentLoop = psychoJS.experiment;  // so we use addData from the experiment
  return Scheduler.Event.NEXT;
}


function loop_choiceLoopEndIteration(scheduler, snapshot) {
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
    psychoJS.experiment.addData('load_instructions.started', globalClock.getTime());
    load_instructionsMaxDuration = null
    // keep track of which components have finished
    load_instructionsComponents = [];
    
    load_instructionsComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
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
    load_instructionsComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
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
    load_instructionsComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('load_instructions.stopped', globalClock.getTime());
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
    psychoJS.experiment.addData('load_imageList.started', globalClock.getTime());
    load_imageListMaxDuration = null
    // keep track of which components have finished
    load_imageListComponents = [];
    
    load_imageListComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
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
    load_imageListComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
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
    load_imageListComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('load_imageList.stopped', globalClock.getTime());
    // the Routine "load_imageList" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var emaInstructionsMaxDurationReached;
var emaInstructions_text;
var emaInstructionsMaxDuration;
var emaInstructionsComponents;
function emaInstructionsRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'emaInstructions' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    emaInstructionsClock.reset();
    routineTimer.reset();
    emaInstructionsMaxDurationReached = false;
    // update component parameters for each repeat
    // text options
    if ((languagechoice === "ger")) {
        emaInstructions_text = emaInstr_ger;
    } else {
        emaInstructions_text = emaInstr_eng;
    }
    
    // make up for wrong line-breaks when reading file with javascript
    emaInstructions_text = emaInstructions_text.split('\\n').join('\n');
    textbox_instructions.setText(emaInstructions_text);
    // setup some python lists for storing info about the mouse_instructions
    mouse_instructions.clicked_name = [];
    gotValidClick = false; // until a click is received
    textbox_submitbutton.setText(submitbutton_text);
    emaInstructionsMaxDuration = null
    // keep track of which components have finished
    emaInstructionsComponents = [];
    emaInstructionsComponents.push(textbox_instructions);
    emaInstructionsComponents.push(mouse_instructions);
    emaInstructionsComponents.push(polygon_submitbutton);
    emaInstructionsComponents.push(textbox_submitbutton);
    
    emaInstructionsComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


function emaInstructionsRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'emaInstructions' ---
    // get current time
    t = emaInstructionsClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Hovereffect for submitbutton
    if ((! mobile_device)) {
        if (polygon_submitbutton.contains(mouse_instructions)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
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
    }
    
    // *polygon_submitbutton* updates
    if (t >= 0.0 && polygon_submitbutton.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbutton.tStart = t;  // (not accounting for frame time here)
      polygon_submitbutton.frameNStart = frameN;  // exact frame index
      
      polygon_submitbutton.setAutoDraw(true);
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
    emaInstructionsComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function emaInstructionsRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'emaInstructions' ---
    emaInstructionsComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    // store data for psychoJS.experiment (ExperimentHandler)
    // the Routine "emaInstructions" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var emaControllerMaxDurationReached;
var emaControllerMaxDuration;
var emaControllerComponents;
function emaControllerRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'emaController' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    emaControllerClock.reset();
    routineTimer.reset();
    emaControllerMaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_emaController
    // This routine sets the text and type of the next question, if it is not
    // skipped due to a preceeding question/response
    
    // handle data storage
    psychoJS.experiment.addData("VAS_questionNr", (questionloop.thisN + 1));
    // the emaTypeX-routines have to change this entry
    psychoJS.experiment.addData("VAS_response", "skipped");
    
    if (emaSkipNext) {
        emaType = 0; // skip current question
        emaSkipNext = false; // reset
    } else {
        emaType = emaQuestions_type;
        //emaType = 10 // TODO: debug, delete, foobar
        if ((languagechoice === "ger")) {
            emaQuestion = emaQuestions_de;
        } else {
            emaQuestion = emaQuestions_uk;
        }
    }
    
    psychoJS.experiment.addData('emaController.started', globalClock.getTime());
    emaControllerMaxDuration = null
    // keep track of which components have finished
    emaControllerComponents = [];
    
    emaControllerComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


function emaControllerRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'emaController' ---
    // get current time
    t = emaControllerClock.getTime();
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
    emaControllerComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function emaControllerRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'emaController' ---
    emaControllerComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('emaController.stopped', globalClock.getTime());
    // the Routine "emaController" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var emaType1MaxDurationReached;
var emaType1MaxDuration;
var emaType1Components;
function emaType1RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'emaType1' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    emaType1Clock.reset();
    routineTimer.reset();
    emaType1MaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_emaType1
    // set anchortext according to language
    if ((languagechoice === "ger")) {
        emaLabel1 = "\u00fcberhaupt nicht";
        emaLabel2 = "sehr";
    } else {
        emaLabel1 = "not at all";
        emaLabel2 = "very";
    }
    
    textbox_emaType1.setText(emaQuestion);
    slider_emaType1.reset()
    textbox_emaType1LeftAnchor.setText(emaLabel1);
    textbox_emaType1RightAnchor.setText(emaLabel2);
    textbox_submitbuttonType1.setText(submitbutton_text);
    // setup some python lists for storing info about the mouse_type1
    // current position of the mouse:
    mouse_type1.x = [];
    mouse_type1.y = [];
    mouse_type1.leftButton = [];
    mouse_type1.midButton = [];
    mouse_type1.rightButton = [];
    mouse_type1.time = [];
    gotValidClick = false; // until a click is received
    psychoJS.experiment.addData('emaType1.started', globalClock.getTime());
    emaType1MaxDuration = null
    // keep track of which components have finished
    emaType1Components = [];
    emaType1Components.push(textbox_emaType1);
    emaType1Components.push(slider_emaType1);
    emaType1Components.push(textbox_emaType1LeftAnchor);
    emaType1Components.push(textbox_emaType1RightAnchor);
    emaType1Components.push(polygon_submitbuttonType1);
    emaType1Components.push(textbox_submitbuttonType1);
    emaType1Components.push(mouse_type1);
    
    emaType1Components.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


var ratingDone;
var buttonPressed;
function emaType1RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'emaType1' ---
    // get current time
    t = emaType1Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Hovereffect for submitbutton
    if ((! mobile_device)) {
        if (textbox_submitbuttonType1.contains(mouse_type1)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    
    // submitbutton display condition
    ratingDone = slider_emaType1.getRating();
    if ((ratingDone !== undefined)) {
        ratingGiven = true;
    }
    
    // Check if submitbutton was pressed and end routine if true
    if ((ratingGiven && polygon_submitbuttonType1.contains(mouse_type1))) {
        buttonPressed = mouse_type1.getPressed()[0];
        if ((buttonPressed === 1)) {
            continueRoutine = false; // native PsychoJS var
        }
    }
    
    
    // *textbox_emaType1* updates
    if (t >= 0.0 && textbox_emaType1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType1.tStart = t;  // (not accounting for frame time here)
      textbox_emaType1.frameNStart = frameN;  // exact frame index
      
      textbox_emaType1.setAutoDraw(true);
    }
    
    
    // *slider_emaType1* updates
    if (t >= 0.0 && slider_emaType1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      slider_emaType1.tStart = t;  // (not accounting for frame time here)
      slider_emaType1.frameNStart = frameN;  // exact frame index
      
      slider_emaType1.setAutoDraw(true);
    }
    
    
    // *textbox_emaType1LeftAnchor* updates
    if (t >= 0.0 && textbox_emaType1LeftAnchor.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType1LeftAnchor.tStart = t;  // (not accounting for frame time here)
      textbox_emaType1LeftAnchor.frameNStart = frameN;  // exact frame index
      
      textbox_emaType1LeftAnchor.setAutoDraw(true);
    }
    
    
    // *textbox_emaType1RightAnchor* updates
    if (t >= 0.0 && textbox_emaType1RightAnchor.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType1RightAnchor.tStart = t;  // (not accounting for frame time here)
      textbox_emaType1RightAnchor.frameNStart = frameN;  // exact frame index
      
      textbox_emaType1RightAnchor.setAutoDraw(true);
    }
    
    
    if (polygon_submitbuttonType1.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_submitbuttonType1.setOpacity(submitbutton_opacity, false);
    }
    
    // *polygon_submitbuttonType1* updates
    if ((ratingGiven) && polygon_submitbuttonType1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbuttonType1.tStart = t;  // (not accounting for frame time here)
      polygon_submitbuttonType1.frameNStart = frameN;  // exact frame index
      
      polygon_submitbuttonType1.setAutoDraw(true);
    }
    
    
    // *textbox_submitbuttonType1* updates
    if ((ratingGiven) && textbox_submitbuttonType1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbuttonType1.tStart = t;  // (not accounting for frame time here)
      textbox_submitbuttonType1.frameNStart = frameN;  // exact frame index
      
      textbox_submitbuttonType1.setAutoDraw(true);
    }
    
    // *mouse_type1* updates
    if (t >= 0.0 && mouse_type1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_type1.tStart = t;  // (not accounting for frame time here)
      mouse_type1.frameNStart = frameN;  // exact frame index
      
      mouse_type1.status = PsychoJS.Status.STARTED;
      mouse_type1.mouseClock.reset();
      prevButtonState = mouse_type1.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_type1.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_type1.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          _mouseXYs = mouse_type1.getPos();
          mouse_type1.x.push(_mouseXYs[0]);
          mouse_type1.y.push(_mouseXYs[1]);
          mouse_type1.leftButton.push(_mouseButtons[0]);
          mouse_type1.midButton.push(_mouseButtons[1]);
          mouse_type1.rightButton.push(_mouseButtons[2]);
          mouse_type1.time.push(mouse_type1.mouseClock.getTime());
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
    emaType1Components.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function emaType1RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'emaType1' ---
    emaType1Components.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('emaType1.stopped', globalClock.getTime());
    // save result for eval if next question shall skip
    emaResponse = slider_emaType1.getRating();
    
    ratingGiven = false;
    
    psychoJS.experiment.addData('slider_emaType1.response', slider_emaType1.getRating());
    psychoJS.experiment.addData('slider_emaType1.rt', slider_emaType1.getRT());
    // store data for psychoJS.experiment (ExperimentHandler)
    psychoJS.experiment.addData('mouse_type1.x', mouse_type1.x);
    psychoJS.experiment.addData('mouse_type1.y', mouse_type1.y);
    psychoJS.experiment.addData('mouse_type1.leftButton', mouse_type1.leftButton);
    psychoJS.experiment.addData('mouse_type1.midButton', mouse_type1.midButton);
    psychoJS.experiment.addData('mouse_type1.rightButton', mouse_type1.rightButton);
    psychoJS.experiment.addData('mouse_type1.time', mouse_type1.time);
    
    // the Routine "emaType1" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var emaType2MaxDurationReached;
var boxCount;
var gaps;
var dist;
var emaType2MaxDuration;
var emaType2Components;
function emaType2RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'emaType2' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    emaType2Clock.reset();
    routineTimer.reset();
    emaType2MaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_emaType2
    // compute checbox positions
    boxCount = 6;
    gaps = (boxCount - 1); // amount of gaps between boxes
    dist = (sliderW / gaps); // distance between boxes
    checkBox1x = ((- sliderW) / 2);
    checkBox2x = (((- sliderW) / 2) + dist);
    checkBox3x = (((- sliderW) / 2) + (dist * 2));
    checkBox4x = (((- sliderW) / 2) + (dist * 3));
    checkBox5x = (((- sliderW) / 2) + (dist * 4));
    checkBox6x = (((- sliderW) / 2) + (dist * 5));
    
    textbox_emaType2.setText(emaQuestion);
    slider_emaType2.reset()
    textbox_submitbuttonType2.setText(submitbutton_text);
    // setup some python lists for storing info about the mouse_type2
    // current position of the mouse:
    mouse_type2.x = [];
    mouse_type2.y = [];
    mouse_type2.leftButton = [];
    mouse_type2.midButton = [];
    mouse_type2.rightButton = [];
    mouse_type2.time = [];
    gotValidClick = false; // until a click is received
    textbox_emaType2Box1.setPos([checkBox1x, sliderY]);
    textbox_emaType2Box2.setPos([checkBox2x, sliderY]);
    textbox_emaType2Box3.setPos([checkBox3x, sliderY]);
    textbox_emaType2Box4.setPos([checkBox4x, sliderY]);
    textbox_emaType2Box5.setPos([checkBox5x, sliderY]);
    textbox_emaType2Box6.setPos([checkBox6x, sliderY]);
    textbox_emaType2Label1.setPos([checkBox1x, anchorY]);
    textbox_emaType2Label2.setPos([checkBox2x, anchorY]);
    textbox_emaType2Label3.setPos([checkBox3x, anchorY]);
    textbox_emaType2Label4.setPos([checkBox4x, anchorY]);
    textbox_emaType2Label5.setPos([checkBox5x, anchorY]);
    textbox_emaType2Label6.setPos([checkBox6x, anchorY]);
    psychoJS.experiment.addData('emaType2.started', globalClock.getTime());
    emaType2MaxDuration = null
    // keep track of which components have finished
    emaType2Components = [];
    emaType2Components.push(textbox_emaType2);
    emaType2Components.push(slider_emaType2);
    emaType2Components.push(polygon_submitbuttonType2);
    emaType2Components.push(textbox_submitbuttonType2);
    emaType2Components.push(mouse_type2);
    emaType2Components.push(textbox_emaType2Box1);
    emaType2Components.push(textbox_emaType2Box2);
    emaType2Components.push(textbox_emaType2Box3);
    emaType2Components.push(textbox_emaType2Box4);
    emaType2Components.push(textbox_emaType2Box5);
    emaType2Components.push(textbox_emaType2Box6);
    emaType2Components.push(textbox_emaType2Label1);
    emaType2Components.push(textbox_emaType2Label2);
    emaType2Components.push(textbox_emaType2Label3);
    emaType2Components.push(textbox_emaType2Label4);
    emaType2Components.push(textbox_emaType2Label5);
    emaType2Components.push(textbox_emaType2Label6);
    
    emaType2Components.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


function emaType2RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'emaType2' ---
    // get current time
    t = emaType2Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Hovereffect for submitbutton
    if ((! mobile_device)) {
        if (textbox_submitbuttonType2.contains(mouse_type2)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    
    // submitbutton display condition
    ratingDone = slider_emaType2.getRating();
    if ((ratingDone !== undefined)) {
        ratingGiven = true;
    }
    
    // Check if submitbutton was pressed and end routine if true
    if ((ratingGiven && polygon_submitbuttonType2.contains(mouse_type2))) {
        buttonPressed = mouse_type2.getPressed()[0];
        if ((buttonPressed === 1)) {
            continueRoutine = false; // native PsychoJS var
        }
    }
    
    
    // *textbox_emaType2* updates
    if (t >= 0.0 && textbox_emaType2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType2.tStart = t;  // (not accounting for frame time here)
      textbox_emaType2.frameNStart = frameN;  // exact frame index
      
      textbox_emaType2.setAutoDraw(true);
    }
    
    
    // *slider_emaType2* updates
    if (t >= 0.0 && slider_emaType2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      slider_emaType2.tStart = t;  // (not accounting for frame time here)
      slider_emaType2.frameNStart = frameN;  // exact frame index
      
      slider_emaType2.setAutoDraw(true);
    }
    
    
    if (polygon_submitbuttonType2.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_submitbuttonType2.setOpacity(submitbutton_opacity, false);
    }
    
    // *polygon_submitbuttonType2* updates
    if ((ratingGiven) && polygon_submitbuttonType2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbuttonType2.tStart = t;  // (not accounting for frame time here)
      polygon_submitbuttonType2.frameNStart = frameN;  // exact frame index
      
      polygon_submitbuttonType2.setAutoDraw(true);
    }
    
    
    // *textbox_submitbuttonType2* updates
    if ((ratingGiven) && textbox_submitbuttonType2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbuttonType2.tStart = t;  // (not accounting for frame time here)
      textbox_submitbuttonType2.frameNStart = frameN;  // exact frame index
      
      textbox_submitbuttonType2.setAutoDraw(true);
    }
    
    // *mouse_type2* updates
    if (t >= 0.0 && mouse_type2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_type2.tStart = t;  // (not accounting for frame time here)
      mouse_type2.frameNStart = frameN;  // exact frame index
      
      mouse_type2.status = PsychoJS.Status.STARTED;
      mouse_type2.mouseClock.reset();
      prevButtonState = mouse_type2.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_type2.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_type2.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          _mouseXYs = mouse_type2.getPos();
          mouse_type2.x.push(_mouseXYs[0]);
          mouse_type2.y.push(_mouseXYs[1]);
          mouse_type2.leftButton.push(_mouseButtons[0]);
          mouse_type2.midButton.push(_mouseButtons[1]);
          mouse_type2.rightButton.push(_mouseButtons[2]);
          mouse_type2.time.push(mouse_type2.mouseClock.getTime());
        }
      }
    }
    
    // *textbox_emaType2Box1* updates
    if (t >= 0.0 && textbox_emaType2Box1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType2Box1.tStart = t;  // (not accounting for frame time here)
      textbox_emaType2Box1.frameNStart = frameN;  // exact frame index
      
      textbox_emaType2Box1.setAutoDraw(true);
    }
    
    
    // *textbox_emaType2Box2* updates
    if (t >= 0.0 && textbox_emaType2Box2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType2Box2.tStart = t;  // (not accounting for frame time here)
      textbox_emaType2Box2.frameNStart = frameN;  // exact frame index
      
      textbox_emaType2Box2.setAutoDraw(true);
    }
    
    
    // *textbox_emaType2Box3* updates
    if (t >= 0.0 && textbox_emaType2Box3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType2Box3.tStart = t;  // (not accounting for frame time here)
      textbox_emaType2Box3.frameNStart = frameN;  // exact frame index
      
      textbox_emaType2Box3.setAutoDraw(true);
    }
    
    
    // *textbox_emaType2Box4* updates
    if (t >= 0.0 && textbox_emaType2Box4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType2Box4.tStart = t;  // (not accounting for frame time here)
      textbox_emaType2Box4.frameNStart = frameN;  // exact frame index
      
      textbox_emaType2Box4.setAutoDraw(true);
    }
    
    
    // *textbox_emaType2Box5* updates
    if (t >= 0.0 && textbox_emaType2Box5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType2Box5.tStart = t;  // (not accounting for frame time here)
      textbox_emaType2Box5.frameNStart = frameN;  // exact frame index
      
      textbox_emaType2Box5.setAutoDraw(true);
    }
    
    
    // *textbox_emaType2Box6* updates
    if (t >= 0.0 && textbox_emaType2Box6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType2Box6.tStart = t;  // (not accounting for frame time here)
      textbox_emaType2Box6.frameNStart = frameN;  // exact frame index
      
      textbox_emaType2Box6.setAutoDraw(true);
    }
    
    
    // *textbox_emaType2Label1* updates
    if (t >= 0.0 && textbox_emaType2Label1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType2Label1.tStart = t;  // (not accounting for frame time here)
      textbox_emaType2Label1.frameNStart = frameN;  // exact frame index
      
      textbox_emaType2Label1.setAutoDraw(true);
    }
    
    
    // *textbox_emaType2Label2* updates
    if (t >= 0.0 && textbox_emaType2Label2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType2Label2.tStart = t;  // (not accounting for frame time here)
      textbox_emaType2Label2.frameNStart = frameN;  // exact frame index
      
      textbox_emaType2Label2.setAutoDraw(true);
    }
    
    
    // *textbox_emaType2Label3* updates
    if (t >= 0.0 && textbox_emaType2Label3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType2Label3.tStart = t;  // (not accounting for frame time here)
      textbox_emaType2Label3.frameNStart = frameN;  // exact frame index
      
      textbox_emaType2Label3.setAutoDraw(true);
    }
    
    
    // *textbox_emaType2Label4* updates
    if (t >= 0.0 && textbox_emaType2Label4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType2Label4.tStart = t;  // (not accounting for frame time here)
      textbox_emaType2Label4.frameNStart = frameN;  // exact frame index
      
      textbox_emaType2Label4.setAutoDraw(true);
    }
    
    
    // *textbox_emaType2Label5* updates
    if (t >= 0.0 && textbox_emaType2Label5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType2Label5.tStart = t;  // (not accounting for frame time here)
      textbox_emaType2Label5.frameNStart = frameN;  // exact frame index
      
      textbox_emaType2Label5.setAutoDraw(true);
    }
    
    
    // *textbox_emaType2Label6* updates
    if (t >= 0.0 && textbox_emaType2Label6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType2Label6.tStart = t;  // (not accounting for frame time here)
      textbox_emaType2Label6.frameNStart = frameN;  // exact frame index
      
      textbox_emaType2Label6.setAutoDraw(true);
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
    emaType2Components.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function emaType2RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'emaType2' ---
    emaType2Components.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('emaType2.stopped', globalClock.getTime());
    // save result for eval if next question shall skip
    emaResponse = slider_emaType2.getRating();
    
    ratingGiven = false;
    
    psychoJS.experiment.addData('slider_emaType2.response', slider_emaType2.getRating());
    psychoJS.experiment.addData('slider_emaType2.rt', slider_emaType2.getRT());
    // store data for psychoJS.experiment (ExperimentHandler)
    psychoJS.experiment.addData('mouse_type2.x', mouse_type2.x);
    psychoJS.experiment.addData('mouse_type2.y', mouse_type2.y);
    psychoJS.experiment.addData('mouse_type2.leftButton', mouse_type2.leftButton);
    psychoJS.experiment.addData('mouse_type2.midButton', mouse_type2.midButton);
    psychoJS.experiment.addData('mouse_type2.rightButton', mouse_type2.rightButton);
    psychoJS.experiment.addData('mouse_type2.time', mouse_type2.time);
    
    // the Routine "emaType2" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var emaType3MaxDurationReached;
var emaType3MaxDuration;
var emaType3Components;
function emaType3RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'emaType3' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    emaType3Clock.reset();
    routineTimer.reset();
    emaType3MaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_emaType3
    // set anchortext according to language
    if ((languagechoice === "ger")) {
        emaLabel1 = "Ja";
        emaLabel2 = "Nein";
    } else {
        emaLabel1 = "Yes";
        emaLabel2 = "No";
    }
    
    // compute checbox positions
    boxCount = 2;
    gaps = (boxCount - 1); // amount of gaps between boxes
    dist = (type3sliderW / gaps); // distance between boxes
    checkBox1x = ((- type3sliderW) / 2);
    checkBox2x = (((- type3sliderW) / 2) + dist);
    
    textbox_emaType3.setText(emaQuestion);
    slider_emaType3.reset()
    textbox_submitbuttonType3.setText(submitbutton_text);
    // setup some python lists for storing info about the mouse_type3
    // current position of the mouse:
    mouse_type3.x = [];
    mouse_type3.y = [];
    mouse_type3.leftButton = [];
    mouse_type3.midButton = [];
    mouse_type3.rightButton = [];
    mouse_type3.time = [];
    gotValidClick = false; // until a click is received
    textbox_emaType3Box1.setPos([checkBox1x, sliderY]);
    textbox_emaType3Box2.setPos([checkBox2x, sliderY]);
    textbox_emaType3Label1.setPos([checkBox1x, anchorY]);
    textbox_emaType3Label1.setText(emaLabel1);
    textbox_emaType3Label2.setPos([checkBox2x, anchorY]);
    textbox_emaType3Label2.setText(emaLabel2);
    psychoJS.experiment.addData('emaType3.started', globalClock.getTime());
    emaType3MaxDuration = null
    // keep track of which components have finished
    emaType3Components = [];
    emaType3Components.push(textbox_emaType3);
    emaType3Components.push(slider_emaType3);
    emaType3Components.push(polygon_submitbuttonType3);
    emaType3Components.push(textbox_submitbuttonType3);
    emaType3Components.push(mouse_type3);
    emaType3Components.push(textbox_emaType3Box1);
    emaType3Components.push(textbox_emaType3Box2);
    emaType3Components.push(textbox_emaType3Label1);
    emaType3Components.push(textbox_emaType3Label2);
    
    emaType3Components.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


function emaType3RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'emaType3' ---
    // get current time
    t = emaType3Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Hovereffect for submitbutton
    if ((! mobile_device)) {
        if (textbox_submitbuttonType3.contains(mouse_type3)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    
    // submitbutton display condition
    ratingDone = slider_emaType3.getRating();
    if ((ratingDone !== undefined)) {
        ratingGiven = true;
    }
    
    // Check if submitbutton was pressed and end routine if true
    if ((ratingGiven && polygon_submitbuttonType3.contains(mouse_type3))) {
        buttonPressed = mouse_type3.getPressed()[0];
        if ((buttonPressed === 1)) {
            continueRoutine = false; // native PsychoJS var
        }
    }
    
    
    // *textbox_emaType3* updates
    if (t >= 0.0 && textbox_emaType3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType3.tStart = t;  // (not accounting for frame time here)
      textbox_emaType3.frameNStart = frameN;  // exact frame index
      
      textbox_emaType3.setAutoDraw(true);
    }
    
    
    // *slider_emaType3* updates
    if (t >= 0.0 && slider_emaType3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      slider_emaType3.tStart = t;  // (not accounting for frame time here)
      slider_emaType3.frameNStart = frameN;  // exact frame index
      
      slider_emaType3.setAutoDraw(true);
    }
    
    
    if (polygon_submitbuttonType3.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_submitbuttonType3.setOpacity(submitbutton_opacity, false);
    }
    
    // *polygon_submitbuttonType3* updates
    if ((ratingGiven) && polygon_submitbuttonType3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbuttonType3.tStart = t;  // (not accounting for frame time here)
      polygon_submitbuttonType3.frameNStart = frameN;  // exact frame index
      
      polygon_submitbuttonType3.setAutoDraw(true);
    }
    
    
    // *textbox_submitbuttonType3* updates
    if ((ratingGiven) && textbox_submitbuttonType3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbuttonType3.tStart = t;  // (not accounting for frame time here)
      textbox_submitbuttonType3.frameNStart = frameN;  // exact frame index
      
      textbox_submitbuttonType3.setAutoDraw(true);
    }
    
    // *mouse_type3* updates
    if (t >= 0.0 && mouse_type3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_type3.tStart = t;  // (not accounting for frame time here)
      mouse_type3.frameNStart = frameN;  // exact frame index
      
      mouse_type3.status = PsychoJS.Status.STARTED;
      mouse_type3.mouseClock.reset();
      prevButtonState = mouse_type3.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_type3.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_type3.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          _mouseXYs = mouse_type3.getPos();
          mouse_type3.x.push(_mouseXYs[0]);
          mouse_type3.y.push(_mouseXYs[1]);
          mouse_type3.leftButton.push(_mouseButtons[0]);
          mouse_type3.midButton.push(_mouseButtons[1]);
          mouse_type3.rightButton.push(_mouseButtons[2]);
          mouse_type3.time.push(mouse_type3.mouseClock.getTime());
        }
      }
    }
    
    // *textbox_emaType3Box1* updates
    if (t >= 0.0 && textbox_emaType3Box1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType3Box1.tStart = t;  // (not accounting for frame time here)
      textbox_emaType3Box1.frameNStart = frameN;  // exact frame index
      
      textbox_emaType3Box1.setAutoDraw(true);
    }
    
    
    // *textbox_emaType3Box2* updates
    if (t >= 0.0 && textbox_emaType3Box2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType3Box2.tStart = t;  // (not accounting for frame time here)
      textbox_emaType3Box2.frameNStart = frameN;  // exact frame index
      
      textbox_emaType3Box2.setAutoDraw(true);
    }
    
    
    // *textbox_emaType3Label1* updates
    if (t >= 0.0 && textbox_emaType3Label1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType3Label1.tStart = t;  // (not accounting for frame time here)
      textbox_emaType3Label1.frameNStart = frameN;  // exact frame index
      
      textbox_emaType3Label1.setAutoDraw(true);
    }
    
    
    // *textbox_emaType3Label2* updates
    if (t >= 0.0 && textbox_emaType3Label2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType3Label2.tStart = t;  // (not accounting for frame time here)
      textbox_emaType3Label2.frameNStart = frameN;  // exact frame index
      
      textbox_emaType3Label2.setAutoDraw(true);
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
    emaType3Components.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function emaType3RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'emaType3' ---
    emaType3Components.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('emaType3.stopped', globalClock.getTime());
    // save result for eval if next question shall skip
    emaResponse = slider_emaType3.getRating();
    
    ratingGiven = false;
    
    psychoJS.experiment.addData('slider_emaType3.response', slider_emaType3.getRating());
    psychoJS.experiment.addData('slider_emaType3.rt', slider_emaType3.getRT());
    // store data for psychoJS.experiment (ExperimentHandler)
    psychoJS.experiment.addData('mouse_type3.x', mouse_type3.x);
    psychoJS.experiment.addData('mouse_type3.y', mouse_type3.y);
    psychoJS.experiment.addData('mouse_type3.leftButton', mouse_type3.leftButton);
    psychoJS.experiment.addData('mouse_type3.midButton', mouse_type3.midButton);
    psychoJS.experiment.addData('mouse_type3.rightButton', mouse_type3.rightButton);
    psychoJS.experiment.addData('mouse_type3.time', mouse_type3.time);
    
    // the Routine "emaType3" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var emaType4MaxDurationReached;
var emaType4MaxDuration;
var emaType4Components;
function emaType4RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'emaType4' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    emaType4Clock.reset();
    routineTimer.reset();
    emaType4MaxDurationReached = false;
    // update component parameters for each repeat
    // set anchortext according to language
    if ((languagechoice === "ger")) {
        emaLabel1 = "sehr schlecht";
        emaLabel2 = "sehr gut";
    } else {
        emaLabel1 = "very poor";
        emaLabel2 = "very good";
    }
    
    textbox_emaType4.setText(emaQuestion);
    slider_emaType4.reset()
    textbox_emaType4LeftAnchor.setText(emaLabel1);
    textbox_emaType4RightAnchor.setText(emaLabel2);
    textbox_submitbuttonType4.setText(submitbutton_text);
    // setup some python lists for storing info about the mouse_type4
    // current position of the mouse:
    mouse_type4.x = [];
    mouse_type4.y = [];
    mouse_type4.leftButton = [];
    mouse_type4.midButton = [];
    mouse_type4.rightButton = [];
    mouse_type4.time = [];
    gotValidClick = false; // until a click is received
    psychoJS.experiment.addData('emaType4.started', globalClock.getTime());
    emaType4MaxDuration = null
    // keep track of which components have finished
    emaType4Components = [];
    emaType4Components.push(textbox_emaType4);
    emaType4Components.push(slider_emaType4);
    emaType4Components.push(textbox_emaType4LeftAnchor);
    emaType4Components.push(textbox_emaType4RightAnchor);
    emaType4Components.push(polygon_submitbuttonType4);
    emaType4Components.push(textbox_submitbuttonType4);
    emaType4Components.push(mouse_type4);
    
    emaType4Components.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


function emaType4RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'emaType4' ---
    // get current time
    t = emaType4Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Hovereffect for submitbutton
    if ((! mobile_device)) {
        if (textbox_submitbuttonType4.contains(mouse_type4)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    
    // submitbutton display condition
    ratingDone = slider_emaType4.getRating();
    if ((ratingDone !== undefined)) {
        ratingGiven = true;
    }
    
    // Check if submitbutton was pressed and end routine if true
    if ((ratingGiven && polygon_submitbuttonType4.contains(mouse_type4))) {
        buttonPressed = mouse_type4.getPressed()[0];
        if ((buttonPressed === 1)) {
            continueRoutine = false; // native PsychoJS var
        }
    }
    
    
    // *textbox_emaType4* updates
    if (t >= 0.0 && textbox_emaType4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType4.tStart = t;  // (not accounting for frame time here)
      textbox_emaType4.frameNStart = frameN;  // exact frame index
      
      textbox_emaType4.setAutoDraw(true);
    }
    
    
    // *slider_emaType4* updates
    if (t >= 0.0 && slider_emaType4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      slider_emaType4.tStart = t;  // (not accounting for frame time here)
      slider_emaType4.frameNStart = frameN;  // exact frame index
      
      slider_emaType4.setAutoDraw(true);
    }
    
    
    // *textbox_emaType4LeftAnchor* updates
    if (t >= 0.0 && textbox_emaType4LeftAnchor.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType4LeftAnchor.tStart = t;  // (not accounting for frame time here)
      textbox_emaType4LeftAnchor.frameNStart = frameN;  // exact frame index
      
      textbox_emaType4LeftAnchor.setAutoDraw(true);
    }
    
    
    // *textbox_emaType4RightAnchor* updates
    if (t >= 0.0 && textbox_emaType4RightAnchor.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType4RightAnchor.tStart = t;  // (not accounting for frame time here)
      textbox_emaType4RightAnchor.frameNStart = frameN;  // exact frame index
      
      textbox_emaType4RightAnchor.setAutoDraw(true);
    }
    
    
    if (polygon_submitbuttonType4.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_submitbuttonType4.setOpacity(submitbutton_opacity, false);
    }
    
    // *polygon_submitbuttonType4* updates
    if ((ratingGiven) && polygon_submitbuttonType4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbuttonType4.tStart = t;  // (not accounting for frame time here)
      polygon_submitbuttonType4.frameNStart = frameN;  // exact frame index
      
      polygon_submitbuttonType4.setAutoDraw(true);
    }
    
    
    // *textbox_submitbuttonType4* updates
    if ((ratingGiven) && textbox_submitbuttonType4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbuttonType4.tStart = t;  // (not accounting for frame time here)
      textbox_submitbuttonType4.frameNStart = frameN;  // exact frame index
      
      textbox_submitbuttonType4.setAutoDraw(true);
    }
    
    // *mouse_type4* updates
    if (t >= 0.0 && mouse_type4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_type4.tStart = t;  // (not accounting for frame time here)
      mouse_type4.frameNStart = frameN;  // exact frame index
      
      mouse_type4.status = PsychoJS.Status.STARTED;
      mouse_type4.mouseClock.reset();
      prevButtonState = mouse_type4.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_type4.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_type4.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          _mouseXYs = mouse_type4.getPos();
          mouse_type4.x.push(_mouseXYs[0]);
          mouse_type4.y.push(_mouseXYs[1]);
          mouse_type4.leftButton.push(_mouseButtons[0]);
          mouse_type4.midButton.push(_mouseButtons[1]);
          mouse_type4.rightButton.push(_mouseButtons[2]);
          mouse_type4.time.push(mouse_type4.mouseClock.getTime());
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
    emaType4Components.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function emaType4RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'emaType4' ---
    emaType4Components.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('emaType4.stopped', globalClock.getTime());
    // save result for eval if next question shall skip
    emaResponse = slider_emaType4.getRating();
    
    ratingGiven = false;
    
    psychoJS.experiment.addData('slider_emaType4.response', slider_emaType4.getRating());
    psychoJS.experiment.addData('slider_emaType4.rt', slider_emaType4.getRT());
    // store data for psychoJS.experiment (ExperimentHandler)
    psychoJS.experiment.addData('mouse_type4.x', mouse_type4.x);
    psychoJS.experiment.addData('mouse_type4.y', mouse_type4.y);
    psychoJS.experiment.addData('mouse_type4.leftButton', mouse_type4.leftButton);
    psychoJS.experiment.addData('mouse_type4.midButton', mouse_type4.midButton);
    psychoJS.experiment.addData('mouse_type4.rightButton', mouse_type4.rightButton);
    psychoJS.experiment.addData('mouse_type4.time', mouse_type4.time);
    
    // the Routine "emaType4" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var emaType5MaxDurationReached;
var emaType5MaxDuration;
var emaType5Components;
function emaType5RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'emaType5' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    emaType5Clock.reset();
    routineTimer.reset();
    emaType5MaxDurationReached = false;
    // update component parameters for each repeat
    // set anchortext according to language
    if ((languagechoice === "ger")) {
        emaLabel1 = "Ja";
        emaLabel2 = "Nein";
        reminderText = "Bitte holen Sie das nach";
    } else {
        emaLabel1 = "Yes";
        emaLabel2 = "No";
        reminderText = "Please catch up";
    }
    
    // compute checbox positions
    boxCount = 2;
    gaps = (boxCount - 1); // amount of gaps between boxes
    dist = (type5sliderW / gaps); // distance between boxes
    checkBox1x = ((- type5sliderW) / 2);
    checkBox2x = (((- type5sliderW) / 2) + dist);
    
    textbox_emaType5.setText(emaQuestion);
    slider_emaType5.reset()
    textbox_submitbuttonType5.setText(submitbutton_text);
    // setup some python lists for storing info about the mouse_type5
    // current position of the mouse:
    mouse_type5.x = [];
    mouse_type5.y = [];
    mouse_type5.leftButton = [];
    mouse_type5.midButton = [];
    mouse_type5.rightButton = [];
    mouse_type5.time = [];
    gotValidClick = false; // until a click is received
    textbox_emaType5Box1.setPos([checkBox1x, sliderY]);
    textbox_emaType5Box2.setPos([checkBox2x, sliderY]);
    textbox_emaType5Label1.setPos([checkBox1x, anchorY]);
    textbox_emaType5Label1.setText(emaLabel1);
    textbox_emaType5Label2.setPos([checkBox2x, anchorY]);
    textbox_emaType5Label2.setText(emaLabel2);
    textbox_reminder.setText(reminderText);
    psychoJS.experiment.addData('emaType5.started', globalClock.getTime());
    emaType5MaxDuration = null
    // keep track of which components have finished
    emaType5Components = [];
    emaType5Components.push(textbox_emaType5);
    emaType5Components.push(slider_emaType5);
    emaType5Components.push(polygon_submitbuttonType5);
    emaType5Components.push(textbox_submitbuttonType5);
    emaType5Components.push(mouse_type5);
    emaType5Components.push(textbox_emaType5Box1);
    emaType5Components.push(textbox_emaType5Box2);
    emaType5Components.push(textbox_emaType5Label1);
    emaType5Components.push(textbox_emaType5Label2);
    emaType5Components.push(textbox_reminder);
    
    emaType5Components.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


function emaType5RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'emaType5' ---
    // get current time
    t = emaType5Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Hovereffect for submitbutton
    if ((! mobile_device)) {
        if (textbox_submitbuttonType5.contains(mouse_type5)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    
    // submitbutton display condition
    ratingDone = slider_emaType5.getRating();
    if ((ratingDone !== undefined)) {
        ratingGiven = true;
    }
    
    if ((ratingDone === 2)) {
        reminderCond = true;
    }
    
    // Check if submitbutton was pressed and end routine if true
    if ((ratingGiven && polygon_submitbuttonType5.contains(mouse_type5))) {
        buttonPressed = mouse_type5.getPressed()[0];
        if ((buttonPressed === 1)) {
            continueRoutine = false; // native PsychoJS var
        }
    }
    
    
    // *textbox_emaType5* updates
    if (t >= 0.0 && textbox_emaType5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType5.tStart = t;  // (not accounting for frame time here)
      textbox_emaType5.frameNStart = frameN;  // exact frame index
      
      textbox_emaType5.setAutoDraw(true);
    }
    
    
    // *slider_emaType5* updates
    if (t >= 0.0 && slider_emaType5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      slider_emaType5.tStart = t;  // (not accounting for frame time here)
      slider_emaType5.frameNStart = frameN;  // exact frame index
      
      slider_emaType5.setAutoDraw(true);
    }
    
    
    if (polygon_submitbuttonType5.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_submitbuttonType5.setOpacity(submitbutton_opacity, false);
    }
    
    // *polygon_submitbuttonType5* updates
    if ((ratingGiven) && polygon_submitbuttonType5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbuttonType5.tStart = t;  // (not accounting for frame time here)
      polygon_submitbuttonType5.frameNStart = frameN;  // exact frame index
      
      polygon_submitbuttonType5.setAutoDraw(true);
    }
    
    
    // *textbox_submitbuttonType5* updates
    if ((ratingGiven) && textbox_submitbuttonType5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbuttonType5.tStart = t;  // (not accounting for frame time here)
      textbox_submitbuttonType5.frameNStart = frameN;  // exact frame index
      
      textbox_submitbuttonType5.setAutoDraw(true);
    }
    
    // *mouse_type5* updates
    if (t >= 0.0 && mouse_type5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_type5.tStart = t;  // (not accounting for frame time here)
      mouse_type5.frameNStart = frameN;  // exact frame index
      
      mouse_type5.status = PsychoJS.Status.STARTED;
      mouse_type5.mouseClock.reset();
      prevButtonState = mouse_type5.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_type5.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_type5.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          _mouseXYs = mouse_type5.getPos();
          mouse_type5.x.push(_mouseXYs[0]);
          mouse_type5.y.push(_mouseXYs[1]);
          mouse_type5.leftButton.push(_mouseButtons[0]);
          mouse_type5.midButton.push(_mouseButtons[1]);
          mouse_type5.rightButton.push(_mouseButtons[2]);
          mouse_type5.time.push(mouse_type5.mouseClock.getTime());
        }
      }
    }
    
    // *textbox_emaType5Box1* updates
    if (t >= 0.0 && textbox_emaType5Box1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType5Box1.tStart = t;  // (not accounting for frame time here)
      textbox_emaType5Box1.frameNStart = frameN;  // exact frame index
      
      textbox_emaType5Box1.setAutoDraw(true);
    }
    
    
    // *textbox_emaType5Box2* updates
    if (t >= 0.0 && textbox_emaType5Box2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType5Box2.tStart = t;  // (not accounting for frame time here)
      textbox_emaType5Box2.frameNStart = frameN;  // exact frame index
      
      textbox_emaType5Box2.setAutoDraw(true);
    }
    
    
    // *textbox_emaType5Label1* updates
    if (t >= 0.0 && textbox_emaType5Label1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType5Label1.tStart = t;  // (not accounting for frame time here)
      textbox_emaType5Label1.frameNStart = frameN;  // exact frame index
      
      textbox_emaType5Label1.setAutoDraw(true);
    }
    
    
    // *textbox_emaType5Label2* updates
    if (t >= 0.0 && textbox_emaType5Label2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType5Label2.tStart = t;  // (not accounting for frame time here)
      textbox_emaType5Label2.frameNStart = frameN;  // exact frame index
      
      textbox_emaType5Label2.setAutoDraw(true);
    }
    
    
    // *textbox_reminder* updates
    if ((reminderCond) && textbox_reminder.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_reminder.tStart = t;  // (not accounting for frame time here)
      textbox_reminder.frameNStart = frameN;  // exact frame index
      
      textbox_reminder.setAutoDraw(true);
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
    emaType5Components.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function emaType5RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'emaType5' ---
    emaType5Components.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('emaType5.stopped', globalClock.getTime());
    // save result for eval if next question shall skip
    emaResponse = slider_emaType5.getRating();
    
    ratingGiven = false;
    reminderCond = false;
    psychoJS.experiment.addData('slider_emaType5.response', slider_emaType5.getRating());
    psychoJS.experiment.addData('slider_emaType5.rt', slider_emaType5.getRT());
    // store data for psychoJS.experiment (ExperimentHandler)
    psychoJS.experiment.addData('mouse_type5.x', mouse_type5.x);
    psychoJS.experiment.addData('mouse_type5.y', mouse_type5.y);
    psychoJS.experiment.addData('mouse_type5.leftButton', mouse_type5.leftButton);
    psychoJS.experiment.addData('mouse_type5.midButton', mouse_type5.midButton);
    psychoJS.experiment.addData('mouse_type5.rightButton', mouse_type5.rightButton);
    psychoJS.experiment.addData('mouse_type5.time', mouse_type5.time);
    
    // the Routine "emaType5" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var emaType6MaxDurationReached;
var emaType6MaxDuration;
var emaType6Components;
function emaType6RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'emaType6' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    emaType6Clock.reset();
    routineTimer.reset();
    emaType6MaxDurationReached = false;
    // update component parameters for each repeat
    // set anchortext according to language
    if ((languagechoice === "ger")) {
        emaLabel1 = "0=nie";
        emaLabel2 = "1";
        emaLabel3 = "2";
        emaLabel4 = "3";
        emaLabel5 = "4";
        emaLabel6 = "5=immer";
    } else {
        emaLabel1 = "0=never";
        emaLabel2 = "1";
        emaLabel3 = "2";
        emaLabel4 = "3";
        emaLabel5 = "4";
        emaLabel6 = "5=always";
    }
    
    // compute checbox positions
    boxCount = 6;
    gaps = (boxCount - 1); // amount of gaps between boxes
    dist = (sliderW / gaps); // distance between boxes
    checkBox1x = ((- sliderW) / 2);
    checkBox2x = (((- sliderW) / 2) + dist);
    checkBox3x = (((- sliderW) / 2) + (dist * 2));
    checkBox4x = (((- sliderW) / 2) + (dist * 3));
    checkBox5x = (((- sliderW) / 2) + (dist * 4));
    checkBox6x = (((- sliderW) / 2) + (dist * 5));
    
    textbox_emaType6.setText(emaQuestion);
    slider_emaType6.reset()
    textbox_submitbuttonType6.setText(submitbutton_text);
    // setup some python lists for storing info about the mouse_type6
    // current position of the mouse:
    mouse_type6.x = [];
    mouse_type6.y = [];
    mouse_type6.leftButton = [];
    mouse_type6.midButton = [];
    mouse_type6.rightButton = [];
    mouse_type6.time = [];
    gotValidClick = false; // until a click is received
    textbox_emaType6Box1.setPos([checkBox1x, sliderY]);
    textbox_emaType6Box2.setPos([checkBox2x, sliderY]);
    textbox_emaType6Box3.setPos([checkBox3x, sliderY]);
    textbox_emaType6Box4.setPos([checkBox4x, sliderY]);
    textbox_emaType6Box5.setPos([checkBox5x, sliderY]);
    textbox_emaType6Box6.setPos([checkBox6x, sliderY]);
    textbox_emaType6Label1.setPos([checkBox1x, anchorY]);
    textbox_emaType6Label1.setText(emaLabel1);
    textbox_emaType6Label2.setPos([checkBox2x, anchorY]);
    textbox_emaType6Label2.setText(emaLabel2);
    textbox_emaType6Label3.setPos([checkBox3x, anchorY]);
    textbox_emaType6Label3.setText(emaLabel3);
    textbox_emaType6Label4.setPos([checkBox4x, anchorY]);
    textbox_emaType6Label4.setText(emaLabel4);
    textbox_emaType6Label5.setPos([checkBox5x, anchorY]);
    textbox_emaType6Label5.setText(emaLabel5);
    textbox_emaType6Label6.setPos([checkBox6x, anchorY]);
    textbox_emaType6Label6.setText(emaLabel6);
    psychoJS.experiment.addData('emaType6.started', globalClock.getTime());
    emaType6MaxDuration = null
    // keep track of which components have finished
    emaType6Components = [];
    emaType6Components.push(textbox_emaType6);
    emaType6Components.push(slider_emaType6);
    emaType6Components.push(polygon_submitbuttonType6);
    emaType6Components.push(textbox_submitbuttonType6);
    emaType6Components.push(mouse_type6);
    emaType6Components.push(textbox_emaType6Box1);
    emaType6Components.push(textbox_emaType6Box2);
    emaType6Components.push(textbox_emaType6Box3);
    emaType6Components.push(textbox_emaType6Box4);
    emaType6Components.push(textbox_emaType6Box5);
    emaType6Components.push(textbox_emaType6Box6);
    emaType6Components.push(textbox_emaType6Label1);
    emaType6Components.push(textbox_emaType6Label2);
    emaType6Components.push(textbox_emaType6Label3);
    emaType6Components.push(textbox_emaType6Label4);
    emaType6Components.push(textbox_emaType6Label5);
    emaType6Components.push(textbox_emaType6Label6);
    
    emaType6Components.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


function emaType6RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'emaType6' ---
    // get current time
    t = emaType6Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Hovereffect for submitbutton
    if ((! mobile_device)) {
        if (textbox_submitbuttonType6.contains(mouse_type6)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    
    // submitbutton display condition
    ratingDone = slider_emaType6.getRating();
    if ((ratingDone !== undefined)) {
        ratingGiven = true;
    }
    
    // Check if submitbutton was pressed and end routine if true
    if ((ratingGiven && polygon_submitbuttonType6.contains(mouse_type6))) {
        buttonPressed = mouse_type6.getPressed()[0];
        if ((buttonPressed === 1)) {
            continueRoutine = false; // native PsychoJS var
        }
    }
    
    
    // *textbox_emaType6* updates
    if (t >= 0.0 && textbox_emaType6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType6.tStart = t;  // (not accounting for frame time here)
      textbox_emaType6.frameNStart = frameN;  // exact frame index
      
      textbox_emaType6.setAutoDraw(true);
    }
    
    
    // *slider_emaType6* updates
    if (t >= 0.0 && slider_emaType6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      slider_emaType6.tStart = t;  // (not accounting for frame time here)
      slider_emaType6.frameNStart = frameN;  // exact frame index
      
      slider_emaType6.setAutoDraw(true);
    }
    
    
    if (polygon_submitbuttonType6.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_submitbuttonType6.setOpacity(submitbutton_opacity, false);
    }
    
    // *polygon_submitbuttonType6* updates
    if ((ratingGiven) && polygon_submitbuttonType6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbuttonType6.tStart = t;  // (not accounting for frame time here)
      polygon_submitbuttonType6.frameNStart = frameN;  // exact frame index
      
      polygon_submitbuttonType6.setAutoDraw(true);
    }
    
    
    // *textbox_submitbuttonType6* updates
    if ((ratingGiven) && textbox_submitbuttonType6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbuttonType6.tStart = t;  // (not accounting for frame time here)
      textbox_submitbuttonType6.frameNStart = frameN;  // exact frame index
      
      textbox_submitbuttonType6.setAutoDraw(true);
    }
    
    // *mouse_type6* updates
    if (t >= 0.0 && mouse_type6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_type6.tStart = t;  // (not accounting for frame time here)
      mouse_type6.frameNStart = frameN;  // exact frame index
      
      mouse_type6.status = PsychoJS.Status.STARTED;
      mouse_type6.mouseClock.reset();
      prevButtonState = mouse_type6.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_type6.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_type6.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          _mouseXYs = mouse_type6.getPos();
          mouse_type6.x.push(_mouseXYs[0]);
          mouse_type6.y.push(_mouseXYs[1]);
          mouse_type6.leftButton.push(_mouseButtons[0]);
          mouse_type6.midButton.push(_mouseButtons[1]);
          mouse_type6.rightButton.push(_mouseButtons[2]);
          mouse_type6.time.push(mouse_type6.mouseClock.getTime());
        }
      }
    }
    
    // *textbox_emaType6Box1* updates
    if (t >= 0.0 && textbox_emaType6Box1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType6Box1.tStart = t;  // (not accounting for frame time here)
      textbox_emaType6Box1.frameNStart = frameN;  // exact frame index
      
      textbox_emaType6Box1.setAutoDraw(true);
    }
    
    
    // *textbox_emaType6Box2* updates
    if (t >= 0.0 && textbox_emaType6Box2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType6Box2.tStart = t;  // (not accounting for frame time here)
      textbox_emaType6Box2.frameNStart = frameN;  // exact frame index
      
      textbox_emaType6Box2.setAutoDraw(true);
    }
    
    
    // *textbox_emaType6Box3* updates
    if (t >= 0.0 && textbox_emaType6Box3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType6Box3.tStart = t;  // (not accounting for frame time here)
      textbox_emaType6Box3.frameNStart = frameN;  // exact frame index
      
      textbox_emaType6Box3.setAutoDraw(true);
    }
    
    
    // *textbox_emaType6Box4* updates
    if (t >= 0.0 && textbox_emaType6Box4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType6Box4.tStart = t;  // (not accounting for frame time here)
      textbox_emaType6Box4.frameNStart = frameN;  // exact frame index
      
      textbox_emaType6Box4.setAutoDraw(true);
    }
    
    
    // *textbox_emaType6Box5* updates
    if (t >= 0.0 && textbox_emaType6Box5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType6Box5.tStart = t;  // (not accounting for frame time here)
      textbox_emaType6Box5.frameNStart = frameN;  // exact frame index
      
      textbox_emaType6Box5.setAutoDraw(true);
    }
    
    
    // *textbox_emaType6Box6* updates
    if (t >= 0.0 && textbox_emaType6Box6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType6Box6.tStart = t;  // (not accounting for frame time here)
      textbox_emaType6Box6.frameNStart = frameN;  // exact frame index
      
      textbox_emaType6Box6.setAutoDraw(true);
    }
    
    
    // *textbox_emaType6Label1* updates
    if (t >= 0.0 && textbox_emaType6Label1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType6Label1.tStart = t;  // (not accounting for frame time here)
      textbox_emaType6Label1.frameNStart = frameN;  // exact frame index
      
      textbox_emaType6Label1.setAutoDraw(true);
    }
    
    
    // *textbox_emaType6Label2* updates
    if (t >= 0.0 && textbox_emaType6Label2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType6Label2.tStart = t;  // (not accounting for frame time here)
      textbox_emaType6Label2.frameNStart = frameN;  // exact frame index
      
      textbox_emaType6Label2.setAutoDraw(true);
    }
    
    
    // *textbox_emaType6Label3* updates
    if (t >= 0.0 && textbox_emaType6Label3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType6Label3.tStart = t;  // (not accounting for frame time here)
      textbox_emaType6Label3.frameNStart = frameN;  // exact frame index
      
      textbox_emaType6Label3.setAutoDraw(true);
    }
    
    
    // *textbox_emaType6Label4* updates
    if (t >= 0.0 && textbox_emaType6Label4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType6Label4.tStart = t;  // (not accounting for frame time here)
      textbox_emaType6Label4.frameNStart = frameN;  // exact frame index
      
      textbox_emaType6Label4.setAutoDraw(true);
    }
    
    
    // *textbox_emaType6Label5* updates
    if (t >= 0.0 && textbox_emaType6Label5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType6Label5.tStart = t;  // (not accounting for frame time here)
      textbox_emaType6Label5.frameNStart = frameN;  // exact frame index
      
      textbox_emaType6Label5.setAutoDraw(true);
    }
    
    
    // *textbox_emaType6Label6* updates
    if (t >= 0.0 && textbox_emaType6Label6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType6Label6.tStart = t;  // (not accounting for frame time here)
      textbox_emaType6Label6.frameNStart = frameN;  // exact frame index
      
      textbox_emaType6Label6.setAutoDraw(true);
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
    emaType6Components.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function emaType6RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'emaType6' ---
    emaType6Components.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('emaType6.stopped', globalClock.getTime());
    // save result for eval if next question shall skip
    emaResponse = slider_emaType6.getRating();
    
    ratingGiven = false;
    
    psychoJS.experiment.addData('slider_emaType6.response', slider_emaType6.getRating());
    psychoJS.experiment.addData('slider_emaType6.rt', slider_emaType6.getRT());
    // store data for psychoJS.experiment (ExperimentHandler)
    psychoJS.experiment.addData('mouse_type6.x', mouse_type6.x);
    psychoJS.experiment.addData('mouse_type6.y', mouse_type6.y);
    psychoJS.experiment.addData('mouse_type6.leftButton', mouse_type6.leftButton);
    psychoJS.experiment.addData('mouse_type6.midButton', mouse_type6.midButton);
    psychoJS.experiment.addData('mouse_type6.rightButton', mouse_type6.rightButton);
    psychoJS.experiment.addData('mouse_type6.time', mouse_type6.time);
    
    // the Routine "emaType6" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var emaType7MaxDurationReached;
var emaType7MaxDuration;
var emaType7Components;
function emaType7RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'emaType7' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    emaType7Clock.reset();
    routineTimer.reset();
    emaType7MaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_emaType7
    // set anchortext according to language
    if ((languagechoice === "ger")) {
        emaLabel1 = "Stimme \u00fcberhaupt nicht zu";
        emaLabel2 = "Stimme nicht zu";
        emaLabel3 = "Stimme eher nicht zu";
        emaLabel4 = "Stimme eher zu";
        emaLabel5 = "Stimme zu";
        emaLabel6 = "Stimme vollst\u00e4ndig zu";
    } else {
        emaLabel1 = "Strongly disagree";
        emaLabel2 = "Moderately disagree";
        emaLabel3 = "Mildly disagree";
        emaLabel4 = "Mildly agree";
        emaLabel5 = "Moderately agree";
        emaLabel6 = "Strongly agree";
    }
    
    // compute checkbox positions
    boxCount = 6;
    gaps = (boxCount - 1); // amount of gaps between boxes
    dist = (sliderW / gaps); // distance between boxes
    checkBox1x = ((- sliderW) / 2);
    checkBox2x = (((- sliderW) / 2) + dist);
    checkBox3x = (((- sliderW) / 2) + (dist * 2));
    checkBox4x = (((- sliderW) / 2) + (dist * 3));
    checkBox5x = (((- sliderW) / 2) + (dist * 4));
    checkBox6x = (((- sliderW) / 2) + (dist * 5));
    
    textbox_emaType7.setText(emaQuestion);
    slider_emaType7.reset()
    textbox_submitbuttonType7.setText(submitbutton_text);
    // setup some python lists for storing info about the mouse_type7
    // current position of the mouse:
    mouse_type7.x = [];
    mouse_type7.y = [];
    mouse_type7.leftButton = [];
    mouse_type7.midButton = [];
    mouse_type7.rightButton = [];
    mouse_type7.time = [];
    gotValidClick = false; // until a click is received
    textbox_emaType7Box1.setPos([checkBox1x, sliderY]);
    textbox_emaType7Box2.setPos([checkBox2x, sliderY]);
    textbox_emaType7Box3.setPos([checkBox3x, sliderY]);
    textbox_emaType7Box4.setPos([checkBox4x, sliderY]);
    textbox_emaType7Box5.setPos([checkBox5x, sliderY]);
    textbox_emaType7Box6.setPos([checkBox6x, sliderY]);
    textbox_emaType7Label1.setPos([checkBox1x, type7anchorY]);
    textbox_emaType7Label1.setText(emaLabel1);
    textbox_emaType7Label2.setPos([checkBox2x, type7anchorY]);
    textbox_emaType7Label2.setText(emaLabel2);
    textbox_emaType7Label3.setPos([checkBox3x, type7anchorY]);
    textbox_emaType7Label3.setText(emaLabel3);
    textbox_emaType7Label4.setPos([checkBox4x, type7anchorY]);
    textbox_emaType7Label4.setText(emaLabel4);
    textbox_emaType7Label5.setPos([checkBox5x, type7anchorY]);
    textbox_emaType7Label5.setText(emaLabel5);
    textbox_emaType7Label6.setPos([checkBox6x, type7anchorY]);
    textbox_emaType7Label6.setText(emaLabel6);
    psychoJS.experiment.addData('emaType7.started', globalClock.getTime());
    emaType7MaxDuration = null
    // keep track of which components have finished
    emaType7Components = [];
    emaType7Components.push(textbox_emaType7);
    emaType7Components.push(slider_emaType7);
    emaType7Components.push(polygon_submitbuttonType7);
    emaType7Components.push(textbox_submitbuttonType7);
    emaType7Components.push(mouse_type7);
    emaType7Components.push(textbox_emaType7Box1);
    emaType7Components.push(textbox_emaType7Box2);
    emaType7Components.push(textbox_emaType7Box3);
    emaType7Components.push(textbox_emaType7Box4);
    emaType7Components.push(textbox_emaType7Box5);
    emaType7Components.push(textbox_emaType7Box6);
    emaType7Components.push(textbox_emaType7Label1);
    emaType7Components.push(textbox_emaType7Label2);
    emaType7Components.push(textbox_emaType7Label3);
    emaType7Components.push(textbox_emaType7Label4);
    emaType7Components.push(textbox_emaType7Label5);
    emaType7Components.push(textbox_emaType7Label6);
    
    emaType7Components.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


function emaType7RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'emaType7' ---
    // get current time
    t = emaType7Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Hovereffect for submitbutton
    if ((! mobile_device)) {
        if (textbox_submitbuttonType7.contains(mouse_type7)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    
    // submitbutton display condition
    ratingDone = slider_emaType7.getRating();
    if ((ratingDone !== undefined)) {
        ratingGiven = true;
    }
    
    // Check if submitbutton was pressed and end routine if true
    if ((ratingGiven && polygon_submitbuttonType7.contains(mouse_type7))) {
        buttonPressed = mouse_type7.getPressed()[0];
        if ((buttonPressed === 1)) {
            continueRoutine = false; // native PsychoJS var
        }
    }
    
    
    // *textbox_emaType7* updates
    if (t >= 0.0 && textbox_emaType7.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType7.tStart = t;  // (not accounting for frame time here)
      textbox_emaType7.frameNStart = frameN;  // exact frame index
      
      textbox_emaType7.setAutoDraw(true);
    }
    
    
    // *slider_emaType7* updates
    if (t >= 0.0 && slider_emaType7.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      slider_emaType7.tStart = t;  // (not accounting for frame time here)
      slider_emaType7.frameNStart = frameN;  // exact frame index
      
      slider_emaType7.setAutoDraw(true);
    }
    
    
    if (polygon_submitbuttonType7.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_submitbuttonType7.setOpacity(submitbutton_opacity, false);
    }
    
    // *polygon_submitbuttonType7* updates
    if ((ratingGiven) && polygon_submitbuttonType7.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbuttonType7.tStart = t;  // (not accounting for frame time here)
      polygon_submitbuttonType7.frameNStart = frameN;  // exact frame index
      
      polygon_submitbuttonType7.setAutoDraw(true);
    }
    
    
    // *textbox_submitbuttonType7* updates
    if ((ratingGiven) && textbox_submitbuttonType7.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbuttonType7.tStart = t;  // (not accounting for frame time here)
      textbox_submitbuttonType7.frameNStart = frameN;  // exact frame index
      
      textbox_submitbuttonType7.setAutoDraw(true);
    }
    
    // *mouse_type7* updates
    if (t >= 0.0 && mouse_type7.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_type7.tStart = t;  // (not accounting for frame time here)
      mouse_type7.frameNStart = frameN;  // exact frame index
      
      mouse_type7.status = PsychoJS.Status.STARTED;
      mouse_type7.mouseClock.reset();
      prevButtonState = mouse_type7.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_type7.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_type7.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          _mouseXYs = mouse_type7.getPos();
          mouse_type7.x.push(_mouseXYs[0]);
          mouse_type7.y.push(_mouseXYs[1]);
          mouse_type7.leftButton.push(_mouseButtons[0]);
          mouse_type7.midButton.push(_mouseButtons[1]);
          mouse_type7.rightButton.push(_mouseButtons[2]);
          mouse_type7.time.push(mouse_type7.mouseClock.getTime());
        }
      }
    }
    
    // *textbox_emaType7Box1* updates
    if (t >= 0.0 && textbox_emaType7Box1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType7Box1.tStart = t;  // (not accounting for frame time here)
      textbox_emaType7Box1.frameNStart = frameN;  // exact frame index
      
      textbox_emaType7Box1.setAutoDraw(true);
    }
    
    
    // *textbox_emaType7Box2* updates
    if (t >= 0.0 && textbox_emaType7Box2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType7Box2.tStart = t;  // (not accounting for frame time here)
      textbox_emaType7Box2.frameNStart = frameN;  // exact frame index
      
      textbox_emaType7Box2.setAutoDraw(true);
    }
    
    
    // *textbox_emaType7Box3* updates
    if (t >= 0.0 && textbox_emaType7Box3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType7Box3.tStart = t;  // (not accounting for frame time here)
      textbox_emaType7Box3.frameNStart = frameN;  // exact frame index
      
      textbox_emaType7Box3.setAutoDraw(true);
    }
    
    
    // *textbox_emaType7Box4* updates
    if (t >= 0.0 && textbox_emaType7Box4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType7Box4.tStart = t;  // (not accounting for frame time here)
      textbox_emaType7Box4.frameNStart = frameN;  // exact frame index
      
      textbox_emaType7Box4.setAutoDraw(true);
    }
    
    
    // *textbox_emaType7Box5* updates
    if (t >= 0.0 && textbox_emaType7Box5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType7Box5.tStart = t;  // (not accounting for frame time here)
      textbox_emaType7Box5.frameNStart = frameN;  // exact frame index
      
      textbox_emaType7Box5.setAutoDraw(true);
    }
    
    
    // *textbox_emaType7Box6* updates
    if (t >= 0.0 && textbox_emaType7Box6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType7Box6.tStart = t;  // (not accounting for frame time here)
      textbox_emaType7Box6.frameNStart = frameN;  // exact frame index
      
      textbox_emaType7Box6.setAutoDraw(true);
    }
    
    
    // *textbox_emaType7Label1* updates
    if (t >= 0.0 && textbox_emaType7Label1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType7Label1.tStart = t;  // (not accounting for frame time here)
      textbox_emaType7Label1.frameNStart = frameN;  // exact frame index
      
      textbox_emaType7Label1.setAutoDraw(true);
    }
    
    
    // *textbox_emaType7Label2* updates
    if (t >= 0.0 && textbox_emaType7Label2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType7Label2.tStart = t;  // (not accounting for frame time here)
      textbox_emaType7Label2.frameNStart = frameN;  // exact frame index
      
      textbox_emaType7Label2.setAutoDraw(true);
    }
    
    
    // *textbox_emaType7Label3* updates
    if (t >= 0.0 && textbox_emaType7Label3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType7Label3.tStart = t;  // (not accounting for frame time here)
      textbox_emaType7Label3.frameNStart = frameN;  // exact frame index
      
      textbox_emaType7Label3.setAutoDraw(true);
    }
    
    
    // *textbox_emaType7Label4* updates
    if (t >= 0.0 && textbox_emaType7Label4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType7Label4.tStart = t;  // (not accounting for frame time here)
      textbox_emaType7Label4.frameNStart = frameN;  // exact frame index
      
      textbox_emaType7Label4.setAutoDraw(true);
    }
    
    
    // *textbox_emaType7Label5* updates
    if (t >= 0.0 && textbox_emaType7Label5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType7Label5.tStart = t;  // (not accounting for frame time here)
      textbox_emaType7Label5.frameNStart = frameN;  // exact frame index
      
      textbox_emaType7Label5.setAutoDraw(true);
    }
    
    
    // *textbox_emaType7Label6* updates
    if (t >= 0.0 && textbox_emaType7Label6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType7Label6.tStart = t;  // (not accounting for frame time here)
      textbox_emaType7Label6.frameNStart = frameN;  // exact frame index
      
      textbox_emaType7Label6.setAutoDraw(true);
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
    emaType7Components.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function emaType7RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'emaType7' ---
    emaType7Components.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('emaType7.stopped', globalClock.getTime());
    // save result for eval if next question shall skip
    emaResponse = slider_emaType7.getRating();
    
    ratingGiven = false;
    
    psychoJS.experiment.addData('slider_emaType7.response', slider_emaType7.getRating());
    psychoJS.experiment.addData('slider_emaType7.rt', slider_emaType7.getRT());
    // store data for psychoJS.experiment (ExperimentHandler)
    psychoJS.experiment.addData('mouse_type7.x', mouse_type7.x);
    psychoJS.experiment.addData('mouse_type7.y', mouse_type7.y);
    psychoJS.experiment.addData('mouse_type7.leftButton', mouse_type7.leftButton);
    psychoJS.experiment.addData('mouse_type7.midButton', mouse_type7.midButton);
    psychoJS.experiment.addData('mouse_type7.rightButton', mouse_type7.rightButton);
    psychoJS.experiment.addData('mouse_type7.time', mouse_type7.time);
    
    // the Routine "emaType7" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var emaType8MaxDurationReached;
var emaType8MaxDuration;
var emaType8Components;
function emaType8RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'emaType8' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    emaType8Clock.reset();
    routineTimer.reset();
    emaType8MaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_emaType8
    // set anchortext according to language
    if ((languagechoice === "ger")) {
        emaLabel1 = "Weniger";
        emaLabel2 = "Gleiche Menge";
        emaLabel3 = "Mehr";
    } else {
        emaLabel1 = "Less";
        emaLabel2 = "same amount";
        emaLabel3 = "More";
    }
    
    // compute checbox positions
    boxCount = 3;
    gaps = (boxCount - 1); // amount of gaps between boxes
    dist = (sliderW / gaps); // distance between boxes
    checkBox1x = ((- sliderW) / 2);
    checkBox2x = (((- sliderW) / 2) + dist);
    checkBox3x = (((- sliderW) / 2) + (dist * 2));
    
    textbox_emaType8.setText(emaQuestion);
    slider_emaType8.reset()
    textbox_submitbuttonType8.setText(submitbutton_text);
    // setup some python lists for storing info about the mouse_type8
    // current position of the mouse:
    mouse_type8.x = [];
    mouse_type8.y = [];
    mouse_type8.leftButton = [];
    mouse_type8.midButton = [];
    mouse_type8.rightButton = [];
    mouse_type8.time = [];
    gotValidClick = false; // until a click is received
    textbox_emaType8Box1.setPos([checkBox1x, sliderY]);
    textbox_emaType8Box2.setPos([checkBox2x, sliderY]);
    textbox_emaType8Box3.setPos([checkBox3x, sliderY]);
    textbox_emaType8Label1.setPos([checkBox1x, anchorY]);
    textbox_emaType8Label1.setText(emaLabel1);
    textbox_emaType8Label2.setPos([checkBox2x, anchorY]);
    textbox_emaType8Label2.setText(emaLabel2);
    textbox_emaType8Label3.setPos([checkBox3x, anchorY]);
    textbox_emaType8Label3.setText(emaLabel3);
    psychoJS.experiment.addData('emaType8.started', globalClock.getTime());
    emaType8MaxDuration = null
    // keep track of which components have finished
    emaType8Components = [];
    emaType8Components.push(textbox_emaType8);
    emaType8Components.push(slider_emaType8);
    emaType8Components.push(polygon_submitbuttonType8);
    emaType8Components.push(textbox_submitbuttonType8);
    emaType8Components.push(mouse_type8);
    emaType8Components.push(textbox_emaType8Box1);
    emaType8Components.push(textbox_emaType8Box2);
    emaType8Components.push(textbox_emaType8Box3);
    emaType8Components.push(textbox_emaType8Label1);
    emaType8Components.push(textbox_emaType8Label2);
    emaType8Components.push(textbox_emaType8Label3);
    
    emaType8Components.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


function emaType8RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'emaType8' ---
    // get current time
    t = emaType8Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Hovereffect for submitbutton
    if ((! mobile_device)) {
        if (textbox_submitbuttonType8.contains(mouse_type8)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    
    // submitbutton display condition
    ratingDone = slider_emaType8.getRating();
    if ((ratingDone !== undefined)) {
        ratingGiven = true;
    }
    
    // Check if submitbutton was pressed and end routine if true
    if ((ratingGiven && polygon_submitbuttonType8.contains(mouse_type8))) {
        buttonPressed = mouse_type8.getPressed()[0];
        if ((buttonPressed === 1)) {
            continueRoutine = false; // native PsychoJS var
        }
    }
    
    
    // *textbox_emaType8* updates
    if (t >= 0.0 && textbox_emaType8.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType8.tStart = t;  // (not accounting for frame time here)
      textbox_emaType8.frameNStart = frameN;  // exact frame index
      
      textbox_emaType8.setAutoDraw(true);
    }
    
    
    // *slider_emaType8* updates
    if (t >= 0.0 && slider_emaType8.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      slider_emaType8.tStart = t;  // (not accounting for frame time here)
      slider_emaType8.frameNStart = frameN;  // exact frame index
      
      slider_emaType8.setAutoDraw(true);
    }
    
    
    if (polygon_submitbuttonType8.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_submitbuttonType8.setOpacity(submitbutton_opacity, false);
    }
    
    // *polygon_submitbuttonType8* updates
    if ((ratingGiven) && polygon_submitbuttonType8.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbuttonType8.tStart = t;  // (not accounting for frame time here)
      polygon_submitbuttonType8.frameNStart = frameN;  // exact frame index
      
      polygon_submitbuttonType8.setAutoDraw(true);
    }
    
    
    // *textbox_submitbuttonType8* updates
    if ((ratingGiven) && textbox_submitbuttonType8.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbuttonType8.tStart = t;  // (not accounting for frame time here)
      textbox_submitbuttonType8.frameNStart = frameN;  // exact frame index
      
      textbox_submitbuttonType8.setAutoDraw(true);
    }
    
    // *mouse_type8* updates
    if (t >= 0.0 && mouse_type8.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_type8.tStart = t;  // (not accounting for frame time here)
      mouse_type8.frameNStart = frameN;  // exact frame index
      
      mouse_type8.status = PsychoJS.Status.STARTED;
      mouse_type8.mouseClock.reset();
      prevButtonState = mouse_type8.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_type8.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_type8.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          _mouseXYs = mouse_type8.getPos();
          mouse_type8.x.push(_mouseXYs[0]);
          mouse_type8.y.push(_mouseXYs[1]);
          mouse_type8.leftButton.push(_mouseButtons[0]);
          mouse_type8.midButton.push(_mouseButtons[1]);
          mouse_type8.rightButton.push(_mouseButtons[2]);
          mouse_type8.time.push(mouse_type8.mouseClock.getTime());
        }
      }
    }
    
    // *textbox_emaType8Box1* updates
    if (t >= 0.0 && textbox_emaType8Box1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType8Box1.tStart = t;  // (not accounting for frame time here)
      textbox_emaType8Box1.frameNStart = frameN;  // exact frame index
      
      textbox_emaType8Box1.setAutoDraw(true);
    }
    
    
    // *textbox_emaType8Box2* updates
    if (t >= 0.0 && textbox_emaType8Box2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType8Box2.tStart = t;  // (not accounting for frame time here)
      textbox_emaType8Box2.frameNStart = frameN;  // exact frame index
      
      textbox_emaType8Box2.setAutoDraw(true);
    }
    
    
    // *textbox_emaType8Box3* updates
    if (t >= 0.0 && textbox_emaType8Box3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType8Box3.tStart = t;  // (not accounting for frame time here)
      textbox_emaType8Box3.frameNStart = frameN;  // exact frame index
      
      textbox_emaType8Box3.setAutoDraw(true);
    }
    
    
    // *textbox_emaType8Label1* updates
    if (t >= 0.0 && textbox_emaType8Label1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType8Label1.tStart = t;  // (not accounting for frame time here)
      textbox_emaType8Label1.frameNStart = frameN;  // exact frame index
      
      textbox_emaType8Label1.setAutoDraw(true);
    }
    
    
    // *textbox_emaType8Label2* updates
    if (t >= 0.0 && textbox_emaType8Label2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType8Label2.tStart = t;  // (not accounting for frame time here)
      textbox_emaType8Label2.frameNStart = frameN;  // exact frame index
      
      textbox_emaType8Label2.setAutoDraw(true);
    }
    
    
    // *textbox_emaType8Label3* updates
    if (t >= 0.0 && textbox_emaType8Label3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType8Label3.tStart = t;  // (not accounting for frame time here)
      textbox_emaType8Label3.frameNStart = frameN;  // exact frame index
      
      textbox_emaType8Label3.setAutoDraw(true);
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
    emaType8Components.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function emaType8RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'emaType8' ---
    emaType8Components.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('emaType8.stopped', globalClock.getTime());
    // save result for eval if next question shall skip
    emaResponse = slider_emaType8.getRating();
    
    ratingGiven = false;
    
    psychoJS.experiment.addData('slider_emaType8.response', slider_emaType8.getRating());
    psychoJS.experiment.addData('slider_emaType8.rt', slider_emaType8.getRT());
    // store data for psychoJS.experiment (ExperimentHandler)
    psychoJS.experiment.addData('mouse_type8.x', mouse_type8.x);
    psychoJS.experiment.addData('mouse_type8.y', mouse_type8.y);
    psychoJS.experiment.addData('mouse_type8.leftButton', mouse_type8.leftButton);
    psychoJS.experiment.addData('mouse_type8.midButton', mouse_type8.midButton);
    psychoJS.experiment.addData('mouse_type8.rightButton', mouse_type8.rightButton);
    psychoJS.experiment.addData('mouse_type8.time', mouse_type8.time);
    
    // the Routine "emaType8" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var emaType10MaxDurationReached;
var emaType10MaxDuration;
var emaType10Components;
function emaType10RoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'emaType10' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    emaType10Clock.reset();
    routineTimer.reset();
    emaType10MaxDurationReached = false;
    // update component parameters for each repeat
    // Run 'Begin Routine' code from code_emaType10
    // compute checbox positions
    boxCount = 7;
    gaps = (boxCount - 1); // amount of gaps between boxes
    dist = (sliderW / gaps); // distance between boxes
    checkBox1x = ((- sliderW) / 2);
    checkBox2x = (((- sliderW) / 2) + dist);
    checkBox3x = (((- sliderW) / 2) + (dist * 2));
    checkBox4x = (((- sliderW) / 2) + (dist * 3));
    checkBox5x = (((- sliderW) / 2) + (dist * 4));
    checkBox6x = (((- sliderW) / 2) + (dist * 5));
    checkBox7x = (((- sliderW) / 2) + (dist * 6));
    
    textbox_emaType10.setText(emaQuestion);
    slider_emaType10.reset()
    textbox_submitbuttonType10.setText(submitbutton_text);
    // setup some python lists for storing info about the mouse_type10
    // current position of the mouse:
    mouse_type10.x = [];
    mouse_type10.y = [];
    mouse_type10.leftButton = [];
    mouse_type10.midButton = [];
    mouse_type10.rightButton = [];
    mouse_type10.time = [];
    gotValidClick = false; // until a click is received
    textbox_emaType10Box1.setPos([checkBox1x, sliderY]);
    textbox_emaType10Box2.setPos([checkBox2x, sliderY]);
    textbox_emaType10Box3.setPos([checkBox3x, sliderY]);
    textbox_emaType10Box4.setPos([checkBox4x, sliderY]);
    textbox_emaType10Box5.setPos([checkBox5x, sliderY]);
    textbox_emaType10Box6.setPos([checkBox6x, sliderY]);
    textbox_emaType10Box7.setPos([checkBox7x, sliderY]);
    textbox_emaType10Label1.setPos([checkBox1x, anchorY]);
    textbox_emaType10Label2.setPos([checkBox2x, anchorY]);
    textbox_emaType10Label3.setPos([checkBox3x, anchorY]);
    textbox_emaType10Label4.setPos([checkBox4x, anchorY]);
    textbox_emaType10Label5.setPos([checkBox5x, anchorY]);
    textbox_emaType10Label6.setPos([checkBox6x, anchorY]);
    textbox_emaType10Label7.setPos([checkBox7x, anchorY]);
    psychoJS.experiment.addData('emaType10.started', globalClock.getTime());
    emaType10MaxDuration = null
    // keep track of which components have finished
    emaType10Components = [];
    emaType10Components.push(textbox_emaType10);
    emaType10Components.push(slider_emaType10);
    emaType10Components.push(polygon_submitbuttonType10);
    emaType10Components.push(textbox_submitbuttonType10);
    emaType10Components.push(mouse_type10);
    emaType10Components.push(textbox_emaType10Box1);
    emaType10Components.push(textbox_emaType10Box2);
    emaType10Components.push(textbox_emaType10Box3);
    emaType10Components.push(textbox_emaType10Box4);
    emaType10Components.push(textbox_emaType10Box5);
    emaType10Components.push(textbox_emaType10Box6);
    emaType10Components.push(textbox_emaType10Box7);
    emaType10Components.push(textbox_emaType10Label1);
    emaType10Components.push(textbox_emaType10Label2);
    emaType10Components.push(textbox_emaType10Label3);
    emaType10Components.push(textbox_emaType10Label4);
    emaType10Components.push(textbox_emaType10Label5);
    emaType10Components.push(textbox_emaType10Label6);
    emaType10Components.push(textbox_emaType10Label7);
    
    emaType10Components.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


function emaType10RoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'emaType10' ---
    // get current time
    t = emaType10Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // Hovereffect for submitbutton
    if ((! mobile_device)) {
        if (textbox_submitbuttonType10.contains(mouse_type10)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
    }
    
    // submitbutton display condition
    ratingDone = slider_emaType10.getRating();
    if ((ratingDone !== undefined)) {
        ratingGiven = true;
    }
    
    // Check if submitbutton was pressed and end routine if true
    if ((ratingGiven && polygon_submitbuttonType10.contains(mouse_type10))) {
        buttonPressed = mouse_type10.getPressed()[0];
        if ((buttonPressed === 1)) {
            continueRoutine = false; // native PsychoJS var
        }
    }
    
    
    // *textbox_emaType10* updates
    if (t >= 0.0 && textbox_emaType10.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType10.tStart = t;  // (not accounting for frame time here)
      textbox_emaType10.frameNStart = frameN;  // exact frame index
      
      textbox_emaType10.setAutoDraw(true);
    }
    
    
    // *slider_emaType10* updates
    if (t >= 0.0 && slider_emaType10.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      slider_emaType10.tStart = t;  // (not accounting for frame time here)
      slider_emaType10.frameNStart = frameN;  // exact frame index
      
      slider_emaType10.setAutoDraw(true);
    }
    
    
    if (polygon_submitbuttonType10.status === PsychoJS.Status.STARTED){ // only update if being drawn
      polygon_submitbuttonType10.setOpacity(submitbutton_opacity, false);
    }
    
    // *polygon_submitbuttonType10* updates
    if ((ratingGiven) && polygon_submitbuttonType10.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbuttonType10.tStart = t;  // (not accounting for frame time here)
      polygon_submitbuttonType10.frameNStart = frameN;  // exact frame index
      
      polygon_submitbuttonType10.setAutoDraw(true);
    }
    
    
    // *textbox_submitbuttonType10* updates
    if ((ratingGiven) && textbox_submitbuttonType10.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_submitbuttonType10.tStart = t;  // (not accounting for frame time here)
      textbox_submitbuttonType10.frameNStart = frameN;  // exact frame index
      
      textbox_submitbuttonType10.setAutoDraw(true);
    }
    
    // *mouse_type10* updates
    if (t >= 0.0 && mouse_type10.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_type10.tStart = t;  // (not accounting for frame time here)
      mouse_type10.frameNStart = frameN;  // exact frame index
      
      mouse_type10.status = PsychoJS.Status.STARTED;
      mouse_type10.mouseClock.reset();
      prevButtonState = mouse_type10.getPressed();  // if button is down already this ISN'T a new click
      }
    if (mouse_type10.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_type10.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          _mouseXYs = mouse_type10.getPos();
          mouse_type10.x.push(_mouseXYs[0]);
          mouse_type10.y.push(_mouseXYs[1]);
          mouse_type10.leftButton.push(_mouseButtons[0]);
          mouse_type10.midButton.push(_mouseButtons[1]);
          mouse_type10.rightButton.push(_mouseButtons[2]);
          mouse_type10.time.push(mouse_type10.mouseClock.getTime());
        }
      }
    }
    
    // *textbox_emaType10Box1* updates
    if (t >= 0.0 && textbox_emaType10Box1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType10Box1.tStart = t;  // (not accounting for frame time here)
      textbox_emaType10Box1.frameNStart = frameN;  // exact frame index
      
      textbox_emaType10Box1.setAutoDraw(true);
    }
    
    
    // *textbox_emaType10Box2* updates
    if (t >= 0.0 && textbox_emaType10Box2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType10Box2.tStart = t;  // (not accounting for frame time here)
      textbox_emaType10Box2.frameNStart = frameN;  // exact frame index
      
      textbox_emaType10Box2.setAutoDraw(true);
    }
    
    
    // *textbox_emaType10Box3* updates
    if (t >= 0.0 && textbox_emaType10Box3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType10Box3.tStart = t;  // (not accounting for frame time here)
      textbox_emaType10Box3.frameNStart = frameN;  // exact frame index
      
      textbox_emaType10Box3.setAutoDraw(true);
    }
    
    
    // *textbox_emaType10Box4* updates
    if (t >= 0.0 && textbox_emaType10Box4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType10Box4.tStart = t;  // (not accounting for frame time here)
      textbox_emaType10Box4.frameNStart = frameN;  // exact frame index
      
      textbox_emaType10Box4.setAutoDraw(true);
    }
    
    
    // *textbox_emaType10Box5* updates
    if (t >= 0.0 && textbox_emaType10Box5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType10Box5.tStart = t;  // (not accounting for frame time here)
      textbox_emaType10Box5.frameNStart = frameN;  // exact frame index
      
      textbox_emaType10Box5.setAutoDraw(true);
    }
    
    
    // *textbox_emaType10Box6* updates
    if (t >= 0.0 && textbox_emaType10Box6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType10Box6.tStart = t;  // (not accounting for frame time here)
      textbox_emaType10Box6.frameNStart = frameN;  // exact frame index
      
      textbox_emaType10Box6.setAutoDraw(true);
    }
    
    
    // *textbox_emaType10Box7* updates
    if (t >= 0.0 && textbox_emaType10Box7.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType10Box7.tStart = t;  // (not accounting for frame time here)
      textbox_emaType10Box7.frameNStart = frameN;  // exact frame index
      
      textbox_emaType10Box7.setAutoDraw(true);
    }
    
    
    // *textbox_emaType10Label1* updates
    if (t >= 0.0 && textbox_emaType10Label1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType10Label1.tStart = t;  // (not accounting for frame time here)
      textbox_emaType10Label1.frameNStart = frameN;  // exact frame index
      
      textbox_emaType10Label1.setAutoDraw(true);
    }
    
    
    // *textbox_emaType10Label2* updates
    if (t >= 0.0 && textbox_emaType10Label2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType10Label2.tStart = t;  // (not accounting for frame time here)
      textbox_emaType10Label2.frameNStart = frameN;  // exact frame index
      
      textbox_emaType10Label2.setAutoDraw(true);
    }
    
    
    // *textbox_emaType10Label3* updates
    if (t >= 0.0 && textbox_emaType10Label3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType10Label3.tStart = t;  // (not accounting for frame time here)
      textbox_emaType10Label3.frameNStart = frameN;  // exact frame index
      
      textbox_emaType10Label3.setAutoDraw(true);
    }
    
    
    // *textbox_emaType10Label4* updates
    if (t >= 0.0 && textbox_emaType10Label4.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType10Label4.tStart = t;  // (not accounting for frame time here)
      textbox_emaType10Label4.frameNStart = frameN;  // exact frame index
      
      textbox_emaType10Label4.setAutoDraw(true);
    }
    
    
    // *textbox_emaType10Label5* updates
    if (t >= 0.0 && textbox_emaType10Label5.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType10Label5.tStart = t;  // (not accounting for frame time here)
      textbox_emaType10Label5.frameNStart = frameN;  // exact frame index
      
      textbox_emaType10Label5.setAutoDraw(true);
    }
    
    
    // *textbox_emaType10Label6* updates
    if (t >= 0.0 && textbox_emaType10Label6.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType10Label6.tStart = t;  // (not accounting for frame time here)
      textbox_emaType10Label6.frameNStart = frameN;  // exact frame index
      
      textbox_emaType10Label6.setAutoDraw(true);
    }
    
    
    // *textbox_emaType10Label7* updates
    if (t >= 0.0 && textbox_emaType10Label7.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_emaType10Label7.tStart = t;  // (not accounting for frame time here)
      textbox_emaType10Label7.frameNStart = frameN;  // exact frame index
      
      textbox_emaType10Label7.setAutoDraw(true);
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
    emaType10Components.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function emaType10RoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'emaType10' ---
    emaType10Components.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('emaType10.stopped', globalClock.getTime());
    // save result for eval if next question shall skip
    emaResponse = slider_emaType10.getRating();
    
    ratingGiven = false;
    
    psychoJS.experiment.addData('slider_emaType10.response', slider_emaType10.getRating());
    psychoJS.experiment.addData('slider_emaType10.rt', slider_emaType10.getRT());
    // store data for psychoJS.experiment (ExperimentHandler)
    psychoJS.experiment.addData('mouse_type10.x', mouse_type10.x);
    psychoJS.experiment.addData('mouse_type10.y', mouse_type10.y);
    psychoJS.experiment.addData('mouse_type10.leftButton', mouse_type10.leftButton);
    psychoJS.experiment.addData('mouse_type10.midButton', mouse_type10.midButton);
    psychoJS.experiment.addData('mouse_type10.rightButton', mouse_type10.rightButton);
    psychoJS.experiment.addData('mouse_type10.time', mouse_type10.time);
    
    // the Routine "emaType10" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var emaSkipperMaxDurationReached;
var expectation;
var emaSkipperMaxDuration;
var emaSkipperComponents;
function emaSkipperRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'emaSkipper' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    emaSkipperClock.reset();
    routineTimer.reset();
    emaSkipperMaxDurationReached = false;
    // update component parameters for each repeat
    psychoJS.experiment.addData("VAS_response", emaResponse);
    // handle condition for skipping next question
    expectation = emaQuestions_expectation;
    console.log(emaResponse);
    console.log(expectation);
    
    if ((expectation === [(- 1)])) {
        emaSkipNext = false;
        console.log("emaSkipNext = False");
    } else {
        // TODO: implement tests to detect skip condition
        console.log("emaSkipNext = maybe");
    }
    
    psychoJS.experiment.addData('emaSkipper.started', globalClock.getTime());
    emaSkipperMaxDuration = null
    // keep track of which components have finished
    emaSkipperComponents = [];
    
    emaSkipperComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


function emaSkipperRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'emaSkipper' ---
    // get current time
    t = emaSkipperClock.getTime();
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
    emaSkipperComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function emaSkipperRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'emaSkipper' ---
    emaSkipperComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('emaSkipper.stopped', globalClock.getTime());
    // the Routine "emaSkipper" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var instructionsMaxDurationReached;
var choiceInstructions1_text;
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
    // text options
    if (mobile_device) {
        if ((languagechoice === "ger")) {
            choiceInstructions1_text = choiceInstr1_ger;
        } else {
            choiceInstructions1_text = choiceInstr1_eng;
        }
    } else {
        if ((languagechoice === "ger")) {
            choiceInstructions1_text = choiceInstr1b_ger;
        } else {
            choiceInstructions1_text = choiceInstr1b_eng;
        }
    }
    
    // make up for wrong line-breaks when reading file with javascript
    choiceInstructions1_text = choiceInstructions1_text .split('\\n').join('\n');
    textbox_instructions_2.setText(choiceInstructions1_text);
    // setup some python lists for storing info about the mouse_instructions_2
    mouse_instructions_2.clicked_name = [];
    gotValidClick = false; // until a click is received
    textbox_submitbutton_2.setText(submitbutton_text);
    instructionsMaxDuration = null
    // keep track of which components have finished
    instructionsComponents = [];
    instructionsComponents.push(textbox_instructions_2);
    instructionsComponents.push(mouse_instructions_2);
    instructionsComponents.push(polygon_submitbutton_2);
    instructionsComponents.push(textbox_submitbutton_2);
    
    instructionsComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
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
    // Hovereffect for submitbutton
    if ((! mobile_device)) {
        if (polygon_submitbutton_2.contains(mouse_instructions_2)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
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
    }
    
    // *polygon_submitbutton_2* updates
    if (t >= 0.0 && polygon_submitbutton_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbutton_2.tStart = t;  // (not accounting for frame time here)
      polygon_submitbutton_2.frameNStart = frameN;  // exact frame index
      
      polygon_submitbutton_2.setAutoDraw(true);
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
    instructionsComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
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
    instructionsComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
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
var choiceInstructions2_text;
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
    // text options
    if ((languagechoice === "ger")) {
        choiceInstructions2_text = choiceInstr2_ger;
    } else {
        choiceInstructions2_text = choiceInstr2_eng;
    }
    
    // make up for wrong line-breaks when reading file with javascript
    choiceInstructions2_text = choiceInstructions2_text .split('\\n').join('\n');
    textbox_instructions_3.setText(choiceInstructions2_text);
    // setup some python lists for storing info about the mouse_instructions_3
    mouse_instructions_3.clicked_name = [];
    gotValidClick = false; // until a click is received
    textbox_submitbutton_3.setText(submitbutton_text);
    instructions_2MaxDuration = null
    // keep track of which components have finished
    instructions_2Components = [];
    instructions_2Components.push(textbox_instructions_3);
    instructions_2Components.push(mouse_instructions_3);
    instructions_2Components.push(polygon_submitbutton_3);
    instructions_2Components.push(textbox_submitbutton_3);
    
    instructions_2Components.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
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
    // Hovereffect for submitbutton
    if ((! mobile_device)) {
        if (polygon_submitbutton_3.contains(mouse_instructions_3)) {
            submitbutton_opacity = opacity2;
        } else {
            submitbutton_opacity = opacity1;
        }
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
    }
    
    // *polygon_submitbutton_3* updates
    if (t >= 0.0 && polygon_submitbutton_3.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      polygon_submitbutton_3.tStart = t;  // (not accounting for frame time here)
      polygon_submitbutton_3.frameNStart = frameN;  // exact frame index
      
      polygon_submitbutton_3.setAutoDraw(true);
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
    instructions_2Components.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
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
    instructions_2Components.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
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


var choicePreparationsMaxDurationReached;
var subSet;
var choiceLoopCount;
var choicePreparationsMaxDuration;
var choicePreparationsComponents;
function choicePreparationsRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'choicePreparations' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    choicePreparationsClock.reset();
    routineTimer.reset();
    choicePreparationsMaxDurationReached = false;
    // update component parameters for each repeat
    // here we prepare a subset of images for the choice task
    subSet = filteredLikings.slice(0, 20);
    // add a counter to the end of each subarray, to count each image usage
    subSet = subSet.map((subArray) => [...subArray, 0]);
    
    
    // do until 60 images are found in a proper order (unique pairs)
    while (imgSet.length < 60) {
        subSet = shuffle_array(subSet);
        
        // test if the subSet is valid (no pairs already in imgSet present)
        let skipFlag = false
        for (let i=0; i<imgSet.length; i+=2) {
            for (let j=0; j<subSet.length; j+=2) {
                // test every 2 entries of imgSet against every 2 of subSet
                if ((imgSet[i] === subSet[j] && imgSet[i+1] === subSet[j+1]) ||
                    (imgSet[i] === subSet[j+1] && imgSet[i+1] === subSet[j]))
                    skipFlag = true; // subSet is invalid, won't be added to imgSet
            }
        }
        if (skipFlag) {
            continue;
        }
        // if test of subSet didn't skip, then add this subset to the imgSet
        imgSet = imgSet.concat(subSet);
    }
    
    choiceLoopCount = (imgSet.length / 2);
    // choiceLoopcount = 2 // TODO: debug, delete
    
    psychoJS.experiment.addData('choicePreparations.started', globalClock.getTime());
    choicePreparationsMaxDuration = null
    // keep track of which components have finished
    choicePreparationsComponents = [];
    
    choicePreparationsComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


function choicePreparationsRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'choicePreparations' ---
    // get current time
    t = choicePreparationsClock.getTime();
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
    choicePreparationsComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function choicePreparationsRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'choicePreparations' ---
    choicePreparationsComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('choicePreparations.stopped', globalClock.getTime());
    // the Routine "choicePreparations" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var countdownMaxDurationReached;
var myStart;
var countdownStep;
var countdownMaxDuration;
var countdownComponents;
function countdownRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'countdown' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    countdownClock.reset(routineTimer.getTime());
    routineTimer.add(5.000000);
    countdownMaxDurationReached = false;
    // update component parameters for each repeat
    myStart = globalClock.getTime();
    countdownStep = 1;
    
    psychoJS.experiment.addData('countdown.started', globalClock.getTime());
    countdownMaxDuration = null
    // keep track of which components have finished
    countdownComponents = [];
    countdownComponents.push(textbox_countdown);
    
    countdownComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


var diffTime;
var frameRemains;
function countdownRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'countdown' ---
    // get current time
    t = countdownClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    diffTime = (globalClock.getTime() - myStart);
    
    if ((diffTime > countdownStep)) {
        countdownStep = (countdownStep + 1);
        countdownNum = (countdownNum - 1);
        countdownText = countdownNum.toString();
    }
    
    
    if (textbox_countdown.status === PsychoJS.Status.STARTED){ // only update if being drawn
      textbox_countdown.setText(countdownText, false);
    }
    
    // *textbox_countdown* updates
    if (t >= 0.0 && textbox_countdown.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      textbox_countdown.tStart = t;  // (not accounting for frame time here)
      textbox_countdown.frameNStart = frameN;  // exact frame index
      
      textbox_countdown.setAutoDraw(true);
    }
    
    frameRemains = 0.0 + 5 - psychoJS.window.monitorFramePeriod * 0.75;// most of one frame period left
    if (textbox_countdown.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      textbox_countdown.setAutoDraw(false);
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
    countdownComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine && routineTimer.getTime() > 0) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function countdownRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'countdown' ---
    countdownComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('countdown.stopped', globalClock.getTime());
    if (countdownMaxDurationReached) {
        countdownClock.add(countdownMaxDuration);
    } else {
        countdownClock.add(5.000000);
    }
    // Routines running outside a loop should always advance the datafile row
    if (currentLoop === psychoJS.experiment) {
      psychoJS.experiment.nextEntry(snapshot);
    }
    return Scheduler.Event.NEXT;
  }
}


var fixationMaxDurationReached;
var fixationStart;
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
    fixationStart = fixationClock.getTime();
    psychoJS.experiment.addData('fixation.started', globalClock.getTime());
    fixationMaxDuration = null
    // keep track of which components have finished
    fixationComponents = [];
    fixationComponents.push(fixation_cross);
    
    fixationComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


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
    fixationComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine && routineTimer.getTime() > 0) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


var fixationStop;
var fixationDuration;
function fixationRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'fixation' ---
    fixationComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('fixation.stopped', globalClock.getTime());
    // save the duration of this routine
    fixationStop = fixationClock.getTime();
    fixationDuration = fixationStop-fixationStart;
    psychoJS.experiment.addData("fixationDuration", fixationDuration);
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


var choiceMaxDurationReached;
var cli;
var indexLeft;
var indexRight;
var imgPath;
var validResponse;
var _key_choice_allKeys;
var choiceMaxDuration;
var choiceComponents;
function choiceRoutineBegin(snapshot) {
  return async function () {
    TrialHandler.fromSnapshot(snapshot); // ensure that .thisN vals are up to date
    
    //--- Prepare to start Routine 'choice' ---
    t = 0;
    frameN = -1;
    continueRoutine = true; // until we're told otherwise
    choiceClock.reset();
    routineTimer.reset();
    choiceMaxDurationReached = false;
    // update component parameters for each repeat
    myStart = globalClock.getTime();
    
    // The "loop_choice" iterates over the choice images,
    //  where 2 images are needed per iteration!
    cli = loop_choice.thisN; // current choice loop index
    
    // extract infos for current images
    indexLeft = (cli * 2);
    indexRight = ((cli * 2) + 1);
    // create filepath for both images
    imgPath = "stimuli/Food_Stimuli/";
    imgLeft = ((imgPath + imgSet[indexLeft][0].toString()) + ".jpg");
    imgRight = ((imgPath + imgSet[indexRight][0].toString()) + ".jpg");
    
    // count their usage
    imgSet[indexLeft][5] +=1;
    imgSet[indexRight][5] +=1;
    
    // save the count of usage of images
    psychoJS.experiment.addData("imgCounterL", imgSet[indexLeft][5] );
    psychoJS.experiment.addData("imgCounterR", imgSet[indexRight][5] );
    // save the image names
    psychoJS.experiment.addData("leftImage", imgSet[indexLeft][0] );
    psychoJS.experiment.addData("rightImage", imgSet[indexRight][0] );
    
    // prepare some vars
    validResponse = false;
    
    image_choiceLeft.setImage(imgLeft);
    image_choiceRight.setImage(imgRight);
    // setup some python lists for storing info about the mouse_choice
    // current position of the mouse:
    mouse_choice.x = [];
    mouse_choice.y = [];
    mouse_choice.leftButton = [];
    mouse_choice.midButton = [];
    mouse_choice.rightButton = [];
    mouse_choice.time = [];
    gotValidClick = false; // until a click is received
    key_choice.keys = undefined;
    key_choice.rt = undefined;
    _key_choice_allKeys = [];
    psychoJS.experiment.addData('choice.started', globalClock.getTime());
    choiceMaxDuration = null
    // keep track of which components have finished
    choiceComponents = [];
    choiceComponents.push(image_choiceLeft);
    choiceComponents.push(image_choiceRight);
    choiceComponents.push(mouse_choice);
    choiceComponents.push(reminder);
    choiceComponents.push(key_choice);
    
    choiceComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    return Scheduler.Event.NEXT;
  }
}


function choiceRoutineEachFrame() {
  return async function () {
    //--- Loop for each frame of Routine 'choice' ---
    // get current time
    t = choiceClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    // react to the choosing of one of the images
    psychoJS.experiment.addData("choice", "missed");
    psychoJS.experiment.addData("optionRight", "missed");
    psychoJS.experiment.addData("choiceRT", (- 1));
    if (mobile_device) {
        if (mouse_choice.isPressedIn(image_choiceLeft)) {
            validResponse = true;
            psychoJS.experiment.addData("choice", "left");
            psychoJS.experiment.addData("optionRight", 0);
            psychoJS.experiment.addData("choiceRT", (globalClock.getTime() - myStart));
            continueRoutine = false; // native PsychoJS var
        } else {
            if (mouse_choice.isPressedIn(image_choiceRight)) {
                validResponse = true;
                psychoJS.experiment.addData("choice", "right");
                psychoJS.experiment.addData("optionRight", 1);
                psychoJS.experiment.addData("choiceRT", (globalClock.getTime() - myStart));
                continueRoutine = false; // native PsychoJS var
            }
        }
    } else {
        keys = key_choice.keys;
        if (keys) {
            for (var key, _pj_c = 0, _pj_a = keys, _pj_b = _pj_a.length; (_pj_c < _pj_b); _pj_c += 1) {
                key = _pj_a[_pj_c];
                if ((key === "x")) {
                    validResponse = true;
                    psychoJS.experiment.addData("choice", "left");
                    psychoJS.experiment.addData("optionRight", 0);
                    psychoJS.experiment.addData("choiceRT", (globalClock.getTime() - myStart));
                    continueRoutine = false; // native PsychoJS var
                }
                if ((key === "m")) {
                    validResponse = true;
                    psychoJS.experiment.addData("choice", "right");
                    psychoJS.experiment.addData("optionRight", 1);
                    psychoJS.experiment.addData("choiceRT", (globalClock.getTime() - myStart));
                    continueRoutine = false; // native PsychoJS var
                }
            }
        }
    }
    
    
    // *image_choiceLeft* updates
    if (t >= 0.0 && image_choiceLeft.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      image_choiceLeft.tStart = t;  // (not accounting for frame time here)
      image_choiceLeft.frameNStart = frameN;  // exact frame index
      
      image_choiceLeft.setAutoDraw(true);
    }
    
    frameRemains = 0.0 + choiceTimeLimit - psychoJS.window.monitorFramePeriod * 0.75;// most of one frame period left
    if (image_choiceLeft.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      image_choiceLeft.setAutoDraw(false);
    }
    
    
    // *image_choiceRight* updates
    if (t >= 0.0 && image_choiceRight.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      image_choiceRight.tStart = t;  // (not accounting for frame time here)
      image_choiceRight.frameNStart = frameN;  // exact frame index
      
      image_choiceRight.setAutoDraw(true);
    }
    
    frameRemains = 0.0 + choiceTimeLimit - psychoJS.window.monitorFramePeriod * 0.75;// most of one frame period left
    if (image_choiceRight.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      image_choiceRight.setAutoDraw(false);
    }
    
    // *mouse_choice* updates
    if (t >= 0 && mouse_choice.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      mouse_choice.tStart = t;  // (not accounting for frame time here)
      mouse_choice.frameNStart = frameN;  // exact frame index
      
      mouse_choice.status = PsychoJS.Status.STARTED;
      mouse_choice.mouseClock.reset();
      prevButtonState = mouse_choice.getPressed();  // if button is down already this ISN'T a new click
      }
    frameRemains = 0 + choiceTimeLimit - psychoJS.window.monitorFramePeriod * 0.75;// most of one frame period left
    if (mouse_choice.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      mouse_choice.status = PsychoJS.Status.FINISHED;
        }
    if (mouse_choice.status === PsychoJS.Status.STARTED) {  // only update if started and not finished!
      _mouseButtons = mouse_choice.getPressed();
      if (!_mouseButtons.every( (e,i,) => (e == prevButtonState[i]) )) { // button state changed?
        prevButtonState = _mouseButtons;
        if (_mouseButtons.reduce( (e, acc) => (e+acc) ) > 0) { // state changed to a new click
          _mouseXYs = mouse_choice.getPos();
          mouse_choice.x.push(_mouseXYs[0]);
          mouse_choice.y.push(_mouseXYs[1]);
          mouse_choice.leftButton.push(_mouseButtons[0]);
          mouse_choice.midButton.push(_mouseButtons[1]);
          mouse_choice.rightButton.push(_mouseButtons[2]);
          mouse_choice.time.push(mouse_choice.mouseClock.getTime());
        }
      }
    }
    
    // *reminder* updates
    if (t >= (choiceTimeLimit - 1) && reminder.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      reminder.tStart = t;  // (not accounting for frame time here)
      reminder.frameNStart = frameN;  // exact frame index
      
      reminder.setAutoDraw(true);
    }
    
    frameRemains = choiceTimeLimit - psychoJS.window.monitorFramePeriod * 0.75;// most of one frame period left
    if ((reminder.status === PsychoJS.Status.STARTED || reminder.status === PsychoJS.Status.FINISHED) && t >= frameRemains) {
      reminder.setAutoDraw(false);
    }
    
    
    // *key_choice* updates
    if (t >= 0.0 && key_choice.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_choice.tStart = t;  // (not accounting for frame time here)
      key_choice.frameNStart = frameN;  // exact frame index
      
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_choice.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_choice.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_choice.clearEvents(); });
    }
    
    frameRemains = 0.0 + choiceTimeLimit - psychoJS.window.monitorFramePeriod * 0.75;// most of one frame period left
    if (key_choice.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      key_choice.status = PsychoJS.Status.FINISHED;
        }
      
    if (key_choice.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_choice.getKeys({keyList: ['x', 'm'], waitRelease: false});
      _key_choice_allKeys = _key_choice_allKeys.concat(theseKeys);
      if (_key_choice_allKeys.length > 0) {
        key_choice.keys = _key_choice_allKeys.map((key) => key.name);  // storing all keys
        key_choice.rt = _key_choice_allKeys.map((key) => key.rt);
        key_choice.duration = _key_choice_allKeys.map((key) => key.duration);
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
    choiceComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


var blockNum;
function choiceRoutineEnd(snapshot) {
  return async function () {
    //--- Ending Routine 'choice' ---
    choiceComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('choice.stopped', globalClock.getTime());
    // add more date to output
    cli = loop_choice.thisN; // current choice loop index
    psychoJS.experiment.addData("trialCounter", cli+1);
    
    blockNum = Math.floor(cli / 10) + 1;
    psychoJS.experiment.addData("blockCounter", blockNum)
    
    if (validResponse) {
        psychoJS.experiment.addData("validChoice", 1)
    } else {
        psychoJS.experiment.addData("validChoice", 0)
    }
    
    validResponse = false; // reset
    
    // store data for psychoJS.experiment (ExperimentHandler)
    psychoJS.experiment.addData('mouse_choice.x', mouse_choice.x);
    psychoJS.experiment.addData('mouse_choice.y', mouse_choice.y);
    psychoJS.experiment.addData('mouse_choice.leftButton', mouse_choice.leftButton);
    psychoJS.experiment.addData('mouse_choice.midButton', mouse_choice.midButton);
    psychoJS.experiment.addData('mouse_choice.rightButton', mouse_choice.rightButton);
    psychoJS.experiment.addData('mouse_choice.time', mouse_choice.time);
    
    // update the trial handler
    if (currentLoop instanceof MultiStairHandler) {
      currentLoop.addResponse(key_choice.corr, level);
    }
    psychoJS.experiment.addData('key_choice.keys', key_choice.keys);
    if (typeof key_choice.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('key_choice.rt', key_choice.rt);
        psychoJS.experiment.addData('key_choice.duration', key_choice.duration);
        }
    
    key_choice.stop();
    // the Routine "choice" was not non-slip safe, so reset the non-slip timer
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
  psychoJS.window.close();
  psychoJS.quit({message: message, isCompleted: isCompleted});
  
  return Scheduler.Event.QUIT;
}
