function [im_binarized,map_width,map_height] = get_map(filename)
%   Compute some points on the robot to test is there is collision somewhere 
%   the first joint does not have any limit.
%   -> filename <string> the absolute path to the map .png
%   <- im_binarized <sparse matrix> representing the binary map (0 = free, 1 = obstacle)
%   <- map_width <int> the width of the map (in px)
%   <- map_height <int> the height of the map (in px)
%
%   CÔTE Geoffrey - CORROENNE Timothée

    info = imfinfo(filename);
    map_width = info.Width;
    map_height = info.Height;
    imraw = imread(filename);
    imgrey = im2gray(imraw);
    im_binarized = sparse(imbinarize(imgrey));
end