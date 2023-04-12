function config = generateRandomConfiguration()
    %   Generate an array of random configuration
    %
    %   -> m <int> the number of parameter a configuration has
    %
    %   <- Q_array <nxm> containing all the generated configuration
    %
    %   -> (global) n <int> number of possible point in a variable
    %   -> (global) density <float> the density in px/m
    %   -> (global) list_x <int[]> the x coordinate of all free cell 
    %   -> (global) list_y <int[]> the y coordinate of all free cell 
    %   -> (global) L <float[n]>(l1, ..., ln-1) the length of the arms [in meters]
    %   -> (global) max_angle <float> the maximum angle that a joint can have [in radians] 
    %
    %   CÔTE Geoffrey - CORROENNE Timothée

    global n density
    global list_x list_y L max_angle

    found = false;

    % While a free configuration hasn't been found, search for another one
    while ~found
        % Get a random cell
        index = randi([1,n]);
        x_p =list_x(index);
        y_p =list_y(index);

        % Get the point in meters for further computation
        x = x_p/density;
        y = y_p/density;
        Q=[x,y,0];

        % Now that we have an base position, we have to get all the joint position 
        % where the robot do not collide with any obstacle or itself
        abandon = false;
        for j=1:size(L,2) %j = theta index
            if abandon
                break
            end
            i=0;    % ième tentative de faire rentrer le bras avec l'angle j dans le tuyau
            detect=true;
            while i<100 && detect
                if j==1
                    thtj = rand*(2*pi)-pi;
                else
                    cone_lim = (180-max_angle)*pi/180;
                    thtj = -pi + cone_lim + rand*(2*pi-2*cone_lim);
                end
                Q(j+2)=thtj;
                detect = collision(Q);
                i=i+1;
                if i==100 && detect
                    abandon = true;
                end
            end
            if (j==4 && detect == false)
                found = true;
            end
        end
        
    end
    config = Q;
end