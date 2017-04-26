# Spatial gradient of Diffusion constants
The diffusion constants of lysosomes is determined and analyzed as a function of distance (r) from the nucleus with the aim of discovering interesting trends, if any

### 1. Diffusion Heat Map
```
Scripts
1. diffusionHeatMap.m: Produces a weighted scatter plot to depict spatial trends of diffusion constants, if any.

Instructions
a. Run diffusionHeatMap.m with inputs as illustrated in Demo_data folder and obtain weighted scattered plot
```

### 2. Quantify the range of diffusion constants with increasing distance from the nucleus
```
Scripts
1. spatialGradient_diffusionConstants.m: 
   Input: 
     i. .mat files present in Demo_data
   
   Output:
     i. Diffusion constants of organelles present in cell as a function of distance from nucleus\
    ii. Regex of mat file output => "*lysoDiff*t.mat"

2. diffusion_rings.m: 
   Input:
     i. .mat file present as regex (*Diff*t.mat*)

   Output:
     i. Diffusion constants of organelles in unique rings 
    ii. Regex of mat file output => "Diff*_Cell*.mat"

3. Plot_diffRings.m: 
   Input:
     i. .mat file present as regex ("Diff*_Cell*.mat)
    
   Output:
     i. box plot depicting range of diffusion constants with increasing "nuclear" distance

Instructions
a. Run spatialGradient_diffusionConstants.m; Once all mat files have been created, move to step b.
b. Run diffusion_rings.m; 
c. Once mat files from 'b' are created, run 'Plot_diffRings.m" to get a box plot
```
