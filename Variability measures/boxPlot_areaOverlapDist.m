
function [] = boxPlot_areaOverlapDist(xlsxFile, SheetName)

%Read xls File with Area-Overlap distances
data = xlsread(xlsxFile,SheetName);

%Based on the number of cells/ number of frames used for each cell, the
%number of rows chosen will vary. 

%Variables '*Within* imply variability within a cell along time
%Variables '*Among* imply variability across cells

IEWithinCell = data(1:542,1);
IEAmongCells = data(1:55, 5);
NNWithinCell = data(1:542,2);
NNAmongCells = data(1:55, 6);
NormOrgNucWithinCell = data(1:542,3);
NormOrgNucAmongCells = data(1:55, 7);

%Plot figures (all the 3 metrics individually)

figure,
C = [IEWithinCell; IEAmongCells];
grp = [zeros(1,542),ones(1,55)];
h = boxplot(C,grp,'Labels',{'Within cell','Across cells'})
set(h(7,:),'Visible','off')
title ('Variation in Normalized Inter-Organelle Distance')
ylabel('Area Overlap(A.U)')

figure,
C = [NNWithinCell; NNAmongCells];
grp = [zeros(1,542),ones(1,55)];
h = boxplot(C,grp,'Labels',{'Within cell','Across cells'})
set(h(7,:),'Visible','off')
title ('Variation in Nearest Neighbor Distance')
ylabel('Area Overlap(A.U)')

figure,
C = [NormOrgNucWithinCell; NormOrgNucAmongCells];
grp = [zeros(1,542),ones(1,55)];
h = boxplot(C,grp,'Labels',{'Within cell','Across cells'})
set(h(7,:),'Visible','off')
title ('Variation in normalized distance to nucleus')
ylabel('Area Overlap(A.U)')

%Plot figures (all the 3 metrics in a single figure)

figure,
C = [IEWithinCell; IEAmongCells;NormOrgNucWithinCell;NormOrgNucAmongCells; NNWithinCell; NNAmongCells];
grp = [zeros(1,542),ones(1,55),ones(1,542)*2,ones(1,55)*3,ones(1,542)*4,ones(1,55)*5];
h = boxplot(C,grp,'Labels',{'Within IO','Across IO','Within DN', 'Across DN','Within NN','Across NN'})
set(h(7,:),'Visible','off')
title ('Area Overlap Distances')
ylabel('Area Overlap (A.U)')
set(gca,'FontSize',20,'XTickLabelRotation',45)


figure,
C = [IEWithinCell;NNWithinCell; NormOrgNucWithinCell; IEAmongCells; NNAmongCells; NormOrgNucAmongCells];
grp = [zeros(1,542), ones(1,542), ones(1,542)*2, ones(1,55)*4, ones(1,55)*5, ones(1,55)*6];
h = boxplot(C,grp,'Labels',{'Within IO','Across IO','Within DN', 'Across DN','Within NN','Across NN'})
set(h(7,:),'Visible','off')
title ('Area Overlap Distances')
ylabel('Area Overlap (A.U)')
set(gca,'FontSize',20,'XTickLabelRotation',45)

end
