function [cos_mean, cos_std, cos_mean_mean, cos_mean_std, cos_std_mean, cos_std_std]...
    = calculate_cos_Delta_theta(theta_cell, max_frame)
n_runs = length(theta_cell);
cos_mean = zeros(n_runs, max_frame);
cos_std = zeros(n_runs, max_frame);

for i = 1:n_runs
    theta = theta_cell{i};

    for df = 1:max_frame
        delta_theta = abs(theta(df+1:end) - theta(1:end-df));
        cos_delta_theta = cos(delta_theta);
        cos_mean(i, df) = mean(cos_delta_theta);
        cos_std(i, df) = std(cos_delta_theta);
    end
end

cos_mean_mean = mean(cos_mean, 1);
cos_mean_std = std(cos_mean, 0, 1);
cos_std_mean = mean(cos_std, 1);
cos_std_std = std(cos_std, 0, 1);
end