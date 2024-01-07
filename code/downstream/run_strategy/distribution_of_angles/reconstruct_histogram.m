function reconstruct_histogram(hist_count)

% assuming you know the minimum and maximum values of the original data
data_min = 0; % replace with your actual minimum value
data_max = 360; % replace with your actual maximum value
num_bins = length(hist_count); % number of bins

% calculate the width of each bin
bin_width = (data_max - data_min) / num_bins;

% create the bin centers
bin_centers = data_min + bin_width/2 : bin_width : data_max - bin_width/2;

% use the bar function to plot the histogram without gaps
figure;
bar(bin_centers, hist_count, 'BarWidth', 1);

% set the axis labels and title
xlabel("$\theta$",Interpreter="latex");
ylabel("pdf");
xticks((0:2:36) * 10)
ylim([0 6*10^(-3)]);

end