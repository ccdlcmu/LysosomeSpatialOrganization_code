
%Select the organelle-specific, DAPI channel and point-detected text file

g1 = msgbox('Select channel with organelles');
[fileCell, pathCell] = uigetfile('*.tif');
imgCell = importdata(strcat(pathCell,fileCell));

g2 = msgbox('Select DIC channel');
[fileNuc, pathNuc] = uigetfile(strcat(pathCell,'/*.tif'));
imgNuc = importdata(strcat(pathNuc,fileNuc));

g3 = msgbox('Select point-detected text file');
[filename, path] = uigetfile(strcat(pathCell,'/*.txt'));
coordsOrg2 = csvread(strcat(path,filename));


pixelSize = 6.5*1e-6/60;

D = imfuse(imgCell, imgNuc);
imshow(D,[])

%Trace the cell boundary

g4 = msgbox('Trace cell boundary');
hCell = imfreehand;
poscellBdry = hCell.getPosition();

g5 = msgbox('Trace cell nucleus');
hNuc = imfreehand;
posNuc = hNuc.getPosition();

BW_cellBdry = poly2mask(poscellBdry(:,1),poscellBdry(:,2),size(imgCell,1),size(imgCell,2));
BW_Nuc = poly2mask(posNuc(:,1),posNuc(:,2),size(imgCell,1),size(imgCell,2));


%polygonal boundary of nucleus
k = boundary(posNuc(:,1), posNuc(:,2));
convNuc = [posNuc(k,1), posNuc(k,2)];

%Polygonal boundary of Cell
%g = convhull(poscellBdry(:,1),poscellBdry(:,2));
g = boundary(poscellBdry(:,1),poscellBdry(:,2));
convCell = [poscellBdry(g,1),poscellBdry(g,2)];

%Output boundary of cell and nucleus to text file
csvwrite('ConvCell.txt',convCell);
csvwrite('ConvNuc.txt',convNuc);


% Select all organelle-coordinates within the cell-mask

[in] = inpolygon(coordsOrg2(:,1),coordsOrg2(:,2),poscellBdry(:,1),poscellBdry(:,2));
coordsOrg = coordsOrg2(find(in==1),1:2);

%Output all organelle-coordinates within the cell to a text file
csvwrite('OrgCoordsInCell.txt', coordsOrg)
dir = pwd;

%Run an R script to simulate monte-carlo poisson within arbitrary shape
command = sprintf('Rscript CSRTest_cellShape.R %s', dir);
system(command)

