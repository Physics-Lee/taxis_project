function theta_delta = calculate_theta_delta_v2(theta_in,theta_out)
    theta_delta = mod(theta_out - theta_in + pi, 2*pi) - pi;
end