function [theta_in,theta_out,Delta_theta] = calculate_Delta_theta_of_reorientation(run_disp)

% init
n = length(run_disp);
theta_in = nan(n,1);
theta_out = nan(n,1);
Delta_theta = nan(n - 1,1);

% for loop
for i = 1:n
    points = run_disp{i};
    [theta,~,~,~] = from_points_to_theta(points);
    theta_in(i) = theta(1);
    theta_out(i) = theta(end);
end

for i = 1:n - 1
    Delta_theta(i) = my_diff(theta_out(i),theta_in(i + 1));
end

end