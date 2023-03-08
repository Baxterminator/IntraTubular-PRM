test_file = "maps/test1.png";

[im_binarized,pixelWidth,pixelHeight] = getImage(test_file);
ax = show_sparse(im_binarized);

global density
density = 5;

Q = [20; 30; pi/5; -pi/3];
L = [5; 8];
plot_robot(ax, Q, L);