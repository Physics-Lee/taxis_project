function name = remove_file_extension(file_name)
    [~, name, ~] = fileparts(file_name);
end