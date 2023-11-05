% calculate Delta theta and plot it.
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
            run_disp = load_struct(full_path);

            % calculate
            [theta_in,theta_out,delta_theta] = calculate_delta_theta(run_disp);

            % convert
            delta_theta = rad2deg(delta_theta);

            %% plot

            figure;
            edges = -180:30:180;
            histogram(delta_theta,edges);

            % label
            xlabel('$\Delta \theta$', 'Interpreter', 'latex');
            ylabel('counts');

            % title
            title('distribution of $\Delta \theta$', 'Interpreter', 'latex');

            % ticks
            xticks(edges);

            %% save
            [folder_path_of_mcd,~,~] = fileparts(fileparts(full_path));
            save_folder_name = 'distribution_of_Delta_theta_of_reorientations';
            save_folder_path = fullfile(folder_path_of_mcd,save_folder_name);
            create_folder(save_folder_path);
            save_file_name = 'distribution_of_Delta_theta';
            save_full_path = fullfile(save_folder_path,save_file_name);
            saveas(gcf,save_full_path,'png');
            close;

        end
    end
end