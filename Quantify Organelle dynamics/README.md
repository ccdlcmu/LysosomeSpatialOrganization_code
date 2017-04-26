#Quantify Organelle Dynamics
The organelle dynamics are quantified by performing Single Particle tracking (on Icy bioimage analysis) followed by computing the mean-squared displacement of each of the trajectories used for classifying the trajectories into their 3 modes of motion.

### 1. Convert .xml files to .txt 
```
Scripts
1. trackParticles_count.sh : Bash script to count the number of particles in the input trajectory files
2. parseXML.sh : Bash script to parse .xml and get x&y coordinates for each particle with time and output a .txt file

Instructions
a. Input time-lapse movies in Icy Bioimage analysis, complete spot tracking and save the .xml file in same folder
b. Determine the number of frames in the time-lapse movie used for single-particle tracking and enter as value for num_columns in parseXML.sh shell script. 
c. Run the following snippet on git-bash or any terminal: 
cat filename.xml | ./trackParticles_count.sh filename.xml "arbitrary-name"
d. Running this script will result in the formation of 2 text files ("trajectory_x_arbitrary-name" and "trajectory_y_arbitrary-name")
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