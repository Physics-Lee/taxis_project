% plot run disp and save
%
% 2023-11-05, Yixuan Li
%

function plot_run_and_save(run_disp,f_sample,full_path_to_mcd)

% merge
run_disp_merged = merge_cell_array(run_disp);

% plot
plot_run_disp(run_disp_merged,f_sample,'blue','run');

% save
father_folder_path = fileparts(full_path_to_mcd);
my_save_for_gcf(father_folder_path, 'plot_run_disp', 'f_sample_2Hz');

% close
close;

end