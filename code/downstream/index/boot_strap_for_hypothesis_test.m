% use bootstrap and permutation test to replace t-test when processing
% index
%
% 2023-12-28, Yixuan Li
%

function boot_strap_for_hypothesis_test(control_group, test_group, n_bootstrap_samples)

% Combine the data
combined_data = [control_group; test_group];

% Initialize array to store differences
mean_differences = zeros(n_bootstrap_samples, 1);

% Size of each group
size_control = size(control_group, 1);
size_test = size(test_group, 1);
size_all = size_control + size_test;

% Actual difference in weighted means
actual_diff = weighted_mean(control_group) - weighted_mean(test_group);

% Bootstrap loop
for i = 1:n_bootstrap_samples

    % Shuffle combined data
    bootstrap_all = combined_data(randi(size_all, size_all, 1), :);

    % Split into new groups
    new_control = bootstrap_all(1:size_control, :);
    new_test = bootstrap_all(size_control+1:end, :);

    % Calculate weighted means
    mean_control = weighted_mean(new_control);
    mean_test = weighted_mean(new_test);

    % Store the difference
    mean_differences(i) = mean_control - mean_test;
end

% Calculate p-value
p_value = sum(abs(mean_differences) >= abs(actual_diff)) / n_bootstrap_samples;

% plot
bar_plot_with_p_value_for_index(control_group,test_group,p_value);

end