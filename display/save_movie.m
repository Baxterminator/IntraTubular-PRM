function save_movie(movie)
    %   Save a movie into a MPEG-4 file
    %   -> movie <Frame[]> a vector of frames
    %
    %   CÔTE Geoffrey - CORROENNE Timothée


    % Prepare the output file
    f_name = strcat("./out/", datestr(datetime('now'), "yy-mm-dd_HH-MM-SS.FFF"), ".mp4");
    writer = VideoWriter(f_name, 'MPEG-4');
    writer.FrameRate = 20;

    open(writer);
    writeVideo(writer, movie);
    close(write;)

end
