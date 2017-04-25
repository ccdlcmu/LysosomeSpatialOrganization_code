
[fileCell, pathCell] = uigetfile('*.tif');
imgCell = importdata(strcat(pathCell,fileCell));

[fileNuc, pathNuc] = uigetfile(strcat(pathCell,'/*.tif'));
imgNuc = importdata(strcat(pathNuc,fileNuc));

[fileDIC, pathDIC] = uigetfile(strcat(pathCell,'/*.tif'));
imgDIC = importdata(strcat(pathDIC,fileDIC));

[filename, path] = uigetfile(strcat(pathCell,'/*.txt'));
%[filename, path] = uigetfile('*.txt');
coordsOrg2 = csvread(strcat(path,filename));


pixelSize = 6.5*1e-6/60;
%imgCell = imread(imCell);
%imgNuc = imread(imNuc);
%coordsOrg2 = csvread(coordsFile);

D = imfuse(imgCell, imgNuc);
D = imfuse(D, imgDIC);
imshow(D,[])

hCell = imfreehand;
poscellBdry = hCell.getPosition();
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

csvwrite('ConvCell.txt',convCell);
csvwrite('ConvNuc.txt',convNuc);


% Select all coordinates within the cell-mask
% LysoIndices = sub2ind(size(BW_cellBdry),coordsOrg2(:,2),coordsOrg2(:,1));
% val = find(BW_cellBdry(LysoIndices)==1);
% coordsOrg = [coordsOrg2(val,1), coordsOrg2(val,2)];

[in] = inpolygon(coordsOrg2(:,1),coordsOrg2(:,2),poscellBdry(:,1),poscellBdry(:,2));
coordsOrg = coordsOrg2(find(in==1),1:2);

csvwrite('OrgCoordsInCell.txt', coordsOrg)
dir = pwd;

command = sprintf('Rscript CSRTest_cellShape.R %d', size(D,1));
system(command)