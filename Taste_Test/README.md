# Taste test

## Introduction
Through this ~20 min food taste task, the consummatory reward facet of anhedonia is assessed. 
The task includes several phases. First, in phase I, participants will be asked to bid for the snacks to determine the participant’s willingness to pay for each snack. 
Next, they will be asked to anticipate the taste and taste the snacks, and to rate the experienced reward (i.e., consummatory liking) in phases II to IV. 
In phase V participants will repeat the willingness to pay trial, giving them the chance to increase or decrease their bid after they have tried the snacks (learning facet). 
Lastly, they will have the chance to receive one of the items as a reward in the winning trial:
![image](https://user-images.githubusercontent.com/50832722/193064022-79524265-5dd6-4dfb-8ade-67ab1203d175.png)

## Detailed description of phases of the experiment

-	Phase I: Willingness to pay I -> Taste test food items are visually presented, and participants have to enter a price that they are willing to pay for each item. 

-	Phase II: Taste test anticipation -> Participants are instructed to inspect the food items in front of them (smell, look), followed by taste test ratings.

-	Phase III: Taste test consumption I -> Participants are instructed to taste the food items in front of them, followed by taste test ratings. 
Every food item is assessed twice in this phase. 

-	Phase IV: Taste test consumption II -> Participants are instructed to taste the food items in front of them, followed by taste test ratings. 
Every food item is assessed once in this phase. 

-	Phase V: Willingness to pay II -> Taste test food items are visually presented, and participants have to enter a price that they are willing to pay for each item.
** The output from Phase V is stored in the output file under the name of phase 6 because the Taste test consumption I section is repeated twice, 
and therefore, from the second run of phase III (phase 4 in the output), the index of all the phases are shifted one number. **

-	Winning trial -> Displays on the screen if an item is won or not together with the snack image, taking into account the item bid in the willingness to pay II section.

## TUE008_Show_TasteTest.m

There are three general blocks in which the script can be divided: 
-	Experiment preparation and customization: Parts 1 – 6
-	Experiment run: Parts 7 – 10
-	Saving experiment data: Part 11

### Part 1: Preparation
In this section, the following points are taken into consideration: 
•	Clear workspace
•	Set random seed 
•	Get operating system and path information
•	Project and subject information: Request subject and session information from experimenter. Convert this information to the appropriate formats (e.g. num2str, abbreviations etc.). Participant ID is filled with zeros at the front of the number until the ID consists of a total of 6 digits.
•	Language selection: German or English
•	Controller selection: Xbox gamepad (gamepad) or mouse
•	Screen preparation
The settings that are found at the beginning of the Taste Test and that can be used to customize the script. Here, elaborated in order of appearance:
![image](https://user-images.githubusercontent.com/50832722/193064737-6aafff1d-a2a8-4cc4-8208-282c241a3906.png)

### Part 2: Load stimuli images
The snack pictures are read and stored in a specific order in a struct. 

% Read image files 
img.d = imread([img_dir '184.jpg']); %pretzels
img.f = imread([img_dir '286.jpg']); % nic nocs
img.c = imread([img_dir '26.jpg']); %cookies
img.e = imread([img_dir '89.jpg']); %raisins
img.a = imread([img_dir '40.jpg']); %strawberry gummy bears
img.b = imread([img_dir '373.jpg']); % bread rings
img.g = imread([img_dir '217.jpg']); %rice cracker

The order of the images can be modified by changing manually the letter order. In the case that the order is altered, the name assigned to each image has to be changed, too.  

% Selection of the image order
order = {'d','f','b','g','e','c','a'};
order_names = {'pretzels','nic nocs','bread rings','rice cracker', 'raisins', 'cookies', 'gummy bears'};

% Storing images in a struct following the specified order
for pic = 1:7
    all_img{pic} = img.(order{pic});
end

### Part 3: Paradigm settings
This part of the code loads the jitters and specifies the following variables (in order) that can be customized:
![image](https://user-images.githubusercontent.com/50832722/193064965-b2e95bf9-3b1c-409a-a15e-b6b65e5343c7.png)

### Part 4: Language, texts, instructions, and repetitions
In this section, the size of the texts and the fixation cross is specified and the supplementary file lang.mat is loaded, which contains all the instructions and texts that appear in the experiment both in German and English.
The number of repetitions of the consumption phase is determined. Currently, it is set to 2 repetitions. 
To change number of times the consumption phase should be shown to the participant, change the value of consumption_repetition to number of desired repetitions. 
The matrix lang.phase  loaded in lang.mat should be updated manually to run the experiment with the correct number of phases.

### Part 5: Screen
This part of the code sets all the screen settings and defines the relative location of the images and texts on the screen.

### Part 6: Initialization before experiment loop
In this part, some variables are initialized before the experiment starts. The textures from the stimuli images are made here before the start of the loop and stored in a struct.

### Part 7: Start of the experiment and timing 
The starting time of the experiment is stored. 

### Part 8: Experimental loop

#### Outer loop: setting the phase
Currently, the experimental loop consists of 5 iterations, corresponding to the five phases of the experiment: 1. Willignness to pay I, 2. Antipication, 3. Consumption I, 4. Consumption II, 5. Willingness to pay II. In the first part of the outer loop, an instructions screen is shown including the current phase number and title, the instructions, and a text indicating how to continue to the next screen (either pressing button A with the gamepad, or with a mouse click).  Then, for every phase, there is an inner loop with as many iterations as there are snacks. 

#### Inner loop: setting the snack item
In each phase all the snacks are presented on the screen in the previously specified order. 

#### Repetition loop
![image](https://user-images.githubusercontent.com/50832722/193065410-f894b895-a4df-45d3-af45-89a6ac3ba5e8.png)
![image](https://user-images.githubusercontent.com/50832722/193065453-d564a32f-04f4-423a-9460-8d969632743b.png)

### Part 9: Winning trial
Announces result of willingness to pay. 
Takes the bid of an item chosen randomly from the second bidding phase and computes a probability to win using a sigmoid function. 
Then, compares that probability with a random one and displays on the screen if the item is won or not together with the snack image.

### Part 10: End of experiment
-	Shows screen with end text 
-	Shows cursor
-	Closes screen

### Part 11: Save experiment data
-	Saves experiment length
-	Saves Data and Backup file

#### Scales and ratings
All the scales in this task are implemented from the Effort_VAS file. 
![image](https://user-images.githubusercontent.com/50832722/193065663-095399a0-8349-4f30-ad32-6b3fd1499584.png)

#### Output description
The most important data structure is Data.mat. It contains two subsections, output and subject information.
![image](https://user-images.githubusercontent.com/50832722/193065786-42c1d6ad-4618-4fa9-b0e6-ebceb7dacd19.png)

### Supporting files
#### Joystick
If a gamepad is used as a controller, the file JoystickSpecification.mat is required.

#### Folder structure
The Taste Test requires the following sub-folders to function:
•	A folder named Backup in which temporary and backup files are stored during the experiment.
•	A folder named Data in which the final data files are stored.
•	A folder named SnackPics which contains all the snack pictures used in the experiment. 

#### Instructions
The instructions’ structure is called lang.mat and needs to be placed in the same folder as TUE008_Show_TasteTest.m to be loaded.

#### Jitters
All jitters need to be placed in the same folder as TUE008_Show_TasteTest.m to be loaded. They do not go into a separate folder.
To create new jitters, use the function ComputeJitter_exp.m.

#### VAS
The file Effort_VAS.m is required to display the rating scales.
