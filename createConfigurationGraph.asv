function graph = ...
    createConfigurationGraph(qSet,k,metric,delta,isCollision)

% Create a configuration graph with a set of free configurations of disks
% in the plane.
% graph = createConfigurationGraph(qSet,k,metric,delta,isCollision)
%
% Inputs:
%   - qSet: set of collision free configurations. Each line of qSet is a
%           collision free configuration.
%   - k: number of nearest neighbors to use when building the graph.
%   - metric: a norm over Q, called as metric(q), where q is a configuration.
%             In this context, design metric so distance(q1,q2) is obtained 
%             by calling metric(q1-q2). If other parameters are necessary
%             to the metric, they will have to be implemented as globals.
%             In practice, the parameter is a handle to the function.
%   - delta: The local planner, a function that returns true if it can find 
%            a collision free path between two collision free configurations. 
%            It will be invoked as delta(q1,q2). Additional necessary parameters
%            (e.g. a step) must be provided as globals.
%            In practice, the parameter is a handle to the function.
%            BEWARE: the algorithm assumes the local planner is SYMMETRICAL
%            and DETERMINISTIC. 
%   - isCollision: Function to check whether a given configuration is
%            a collision or not (it's a handle).
%
% Outputs:
%   - graph, the graph represented as an adjacency matrix. graph(i,j)=0
%            means no arc from node i to node j. graph(i,j)=someValue means 
%            there is an arc from i to j, with someValue being the cost
%            of the arc. The output adjacency matrix is a sparse matrix.
%
% Author: Gaetan Garcia - Ecole Centrale de Nantes - February 2021.

graph = sparse( size(qSet,1) ) ;

% Progress bars seem to take up quite a bit of resources, so they were
% replaced by a low-tech, low-consumption solution...
% wbHandle = waitbar(0,'Generating graph edges...') ;

for i = 1 : size(qSet,1) 
    % Low tech progress indicator. Waitbars seem to slow down the program.
    if mod(i,100) == 0 
        fprintf('%c','.');
    end
    %waitbar(i/size(qSet,1)) ;
    % Search for k+1 neighbors because configuration i will be in the list
    % of its own neighbors...
    nearest = knnsearch(qSet,qSet(i,:),'K',k+1,'NSMethod','exhaustive',...
                        'Distance','euclidean') ;
    % Eliminate all nodes whose index is stricly less than i. This will 
    % eliminate the node itself. Because the local planner is assumed
    % symmetrical if there is an edge from k to j<k, then there is
    % also an edge from j to k. Both edges will be created when processing
    % the neighbors of node j.
    nearest = nearest( (nearest > i) ) ;
    for j = 1 : length(nearest) 
        if delta( qSet(i,:),qSet(nearest(j),:),isCollision )
            graph(i,nearest(j)) = metric( qSet(i,:)-qSet(nearest(j),:) ) ;
            graph(nearest(j),i) = graph(i,nearest(j)) ;
        end
    end
end
disp('Done generating graph!');
%close(wbHandle) ;
return 
end
