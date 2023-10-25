% calculate the weighted standard deviation of a certain measure.
%
% 2023-10-25, Yixuan Li
%

function weighted_std = calculate_weighted_std(measure_all)

n_worm = size(measure_all,1);
weighted_std = nan(n_worm,1);
for i = 1:n_worm
    measure = measure_all{i,1};
    x = measure(:,1);
    weight = measure(:,2);
    weighted_average = calculate_the_weighted_average_of_a_random_variable(x, weight);
    weighted_var = calculate_the_weighted_average_of_a_random_variable((x - weighted_average).^2, weight);
    weighted_std(i) = sqrt(weighted_var);
end

end