function Q_array = createConfigurationArray(m, n)
    %   Generate an array of random configuration
    %
    %   -> m <int> the number of parameters a configuration has
    %   -> n <int> the number of configuration to make
    %
    %   <- Q_array <nxm> containing all the generated configuration
    %
    %   CÔTE Geoffrey - CORROENNE Timothée

    Q_array = zeros([m,n]);
    for i=1:m
        Q_array(i,:) = generateRandomConfiguration(m);
    end
end