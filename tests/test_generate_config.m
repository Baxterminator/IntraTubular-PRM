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
seg_sampling = 5;

L = [0.3,0.3,0.3,0.3];
for i=1:200 
    Q = generateRandomConfiguration()
    %x = input(prompt)
end