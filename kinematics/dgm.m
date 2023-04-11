function T0i = dgm(L,Q, idx_seg, l_seg)
%   Compute the MDG of the intra-tubular robot
%   -> Q = (x, y, t1, ..., tn) the configuration vector [in meters/radians]
%   -> L = <float[n]>(l1, ..., ln-1) the length of the arms [in meters]
%   -> idx_seg is the segment onto which we compute the MGD (e.g. 1, 2, ...)
%   -> l_seg is the length that we should travel onto the wanted segment [in meters]
%       = 0 => Joint between arms idx_seg-1 and idx_seg
%       = L(idx_seg) => the position of the joint between arms idx_seg and idx_seg + 1
%
%   <- T0i <4x4 matrix> the homogenous transform between the world frame and the asked point
%
%   CÔTE Geoffrey - CORROENNE Timothée

    % Get the number of the segment
    n_max = max(size(Q))-2;

    % If asking an arms that doesn't exist, limit to the end-point of the manipulator
    if idx_seg > n_max
        idx_seg = n_max;
        l_seg = L(idx_seg);
    end
    
    % Template for making 2D homogenous transformation matrix
    T = @(xi, yi, ti) [cos(ti) -sin(ti) xi;
                        sin(ti) cos(ti) yi;
                        0 0 1];
    
    % Recursive template to compute the DGM.
    % Split the computation on the joints and a translation on the segment
    % It's not optimal considering that the algorithm will compute 
    % each joint position at each call.
    if idx_seg == 1 && l_seg == 0  % End of recursivity, we return the value of the transformation matrix of the robot base 
        T0i = T(Q(1), Q(2), Q(3));
    elseif l_seg == 0   % Else if we're asked to compute a joint position
        T0i = dgm(L, Q, idx_seg-1, L(idx_seg-1))*T(0, 0, Q(idx_seg+2));
    else  % Else, compute previous joint position and add small translation corresponding to the wanted position on the axle
        T0i = dgm(L, Q, idx_seg, 0) * T(l_seg, 0, 0);
    end
end

