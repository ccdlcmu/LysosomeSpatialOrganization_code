# Figure 3
This folder contains all scripts used for generating data for figure-3
1. Converting .xml files to coords_x & coords_y (single particle trajectory files)
2. Evaluate mean-square-displacement (msd) for each particle trajectory and classify the trajectories into free diffusion, confined diffusion and directed motion

## 1. Converting .xml to coords_x & coords_y
trackParticles_count.sh : Shell script to count the number of particles in the input trajectory files
parseXML.sh : Shell script to parse .xml and get x&y coordinates for each particle with time 

### Instructions
1. Input time-lapse movies in Icy Bioimage analysis, complete spot tracking and save the .xml file in same folder
2. Determine the number of frames in the time-lapse movie used for single-particle tracking and enter as value for num_columns in parseXML.sh shell script. 
3. Run the following snippet on git-bash or any terminal: 
cat filename.xml | ./trackParticles_count.sh filename.xml "arbitrary-name"
4. Running this script will result in the formation of 2 text files ("trajectory_x_arbitrary-name" and "trajectory_y_arbitrary-name")


##2. Evaluate mean-square-displacement (msd) for each particle trajectory and classify the trajectories into free diffusion, confined diffusion and directed motion
MeanSqDisp.m : MATLAB script to calculate mean-square-displacement and classify trajectories into 3 modes of transport
plotloglogMSD.m : MATLAB script to plot loglogMSD wrt mode of transport
plotTrackswMode.m : MATLAB script to plot tracks wrt mode of transport
plotMSDwMode.m : MATLAB script to plot MSD wrt mode of transport
 
### Instructions
1. Run MATLAB script to compute mean-square-displacement, to classify the mode of trajectory and plot trajectories, loglogMSD and MSD wrt time-lags. "MeansSqDisp(filename, orgName)"