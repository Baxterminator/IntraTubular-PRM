function qFree = generateFreeConfigurations( nbConfig , isCollision )

global dimOfQ

% Generate collision free configurations of disks in the plane.
% qFree = generateFreeConfigurations( nbConfig , isCollision )
%
% Inputs:
%   - nbConfig, number of collisions free configurations to generate.
%   - isCollision: handle to a boolean function that determines whether  
%                  a given configuration is a collision.
% Outputs:
%   - qFree, the array of collision free configurations. 
% 
% Author: Gaetan Garcia - Ecole Centrale de Nantes - Febr. 2021.

configCounter = 0 ;
% This call just to determine the size of a configuration
% and statically dimension qFree (much faster than dynamically).
q = generateRandomConfiguration ;
qFree = zeros( nbConfig , length(q) ) ;
%wbHandle = waitbar(0,'Generating free configurations...') ;
while configCounter < nbConfig
    q = generateRandomConfiguration ;
    if ~isCollision( q )
        configCounter = configCounter + 1 ;
        qFree(configCounter,:) = q ;
        if mod(configCounter,1000) == 0
            %waitbar(configCounter/nbConfig)
            fprintf('%c','.');
        end
    end
end
%close(wbHandle) ;
disp('Done generating configurations.');
save FreeConfigs qFree nbConfig box radius ;
end
