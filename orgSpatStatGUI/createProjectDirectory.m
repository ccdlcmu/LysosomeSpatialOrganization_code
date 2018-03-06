function createProjectDirectory(projectDirectory)
% This function creates subdirectories under the project directory.

mkdir(projectDirectory,'particleDetectionResults')
mkdir(projectDirectory,'particleInCell')
mkdir(projectDirectory,'csvFiles')
mkdir(projectDirectory,'cluster')
mkdir(projectDirectory,'imagesCellNucBoundary')
mkdir(projectDirectory,'images')
mkdir(projectDirectory,'distanceDistributions')
mkdir(projectDirectory,'trackingResults')
mkdir(projectDirectory,'trackAnalysis')
mkdir(projectDirectory,'cellNucleusBoundaries')
mkdir(projectDirectory,'drawnCellBoundary')
mkdir(projectDirectory,'particleImageOverlay')
% mkdir(prjectDirectory,'RipleyK')

tempPath = fullfile(projectDirectory,'csvFiles');
mkdir(tempPath, 'cellNucleusBoudary')
mkdir(tempPath, 'particleFiles')

tempPath = fullfile(projectDirectory,'cluster');
mkdir(tempPath, 'simulation')
mkdir(tempPath,'clusterPlot')

