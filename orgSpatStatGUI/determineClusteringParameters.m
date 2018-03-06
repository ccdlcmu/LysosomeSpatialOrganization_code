function clusterParameters = determineClusteringParameters(handles)

minPts = str2num(get(handles.minPtsEdit,'String'));

clusterParameters.minPts = minPts;

isManualSelection = get(handles.manualSelectEpsRadio,'Value');
isRunSimulation = get(handles.runRSimulationForEpsRadio,'Value');
isLoadSimulation = get(handles.loadSimulationResultsForEpsRadio,'Value');

if isManualSelection == 1

    eps = str2num(get(handles.epsEdit,'String'));
% elseif isRunSimularion == 1
%     % runRSimulation()
% elseif isLoadSimulation == 1
%     loadSimulationForEps()
    
end
clusterParameters.eps = eps;