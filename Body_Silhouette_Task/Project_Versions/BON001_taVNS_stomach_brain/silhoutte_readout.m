clear all
close all
%% Settings
load([pwd '\RGBtoIntensities.mat'])
load([pwd '\maskInside_silhouettes.mat'])
maskInside = reshape(maskInside, [131440 1]);
datapath = 'X:\Projects\tVNS\TUE006\Tasks\BodySilC';
all_IDs = [1,2,3,5,6,7,9,10,11,12,13,14,15,16,18,22,23]; %insert all ID numbers you want to analyze
%% load data
for pos = 1:length(all_IDs)
    subj = all_IDs(pos);
    for ses = 1:4
        try
            if subj <10
                load([datapath '\silhouette_TUE006_00000' num2str(subj) '_S' num2str(ses) '.mat'],'ActivationSilhouette','DeactivationSilhouette')
            else
                load([datapath '\silhouette_TUE006_0000' num2str(subj) '_S' num2str(ses) '.mat'],'ActivationSilhouette','DeactivationSilhouette')
            end
        catch
            continue
        end

        %% Activation
        activationRGB = reshape(ActivationSilhouette,[131440 3]);
        intensityActivation = NaN(131440,3);
        maskChangedActivation = zeros(131440,1);
        for i = 1:length(activationRGB)
            if ~isequal(activationRGB(i,:), [1 1 1]) & ~isequal(activationRGB(i,:), [255 255 255])
                maskChangedActivation(i) = 1;
            end
        end
        maskChangedActivation = logical(maskChangedActivation);
        changedRGBActivation = activationRGB(maskChangedActivation,1:3);

        currentIntensitiesActivation = zeros(length(changedRGBActivation),1);
        for i = 1:length(changedRGBActivation)
            iRGB = changedRGBActivation(i,1:3);
            for k = 1:length(ActivationIntensities)
                if isequal(ActivationIntensities(k,1:3),iRGB)
                    match = k;
                    break
                end
            end
            currentIntensitiesActivation(i) = ActivationIntensities(match,4);
        end

        intensityResultsActivation = NaN(131440,1);
        intensityResultsActivation(maskInside) = 0;
        intensityResultsActivation(maskChangedActivation) = currentIntensitiesActivation;

        intensityResultsActivation = reshape(intensityResultsActivation,[620 212]);

        %% Deactivation
        deactivationRGB = reshape(DeactivationSilhouette,[131440 3]);
        intensityDeactivation = NaN(131440,3);
        maskChangedDeactivation = zeros(131440,1);
        for i = 1:length(deactivationRGB)
            if ~isequal(deactivationRGB(i,:), [1 1 1]) & ~isequal(deactivationRGB(i,:), [255 255 255])
                maskChangedDeactivation(i) = 1;
            end
        end
        maskChangedDeactivation = logical(maskChangedDeactivation);
        changedRGBDeactivation = deactivationRGB(maskChangedDeactivation,1:3);

        currentIntensitiesDeactivation = zeros(length(changedRGBDeactivation),1);
        for i = 1:length(changedRGBDeactivation)
            iRGB = changedRGBDeactivation(i,1:3);
            for k = 1:length(DeactivationIntensities)
                if isequal(DeactivationIntensities(k,1:3),iRGB)
                    match = k;
                    break
                end
            end
            currentIntensitiesDeactivation(i) = DeactivationIntensities(match,4);
        end

        intensityResultsDeactivation = NaN(131440,1);
        intensityResultsDeactivation(maskInside) = 0;
        intensityResultsDeactivation(maskChangedDeactivation) = currentIntensitiesDeactivation;

        intensityResultsDeactivation = reshape(intensityResultsDeactivation,[620 212]);

        save(['X:\Projects\tVNS\TUE006\Tasks\BodySilC\Intensities\silhouetteIntensities_ID' num2str(subj) '_S' num2str(ses) '.mat'], 'intensityResultsActivation','intensityResultsDeactivation')
    end
end