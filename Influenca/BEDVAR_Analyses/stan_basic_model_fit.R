
# Script for running basic hierarchical Bayesian model (STAN) on influenca data
# Sahiti Chebolu, 12.2022

# load necessary libraries

library(rstan) #load rstan package
options(mc.cores = parallel::detectCores()) #if using rstan locally on a multicore machine and 
#have a lot of RAM to estimate model parallelly
rstan_options(auto_write = TRUE) # save compiled Stan program on hard disk, only recompile if changed

#load file with necessary functions
source("/mnt/big_data/SynologyDrive/Tasks/Influenca/Analyses/TUE009/Hierarchical_Sampling/StanModels-metabolicState/helper_functions_plotting.R")

# load data set
data <- read.csv('/mnt/big_data/SynologyDrive/Tasks/Influenca/Analyses/TUE002_freeze_2022_09_19/Influenca_TUE002_data_trials_clean.csv')


data %>%   
  group_by(ID) %>% 
  filter(n()>=1500) %>% 
  ungroup() %>% 
  arrange(ID,Run,Trial) -> data



# preparing data for STAN model

dList_allData = prep_data(data);

save(dList_allData, file = '/mnt/big_data/SynologyDrive/Tasks/Influenca/Analyses/TUE002/Hierarchical_Bayes/StanModels-metabolicState/data/data.RData')

fit_combined = stan(file = '/mnt/big_data/SynologyDrive/Tasks/Influenca/Analyses/TUE002/Hierarchical_Bayes/StanModels-metabolicState/basicModel.stan',
                data=dList_allData, init = 0, iter = 2000, chains = 4)
save(fit_combined, file = '/mnt/big_data/SynologyDrive/Tasks/Influenca/Analyses/TUE002/Hierarchical_Bayes/StanModels-metabolicState/STAN_fits/fit_data.RData')
log_lik2 <- extract_log_lik(fit_combined,parameter_name = 'log_lik')


