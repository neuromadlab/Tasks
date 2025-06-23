// 'Basic' Model - no further modification of parameters
// inspired by Baribault & Collins (2021)
// adapted priors: tighter version

data {
  int<lower=0> nSub;
  int<lower=0> nTrial;
  int<lower=0> nRun;
  int<lower=0> Sub[nRun];
  int<lower=0> choice[nTrial,nRun];
  real<lower=0> rewA[nTrial,nRun];
  real<lower=0> rewB[nTrial,nRun];
  int<lower=0> win[nTrial,nRun];
  int<lower=0> outcome[nTrial,nRun];
 
}


transformed data {
  real initV;  // initial values for est_prob
  initV = 0.5;
}

// The parameters accepted by the model
parameters {
  //  Hierarchical parameters
  // alpha-priors
  vector<lower=0> [nSub] a11;
  vector<lower=0> [nSub] a12;
  vector<lower=0> [nSub] a21;
  vector<lower=0> [nSub] a22;
  
  // beta-priors
  vector<lower=0> [nSub] mu_beta;
  vector<lower=0> [nSub] b1;
  
  // lambda-priors
  vector<lower=0> [nSub] l1;
  vector<lower=0> [nSub] l2;
  
  // Model Parameters
  matrix<lower=0, upper=1> [nRun,2] alpha;
  vector<lower=0, upper=15>[nRun] beta;
  vector<lower=0,  upper=1>[nRun] lambda;
  
}


transformed parameters {

    // Mean and Sd for analysis
    vector<lower=0> [nSub] alpha_1_mu ;
    vector<lower=0> [nSub] alpha_1_sigma ;
    vector<lower=0> [nSub] alpha_2_mu ;
    vector<lower=0> [nSub] alpha_2_sigma ;
    
    vector<lower=0> [nSub] lambda_mu ;
    vector<lower=0> [nSub] lambda_sigma ;
    
    vector<lower=0> [nSub] b2;
    vector<lower=0> [nSub] sigma_beta;
    
    for (i in 1:nSub) {
    alpha_1_mu[i] = (a11[i]+1)/(a11[i] + 1 + a12[i] + 1);
    
    alpha_2_mu[i] = (a21[i]+1)/(a21[i] + 1 + a22[i] + 1);
    
    alpha_1_sigma[i] = sqrt((a11[i]+1)*(a12[i]+1) / ( ((a11[i]+1 + a12[i]+1)^2) * (a11[i]+1 + a12[i]+1 + 1)));

    alpha_2_sigma[i] = sqrt((a21[i]+1)*(a22[i]+1) / ( ((a21[i]+1 + a22[i]+1)^2) * (a21[i]+1 + a22[i]+1 + 1)));
    
    lambda_mu[i] = (l1[i]+1)/(l1[i] + 1 + l2[i] + 1);
    lambda_sigma[i] = sqrt((l1[i]+1)*(l2[i]+1) / ( ((l1[i]+1 + l2[i]+1)^2) * (l1[i]+1 + l2[i]+1 + 1)));
    
    // for beta
    b2[i] = (1+b1[i])/mu_beta[i];
    sigma_beta[i] = sqrt((1+b1[i]) / (b2[i]^2));

    }
    
}

// The model to be estimated

model {

 for (i in 1:nSub) {
   // subject-level priors

   a11[i] ~ gamma(2,2); // alpha_lose
   a12[i] ~ gamma(5,2);
   a21[i] ~ gamma(5,2); // alpha_win
   a22[i] ~ gamma(4,2);
   
   mu_beta[i] ~ normal(4.5,2);
   b1[i] ~ gamma(5,1);
   
   l1[i] ~ gamma(5,2);
   l2[i] ~ gamma(1,3);
   
 }

 // Run level priors sampled from the hierarchical prior
 for (i in 1:nRun) {
    
    alpha[i,1] ~ beta(1+a11[Sub[i]], 1+a12[Sub[i]]);
    alpha[i,2] ~ beta(1+a21[Sub[i]], 1+a22[Sub[i]]);
    
    //beta[i] ~ normal(mu_beta, sigma_beta) ;
    beta[i] ~ gamma(1+b1[Sub[i]], b2[Sub[i]]);
    
    lambda[i] ~ beta(1+l1[Sub[i]], 1+l2[Sub[i]]);
    
  }
   

  for (i in 1:nRun) {
    
    real est_prob; // est_prob
    real PE;      // prediction error
    real Q;      // prediction error
    vector[2] choice_prob; 

    est_prob = initV;

    for (t in 1:nTrial) {
      //compute Q-value /Expected value and choice probabilities
      Q = lambda[i]*(est_prob - (1-est_prob)) + (1-lambda[i])*((rewA[t,i]/50) - (rewB[t,i]/50));
      choice_prob[1] =  1/(1 + exp(Q*(-beta[i])));
      //choice_prob[2] =  1 - (1/(1 + exp(Q*(-beta[i]))));
      choice_prob[2] =  1 - choice_prob[1];
      
      // compute action probabilities
      choice[t,i] ~ categorical(choice_prob);
  
      // prediction error
     
      PE = outcome[t,i] - est_prob;

      // value updating (learning)
      est_prob += alpha[i,win[t,i]] * PE;
      
    }
  }
}

generated quantities {

  // For log likelihood calculation
  real log_lik[nRun];


  for (i in 1:nRun) {

    real est_prob; // est_prob
    real PE;      // prediction error
    real Q;      // prediction error
    vector [2] choice_prob;

    est_prob = initV;
    log_lik[i] = 0;

    for (t in 1:nTrial) {
      //compute Q-value /Expected value and choice probabilities
      Q = lambda[i]*(est_prob - (1-est_prob)) + (1-lambda[i])*((rewA[t,i]/50) - (rewB[t,i]/50));
      choice_prob[1] =  1/(1 + exp(Q*(-beta[i])));
      //choice_prob[2] =  1 - (1/(1 + exp(Q*(-beta[i]))));
      choice_prob[2] =  1 - choice_prob[1];

      // compute action probabilities
      log_lik[i] += categorical_lpmf(choice[t,i] |choice_prob);

      // prediction error
      PE = outcome[t,i] - est_prob;

      // value updating (learning)
      est_prob += alpha[i,win[t,i]] * PE;

    }
  }
}

