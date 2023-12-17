% extract all disps (both run and reorientation) from esets and save them in the same folder
%
% Because I only want to see the index of the whole track disp, only
% saving all disps of each track are OK.
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

            % create save folder
            folder_path_to_eset = fileparts(full_path);
            save_folder_path = fullfile(folder_path_to_eset,'all_disp_of_each_track');
            create_folder(save_folder_path);

            %% for run disps of each track

            % extract
            all_disp_of_all_tracks = extract_all_disp_of_each_track(eset);

            % save
            for j = 1:size(all_disp_of_all_tracks,1)
                all_disp = all_disp_of_all_tracks{j,1};
                save_file_name = sprintf('all_disp_of_track_%d.mat',j);
                save_full_path = fullfile(save_folder_path, save_file_name);
                save(save_full_path,'all_disp');
            end

            %% disp
            disp('all_disp.mat saved successfully!');

        end
    end
end

disp('<<<END>>>');