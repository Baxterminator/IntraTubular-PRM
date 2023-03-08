function collisionDetected = collision(Q)
% Return if there is a collision between the robot and the world
    global map L
    global seg_sampling
    
    % Iterate over the segments
    collisionDetected = false;
    for i=1:max(size(Q))-2
        Lpoints = linspace(0, L(i), seg_sampling);
        for l = Lpoints
            P = pos(L, Q, i, l);
            if ~map(P(1), P(2))
                collisionDetected = true;
                break;
            end
        end
        if collisionDetected
            break;
        end
    end
end