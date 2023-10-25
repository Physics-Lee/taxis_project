% plot histograms of theta of the whole disp of a run
%
% 2023-10-02, Yixuan Li
%

clc;clear;close all;

%% set bins and ticks
n_bins = 12;
x_ticks_180 = -180:20:180;
x_ticks_360 = 0:20:360;

%% main

% chose the folder to analyze
path = uigetdir;

% if the user choose a folder
if path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path,'run_disp_of_all_tracks.mat');

    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files');

    % if at least 1 file is choosed
    if tf == 1

        % loop to process each file
        for i = indx

            %% plot histograms of f(disp angle)

            % load run disp
            full_path = list{i};
            run_disp = load_data_from_mat(full_path);

            % create a sub-folder for savings
            full_path_of_eset = fileparts(fileparts(full_path));
            save_folder_path = fullfile(full_path_of_eset,'distribution_of_angles');
            create_folder(save_folder_path);

            % init
            n_runs = length(run_disp);
            disp_angle_cell = cell(n_runs,1);

            % loop to calculate disp anlges
            for j = 1:n_runs

                % get points
                points = run_disp{j};

                % only preserve the first and the last point.
                points_new = points(:, [1 end]);

                % calculate disp angle
                [disp_angle_cell{j,1},~,~,~] = from_points_to_theta(points_new);

            end

            % hist
            disp_angle_vector = cell_array_to_numerical_array(disp_angle_cell);
            disp_angle_vector = to_360(disp_angle_vector);
            xlabel_str = 'disp angle';
            title_str = 'f(disp angle)';
            save_full_path = fullfile(save_folder_path, ['f(disp angle)', '.png']);
            y_lim = [0 0.012];
            create_histogram(disp_angle_vector, n_bins, x_ticks_360, xlabel_str, title_str, save_full_path, y_lim);


            close all;

            %% plot histograms of f(disp angle|theta in)

            % get taxis type
            option_taxis = get_taxis_type_by_full_path(full_path);

            % get theta from run disp
            theta_cell = cellfun(@from_points_to_theta, run_disp, 'UniformOutput', false);

            % get theta_in
            theta_in = cellfun(@(x) x(1), theta_cell);

            % get data
            [disp_angle_vector_regions{1:4}] = allocate_angles_to_4_regions(option_taxis,theta_in,disp_angle_cell);

            % plot f(theta|theta in)
            for region = 1:4
                theta_region = disp_angle_vector_regions{region};
                theta_region = to_360(theta_region);
                xlabel_str = 'disp angle';
                title_str = ['$f(disp \ angle|\theta_{in} \ belongs \ to \ region \ ' num2str(region) ')$'];
                save_full_path = fullfile(save_folder_path, ['f(disp angle;theta_in belongs to region ' num2str(region) ')','.png']);
                y_lim = [0 0.012];
                create_histogram(theta_region, n_bins, x_ticks_360, xlabel_str, title_str, save_full_path, y_lim);
            end

            close all;
        end
    end
end

disp('<<<END>>>');