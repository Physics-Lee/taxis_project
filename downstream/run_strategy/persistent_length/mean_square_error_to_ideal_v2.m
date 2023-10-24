% Calculate the "Mean Square Error to the ideal theta" of a run.
%
% 2023-09-30, Yixuan Li
%

function MSE_to_ideal_of_a_run = mean_square_error_to_ideal_v2(theta,ideal_theta)

    delta_theta = my_diff_v2(ideal_theta,theta);
    MSE_to_ideal_of_a_run = sum(delta_theta.^2)/length(theta);
    
end