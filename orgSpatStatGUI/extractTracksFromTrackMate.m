function tracks = extractTracksFromTrackMate( filePathName )
% extractTracksFromTrackMate is a function that arrange TrackMate tracking results into a 
% strcuture 

% input:
% (1) trackfile: a csv file with tracks where the columns are tracking id,t,x,y,type, from column 1 to 5.
% trackID: 2nd column; XY: 4th, 5th columns, respectively; frameNo: 8th
% column.
% (2) filename: save "trackrecord" if a filename is specified



%%%
% rejectThresh = 14;% Duration of tracks below which the tracks are rejected.
rejectThresh = 14;
%%%
trackFile = importdata(filePathName);
trackData = trackFile.data;
% clear trackfile
trackData(:,8) = trackData(:,8)+1; % adjust time point starting from 1 instead of 0
trackData(:,4:5)=trackData(:,4:5); % x,y
% find tracks and store in a structure
differenceInID = trackData(:,2) - [trackData(2:end,2); 0];
findTrack = [0; find(differenceInID | 0)];
j = 0;
nTrack = 1+ max(trackData(:,2));
% save('testtrack.mat','findTrack')
for i = 2:length(findTrack)
    
    if findTrack(i)-findTrack(i-1)> rejectThresh
        j = j + 1;
        trackTXY{j,1} = trackData( findTrack(i-1)+1:findTrack(i),[8,4,5] ); 
    end
    
end

trackData = trackData(:,[2,8,4,5]);

tracks.trackData = trackData;
tracks.trackTXY = trackTXY;