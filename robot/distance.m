function dist = distance(qdiff)
%   Compute the distance between two configurations, also take in account 
%   the first joint does not have any limit.
%   -> qdiff <float[n]> the difference between two configuration
%   <- dist <float> the estimated distance between two configurations
%
%   -> (global) alpha <float[n-1]> containg all the coefficients for the distance computation
%   to compute the distance
%
%   CÔTE Geoffrey - CORROENNE Timothée

    global alpha

    distxy = alpha(1)*sqrt((qdiff(1))^2+(qdiff(2))^2);
    distt1 = alpha(2)*min([(qdiff(3))^2,(qdiff(3)+2*pi)^2,(qdiff(3)-2*pi)^2]);
    distt2 = alpha(3)*(qdiff(4))^2;
    distt3 = alpha(4)*(qdiff(5))^2;
    distt4 = alpha(5)*(qdiff(6))^2;
    
    dist = distxy + sqrt(distt1+distt2+distt3+distt4);

end

