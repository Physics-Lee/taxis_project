% calculate the weighted average of a certain measure.
%
% 2023-10-25, Yixuan Li
%

function weighted_average = calculate_weighted_average(measure_cell)

n_sample = size(measure_cell,1);
weighted_average = nan(n_sample,1);
for i = 1:n_sample
    measure = measure_cell{i,1};
    x = measure(:,1);
    weight = measure(:,2);
    weighted_average(i) = calculate_the_weighted_average_of_a_random_variable(x, weight);
end

end