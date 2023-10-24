% plot histograms of the first theta of a run
%
% 2023-10-02, Yixuan Li
%

clc;clear;close all;

%% set bins and ticks
n_bins = 12;
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

            % load run disp
            full_path = list{i};
            load(full_path);

            % create a sub-folder for savings
            full_path_of_eset = fileparts(fileparts(full_path));
            save_folder_path = fullfile(full_path_of_eset,'distribution_of_angles');
            create_folder(save_folder_path);

            % get theta from run disp
            theta_cell = cellfun(@from_points_to_theta, run_disp, 'UniformOutput', false);

            % theta in
            theta_in = cellfun(@(x) x(1), theta_cell);
            theta_in_360 = to_360(theta_in);
            xlabel_str = '$\theta_{in}$';
            title_str = '$f(\theta_{in})$';
            save_full_path = fullfile(save_folder_path, ['f(theta_in)', '.png']);
            y_lim = [0 0.005];
            create_histogram(theta_in_360, n_bins, x_ticks_360, xlabel_str, title_str, save_full_path, y_lim);

            close all;
        end
    end
end