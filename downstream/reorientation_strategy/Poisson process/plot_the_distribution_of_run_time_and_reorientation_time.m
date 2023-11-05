% plot the distribution of run time and reorientation time from run disp
% and reorientation disp.
%
% 2023-11-05, Yixuan Li
%

dbstop if error;

clc;clear;close all;

% chose the folder to analyze
path = uigetdir;

% if the user choose a folder
if path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path,'*disp_of_all_*.mat');

    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files');

    % if at least 1 file is choosed
    if tf==1

        % loop to process each file
        for i = indx

            % load
            full_path = list{i};
            disp_of_all = load_data_from_mat(full_path);

            % create save folder
            folder_path_to_eset = fileparts(fileparts(full_path));
            save_folder_path = fullfile(folder_path_to_eset,'distribution_of_run_time_and_reorientation_time');
            create_folder(save_folder_path);

            % get title str
            if contains(full_path,'run')
                title_str = 'distribution of run time';
                edges = [5 5:5:200 200];
                x_lim_range = [5,200]; % s
                y_lim_range = [0,0.20]; % probability

                % for Colbert
                if contains(full_path,'Colbert')
                    edges = [5 5:10:85 85];
                    x_lim_range = [5,85]; % s
                    y_lim_range = [0,0.50]; % probability
                end

            elseif contains(full_path,'reorientation')
                title_str = 'distribution of reorientation time';
                edges = [0 0:2.5:60 60];
                x_lim_range = [0,60]; % s
                y_lim_range = [0,0.3]; % probability
            end

            % calculate
            n_disp = size(disp_of_all,1);
            time_of_disp = nan(n_disp,1);
            for j = 1:n_disp
                time_of_disp(j) = size(disp_of_all{j},2) / 2; % frame rate is 2 Hz
            end

            % plot
            figure;
            histogram(time_of_disp,edges,'Normalization','probability');
            xlabel('time (s)');
            ylabel('probability');
            title(title_str);
            xlim(x_lim_range);
            ylim(y_lim_range);

            % save
            save_file_name = title_str;
            save_full_path = fullfile(save_folder_path,save_file_name);
            saveas(gcf,save_full_path,'png');

            % semilogy
            set_semilogy();
            add_linear_fit(time_of_disp, edges);
            save_file_name = strcat(title_str,'_semilogy');
            save_full_path = fullfile(save_folder_path,save_file_name);
            saveas(gcf,save_full_path,'png');

            %
            pause(0.5);

            %
            close;

        end
    end
end