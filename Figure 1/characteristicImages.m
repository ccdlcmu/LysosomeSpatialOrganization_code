%% Selecting Characteristic Images to highlight cell nucleus and cell membrane
    
%Import channel-specific images

g1 = msgbox('Select channel with lysosomes');
[fileCell, pathCell] = uigetfile('*.tif');
imgCell = importdata(strcat(pathCell,fileCell));

g2 = msgbox('Select DIC channel');
[fileDIC, pathDIC] = uigetfile(strcat(pathCell,'/*.tif'));
imgDIC = importdata(strcat(pathDIC,fileDIC));

g3 = msgbox('Select DAPI channel');
[fileNuc, pathNuc] = uigetfile(strcat(pathCell,'/*.tif'));
imgNuc = importdata(strcat(pathNuc,fileNuc));

%Fusing DIC and Nucleus channels
D = imfuse(imgDIC, imgNuc);

figure,
imshow(D,[])

%Freehand tracing of cell boundary and cell nucleus
h1 = msgbox('Trace the cell boundary');
hCell = imfreehand;

h2 = msgbox('Trace the cell nucleus');
hNuc = imfreehand;

posCell = hCell.getPosition();
posNuc = hNuc.getPosition();

%Display cell with boundary and nucleus (in red) 
%NOTE: Figure can be saved by user in any desirable format
figure,
imshow(imgCell,[])
hold on
plot(posCell(:,1),posCell(:,2),'r')
hold on
plot(posNuc(:,1),posNuc(:,2),'r')

