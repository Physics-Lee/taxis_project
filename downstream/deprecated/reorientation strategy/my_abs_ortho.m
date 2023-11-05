function x = my_abs_ortho(theta)
    if theta < 1/4*pi
        x = abs(theta - (-3/4*pi));
    else
        x = abs(theta - (+5/4*pi));
    end
end