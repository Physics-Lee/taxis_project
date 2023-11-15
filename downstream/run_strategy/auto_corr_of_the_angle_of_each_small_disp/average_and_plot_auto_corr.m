function acf_averaged = average_and_plot_auto_corr(acf_cell,max_lag,color_str)

% calculate
acf_expanded = cell2mat(acf_cell);
acf_averaged = mean(acf_expanded, 1);
acf_error_bar = std(acf_expanded, 1) / sqrt(length(acf_cell));

% plot
t = (0:max_lag)/2; % s
errorbar(t, acf_averaged, acf_error_bar, color_str);
ylim([-0.2,1]);

end