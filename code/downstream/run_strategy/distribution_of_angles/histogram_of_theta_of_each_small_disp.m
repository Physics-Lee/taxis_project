% plot histograms of theta of each small disp of a run
%
% 2023-09-30, Yixuan Li
%

clc;clear;close all;

%% set bins and ticks
n_bins = 36;
x_ticks_360 = 0:20:360;
x_ticks_180 = -180:20:180;

%% main

% chose the folder to analyze
root_folder_path = uigetdir;

% if the user choose a folder
if root_folder_path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(root_folder_path,'run_disp_of_all_*.mat');

    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Choose files');

    % if at least 1 file is choosed
    if tf == 1

        % loop to process each file
        for i = indx
            %% plot histograms of f(theta), f(theta_in), f(theta - theta_in)

            % load run disp
            full_path = list{i};
            run_disp = load_data_from_mat(full_path);

            % create a sub-folder for savings
            full_path_of_eset = fileparts(fileparts(full_path));
            save_folder_path = fullfile(full_path_of_eset,'distribution_of_angles');
            create_folder(save_folder_path);

            % get theta from run disp
            theta_cell = cellfun(@from_points_to_theta, run_disp, 'UniformOutput', false);

            % theta in
            theta_in = cellfun(@(x) x(1), theta_cell);

            %% plot f(theta)

            % calculate theta
            theta_vector = cell_array_to_numerical_array(theta_cell);
            theta_vector = to_360(theta_vector);

            % set parameters
            xlabel_str = '$\theta$';
            title_str = '$f(\theta)$';
            y_lim = [0 0.008];

            % plot f(theta)
            save_file_name = 'f(theta).png';
            save_full_path = fullfile(save_folder_path, save_file_name);
            save_histcount = true;
            create_histogram(theta_vector, n_bins, x_ticks_360, xlabel_str, title_str, save_full_path, y_lim, save_histcount);
            % 
            % % plot f(theta) on semilogy
            % save_file_name = 'f(theta)_semilogy.png';
            % save_full_path = fullfile(save_folder_path, save_file_name);
            % create_histogram_semilogy(theta_vector, n_bins, x_ticks_360, xlabel_str, title_str, save_full_path, y_lim);
            % 
            % %% plot f(theta - theta_in)
            % 
            % % calculate (theta - theta_in)
            % [theta_minus_theta_in_vector,theta_minus_theta_in_cell] = minus_theta_in(theta_cell,theta_in);
            % theta_minus_theta_in_vector = rad2deg(theta_minus_theta_in_vector);
            % 
            % % set parameters
            % xlabel_str = '$\theta - \theta_{in}$';
            % title_str = '$f(\theta - \theta_{in})$';
            % y_lim = [0 0.012];
            % 
            % % plot f(theta - theta_in)
            % save_file_name = 'f(theta-theta_in).png';
            % save_full_path = fullfile(save_folder_path, save_file_name);
            % create_histogram(theta_minus_theta_in_vector, n_bins, x_ticks_180, xlabel_str, title_str, save_full_path, y_lim);
            % 
            % % plot f(theta - theta_in) on semilogy
            % save_file_name = 'f(theta-theta_in)_semilogy.png';
            % save_full_path = fullfile(save_folder_path, save_file_name);
            % create_histogram_semilogy(theta_minus_theta_in_vector, n_bins, x_ticks_180, xlabel_str, title_str, save_full_path, y_lim);
            % 
            % % close
            % close all;
            % 
            % %% plot f(theta|theta in)
            % 
            % % get taxis type
            % option_taxis = get_taxis_type_by_full_path(full_path);
            % 
            % % get data
            % [theta_vector_regions{1:4}] = allocate_angles_to_4_regions(option_taxis,theta_in,theta_cell);
            % 
            % % plot f(theta|theta in)
            % for region = 1:4
            %     theta_region = theta_vector_regions{region};
            %     theta_region = to_360(theta_region);
            %     xlabel_str = '$\theta$';
            %     title_str = ['$f(\theta|\theta_{in} \ belongs \ to \ region \ ' num2str(region) ')$'];
            %     save_full_path = fullfile(save_folder_path, ['f(theta;theta_in belongs to region ' num2str(region) ')','.png']);
            %     y_lim = [0 0.012];
            %     create_histogram(theta_region, n_bins, x_ticks_360, xlabel_str, title_str, save_full_path, y_lim);
            % end
            % 
            % close all;
            % 
            % %% plot f(theta - theta_in|theta in)
            % 
            % % get data
            % [theta_vector_regions{1:4}] = allocate_angles_to_4_regions(option_taxis,theta_in,theta_minus_theta_in_cell);
            % 
            % % plot f(theta - theta_in|theta in)
            % for region = 1:4
            %     theta_region = theta_vector_regions{region};
            %     theta_region = rad2deg(theta_region);
            %     xlabel_str = '$\theta - \theta_{in}$';
            %     title_str = ['$f(\theta - \theta_{in}|\theta_{in} \ belongs \ to \ region \ ' num2str(region) ')$'];
            %     save_full_path = fullfile(save_folder_path, ['f(theta-theta_in;theta_in belongs to region ' num2str(region) ')','.png']);
            %     y_lim = [0 0.012];
            %     create_histogram(theta_region, n_bins, x_ticks_180, xlabel_str, title_str, save_full_path, y_lim);
            % end

            close all;

        end
    end
end

disp('<<<END>>>');