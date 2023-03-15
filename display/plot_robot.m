function ax = plot_robot(Q, L, varargin)
    global map
    if nargin > 2
        ax = varargin{1};
    else
        ax = show_sparse(map);
    end
    
    global density
    old_x = Q(1)*density;
    old_y = Q(2)*density;
    
    for i=2:size(Q)-1
        P = pos(L, Q, i, 0);
        plot(ax, [old_x, P(1)], [old_y, P(2)], '-or')
        hold on;
        old_x = P(1);
        old_y = P(2);
    end
    scatter(ax, [Q(1)*density], [Q(2)*density],'filled', 'g');
end

