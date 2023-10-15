function suitable_name = get_suitable_file_name_from_mcd_dir(full_path_to_mcd)

    % Get the parts of the path
    [folder, ~, ~] = fileparts(full_path_to_mcd);
    
    % Split the folder into separate directories
    folder_parts = split(folder, filesep);
    
    % Get the relevant directories
    relevant_dirs = folder_parts(end-1:end);
    
    % Combine them into a string
    suitable_name = strjoin(relevant_dirs, '_');

end