function config = generateRandomConfiguration()
    global n density
    %global map
    global list_x list_y L max_angle

    found = false;

    while ~found
        index = randi([1,n]);
        x_p =list_x(index);
        y_p =list_y(index);
        x = x_p/density;
        y = y_p/density;
        Q=[x,y,0];
        abandon = false;
        for j=1:size(L,2) %j = theta index
            if abandon
                break
            end
            i=0;    % ième tentative de faire rentrer le bras avec l'angle j dans le tuyau
            detect=true;
            while i<100 && detect
                if j==1
                    thtj = rand*(2*pi)-pi;
                else
                    cone_lim = (180-max_angle)*pi/180;
                    thtj = -pi + cone_lim + rand*(2*pi-2*cone_lim);
                end
                Q(j+2)=thtj;
                detect = collision(Q);
                i=i+1;
                if i==100 && detect
                    abandon = true;
                end
            end
            if (j==4 && detect == false)
                found = true;
            end
        end
        
    end
    config = Q;
end