%Spatial gradient - using dilation techniques
%Spatial density gradient (Centered at the nucleus)

clear 
clc

cd track_MSD_PtLoc
timePt = 3;
img_x = 1392;
img_y = 1040;

for fileNum = 1:6

  
    fileMSD = sprintf('CellNo.%0.1d_MSDFit.mat',fileNum);
    fileTrack = sprintf('CellNo.%0.1d_track.mat',fileNum);
    fileCellNuc = sprintf('CellNo.%0.1d_PtLocCellNuc.mat',fileNum);

    % Loading diffusion constants and Tracks
    load(fileMSD)
    load(fileTrack)
    load(fileCellNuc)
    
    posNuc = PosNuc(timePt).pos;
    posCell = PosCell(timePt).pos;
    
    %Get all diffusion constants for all tracks in image
    diffConstants = FitResult(timePt).bp(1,:);

    
    figure(1);
    plot(posNuc(:,1),posNuc(:,2),'r.')
    hold on
    plot(posCell(:,1),posCell(:,2),'r.')
    set(gca,'YDir','reverse')

%% 

    oldContour = posNuc;
    %Making the initial Mask
    BW_oldContour = poly2mask(oldContour(:,1),oldContour(:,2),img_y,img_x);

    dist = 40; %Distance between 2 points in contour (in pixels)
    ctr = 0;

    numLyso = []; %Number of Lysosomes
    areaS = []; %Area of mask

    
    %Mask area (initial contour)
    areaS = [areaS; sum(BW_oldContour(:))];

    %cell boundary Mask
    BW_cellBdry = poly2mask(posCell(:,1),posCell(:,2),img_y,img_x);
    %Make a coordinates mask (1 wherever lysosomes are present)
    BW_coords = zeros(img_y,img_x);
    
    lysoCoords = [];
    %Count number of trajectories 
    numTracks = length(CellTracks(timePt).tracks);
 
    %Loading initial positions for each of the tracks
        %x,y coordinate of first position of 1 track @ time before treatment
    for lysoTrack = 1:numTracks
        lysoCoords = [lysoCoords; CellTracks(timePt).tracks(lysoTrack).track(1,2:3)];
    end
    lysoCoords = round(lysoCoords);
    
    diff_lyso = [lysoCoords,diffConstants'];
    
    ind = sub2ind(size(BW_cellBdry),lysoCoords(:,2),lysoCoords(:,1));
    BW_coords(ind) = 1;

    %Number of lysosomes in initial contour (within nucleus)
    BW_modMask_lyso = BW_coords.*BW_oldContour;
    [lysoMask_y, lysoMask_x] = find(BW_modMask_lyso == 1);
    
    numLyso = [numLyso; sum(BW_modMask_lyso(:))];

    
    while 1

        ctr = ctr + 1;
        
        [c,mat1Ind, mat2Ind] = intersect(diff_lyso(:,1:2),[lysoMask_x, lysoMask_y],'rows');
        
        lysoDiffgradient{ctr} = [lysoMask_x, lysoMask_y,diff_lyso(mat1Ind,3)]; 
        
        % Expand Nucleus contour by 'dist' pixels 
        SE = strel('disk',dist);    
        BW_newContour = imdilate(BW_oldContour, SE);

        %Intersect new contour mask with cell boundary
        BW_contour_cell = BW_newContour.*BW_cellBdry;
        
        figure(2);
        imshow(BW_contour_cell,[])
        
        
        %Area of mask
        areaS = [areaS; [sum(BW_contour_cell(:))]];

        %Count number of lyso inside mask; 
        BW_modMask_lyso = BW_contour_cell.*BW_coords;
        [lysoMask_y, lysoMask_x] = find(BW_modMask_lyso == 1);
        
        numLyso = [numLyso; sum(BW_modMask_lyso(:))];

        %while loop termination condition (if mask completely overlaps with
        %cell)

        if sum(BW_contour_cell(:)) == sum(BW_cellBdry(:))
            break
        end
        
        BW_oldContour = BW_newContour;
    end

    %deltaArea = areaS(2:end)-areaS(1:end-1);
    %deltaLyso = numLyso(2:end)-numLyso(1:end-1);
    %spatDensity = deltaLyso./deltaArea;
    
    %LysoSpatDensity = [areaS, numLyso];
    filesave = strcat(fileMSD(1:end-10),sprintf('lysoDiff%0.1dt.mat',timePt));
    save(filesave, 'lysoDiffgradient')
    %filesave = strcat(fileTxt{txtCtr}(1:end-4),'_spatDensity.mat');
    %save(filesave,'LysoSpatDensity')
        
end

cd ..