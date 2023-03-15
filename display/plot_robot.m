function ax = plot_robot(Q, L, varargin)
    global map
    
    robot_color = 'r';
    for i=1:nargin-2
        if ishandle(varargin{i}) % Axes option
            ax = varargin{i};
        elseif isstring(varargin{i})
            robot_color = varargin{i};
        end
    end
    if exist('ax') == 0
        ax = show_sparse(map);
    end
    
    global density
    old_x = Q(1)*density;
    old_y = Q(2)*density;
    
    for i=2:size(Q)-1
        P = pos(L, Q, i, 0);
        plot(ax, [old_x, P(1)], [old_y, P(2)], strcat('-o', robot_color));
        hold on;
        old_x = P(1);
        old_y = P(2);
    end
    scatter(ax, [Q(1)*density], [Q(2)*density],'filled', 'g');
end

