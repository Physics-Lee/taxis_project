% Plot the histogram of Delta theta between certain frames
%
% Here, the histogram implys exponential distribution.
%
% 2023-09-30, Yixuan Li
%

clc;clear;close all;

%% set bins and ticks
n_frame = 40;
switch n_frame
    case 1
        n_bins = 36 * 10;
        x_limit = 20;
        y_lim = [0 0.10];
    case 20
        n_bins = 36;
        x_limit = 180;
        y_lim = [0 0.02];
    case 40
        n_bins = 36;
        x_limit = 180;
        y_lim = [0 0.012];
    case {100,200,400}
        n_bins = 36;
        x_limit = 180;
        y_lim = [0 0.010];
end
n_edges = [-x_limit -x_limit : 360 / n_bins : x_limit x_limit];
x_ticks = -x_limit : 360 / n_bins * 2 : x_limit;

%% define labels and titles
xlabel_str = ['$\Delta \theta \ between \ ' num2str(n_frame) ' \ frame$'];
title_str = ['f(' xlabel_str ')'];

%% main

% chose the folder to analyze
path = uigetdir;

% if the user choose a folder
if path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path,'run_disp_of_all_*.mat');

    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files');

    % if at least 1 file is choosed
    if tf == 1

        % loop to process each file
        for i = indx

            %% f(Delta theta)

            % load run disp
            full_path = list{i};
            run_disp = load_data_from_mat(full_path);

            % create a sub-folder for savings
            full_path_of_eset = fileparts(fileparts(full_path));
            save_folder_path = fullfile(full_path_of_eset,'distribution_of_angles');
            create_folder(save_folder_path);

            % get theta from run disp
            theta_cell = cellfun(@from_points_to_theta, run_disp, 'UniformOutput', false);

            % calculate delta theta
            Delta_theta_cell = calculate_Delta_theta_between_n_frames(theta_cell, n_frame);

            % convert cell array to numerical array.
            Delta_theta_vector = cell_array_to_numerical_array(Delta_theta_cell);

            % convert rad to deg
            Delta_theta_vector = rad2deg(Delta_theta_vector);

            % plot f(delta theta)
            save_file_name = sprintf("f(Delta theta of %d frames).png",n_frame);
            save_full_path = fullfile(save_folder_path, save_file_name);
            create_histogram(Delta_theta_vector, n_edges, x_ticks, xlabel_str, title_str, save_full_path, y_lim);

            % plot f(delta theta) on semilogy
            save_file_name = sprintf("f(Delta theta of %d frames)_semilogy.png",n_frame);
            save_full_path = fullfile(save_folder_path, save_file_name);
            create_histogram_semilogy(Delta_theta_vector, n_edges, x_ticks, xlabel_str, title_str, save_full_path, y_lim);

            %% f(Delta theta|theta in)

            % get taxis type
            option_taxis = get_taxis_type_by_full_path(full_path);

            % get theta_in
            theta_in = cellfun(@(x) x(1), theta_cell);

            % get Delta theta | theta in
            [Delta_theta_regions{1:4}] = allocate_angles_to_4_regions(option_taxis,theta_in,Delta_theta_cell);

            % plot f(Delta theta|theta in)
            for region = 1:4
                delta_theta_region = Delta_theta_regions{region};
                delta_theta_region = delta_theta_region / pi * 180;
                region_title = ['$f(\Delta \theta \ between \ ' num2str(n_frame) ' \ frame|\theta_{in} \ belongs \ to \ region \ ' num2str(region) ')$'];
                save_full_path = fullfile(save_folder_path, sprintf('f(Delta theta of %d frames;theta_in belongs to region %d).png',n_frame,region));
                create_histogram(delta_theta_region, n_edges, x_ticks, xlabel_str, region_title, save_full_path, y_lim);
            end

            close all;

        end
    end
end

disp('<<<END>>>');