function particlePositionInBoundary = extractParticle(handles)

% This function extract particle positions from selected frames in a cell

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extract all the particles in the images.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% check frame indices
switch handles.frameSelection
    case 1 % all frames
        framesInput = []; % input for the particle extraction functions
    case 2
        framesInput = handles.frameIndices;
    otherwise
        msgbox('Please select image frames in the "Detected Particles Panel".')
end

% check particle detection program
if handles.isParticleDetectionInIcy == 1
    particlePositions = icyParticleInSelectedFrames(handles.particleFileName, framesInput);
elseif handles.isParticleDetectionInCustom == 1
    % load file
    
    if isfield(handles, 'particlePositions') == 1 % if custom particle detection was done
        particlePositions = handles.particlePositions;
    else
        load(handles.particleFileName,'particlePositions')
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find particles inside the boundary.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
particlePositionInBoundary = struct; % Initialization.
switch handles.frameSelection
    case 1
        frames = 1:length(particlePositions);
    case 2
        frames = framesInput; % which frames
end

% isParticleOnNucleusIncluded = get(handles.extractParticleInCellRadio,'Value');

iiframe = 0;
for iframe = frames
    iiframe = iiframe+1;
    allParticleX = particlePositions(iiframe).xy(:,1);
    allParticleY = particlePositions(iiframe).xy(:,2);
    inCell= inpolygon(allParticleX, allParticleY,...
        handles.cellBoundary(:,1),handles.cellBoundary(:,2) );
    inNuc = inpolygon(allParticleX, allParticleY,...
        handles.nucleusBoundary(:,1),handles.nucleusBoundary(:,2) );

    particlePositionInBoundary(iiframe,1).xy = [allParticleX(inCell) , allParticleY(inCell)]; 
    particlePositionInBoundary(iiframe,2).xy = [allParticleX(inNuc) , allParticleY(inNuc)];
    particlePositionInBoundary(iiframe,3).xy =  setxor(  particlePositionInBoundary(iiframe,1).xy,...
            intersect(particlePositionInBoundary(iiframe,1).xy, particlePositionInBoundary(iiframe,2).xy,'rows') ,'rows');


end


