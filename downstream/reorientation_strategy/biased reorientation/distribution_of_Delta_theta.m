% plot f(Delta theta)
%
% 2023-11-05, Yixuan Li
%

dbstop if error
clear;clc;close all;
path = uigetdir;
if path ~= 0
    list = get_all_files_of_a_certain_type_in_a_rootpath(path,'run_disp_of_all_*.mat');
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Choose files');
    if tf == 1
        for i = indx

            % load
            full_path = list{i};
            run_disp = load_data_from_mat(full_path);

            % calculate
            [theta_in_of_runs,theta_out_of_runs,Delta_theta] = calculate_Delta_theta(run_disp);

            %% f(Delta theta)

            figure;
            edges = -180:30:180;
            histogram(rad2deg(Delta_theta),edges,'Normalization','pdf');

            % label
            xlabel('$\Delta \theta$', 'Interpreter', 'latex');
            ylabel('pdf');

            % title
            title('distribution of $\Delta \theta$', 'Interpreter', 'latex');

            % ticks
            xticks(edges);

            % lim
            ylim([0,0.01]);

            %% save
            [folder_path_of_mcd,~,~] = fileparts(fileparts(full_path));
            save_folder_name = 'distribution_of_Delta_theta_of_reorientations';
            save_folder_path = fullfile(folder_path_of_mcd,save_folder_name);
            create_folder(save_folder_path);
            save_file_name = 'distribution_of_Delta_theta';
            save_full_path = fullfile(save_folder_path,save_file_name);
            saveas(gcf,save_full_path,'png');
            close;

            %% f(Delta theta|theta in)

            % get taxis type
            option_taxis = get_taxis_type_by_full_path(full_path);

            % Runhui NC
            % option_taxis = "NC_Runhui";

            % get Delta theta | theta in
            [Delta_theta_regions{1:4}] = allocate_angles_to_4_regions(option_taxis,theta_out_of_runs(1:end-1),Delta_theta);

            % plot f(Delta theta|theta in)
            for region = 1:4

                % get data
                Delta_theta_region = Delta_theta_regions{region};

                % Create a histogram for f(Delta theta|theta in) in the current region
                figure;
                edges = -180:30:180;
                histogram(rad2deg(Delta_theta_region), edges, 'Normalization', 'pdf');

                % label and title
                xlabel('$\Delta \theta$', 'Interpreter', 'latex');
                ylabel('pdf');
                title(['Distribution of $\Delta \theta$ for Region ' num2str(region)], 'Interpreter', 'latex');

                % ticks
                xticks(edges);

                % lim
                ylim([0, 0.01]);

                % Save the plot to a specific file
                save_file_name = ['distribution_of_Delta_theta_for_region_' num2str(region)];
                save_full_path = fullfile(save_folder_path,save_file_name);
                saveas(gcf, save_full_path, 'png');
                close;

            end
        end
    end
end