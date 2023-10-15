function my_save(father_folder_path, name_of_new_folder, file_name, variable_name, variable_saved)

% save .mat files

folder_path_of_save = create_save_folder(father_folder_path, name_of_new_folder);
file_path_of_save = fullfile(folder_path_of_save, file_name);
var_struct.(variable_name) = variable_saved;  % Create a struct with dynamic field name
save(file_path_of_save, '-struct', 'var_struct');

end