% Calculate the "Mean Square Error to the initial theta" of a run.
%
% 2023-09-30, Yixuan Li
%

function MSE_to_initial = mean_square_error_to_initial_v2(theta)

    delta_theta = my_diff_v2(theta(1),theta);
    MSE_to_initial = sum(delta_theta.^2)/length(theta);
    
end