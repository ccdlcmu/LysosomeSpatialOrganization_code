%find diffusion constants within each ring 

sMat_lysoDiff = dir('*Diff3t.mat');
fileMat_lyso = {sMat_lysoDiff.name};
timePt = 3;

for fileNum = 1:length(fileMat_lyso)
    
    %Load all lyso positions and diffusion constants
    load(fileMat_lyso{fileNum})
    
    diffRings = {};
    
    for ring = 2:length(lysoDiffgradient)
        
        matA = lysoDiffgradient{ring-1};
        matB = lysoDiffgradient{ring};
        [C,indB] = setdiff(matB(:,1:2),matA(:,1:2),'rows');
        diffRings{ring-1} = matB(indB,3);
        
    end
    filesave = sprintf('DiffConstants_Cell%0.1d_time%0.1d',fileNum,timePt);
    save(filesave,'diffRings')
    
end
    