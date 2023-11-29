% calculate \theta(t) and \theta(t+\tau) from theta_cell
%
% Yixuan Li, 2023-11-29
%

function [theta_t1,theta_t2] = visualize_X_Y(theta_cell_filted_unwrapped,max_frame)

theta_t1 = [];
theta_t2 = [];

for i = 1:length(theta_cell_filted_unwrapped)
    theta_now = theta_cell_filted_unwrapped{i,1};
    theta_now = rad2deg(theta_now);
    n_theta = length(theta_now);
    theta_t1 = [theta_t1 theta_now(1:n_theta-max_frame)];
    theta_t2 = [theta_t2 theta_now(1+max_frame:n_theta)];
end

end