test_file = "maps/test1.png";

[im_binarized,pixelWidth,pixelHeight] = getImage(test_file);
global w h
w = pixelWidth;
h = pixelHeight;

global density
density = 5;
global map
map = im_binarized;

global seg_sampling
seg_sampling = 5;
Qini = [80/density; 167/density; pi/2; -3*pi/4];
Qtot = [Qini];
for i=1:20
    Qtot = [Qtot Qtot(:, i)+[0; 1; 0; 0]];
end

global L
L = [5; 8];

movie(make_movie(Qtot), 1, 5);
