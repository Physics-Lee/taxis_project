% calculate the weighted average of a certain measure.
%
% 2023-10-25, Yixuan Li
%

function weighted_average = calculate_weighted_average(measure_all)

n_worm = size(measure_all,1);
weighted_average = nan(n_worm,1);
for i = 1:n_worm
    measure = measure_all{i,1};
    x = measure(:,1);
    weight = measure(:,2);
    weighted_average(i) = calculate_the_weighted_average_of_a_random_variable(x, weight);
end

end