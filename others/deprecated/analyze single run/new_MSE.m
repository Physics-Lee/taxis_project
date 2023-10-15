function [MSE_mean,MSE_all] = new_MSE(theta)
    
	n = length(theta);
    MSE_all = zeros(n,1);
    
    % calculate MSE to the initial theta of a run   
    MSE_all(1) = mean_square_error_to_initial(theta);
    
    % calculate MSE to all theta of a run    
    n_theta_after_screen = 2; % to include i == 1 and i == n
    for i = 2:n - 1        
        if screen_a_theta(theta(i),theta(i-1),theta(i+1))
            n_theta_after_screen = n_theta_after_screen + 1;
            theta_remain = theta(i:n);
            MSE_all(i) = mean_square_error_to_initial(theta_remain);            
        end
    end
    
    MSE_mean = sum(MSE_all)/n_theta_after_screen;
    
end