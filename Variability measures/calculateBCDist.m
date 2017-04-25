%%% Evaluate Bhattacharyya Distance within a single cell over time for 3 spatial metrics

function [BCdist_IE, BCdist_NN, BCdist_OrgNuc] = calculateBCDist(Cell_MatFile)

%%% INPUTS
% 1. Cell_MatFile - .Mat file that stores all the evaluated spatial metrics of a single cell over multiple time-points
%%% OUTPUTS
% 1. BCdist_IE: Bhattacharyya distance between Inter-organelle
% distributions along time within a single cell
% 2. BCdist_NN: Bhattacharyya distance between Nearest-neighbor
% distribution along time within a single cell
% 3. BCdist_OrgNuc: Bhattacharyya distance between normalized distance to
% nucleus along time within a single cell

clear
clc

load(Cell_MatFile) %Load data from a single cell from multiple time-points
numTimePts = length(LysoIEDist); %Number of time-points 
pixelSize = 6.5e-6/60; 

%Extract multiple spatial metrics (IE dist, NN Dist, Norm dist to nucleus
for i = 1:numTimePts
    LysoIEDist{i} = LysoIEDist{i}/max(LysoIEDist{i});
    LysoOrgNuc{i} = LysoNucPeriphery{i,1}./(LysoNucPeriphery{i,1}+LysoNucPeriphery{i,2});
end

BCdist_IE = [];
BCdist_NN = [];
BCdist_OrgNuc = [];


%% Evaluating bhattacharyya distances within a single cell 

%(Normalized Inter-event distance)
for i = 1:length(LysoIEDist)-1
    for j = i+1:length(LysoIEDist)

    IEDist1 = LysoIEDist{i};
    [f1,x1] = ksdensity(IEDist1);

    IEDist2 = LysoIEDist{j};
    [f2,x2] = ksdensity(IEDist2);

    %Find max value
    maxVal = max(max(x1),max(x2));
    LstCnt = maxVal/50;
    % %finding appropriate least count
    % L1 = min(x1(2:end)-x1(1:end-1));
    % L2 = min(x2(2:end)-x2(1:end-1));
    % LstCnt = min(L1,L2);

    Cntrs = 0:LstCnt:maxVal;
    X1Val = hist(IEDist1, Cntrs);
    X2Val = hist(IEDist2, Cntrs);
    X1Val = X1Val/sum(X1Val);
    X2Val = X2Val/sum(X2Val);
    
    BC = sum(sqrt(X1Val.*X2Val));
    BCdist_IE = [BCdist_IE;i,j,-log(BC)];
    
    end
end

%Lyso Nearest Neighbor distance
for i = 1:length(LysoNNDist)-1
    for j = i+1:length(LysoNNDist)

    NNDist1 = LysoNNDist{i};
    [f1,x1] = ksdensity(NNDist1);

    NNDist2 = LysoNNDist{j};
    [f2,x2] = ksdensity(NNDist2);

    %Find max value
    maxVal = max(max(x1),max(x2));
    LstCnt = maxVal/50;
    % %finding appropriate least count
    % L1 = min(x1(2:end)-x1(1:end-1));
    % L2 = min(x2(2:end)-x2(1:end-1));
    % LstCnt = min(L1,L2);

    Cntrs = 0:LstCnt:maxVal;
    X1Val = hist(NNDist1, Cntrs);
    X2Val = hist(NNDist2, Cntrs);
    X1Val = X1Val/sum(X1Val);
    X2Val = X2Val/sum(X2Val);
    
    BC = sum(sqrt(X1Val.*X2Val));
    BCdist_NN = [BCdist_NN;i,j,-log(BC)];
    
    end
end

% Normalized Distance to Nucleus
for i = 1:length(LysoOrgNuc)-1
    for j = i+1:length(LysoOrgNuc)

    OrgNuc1 = LysoOrgNuc{i};
    [f1,x1] = ksdensity(OrgNuc1);

    OrgNuc2 = LysoOrgNuc{j};
    [f2,x2] = ksdensity(OrgNuc2);

    %Find max value
    maxVal = max(max(x1),max(x2));
    LstCnt = maxVal/50;
    % %finding appropriate least count
    % L1 = min(x1(2:end)-x1(1:end-1));
    % L2 = min(x2(2:end)-x2(1:end-1));
    % LstCnt = min(L1,L2);

    Cntrs = 0:LstCnt:maxVal;
    X1Val = hist(OrgNuc1, Cntrs);
    X2Val = hist(OrgNuc2, Cntrs);
    X1Val = X1Val/sum(X1Val);
    X2Val = X2Val/sum(X2Val);
    
    BC = sum(sqrt(X1Val.*X2Val));
    BCdist_OrgNuc = [BCdist_OrgNuc;i,j,-log(BC)];
    
    end
end

end
  



    