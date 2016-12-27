# Figure 1
This folder contains all scripts used for generating data for figure-1, which focuses on proving that spatial distribution of organelles isn't random within a cell and to decipher the variation in spatial organization of organelles across cells using 4 statistical metrics. The following scripts are used:
### 1. Selecting Characteristic images
### 2. Evaluating Spatial statistical metrics
### 3. Calculating Ripley's K/L statistic for arbitrary cell shapes

## 1. Selecting characteristic images
characteristicImages: This script can be run to produce images of cells with their boundary and nucleus segmented (manually)

### Instructions
Run the code and follow the instructions (message boxes) as well as comments. 

## 2. Evaluating the spatial statistical metrics: 
plosCompBio_fig1 : This GUI based script allows you to import an image, detected positions and evaluate the 4 metrics; 

### Instructions
1. Run the plosCompbio_fig1 
2. Click the Load Image button and import the DIC, organelle, DAPI channel and the points detected text file.
3. Click the trace cell button and trace the boundary of the cell
4. Click the trace nucleus button and trace the nucleus of the cell
5. Click the buttons (any 4 metrics) to plot and save the metric. 

## 3. Calculating Ripley's K/L statistic for arbitrary cell shapes
ripleysK_arbitShape: This script takes the DAPI, DIC, organelle channel and the points detected (organelle positions) as the input and generates a homogenous poisson point process within the arbitrarily shaped cell. 

### Instructions
1. Run ripleysK_arbitShape.m and follow the instructions specified in message boxes to evaluate the Ripley's K/L function. 





