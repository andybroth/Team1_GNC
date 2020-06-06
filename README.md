# Team1_GNC
There are few dependencies between Matlab files, the only dependencies will be on files in the library folder. 

This is formatted as follows:
FileName.m
Brief Description

ejection_drift.m
Plots the drift from a CubeSat ejected from Cygnus at a given initial velocity direction.

period_test.m
Used to calculate the injection delta V for a PRO ejected close to the x-axis. 

PRO.m
Use sequential convex optimization to solve numerically an optimal impulsive trajectory(2D) starting from a given PRO to final PRO while minimizing delta_v for firing

PRO_reconfig_2_maneouvres_test_case.m
Uses SCP optimization to solve numerically an optimal impulsive trajectory(2D) starting from a given PRO to final PRO while minimizing delta_v for firing.

RUN_MAIN.m
Finds min Delta V for a 1-impulse PRO injection from a fully random initial velocity.