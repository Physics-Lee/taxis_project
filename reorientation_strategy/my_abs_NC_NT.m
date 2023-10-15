function x = my_abs_NC_NT(theta)
    if theta < 0
        x = abs(theta - (-pi));
    else
        x = abs(theta - pi);
    end
end