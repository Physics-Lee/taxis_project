% some basic plots for mcd.mat
%
% 2023-11-05, Yixuan Li
%

clear;clc;close all;

path = uigetdir;
if path ~= 0
    list_mcd = get_all_files_of_a_certain_type_in_a_rootpath(path,'*mcd_corr*.mat');
    [indx,tf] = listdlg('ListString',list_mcd,'ListSize',[800,600],...
        'Name','Chose files to convert');
    if tf==1
        for i = indx
            % load
            full_path_of_mcd = list_mcd{i};
            mcd = load_mcd(full_path_of_mcd);
            
            % save
            [folder_path_of_mcd,file_name_of_mcd,ext] = fileparts(full_path_of_mcd);
            
            % plot the trajectory of the C.elegan
            full_path_of_save = create_save_folder(folder_path_of_mcd,'trajectory_of_the_C_elegan_in_the_absolute_frame');
            start_frame = 1;
            end_frame = length(mcd);
            f_sample = 66;
            plot_the_trajectory_of_the_C_elegan_in_the_absolute_frame(mcd,start_frame,end_frame,f_sample,full_path_of_save);
    
            % plot the C.elegan
            full_path_of_save = create_save_folder(folder_path_of_mcd,'the_whole_C_elegan_in_the_relative_frame');
            start_frame = 1;
            end_frame = 10;
            plot_the_whole_C_elegan_in_the_relative_frame(mcd,start_frame,end_frame,full_path_of_save)
            
            % plot the trajetory of the stage position
            full_path_of_save = create_save_folder(folder_path_of_mcd,'the_trajectory_of_the_stage_in_the_absolute_frame');
            start_frame = 1;
            end_frame = length(mcd);
            f_sample = 66;
            plot_the_trajectory_of_the_stage_in_the_absolute_frame(mcd,start_frame,end_frame,f_sample,full_path_of_save)
            
        end
    end    
end