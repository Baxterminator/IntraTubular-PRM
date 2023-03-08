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
global seg_sampling 
seg_sampling = 10;

L = [0.5,0.5,0.5,0.5];
ax = show_sparse(map);
global SHOW
SHOW = false;

for i=1:10
    Q = generateRandomConfiguration()';
    plot_robot(ax,Q,L);
    %x = input('input wait')
end