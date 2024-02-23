function region_flags = screened_by_std_to_mean(region_flags,theta_cell,std2mean)

n_runs = length(theta_cell);
region_flags_new = region_flags;
for i = 1:n_runs
    if ~isnan(region_flags(i))
        theta_now = theta_cell{i}; 
        if std(theta_now) / mean(theta_now) < std2mean
            region_flags_new(i) = nan; 
        end
    end
end

disp(sum(region_flags_new ~= region_flags) / n_runs)

end