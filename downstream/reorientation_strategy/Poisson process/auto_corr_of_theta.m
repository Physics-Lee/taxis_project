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
            save_folder_path = fullfile(folder_path_to_eset,'auto_corr_of_theta_of_each_small_disp_of_runs');
            create_folder(save_folder_path);

            % main
            for max_frame = 20:20:100

                %% get theta
                logical_index_run_disp = cellfun(@(x) size(x, 2) > max_frame, run_disp);
                run_disp_filted = run_disp(logical_index_run_disp);
                theta_cell = cellfun(@from_points_to_theta, run_disp_filted, 'UniformOutput', false);
                logical_index_theta = cellfun(@(x) size(x, 2) > max_frame, theta_cell);
                theta_cell_filted = theta_cell(logical_index_theta);

                %% auto-corr
                max_lag = max_frame - 1; % frames
                acf_cell = cellfun(@(x) autocorr(x, max_lag), theta_cell_filted, 'UniformOutput', false);
                matrix_acf = cell2mat(acf_cell);
                average_acf = mean(matrix_acf, 1);
                t = (0:max_lag)/2; % s

                figure;
                hold on;
                plot(t, average_acf, 'blue-o');
                xlabel('t (s)');
                ylabel('auto correlation');
                title('auto corr of theta of each small disp of runs');
                subtitle(sprintf('percentage of remaining runs: %.2f',length(run_disp_filted)/length(run_disp)));
            end

            save_all_figs(save_folder_path);

            pause(1);

            close all;
        end
    end
end