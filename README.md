# Organelle spatial statistical analysis
This repo contains all scripts/code used for the paper titled "Whole-cell scale dynamic organization of lysosomes revealed by spatial statistical analysis" submitted to "Cell Reports"

## Folders
### 1. Quantification of lysosome spatial distribution 
```
 1. Ripley's K/L test (for checking spatial randomness)
 2. Quantifying distance measures for characterizing lysosome distributions
 The workflow is 
	i. Inter-Organelle distribution
	ii. Nearest-Neighbor distribution
	iii. Normalized to Nucleus distance
```
### 2. Quantification of variations of lysosome distance distributions.
```
The following methods measures variations between distance distributions within cells (intracellular) and among cells (intercellular).
(1). Two-sample Kolmogorov-Smirnov test (KS test): testing if two set of distances are sampeled from the same underlying probability distribuiton. 
(2). Ranksum test: a non-parametric test for testing if median of two distributions are the same or not. One-tailed tests are used in this study.
(3). Area non-overlap (Sorensen distance): dissimilarity of two distributions.

```
### 3. Quantify lysosome motility
```

 1. MSD
 2. Segregating MSD into 3 modes of motion
	i. Active Transport
	ii. Brownian Diffusion
	iii. Confined Diffusion
```
### 4. Micellaneous


## Authors
* **Guruprasad Raghavan** 
* **Qinle Ba**

## Citation
If you intend to use any of the scripts from this repository, please cite "Ba, Q., Raghavan, G., Kiselyov, K. & Yang, G. Whole-cell scale dynamic organization of lysosomes revealed by spatial statistical analysis. submitted (2017)."

## Acknowledgements



