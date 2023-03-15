function config = generateRandomConfiguration()
    global n density
    %global map
    global list_1x list_1y

    found = false;

    while ~found
        index = randi([1,n]);
        x_p =list_1x(index);
        y_p =list_1y(index);
        x = x_p/density;
        y = y_p/density;
        Q=[x,y,0];
        abandon = false;
        for j=1:4 %j = indice de theta
            if abandon
                break
            end
            i=0;    % ième tentative de faire rentrer le bras avec l'angle j dans le tuyau
            detect=true;
            while i<100 && detect
                if j==1
                    thtj = rand*(2*pi)-pi;
                else
                    cone_lim = 80*pi/180;
                    thtj = -pi + cone_lim/2 + rand*(2*pi-cone_lim);
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