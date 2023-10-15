function [theta_in,theta_out,delta_theta] = calculate_delta_theta(run_disp_all)

% init
n = length(run_disp_all);
theta_in = nan(n,1);
theta_out = nan(n,1);
delta_theta = nan(n - 1,1);

% for loop
for i = 1:n
    points = run_disp_all{i};
    v_direction = (points(:, 2:end) - points(:, 1:end - 1)); % disp vectors
    path_length = sqrt(sum(v_direction.^2,1)); % length of disp vectors
    v_norm = v_direction./repmat(path_length,2,1); % normalized disp vectors
    theta = atan2(v_norm(2, :), v_norm(1, :));
    theta_in(i) = theta(1);
    theta_out(i) = theta(end);
end

for i = 1:n - 1
    delta_theta(i) = my_diff(theta_out(i),theta_in(i + 1));
end

end