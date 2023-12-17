# Introduction

This folder contains codes for ploting the histogram of angles in runs.

This angles are the basis of further analysis, so it is very important to know its distribution!



# Problems of Conditional Frequency

**All analysis about $f(blah|\theta_{in})$ can't be trusted, because a run with $\theta_{in}$ in certain region can quickly be into another region.**

This is also the reason why

* persistent length method is so important.
* we must consider intention-to-treat in biased random walk.



# What Do These Distributions Tell Us?

* All of them are Gaussian-like, except $f(\theta|\theta_{in} \ belongs \ to \ region \ 1)$, which is uniform-like
* $f(\theta_{in})$
  * biased, not uniform-like
* $f(\theta)$
  * single peak instead of double peak, which is one of the most important result of Bingzhen thesis
* $f(\theta - \theta_{in})$
  * eliminate the bias of $\theta_{in}$
  * I used to believe that $f(\theta - \theta_{in}| \theta_{in} \ belongs \ to \ region \ 2)$ and $f(\theta - \theta_{in}| \theta_{in} \ belongs \ to \ region \ 4)$ shows difference of **Ping-discovery**, but seem not now, because quadrant 2 and quadrant 4 are similar in the figure of persistent length.
* $f(\Delta \theta)$
  * can be used to label shallow turn, although this is a bad method.
  * shows consistency with persistent length.
  * tell us SMD and RMD runs straighter.
