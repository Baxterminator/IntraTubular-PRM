function Q_array = createConfigurationArray(n)
    Q_array = zeros([n,6]);
    for i=1:n
        Q_array(i,:) = generateRandomConfiguration;
    end
end