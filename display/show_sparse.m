function ax = show_sparse(sparsem)
    fig = figure('Name', 'Map', 'NumberTitle', 'off');
    ax = axes('Parent', fig);
    spy(sparsem, 'hw');
    hold on;
    set(gca, 'Color', 'k');
end