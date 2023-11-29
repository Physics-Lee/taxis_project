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
            save_folder_path = fullfile(folder_path_to_eset,'Pearson_Corr');
            % save_folder_path = fullfile(folder_path_to_eset,'cos_Delta_theta');
            % save_folder_path = fullfile(save_folder_path,'to see variance within a run');
            % save_folder_path = fullfile(save_folder_path,'std within a run vs std of runs');
            create_folder(save_folder_path);

            % main
            for max_frame = 20:20:200

                %% get theta
                logical_index_run_disp = cellfun(@(x) size(x, 2) > max_frame, run_disp);
                run_disp_filted = run_disp(logical_index_run_disp);
                theta_cell = cellfun(@from_points_to_theta, run_disp_filted, 'UniformOutput', false);
                logical_index_theta = cellfun(@(x) size(x, 2) > max_frame, theta_cell); % above function will eliminate exactly same points of a run, so we need the 2nd filter.
                theta_cell_filted = theta_cell(logical_index_theta);
                n_runs = length(theta_cell_filted);

                %% Calculate Delta theta
                [cos_mean, cos_std, cos_mean_mean, cos_mean_std, cos_std_mean, cos_std_std]...
                    = calculate_cos_Delta_theta(theta_cell_filted, max_frame);

                %% Calculate Pearson Corr
                [r, r_mean, r_std] = calculate_Pearson_corr(theta_cell_filted, max_frame);

                %% plot cos
                % figure;
                % errorbar(1:max_frame, cos_std_mean, cos_std_std);
                % xlabel('Delta Frame');
                % ylabel('$<cos(\Delta \theta)>$',Interpreter='latex');
                % title('Error Bar for Runs');
                % subtitle(sprintf('percentage of remaining runs: %.2f',length(run_disp_filted)/length(run_disp)));
                % ylim([0,1]);

                %% compare std within a run and std of runs
                % figure;
                % hold on;
                % plot(1:max_frame,cos_mean_std,'r-o');
                % plot(1:max_frame,cos_std_mean,'b-o');
                % xlabel('Delta Frame');
                % ylabel('standard deviation');
                % title('std within a run vs std of runs');
                % subtitle(sprintf('percentage of remaining runs: %.2f',length(run_disp_filted)/length(run_disp)));
                % legend('std of runs: std of mean of this index','std within a run: mean of std of this index');
                % ylim([0,0.6]);

                %% plot Pearson Corr
                figure;
                errorbar(0:max_frame, [1, r_mean], [0, r_std / sqrt(n_runs)]);
                xlabel('Delta Frame');
                ylabel('Pearson Corr');
                title('Error Bar for Runs');
                subtitle(sprintf('percentage of remaining runs: %.2f',length(run_disp_filted)/length(run_disp)));
                ylim([-0.2,1]);

                %% save
                save_file_name = sprintf("max_frame_%d_std",max_frame);
                save_full_path = fullfile(save_folder_path,save_file_name);
                saveas(gcf,save_full_path,'png');
                close all;
            end
        end
    end
end