clc;clear;close all;

%% load

% chose the folder to analyze
path = uigetdir;

% if the user choose a folder
if path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path,'run_disp_of_all_*.mat');

    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files');

    % if at least 1 file is choosed
    if tf==1

        % loop to process each file
        for i = indx

            % load
            full_path = list{i};
            run_disp = load_data_from_mat(full_path);

            % create save folder
            folder_path_to_eset = fileparts(fileparts(full_path));
            save_folder_path = fullfile(folder_path_to_eset,'cos_Delta_theta');
            create_folder(save_folder_path);

            % main
            for max_frame = 20:20:100

                %% get theta
                logical_index_run_disp = cellfun(@(x) size(x, 2) > max_frame, run_disp);
                run_disp_filted = run_disp(logical_index_run_disp);
                theta_cell = cellfun(@from_points_to_theta, run_disp_filted, 'UniformOutput', false);
                logical_index_theta = cellfun(@(x) size(x, 2) > max_frame, theta_cell);
                theta_cell_filted = theta_cell(logical_index_theta);

                %% Calculate Delta theta
                [cos_means, cos_SEMs] = calculate_cos_Delta_theta(theta_cell, max_frame);

                %% plot
                figure;
                errorbar(1:max_frame, cos_means, cos_SEMs);
                xlabel('Delta Frame');
                ylabel('$<cos(\Delta \theta)>$',Interpreter='latex');
                title('Error Bar for Runs');
                subtitle(sprintf('percentage of remaining runs: %.2f',length(run_disp_filted)/length(run_disp)));
                ylim([0,1]);

                %% save
                save_file_name = sprintf("max_frame_%d",max_frame);
                save_full_path = fullfile(save_folder_path,save_file_name);
                saveas(gcf,save_full_path,'png');
                close all;
            end
        end
    end
end