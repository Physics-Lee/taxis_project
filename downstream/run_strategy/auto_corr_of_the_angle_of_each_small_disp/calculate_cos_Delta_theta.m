function [cos_means, cos_SEMs] = calculate_cos_Delta_theta(theta_cell, max_frame)
n_runs = length(theta_cell);
cos_means = zeros(max_frame, 1);
cos_SEMs = zeros(max_frame, 1);

for df = 1:max_frame
    all_cos_Delta_theta = [];

    for i = 1:n_runs
        theta = theta_cell{i};
        if length(theta) > df
            delta_theta = abs(theta(df+1:end) - theta(1:end-df));
            all_cos_Delta_theta = [all_cos_Delta_theta, cos(delta_theta)];
        end
    end

    cos_means(df) = mean(all_cos_Delta_theta);
    cos_SEMs(df) = std(all_cos_Delta_theta) / sqrt(length(all_cos_Delta_theta));
end
end
