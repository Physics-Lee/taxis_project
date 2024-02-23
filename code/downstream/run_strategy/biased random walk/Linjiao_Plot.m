function Linjiao_Plot(mean_SEM_of_run_time_4_regions)

% Extract mean, SEM, and N from the array
means = mean_SEM_of_run_time_4_regions(:, 1);
sems = mean_SEM_of_run_time_4_regions(:, 2);
Ns = mean_SEM_of_run_time_4_regions(:, 3);

% Create the bar plot for means
figure; % Open a new figure window
bar(means, 'FaceColor', [0.2, 0.2, 0.5]); % Customize color as needed
hold on; % Hold on to add error bars

% Calculate the x positions for the error bars
x = 1:length(means);

% Add error bars for SEM
errorbar(x, means, sems, 'k', 'linestyle', 'none');

% Annotate each bar with the N value
for i = 1:length(Ns)
    text(x(i), means(i), sprintf('N=%d', Ns(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
end

% Customize the plot
xlabel('Region'); % or specific group names if applicable
ylabel('Run Time (s)');
title('Mean and SEM for 4 Groups');
set(gca, 'XTick', 1:4); % Assuming 4 groups
% Optional: set custom group names
% set(gca, 'XTickLabel', {'Group 1', 'Group 2', 'Group 3', 'Group 4'});

hold off; % Release the hold

end