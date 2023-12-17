% plot the histogram of a single point capturing the deviation of runs
%
% 2023-10-30, Yixuan Li
%

function histogram_of_a_single_point_capturing_deviation_of_runs(measure,...
    option_measure,folder_path_to_eset,run_number)

% plot
figure;
n_bins = ceil(length(measure(:,1))/5);
histogram(measure(:,1),n_bins);

% label, title
ylabel('count');
title(['distribution of ' char(option_measure)]);
subtitle('distribution of a single point capturing the deviation of runs');

% save
save_folder_name_1 = "weighted_average";
save_folder_name_2 = option_measure;
save_folder_path = fullfile(folder_path_to_eset,save_folder_name_1,save_folder_name_2);
create_folder(save_folder_path);
save_file_name = sprintf('run_%d',run_number);
save_full_path = fullfile(save_folder_path,save_file_name);
saveas(gcf,save_full_path,'png');
close;

end