% using the name of .yaml to name mcd and mcd_corrected
%
% 2023-10-18, Yixuan Li
%

clear;clc;close all;

% chose the folder to analyze
path = uigetdir;

% if the user choose a folder
if path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_type_in_a_rootpath(path,'*.yaml');

    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],...
        'Name','Chose files to convert');

    % if at least 1 file is choosed
    if tf==1
        for i = indx

            full_path_to_yaml = list{i};
            [folder_path_of_yaml,file_name_of_yaml] = fileparts(full_path_to_yaml);
            list_mcd = get_all_files_of_a_certain_name_pattern_in_a_rootpath(folder_path_of_yaml,'*mcd_corred.mat');

            % if no certain file
            if size(list_mcd,2) == 0
                continue;
            end

            % loop to rename each file
            for j = 1:size(list_mcd,2)

                % old full path
                full_path_to_mcd = list_mcd{j};

                % new full path
                [folder_path_of_mcd,file_name_of_mcd,ext_of_mcd] = fileparts(full_path_to_mcd);
                file_name_of_mcd_new = [file_name_of_yaml '_' 'mcd_corrected' ext_of_mcd];
                full_path_to_mcd_new = fullfile(folder_path_of_mcd,file_name_of_mcd_new);

                % rename
                movefile(full_path_to_mcd, full_path_to_mcd_new);
                
            end

        end
    end
end