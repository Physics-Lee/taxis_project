% get the value of certain super-parameter from a .txt file
%
% 2023-12-05, Yixuan Li
%

function para = get_para_value_from_txt(folder_path,file_name)

% Define the file name
file_name = fullfile(folder_path, file_name);

% Open the file for reading
file_id = fopen(file_name, 'r');

% Check if the file is opened successfully
if file_id == -1
    error('Error opening file.');
end

% Read the value from the file
file_content = fgetl(file_id);
para = str2double(file_content);

% Close the file
fclose(file_id);

end