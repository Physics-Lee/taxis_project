function theta = calculate_theta_from_x_y(x,y)
    theta = zeros(1,length(x)-1);    
    for i = 1:length(x)-1
        delta_x = x(i+1) - x(i);
        delta_y = y(i+1) - y(i);
        if delta_x > 0
            theta(i) = atan(delta_y/delta_x);
        else
            if delta_y > 0
                theta(i) = atan(abs(delta_x)/delta_y) + pi/2;
            else
                theta(i) = - atan(delta_x/delta_y) - pi/2;
            end
        end
    end
end