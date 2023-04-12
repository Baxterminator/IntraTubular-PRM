function [wasAdded, QSet, graph] = addConfiguration(q, QSet, graph, ...
        kNeighbors, delta, isCollision, distance_conf)
    %   Add a configuration to an existing graph of configuration and to a set
    %
    %   -> Q <double[n]> represents the configuration to add in the graph
    %   -> QSet is a <double[m, n]>, n is the number of parameter, m is the number of
    %       configurations that is already saved. Each row is a configuration
    %   -> graph <graph> represents the interconnections between the previously made configurations
    %   -> kNeighbors <int> the maximum number of neighbours to connect the configuration Q with
    %   -> delta <function> the function that will check whether we can pass from one configuration
    %       to another without stepping into an obstacle
    %   -> isCollision <function> the function that will test whether to robot is actually in collision
    %   -> distance_conf <function> the distance to use
    %
    %   <- wasAdded <bool> whether the configuration could have been added to the actual set or not
    %   <- QSet <double[m+1, n]> the updated QSet with the new configuration Q
    %   <- graph <graph> the updated graph with the new configuration Q
    %
    %   CÔTE Geoffrey - CORROENNE Timothée
    % Add configuration q to a graph of configurations.

    nearest = knnsearch(QSet, q, 'K', kNeighbors, 'NSMethod', 'exhaustive');
    nbNodes = size(graph, 1);
    wasAdded = false; % Until proved otherwise.

    for i = 1:kNeighbors

        if delta(q, QSet(nearest(i), :), isCollision) %collisionFreeSegment( q , QSet(nearest(i),:) , delta , radius ) % TO CHANGE
            graph(nbNodes + 1, nearest(i)) = distance_conf(q - QSet(nearest(i), :));
            graph(nearest(i), nbNodes + 1) = graph(nbNodes + 1, nearest(i));
            QSet(nbNodes + 1, :) = q;
            wasAdded = true;
            break;
        end

    end

end
