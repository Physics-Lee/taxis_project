% Cell to table
%
% 2023-10-25, Yixuan Li
%

function table_array = my_cell2table(cell_array)

% calculate weighted average
weighted_average = calculate_weighted_average(cell_array);
weighted_std = calculate_weighted_std(cell_array);

% save to cell array
cell_array = [cell_array num2cell(weighted_average) num2cell(weighted_std)];

% cell to table
header = {'measure', 'info', 'weighted_average', 'weighted_std'};
table_array = cell2table(cell_array, 'VariableNames', header);

end