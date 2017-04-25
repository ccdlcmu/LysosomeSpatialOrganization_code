%%% Evaluate Area-Overlap Distance within a single cell over time for 3 spatial metrics

function [areaOverlap_IE, areaOverlap_NN, areaOverlap_OrgNuc] = calculateAreaOverlapDist(Cell_MatFile)

%%% INPUTS
% 1. Cell_MatFile - .Mat file that stores all the evaluated spatial metrics of a single cell over multiple time-points
%%% OUTPUTS
% 1. areaOverlap_IE: Area overlap distance between Inter-organelle
% distributions along time within a single cell
% 2. areaOverlap_NN: Area overlap distance between Nearest-neighbor
% distribution along time within a single cell
% 3. areaOverlap_OrgNuc: Area overlap distance between normalized distance to
% nucleus along time within a single cell

clear
clc


load(Cell_MatFile) %Load data from a single cell from multiple time-points
numTimePts = length(LysoIEDist); %Number of time-points 
pixelSize = 6.5e-6/60; 

for i = 1:numTimePts
    LysoIEDist{i} = LysoIEDist{i}/max(LysoIEDist{i});
    LysoOrgNuc{i} = LysoNucPeriphery{i,1}./(LysoNucPeriphery{i,1}+LysoNucPeriphery{i,2});
    %LysoOrgNuc{i} = LysoNucMD{i}./(LysoNucMD{i}+LysoCellMD{i});
end

areaOverlap_IE = [];
areaOverlap_NN = [];
areaOverlap_OrgNuc = [];

%% Distances within a single cell (Normalized Inter-event distance)
for i = 1:length(LysoIEDist)-1
    for j = i+1:length(LysoIEDist)

    IEDist1 = LysoIEDist{i};
    IEDist2 = LysoIEDist{j};

    LstCnt = 1/100;
    pts = 0:LstCnt:1;
    
    [f1,x1] = ksdensity(IEDist1,pts);
    [f2,x2] = ksdensity(IEDist2,pts);

    %Find area of non-overlap
    nonOverlap = trapz(abs(f1-f2));
    area_dist1 = trapz(f1);
    area_dist2 = trapz(f2);

    areaOverlap_IE = [areaOverlap_IE; nonOverlap/(area_dist1+area_dist2)];
    
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

    %Find area of non-overlap
    nonOverlap = trapz(abs(f1-f2));
    area_dist1 = trapz(f1);
    area_dist2 = trapz(f2);
    
    areaOverlap_NN = [areaOverlap_NN; nonOverlap/(area_dist1+area_dist2)];
    
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
    
    %Find area of non-overlap
    nonOverlap = trapz(abs(f1-f2));
    area_dist1 = trapz(f1);
    area_dist2 = trapz(f2);
    
    areaOverlap_OrgNuc = [areaOverlap_OrgNuc; nonOverlap/(area_dist1+area_dist2)];
    
    end
end

%Combine all 3 spatial metrics
areaOverlapDist = vertcat(areaOverlapDist, [areaOverlap_IE, areaOverlap_NN, areaOverlap_OrgNuc]); 
clearvars -except areaOverlapDist

end
   