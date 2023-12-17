% draw the symmetric error-bar plot on semilogy for 4 regions.
%
% mean_values, error_bar_values should be 4*n while custom_colors should be
% 4*3 with each row indicating colors.
%
% 2023-10-10, Yixuan Li
%

function errorbar_semilogy_symmetric(x, mean_values, error_bar_values, custom_colors)
figure;

for j = 1:size(mean_values, 1)
    % Calculate logarithmically adjusted error bars
    upper_error = mean_values(j,:) .* (1 + error_bar_values(j,:)./mean_values(j,:));
    lower_error = mean_values(j,:) ./ (1 + error_bar_values(j,:)./mean_values(j,:));

    % Plot the data
    semilogy(x, mean_values(j,:), 'o', 'Color', custom_colors(j,:));
    hold on;

    % Plot the error bars
    line([x; x], [lower_error; upper_error], 'Color', custom_colors(j,:));
end
set(gca, 'YScale', 'log');
end
