% Load data from a CSV file
%
% The CSV file should contain headers in the first row.
% If the data is purely numeric, it will convert the table to an array.
%
% 2023-10-24, Yixuan Li
%

function data = load_data_from_csv(full_path)

% Read the data from the CSV file
table_data = readtable(full_path);

% Check if the data is purely numeric and convert to an array if true
if all(varfun(@isnumeric, table_data, 'OutputFormat', 'uniform'))
    data = table2array(table_data);
else
    data = table_data;
end

end
