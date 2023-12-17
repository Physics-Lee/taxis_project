% save the value of certain super-parameter to a .txt file
%
% 2023-12-03, Yixuan Li
%

function save_para_value_to_txt(folder_path, para)

% Get the variable name using inputname
variable_name = inputname(2);  % '2' because sensitivity_threshold is the second argument

% Define the file name
file_name = fullfile(folder_path, sprintf('%s.txt', variable_name));

% Open the file for writing
file_id = fopen(file_name, 'w');

% Check if the file is opened successfully
if file_id == -1
    error('Error opening file.');
end

% Write the variable name and value to the file
fprintf(file_id, '%f', para);

% Close the file
fclose(file_id);

end