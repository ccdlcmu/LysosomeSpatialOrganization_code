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

   Instructions
     a. Run ripleysK_arbitShape.m and follow the instructions specified in message boxes
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
   
   Instructions
     a. Run the plosCompbio_fig1 
     b. Click the Load Image button and import the DIC, organelle, DAPI channel and the points 				detected text file.
     c. Click the trace cell button and trace the boundary of the cell
     d. Click the trace nucleus button and trace the nucleus of the cell
     e. Click the buttons (any 4 metrics) to plot and save the metric. 
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
   
   Instructions
     a. Run the plosCompbio_fig1 
     b. Click the Load Image button and import the DIC, organelle, DAPI channel and the points 				detected text file.
     c. Click the trace cell button and trace the boundary of the cell
     d. Click the trace nucleus button and trace the nucleus of the cell
     e. Click the buttons (any 4 metrics) to plot and save the metric. 
```


