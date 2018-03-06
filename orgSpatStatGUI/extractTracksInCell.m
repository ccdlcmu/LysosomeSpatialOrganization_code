
function cellTracks = extractTracksInCell(tracks,posCell)

nCondition = length(tracks);

if nCondition == 1
    nTrack = length(tracks.trackTXY);
    for iTrack = 1:nTrack
        trackRecord = tracks.trackTXY{iTrack}; 
        xy(iTrack,1:4) = [trackRecord(1,2:3),trackRecord(end,2:3)];
    end
    InCellStart = inpolygon( xy(:,1), xy(:,2), posCell(:,1),...
        posCell(:,2) );
    InCellEnd = inpolygon( xy(:,3), xy(:,4), posCell(:,1),...
        posCell(:,2) );
    InCell = InCellStart+InCellEnd;
    cellTracks = tracks.trackTXY(InCell==2);
    clear xy
    
end
