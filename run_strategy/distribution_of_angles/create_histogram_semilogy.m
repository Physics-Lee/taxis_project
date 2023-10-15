% plot the histogram and then save it
%
% the 2nd input can be n_edges or n_bins
%
% scale: linear for x, log for y
%
% 2023-10-13, Yixuan Li
%

function create_histogram_semilogy(data, n_edges,~, xlabel_str, title_str, full_path, y_lim)

% Divide data into positive and negative subsets
data_pos = data(data >= 0); % Consider non-negative values as positive
data_neg = abs(data(data < 0)); % Take the absolute value for the negative data

% Compute bin counts and bin edges for positive and negative data
[bin_counts_pos, bin_edges_pos] = histcounts(data_pos, n_edges, 'Normalization', 'pdf');
[bin_counts_neg, bin_edges_neg] = histcounts(data_neg, n_edges, 'Normalization', 'pdf');

% Compute bin centers from bin edges for plotting
bin_centers_pos = (bin_edges_pos(1:end-1) + bin_edges_pos(2:end)) / 2;
bin_centers_neg = (bin_edges_neg(1:end-1) + bin_edges_neg(2:end)) / 2;

% drop negative value
bin_counts_pos = bin_counts_pos(bin_centers_pos>0);
bin_counts_neg = bin_counts_neg(bin_centers_neg>0);
bin_centers_pos = bin_centers_pos(bin_centers_pos>0);
bin_centers_neg = bin_centers_neg(bin_centers_neg>0);

figure;

% Plot for positive values in blue
plot(bin_centers_pos, bin_counts_pos, 'b-o', 'LineWidth', 2);
hold on;

% Plot for (absolute) negative values in red
plot(bin_centers_neg, bin_counts_neg, 'r-o', 'LineWidth', 2);

xlabel(xlabel_str, 'Interpreter', 'latex');
ylabel('probability density function');
title(title_str, 'Interpreter', 'latex');
% ylim(y_lim);

% Set y axis to logarithmic scales
set(gca, 'YScale', 'log');

saveas(gcf, full_path);

end
