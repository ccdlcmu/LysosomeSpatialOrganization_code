%%% Evaluate Euclidean Distance within a single cell over time for 3 spatial metrics

function [Eucliddist_IE, Eucliddist_NN, Eucliddist_OrgNuc] = calculateEuclidDist(Cell_MatFile)

%%% INPUTS
% 1. Cell_MatFile - .Mat file that stores all the evaluated spatial metrics of a single cell over multiple time-points
%%% OUTPUTS
% 1. Eucliddist_IE: Euclidean distance between Inter-organelle
% distributions along time within a single cell
% 2. Eucliddist_NN: Euclidean distance between Nearest-neighbor
% distribution along time within a single cell
% 3. Eucliddist_OrgNuc: Euclidean distance between normalized distance to
% nucleus along time within a single cell

clear
clc

eucDist = [];

load(Cell_MatFile) %Load data from a single cell from multiple time-points
numTimePts = length(LysoIEDist); %Number of time-points 
pixelSize = 6.5e-6/60; 

for i = 1:numTimePts
    LysoIEDist{i} = LysoIEDist{i}/max(LysoIEDist{i});
    LysoOrgNuc{i} = LysoNucPeriphery{i,1}./(LysoNucPeriphery{i,1}+LysoNucPeriphery{i,2});
    %LysoOrgNuc{i} = LysoNucMD{i}./(LysoNucMD{i}+LysoCellMD{i});
end

Eucliddist_IE = [];
Eucliddist_NN = [];
Eucliddist_OrgNuc = [];

%% Distances within a single cell (Normalized Inter-event distance)
for i = 1:length(LysoIEDist)-1
    for j = i+1:length(LysoIEDist)

    IEDist1 = LysoIEDist{i};
    IEDist2 = LysoIEDist{j};

    LstCnt = 1/100;
    pts = 0:LstCnt:1;
    
    [f1,x1] = ksdensity(IEDist1,pts);
    [f2,x2] = ksdensity(IEDist2,pts);

    euc_dist = mean((f1-f2).^2);
    Eucliddist_IE = [Eucliddist_IE;i,j,euc_dist];
    
    end
end

% Lyso Nearest Neighbor distance
for i = 1:length(LysoNNDist)-1
    for j = i+1:length(LysoNNDist)

    NNDist1 = LysoNNDist{i};
    NNDist2 = LysoNNDist{j};

    maxNNDist = max(max(NNDist1),max(NNDist2));
    LstCount = maxNNDist/100;
    
    pts = 0:LstCount:maxNNDist;
    
    [f1,x1] = ksdensity(NNDist1, pts);
    [f2,x2] = ksdensity(NNDist2, pts);

    euc_dist = mean((f1-f2).^2);
    Eucliddist_NN = [Eucliddist_NN;i,j,euc_dist];
    
    end
end

% Normalized Distance to Nucleus
for i = 1:length(LysoOrgNuc)-1
    for j = i+1:length(LysoOrgNuc)

    OrgNuc1 = LysoOrgNuc{i};
    OrgNuc2 = LysoOrgNuc{j};
    
    LstCnt = 1/100;
    pts = 0:LstCnt:1;
    
    [f1,x1] = ksdensity(OrgNuc1, pts);
    [f2,x2] = ksdensity(OrgNuc2, pts);

    euc_dist = mean((f1-f2).^2);
    Eucliddist_OrgNuc = [Eucliddist_OrgNuc;i,j,euc_dist];
    
    end
end

%Combine all 3 spatial metrics
eucDist = vertcat(eucDist, [Eucliddist_IE(:,3),Eucliddist_NN(:,3),Eucliddist_OrgNuc(:,3)]); 
clearvars -except eucDist

end

