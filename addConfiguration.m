function [wasAdded,qSet,graph] = addConfiguration( q , qSet , graph , ...
                                     kNeighbors , delta , L ) 

% Add configuration q to a graph of configurations.

nearest = knnsearch(qSet,q,'K',kNeighbors,'NSMethod','exhaustive') ;
nbNodes = size(graph,1) ;
wasAdded = false ;  % Until proved otherwise.
for i = 1 : kNeighbors
    if collisionFreeSegment( q , qSet(nearest(i),:) , delta , radius ) , % TO CHANGE
        graph(nbNodes+1,nearest(i)) = norm( q-qSet(nearest(i),:) ) ;
        graph(nearest(i),nbNodes+1) = graph(nbNodes+1,nearest(i)) ;
        qSet(nbNodes+1,:) = q ;
        wasAdded = true ;
    end
end