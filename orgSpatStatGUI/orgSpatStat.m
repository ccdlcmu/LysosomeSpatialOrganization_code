function varargout = orgSpatStat(varargin)
% ORGSPATSTAT MATLAB code for orgSpatStat.fig
%      ORGSPATSTAT, by itself, creates a new ORGSPATSTAT or raises the existing
%      singleton*.
%
%      H = ORGSPATSTAT returns the handle to a new ORGSPATSTAT or the handle to
%      the existing singleton*.
%
%      ORGSPATSTAT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ORGSPATSTAT.M with the given input arguments.
%
%      ORGSPATSTAT('Property','Value',...) creates a new ORGSPATSTAT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before orgSpatStat_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to orgSpatStat_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help orgSpatStat

% Last Modified by GUIDE v2.5 05-Mar-2018 23:37:05

% By Qinle Ba, Biomedical Engineering Department at Carnegie Mellon University

% clc;
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @orgSpatStat_OpeningFcn, ...
                   'gui_OutputFcn',  @orgSpatStat_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before orgSpatStat is made visible.
function orgSpatStat_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to orgSpatStat (see VARARGIN)

% % Set up GUI Enable properties upon initialization
% defaultEnableStates(handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Default Parameters.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Default custering parameters.
handles.minPts = 5;
% handles.pixelSize = 0.108;
handles.timeInterval = 1;
handles.timeIntervalUnit = 's';



% Choose default command line output for orgSpatStat
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes orgSpatStat wait for user response (see UIRESUME)
% uiwait(handles.orgSpatStat);


% --- Outputs from this function are returned to the command line.
function varargout = orgSpatStat_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function projectMenu_Callback(hObject, eventdata, handles)
% hObject    handle to projectMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function newProjectDirectoryCreation_Callback(hObject, eventdata, handles)
% hObject    handle to newProjectDirectoryCreation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Create default directory: 

handles.defaultNewProjectDirectory = 'G:\';%matlabroot;
% Open folder selection dialog box with a title
newProjectDirectory = uigetdir(handles.defaultNewProjectDirectory,'New Project directory');
%newProjectDirectory = uigetdir(matlabroot,'New Project directory');

% Create subdictories under this new project directory
createProjectDirectory(newProjectDirectory);

% Set the chosen directory as the new project directory
handles.newProjectDirectory = newProjectDirectory;
display(['Project directory: ' handles.newProjectDirectory]);

% Update handle structures
guidata(hObject,handles);

% --------------------------------------------------------------------
function fileMenuExit_Callback(hObject, eventdata, handles)
% hObject    handle to fileMenuExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figHandles = findall(groot,'Tag','orgSpatStat'); % Get the handle of orgSpatStat
choice = questdlg('Do you want to exit?','Exit','Yes','No','No');
switch choice,
    case 'Yes', 
        delete(figHandles);
    case 'No', 
        return;
end % switch



% --- Executes on button press in defaultParameter.
function defaultParameter_Callback(hObject, eventdata, handles)
% hObject    handle to defaultParameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FRAME SELECTION CALLBACKS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in allFramesRadio.
function allFramesRadio_Callback(hObject, eventdata, handles)
% hObject    handle to allFramesRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of allFramesRadio

% Disable the other option to enter select frames
set(handles.frameIndicesEdit,'Enable','off');

set(handles.selectFramesRadio,'Value',0);

display('Frames selected: all frames')

% store the state 
handles.frameSelection = 1; % All frames

guidata(hObject,handles);


% --- Executes on button press in selectFramesRadio.
function selectFramesRadio_Callback(hObject, eventdata, handles)
% hObject    handle to selectFramesRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectFramesRadio

% Disable the other option to select frames
set(handles.frameIndicesEdit,'Enable','on');

set(handles.allFramesRadio,'Value',0);

% store the state 
handles.frameSelection = 2; % Select frames.

guidata(hObject,handles);



function frameIndicesEdit_Callback(hObject, eventdata, handles)
% hObject    handle to frameIndicesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frameIndicesEdit as text
%        str2double(get(hObject,'String')) returns contents of frameIndicesEdit as a double
% set(handles.frameIndicesEdit,'String',);

frameIndices = str2num(get(hObject,'String'));
handles.frameIndices = frameIndices;

display(['Frames selected: ' get(hObject,'String')])

guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function frameIndicesEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frameIndicesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function particlePathEdit_Callback(hObject, eventdata, handles)
% hObject    handle to particlePathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of particlePathEdit as text
%        str2double(get(hObject,'String')) returns contents of particlePathEdit as a double


% --- Executes during object creation, after setting all properties.
function particlePathEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to particlePathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in particlePathBrowse.
function particlePathBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to particlePathBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guiPath = pwd;
projectPath = handles.newProjectDirectory; % Get project path.
defaultParticlePath = fullfile(projectPath, 'particleDetectionResults');
handles.defaultParticlePath = defaultParticlePath;


% cd(handles.defaultParticlePath) % Set the current path to be particleDetectionResults subfolder.
% [particleFile,newParticlePath,~]= uigetfile(...
%     {'*.xls'; '*.txt'; '*.mat'},'Select particle detection file');
%%%
[particleFile,newParticlePath,~]= uigetfile(...
    {'*.mat';'*.xls'; '*.txt'},'Select particle detection file', handles.defaultParticlePath, 'MultiSelect', 'on'); % can select multiple files
%%%
cd(guiPath) 

if isequal(newParticlePath,0) == 1 % if user clicked "cancel"
    disp('Please select a file')
elseif iscell(particleFile)==0 % one file
    isDefaultParticlePath = strcmp(newParticlePath,[defaultParticlePath filesep]);
    if isDefaultParticlePath == 0 %if user clicked a file not in the default path
        disp('Please select a file in the subfolder "particleDetectionResults" of the project folder.')
    else % if user clicked a file in the default path
        handles.particleFileName = fullfile(defaultParticlePath, particleFile);
        handles.particleFile = particleFile;
        set(handles.particlePathEdit,'String', handles.defaultParticlePath);
    end
    % elseif iscell(particleFile)==0
end

% handlesOrgSpatStat = findall(groot, 'Tag', 'orgspatstat');
% guidata(handleOrgSpatStat,handles)
guidata(hObject,handles);



% --- Executes on button press in saveParameter.
function saveParameter_Callback(hObject, eventdata, handles)
% hObject    handle to saveParameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function pixelSizeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to pixelSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pixelSizeEdit as text
%        str2double(get(hObject,'String')) returns contents of pixelSizeEdit as a double

handle.pixelSize = str2num(get(hObject,'String'));

guidata(hObject,handles);




% --- Executes during object creation, after setting all properties.
function pixelSizeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pixelSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function timeIntervalEdit_Callback(hObject, eventdata, handles)
% hObject    handle to timeIntervalEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timeIntervalEdit as text
%        str2double(get(hObject,'String')) returns contents of timeIntervalEdit as a double

% handle.timeInterval = str2num(get(hObject,'String'));
% 
% guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function timeIntervalEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeIntervalEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function timeIntervalUnitEdit_Callback(hObject, eventdata, handles)
% hObject    handle to timeIntervalUnitEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timeIntervalUnitEdit as text
%        str2double(get(hObject,'String')) returns contents of timeIntervalUnitEdit as a double
% handle.timeIntervalUnit = get(hObject,'String'); % 's' or 'm'
% 
% guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function timeIntervalUnitEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeIntervalUnitEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DRAW BOUNDARY CALLBACKS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in drawCellBoundaryRadio.
function drawCellBoundaryRadio_Callback(hObject, eventdata, handles)
% hObject    handle to drawCellBoundaryRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawCellBoundaryRadio

% exclusive selection
set(handles.drawNucleusBoundaryRadio,'Value',0)
set(handles.loadBoundaryRadio,'Value',0)

guidata(hObject,handles)


% --- Executes on button press in drawNucleusBoundaryRadio.
function drawNucleusBoundaryRadio_Callback(hObject, eventdata, handles)
% hObject    handle to drawNucleusBoundaryRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawNucleusBoundaryRadio

% exclusive slection
set(handles.drawCellBoundaryRadio,'Value',0)
set(handles.loadBoundaryRadio,'Value',0)

guidata(hObject,handles)


% --- Executes on button press in loadBoundaryRadio.
function loadBoundaryRadio_Callback(hObject, eventdata, handles)
% hObject    handle to loadBoundaryRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of loadBoundaryRadio
set(handles.drawCellBoundaryRadio,'Value',0)
set(handles.drawNucleusBoundaryRadio,'Value',0)

guidata(hObject,handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IMAGE SELECTION CALLBACKS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in cellImagePathBrowse.
function cellImagePathBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to cellImagePathBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guiPath = pwd; % Get gui path.
projectPath = handles.newProjectDirectory; % Get project path.
defaultBoundaryImagePath = fullfile(projectPath, 'imagesCellNucBoundary');
handles.defaultBoundaryImagePath = defaultBoundaryImagePath;

cd(defaultBoundaryImagePath) % Switch to "images" folder.
[ImageFile,newImagePath,~]= uigetfile(...
    {'*.tif';'*.png'},'Select image file');

cd(guiPath) % Switch back to gui path.

if isequal(newImagePath,0) == 1 % if user clicked "cancel"
    disp('Please select an image file')
else
    isdefaultBoundaryImagePath = strcmp(newImagePath,[defaultBoundaryImagePath filesep]);
    if isdefaultBoundaryImagePath == 0 %if user clicked a file not in the default path
        disp('Please select a file in the subfolder "images" of the project folder.')
    else % if user clicked a file in the default path
        handles.cellImageFileName = fullfile(defaultBoundaryImagePath, ImageFile);
%         set(handles.cellImagePathBrowse,'String', handles.cellImageFileName);
    end 
end

guidata(hObject,handles);

% --- Executes on button press in nucleusImagePathBrowse.
function nucleusImagePathBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to nucleusImagePathBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guiPath = pwd; % Get gui path
projectPath = handles.newProjectDirectory; % Get project path.
defaultBoundaryImagePath = fullfile(projectPath, 'imagesCellNucBoundary');

handles.defaultBoundaryImagePath = defaultBoundaryImagePath;
cd(defaultBoundaryImagePath)
[ImageFile,newImagePath,~]= uigetfile(...
    {'*.tif';'*.png'},'Select image file');

cd(guiPath);

if isequal(newImagePath,0) == 1 % if user clicked "cancel"
    display('Please select an image file')
else
    isdefaultBoundaryImagePath = strcmp(newImagePath,[defaultBoundaryImagePath filesep]);
    if isdefaultBoundaryImagePath == 0 %if user clicked a file not in the default path
        disp('Please select a file in the subfolder "images" of the project folder.')
    else % if user clicked a file in the default path
        handles.nucleusImageFileName = fullfile(defaultBoundaryImagePath, ImageFile);
%         set(handles.nucleusImagePathEdit,'String', handles.nucleusImageFileName);
    end 
end

guidata(hObject,handles);

function cellImagePathEdit_Callback(hObject, eventdata, handles)
% hObject    handle to cellImagePathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cellImagePathEdit as text
%        str2double(get(hObject,'String')) returns contents of cellImagePathEdit as a double


% --- Executes during object creation, after setting all properties.
function cellImagePathEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cellImagePathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nucleusImagePathEdit_Callback(hObject, eventdata, handles)
% hObject    handle to nucleusImagePathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nucleusImagePathEdit as text
%        str2double(get(hObject,'String')) returns contents of nucleusImagePathEdit as a double


% --- Executes during object creation, after setting all properties.
function nucleusImagePathEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nucleusImagePathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in drawStart.
function drawStart_Callback(hObject, eventdata, handles)
% hObject    handle to drawStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check which boundary to draw (cell or nucleus).
if get(handles.drawCellBoundaryRadio,'Value') == 1
    whichBoundary = 'cell';
elseif get(handles.drawNucleusBoundaryRadio,'Value') == 1
    whichBoundary = 'nucleus';
elseif get(handles.loadBoundaryRadio,'Value')==1
    whichBoundary = 'load';
else
    msgbox('Please select which boundary to draw or load data')
end

if  strcmp(whichBoundary,'load')
    
    % Get file path and name(s)
    guiPath = pwd;
    defaultBoundaryPath = fullfile(handles.newProjectDirectory,'cellNucleusBoundaries');
    [boundaryFile,boundaryPath,~] = uigetfile(...
        {'.mat'},'Select boundary files',defaultBoundaryPath,'multiSelect','on');
    cd(guiPath)
    
    isDefaultBoundaryPath = strcmp(boundaryPath,[defaultBoundaryPath filesep]);
    if isequal(boundaryPath,0) % if user clicked "cancel"
        disp('Please select a file')
        
    elseif ~isDefaultBoundaryPath %if user clicked a file not in the default path
        disp('Please select a file in the subfolder "cellNucleusBoundaries" of the project folder.')
    elseif isDefaultBoundaryPath
         [boundary, boundaryType] = loadCellNucleusBoundary(boundaryPath,boundaryFile);
         
         if strcmp(boundaryType{1},'cell')
             handles.cellBoundary = boundary;
         elseif strcmp(boundaryType{1},'nucleus') 
             handles.nucleusBoundary = boundary;
         end
        
         if and( length(boundaryType)>1, strcmp(boundaryType{1},'cell') )
             handles.cellBoundary = boundary{1};
             handles.nucleusBoundary = boundary{2};
         elseif and( length(boundaryType)>1, strcmp(boundaryType{1},'nucleus') )
             handles.cellBoundary = boundary{2};
             handles.nucleusBoundary = boundary{1};
         end

    end
%     elseif and(isDefaultBoundaryPath, ~iscell(boundaryFile)) % one file
%         isCellBoundary = contain(boundaryFile,'CellBoundary');
%         isNucleusBoundary = contain(boundaryFile,'NucleusBoundary');
%         
%         if isCellBoundary
%             handles.cellBoundaryFileName = fullfile(boundaryPath, boundaryFile);
%             load(handles.cellBoundaryFileName)
%             if 
%             handles.cellBoundary = posCell; 
%         elseif isNucleusBoundary
%             handles.nucelusBoundaryFileName = fullfile(boundaryPath, boundaryFile);
%             load(handles.nucleusBoundaryFileName)
%             handles.nucleusBoundary = posNuc;  
%         end % end isCellBoundary
%         
%     elseif iscell(boundaryFile) % two files
%         
%         if contain(boundaryFile{1},'CellBoundary')
%             handles.cellBoundaryFileName = fullfile(boundaryPath, boundaryFile{1});
%             load(handles.cellBoundaryFileName)
%             handles.cellBoundary = posCell; 
%             
%             handles.nucelusBoundaryFileName = fullfile(boundaryPath, boundaryFile{2});
%             load(handles.nucleusBoundaryFileName)
%             handles.nucleusBoundary = posNuc;
%             
%         elseif contain(boundaryFile{2},'CellBoundary')
%             handles.cellBoundaryFileName = fullfile(boundaryPath, boundaryFile{2});
%             load(handles.cellBoundaryFileName)
%             handles.cellBoundary = posCell; 
%             
%             handles.nucelusBoundaryFileName = fullfile(boundaryPath, boundaryFile{1});
%             load(handles.nucleusBoundaryFileName)
%             handles.nucleusBoundary = posNuc;  
%             
%         end
        
%     end % end "load"
    
else % Draw boundaries
    
    cellName = handles.cellNaming;% Determine file names for cell and nucleus boundaries

    existCellImage = exist(handles.cellImageFileName);
    switch existCellImage
        case 0
            msgbox('Please choose a cell image path!') % At least enter cell image path.
    end
    
    existNucluesImage = exist('handles.nucleusImageFileName');
    switch existNucluesImage
        case 0 % Draw boundaries using a single image.
            nImage = 1;
        otherwise % Draw boundaries using two images.
            nImage = 2;
    end
    boundaryPositions = drawCellNucleusBoundary(handles,nImage);
    
    switch whichBoundary
        case 'cell'
            cellBoundary = boundaryPositions;
            handles.cellBoundary = cellBoundary;
            % Save boundary
            cellBoundaryFileName = fullfile(...
                handles.newProjectDirectory,'cellNucleusBoundaries',[cellName '_CellBoundary.mat']);
            save(cellBoundaryFileName,'cellBoundary'); 
            disp(cellBoundaryFileName)
        case 'nucleus'
            nucleusBoundary = boundaryPositions;
            handles.nucleusBoundary = nucleusBoundary;
            % Save boundary
            nucleusBoundaryFileName = fullfile(...
                handles.newProjectDirectory,'cellNucleusBoundaries',[cellName '_NucleusBoundary.mat']);
            save(nucleusBoundaryFileName,'nucleusBoundary');
    end
    

end
guidata(hObject,handles)





% --- Executes on button press in drawSave.
function drawSave_Callback(hObject, eventdata, handles)
% hObject    handle to drawSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in drawRedo.
function drawRedo_Callback(hObject, eventdata, handles)
% hObject    handle to drawRedo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)






function minPtsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to minPtsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minPtsEdit as text
%        str2double(get(hObject,'String')) returns contents of minPtsEdit as a double


% --- Executes during object creation, after setting all properties.
function minPtsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minPtsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in manualSelectEpsRadio.
function manualSelectEpsRadio_Callback(hObject, eventdata, handles)
% hObject    handle to manualSelectEpsRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of manualSelectEpsRadio
set(handles.runRSimulationForEpsRadio,'Value',0);
set(handles.loadSimulationResultsForEpsRadio,'Value',0);
 

function epsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to epsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epsEdit as text
%        str2double(get(hObject,'String')) returns contents of epsEdit as a double



% --- Executes during object creation, after setting all properties.
function epsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in runRSimulationForEpsRadio.
function runRSimulationForEpsRadio_Callback(hObject, eventdata, handles)
% hObject    handle to runRSimulationForEpsRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of runRSimulationForEpsRadio
set(handles.manualSelectEpsRadio,'Value',0);
set(handles.loadSimulationResultsForEpsRadio,'Value',0);
 

% --- Executes on button press in startRSimulationForEps.
function startRSimulationForEps_Callback(hObject, eventdata, handles)
% hObject    handle to startRSimulationForEps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function epsEstimateEdit_Callback(hObject, eventdata, handles)
% hObject    handle to epsEstimateEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epsEstimateEdit as text
%        str2double(get(hObject,'String')) returns contents of epsEstimateEdit as a double


% --- Executes during object creation, after setting all properties.
function epsEstimateEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epsEstimateEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startEstimateEps.
function startEstimateEps_Callback(hObject, eventdata, handles)
% hObject    handle to startEstimateEps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in loadSimulationResultsForEpsRadio.
function loadSimulationResultsForEpsRadio_Callback(hObject, eventdata, handles)
% hObject    handle to loadSimulationResultsForEpsRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of loadSimulationResultsForEpsRadio
set(handles.manualSelectEpsRadio,'Value',0);
set(handles.runRSimulationForEpsRadio,'Value',0);


% --- Executes during object creation, after setting all properties.
function allFramesRadio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to allFramesRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function boundaryImagePanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boundaryImagePanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in loadParticleInCellRadio.
function loadParticleInCellRadio_Callback(hObject, eventdata, handles)
% hObject    handle to loadParticleInCellRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of loadParticleInCellRadio
set(handles.extractParticleInCellIcyRadio,'Value',0);
set(handles.extractParticleInCellCustomRadio,'Value',0);

% --- Executes on button press in extractParticleInCellCustomRadio.
function extractParticleInCellCustomRadio_Callback(hObject, eventdata, handles)
% hObject    handle to extractParticleInCellCustomRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of extractParticleInCellCustomRadio

set(handles.loadParticleInCellRadio,'Value',0);
set(handles.extractParticleInCellIcyRadio,'Value',0);

% --- Executes during object creation, after setting all properties.
function extractParticleInCellCustomRadio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to extractParticleInCellCustomRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in particleExtractStart.
function particleExtractStart_Callback(hObject, eventdata, handles)
% hObject    handle to particleExtractStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

radioValue1 = get(handles.extractParticleInCellIcyRadio,'Value');
radioValue2 = get(handles.extractParticleInCellCustomRadio,'Value');
% radioValue3 = get(handles.loadParticleInCellRadio,'Value');
if radioValue1==1 || radioValue2==1
     
    if radioValue1 == 1
        
        isParticleDetectionInIcy = 1;
        isParticleDetectionInCustom = 0;
        
    elseif radioValue2 == 1
        
        isParticleDetectionInIcy = 0;    
        isParticleDetectionInCustom = 1;
    end
            
    handles.isParticleDetectionInIcy = isParticleDetectionInIcy;
    handles.isParticleDetectionInCustom= isParticleDetectionInCustom;
    particlePositions = extractParticle(handles);
    handles.particlePositionInCells = particlePositions(:,1);
    handles.particlePositionInNucleus = particlePositions(:,2);
    handles.particlePositionNotInNucleus = particlePositions(:,3);
    
    
end

allPtLoc = handles.particlePositionInCells;
cellPtLoc = handles.particlePositionNotInNucleus;
nucPtLoc = handles.particlePositionInNucleus;
posCell = handles.cellBoundary;
posNuc = handles.nucleusBoundary;
particleInCellFileName = fullfile(handles.newProjectDirectory,'particleInCell',...
    [handles.cellNaming '_CellPtLoc.mat']);
save(particleInCellFileName,'allPtLoc','cellPtLoc','nucPtLoc','posCell','posNuc');
disp('Particle extraction all done!')

% Get frame numbers when all the frames are selected for analysis.
if handles.frameSelection == 1 % All frames.
    handles.frameIndices = 1:size(particlePositions,1);
end
     
guidata(hObject,handles);

% --- Executes on button press in radiobutton17.
function radiobutton17_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton17


% --- Executes on button press in extractParticleInCellIcyRadio.
function extractParticleInCellIcyRadio_Callback(hObject, eventdata, handles)
% hObject    handle to extractParticleInCellIcyRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.loadParticleInCellRadio,'Value',0);
set(handles.extractParticleInCellCustomRadio,'Value',0);
% guidata(hObject, handles)


% Hint: get(hObject,'Value') returns toggle state of extractParticleInCellIcyRadio
% --- Executes on button press in startClustering.
function startClustering_Callback(hObject, eventdata, handles)
% hObject    handle to startClustering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Image parameters.
imageParameters = detemineImageParameters(handles);
handles.imageParameters = imageParameters;

% Clustering parameters.
clusterParameters = determineClusteringParameters(handles);
eps = clusterParameters.eps;
minPts = clusterParameters.minPts;

% Clustering.
particlePositionInCells = handles.particlePositionInCells;
clusters = struct;
frames = handles.frameIndices;
for iFrame = 1:length(frames)
    clusters(iFrame,1).whichCluster = ...
        DBSCAN( particlePositionInCells(iFrame).xy,eps,minPts );
end

handles.clusters = clusters;

% Save clusters.
clusterFileName = fullfile(handles.newProjectDirectory,'cluster','clusters.mat');
save(clusterFileName,'clusters','eps','minPts');

guidata(hObject, handles);


% --- Executes on button press in plotClusters.
function plotClusters_Callback(hObject, eventdata, handles)
% hObject    handle to plotClusters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clusters = handles.clusters;
particles = handles.particlePositionInCells;
cellxy = handles.cellBoundary;
for iframe = 1:length(particles)
    figure,
    PlotClusterInResult(particles(iframe).xy, clusters(iframe).whichCluster)
    hold on
    plot(cellxy(:,1),cellxy(:,2),'k')
end

% --- Executes on button press in nearestNeighborDistDistributton.
function nearestNeighborDistDistributton_Callback(hObject, eventdata, handles)
% hObject    handle to nearestNeighborDistDistributton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
particles =  handles.particlePositionNotInNucleus;
pixelSize = str2num(get(handles.pixelSizeEdit,'String'));
nnDistance = nnDistDistributionSelectFrame(particles,particles,handles.frameIndices,pixelSize);

% Save nn Distance.
NNDistanceFileName = fullfile(...
    handles.newProjectDirectory,'distanceDistributions',[handles.cellNaming '_NNDistance.mat']);
save(NNDistanceFileName,'nnDistance');
guidata(hObject, handles);

% --- Executes on button press in normalizedToNucleusDistDistributton.
function normalizedToNucleusDistDistributton_Callback(hObject, eventdata, handles)
% hObject    handle to normalizedToNucleusDistDistributton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
particles = handles.particlePositionNotInNucleus;
% pixelSize = str2num(get(handles.pixelSizeEdit,'String'));

nucleusBoundary = handles.nucleusBoundary;
frames = handles.frameIndices;
toNucleusDistance = orgNucNormToMaxSelectFrame(...
    particles, nucleusBoundary, frames);
display(frames)
% Save Distance.
normalizedToNucleusDistanceFileName = fullfile(...
    handles.newProjectDirectory,'distanceDistributions',[handles.cellNaming '_TNDistance.mat']);
save(normalizedToNucleusDistanceFileName,'toNucleusDistance');
guidata(hObject, handles);



% --- Executes on button press in normalizedInterOrganelleDistDistributton.
function normalizedInterOrganelleDistDistributton_Callback(hObject, eventdata, handles)
% hObject    handle to normalizedInterOrganelleDistDistributton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
particles = handles.particlePositionNotInNucleus;
frames = handles.frameIndices;
interOrganelleDistance = normIOSelectFrame(particles, frames);
% Save Distance.
normalizedInterOrganelleDistanceFileName = fullfile(...
    handles.newProjectDirectory,'distanceDistributions',[handles.cellNaming '_IODistance.mat']);
save(normalizedInterOrganelleDistanceFileName,'interOrganelleDistance');
guidata(hObject, handles);




function cellNamingEdit_Callback(hObject, eventdata, handles)
% hObject    handle to cellNamingEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cellNamingEdit as text
%        str2double(get(hObject,'String')) returns contents of cellNamingEdit as a double
cellName = get(hObject,'String');

isCellNameSpecified = ~strcmp(cellName,'Cell naming'); % same as spot detection file name if not specified
if isCellNameSpecified == 0
   particleFile = strsplit(handles.particleFile,'.xls');
   cellName = particleFile{1};
end
handles.cellNaming = cellName;

% set(hObject,'String',cellName)
% display(['Cell naming: ' get(hObject,'String')])

guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function cellNamingEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cellNamingEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function cellNameText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cellNameText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function toolMenu_Callback(hObject, eventdata, handles)
% hObject    handle to toolMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function closeFigureMenu_Callback(hObject, eventdata, handles)
% hObject    handle to closeFigureMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(dataPreparationGUI, 'HandleVisibility', 'off');
close all;
set(dataPreparationGUI, 'HandleVisibility', 'on');


close all


% --- Executes during object creation, after setting all properties.
function particleExtractStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to particleExtractStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in extractTrackFromTrakeMateButton.
function extractTrackFromTrakeMateButton_Callback(hObject, eventdata, handles)
% hObject    handle to extractTrackFromTrakeMateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in trackPathBrowse.
function trackPathBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to trackPathBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guiPath = pwd;
projectPath = handles.newProjectDirectory; % Get project path.
defaultTrackFilePath = fullfile(projectPath, 'trackingResults');
handles.defaultTrackFilePath = defaultTrackFilePath;

[trackFile,newTrackFilePath,~]= uigetfile(...
    {'*.csv'; '*.txt'; '*.mat'},'Select tracking file', handles.defaultTrackFilePath, 'MultiSelect', 'on'); % can select multiple files
%%%
cd(guiPath) 

if isequal(newTrackFilePath,0) == 1 % if user clicked "cancel"
    disp('Please select a file')
elseif iscell(trackFile)==0 % one file
    
    isDefaultTrackFilePath = strcmp(newTrackFilePath,[defaultTrackFilePath filesep]);
    if isDefaultTrackFilePath == 0 %if user clicked a file not in the default path
        disp('Please select a file in the subfolder "trackingResults" of the project folder.')
    else % if user clicked a file in the default path
        handles.trackFileName = fullfile(defaultTrackFilePath, trackFile);
        handles.trackFile = trackFile;
        set(handles.trackPathEdit,'String', handles.trackFileName);
    end
    
end

guidata(hObject,handles);


function trackPathEdit_Callback(hObject, eventdata, handles)
% hObject    handle to trackPathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trackPathEdit as text
%        str2double(get(hObject,'String')) returns contents of trackPathEdit as a double
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function trackPathEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trackPathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton34.
function radiobutton34_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton34


% --- Executes on button press in radiobutton35.
function radiobutton35_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton35


% --- Executes on button press in radiobutton36.
function radiobutton36_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton36


% --- Executes on button press in extractTrackFromIcyButton.
function extractTrackFromIcyButton_Callback(hObject, eventdata, handles)
% hObject    handle to extractTrackFromIcyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in extractTracksFromCustomFileButton.
function extractTracksFromCustomFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to extractTracksFromCustomFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton49.
function pushbutton49_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in extractTracksInCellButton.
function extractTracksInCellButton_Callback(hObject, eventdata, handles)
% hObject    handle to extractTracksInCellButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cellName = handles.cellNaming;
cellBoundary = handles.cellBoundary;
pixelSize = 0.001*str2num(get(handles.pixelSizeEdit,'String'));
cellBoundaryInMicron = cellBoundary*pixelSize; 
tracks = handles.tracksInSample;
cellTracks = extractTracksInCell(tracks,cellBoundaryInMicron);
handles.cellTracks = cellTracks;
cellTrackFileName = fullfile(handles.newProjectDirectory,'trackAnalysis',[cellName '_CellTracks']);
save(cellTrackFileName,'cellTracks');
plotTracksInCell(cellTracks, cellBoundaryInMicron)

guidata(hObject,handles);


% --- Executes on button press in extractTracksInSampleButton.
function extractTracksInSampleButton_Callback(hObject, eventdata, handles)
% hObject    handle to extractTracksInSampleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if get(handles.TrackMateTracksRadio,'Value')==1
    whichTrackFile = 'TrackMate';
elseif get(handles.IcyTracksRadio,'Value')==1
    whichTrackFile = 'Icy';
else
    whichTrackFile = 'custom';
end

pixelSize = str2num(get(handles.pixelSizeEdit,'String'));

switch whichTrackFile
    case 'TrackMate'
        tracks = extractTracksFromTrackMate(handles.trackFileName); 
        trackFileStrings = strsplit(handles.trackFile,'.csv');
        trackFile = trackFileStrings{1};
    case 'Icy'
        
    case 'Custom'
        
end

tracksInSampleFileName = fullfile(...
    handles.newProjectDirectory,'trackAnalysis',[ trackFile '_tracksInSamples.mat']);
handles.tracksInSampleFileName = tracksInSampleFileName;
handles.tracksInSample = tracks;

save( tracksInSampleFileName,'tracks' );
disp('Track extraction al done!')
guidata(hObject,handles)



% --- Executes on button press in pushbutton50.
function pushbutton50_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton51.
function pushbutton51_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in IcyTracksRadio.
function IcyTracksRadio_Callback(hObject, eventdata, handles)
% hObject    handle to IcyTracksRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.TrackMateTracksRadio,'Value',0);
set(handles.customTrackFileRadio,'Value',0);
% Hint: get(hObject,'Value') returns toggle state of IcyTracksRadio


% --- Executes on button press in TrackMateTracksRadio.
function TrackMateTracksRadio_Callback(hObject, eventdata, handles)
% hObject    handle to TrackMateTracksRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.IcyTracksRadio,'Value',0);
set(handles.customTrackFileRadio,'Value',0);
% Hint: get(hObject,'Value') returns toggle state of TrackMateTracksRadio


% --- Executes on button press in customTrackFileRadio.
function customTrackFileRadio_Callback(hObject, eventdata, handles)
% hObject    handle to customTrackFileRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.IcyTracksRadio,'Value',0);
set(handles.TrackMateTracksRadio,'Value',0);
% Hint: get(hObject,'Value') returns toggle state of customTrackFileRadio


% --- Executes on button press in displacementButton.
function displacementButton_Callback(hObject, eventdata, handles)
% hObject    handle to displacementButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function displacementButton_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to displacementButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in MSDAnalysisButton.
function MSDAnalysisButton_Callback(hObject, eventdata, handles)
% hObject    handle to MSDAnalysisButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in motilityModeButton.
function motilityModeButton_Callback(hObject, eventdata, handles)
% hObject    handle to motilityModeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
radioValue1 = get(handles.allFramesForTracksRadio,'Value');
radioValue2 = get(handles.selectedFramesForTracksRadio,'Value');

if radioValue1 == 1 % all frames
    cellTracks = handles.cellTracks;
    disp('Motility mode fitting starts...')
    fitResult = motilityModeFitting(cellTracks);
    cellName = handles.cellNaming;
    save(fullfile(handles.newProjectDirectory,'trackAnalysis',[cellName '_motilityMode.mat']),'fitResult') 
    %%%
    cellBoundary = handles.cellBoundary;
    pixelSize = 0.001*str2num(get(handles.pixelSizeEdit,'String'));
    cellBoundaryInMicron = cellBoundary*pixelSize;  
    hold on
    plot(cellBoundaryInMicron(:,1),cellBoundaryInMicron(:,2),'k')
    axis ij; axis equal
    %%%
end
    
display('Motili all done!')




% --- Executes on button press in selectedFramesForTracksRadio.
function selectedFramesForTracksRadio_Callback(hObject, eventdata, handles)
% hObject    handle to selectedFramesForTracksRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selectedFramesForTracksRadio


% --- Executes on button press in allFramesForTracksRadio.
function allFramesForTracksRadio_Callback(hObject, eventdata, handles)
% hObject    handle to allFramesForTracksRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of allFramesForTracksRadio



function frameIndicesForTracksEdit_Callback(hObject, eventdata, handles)
% hObject    handle to frameIndicesForTracksEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frameIndicesForTracksEdit as text
%        str2double(get(hObject,'String')) returns contents of frameIndicesForTracksEdit as a double


% --- Executes during object creation, after setting all properties.
function frameIndicesForTracksEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frameIndicesForTracksEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MSDPlotButton.
function MSDPlotButton_Callback(hObject, eventdata, handles)
% hObject    handle to MSDPlotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in loadCellTracks.
function loadCellTracks_Callback(hObject, eventdata, handles)
% hObject    handle to loadCellTracks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function quantileLevelEdit_Callback(hObject, eventdata, handles)
% hObject    handle to quantileLevelEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of quantileLevelEdit as text
%        str2double(get(hObject,'String')) returns contents of quantileLevelEdit as a double
handles.quantile = str2num(get(hObject,'String'));

guidata(hObject,handles)



% --- Executes during object creation, after setting all properties.
function quantileLevelEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to quantileLevelEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in particleDetectionStartButton.
function particleDetectionStartButton_Callback(hObject, eventdata, handles)
% hObject    handle to particleDetectionStartButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

maskSize = handles.maskSize;
quantile = handles.quantile;
wavelength = handles.wavelength;
NA = handles.NA;
isExistPixelSizeInput = exist('handles.pixelSize','var');
if isExistPixelSizeInput == 1
   pixelSize = handles.pixelSize;
else
   pixelSize = 64.8; % nm
end

imageFileName = handles.imageFileName;

image = imread(imageFileName);
display('Image is imported for particle deteciton!')
[particleXY, ~] = particleDetectionCustom(image, maskSize, quantile, wavelength, pixelSize, NA);

particlePositions.xy = particleXY;

handles.particlePositions = particlePositions;

particleDetectionFileName = fullfile(...
                handles.newProjectDirectory,'particleDetectionResults',[ handles.imageName '_particlXYInImageCustom.mat']);
save(particleDetectionFileName,'particlePositions','maskSize', 'quantile', 'wavelength', 'pixelSize', 'NA');

guidata(hObject,handles);





function maskSizeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to maskSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maskSizeEdit as text
%        str2double(get(hObject,'String')) returns contents of maskSizeEdit as a double
% store the state 
handles.maskSize = str2num(get(hObject,'String')); 

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function maskSizeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maskSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in imagePathBrowse.
function imagePathBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to imagePathBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guiPath = pwd;
projectPath = handles.newProjectDirectory; % Get project path.
defaultImagePath = fullfile(projectPath, 'images');
handles.defaultImagePath = defaultImagePath;

cd(defaultImagePath) % Switch to "images" folder.
[ImageFile,newImagePath,~]= uigetfile(...
    {'*.tif'},'Select image file');

cd(guiPath) % Switch back to gui path.

if isequal(newImagePath,0) == 1 % if user clicked "cancel"
    disp('Please select an image file')
else
    isdefaultImagePath = strcmp(newImagePath,[defaultImagePath filesep]);
    if isdefaultImagePath == 0 %if user clicked a file not in the default path
        disp('Please select a file in the subfolder "images" of the project folder.')
    else % if user clicked a file in the default path
        handles.imageFileName = fullfile(defaultImagePath, ImageFile);
        imageNameSplit = strsplit(ImageFile,'.tif');
        handles.imageName = imageNameSplit{1};
        set(handles.imagePathEdit,'String', handles.imageFileName)
    end 
end

guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function imagePathEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imagePathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in imageCropButton.
function imageCropButton_Callback(hObject, eventdata, handles)
% hObject    handle to imageCropButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in calibrationButton.
function calibrationButton_Callback(hObject, eventdata, handles)
% hObject    handle to calibrationButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% display image



function wavelengthEdit_Callback(hObject, eventdata, handles)
% hObject    handle to wavelengthEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wavelengthEdit as text
%        str2double(get(hObject,'String')) returns contents of wavelengthEdit as a double
handles.wavelength = str2num(get(hObject,'String'));
guidata(hObject, handles)


% --- Executes during object creation, after setting all properties.
function wavelengthEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wavelengthEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NAEdit_Callback(hObject, eventdata, handles)
% hObject    handle to NAEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NAEdit as text
%        str2double(get(hObject,'String')) returns contents of NAEdit as a double

handles.NA = str2num(get(hObject,'String'));
guidata(hObject, handles)

% --- Executes during object creation, after setting all properties.
function NAEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NAEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cellNameEdit_Callback(hObject, eventdata, handles)
% hObject    handle to cellNameEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cellNameEdit as text
%        str2double(get(hObject,'String')) returns contents of cellNameEdit as a double

cellNaming = get(hObject,'String');
handles.cellNaming = cellNaming;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function cellNameEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cellNameEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function customParticleDetectionPanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to customParticleDetectionPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function imagePathEdit_Callback(hObject, eventdata, handles)
% hObject    handle to imagePathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imagePathEdit as text
%        str2double(get(hObject,'String')) returns contents of imagePathEdit as a double

handles.imagePathEdit = get(hObject,'String');
guidata(hObject,handles)
