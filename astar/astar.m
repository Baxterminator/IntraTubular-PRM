% Find a path in a graph using the A* algorithm
%
% Inputs:
%   - start,goal: start and goal vertices of the graph (integer number).
%   - graph: the sparse NxN matrix of the graph, N number of vertices.
%            graph(i,j) is the cost of the arc between vertices i and j,
%            and should be positive.
%   - nodeInfo: a N-cell array with the characteristics of each node.
%               Node info depends on the problem at hand.
%   - hStarHandle: the handle to the h* function. Typically, the function
%                  uses goal and nodeInfo to calculate the estimated cost
%                  from a given node to the goal. The function will 
%                  be called by h*(goal,nodeInfo) so h* should know what
%                  nodeInfo is all about.
% Outputs:
%   - path: a list of node numbers, from start to goal.
%   - cost: the cost of the path
%   - openSet,nodesInOpenSet, closedSet,nodesInClosed set for result 
%        display purposes.
%
% Note:
%   The program displays a progress bar. The progress restarts every 
%   1000 loops: there is no way to know beforehand how many loops will be
%   performed...
%
% Author: 
%   Gaetan Garcia - Ecole Centrale de Nantes

function [path,cost,openSet,closedSet] = ...
    astar( start , goal , graph , nodeInfo , hStarHandle )

global numberOfNodes envir

    numberOfNodes = size(graph,1) ;
    rng shuffle ;
    
    % Initialize open and closed sets
    openSet   = [zeros(numberOfNodes,1) , Inf(numberOfNodes,1)] ;
    closedSet = [zeros(numberOfNodes,1) , Inf(numberOfNodes,1)] ;
    
    goalReached = false ;
    % Put start in open. No predecessor (denoted as -1).
    openSet(start,:)= [-1, hStarHandle(nodeInfo(start,:)-nodeInfo(goal,:)) ] ;
    
    %wbHandle = waitbar(0,'Searching the graph...') ;
    nbLoops = 0 ;
    % While the goal is not reached and openSet is not empty...
    while ~goalReached && any(openSet(:,1))

        nbLoops = nbLoops + 1 ;
        if mod(nbLoops,100) == 0
            %waitbar( mod(nbLoops,1000)/1000 ) ;
            fprintf('%c','.');
        end
        
        % Take node with lowest evaluation in openSet and remove it
        % and put in closed set.
        [eval,node] = min(openSet(:,2)) ;
        predecessor = openSet(node,1) ;
        openSet(node,:) = [0 Inf] ;
        closedSet(node,:) = [predecessor , eval] ;
        
        if node == goal
            goalReached = true ;
        else
            edges = find( graph(node,:) > 0 ) ;
            % Just to check that the cost of an optimal path is not
            % influenced, randomly order edges.
            edges = edges(randperm(length(edges)));
            for edgeIndex = 1 : length(edges)
                successor = edges(edgeIndex) ;
                successorEval = eval ...
                    - hStarHandle(nodeInfo(node,:)-nodeInfo(goal,:)) ... 
                    + hStarHandle(nodeInfo(successor,:)-nodeInfo(goal,:)) ... 
                    + graph(node,successor) ;
                if openSet(successor,1) ~= 0 % succ is in openSet.
                    if successorEval < openSet(successor,2)
                        % New evaluation is better: update accordingly.
                        openSet(successor,:) = [node, successorEval] ;
                    end
                elseif closedSet(successor,1) ~= 0 % succ is in closedSet
                    if successorEval < closedSet(successor,2)
                        % New evaluation is better: put back in openSet
                        openSet(successor,:) = [node, successorEval] ;
                        % Update in closedSet.
                        closedSet(successor,:) = [node, successorEval] ;
                    end
                else
                    openSet(successor,:) = [ node , successorEval ] ;
                end
            end
        end
    end
    
    if ~goalReached
        path = [] ;
    else
        node = goal ;
        indexInPath = 1 ;
        path(indexInPath) = goal ;
        while node ~= start
            if closedSet(node,1) == 0 
                error(['Can''t find ',num2str(node),' in closedSet!']);
            else
                node = closedSet(node,1) ;
                indexInPath = indexInPath+1 ;
                path(indexInPath) = node ;
            end
        end
    end
    
    % Calculate the cost of the path.
    cost = 0.0 ;
    for i = 1 : length(path)-1
        cost = cost + graph( path(i) , path(i+1) ) ;
    end
    return

    cost = pathCost( path , graph ) ;
    %close(wbHandle) ;
    
    %------------------
    % Functions used in astar function.
    %------------------
    
    function cost = pathCost( path , graph )
        % Assuming path is legal
        cost = 0.0 ;
        for i = 1 : length(path)-1
            cost = cost + graph( path(i) , path(i+1) ) ;
        end
        return
    end

end
