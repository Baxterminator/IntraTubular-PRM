filename = 'maps/test1.png';
global map w h
[map,w,h] = getImage(filename);
global list_1x list_1y
[list_1x,list_1y] = find(map);
global n
n = size(list_1x);
n = n(1);
global L  %m
global density %pix/m
density = 50; 
global seg_sampling conf_sampling
seg_sampling = 20;
conf_sampling = 5;
L = [0.5,0.5,0.5,0.5];
global alpha
alpha = [3 1.5 1.2 1.0 1.0];

start; %TO BE DEFINED
goal;


qSet = createConfigurationArray(300);
nb_voisin = 50;

graph = createConfigurationGraph(qSet,nb_voisin,@distance,@delta,@collision);
ax = show_sparse(map);

for i=1:size(qSet,1)
    plot_robot(ax,qSet(i,:)',L);
end
[wasAdded,qSet,graph] = addConfiguration( q , qSet , graph ,nb_voisin , @delta , radius ) 