% Change the error-bar from capturing the deviance of branches to
% capturing the deviance of tracks or worms.
%
% You must choose a folder containing a single exp, not multi exps.
%
% 2023-10-03, Yixuan Li
%

dbstop if error;

clc;clear;close all;

data_cell_array = {};

%% if Runhui's NC
is_Runhui_NC = false;

%% choose files to analyze

% chose the folder to analyze
path = uigetdir;

% if the user choose a folder
if path ~= 0

    % get full paths of files
    name_pattern = 'cos___*pi_as_ideal___-pi___mean_of_data___run_disp_of_*';
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path,name_pattern);

    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files');

    % if at least 1 file is choosed
    if tf == 1

        % loop to process each file
        for i = indx

            % load
            full_path = list{i};
            load(full_path);

            % save
            data_cell_array{end+1} = mean_of_data;
        end
    end
end

%% calculate mean and error bar
n_tracks = length(indx);
n_regions = 4;
n_bins = size(data_cell_array{1, 1}{1, 1},2);

% Convert cell arrays to 3D matrix, the size of it is n_tracks * n_regions
% * n_bins
data_3D_array = zeros(n_tracks, n_regions, n_bins);
for i = 1:n_tracks
    for j = 1:n_regions
        if isempty(data_cell_array{i}{j})
            data_3D_array(i, j, :) = nan(n_bins,1);
            why;
        else
            data_3D_array(i, j, :) = data_cell_array{i}{j};
        end
    end
end

mean_values = squeeze(mean(data_3D_array, 1,"omitnan"));
error_bar_values = squeeze(std(data_3D_array, 0, 1,"omitnan"));

% use n_drop_nan to calculate SEM
n_drop_nan_save = zeros(n_regions,n_bins);
for i = 1:n_regions
    for j = 1:n_bins
        data_now = data_3D_array(:,i,j);
        n_drop_nan = sum(~isnan(data_now));
        error_bar_values(i,j) = error_bar_values(i,j) / n_drop_nan;

        n_drop_nan_save(i,j) = n_drop_nan;
    end
end

%% plot
step_size = 30/n_bins;
x = 0:step_size:30 - step_size;
custom_colors = [0 0 1; 0 1 1; 0 0 0; 1 0 0]; % blue-cyan-black-red
for j = 1:4
    errorbar(x,mean_values(j,:),error_bar_values(j,:),'Color',custom_colors(j,:)); % core
    hold on;
end

% add label
xlabel('run length (mm)', 'FontSize', 14);
ylabel('<cos \theta>', 'FontSize', 14);

% add title
title_str = sprintf("n tracks = %d",n_tracks);
title(title_str);

% add lim
xlim([0.2,2]);
ylim([0,1]);

% add legend
option_taxis = get_taxis_type_by_full_path(full_path);
switch option_taxis
    case {"NC","NT","Pa"}
        option_partition_region = "-pi_as_ideal";
    case {"Ctl"}
        option_partition_region = "-3/4*pi_as_ideal";
    case {"Or"}
        option_partition_region = "-3/4*pi_as_ideal";
end

% you can change partition region here if you like
if is_Runhui_NC
    option_partition_region = "-1/2*pi_as_ideal"; % special for Runhui's data
end

add_legend(option_partition_region);

% save
save_folder_path = fileparts(full_path);
save_folder_path = fileparts(save_folder_path);
save_folder_path = fullfile(save_folder_path,'persistent_length_error_bar_for_tracks');
create_folder(save_folder_path);
save_file_name = 'error_bar_for_different_tracks';
save_full_path = fullfile(save_folder_path,save_file_name);
saveas(gcf,save_full_path,'fig');
saveas(gcf,save_full_path,'png');

% % semilogy
% errorbar_semilogy;
% save_file_name = 'error_bar_for_different_tracks_semilogy';
% save_full_path = fullfile(save_folder_path,save_file_name);
% saveas(gcf,save_full_path,'png');
%
% % loglog
% errorbar_loglog;
% save_file_name = 'error_bar_for_different_tracks_loglog';
% save_full_path = fullfile(save_folder_path,save_file_name);
% saveas(gcf,save_full_path,'png');

% close
close;

% %% plot histogram for a single point capturing deviation for worms/tracks
% for x_critical = [0.5 1 2] % mm
%     figure;
%     for i = 1:n_regions
%         if i > 4
%             % Stop if we have more than 4 regions since we're plotting only a 2x2 grid
%             break;
%         end
%
%         % plot
%         subplot(2,2,i);
%         test = data_3D_array(:,i,round(x_critical/step_size));
%         histogram(test);
%         xlabel('$cos(\theta)$', 'Interpreter', 'latex');
%         ylabel('count');
%         title(from_index_to_color(i));
%         xlim([-1 +1]);
%     end
%
%     % save
%     save_folder_path_new = fullfile(save_folder_path,'histogram of a single point in persistent lenght with error bar for branches');
%     create_folder(save_folder_path_new);
%     save_file_name = [num2str(x_critical) 'mm.png'];
%     save_full_path = fullfile(save_folder_path_new,save_file_name);
%     saveas(gcf,save_full_path,'png');
%     close;
% end

% disp end
disp('<<<END>>>');