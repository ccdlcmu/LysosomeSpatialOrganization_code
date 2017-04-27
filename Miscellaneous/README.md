# Variability Measures
The variability in the spatial metrics evaluated across cells as well as within a single cell along time can be computed using 3 distance metrics.

### 1. Area-Overlap Distance
```
Scripts
1. calculateAreaOverlapDist:
   Inputs:
     i. Cell specific Matfile (contains spatial metrics)
  
   Output:
     i. areaOverlap_IE: Area overlap distance between Inter-organelle distributions along time within a single cell
    ii. areaOverlap_NN: Area overlap distance between Nearest-neighbor distribution along time within a single cell 
   iii. areaOverlap_OrgNuc: Area overlap distance between normalized distance to nucleus along time within a single cell

2. boxPlot_areaOverlapDist:
   Inputs:
     i. MS Excel file name that contains all the distance values
    ii. Sheet name (within excel file) that contains the distance measures

   Outputs:
     i. Box plots

   Instructions
     a. Run calculateAreaOverlapDist and store all the distance measures in an excel file.
     b. Pass the excel & sheet name as parameters to boxPlot_areaOverlapDist to get boxplots.
```
### 2. Euclidean Distance: 
```
Scripts
1. calculateEuclidDist: 

   Inputs:
     i. Cell specific Matfile (contains spatial metrics) 
	
    Output:
     i. Eucliddist_IE: Euclidean distance between Inter-organelle distributions along time within a single cell
    ii. Eucliddist_NN: Euclidean distance between Nearest-neighbor distribution along time within a single cell
   iii. Eucliddist_OrgNuc: Euclidean distance between normalized distance to nucleus along time within a single cell
   
2. boxPlot_EuclidDist:
   Inputs:
     i. MS Excel file name that contains all the distance values
    ii. Sheet name (within excel file) that contains the distance measures

   Outputs:
     i. Box plots

   Instructions
     a. Run calculateEuclidDist and store all the distance measures in an excel file.
     b. Pass the excel & sheet name as parameters to boxPlot_EuclidDist to get boxplots.
```

### 3. Bhattacharyya Distance
```
Scripts
1. calculateBCDist: 

   Inputs:
     i. Cell specific Matfile (contains spatial metrics) 
	
    Output:
     i. BCdist_IE: Bhattacharyya distance between Inter-organelle distributions along time within a single cell
    ii. BCdist_NN: Bhattacharyya distance between Nearest-neighbor distribution along time within a single cell
   iii. BCdist_OrgNuc: Bhattacharyya distance between normalized distance to nucleus along time within a single cell
   
2. boxPlot_BCDist:
   Inputs:
     i. MS Excel file name that contains all the distance values
    ii. Sheet name (within excel file) that contains the distance measures

   Outputs:
     i. Box plots

   Instructions
     a. Run calculateBCDist and store all the distance measures in an excel file.
     b. Pass the excel & sheet name as parameters to boxPlot_BCDist to get boxplots.
```


