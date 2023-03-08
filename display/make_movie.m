function movie = make_movie(Qset)
% Make a movie from a configuration set
%   -> Q is a n*q matrix, n is the number of parameter, q is the number of
%   frames
%   Each column is a configuration
    global L
    
    n_frames = size(Qset, 2);
    movie(n_frames) = struct('cdata',[],'colormap',[]);
    for frame_id=1:n_frames
        Q = Qset(:, frame_id);
        ax = plot_robot(Q, L);
        movie(frame_id) = getframe(ax);
    end
end