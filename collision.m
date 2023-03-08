function collisionDetected = collision(Q)
% Return if there is a collision between the robot and the world
    global map L w h
    global seg_sampling
    
    % Iterate over the segments
    collisionDetected = false;
    for i=1:max(size(Q))-2
        Lpoints = linspace(0, L(i), seg_sampling);
        for l = Lpoints
            P = pos(L, Q, i, l);        %en px, arrondi au plus proche
            if(P(1)>w || P(1)<=0 || P(2)>h || P(2)<=0)
                collisionDetected = true;
                break;
            else
                if ~full(map(P(2), P(1)))
                    collisionDetected = true;
                    break;
                end
            end
        end
        if collisionDetected
            break;
        end
    end
end