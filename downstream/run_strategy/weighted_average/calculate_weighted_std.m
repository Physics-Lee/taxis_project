function weighted_std = calculate_weighted_std(measure_all)

% calculate weighted standard deviation of a certain measure.

n_exp = length(measure_all);
weighted_std = nan(n_exp,1);
for i = 1:n_exp
    measure = measure_all{i,1};
    x = measure(:,1);
    weight = measure(:,2);
    weighted_average = calculate_weighted_average_v2(x, weight);
    weighted_var = calculate_weighted_average_v2((x - weighted_average).^2, weight);
    weighted_std(i) = sqrt(weighted_var);
end

end