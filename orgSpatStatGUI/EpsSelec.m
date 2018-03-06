function Eps = EpsSelec(pt,thresh,minpts)
% Function for selecting Eps based on a threshold local density within k
% nearest neighbor distances (where k = minpts).

% Input
% pt: point locations; 2-column matrix
% thresh: threshold point density (#/area)
% minpts: neighborhood point numbers

% Output
% Eps: neighborhood size to search for clustering

% By Qinle Ba at BME, Carnegie Mellon Univeristy, 2017-April


[~,KNND] = knnsearch(pt,pt,'K',minpts+1);
SortKNND = sort(KNND(:,end),'descend');
KNNDensty = minpts./( pi*SortKNND.^2 ); % estimated Eps
% figure, plot(KNNDensty)
idxs = find(KNNDensty>thresh);
if isempty(idxs) == 0
   Eps= SortKNND(idxs(1));
else
    Eps = [];
end

end