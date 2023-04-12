function Q_array = createConfigurationArray(n)
    %   Generate an array of random configuration
    %
    %   -> m <int> the number of parameters a configuration has
    %   -> n <int> the number of configuration to make
    %
    %   <- Q_array <nxm> containing all the generated configuration
    %
    %   CÔTE Geoffrey - CORROENNE Timothée

    global L
    
    Q_array = zeros([n, size(L,2)+2]);
    for i=1:n
        Q_array(i,:) = generateRandomConfiguration();
    end
end