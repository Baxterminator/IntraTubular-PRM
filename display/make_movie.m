function movie = make_movie(QSet)
    %   Make a movie from a configuration set
    %   -> QSet <n x q matrix>, n is the number of parameter, q is the number of
    %       frames. Each column is a configuration
    %
    %   -> (global) L <float[n]>{l1, ..., ln-1} containing the length of each arm of the robot
    %   -> (global) map <sparse matrix> representing the binary map (0 = free, 1 = obstacle)
    %
    %   CÔTE Geoffrey - CORROENNE Timothée

    global L map

    % Pre-allocate the memory for the movie
    n_frames = size(QSet, 2);
    movie(n_frames) = struct('cdata', [], 'colormap', []);

    % Plot the robot for each frame and save the frame in the array
    for frame_id = 1:n_frames
        Q = QSet(:, frame_id);
        ax = plot_robot(Q, L, "b");
        movie(frame_id) = getframe(ax);
    end

end
