clear;clc;close all;

my_add_path;
path = uigetdir;
if path ~= 0
    list_csv = get_all_files_of_a_certain_type_in_a_rootpath(path,'*machine_label_v2_frame_window_10.csv');
    [indx,tf] = listdlg('ListString',list_csv,'ListSize',[800,600],'Name','Chose files');
    f_sample = 66;
    if tf == 1
        for i = indx

            % load .csv
            full_path_to_csv = list_csv{i};
            label_rearranged = readcell(full_path_to_csv); % write cell then, read cell now.

            % load mcd.mat
            [parent_dir,~,~] = fileparts(full_path_to_csv);
            [folder_path_of_mcd,~,~] = fileparts(parent_dir);
            list_mcd = get_all_files_of_a_certain_type_in_a_rootpath(folder_path_of_mcd,'*mcd_corr*.mat');

            if size(list_mcd,2) ~= 1
                error("More than 1 '*mcd_corr*.mat' in the folder!");
            end

            full_path_to_mcd = list_mcd{1};
            mcd = load_mcd(full_path_to_mcd);

            % get run disp and reorientation disp
            run_disp = process_labels(label_rearranged, mcd, "forward", f_sample);
            reorientation_disp = process_labels(label_rearranged, mcd, "reorientation", f_sample);

            plot_run_reorientation_and_save(run_disp,reorientation_disp,f_sample,full_path_to_mcd);

            % smooth
            T = 3; % s
            window_size = f_sample*T;
            run_disp_smoothed = smooth_run_disp(run_disp,window_size);

            % downsample
            f_sample_old = 66;
            f_sample_new = 2;
            run_disp_smoothed_downsampled = down_sample(run_disp_smoothed,f_sample_old,f_sample_new);

            % smooth
            window_size = 11;
            run_disp_smoothed_downsampled_smoothed = smooth_run_disp(run_disp_smoothed_downsampled,window_size);

            % save
            my_save(folder_path_of_mcd, 'disp', 'run_disp_smoothed_downsampled_smoothed.mat', 'run_disp_smoothed_downsampled_smoothed', run_disp_smoothed_downsampled_smoothed);

            plot_run_and_save(run_disp_smoothed_downsampled_smoothed,f_sample,full_path_to_mcd)

        end
    end
end

function plot_run_reorientation_and_save(run_disp,reorientation_disp,f_sample,full_path_to_mcd)

% plot run and reorientation in one graph
run_disp_merged = merge_cell_array(run_disp);
reorientation_disp_merged = merge_cell_array(reorientation_disp);
plot_run_disp_and_reorientation_disp(run_disp_merged,reorientation_disp_merged,f_sample);

% save to the corresponding folder
father_folder_path = fileparts(full_path_to_mcd);
my_save_for_gcf(father_folder_path, 'run_reorientation_trajectory_of_mcd_corrected', 'f_sample_66Hz');

% save to the same folder
father_folder_path = 'F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\result\visulization_run_reorientation_f_sample_66Hz';
save_to_the_same_folder(father_folder_path,full_path_to_mcd);
close;

end

function save_to_the_same_folder(father_folder_path,full_path_to_mcd)
name_of_new_folder = get_suitable_folder_name_from_mcd_dir(full_path_to_mcd);
file_name = get_suitable_file_name_from_mcd_dir(full_path_to_mcd);
my_save_for_gcf(father_folder_path, name_of_new_folder, file_name);
end

function plot_run_and_save(run_disp_smoothed_downsampled_smoothed,f_sample,full_path_to_mcd)

% merge
run_disp_smoothed_downsampled_smoothed_merged = merge_cell_array(run_disp_smoothed_downsampled_smoothed);

% plot
plot_run_disp(run_disp_smoothed_downsampled_smoothed_merged,f_sample,'blue','run');

% save to the same folder
father_folder_path = 'F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\result\visulization_run_disp_smoothed_downsampled_smoothed_merged';
save_to_the_same_folder(father_folder_path,full_path_to_mcd);
close;

end