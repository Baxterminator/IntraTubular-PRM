function ax = show_sparse(sparsem)
%   Plot a sparse matrix in a figure named "Map"
%   -> sparsem <sparse matrix> representing the map
%   <- ax <axes> return a axes reference for further ploting
%
%   CÔTE Geoffrey - CORROENNE Timothée

    % Looking for an already existing "Map" figure, else init it
    fig_last = findall(groot, 'Type', 'figure', 'Name', 'Map');
    if isempty(fig_last)
        fig_last = figure('Name', 'Map');

    end

    % Declare the use of the "Map" figure and get its axes
    figure(fig_last);
    ax = axes('Parent', fig_last);
    
    % Print the sparse matrix
    spy(sparsem, 'hw');
    hold on;

    % Custom parameters to alter the current plot
    set(gca, 'Color', 'k');  % Background = black
end