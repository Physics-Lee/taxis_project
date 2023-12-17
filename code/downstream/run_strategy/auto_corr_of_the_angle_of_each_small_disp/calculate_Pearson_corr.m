% calculate Pearson-Corr of angle data
%
% Yixuan Li, 2023-11-29
%

function [r, r_mean, r_std] = calculate_Pearson_corr(theta_cell, max_frame)

max_frame = max_frame - 10; % make sure you at least have 10 points to calculate Pearson r

n_runs = length(theta_cell);
r = zeros(n_runs, max_frame);

for i = 1:n_runs
    theta = theta_cell{i};

    for tau = 1:max_frame
        theta_t = theta(1:end-tau);
        theta_tau = theta(tau+1:end);

        % Calculating
        r_matrix = corrcoef(theta_t,theta_tau);
        r(i, tau) = r_matrix(1,2);
    end
end

r_mean = mean(r, 1);
r_std = std(r, 0, 1);
end