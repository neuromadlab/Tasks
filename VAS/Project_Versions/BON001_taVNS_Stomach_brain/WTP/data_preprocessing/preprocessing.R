##############################################
### Willingness2Pay - Preprocessing ###
# Editor: Adrian Welter
# LastEdit: 18.12.2023
##############################################
### Relevant columns:
# participantID: ParticipantID
# studyID: which study asigned to
# date: yyyy-mm-dd_time
# expName: Name of the experiment
# psychopyVersion: PsychoPy Version
# OS: operating system
# frameRate: average frames per second
# language: chosen language {ger, uk}
# fixation_dur: duration of pre-trial fixation (in seconds)
# activityID: ID of the current activity displayed in a trial (see 'stimuli/activities.csv')
# condition: Condition for which the willingness2pay had to be given ("alone" vs. "together")
# willi2pay: Willingness2pay (in €), rounded to .50
# Trial_RT: reaction time (in seconds)

## TODO: Set working directory (where to search for files, where to write to)
setwd("C:\\Users\\adria\\OneDrive\\Desktop\\_\\Studium\\Master\\Job_NeuroMad\\Willingness2Pay\\data_preprocessing")

### TODO: Change filename to file you want to preprocess
FILENAME <- '90001_willingness2pay_2023-12-18_12h42.25.408.csv'
SAFE_CSV = FALSE #Safe as csv or as txt?

# read csv-file
data <- read.csv(FILENAME)

# Get the number of rows in the dataframe
num_rows <- nrow(data)

# Remove the irrelevant rows (first 5 rows before trials + last row)
data <- data[6:(num_rows - 1), ]

# delete irrelevant columns
data$mouse.x <- NULL
data$mouse.y <- NULL
data$mouse.leftButton <- NULL
data$mouse.midButton <- NULL
data$mouse.rightButton <- NULL
data$mouse.time <- NULL
data$mouse.clicked_name <- NULL
data$trials.thisRepN <- NULL
data$trials.thisTrialN <- NULL
data$trials.thisN <- NULL
data$trials.thisIndex <- NULL
data$trials.ran <- NULL

# safe preprocessed csv-file
if (SAFE_CSV == TRUE){
  out_name = paste("preprocessed_data/preprocessed_",FILENAME)
  write.csv(data, file=out_name, row.names=FALSE)
} else {
  out_name = paste("preprocessed_data/preprocessed_",gsub(".csv","",FILENAME),".txt")
  write.table(data,file=out_name, row.names=FALSE)
}
