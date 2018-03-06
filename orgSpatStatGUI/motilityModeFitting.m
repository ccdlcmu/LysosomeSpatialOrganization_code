function  fitResult = motilityModeFitting(cellTracks)

warning('off','all')

% lagForFit = 0.1; % around 10 frame per second, i.e. time lag = 0.1 s
% lagNumb = 14;

lagForFit = 1/1.16;
lagNumb = 20;
opts = statset('nlinfit');
opts.RobustWgtFun = 'bisquare';
modelstr = 'y ~  b1*x^b2';
b0 = [0;0];
AdjRsquareThresh = 0.7; % Threshold for fitting results
timeLag = lagForFit*(1:lagNumb)';
par = [0.9;1.2;1.2];

tracksAll = cellTracks;
nTrack = length(tracksAll);

figure,
bp =[];  mode =[]; msd = {};
iiTrack = 0; trackNoRecord = [];
for iTrack = 1:nTrack
    
    trackTXY = tracksAll{iTrack};
    if size(trackTXY,1)> lagNumb
        % calculate MSD
        msdTrack = MSD(trackTXY(:,2:3), lagNumb);
%         trackTXY = trackTXY/pixelSize;
        % fit diffusion model
%         trackTXY
%         msdTrack
        mdl = fitnlm(timeLag, msdTrack(1:lagNumb),modelstr,b0,'Options',opts);
        
        if mdl.Rsquared.Adjusted>AdjRsquareThresh
            iiTrack = iiTrack + 1; % a track that is well fitted
            trackNoRecord(iiTrack,1) = iTrack;
            b = mdl.Coefficients;
            bp(iiTrack,:) = [b{:,'Estimate'}; b{:,'pValue'};  mdl.Rsquared.Adjusted; mdl.RMSE]';
            
            % ---------------- diffusion mode------------------------ %
            b2 = b{2,'Estimate'};
            if b2 < par(1) % subdiffusion
                mode(iiTrack,1) = 0;
                %--
                plot(trackTXY(:,2),trackTXY(:,3),'g')
                hold on
                %--
            elseif b2 > par(3) % direct transport
                mode(iiTrack,1) = 1;
                %--
                plot(trackTXY(:,2),trackTXY(:,3),'r')
                hold on
                %--
            elseif b2 >= par(1) && b2 <= par(2) % free diffusion
                mode(iiTrack,1) = 2;
                %--
                plot(trackTXY(:,2),trackTXY(:,3),'b')
                hold on
                %--
            else
                mode(iiTrack,1) = -1;
            end
            
            
            msd{iiTrack,1} = msdTrack;
            
        end
        
    end
end % end trackNo



nTrackFitted = sum(mode >-1);
modePercentage(1,1) = sum(mode == 0)/nTrackFitted*100; % subdiffusion
modePercentage(2,1) = sum(mode == 1)/nTrackFitted*100; % direct transport
modePercentage(3,1) = sum(mode == 2)/nTrackFitted*100; % free diffusion
fitResult.modePercentage = modePercentage;
fitResult.mode = mode;
fitResult.msd = msd;
fitResult.bp = bp;
fitResult.trackNo = trackNoRecord;
fitResult.par = par;
%
%
%         save(fullfile(trackFitFolder,['Fib_' sampleTypes{iSampleType} ...
%             '_' num2str(iiCell) '_trackFit.mat']),'fitResult');

% modePercentageSample(end+1,:) = modePercentage';
% modePercentageMean(iSampleType,:) = mean(modePercentageSample);
% modePercentageStd(iSampleType,:) = sqrt(var(modePercentageSample));



% save('modePerct.mat','modePercentageMean','modePercentageStd')

