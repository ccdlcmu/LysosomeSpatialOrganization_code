
function [tracks, coords_x_org1] = MeanSqDisp(filename, orgName)
%% PURPOSE
%Single particle tracking of a small subset of organelles (to study
%possible correlation in their motion)

%INPUT Parameters
%filename: "arbitrary-name" (if the filename for coordinates is:
%trajectory_x_arbitrary-name
%orgName: "Lysosome" (the organelle of interest)

%% 
%Reading Organelle Coordinates (x & y coordinates)
fileread = strcat('trajectory_x_',filename,'.txt');
coords_x_org1 = csvread(fileread);
fileread = strcat('trajectory_y_',filename,'.txt');
coords_y_org1 = csvread(fileread);

coords_x_org1 = coords_x_org1(:,1:end-1); %Removing last set of values (due to terminating comma)
coords_y_org1 = coords_y_org1(:,1:end-1);
num_orgs1 = size(coords_x_org1,1); %Number of organelles => Number of rows

%Cleaning data (Removing organelle trajectories (with less than 50 tracked
%points))
a = [];
for org1 = 1:num_orgs1
    if length(find(coords_x_org1(org1, :) ~= -1)) < 30 %size(coords_x_org1,2)/2 
        a = [a;org1];
    end
end

coords_x_org1(a,:) = []; %Deleting organelles that are tracked for < 50 frames
coords_y_org1(a,:) = [];

num_orgs1 = size(coords_x_org1,1); 
tracks = {};
time = 0:1:size(coords_x_org1,2); 

%Generate all tracks for all organelles (of the same kind)
for org1 = 1:num_orgs1
    validTimesteps = find(coords_x_org1(org1, :) ~= -1);
    coords = [coords_x_org1(org1, validTimesteps); coords_y_org1(org1, validTimesteps)]';
    timeSteps = [1:size(validTimesteps,2)];
    tracks{org1} = [timeSteps' coords*0.06];
end


% Simulation Parameters (Mean-sq-displacement)
SPACE_UNITS = 'um';
TIME_UNITS = 's';
N_DIM = 2; % 2D

ma = msdanalyzer(N_DIM, SPACE_UNITS, TIME_UNITS);
ma = ma.addAll(tracks);

% Plot Organelle Tracks
[hps, ha] = ma.plotTracks;
ma.labelPlotTracks(ha);
title(strcat(orgName, ' Trajectory'))

%compute Mean-square-displacement
ma = ma.computeMSD;

%plot Mean-square-displacement for each of the trajectories
figure,
ma.plotMSD
title(strcat(orgName, ':MSD'))

%figure,
%hmsd = ma.plotMeanMSD(gca, true);

%ma = ma.computeVCorr;
%ma.plotMeanVCorr

%% Classify tracks into Brownian, Directed & Confined motion based on the MSD curve

tracks = ma.tracks;

% Fit log MSD for 75% of the trajectory
ma = fitLogLogMSD(ma, 0.75);

%Count number of confined particles
confinedParticle = find(ma.loglogfit.alpha<0.90);
numConfined = length(confinedParticle);

%Count number of directed particles
directedParticle = find(and(ma.loglogfit.alpha>1.20, ma.loglogfit.r2fit>0.85)); %find(ma.loglogfit.alpha>1.10);
numDirected = length(directedParticle);

%Count number of brownian particles
brownianParticle = find(and(and(ma.loglogfit.alpha>1, ma.loglogfit.alpha<1.10),ma.loglogfit.r2fit>0.85));
numBrownian = length(brownianParticle);

% PLOT MSD wrt mode, Tracks wrt mode, loglogMSD wrt mode
figure,
plotMSDwMode(confinedParticle, directedParticle, brownianParticle, ma);
figure,
plotTrackswMode(confinedParticle, brownianParticle, directedParticle, tracks)
figure,
plotloglogMSD(ma, confinedParticle, brownianParticle, directedParticle)

%% APPENDIX
%numConfined = length(find(and(ma.loglogfit.alpha<0.90, ma.loglogfit.r2fit>0.75)));
%numConfined = length(f ind(and(ma.loglogfit.alpha<1, ma.loglogfit.r2fit>0.75)));
%numDirected = length(find(and(ma.loglogfit.alpha>1.10, ma.loglogfit.r2fit>0.75)));
%numDirected = length(find(and(ma.loglogfit.alpha>1.50, ma.loglogfit.r2fit>0.85)));
%numBrownian = length(find(and(and(ma.loglogfit.alpha>1, ma.loglogfit.alpha<1.20),ma.loglogfit.r2fit>0.95)));