function  imageParameters = detemineImageParameters(handles)
% determineImageParamers function determine parameters from input. If user
% does not enter any of the inputs, default parameters are used.

imageParameters = struct;

% Pixel size.
pixelSize = str2num(get(handles.pixelSizeEdit,'String'));
isPixelSizeEnterCorrect = isempty(pixelSize);
if isPixelSizeEnterCorrect == 1
    msgbox('Pixel number: please enter a number.');
else
    imageParameters.pixelSize = pixelSize/1000; % micron
end

% Time interval unit
timeIntervalUnit = get(handles.timeIntervalEdit,'String');
istimeIntervalUnitSec = strcmp(timeIntervalUnit,{'sec','s'});
istimeIntervalUnitMin = strcmp(timeIntervalUnit,{'min','m'});
errorCondition = istimeIntervalUnitSec(1) == 0 && istimeIntervalUnitSec(2) == 0&&...
    istimeIntervalUnitMin(1) == 0 && istimeIntervalUnitMin(2) == 1;
if errorCondition
    msgbox('Time interval unit: please enter "s", "sec", "m" or "min".');
else
    imageParameters.timeIntervalUnit = timeIntervalUnit;
end

% Time interval
timeInterval = str2num(get(handles.timeIntervalEdit,'String'));
isTimeIntervalEnterCorrect = isempty(timeInterval);
if isTimeIntervalEnterCorrect == 1
    msgbox('Time interval: please enter a number.');
else
    imageParameters.timeInterval = timeInterval; 
end