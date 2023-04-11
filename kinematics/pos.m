function P = pos(L, Q, idx_seg, l_seg)
%   Return the position of point located at l_seg along the idx_seg in
%   pixel with a robot configuration
%   -> Q = (x, y, t1, ..., tn) the configuration vector [in meters/radians]
%   -> L = <float[n]>(l1, ..., ln-1) the length of the arms [in meters]
%   <- P the position in px of the point in the figure
%
%   -> (global) density <float> the density in px/m
%   CÔTE Geoffrey - CORROENNE Timothée

    global density % px/m

    T = dgm(L, Q, idx_seg, l_seg);
    P = round([T(1, 3); T(2, 3)].*density);
end