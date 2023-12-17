% [-pi,+pi] to [0,360]
%
% 2023-09-30, Yixuan Li
%

function run_theta_vector = to_360(run_theta_vector)

run_theta_vector = run_theta_vector/pi*180;
mask = run_theta_vector < 0;
run_theta_vector(mask) = run_theta_vector(mask) + 2*180;

end