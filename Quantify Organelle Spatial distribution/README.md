# Quantify Organelle Spatial distribution 
The Ripley's K/L test can be used to test whether the spatial positioning of organelles is purely random; Having proved that their distribution is not random, 3 spatial metrics have been developed to quantify the same within a cell along time and across cells. 

### 1. Calculating Ripley's K/L statistic for arbitrary cell shapes:
```
Scripts
1. ripleysK_arbitShape:
   Inputs:
     i. Images (DAPI, DIC, TRITC/FITC)
    ii. Organelle coordinates (x,y)

   Output:
     i. Ripley's K/L v/s neighborhood radius(r)

   Instructions
     a. Run ripleysK_arbitShape.m and follow the instructions specified in message boxes to evaluate the 	Ripley's K/L function. 
```
### 2. Evaluating the spatial statistical metrics: 
```
Scripts
1. plosCompBio_fig1 : 

   Inputs:
     i. Image 
    ii. Organelle coordinates (x,y)
	
    Output:
     i. Evaluated spatial metrics (histograms and plots)
   
   Instructions
     a. Run the plosCompbio_fig1 
     b. Click the Load Image button and import the DIC, organelle, DAPI channel and the points 				detected text file.
     c. Click the trace cell button and trace the boundary of the cell
     d. Click the trace nucleus button and trace the nucleus of the cell
     e. Click the buttons (any 4 metrics) to plot and save the metric. 
```



