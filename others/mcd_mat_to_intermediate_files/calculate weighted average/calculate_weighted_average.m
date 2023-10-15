function weighted_average = calculate_weighted_average(measure_all)

% calculate weighted average of a certain measure.

n_exp = length(measure_all);
weighted_average = nan(n_exp,1);
for i = 1:n_exp
    measure = measure_all{i,1};
    x = measure(:,1);
    weight = measure(:,2);
    weighted_average(i) = calculate_weighted_average_v2(x, weight);
end

end