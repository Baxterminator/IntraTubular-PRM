function collisionDetected = collision(Q)
%   Compute some points on the robot to test is there is collision somewhere 
%   the first joint does not have any limit.
%   -> Q = (x, y, t1, ..., tn) the configuration vector [in meters & radians]
%   <- collisionDetected <bool> is True if the robot has a part in a wall
%
%   -> (global) map <sparse matrix> representing the binary map (0 = free, 1 = obstacle)
%   -> (global) L <float[n]>{l1, ..., ln-1} containing the length of each arm of the robot
%   -> (global) w <float> the width of the map (in px)
%   -> (global) h <float> the height of the map (in px)
%   -> (global) seg_sampling <int> the number of points to compute on each arm of the robot
%
%   CÔTE Geoffrey - CORROENNE Timothée

    global map L w h
    global seg_sampling
    
    % Iterate over the segments
    collisionDetected = false;
    for i=1:max(size(Q))-2  % For each arm
        % Generate all test points and iterate over them
        Lpoints = linspace(0, L(i), seg_sampling);
        for l = Lpoints

            % Computing point position (in rounded px) 
            P = pos(L, Q, i, l);

            % Test whether the robot is going outside of the map
            if(P(1)>w || P(1)<=0 || P(2)>h || P(2)<=0)
                collisionDetected = true;
                break;
            else
                % Else, test if the point is on a black cell
                if ~full(map(P(2), P(1)))
                    collisionDetected = true;
                    break;
                end
            end
        end

        % End as soon as a collision happen to optimize computation time
        if collisionDetected
            break;
        end
    end
end