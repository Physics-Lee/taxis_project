% calculate b of Least Square of angle data
%
% Yixuan Li, 2023-11-29
%

function [b, b_mean, b_std] = calculate_b(theta_cell, max_frame)

max_frame = max_frame - 10; % make sure you at least have 10 points to calculate Pearson r

n_runs = length(theta_cell);
b = zeros(n_runs, max_frame);

for i = 1:n_runs
    theta = theta_cell{i};

    for tau = 1:max_frame
        theta_t = theta(1:end-tau);
        theta_tau = theta(tau+1:end);

        % Calculating
        p = polyfit(theta_t, theta_tau, 1);
        b(i, tau) = p(1);
    end
end

b_mean = mean(b, 1);
b_std = std(b, 0, 1);
end