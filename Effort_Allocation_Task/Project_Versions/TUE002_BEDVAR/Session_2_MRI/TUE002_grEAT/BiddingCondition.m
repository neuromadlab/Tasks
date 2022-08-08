%%=========================
%%Conditions for bidding
%%=========================

%Create difficulty+Incentive conditions for experiment
Money   = 1;
Food    = 0;

%Reward levels
LowRwrd     = 50;     % 50 cents
StndrdRwrd  = 100;    % 100 cents (euro)  
HighRwrd    = 200;    % 209 cents (2 euro)

%all possible combinations
LowRwrd_M       = [Money, LowRwrd];
LowRwrd_F       = [Food, LowRwrd];

StndrdRwrd_M    = [Money, StndrdRwrd];
StndrdRwrd_F    = [Food, StndrdRwrd];

HighRwrd_M      = [Money, HighRwrd];
HighRwrd_F      = [Food, HighRwrd];

%condition vector
bidcond = [LowRwrd_M; LowRwrd_F; StndrdRwrd_M; StndrdRwrd_F; HighRwrd_M; HighRwrd_F];

%labels
Value_labels = {'Money', Money; 'Food', Food; 'LowRwrd', LowRwrd; 'HighRwrd', HighRwrd; 'StandardRwrd', StndrdRwrd;};

%save vector
output.filename = sprintf('%s/conditions/EATBid_cond', pwd);
save([output.filename '.mat'], 'bidcond', 'Value_labels')
