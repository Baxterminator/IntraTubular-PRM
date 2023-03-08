function test_astar( envir, is,js , ig,jg , adjacency , hStarHandle ) 

% function test_astar( envir, is,js , ig,jg , hStarHandle )
%
% Test the A* algorithm on the problem of moving a point in a 2D 
% occupancy grid. 
%
% Inputs:
% - envir: a boolean matrix describing the 2D occupancy grid.
%          0: free space - 1: obstacle
% - is,js: start point pixel coordinates
% - ig,jg: goal point pixel coordinates.
% - adjacency: 0 for 4-adjacency, 1 for 8-adjacency.
% - hStarHandle: handle of the hStar function
%
% Notes:
% First the implicit adjacency graph between pixels of the grid is built.
% Then the graph is searched and the results are displayed as an image
% which includes start and goal positions, open and closed sets, and path.

% Exit is either start of goal point are in an obstacle or out of bounds,
% and that adjacency has a correct value.

nLin = size(envir,1) ;
nCol = size(envir,2) ;
numberOfNodes = nLin*nCol ;

if (is<=0) || (is>nLin) || (js<=0) || (js>nCol) || ...
   (ig<=0) || (ig>nLin) || (jg<=0) || (jg>nCol)
    error('Start or goal point out of bounds.');
end
if envir(is,js)==1 || envir(ig,jg)==1 
    error('Start and goal points cannot be in an obstacle.');
end
if adjacency~=0 && adjacency~=1 
    error('Incorrect value of adjancecy parameter (allowed are 0 and 1).');
end

% Create the adjacency graph as a Matlab sparse matrix plus a nodeInfo
% structure. In the general case of use of the A* algorithm, the nodeInfo
% structure typically holds a configuration vector corresponding to each
% node. Here it is its pixel coordinates.

% Variables for the adjacency graph.
graph    = sparse(numberOfNodes,numberOfNodes) ;
nodeInfo = zeros(numberOfNodes,2) ;

% Fill the nodeInfo part of the graph information.
for i = 1 : nLin
    for j = 1 : nCol
        nodeInfo( nodeNum(i,j) , : ) = [ i j ] ;
    end
end

% Fill adjacency matrix 
disp('Building adjacency matrix...');
for i = 1 : nLin-1
    for j=1 : nCol-1 
        % Is motion from (i,j) to (i,j+1) possible
        if envir(i,j)==0 && envir(i,j+1)==0 
            graph(nodeNum(i,j),nodeNum(i,j+1)) = 1.0 ;
            graph(nodeNum(i,j+1),nodeNum(i,j)) = 1.0 ;
        end
        % Same from (i,j) to (i+1,j)
        if envir(i,j)==0 && envir(i+1,j)==0 
            graph(nodeNum(i,j),nodeNum(i+1,j)) = 1.0 ;
            graph(nodeNum(i+1,j),nodeNum(i,j)) = 1.0 ;
        end
        % Same for (i,j) to (i+1,j+1).
        if adjacency == 1
            if envir(i,j)==0 && envir(i+1,j+1)==0
                graph(nodeNum(i,j),nodeNum(i+1,j+1)) = 1.414213 ;
                graph(nodeNum(i+1,j+1),nodeNum(i,j)) = 1.414213 ;
            end
        end
    end
    % Last line: don't check for neighbors below, but check to the right.
    for j = 1 : nCol-1
        if envir(nLin,j)==0 && envir(nLin,j+1)==0
            graph(nodeNum(nLin,j),nodeNum(nLin,j+1)) = 1 ;
            graph(nodeNum(nLin,j+1),nodeNum(nLin,j)) = 1 ;
        end
    end
    % Last column: don't check to the right, but check below.
    for i = 1 : nLin-1
        if envir(i,nCol)==0 && envir(i+1,nCol)==0
            graph(nodeNum(i,nCol),nodeNum(i+1,nCol)) = 1 ;
            graph(nodeNum(i+1,nCol),nodeNum(i,nCol)) = 1 ;
        end
    end
end

% Now search the graph for a path using the A* algorithm

start = nodeNum(is,js) ;
goal  = nodeNum(ig,jg) ;
[path,cost,openSet,closedSet] = ...
    astar( start , goal , graph , nodeInfo , hStarHandle ) ;

% Visualise sets and path.

visualizeResults(envir,is,js,ig,jg,path,cost,openSet,closedSet) ;

% -----------------------------
% Functions used above.
%------------------------------

% Node number to pixel coordinates.

function [line,col] = coordinates( nodeNumber )
   line = fix((nodeNumber-1)/nCol)+1 ;
   col  = mod(nodeNumber-1,nCol)+1 ;
end


%-------------
% Pixel coordinates to node number.

function nodeNumber = nodeNum(line,col)
   nodeNumber = (line-1)*nCol + col ;
end


%-------------
% Results visualization: visualize open and closed sets,
% initial and final point, and path.

function visualizeResults(A,is,js,ig,jg,path,cost,openSet,closedSet)

% Build the image to visualize.
grayImage = 255*uint8(~A);
visual = cat(3, grayImage, grayImage, grayImage);

% Color closed set
for k = 1 : size(closedSet,1)
    if closedSet(k,1) ~= 0
        [line,col] = coordinates( k ) ;
        visual(line,col,:) = [255 255 0] ; % yellow 
    end
end

% Color open set
for k = 1 : size(openSet,1) 
    if openSet(k,1) ~= 0
        [line,col] = coordinates( k ) ;
        visual(line,col,:) = [0 0 255] ; % blue 
    end
end

% Color the path
for k = 1 : length(path)
    [line,col] = coordinates( path(k) ) ;
    visual(line,col,:) = [0 255 0] ; % blue
end

% Color start and goal points
visual(is,js,:) = [255 0 0] ; % red
visual(ig,jg,:) = [0 255 255] ; % aqua

figure ;
imshow(visual,'InitialMagnification','fit')
title('bk:obst., w:free unexpl., y:closed, b:open, g:path');
xlabel(['cost: ',num2str(cost)]);
end

end