function ax = show_sparse(sparsem)
    fig_last = findall(groot, 'Type', 'figure', 'Name', 'Map');
    if isempty(fig_last)
        fig_last = figure('Name', 'Map');
    else
        %clf(fig_last);
    end
    figure(fig_last);
    ax = axes('Parent', fig_last);
    
    spy(sparsem, 'hw');
    hold on;
    set(gca, 'Color', 'k');
end