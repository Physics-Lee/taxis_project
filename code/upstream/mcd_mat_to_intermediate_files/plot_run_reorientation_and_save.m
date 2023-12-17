% plot run and reorientation disp and save
%
% 2023-11-05, Yixuan Li
%

function plot_run_reorientation_and_save(run_disp,reorientation_disp,f_sample,full_path_to_mcd)

% plot run and reorientation in one graph
run_disp_merged = merge_cell_array(run_disp);
reorientation_disp_merged = merge_cell_array(reorientation_disp);
plot_run_disp_and_reorientation_disp(run_disp_merged,reorientation_disp_merged,f_sample);

% save
father_folder_path = fileparts(full_path_to_mcd);
my_save_for_gcf(father_folder_path, 'plot_run_reorientation_disp', 'f_sample_66Hz');

% close
close;

end