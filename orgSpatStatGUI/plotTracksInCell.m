function plotTracksInCell(cellTracks, cellBoundaryInMicron)
 figure,
 for iTrack = 1:length(cellTracks)
 plot(cellTracks{iTrack}(:,2),cellTracks{iTrack}(:,3))
 hold on
 end
 hold on
 plot(cellBoundaryInMicron(:,1),cellBoundaryInMicron(:,2),'b')
 axis ij
 axis equal