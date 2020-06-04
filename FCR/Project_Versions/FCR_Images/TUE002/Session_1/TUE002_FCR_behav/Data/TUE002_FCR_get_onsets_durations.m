
MR_metadata_path = input('Full path to FCR MR data: ','s');
load(MR_metadata_path)

% Generate condition identifier
cond_ID = design.rand.order_mat(:,3);
cond_ID_GFD = design.rand.order_mat(:,3);
cond_ID_GFD_rating = design.rand.order_mat(:,3);

for i = 1:length(cond_ID)
    
   if mod(i,5) ~= 1
       
       cond_ID(i) = 0;
       cond_ID_GFD(i) = 0;
       
   end
    
end

cond_ID_GFD(cond_ID_GFD == 0) = [];

% Add time for dummy volumes
if MR_timings.dummy_volumes ~= 0

    corr_ons = MR_timings.trigger.all(MR_timings.dummy_volumes) - MR_timings.trigger.all(1);
    
end

% Generate onsets for food and nonfood
if MR_timings.dummy_volumes ~= 0
    onsets.image.food = MR_timings.onsets.image(cond_ID==1 | cond_ID==2 | cond_ID==3 | cond_ID==4) + corr_ons;
    onsets.image.nonfood = MR_timings.onsets.image(cond_ID==5) + corr_ons;
else
    onsets.image.food = MR_timings.onsets.image(cond_ID==1 | cond_ID==2 | cond_ID==3 | cond_ID==4);
    onsets.image.nonfood = MR_timings.onsets.image(cond_ID==5);
end

% Generate onsets for bidding (food and nonfood)
if MR_timings.dummy_volumes ~= 0
    onsets.bidding.food = MR_timings.onsets.scales.GFD(cond_ID_GFD==1 | cond_ID_GFD==2 | cond_ID_GFD==3 | cond_ID_GFD==4) + corr_ons;
    onsets.bidding.nonfood = MR_timings.onsets.scales.GFD(cond_ID_GFD==5) + corr_ons;
else
    onsets.bidding.food = MR_timings.onsets.scales.GFD(cond_ID_GFD==1 | cond_ID_GFD==2 | cond_ID_GFD==3 | cond_ID_GFD==4);
    onsets.bidding.nonfood = MR_timings.onsets.scales.GFD(cond_ID_GFD==5);
end

onsets.bidding.pmod.food = output.rating.value((cond_ID_GFD_rating==1 | cond_ID_GFD_rating==2 | cond_ID_GFD_rating==3 | cond_ID_GFD_rating==4) & ~isnan(output.rating.value));
onsets.bidding.pmod.nonfood = output.rating.value(cond_ID_GFD_rating==5 & ~isnan(output.rating.value));

% Generate duration
durations.image.single = MR_timings.durations.image;
durations.bidding = MR_timings.durations.scales.GFD;
durations.image.block = 5*durations.image.single;

% Clean up
clearvars -except onsets durations


