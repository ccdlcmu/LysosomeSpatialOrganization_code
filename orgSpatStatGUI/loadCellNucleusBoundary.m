function  [boundary, whichBondary] = loadCellNucleusBoundary(boundaryPath, boundaryFile)

if ~iscell(boundaryFile) % one file
    
    BoundaryFileName = fullfile(boundaryPath, boundaryFile);
    load(BoundaryFileName)
    
    if contains(boundaryFile,'CellBoundary')
        
        if exist('posCell', 'var')
            boundary = posCell;
        elseif exist('cellBoundary', 'var')
            boundary = cellBoundary;
        end
        whichBondary = {'cell'};
    elseif contains(boundaryFile,'NucleusBoundary')
        
        if exist('posNuc', 'var')
            boundary = posNuc;
        elseif exist('nucleusBoundary', 'var')
            boundary = nucleusBoundary;
        end
        whichBondary = {'nucleus'};
    end
    
elseif iscell(boundaryFile) % two files
    
    if and( contains(boundaryFile{1},'CellBoundary'),contains(boundaryFile{2},'NucleusBoundary') )
        cellBoundaryFileName = fullfile(boundaryPath, boundaryFile{1});
        nucleusBoundaryFileName = fullfile(boundaryPath, boundaryFile{2});
        
    elseif and( contains(boundaryFile{2},'CellBoundary'),contains(boundaryFile{1},'NucleusBoundary') )
        cellBoundaryFileName = fullfile(boundaryPath, boundaryFile{2});
        nucleusBoundaryFileName = fullfile(boundaryPath, boundaryFile{1});
        
    end
    
    load(cellBoundaryFileName)
    load(nucleusBoundaryFileName)
    if exist('posCell', 'var')
        cellBoundary = posCell;
    end
    if exist('posNuc', 'var')
        nucleusBoundary = posNuc;
    end
    
    boundary = {cellBoundary;nucleusBoundary};
    
    whichBondary = {'cell';'nucleus'};
    
    
end