function theta_delta = calculate_theta_delta(theta_in,theta_out)
    theta_delta = theta_out - theta_in;
    for i = 1:length(theta_delta)
        if theta_delta(i) > +pi
            theta_delta(i) = mod(theta_delta(i),-pi);
        end
        if theta_delta(i) < -pi
            theta_delta(i) = mod(theta_delta(i),+pi);
        end
    end
end