function nnDistance = nnDistDistributionSelectFrame(ptloc1, ptloc2, frames, pixelsize)

% Number of organelle types to be analyzed: 1

% Input:
% (1) ptloc1 and ptloc2: two 1 x n structure with a field xy containing point positions and n =
% frame numbers
% (2) frames: frame indices
% (3) pixelsize: unit: micrometer

% Output:
% nnDistance: nearest neighbor distances

kk = 2; % One type of organelle.

if isempty(frames) == 1
    frames = 1:length(ptloc2);
end

figure,
iiframe = 0;
for iframe = frames
    iiframe = iiframe+1;
    [idxnn, Dnn] = knnsearch(ptloc1(iiframe).xy, ptloc2(iiframe).xy,'K',kk); 
    D = Dnn(:,2); 
    [f,Di] = ksdensity(D); % smoothing
    idxf = find(f<0); f(idxf) = []; Di(idxf) = [];
    plot(Di*pixelsize/1000,f)
    hold on
    nnDistance(iiframe,1).D = D*pixelsize/1000;
   
end
xlim([0 8])
% figure,
% histogram(Dnn)
ylabel('pdf')
xlabel('nearest neighbor distance (micron)')


end
