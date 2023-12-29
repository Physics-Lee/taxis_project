% move files based on the dir of eset.mat
%
% 2023-12-29, Yixuan Li
%

clc;clear;close all;
root_path = uigetdir;
folder_destination_relative_path = "all_disp_of_each_worm";
folder_departure_relative_path = "mcd.mat";
if root_path ~= 0
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(root_path,'eset.mat');
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Choose files');
    if tf == 1
        for i = indx

            % locates eset
            folder_path_to_eset = fileparts(list{i});

            % departure
            folder_path_to_departure = fullfile(folder_path_to_eset,folder_departure_relative_path);
            list_departure = get_all_folders_in_the_first_level(folder_path_to_departure);

            % destination
            folder_path_to_destination = fullfile(folder_path_to_eset,folder_destination_relative_path);

            % loop to move files
            for j = 1:length(list_departure)

                %
                folder_name = list_departure{j};

                % new
                folder_path_to_departure_new = fullfile(folder_path_to_departure,folder_name); 
                folder_path_to_destination_new = fullfile(folder_path_to_destination,folder_name);

                % loop
                list_mat = get_all_files_of_a_certain_name_pattern_in_a_rootpath(folder_path_to_departure_new,'all_disp_of_worm_*.mat');
                for k = 1:length(list_mat)
                    full_path_to_departure = list_mat{k};

                    [~,file_name,ext] = fileparts(full_path_to_departure);
                    file_name = strcat(file_name, ext);

                    full_path_to_destination = fullfile(folder_path_to_destination_new,file_name);

                    % finally
                    if ~isfile(full_path_to_destination)
                        movefile(full_path_to_departure, full_path_to_destination)
                    end
                end

            end
            
        end
    end
end