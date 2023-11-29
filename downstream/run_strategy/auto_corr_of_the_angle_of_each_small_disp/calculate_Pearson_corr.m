% calculate Pearson-Corr of angle data
%
% Yixuan Li, 2023-11-29
%

function [r, r_mean, r_std] = calculate_Pearson_corr(theta_cell, max_frame)
n_runs = length(theta_cell);
r = zeros(n_runs, max_frame);

for i = 1:n_runs
    theta = theta_cell{i};

    for tau = 1:max_frame
        theta_t = theta(1:end-tau);
        theta_tau = theta(tau+1:end);

        % Calculating Pearson correlation
        mean_theta_t = mean(theta_t);
        mean_theta_tau = mean(theta_tau);
        covariance = sum((theta_t - mean_theta_t) .* (theta_tau - mean_theta_tau));
        standard_deviation = sqrt(sum((theta_t - mean_theta_t).^2) * sum((theta_tau - mean_theta_tau).^2));
        r(i, tau) = covariance / standard_deviation;
    end
end

r_mean = mean(r, 1);
r_std = std(r, 0, 1);
end