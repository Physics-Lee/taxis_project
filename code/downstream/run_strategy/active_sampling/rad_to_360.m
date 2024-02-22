function run_theta_vector = rad_to_360(run_theta_vector)

run_theta_vector = run_theta_vector/pi*180;
mask = run_theta_vector < 0;
run_theta_vector(mask) = run_theta_vector(mask) + 2*180;

end