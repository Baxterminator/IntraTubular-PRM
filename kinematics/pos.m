function P = pos(L, Q, idx_seg, l_seg)
% Return the position of point along the idx_seg  by a l_seg length in
% pixel with a robot configuration Q (in meters & rad)
    global density % px/m
    T = dgm(L, Q, idx_seg, l_seg);
    P = round([T(1, 3); T(2, 3)].*density);
end