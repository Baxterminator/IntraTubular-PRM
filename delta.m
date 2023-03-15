function isPossible = delta(q1,q2,isCollision)
%DELTA Summary of this function goes here
%   Detailed explanation goes here
    global conf_sampling
    isPossible = true;
    for i=1:conf_sampling
        signt1 = sign(q1(3)-q2(3));
        qi = q1+((i+1)/(conf_sampling+2))*(q2-q1);
        if(abs(q1(3)-q2(3))>abs(q1(3)-q2(3)-signt1*2*pi))
            qi(3) = q1(3)+((i+1)/(conf_sampling+2))*(q2(3)-q1(3)+signt1*2*pi);
        end
        
        if(isCollision(qi'))
            isPossible = false;
            break;
        end
    end
end

