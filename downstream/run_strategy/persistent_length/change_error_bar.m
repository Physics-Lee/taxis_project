% Change the error-bar from capturing the deviance of branches to
% capturing the deviance of tracks or worms.
%
% You must choose a folder containing a single exp, not multi exps.
%
% option_measure: "cos", "Delta_cos_Delta_theta_v2"
%
% 2023-10-03, Yixuan Li
%

dbstop if error;

clc;clear;close all;

data_cell_array = {};

%% if Runhui's NC
is_Runhui_NC = false;

%% choose measure
option_measure = "cos";

%% choose files to analyze

% chose the folder to analyze
path = uigetdir;

% if the user choose a folder
if path ~= 0

    % get full paths of files
    switch option_measure
        case "cos"
            name_pattern = 'cos___*___*___mean_of_data___run_disp_of_*';
        case "Delta_cos_Delta_theta_v2"
            name_pattern = 'Delta_cos_Delta_theta_v2___-3_4_pi_as_ideal___-3_4_pi___mean_of_data___run_disp_of_*';
    end
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
    xlabel('run length (mm)');

    % add title
    title_str = sprintf("n tracks = %d",n_tracks);
    title(title_str);

    % add lim
    xlim([0.2,2]);

    switch option_measure
        case "cos"
            ylim([0,1]);
            ylabel('$<cos(\Delta \theta)>$','Interpreter','latex');
        case "Delta_cos_Delta_theta_v2"
            ylim([-1,1]);
            ylabel('$<\Delta cos (\Delta \theta)>$','Interpreter','latex');
    end

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

    if contains(full_path,'first_half_of_a_run')
        save_folder_path = fullfile(save_folder_path,'first_half_of_a_run');
    elseif contains(full_path,'second_half_of_a_run')
        save_folder_path = fullfile(save_folder_path,'second_half_of_a_run');
    elseif contains(full_path,'first_half_of_an_exp')
        save_folder_path = fullfile(save_folder_path,'first_half_of_an_exp');
    elseif contains(full_path,'second_half_of_an_exp')
        save_folder_path = fullfile(save_folder_path,'second_half_of_an_exp');
    end
    
    create_folder(save_folder_path);
    save_file_name = strcat('error_bar_for_different_tracks','_',option_measure);
    save_full_path = fullfile(save_folder_path,save_file_name);
    saveas(gcf,save_full_path,'fig');
    saveas(gcf,save_full_path,'png');

    % close
    close;
end

% disp end
disp('<<<END>>>');