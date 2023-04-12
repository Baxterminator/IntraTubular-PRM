% ########################################################################
%                            LIBS LOADING
% ########################################################################
addpath("./astar", ...
    "./display", ...
    "./robot", ...
"./PRM")
clear;
close all;

% ########################################################################
%                           ROBOT DEFINITION
% ########################################################################
global L max_angle

% Define the length of each arm here (in meters)
L = [0.4, 0.4, 0.4, 0.4];

% Define the maximum angle for theta(i), i>1 (in degree)
max_angle = 135;

% ########################################################################
%                           MAP DEFINITION
% ########################################################################
global map w h density list_x list_y n

% Set your own map file
image_file = "maps/test1.png";
[map, w, h] = get_map(image_file);

% Set the density of the map (in px/m)
density = 50;

% Create the lists of coordinates of every possible point in the map.
[list_y, list_x] = find(map);

% Get the number of possible point in a variable (n)
n = size(list_x, 1);

% Define the posture of the start and the goal
start = [140 / density, 295 / density, -pi / 2, 0, 0, pi / 4];
goal = [75 / density, 90 / density, -pi / 2, 0, 0, 0];

% ########################################################################
%                           PRM PARAMETERS
% ########################################################################
global alpha seg_sampling conf_sampling

% Define the factors to compute the distance between two configurations
alpha = [3 1.5 1.2 1.0 1.0];
alpha = alpha ./ max(alpha); % To have alpha(i)<1

% Define how many points are made on the robot arm for the collision
% detection
seg_sampling = 10;

% Define how many configurations are checked between two configuration
% randomly generated to verify the connectedness in the graph
conf_sampling = 10;

% Define the number of random configuration to be generated
nb_rd_conf = 1500;

% Define the number of neighbours to check while creating the graph
nb_neigh = 50;

% ########################################################################
%                         ANIMATION PARAMETERS
% ########################################################################
fps = 20;

% Number of configuration to add for smoothing
interpolation_smoothing = 5;

% Number of time the animation loops
nb_loop = 10;

% ########################################################################
%                               RUNNING
% ########################################################################

% Making to the set then the graph
qSet = createConfigurationArray(nb_rd_conf);
graph = createConfigurationGraph(qSet, nb_neigh, @distance, @delta, @collision);

nb_node = size(graph, 1);

% Add start and goal to graph
[wasAdded_start, qSet, graph] = addConfiguration(start, qSet, graph, nb_neigh, @delta, @collision, @distance);
[wasAdded_goal, qSet, graph] = addConfiguration(goal, qSet, graph, nb_neigh, @delta, @collision, @distance);

% Compute the path if it exists
[path, cost, openSet, closedSet] = astar(nb_node + 1, nb_node + 2, graph, qSet, @distance);

% Path is from goal to start, so let's revertit
path_inverse = flip(path);

% Creating the list of configuration on the path to make the movie
qSet_path = zeros(size(path, 2), size(L, 2) + 2);

for k = 1:size(path_inverse, 2)
    qSet_path(k, :) = qSet(path_inverse(1, k), :);
end

% Adding mid-configuration to smooth the animation
qSet_new = interpolation(qSet_path, interpolation_smoothing);

movie(make_movie(qSet_new'), nb_loop, fps);
