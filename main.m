% ########################################################################
%                            LIBS LOADING
% ########################################################################
addpath("./astar", ...
    "./display", ...
    "./kinematics", ...
    "./PRM_helpers")

% ########################################################################
%                           ROBOT DEFINITION
% ########################################################################
global L seg_sampling

% Define the length of each arm here (in meters)
L = [0.5, 0.3, 0.4, 0.5];

% Define how many points are made on the robot arm for the collision
% detection
seg_sampling = 5;

% ########################################################################
%                           MAP DEFINITION
% ########################################################################
global map w h density

% Set your own map file
image_file = "maps/test1.png";
[map,w,h] = getImage(image_file);

% Set the density of the map (in px/m)
density = 50; 

% ########################################################################
%                               RUNNING
% ########################################################################
