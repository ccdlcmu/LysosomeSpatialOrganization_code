% Plot heatmap for the diffusion constants 

clear 
clc
close all

cd Demo_data

timePt = 3;
img_x = 1392;
img_y = 1040;


%for fileNum = 1:6
    
    fileNum = 2;
    
    fileMSD = sprintf('CellNo.%0.1d_MSDFit.mat',fileNum);
    fileTrack = sprintf('CellNo.%0.1d_track.mat',fileNum);
    fileCellNuc = sprintf('CellNo.%0.1d_PtLocCellNuc.mat',fileNum);

    % Loading diffusion constants and particle tracks (trajectories)
    load(fileMSD)
    load(fileTrack)
    load(fileCellNuc)

    lysoCoords = [];

    %get nucleus and cell membrane boundary
    posNuc = PosNuc(timePt).pos;
    posCell = PosCell(timePt).pos;    
    
    %Get diffusion constants for all tracks in image at a desired time point
    diffConstants = FitResult(timePt).bp(1,:);
    
    %Count number of trajectories 
    numTracks = length(CellTracks(timePt).tracks);
    
    %Get all organelle coordinates (x,y positions)
    
        %Loading initial positions for each of the tracks
        %x,y coordinate of first position of 1 track @ time before treatment
    
    for lysoTrack = 1:numTracks
        lysoCoords = [lysoCoords; CellTracks(timePt).tracks(lysoTrack).track(1,2:3)];
    end
            
    %Finding points within cell boundary
    [in] = inpolygon(lysoCoords(:,1),lysoCoords(:,2),posCell(:,1),posCell(:,2));
    lysoIn = [lysoCoords(in,1), lysoCoords(in, 2)];
    diffConstants = diffConstants(in);
    
    bubsizes = [min(diffConstants) quantile(diffConstants,[0.25, 0.5, 0.75]) max(diffConstants)];
    legentry=cell(size(bubsizes));
    figure,hold on
    for ind = 1:numel(bubsizes)
       bubleg(ind) = plot(0,0,'ro','markersize',sqrt(bubsizes(ind)),'MarkerFaceColor','red');
       set(bubleg(ind),'visible','off')
       legentry{ind} = num2str(bubsizes(ind));
    end
    
    h2 = scatter(lysoIn(:,1),lysoIn(:,2),diffConstants,'c','MarkerFaceColor','r')
    legend(legentry)
    hold on
    plot(posCell(:,1),posCell(:,2),'b')
    hold on
    plot(posNuc(:,1),posNuc(:,2),'b')
   
    xlim([0 1392])
    ylim([0 1040])
    set(gca,'YDir','reverse')
    
%end

cd ..
    