load('FCRbeh_TUE002_900009_S2_R1.mat')

% Generate condition identifier
cond_ID_GFD = [repelem(design.rand.block_order(:,1),5); repelem(design.rand.block_order(:,2),5)];
cond_ID = [repelem(design.rand.block_order(:,1),5); repelem(design.rand.block_order(:,2),5)];

for i = 1:length(cond_ID)
    
   if mod(i,5) ~= 1
       
       cond_ID(i) = 0;
       
   end
    
end

% Add time for dummy volumes
corr_ons = subj.trigger.all(3) - subj.trigger.all(1);

% Generate onsets for food and nonfood
onsets.image.food = subj.onsets.image(cond_ID==1 | cond_ID==2 | cond_ID==3 | cond_ID==4) + corr_ons;
onsets.image.nonfood = subj.onsets.image(cond_ID==5) + corr_ons;

% Generate onsets for bidding (food and nonfood)
onsets.bidding.food = subj.onsets.scales.GFD((cond_ID_GFD==1 | cond_ID_GFD==2 | cond_ID_GFD==3 | cond_ID_GFD==4) & subj.onsets.scales.GFD ~= 0) + corr_ons;
onsets.bidding.nonfood = subj.onsets.scales.GFD(cond_ID_GFD==5 & subj.onsets.scales.GFD ~= 0) + corr_ons;
onsets.bidding.pmod.food = output.rating.value((cond_ID_GFD==1 | cond_ID_GFD==2 | cond_ID_GFD==3 | cond_ID_GFD==4) & ~isnan(output.rating.value));
onsets.bidding.pmod.nonfood = output.rating.value(cond_ID_GFD==5 & ~isnan(output.rating.value));

% Generate duration
duration.image.single = 3.5;
duration.bidding = 5;
duration.image.block = 5*duration.image.single;

