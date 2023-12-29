% create folders based on the dir of eset.mat
%
% 2023-12-29, Yixuan Li
%

clc;clear;close all;
root_path = uigetdir;
new_folder_name = "all_disp_of_each_worm";
if root_path ~= 0
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(root_path,'eset.mat');
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Choose files');
    if tf == 1
        for i = indx
            folder_path_to_eset = fileparts(list{i});
            folder_path_to_the_new_folder = fullfile(folder_path_to_eset,new_folder_name);
            create_folder(folder_path_to_the_new_folder);
        end
    end
end