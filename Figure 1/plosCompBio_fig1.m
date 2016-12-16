function varargout = plosCompBio_fig1(varargin)
% PLOSCOMPBIO_FIG1 MATLAB code for plosCompBio_fig1.fig
%      PLOSCOMPBIO_FIG1, by itself, creates a new PLOSCOMPBIO_FIG1 or raises the existing
%      singleton*.
%
%      H = PLOSCOMPBIO_FIG1 returns the handle to a new PLOSCOMPBIO_FIG1 or the handle to
%      the existing singleton*.
%
%      PLOSCOMPBIO_FIG1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOSCOMPBIO_FIG1.M with the given input arguments.
%
%      PLOSCOMPBIO_FIG1('Property','Value',...) creates a new PLOSCOMPBIO_FIG1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plosCompBio_fig1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plosCompBio_fig1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plosCompBio_fig1

% Last Modified by GUIDE v2.5 08-Oct-2016 18:48:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plosCompBio_fig1_OpeningFcn, ...
                   'gui_OutputFcn',  @plosCompBio_fig1_OutputFcn, ...
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


% --- Executes just before plosCompBio_fig1 is made visible.
function plosCompBio_fig1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plosCompBio_fig1 (see VARARGIN)

% Choose default command line output for plosCompBio_fig1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plosCompBio_fig1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plosCompBio_fig1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in pushButtonloadTifs.
function pushButtonloadTifs_Callback(hObject, eventdata, handles)
% hObject    handle to pushButtonloadTifs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fileCell, pathCell] = uigetfile('*.tif');
imgCell = importdata(strcat(pathCell,fileCell));


[fileNuc, pathNuc] = uigetfile(strcat(pathCell,'/*.tif'));
imgNuc = importdata(strcat(pathNuc,fileNuc));

[fileDIC, pathDIC] = uigetfile(strcat(pathCell,'/*.tif'));
imgDIC = importdata(strcat(pathDIC,fileDIC));


handles.fileCell = strcat(pathCell,fileCell);
handles.imgCell = imgCell;

handles.fileNuc = strcat(pathNuc,fileNuc);
handles.imgNuc = imgNuc;

[filename, path] = uigetfile(strcat(pathCell,'/*.txt'));
%[filename, path] = uigetfile('*.txt');
coordsOrg = csvread(strcat(path,filename));
handles.orgCoords = coordsOrg;


guidata(hObject, handles)
axes(handles.axes1)

img = imfuse(imgCell, imgNuc);
img = imfuse(imgDIC, img);

imshow(img,[])
%imshow(imgCell,[])


% --- Executes on button press in pushButton_traceCell.
function pushButton_traceCell_Callback(hObject, eventdata, handles)
% hObject    handle to pushButton_traceCell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1)

hCell = imfreehand;
posCell = hCell.getPosition();
handles.posCell = posCell;

BW_cellBdry = poly2mask(posCell(:,1),posCell(:,2), size(handles.imgCell,1), size(handles.imgCell,2));
coordsOrg2 = handles.orgCoords;

% Select all coordinates within the cell-mask
%LysoIndices = int64(sub2ind(size(BW_cellBdry),coordsOrg2(:,2),coordsOrg2(:,1)));

[in] = inpolygon(coordsOrg2(:,1),coordsOrg2(:,2),posCell(:,1),posCell(:,2));

coordsOrg = coordsOrg2(find(in==1),1:2);
% LysoIndices = int64(sub2ind(size(BW_cellBdry),round(coordsOrg2(:,2)),round(coordsOrg2(:,1))));
% val = find(BW_cellBdry(LysoIndices)==1);
% coordsOrg = [coordsOrg2(val,1), coordsOrg2(val,2)];

% axes(handles.axes1)
% hold on
% scatter(coordsOrg(:,1),coordsOrg(:,2),'b.')


%Inside the cell mask
handles.orgCoordsIn = coordsOrg;
guidata(hObject,handles)


% --- Executes on button press in pushbutton_TraceNucleus.
function pushbutton_TraceNucleus_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_TraceNucleus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1)
hNuc = imfreehand;
posNuc = hNuc.getPosition();
handles.posNuc = posNuc;

guidata(hObject, handles)

% --- Executes on button press in pushbuttonLoadCoordstxt.
function pushbuttonLoadCoordstxt_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonLoadCoordstxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



[filename, path] = uigetfile('*.txt');
coordsOrg = csvread(strcat(path,filename));
handles.orgCoords = coordsOrg;

% axes(handles.axes1)
% hold on
% scatter(coordsOrg(:,1),coordsOrg(:,2),'b.')

guidata(hObject,handles)

% --- Executes on button press in pushbuttonLoadCoordsxls.
function pushbuttonLoadCoordsxls_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonLoadCoordsxls (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonInterEvent.
function pushbuttonInterEvent_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonInterEvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% %Setting all other calls to empty status
% set(handles.pushbuttonNearestNeighbor, 'userdata', [])
% set(handles.pushbuttonOrgNuc, 'userdata', [])
% set(handles.pushbuttonOrgNucPeriphery, 'userdata',[])

axes(handles.axes2)
hold on

pixelSize = 6.5*1e-6/100;

OrgCoordsIn = handles.orgCoordsIn;
posNuc = handles.posNuc;
poscellBdry = handles.posCell;
imgCell = handles.imgCell;

BW_cellBdry = poly2mask(poscellBdry(:,1),poscellBdry(:,2),size(imgCell,1),size(imgCell,2));
BW_Nuc = poly2mask(posNuc(:,1),posNuc(:,2),size(imgCell,1),size(imgCell,2));

num_Lyso = size(OrgCoordsIn,1);

%Find all coordinates within cell mask and outside nucleus
pixelsInCell = intersect(find(BW_cellBdry==1),find(BW_Nuc==0));
[pixelsInCell_y, pixelsInCell_x] = ind2sub(size(imgCell),pixelsInCell);
pixelsInCell = [pixelsInCell_x, pixelsInCell_y];


IEDist = pdist(OrgCoordsIn, 'euclidean'); % Inter event distance 
%[f,xi] = ksdensity(IEDist*pixelSize);
[f,xi] = ksdensity(IEDist/max(IEDist));
plot(xi,f)
hold on

%Randomize - pick 'n' pixels for placing Lysosomes - Perform it 100 times
% for iter = 1:10
% 
%     [y] = datasample(pixelsInCell,num_Lyso,'Replace',false);
%     %csvwrite(sprintf('randomOrgCoords%0.1d.txt',iter),y);
%     csvwrite('randomOrgCoords.txt',y);
%     
%     %Call the graded perinuclear function
%     IEDist = pdist(y, 'euclidean'); % Inter event distance 
%     [f,xi] = ksdensity(IEDist*pixelSize/max(IEDist));
%     plot(xi,f,'r')
%     hold on    
%     
% end 

% legend('Sample','Randomized')


calls = get(handles.pushbuttonInterEvent, 'userdata');
if isempty(calls)
    calls = 1;
else
    calls = calls + 1;
end

handles.LysoIEDist{calls} = IEDist*pixelSize;
set(handles.pushbuttonInterEvent, 'userdata',calls);

guidata(hObject, handles)

xlabel('Inter Event Distance (um)')
ylabel('Probability')

LysoIEDist = handles.LysoIEDist;

save('LysoIEDist_Control.mat','LysoIEDist');

% --- Executes on button press in pushbuttonNearestNeighbor.
function pushbuttonNearestNeighbor_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonNearestNeighbor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Setting all other calls to empty status
pixelSize = 6.5*1e-6/100;
axes(handles.axes3)
hold on

OrgCoordsIn = handles.orgCoordsIn;

[NNDist,idx] = knnsearch(OrgCoordsIn, OrgCoordsIn, 'K',2);
[f,xi] = ksdensity(NNDist(:,2)*pixelSize);
plot(xi,f)
hold on


calls = get(handles.pushbuttonNearestNeighbor, 'userdata');
if isempty(calls)
    calls = 1;
else
    calls = calls + 1;
end

handles.LysoNNDist{calls} = NNDist(:,2);
set(handles.pushbuttonNearestNeighbor, 'userdata',calls);

guidata(hObject, handles)

xlabel('Nearest Neighbor Distance (um)')
ylabel('Probability')

LysoNNDist = handles.LysoNNDist;

save('LysoNNDist_Control.mat','LysoNNDist');




% --- Executes on button press in pushbuttonOrgNuc.
function pushbuttonOrgNuc_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonOrgNuc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pixelSize = 6.5*1e-6/100;

% cd Scripts_metrics\
posCell = handles.posCell;
posNuc = handles.posNuc;
OrgCoordsIn = handles.orgCoordsIn;
imgCell = handles.imgCell;

BW_cellBdry = poly2mask(posCell(:,1),posCell(:,2),size(imgCell,1),size(imgCell,2));
BW_Nuc = poly2mask(posNuc(:,1),posNuc(:,2),size(imgCell,1),size(imgCell,2));

num_Lyso = size(OrgCoordsIn,1);

%Find all coordinates within cell mask and outside nucleus
pixelsInCell = intersect(find(BW_cellBdry==1),find(BW_Nuc==0));
[pixelsInCell_y, pixelsInCell_x] = ind2sub(size(imgCell),pixelsInCell);
pixelsInCell = [pixelsInCell_x, pixelsInCell_y];


[minDistLysoNuc, minDistLysoCell, ArCell] = OrgNuc(posCell, posNuc, OrgCoordsIn);

[f,xi] = ksdensity((minDistLysoNuc*pixelSize)/(ArCell*pixelSize^2));
axes(handles.axes5)
hold on
plot(xi,f)
xlabel('Normalized Lyso-Nuc Distance Distribution (in um^{-1})')
ylabel('Probability')

[f,xi] = ksdensity((minDistLysoNuc./(minDistLysoNuc+minDistLysoCell))*100);
axes(handles.axes4)
hold on
plot(xi,f)
xlabel('Lyso-Nuc-Cell distance distribution (in %)')
ylabel('Probability')



% %Randomize - pick 'n' pixels for placing Lysosomes - Perform it 100 times
% for iter = 1:10
%     
%     cd 7_Oct_16' (GUIDE)'\
% 
%     [y] = datasample(pixelsInCell,num_Lyso,'Replace',false);
%     %csvwrite(sprintf('randomOrgCoords%0.1d.txt',iter),y);
%     csvwrite('randomOrgCoords.txt',y);
% 
% 
%     %Call the graded perinuclear function
%     [minDistLysoNuc, minDistLysoCell, ArCell] = OrgNuc(posCell, posNuc, y);
%     [f,xi] = ksdensity((minDistLysoNuc*pixelSize)/(ArCell*pixelSize^2));
%     axes(handles.axes5)
%     hold on
%     plot(xi,f,'r')
%     xlabel('Normalized Lyso-Nuc Distance Distribution (in um^{-1})')
%     ylabel('Probability')
% 
%     [f,xi] = ksdensity((minDistLysoNuc./(minDistLysoNuc+minDistLysoCell))*100);
%     axes(handles.axes4)
%     hold on
%     plot(xi,f,'r')
%     xlabel('Lyso-Nuc-Cell distance distribution (in %)')
%     ylabel('Probability')
% 
% end

calls = get(handles.pushbuttonOrgNuc, 'userdata');
if isempty(calls)
    calls = 1;
else
    calls = calls + 1;
end

% handles.minDistLysoNuc{calls} = minDistLysoNuc;
% handles.minDistLysoCell{calls} = minDistLysoCell;
% handles.ArCell{calls} = ArCell;

% LysoNucMD{calls} = handles.minDistLysoNuc
% LysoCellMD{calls} = handles.minDistLysoCell
% ArCell_final{calls} = handles.ArCell

LysoNucMD{calls} = minDistLysoNuc;
LysoCellMD{calls} = minDistLysoCell;
ArCell_final{calls} = ArCell;


save('LysoOrgNuc_tbhp.mat','LysoNucMD', 'LysoCellMD', 'ArCell_final');

guidata(hObject, handles)
