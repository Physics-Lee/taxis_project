function run_theta_vector = extract_run_theta_vector(eset)
run_theta = extract_run_theta(eset);
run_theta_vector = [];
for i = 1:length(run_theta)
    run_theta_vector = [run_theta_vector run_theta{i}];
end
end