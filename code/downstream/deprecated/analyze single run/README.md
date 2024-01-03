# Introduction

These codes were written in the March and April of 2023.

I wanted to analyze some indexes for each run at that time, but lately I found that taking all the continuous subsets (and keep the time order) is a better approach.

In summary, just 2 approaches:

* calculate some measure for the whole run.
* calculate some measure for all possible continuous subsets.



# THINK

Now (2023-09-29) consider about it:

For all measures, both approaches are OK.

But, when you want to split the whole plane into 2 regions or 4 regions or 8 regions, measures requiring the ideal direction will have intrinsic bias.

In summary, the intrinsic bias comes from splitting the plane, not these 2 approaches.