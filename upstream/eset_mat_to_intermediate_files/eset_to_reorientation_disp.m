% extract reorientation disps (mm) from esets and save them in the same folder
%
% Because I only want to see the distribution of reorientation time, only
% saving reorienation disps of all tracks are OK.
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
            save_folder_path_1 = fullfile(folder_path_to_eset,'reorientation_disp_of_all_tracks');
            create_folder(save_folder_path_1);

            %% for reorientation disps of all tracks

            % extract
            reorientation_disp = extract_reorientation_disp_of_all_tracks(eset);

            % save
            save_file_name = 'reorientation_disp_of_all_tracks.mat';
            save_full_path = fullfile(save_folder_path_1, save_file_name);
            save(save_full_path,'reorientation_disp');

            %% disp
            disp('reorientation_disp.mat saved successfully!');

        end
    end
end

disp('<<<END>>>');