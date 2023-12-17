% extract run disps (mm) of the first half and the second half of an exp
%
% 2023-11-08, Yixuan Li
%

dbstop if error;

clc;clear;close all;

% chose the folder to analyze
path = uigetdir;

% if the user choose a folder
if path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path,'*eset.mat');

    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files');

    % if at least 1 file is choosed
    if tf==1

        % loop to process each file
        for i = indx

            % load
            full_path = list{i};
            load(full_path);

            %% first half

            % % create save folder
            % folder_path_to_eset = fileparts(full_path);
            % save_folder_path = fullfile(folder_path_to_eset,'run_disp_of_all_tracks_first_half_of_an_exp');
            % create_folder(save_folder_path);

            % % extract
            % run_disp = extract_run_disp_of_all_tracks_first_half_of_an_exp(eset);
            %
            % % save
            % save_file_name = 'run_disp_of_all_tracks.mat';
            % save_full_path = fullfile(save_folder_path, save_file_name);
            % save(save_full_path,'run_disp');

            % create save folder
            folder_path_to_eset = fileparts(full_path);
            save_folder_path = fullfile(folder_path_to_eset,'run_disp_of_each_track_first_half_of_an_exp');
            create_folder(save_folder_path);

            % extract
            run_disp_of_all_tracks = extract_run_disp_of_each_track_first_half_of_an_exp(eset);

            % save
            for j = 1:size(run_disp_of_all_tracks,1)
                run_disp = run_disp_of_all_tracks{j,1};
                save_file_name = sprintf('run_disp_of_track_%d.mat',j);
                save_full_path = fullfile(save_folder_path, save_file_name);
                save(save_full_path,'run_disp');
            end

            %% second half

            % % create save folder
            % folder_path_to_eset = fileparts(full_path);
            % save_folder_path = fullfile(folder_path_to_eset,'run_disp_of_all_tracks_second_half_of_an_exp');
            % create_folder(save_folder_path);

            % % extract
            % run_disp = extract_run_disp_of_all_tracks_second_half_of_an_exp(eset);
            %
            % % save
            % save_file_name = 'run_disp_of_all_tracks.mat';
            % save_full_path = fullfile(save_folder_path, save_file_name);
            % save(save_full_path,'run_disp');

            % create save folder
            folder_path_to_eset = fileparts(full_path);
            save_folder_path = fullfile(folder_path_to_eset,'run_disp_of_each_track_second_half_of_an_exp');
            create_folder(save_folder_path);

            % extract
            run_disp_of_all_tracks = extract_run_disp_of_each_track_second_half_of_an_exp(eset);

            % save
            for j = 1:size(run_disp_of_all_tracks,1)
                run_disp = run_disp_of_all_tracks{j,1};
                save_file_name = sprintf('run_disp_of_track_%d.mat',j);
                save_full_path = fullfile(save_folder_path, save_file_name);
                save(save_full_path,'run_disp');
            end

            %% disp
            disp('run_disp.mat saved successfully!');

        end
    end
end

disp('<<<END>>>');