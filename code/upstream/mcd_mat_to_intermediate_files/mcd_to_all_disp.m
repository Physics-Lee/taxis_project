% from mcd to all disp (contains both runs and reorientations).
%
% 2023-12-29, Yixuan Li
%

clear;clc;close all;

dbstop if error;
path = uigetdir;
if path ~= 0
    list_csv = get_all_files_of_a_certain_type_in_a_rootpath(path,'*machine_label_v2_frame_window_10.csv');
    [indx,tf] = listdlg('ListString',list_csv,'ListSize',[800,600],'Name','Chose files');
    if tf == 1
        for i = indx

            % load .csv
            full_path_to_csv = list_csv{i};
            label_rearranged = readcell(full_path_to_csv); % write cell then, read cell now.

            % load mcd.mat
            [parent_dir,~,~] = fileparts(full_path_to_csv);
            [folder_path_of_mcd,~,~] = fileparts(parent_dir);
            list_mcd = get_all_files_of_a_certain_type_in_a_rootpath(folder_path_of_mcd,'*mcd_corrected.mat');

            if size(list_mcd,2) ~= 1
                error("More than 1 '*mcd_corrected.mat' in the folder!");
            end

            full_path_to_mcd = list_mcd{1};
            mcd = load_mcd(full_path_to_mcd);

            % get run disp and reorientation disp
            run_disp = process_labels(label_rearranged, mcd, "forward");
            reorientation_disp = process_labels(label_rearranged, mcd, "reorientation");

            % plot
            plot_run_reorientation_and_save(run_disp,reorientation_disp,f_sample,full_path_to_mcd);

            % smooth
            run_disp = my_smooth(run_disp);
            reorientation_disp = my_smooth(reorientation_disp);

            % plot
            f_sample = 2; % Hz
            plot_run_and_save(run_disp,f_sample,full_path_to_mcd);

            % save
            [~,worm_str,~] = fileparts(folder_path_of_mcd);
            worm_str = strrep(worm_str,'w','worm_');
            save_file_name_1 = strcat('run_disp_of_',worm_str,'.mat');
            save_file_name_2 = strcat('reorientation_disp_of_',worm_str,'.mat');
            my_save(folder_path_of_mcd, 'run_disp', save_file_name_1, 'run_disp', run_disp);
            my_save(folder_path_of_mcd, 'reorientation_disp', save_file_name_2, 'reorientation_disp', reorientation_disp);

        end
    end
end