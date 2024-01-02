% save the path length of each worm or each track
%
% 2024-01-02, Yixuan Li
%

clc;clear;close all;

%% load data
root_folder_path = uigetdir;
list_eset = get_all_files_of_a_certain_name_pattern_in_a_rootpath(root_folder_path,'eset.mat');
[indx,tf] = listdlg('ListString',list_eset,'ListSize',[800,600],'Name','Choose files');
for i = indx
    full_path_to_eset = list_eset{i};
    folder_path_to_all_disp = fullfile(fileparts(full_path_to_eset),'all_disp_of_each_worm');
    list_all_disp = get_all_files_of_a_certain_name_pattern_in_a_rootpath(folder_path_to_all_disp,'all_disp_of_worm_*.mat');
    
    % init
    n_worms = length(list_all_disp);
    path_length = nan(n_worms,1);

    % loop to process each worm
    for j = 1:n_worms
        full_path_to_all_disp = list_all_disp{j};
        all_disp = load_data_from_mat(full_path_to_all_disp);
        path_length(j,1) = calculate_path_length_of_all_disp_of_a_worm(all_disp);
    end

    % save
    folder_path_to_eset = fileparts(full_path_to_eset);

    path_length = array2table(path_length, 'VariableNames', {'path_length_mm'});

    save_folder_name = "path_length_of_each_worm";
    save_folder_path = fullfile(folder_path_to_eset,save_folder_name);
    create_folder(save_folder_path);

    save_file_name = "path_length_of_each_worm";
    save_full_path = fullfile(save_folder_path,save_file_name);
    save_full_path_csv = strcat(save_full_path,'.csv');

    writetable(path_length, save_full_path_csv);
end