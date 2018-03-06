function IODist = normIOSelectFrame(ptloc, frames)
% function of normalized inter-organelle  distance
% input:
% (1) ptloc: 1 x n or n x 1 structure with a field xy containing point positions and n =
% frame numbers
% (2) frames: frame indices

% output:
% normIODist: normalized inter-organelle distances


if isempty(frames) == 1
    frames = 1:length(ptloc2);
end

figure,
iiframe = 0;

for iframe = frames
    iiframe = iiframe+1;
    IODist(iiframe).D = pdist(ptloc(iiframe).xy);
    normIODist = IODist(iiframe).D/max(IODist(iiframe).D);  
    [f,Di] = ksdensity(normIODist);% smoothing
    idxf = find(f<0); f(idxf) = []; Di(idxf) = [];
    plot(Di, f);

    hold on
end

ylabel('pdf')
xlabel('normalized inter-organelle distance')
xlim([0 1])
end
