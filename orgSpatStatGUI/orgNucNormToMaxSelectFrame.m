function ONDist = orgNucNormToMaxSelectFrame(orgptloc, posnuc, frames )
% function of normalized organelle to Nucleus distance

% input:
% (1) orgptloc: 1 x n or n x 1 structure with a field xy containing point positions and n =
% frame numbers
% (2) frames: frame indices

% output:
% normIODist: normalized inter-organelle distances


if isempty(frames) == 1
    frames = 1:length(orgptloc);
end

figure,
iiframe = 0;
for iframe = frames
    iiframe = iiframe+1;
    [idxn, ONDist(iiframe,1).D] = knnsearch(posnuc,orgptloc(iiframe).xy,'K',1);  
    
    normD = ONDist(iiframe).D/max(ONDist(iiframe).D);
    
    [f,Di] = ksdensity(normD);
    idxf = find(f<0); f(idxf) = []; Di(idxf) = [];
    plot(Di, f)
    
    hold on
    
end

ylabel('pdf')
xlabel('normalized to-nucleus distance')
xlim([0 1])
