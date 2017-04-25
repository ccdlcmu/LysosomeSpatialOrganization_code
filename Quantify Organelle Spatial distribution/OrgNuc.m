function [minDistLysoNuc, minDistLysoCell, ArCell] = OrgNuc(poscellBdry, posNuc, OrgCoordsIn)

%cd Lysosome-Ctrl' (Fixed)'\
%cd ctl_DextranR_2-6h\


%BW_nuc = poly2mask(posNuc(:,1), posNuc(:,2), size(imgCell,1), size(imgCell,2));
%BW_cellBdry = poly2mask(poscellBdry(:,1),poscellBdry(:,2), size(imgCell,1), size(imgCell,2));

%Finding Area of cell (for future normalization)
ArCell = polyarea(poscellBdry(:,1), poscellBdry(:,2));


%Fit nuclear region to convex polygon
%k = convhull(posNuc(:,1),posNuc(:,2));
k = boundary(posNuc(:,1), posNuc(:,2));
convNuc = [posNuc(k,1), posNuc(k,2)];

%g = convhull(poscellBdry(:,1),poscellBdry(:,2));
g = boundary(poscellBdry(:,1),poscellBdry(:,2));
convCell = [poscellBdry(g,1),poscellBdry(g,2)];

%Plot convex polygon around cell
% figure,
% imshow(imgCell,[])
% hold on
% plot(convCell(:,1),convCell(:,2),'r')
% plot(convNuc(:,1), convNuc(:,2),'r')

%Find distance between organelles (lysosomes) and vertices of convex
%polygon (nucleus)
distLysoToConvNuc = pdist2(OrgCoordsIn, convNuc);
minDistLysoNuc = min(distLysoToConvNuc,[],2);


%Find distance between organelles (lysosomes) and vertices of convex
%polygon (cell)
distLysoToConvCell = pdist2(OrgCoordsIn, convCell);
minDistLysoCell = min(distLysoToConvCell, [], 2);


%kernel density estimation (distance from nucleus)
%[f,xi] = ksdensity(minDistLysoNuc);








