% Split path length into small bins and calculate mean and SEM 
% in each small bin of path length.
%
% If a bin contains no data, the mean and SEM will be NaN.
%
% 2023-09-26, Yixuan Li
%

function [x,mean_of_data,error_bar_of_data,counts] = averaged_correlation(path_length,measure)


%% for saving histograms
global folder_path_of_eset;

%% split x axis into small bins
n_bins = 500; % super-parameter
[path_length_sorted, sort_index] = sort(path_length);
x_start = 0; % mm
x_end = 30; % mm
step_size = (x_end-x_start)/n_bins;
% x = x_start + step_size/2 : step_size : x_end - step_size/2; % for hist
x = x_start : step_size : x_end; % for histcounts

%% get counts for all bins
[counts, ~] = histcounts(path_length_sorted, x);

%% vectorized processing of each bin

% init
mean_of_data = zeros(1, n_bins);
error_bar_of_data = zeros(1, n_bins);
cum_counts = [0 cumsum(counts)];  % create cumulative counts for indexing

% distribution contains more information than just mean and variance
d = [0.5 1 2]; % mm
n = floor(d/step_size);

% loop to process each bin
for i = 1:n_bins

    % get the measure for the current bin
    r = measure(sort_index(cum_counts(i)+1:cum_counts(i+1)));

    % % distribution
    % if ismember(i,n)
    %     figure;
    %     histogram(r);
    %     save_file_name = num2str(i);
    %     save_file_name = add_date_and_time(save_file_name);
    %     save_folder_path_new = fullfile(folder_path_of_eset,'histogram of a single point in persistent lenght with error bar for branches');
    %     create_folder(save_folder_path_new);
    %     save_full_path = fullfile(save_folder_path_new,save_file_name);
    %     saveas(gcf,save_full_path,'png');
    %     close;
    % end

    % mean and error-bar
    mean_of_data(i) = mean(r);
    error_bar_of_data(i) = std(r)/sqrt(counts(i));

end

end