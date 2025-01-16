%% Script to create BON002 reward & probabilities
%% Reward
for i = 1:setup.nblocks
        reward.left{i} = round(normrnd(50,16,[setup.ntrials,1])); % random numbers with mean 50 and st 15
        reward.right{i} = 100-reward.left{i};
        reward.grid{i}(:,:) = [reward.left{i},reward.right{i}];
end

f = figure;
tiledlayout(2,2)
for i = 1:4
nexttile
histogram(reward.grid{i})
title(num2str(i))
end


%% Probabilities rgw
%addpath('X:\Tasks\Influenca\Simulation\Lit_Review');
ntrials = 48;
nruns = 4;

rgw = generate_random_walk_TUE009(nruns,ntrials);

rgw = rgw.probs;
figure;
plot(rgw)
hold on
yline(0.5)

rgw2 = 1-rgw;

for r = 1:nruns
    prob{r} = [rgw(:,r),rgw2(:,r)];
end

for b = 1:nruns
    diff(:,b) = prob{b}(:,2)-prob{b}(:,1);
end

diff = abs(diff);

figure;
tiledlayout(2,1)
nexttile
boxplot(diff)
hold on
plot(mean(diff),'*')
title('Probability differences')
nexttile
for r = 1:4
hold on
plot(prob{r}(:,1))
end
yline(0.5)

save('TUE009_setup.mat','SMsettings','jitter_isi','jitter_iti','reward','setup')