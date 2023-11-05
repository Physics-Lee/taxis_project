% extract run disps (mm) from esets and save them in the same folder
%
% 2023-09-26, Yixuan Li
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

            % create save folder
            folder_path_to_eset = fileparts(full_path);
            save_folder_path_1 = fullfile(folder_path_to_eset,'run_disp_of_all_tracks');
            save_folder_path_2 = fullfile(folder_path_to_eset,'run_disp_of_each_track');
            create_folder(save_folder_path_1);
            create_folder(save_folder_path_2);

            %% for run disps of all tracks

            % extract
            run_disp = extract_run_disp_of_all_tracks(eset);

            % save
            save_file_name = 'run_disp_of_all_tracks.mat';
            save_full_path = fullfile(save_folder_path_1, save_file_name);
            save(save_full_path,'run_disp');

            %% for run disps of each track

            % extract
            run_disp_of_all_tracks = extract_run_disp_of_each_track(eset);

            % save
            for j = 1:size(run_disp_of_all_tracks,1)
                run_disp = run_disp_of_all_tracks{j,1};
                save_file_name = sprintf('run_disp_of_track_%d.mat',j);
                save_full_path = fullfile(save_folder_path_2, save_file_name);
                save(save_full_path,'run_disp');
            end

            %% disp
            disp('run_disp.mat saved successfully!');

        end
    end
end

disp('<<<END>>>');