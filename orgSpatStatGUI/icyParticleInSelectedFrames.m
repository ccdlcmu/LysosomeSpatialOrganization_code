function particlePositions = icyParticleInSelectedFrames( xlsFileName, frames )
% icyParticleInSelectedFrames is a function that extract icy spot detection results into a
% strcuture array 

% Input:
% (1) Xlsfilename: file path with file name.
% (2) Frames: frames for extracting particle locations. input [] if applying 
% to all frames.

% Output:
% A n x 1 structure with a field xy containing particle positions and n =
% frame numbers.

xlsfile = importdata( fullfile(xlsFileName) );
columnX = 3; columnY = 4; columnT = 6;% x, y are in the 3rd and 4th columns in xls files, respectivly.

xlsText = xlsfile.textdata; % Pull out text in 1st xls file
rlog= strfind({xlsText{:,1}}, 'Detection #'); % logical: contain/not
row = 1 + find(~cellfun('isempty',rlog));
nParticle = (size(xlsText,1)-1) -row+1;

xlsData = xlsfile.data;
allParticlePositins = xlsData(size(xlsData,1)- nParticle+1: end, [columnX columnY columnT]);

tMax = max(allParticlePositins(:,3)); % time point from 0 to tmax ( i.e.total number of frames -1 )

j = 1;
if isempty(frames) == 0 % Selected frames.
    for i = frames
        isIdx = (allParticlePositins(:,3) == i-1);
        particlePositions(j,1).xy = allParticlePositins(isIdx,1:2);
        j = j+1; 
    end
    display(frames)
else % All frames.
    for i = 1:tMax+1
        isIdx = (allParticlePositins(:,3) == i-1);
        particlePositions(i,1).xy = allParticlePositins(isIdx,1:2);
    end
end

