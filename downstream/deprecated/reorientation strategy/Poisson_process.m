clc;clear;close all;

%% upload
[eset,type_of_C_elegans,type_of_taxis] = upload_eset;

%% extract
[run_times, run_lengths] = extract_run_time_run_length(eset);
run_lengths = run_lengths/22; % convert to mm

%% refractory
t_threshold = 5;
run_times_t = screen_run_time(run_times,t_threshold);

%% histogram
% Define the range of bin sizes
bin_sizes = 10:10:100;

% Create the folder for saving the plots
folder_name = fullfile('C:\Users\11097\Desktop\temp',[type_of_C_elegans '_' type_of_taxis '_v2']);
if ~isfolder(folder_name)
    mkdir(folder_name);
end

% Plot and save histograms for each bin size
for i = 1:numel(bin_sizes)
    
    figure;
    histogram(run_times, bin_sizes(i));
    xlabel('Run time (s)');
    ylabel('Count');
    title(sprintf('%s; number of bins = %d', type_of_C_elegans, bin_sizes(i)));
    saveas(gcf, fullfile(folder_name, sprintf('run_time_bin_%d.png', bin_sizes(i))));
    
end

for i = 1:numel(bin_sizes)
    
    figure;
    histogram(run_lengths, bin_sizes(i));
    xlabel('Run Length (mm)');
    ylabel('Count');
    title(sprintf('%s; number of bins = %d', type_of_C_elegans, bin_sizes(i)));
    saveas(gcf, fullfile(folder_name, sprintf('run_length_bin_%d.png', bin_sizes(i))));
    
end

% %% ln
% bin_sizes = 10:10:100;
% 
% folder_name = fullfile('F:\1_learning\work\result of taxi behavior\20230321',[type_of_C_elegans '_' type_of_taxis '_v3']);
% if ~isfolder(folder_name)
%     mkdir(folder_name);
% end
% 
% for i = bin_sizes
%     
%     % Create histogram and calculate log of bin values
%     h = histogram(run_times, i);
%     count_log = log(h.Values);
% 
%     % Create x-axis values
%     x_axis = h.BinEdges(1:end-1) + h.BinWidth/2;
% 
%     % Plot histogram and save figure
%     plot(x_axis, count_log, 'black-o');
%     xlabel('run time with refractory period');
%     ylabel('log(count)');
%     title(str);
%     saveas(gcf, fullfile(folder_name, sprintf('run_time_refractory_log_bin_%d.png', i)));
%     
% end