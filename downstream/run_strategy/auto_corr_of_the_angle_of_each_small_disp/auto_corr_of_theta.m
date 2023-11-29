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
            save_folder_path = fullfile(folder_path_to_eset,'auto_corr_of_theta_of_each_small_disp_of_runs_unit_vector_method');
            create_folder(save_folder_path);

            % main
            for max_frame = 20:20:100

                %% get theta
                logical_index_run_disp = cellfun(@(x) size(x, 2) > max_frame, run_disp);
                run_disp_filted = run_disp(logical_index_run_disp);
                theta_cell = cellfun(@from_points_to_theta, run_disp_filted, 'UniformOutput', false);
                logical_index_theta = cellfun(@(x) size(x, 2) > max_frame, theta_cell);
                theta_cell_filted = theta_cell(logical_index_theta);
                theta_cell_filted_unwrapped = cellfun(@unwrap, theta_cell_filted, 'UniformOutput', false);

                %% auto-corr
                max_lag = max_frame - 1;

                % method 1                
                % acf_cell = cellfun(@(x) autocorr(x, max_lag), theta_cell_filted_unwrapped, 'UniformOutput', false);

                % method 2
                unit_vector_cell = cellfun(@(x) [cos(x); sin(x)], theta_cell_filted_unwrapped, 'UniformOutput', false);
                acf_cell = cellfun(@(x) dot_product_autocorr(x, max_lag), unit_vector_cell, 'UniformOutput', false);

                % plot
                figure;
                hold on;
                xlabel('t (s)');
                ylabel('auto correlation');
                title('Error Bar for Runs');
                subtitle(sprintf('percentage of remaining runs: %.2f',length(run_disp_filted)/length(run_disp)));
                average_and_plot_auto_corr(acf_cell,max_lag,'blue');
                ylim([0,1]);
                save_file_name = sprintf("max_frame_%d",max_frame);

                % save
                save_full_path = fullfile(save_folder_path,save_file_name);
                saveas(gcf,save_full_path,'png');

                %% auto-corr of 4 regions

                % get taxis type
                option_taxis = get_taxis_type_by_full_path(full_path);

                % get theta_in
                theta_in = cellfun(@(x) x(1), theta_cell_filted);

                % get auto-corr | theta in
                [acf_cell_regions{1:4}] = allocate_angles_to_4_regions_and_remain_cell_array(option_taxis,theta_in,acf_cell);

                % plot

                color_strings = {'black', 'red', 'blue', 'cyan'};

                figure;
                hold on;
                xlabel('t (s)');
                ylabel('auto correlation');
                title('Error Bar for Runs');
                subtitle(sprintf('percentage of remaining runs: %.2f',length(run_disp_filted)/length(run_disp)));

                % Loop for plotting
                for j = 1:4
                    average_and_plot_auto_corr(acf_cell_regions{j}, max_lag, color_strings{j});
                end

                legend('region 1','region 2','region 3','region 4');
                save_file_name = strcat(sprintf("max_frame_%d",max_frame),'_of_4_regions');
                save_full_path = fullfile(save_folder_path, save_file_name);
                saveas(gcf, save_full_path, 'png');

                close all;
            end
        end
    end
end