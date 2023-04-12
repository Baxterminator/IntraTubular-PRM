# PLANI_Matlab

Authors:
- [Geoffrey Côte](https://github.com/Meltwin) 
- [Timothée Corroënne](https://github.com/TCorroenne)

This repository is a project made during the path planning cours of the robotics engineering cursus at Centrale Nantes.

The goal was to write a planning algorithm that would move an intra-tubular robot (e.g. in domestic or industrial pipes to repair leaks) from a start configuration to a goal configuration.

The script was made to work for any N-R serial planar robot. To configurate the path finding, only the script main.m should be modified. The map is described by a binary png file and are located in the maps/ folder.

We made some bricks to use existing PRM function and an A* lib for matlab using sparse matrix for better optimisation. For more information, refer to the report in this repository (in French only).

Two videos are availible to show that a PRM algorithm does not always give an optimal trajectory. These are located in the out/ folder:
- 23-04-13_00-32-43.914.mp4 is a case where a non-optimal solution was found
- 23-04-13_00-40-58.073.mp4 is on the other hand a case where the solution seems quite close to an optimal one
