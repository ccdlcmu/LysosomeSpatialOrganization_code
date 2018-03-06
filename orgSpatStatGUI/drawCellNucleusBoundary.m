function boundaryPositions = drawCellNucleusBoundary(handles, nImage,whichBoundary)

% This function creates cell and nucleus boundaries interactively.

switch nImage
    case 1% Draw boundary using a single image
        %         imageDraw = imadjust(imread(handles.cellImageFileName));
        imageDraw = imread(handles.cellImageFileName);
    case 2 % Draw boundary using two images
        cellImage = imread(handles.cellImageFileName);
        nucleusImage = imread(handles.nucleusImageFileName);
        imageDraw = imfuse(imadjust(cellImage),imadjust(nucleusImage));
end % nImage

figure, imshow(imageDraw,[]);
%figure, imshow(imageDraw,[min(min(imageDraw)), max(max(imageDraw))]);
boundaryHandle = imfreehand;
boundaryPositions = boundaryHandle.getPosition();
% drawnBoundaryImageName = fullfile(handles.newProjectDirectory,'drawnCellBoundary',[handles.cellNaming '_' whichBoundary 'Boundary.fig']);
% saveas(gcf,drawnBoundaryImageName)

