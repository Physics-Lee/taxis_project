% create fake eset.mat for the convenience to locate files.
%
% 2023-12-29, Yixuan Li
%

clc;clear;close all;
root_path = uigetdir;
save_file_name = "eset.mat";
x = [];
if root_path ~= 0
    list = get_all_folders_of_a_certain_name_pattern_in_a_rootpath(root_path,'mcd.mat');
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files');
    if tf == 1
        for i = indx
            folder_path_to_fake_eset = fileparts(list{i});
            save_full_path = fullfile(folder_path_to_fake_eset,save_file_name);
            save(save_full_path,"x","-mat");
        end
    end
end