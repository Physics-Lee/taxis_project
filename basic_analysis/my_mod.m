function z = my_mod(x,y) % x and y is positive
    if x < y
        z = x;
    elseif x == y
        z = x; % I just want to do this
    elseif x > y
        z = mod(x,y);
    end
end