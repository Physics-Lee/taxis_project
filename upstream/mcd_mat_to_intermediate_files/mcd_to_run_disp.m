% from mcd to run disp.
%
% 2023-10-30, Yixuan Li
%

clear;clc;close all;

dbstop if error;
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
            list_mcd = get_all_files_of_a_certain_type_in_a_rootpath(folder_path_of_mcd,'*mcd_corrected.mat');

            if size(list_mcd,2) ~= 1
                error("More than 1 '*mcd_corrected.mat' in the folder!");
            end

            full_path_to_mcd = list_mcd{1};
            mcd = load_mcd(full_path_to_mcd);

            % get run disp and reorientation disp
            run_disp = process_labels(label_rearranged, mcd, "forward", f_sample);
            reorientation_disp = process_labels(label_rearranged, mcd, "reorientation", f_sample);

            % plot
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
            [~,worm_str,~] = fileparts(folder_path_of_mcd);
            worm_str = strrep(worm_str,'w','worm_');
            save_file_name = strcat('run_disp_of_',worm_str,'.mat');
            my_save(folder_path_of_mcd, 'disp_new', save_file_name, 'run_disp_smoothed_downsampled_smoothed', run_disp_smoothed_downsampled_smoothed);
            
            % plot
            plot_run_and_save(run_disp_smoothed_downsampled_smoothed,f_sample);

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
my_save_for_gcf(father_folder_path, 'run_reorientation_trajectory_of_mcd_corrected_new', 'f_sample_66Hz');

% close
close;

end

function plot_run_and_save(run_disp_smoothed_downsampled_smoothed,f_sample)

% merge
run_disp_smoothed_downsampled_smoothed_merged = merge_cell_array(run_disp_smoothed_downsampled_smoothed);

% plot
plot_run_disp(run_disp_smoothed_downsampled_smoothed_merged,f_sample,'blue','run');

% close
close;

end