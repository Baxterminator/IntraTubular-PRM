clear;
close all;
filename = 'maps/test1.png';
global map w h
[map,w,h] = getImage(filename);
global list_x list_y
[list_y,list_x] = find(map);
global n
n = size(list_x);
n = n(1);
global L  %m
global density %pix/m
density = 50; 
global seg_sampling conf_sampling
seg_sampling = 20;
conf_sampling = 10;
L = [0.4,0.4,0.4,0.4];
global alpha
alpha = [3 1.5 1.2 1.0 1.0];

%%
start = [140/density,295/density,-pi/2,0,0,pi/4]; 

goal = [75/density,90/density,-pi/2,0,0,0];


qSet = createConfigurationArray(1500);
nb_voisin = 50;
%%
graph = createConfigurationGraph(qSet,nb_voisin,@distance,@delta,@collision);

n_node = size(graph,1)


[wasAdded_start,qSet,graph] = addConfiguration(start , qSet , graph ,nb_voisin , @delta , @collision , @distance);
[wasAdded_goal,qSet,graph] = addConfiguration(goal , qSet , graph ,nb_voisin , @delta , @collision , @distance);
wasAdded_start
wasAdded_goal

%%

alpha = alpha./alpha(1);


[path,cost,openSet,closedSet] = astar( n_node+1 , n_node+2 , graph , qSet , @distance )
path_inverse = flip(path);
path
size(path,2)
Qset_path = zeros(size(path,2),6);
Qset_path
for k=1:size(path_inverse,2)
    Qset_path(k,:) = qSet(path_inverse(1,k),:);
end
Qset_new = interpolation(Qset_path,5);
movie(make_movie(Qset_new'),10,18);
