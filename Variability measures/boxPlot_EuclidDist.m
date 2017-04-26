function [] = boxPlot_EuclidDist(xlsxFile, SheetName)

%Read xls File with Bhattacharyya distances
data = xlsread(xlsxFile,SheetName);

%Based on the number of cells/ number of frames used for each cell, the
%number of rows chosen will vary. 

%Variables '*Within* imply variability within a cell along time
%Variables '*Among* imply variability across cells

IEWithinCell = data(4:545,1);
IEAmongCells = data(4:58, 5);
NNWithinCell = data(4:545,2);
NNAmongCells = data(4:58, 6);
NormOrgNucWithinCell = data(4:545,3);
NormOrgNucAmongCells = data(4:58, 7);

%Plot figures (all the 3 metrics individually)

figure,
C = [IEWithinCell; IEAmongCells];
grp = [zeros(1,542),ones(1,55)];
h = boxplot(C,grp,'Labels',{'Within cell','Across cells'})
set(h(7,:),'Visible','off')
title ('Variation in Normalized Inter-Organelle Distance')
ylabel('Euclid Distance (A.U)')
set(gca,'FontSize',20,'XTickLabelRotation',45)

figure,
C = [NNWithinCell; NNAmongCells];
grp = [zeros(1,542),ones(1,55)];
h = boxplot(C,grp,'Labels',{'Within cell','Across cells'});
set(h(7,:),'Visible','off')
title ('Variation in Nearest Neighbor Distance')
ylabel('Euclid Distance (A.U)')
set(gca,'FontSize',20,'XTickLabelRotation',45)

figure,
C = [NormOrgNucWithinCell; NormOrgNucAmongCells];
grp = [zeros(1,542),ones(1,55)];
h = boxplot(C,grp,'Labels',{'Within cell','Across cells'});
set(h(7,:),'Visible','off')
title ('Variation in Normalized Organelle-Nucleus Distance')
ylabel('Euclid Distance (A.U)')
set(gca,'FontSize',20,'XTickLabelRotation',45)

%Plot figures (all the 3 metrics simultaneously)

figure,
C = [IEWithinCell; IEAmongCells;NNWithinCell; NNAmongCells; NormOrgNucWithinCell;NormOrgNucAmongCells];
grp = [zeros(1,542),ones(1,55),ones(1,542)*2,ones(1,55)*3,ones(1,542)*4,ones(1,55)*5];
h = boxplot(C,grp,'Labels',{'Within IO','Across IO','Within DN', 'Across DN','Within NN','Across NN'})
set(h(7,:),'Visible','off')
title ('Euclid Distances')
ylabel('Euclid Distance (A.U)')
set(gca, 'FontSize',20,'XTickLabelRotation',45) 

figure,
C = [IEWithinCell;NNWithinCell; NormOrgNucWithinCell; IEAmongCells; NNAmongCells; NormOrgNucAmongCells];
grp = [zeros(1,542), ones(1,542), ones(1,542)*2, ones(1,55)*4, ones(1,55)*5, ones(1,55)*6];
h = boxplot(C,grp,'Labels',{'Within IO','Across IO','Within DN', 'Across DN','Within NN','Across NN'})
set(h(7,:),'Visible','off')
title ('Euclid Distances')
ylabel('Euclid Distance (A.U)')
set(gca,'FontSize',20,'XTickLabelRotation',45)

end