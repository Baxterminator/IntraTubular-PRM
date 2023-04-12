function isPossible = delta(q1,q2,isCollision)
%   Create some waypoints configurations to check whether the robot will 
%   -> q1 <float[n]> first position
%   -> q2 <float[n]> second position
%   -> isCollision <function> the collision function that will be used
%   <- isPossible <bool> 
%       TRUE = the robot can pass from one configuration to another without any problem.
%       FALSE = the robot cannot go to one configuration to another
%
%   -> (global) conf_sampling <int> the number of points to generate onto the robots
%
%   CÔTE Geoffrey - CORROENNE Timothée

    global conf_sampling
    isPossible = true;

    % Using linear interpolation to test the collision between two points
    for i=1:conf_sampling
        signt1 = sign(q1(3)-q2(3));
        qi = q1+((i+1)/(conf_sampling+2))*(q2-q1);  % Interpolated point

        
        if(abs(q1(3)-q2(3))>abs(q1(3)-q2(3)-signt1*2*pi))
            qi(3) = q1(3)+((i+1)/(conf_sampling+2))*(q2(3)-q1(3)+signt1*2*pi);
        end
        
        if(isCollision(qi'))
            isPossible = false;
            break;
        end
    end
end

