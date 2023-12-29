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

            % get all disp
            all_disp = process_labels(label_rearranged, mcd);
            all_disp_vector = cell_array_to_numerical_array(all_disp);
            all_disp = {all_disp_vector};

            % smooth
            all_disp = my_smooth(all_disp);

            % save
            [~,worm_str,~] = fileparts(folder_path_of_mcd);
            worm_str = strrep(worm_str,'w','worm_');
            save_file_name_3 = strcat('all_disp_of_',worm_str,'.mat');
            my_save(folder_path_of_mcd, 'all_disp', save_file_name_3, 'all_disp', all_disp);

        end
    end
end