function suitable_name = get_suitable_folder_name_from_mcd_dir(full_path_to_mcd)

    % Get the parts of the path
    [folder, ~, ~] = fileparts(full_path_to_mcd);
    
    % Split the folder into separate directories
    folder_parts = split(folder, filesep);
    
    % Get the relevant directories
    suitable_name = folder_parts{end-2};

end