function mean_SEM_of_run_length_4_regions = calculate_mean_std_of_run_length(run_length_cell_4_region)

mean_SEM_of_run_length_4_regions = nan(4,3);
for i = 1:4
    run_length_now = cell2mat(run_length_cell_4_region{i});
    mean_SEM_of_run_length_4_regions(i,1) = mean(run_length_now);
    mean_SEM_of_run_length_4_regions(i,2) = std(run_length_now) / sqrt(length(run_length_now));
    mean_SEM_of_run_length_4_regions(i,3) = length(run_length_now);
end

end