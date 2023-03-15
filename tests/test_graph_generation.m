filename = 'maps/test_vide.png';
global map w h
[map,w,h] = getImage(filename);
global list_lx list_ly
[list_ly,list_lx] = find(map);
global n
n = size(list_1x);
n = n(1);
global L  %m
global density %pix/m
density = 50; 
global seg_sampling conf_sampling
seg_sampling = 20;
conf_sampling = 5;
L = [0.4,0.4,0.4,0.4];
global alpha
alpha = [3 1.5 1.2 1.0 1.0];

ax = show_sparse(map);
start = [140/density,295/density,-pi/2,0,0,pi/4]; 
plot_robot(ax,start',L);

goal = [75/density,90/density,-pi/2,0,0,0];
plot_robot(ax,goal',L);

%%
qSet = createConfigurationArray(100);
nb_voisin = 60;

graph = createConfigurationGraph(qSet,nb_voisin,@distance,@delta,@collision);
ax = show_sparse(map);



[wasAdded_start,qSet,graph1] = addConfiguration(start , qSet , graph ,nb_voisin , @delta , @collision , @distance);
[wasAdded_goal,qSet,graph1] = addConfiguration(goal , qSet , graph1 ,nb_voisin , @delta , @collision , @distance);
wasAdded_start
wasAdded_goal

for i=1:size(qSet,1)
    plot_robot(ax,qSet(i,:)',L);
end