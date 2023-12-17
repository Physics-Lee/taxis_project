% calculate the weighted SEM of a certain measure.
%
% 2023-10-30, Yixuan Li
%

function weighted_SEM = calculate_weighted_SEM(measure_cell)

n_sample = size(measure_cell,1);
weighted_SEM = nan(n_sample,1);
for i = 1:n_sample
    measure = measure_cell{i,1};
    x = measure(:,1);
    weight = measure(:,2);
    weighted_average = calculate_the_weighted_average_of_a_random_variable(x, weight);
    weighted_var = calculate_the_weighted_average_of_a_random_variable((x - weighted_average).^2, weight);
    weighted_std = sqrt(weighted_var);
    weighted_SEM(i) = weighted_std / n_sample;
end

end