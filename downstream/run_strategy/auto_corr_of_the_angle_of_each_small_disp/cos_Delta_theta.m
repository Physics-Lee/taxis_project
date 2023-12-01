% function: calculate cos(\Delta \theta), Pearson Corr or visualize
% \theta(t) and \theta(t+\tau) as X and Y
%
% option_measure: cos_Delta_theta, Pearson_Corr, Visualize_as_X_and_Y,
% visualize_X_Y_for_each_run, Slope_of_Least_Squre
%
% Yixuan Li, 2023-11-29
%

clc;clear;close all;

%% option
option_measure = "Visualize_as_X_and_Y";

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
            save_folder_path = fullfile(folder_path_to_eset, option_measure);
            create_folder(save_folder_path);

            % main
            for max_frame = 20:20:60

                %% get theta
                logical_index_run_disp = cellfun(@(x) size(x, 2) > max_frame, run_disp);
                run_disp_filted = run_disp(logical_index_run_disp);
                theta_cell = cellfun(@from_points_to_theta, run_disp_filted, 'UniformOutput', false);
                logical_index_theta = cellfun(@(x) size(x, 2) > max_frame + 2, theta_cell); % above function will eliminate exactly same points of a run, so we need the 2nd filter.
                theta_cell_filted = theta_cell(logical_index_theta);
                theta_cell_filted_unwrapped = cellfun(@unwrap, theta_cell_filted, 'UniformOutput', false);
                n_runs = length(theta_cell_filted_unwrapped);

                %% switch case
                switch option_measure
                    case "cos_Delta_theta"

                        %% Calculate Delta theta
                        [cos_mean, cos_std, cos_mean_mean, cos_mean_std, cos_std_mean, cos_std_std]...
                            = calculate_cos_Delta_theta(theta_cell_filted_unwrapped, max_frame);

                        %% plot cos
                        figure;
                        errorbar(1:max_frame, cos_mean_mean, cos_mean_std / sqrt(n_runs));
                        xlabel('Delta Frame');
                        ylabel('$<cos(\Delta \theta)>$',Interpreter='latex');
                        title('Error Bar for Runs');
                        subtitle(sprintf('percentage of remaining runs: %.2f',length(run_disp_filted)/length(run_disp)));
                        ylim([0,1]);

                        %% save
                        save_folder_path_now = fullfile(save_folder_path, 'persistent-length-like');
                        create_folder(save_folder_path_now);
                        save_file_name = sprintf("max_frame_%d_SEM",max_frame);
                        save_full_path = fullfile(save_folder_path_now,save_file_name);
                        saveas(gcf,save_full_path,'png');

                        %% plot std
                        figure;
                        errorbar(1:max_frame, cos_std_mean, cos_std_std / sqrt(n_runs));
                        xlabel('Delta Frame');
                        ylabel('standard deviation');
                        title('Error Bar for Runs');
                        subtitle(sprintf('percentage of remaining runs: %.2f',length(run_disp_filted)/length(run_disp)));
                        ylim([0,1]);

                        %% save
                        save_folder_path_now = fullfile(save_folder_path, 'to see variance within a run');
                        create_folder(save_folder_path_now);
                        save_file_name = sprintf("max_frame_%d_SEM",max_frame);
                        save_full_path = fullfile(save_folder_path_now,save_file_name);
                        saveas(gcf,save_full_path,'png');

                        %% compare std within a run and std of runs
                        figure;
                        hold on;
                        plot(1:max_frame,cos_mean_std,'r-o');
                        plot(1:max_frame,cos_std_mean,'b-o');
                        xlabel('Delta Frame');
                        ylabel('standard deviation');
                        title('std within a run vs std of runs');
                        subtitle(sprintf('percentage of remaining runs: %.2f',length(run_disp_filted)/length(run_disp)));
                        legend('std of runs: std of mean of this index','std within a run: mean of std of this index');
                        ylim([0,0.6]);

                        %% save
                        save_folder_path_now = fullfile(save_folder_path, 'std within a run vs std of runs');
                        create_folder(save_folder_path_now);
                        save_file_name = sprintf("max_frame_%d",max_frame);
                        save_full_path = fullfile(save_folder_path_now,save_file_name);
                        saveas(gcf,save_full_path,'png');

                    case "Pearson_Corr"
                        %% Calculate
                        [r, r_mean, r_std] = calculate_Pearson_corr(theta_cell_filted_unwrapped, max_frame);

                        %% plot
                        figure;
                        errorbar(0:max_frame-10, [1, r_mean], [0, r_std / sqrt(n_runs)]);
                        xlabel('Delta Frame');
                        ylabel('Pearson Corr');
                        title('Error Bar for Runs');
                        subtitle(sprintf('percentage of remaining runs: %.2f',length(run_disp_filted)/length(run_disp)));
                        ylim([-0.2,1]);

                        %% save
                        save_file_name = sprintf("max_frame_%d_SEM",max_frame-10);
                        save_full_path = fullfile(save_folder_path,save_file_name);
                        saveas(gcf,save_full_path,'png');

                    case "Slope_of_Least_Squre"
                        %% Calculate
                        [b, b_mean, b_std] = calculate_b(theta_cell_filted_unwrapped, max_frame);

                        %% plot
                        figure;
                        errorbar(0:max_frame-10, [1, b_mean], [0, b_std / sqrt(n_runs)]);
                        xlabel('Delta Frame');
                        ylabel('Slope of Least Squre');
                        title('Error Bar for Runs');
                        subtitle(sprintf('percentage of remaining runs: %.2f',length(run_disp_filted)/length(run_disp)));
                        ylim([-0.2,1]);

                        %% save
                        save_file_name = sprintf("max_frame_%d_SEM",max_frame-10);
                        save_full_path = fullfile(save_folder_path,save_file_name);
                        saveas(gcf,save_full_path,'png');

                    case "Visualize_as_X_and_Y"
                        %% Visualize as X and Y
                        [theta_t1,theta_t2] = visualize_X_Y(theta_cell_filted_unwrapped,max_frame);
                        figure;
                        hold on;
                        axis equal;
                        plot(theta_t1,theta_t2,'k-o');

                        % r
                        r = corrcoef(theta_t1,theta_t2);

                        % b
                        p = polyfit(theta_t1, theta_t2, 1);

                        % Lines y = x + 90 and y = x - 90
                        y1 = theta_t1 + 90; % Calculate y values for y = x + 90
                        y2 = theta_t1 - 90; % Calculate y values for y = x - 90
                        plot(theta_t1, y1, 'r--'); % Plotting y = x + 90 in red dashed line
                        plot(theta_t1, y2, 'b--'); % Plotting y = x - 90 in blue dashed line

                        % label and title
                        xlabel('$\theta(t)$',Interpreter='latex');
                        ylabel('$\theta(t+\tau)$',Interpreter='latex');
                        title(sprintf("r = %.2f; b = %.2f",r(1,2),p(1)));
                        subtitle(sprintf('percentage of remaining runs: %.2f',length(run_disp_filted)/length(run_disp)));
                        legend('data','y = x + 90','y = x - 90');

                        %% save
                        save_file_name = sprintf("max_frame_%d",max_frame);
                        save_full_path = fullfile(save_folder_path,save_file_name);
                        saveas(gcf,save_full_path,'png');
                    case "visualize_X_Y_for_each_run"
                        visualize_X_Y_for_each_run(theta_cell_filted_unwrapped,max_frame,save_folder_path)
                end
                close all;
            end
        end
    end
end