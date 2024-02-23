function mean_SEM_of_run_time_4_regions = calculate_mean_std_of_run_time(theta_cell_4_region)

mean_SEM_of_run_time_4_regions = nan(4,3);
for i = 1:4
    theta_cell_now = theta_cell_4_region{i};
    run_time = cellfun(@length, theta_cell_now) / 2;
    mean_SEM_of_run_time_4_regions(i,1) = mean(run_time);
    mean_SEM_of_run_time_4_regions(i,2) = std(run_time) / sqrt(length(theta_cell_now));
    mean_SEM_of_run_time_4_regions(i,3) = length(theta_cell_now);
end

end