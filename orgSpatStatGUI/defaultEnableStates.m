function defaultEnableStates(handles)
% This function sets up GUI Enable properties upon initialization

set(handles.organelleImagePathBrowse,'Enable','off');
set(handles.cellImagePathBrowse,'Enable','off');
set(handles.nucleusImagePathBrowse,'Enable','off');
set(handles.organelleImagePathEdit,'Enable','off');
set(handles.cellImagePathEdit,'Enable','off');
set(handles.nucleusImagePathEdit,'Enable','off');
end