function [slope_fit_save_table, slope_fit_save_T] = add_quadrant_and_save(slope_fit,var_name,save_folder_path,save_file_name)
quadrant_index = [3;4;1;2];
slope_fit_save = horzcat(quadrant_index,slope_fit);
slope_fit_save_table = array2table(slope_fit_save);
slope_fit_save_table.Properties.VariableNames = {'Quadrant', var_name};

slope_fit_save_table = swap_rows_of_a_table(slope_fit_save_table, 1, 3);
slope_fit_save_table = swap_rows_of_a_table(slope_fit_save_table, 2, 4);
writetable(slope_fit_save_table,fullfile(save_folder_path,strcat(save_file_name,'_',var_name,'.csv')));

slope_fit_save = swap_rows_of_an_array(slope_fit_save, 1, 3);
slope_fit_save = swap_rows_of_an_array(slope_fit_save, 2, 4);
slope_fit_save_T = slope_fit_save';
end