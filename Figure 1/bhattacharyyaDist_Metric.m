function [BCdist, meanBC, stdBC] = bhattacharyyaDist_Metric(metric)

%% INPUTS
%metric catalog
%1:-inter-organelle distribution
%2:-nearest neighbor distribution
%3:-organelle-nucleus distance
%4:-organelle-nucleus-cellmembrane distance
%% OUTPUTS
%BCdist: Set of bhattacharyya distances 
%meanBC: Mean of bhattacharyya distances
%stdBC: Standard deviation of bhattacharyya distances

%% Bhattacharyya Distance between probability distributions
BCdist = [];

for cellNum = 1:1
    
    MatFileL = sprintf('LysoTreatedTBHPCell%0.3d.mat',cellNum);

    load (MatFileL)
    pixelSize = 6.5*1e-6/60;

    %Selecting metric to be compared (based on user-defined input)    
    if metric == 1
        metric_val = LysoIEDist;
    else if metric == 2
            metric_val = LysoNNDist;
        else if metric == 3
                metric_val = LysoNucPeriphery(:,1);
            else 
                for timePt = 1:length(LysoIEDist)
                    metric_val{timePt} = LysoNucPeriphery{timePt,1}./LysoNucPeriphery{timePt,2};
                end
            end
        end
    end

%% Bhattacharyya Distances within a group

for i = 1:length(metric_val)-1
    for j = i+1:length(metric_val)

    metric_1 = metric_val{i};
    [f1,x1] = ksdensity(metric_1);

    metric_2 = metric_val{j};
    [f2,x2] = ksdensity(metric_2);

    %Find max value
    maxVal = max(max(x1),max(x2));
    LstCnt = maxVal/50;
    
    Cntrs = 0:LstCnt:maxVal;
    X1Val = hist(metric_1, Cntrs);
    X2Val = hist(metric_2, Cntrs);
    X1Val = X1Val/sum(X1Val);
    X2Val = X2Val/sum(X2Val);
    
    BC = sum(sqrt(X1Val.*X2Val));
    BCdist = [BCdist;i,j,-log(BC)];
    
    end
end

%Evaluating mean and std-dev of bhattacharyya distance
meanBC = mean(BCdist(:,3));
stdBC = std(BCdist(:,3));
    
end
    