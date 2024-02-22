% explore active sampling
%
% 2024-02-17, Yixuan Li
%

clc;clear;close all;

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

            % load run disp
            full_path = list{i};
            run_disp = load_data_from_mat(full_path);

            % create a sub-folder for savings
            full_path_of_eset = fileparts(fileparts(full_path));
            save_folder_path = fullfile(full_path_of_eset,'active_sampling');
            create_folder(save_folder_path);

            % get theta from run disp
            theta_cell = cellfun(@from_points_to_theta, run_disp, 'UniformOutput', false);
            n_frame = 1;
            Delta_theta_cell = calculate_Delta_theta_between_n_frames(theta_cell, n_frame);
            theta_vector = cell_array_to_numerical_array_after_drop_n_frames(theta_cell, n_frame);
            Delta_theta_vector = cell_array_to_numerical_array(Delta_theta_cell);
            theta_vector = rad_to_360(theta_vector);
            Delta_theta_vector = rad2deg(Delta_theta_vector);

            figure;
            scatter(theta_vector,Delta_theta_vector);
            xlabel("$\theta$",Interpreter="latex");
            ylabel("$\mathrm{d} \theta$",Interpreter="latex");
            xlim([0 +360]);
            ylim([-20 +20]);
            saveas(gcf,fullfile(save_folder_path,"scatter_plot"),"png");

            % plot heatmap
            plot_heatmap_of_theta_and_Dtheta(theta_vector, Delta_theta_vector);
            saveas(gcf,fullfile(save_folder_path,"heatmap"),"png");

            plot_heatmap_of_theta_and_Dtheta_normalized(theta_vector, Delta_theta_vector);
            saveas(gcf,fullfile(save_folder_path,"heatmap_normalized"),"png");

            close all;
        end
    end
end

disp('<<<END>>>');