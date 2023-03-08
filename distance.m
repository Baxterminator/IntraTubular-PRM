function dist = distance(qdiff)
%DISTANCE Summary of this function goes here
%   Detailed explanation goes here
    global alpha
    distxy = alpha(1)*sqrt((qdiff(1))^2+(qdiff(2))^2);
    distt1 = alpha(2)*min([(qdiff(3))^2,(qdiff(3)+2*pi)^2,(qdiff(3)-2*pi)^2]);
    distt2 = alpha(3)*(qdiff(4))^2;
    distt3 = alpha(4)*(qdiff(5))^2;
    distt4 = alpha(5)*(qdiff(6))^2;
    
    dist = distxy + sqrt(distt1+distt2+distt3+distt4);

end

