# Spatial gradient of Diffusion constants
The diffusion constants of lysosomes is determined and analyzed as a function of distance (r) from the nucleus with the aim of discovering interesting trends, if any

### 1. Diffusion Heat Map
```
Scripts
1. diffusionHeatMap.m: Produces a weighted scatter plot to depict spatial trends of diffusion constants, if any.

Instructions
a. Run diffusionHeatMap.m with inputs as illustrated in Demo_data folder and obtain weighted scattered plot
```

### 2. Mean-square displacement (MSD) and classification into 3 modes of motion {free diffusion, confined diffusion and active transport}
```
Scripts
1. MeanSqDisp.m : MATLAB script to calculate mean-square-displacement and classify trajectories into 3 modes of transport
2. plotloglogMSD.m : MATLAB script to plot loglogMSD wrt mode of transport
3. plotTrackswMode.m : MATLAB script to plot tracks wrt mode of transport
4. plotMSDwMode.m : MATLAB script to plot MSD wrt mode of transport
 
Instructions
a. Run MATLAB script to compute mean-square-displacement, to classify the mode of trajectory and plot trajectories, loglogMSD and MSD wrt time-lags. "MeansSqDisp(filename, orgName)"
```