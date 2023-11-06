# Introduction

Hi, I am a ranger in neuroscience.



# How to Analyze?

Now we have data from both the high-throughout system and the Colbert system, so it is better to save some halfway files.

Just 2 steps. **(I will call the first step upstream and call the second step downstream.)**

For the high-throughout system:

`eset.mat -> run_disp.mat, reorientation_disp.mat -> results`

For the Colbert system:

`mcd.mat, machine_label.csv -> run_disp.mat, reorientation_disp.mat. -> results`



## Upstream

* `eset_mat_to_intermediate_files`: `eset.mat -> run_disp.mat, reorientation_disp.mat.`
* `mcd_mat_to_intermediate_files`: `mcd.mat, machine_label.csv -> run_disp.mat, reorientation_disp.mat.`
* `correct the ideal direction of NC or Ortho`: When doing Colbert experiments, sometimes we make the ideal direction of NC to be **up** and that of ortho to be **left-up**, to eliminate the effect of the air conditioner.



## Downstream

* `run_strategy`
  * `distribution_of_angles`: plot the distribution of all the angles of runs that you could ever imagine.
  * `persistent_length`: persistent length analysis, first use `run_disp_to_persistent_length`, then `change_error_bar`.
  * `weighted average`: Calculate weighted average of a certain measure of runs instead of arithmetic average.
* `reorientation_strategy`
  * `Poisson process`: plot the distribution of inter-incident-interval, to see if run follows Poisson process and if reorientation follows.
  * `biased reorientation`: plot the distribution of $\Delta \theta$ of reorientations.
* `deprecated`: codes that are not in use now, but may be useful in the future.



## utils

utils contains some tool-like funcitons and scripts.

* `general` contains tools for general purposes, like moving files, deleting files and Tukey test.
* `for_taxis_project` contains tools for this project, like screening data, `from_points_to_theta` and `use_circle_to_test_persistent_length`.
* `for_Colbert` contains tools for processing Colbert data, like getting centerlines and calculating the curvature.
