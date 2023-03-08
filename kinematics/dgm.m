function T0i = dgm(L,Q, idx_seg, l_seg)
% Compute the MDG of the intra-tubular robot
% Q = (x, y, t1, ..., tn)the configuration vector
% L = (l1, ..., ln-1) the length of the arms
% idx_seg is the segment onto which we compute the MGD
% l_seg is the length on the semgent where the point is

    % Get the number of the segment
    n_max = max(size(Q))-2;
    if idx_seg > n_max
        idx_seg = n_max;
        l_seg = L(idx_seg);
    end
    
    T = @(xi, yi, ti) [cos(ti) -sin(ti) xi;
                        sin(ti) cos(ti) yi;
                        0 0 1];
    
    if idx_seg == 1 && l_seg == 0
        T0i = T(Q(1), Q(2), Q(3));
    elseif l_seg == 0
        T0i = dgm(L, Q, idx_seg-1, L(idx_seg-1))*T(0, 0, Q(idx_seg+2));
    else
        T0i = dgm(L, Q, idx_seg, 0) * T(l_seg, 0, 0);
    end
end

