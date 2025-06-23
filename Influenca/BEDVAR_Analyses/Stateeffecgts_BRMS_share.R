#Analyse effects of metabolic state / mood on fit parameters (averages from STAN)
# using BRMS and for now the combined model (including food vs. money, logRun and hunger ratings and glucose)

library(parallel)
library(tidyverse)
library(cmdstanr)
library(brms)
library(tidybayes)
library(readr)


#load data

estimates <- read_csv("TUE002_run_level_means_STAN.csv")

estimates %>% 
  mutate(logRun = log(run),
         expRun = exp(-run),
         run01 = run/max(run)) %>% 
  select(-c("n","ID")) %>% 
  rename("ID" = "Influenca_ID")-> estimates

#add glucose and metabolic state data

run_info  <- read_csv("../../../../Data/TUE002/Influenca_TUE002_data_runs.csv",na = "NaN")

run_info %>% 
  select(ID,Run,Hunger,Satiety,Happy,Sad,Stress,Binge,Alert,Coffee) %>% 
  rename("run" = "Run") %>% 
  mutate(metstate = (Hunger - Satiety)/100) %>% 
  mutate(moodstate = (Happy - Sad)/100) %>% 
  mutate(alert01 = Alert/100) -> metabolic_info

estimates <- inner_join(estimates,metabolic_info)

estimates %>% 
  group_by(ID) %>% 
  filter(n()>10) ->estimates



ncores = detectCores()
#rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

#metabolic state + binge

mdl_brms_alpha_pun_scale_metstate_gc <-brm(
  bf(alpha1 ~ 0 + Intercept +  metstate + Binge + Coffee+ clogRun +  (1 + metstate + Binge + Coffee + logRun |i| ID),
     phi ~ 1 + (1 |i| ID)),
  prior = c(prior(normal(0, 1), class = b, coef = Intercept),
            prior(normal(0, 1), class = b, coef = logRun),
            prior(normal(0, 1), class = b, coef = metstate),
            prior(normal(0, 1), class = b, coef = Binge),
            prior(exponential(1), class = sd),
            prior(normal(log(0.5),1), class = Intercept, dpar = phi),
            prior(exponential(1), class = sd, dpar = phi),
            prior(lkj(2), class = cor)),
  data = estimates, family = Beta(), cores = ncores, chains = 8, iter = 4000, file = "brms_fits/alpha_pun_beta_randscale_metstate", backend = "cmdstanr", threads = threading(2))


mdl_lme_alpha_pun_metstate_gc <-lmerTest::lmer(alpha1 ~1 +  metstate_gc + Binge + Coffee+ clogRun +  (1 + metstate_gc + Binge + Coffee + clogRun|ID), data = estimates)




mdl_brms_alpha_win_scale_metstate <-brm(
  bf(alpha2 ~ 0 + Intercept +  metstate + Binge + Coffee + clogRun +  (1 + metstate + Binge + Coffee + clogRun |i| ID),
     phi ~ 1 + (1 |i| ID)),
  prior = c(prior(normal(0, 1), class = b, coef = Intercept),
            prior(normal(0, 1), class = b, coef = clogRun),
            prior(normal(0, 1), class = b, coef = metstate),
            prior(normal(0, 1), class = b, coef = Binge),
            prior(exponential(1), class = sd),
            prior(normal(log(0.5),1), class = Intercept, dpar = phi),
            prior(exponential(1), class = sd, dpar = phi),
            prior(lkj(2), class = cor)),
  data = estimates, family = Beta(), cores = ncores, chains = 8, iter = 4000, file = "brms_fits/alpha_win_beta_randscale_metstate", backend = "cmdstanr", threads = threading(2))




mdl_brms_lambda_scale_metstate <-brm(
  bf(lambda ~ 0 + Intercept +  metstate + Binge + Coffee + expRun +  (1 + metstate + Binge +Coffee  + expRun |i| ID),
     phi ~ 1 + (1 |i| ID)),
  prior = c(prior(normal(0, 1), class = b, coef = Intercept),
            prior(normal(0, 1), class = b, coef = expRun),
            prior(normal(0, 1), class = b, coef = metstate),
            prior(normal(0, 1), class = b, coef = Binge),
            prior(exponential(1), class = sd),
            prior(normal(log(0.5),1), class = Intercept, dpar = phi),
            prior(exponential(1), class = sd, dpar = phi),
            prior(lkj(2), class = cor)),
  data = estimates, family = Beta(), cores = ncores, chains = 8, iter = 4000, file = "brms_fits/lambda_beta_randscale_metstate", backend = "cmdstanr", threads = threading(2))


mdl_brms_beta_metstate <- brm(bf(beta ~ 0 + Intercept + metstate + Binge + Coffee + clogRun  + (1 + Binge + metstate + Binge + Coffee + clogRun |i|ID),
                                      sigma ~ 1 + (1 |i| ID)),
                                   prior = c(prior(normal(log(5), 1), class = b, coef = Intercept),
                                             prior(normal(0, 1), class = b, coef = clogRun),
                                             prior(normal(0, 1), class = b, coef = metstate),
                                             prior(normal(0, 1), class = b, coef = Binge),
                                             prior(exponential(1), class = sd),
                                             prior(cauchy(0,1), class = Intercept, dpar = sigma),
                                             prior(cauchy(0,1), class = sd, dpar = sigma),
                                             prior(lkj(2), class = cor)),
                                   data = estimates, cores = ncores/4, chains = 8, iter = 4000, file = "brms_fits/beta_lognormal_metstate", family = lognormal, backend = "cmdstanr", threads = threading(2), max_treedepth = 15)

#mood + binge

mdl_brms_alpha_pun_scale_moodstate <-brm(
  bf(alpha1 ~ 0 + Intercept +  moodstate + logRun + alert01 + (1 + moodstate +alert01 +logRun |i| ID),
     phi ~ 1 + (1 |i| ID)),
  prior = c(prior(normal(0, 1), class = b, coef = Intercept),
            prior(normal(0, 1), class = b, coef = logRun),
            prior(normal(0, 1), class = b, coef = moodstate),
            prior(normal(0, 1), class = b, coef = alert01),
            prior(exponential(1), class = sd),
            prior(normal(log(0.5),1), class = Intercept, dpar = phi),
            prior(exponential(1), class = sd, dpar = phi),
            prior(lkj(2), class = cor)),
  data = estimates, family = Beta(), cores = ncores/4, chains = 8, iter = 4000, file = "brms_fits/alpha_pun_beta_randscale_moodstate_alert", backend = "cmdstanr", threads = threading(2))

mdl_brms_alpha_win_scale_moodstate <-brm(
  bf(alpha2 ~ 0 + Intercept +  moodstate + alert01 + logRun +  (1 + moodstate + alert01 + logRun |i| ID),
     phi ~ 1 + (1 |i| ID)),
  prior = c(prior(normal(0, 1), class = b, coef = Intercept),
            prior(normal(0, 1), class = b, coef = logRun),
            prior(normal(0, 1), class = b, coef = moodstate),
            prior(normal(0, 1), class = b, coef = alert01),
            prior(exponential(1), class = sd),
            prior(normal(log(0.5),1), class = Intercept, dpar = phi),
            prior(exponential(1), class = sd, dpar = phi),
            prior(lkj(2), class = cor)),
  data = estimates, family = Beta(), cores = ncores/4, chains = 8, iter = 4000, file = "brms_fits/alpha_win_beta_randscale_moodstate", backend = "cmdstanr", threads = threading(2))

mdl_brms_lambda_scale_moodstate <-brm(
  bf(lambda ~ 0 + Intercept +  moodstate + alert01 + expRun +  (1 + moodstate + alert01  + expRun |i| ID),
     phi ~ 1 + (1 |i| ID)),
  prior = c(prior(normal(0, 1), class = b, coef = Intercept),
            prior(normal(0, 1), class = b, coef = expRun),
            prior(normal(0, 1), class = b, coef = moodstate),
            prior(normal(0, 1), class = b, coef = alert01),
            prior(exponential(1), class = sd),
            prior(normal(log(0.5),1), class = Intercept, dpar = phi),
            prior(exponential(1), class = sd, dpar = phi),
            prior(lkj(2), class = cor)),
  data = estimates, family = Beta(), cores = ncores/4, chains = 8, iter = 4000, file = "brms_fits/lambda_beta_randscale_moodstate", backend = "cmdstanr", threads = threading(2))


mdl_brms_beta_moodstate <- brm(bf(beta ~ 0 + Intercept + moodstate +Alert + logRun  + (1 + moodstate + Alert + logRun |i|ID),
                                 sigma ~ 1 + (1 |i| ID)),
                              prior = c(prior(normal(log(5), 1), class = b, coef = Intercept),
                                        prior(normal(0, 1), class = b, coef = logRun),
                                        prior(normal(0, 1), class = b, coef = moodstate),
                                        prior(normal(0, 1), class = b, coef = Alert),
                                        prior(exponential(1), class = sd),
                                        prior(cauchy(0,1), class = Intercept, dpar = sigma),
                                        prior(cauchy(0,1), class = sd, dpar = sigma),
                                        prior(lkj(2), class = cor)),
                              data = estimates, cores = ncores, chains = 8, iter = 4000, file = "brms_fits/beta_lognormal_moodstate", family = lognormal, backend = "cmdstanr", threads = threading(2), max_treedepth = 15)
