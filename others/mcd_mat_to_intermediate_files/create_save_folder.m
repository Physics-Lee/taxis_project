function full_path_of_save = create_save_folder(folder_path,folder_name)
full_path_of_save = fullfile(folder_path,folder_name);
if ~isfolder(full_path_of_save)
    mkdir(full_path_of_save);
end
end