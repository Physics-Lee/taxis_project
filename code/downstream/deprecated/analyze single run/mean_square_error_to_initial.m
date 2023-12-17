function MSE_to_initial = mean_square_error_to_initial(theta)

    n = length(theta);
    MSE_to_initial = 0;
    n_theta_after_screen = 2; % to include i == 1 and i == n
    for i = 2:n
        if i < n
            if screen_a_theta(theta(i),theta(i-1),theta(i+1))
                n_theta_after_screen = n_theta_after_screen + 1;
                MSE_to_initial = MSE_to_initial + (my_diff_abs(theta(1),theta(i)))^2;
            end
        elseif i == n
            MSE_to_initial = MSE_to_initial + (my_diff_abs(theta(1),theta(i)))^2;
        end        
    end
    MSE_to_initial = MSE_to_initial / n_theta_after_screen;
    
end