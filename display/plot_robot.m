function ax = plot_robot(Q, L, varargin)
    %   Plot the skeletton of a N-R serial robot on the map
    %   -> Q is a n x q matrix, n is the number of parameter, q is the number of
    %       frames. Each column is a configuration
    %   -> L <float[n]>{l1, ..., ln-1} containing the length of each arm of the robot
    %   -> kwargs* all optional arguments
    %       - ax: the axes that the plot will be made, if none is provided it will use the (global) map variable
    %       - color: the string containing the color of the robot, by default it will be blue
    %   <- ax <axes> return a reference to the figure axes for further ploting
    %
    %   -> (global) map <sparse matrix> representing the binary map (0 = free, 1 = obstacle)
    %   -> (global) density <float> the density in px/m
    %
    %   CÔTE Geoffrey - CORROENNE Timothée

    % Loading optional arguments if they exist
    robot_color = 'r';

    for i = 1:nargin - 2

        if ishandle(varargin{i}) % Axes option
            ax = varargin{i};
        elseif isstring(varargin{i}) % Color of the robot
            robot_color = varargin{i};
        end

    end

    % If no figure has been given, make one from the map
    if exist('ax') == 0
        global map
        ax = show_sparse(map);
    end

    % Compute the base point of the robot (correspond to the (x,y) parameters)
    global density
    previous_x = Q(1) * density;
    previous_y = Q(2) * density;

    % Compute iteratively the joints position and plot a line between them
    for i = 2:size(Q) - 1
        P = pos(L, Q, i, 0);
        plot(ax, [previous_x, P(1)], [previous_y, P(2)], strcat('-o', robot_color));
        hold on;
        previous_x = P(1);
        previous_y = P(2);
    end

    % Plot the base point in a different color for better visibility
    scatter(ax, [Q(1) * density], [Q(2) * density], 'filled', 'g');
end
