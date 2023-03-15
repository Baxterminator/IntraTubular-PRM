function [wasAdded,qSet,graph] = addConfiguration( q , qSet , graph , ...
                                     kNeighbors , delta , isCollision , distance_conf ) 

% Add configuration q to a graph of configurations.

nearest = knnsearch(qSet,q,'K',kNeighbors,'NSMethod','exhaustive') ;
nbNodes = size(graph,1) ;
wasAdded = false ;  % Until proved otherwise.
for i = 1 : kNeighbors
    if delta(q,qSet(nearest(i),:),isCollision)  %collisionFreeSegment( q , qSet(nearest(i),:) , delta , radius )  % TO CHANGE
        graph(nbNodes+1,nearest(i)) = distance_conf( q-qSet(nearest(i),:) ) ;
        graph(nearest(i),nbNodes+1) = graph(nbNodes+1,nearest(i)) ;
        qSet(nbNodes+1,:) = q ;
        wasAdded = true ;
        break;
    end
end