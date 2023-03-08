function plot_robot(ax,Q, L)
    old_x = -1;
    old_y = -1;
    for i=1:size(Q)-1
        i
        P = pos(L, Q, i, 0)
        if old_x == -1
            old_x = P(1);
            old_y = P(2);
        end
        plot(ax, [old_x, P(1)], [old_y, P(2)], '-or')
        hold on;
        old_x = P(1);
        old_y = P(2);
    end
end

