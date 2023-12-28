% Cell array to table array
%
% Input: N*2 cell array, 1st column is measure and weight for all runs in
% a track, 2nd column is the serial number of the track
%
% Output: N*4 table array, 1st and 2nd column are same as input, 3rd
% column is weighted mean while 4th column is weighted SEM. Weighted by run
% time.
%
% 2023-10-25, Yixuan Li
%

function table_array = my_cell2table(cell_array)

% calculate weighted average
weighted_average = calculate_weighted_average(cell_array);
weighted_SEM = calculate_weighted_SEM(cell_array);

% save to cell array
cell_array = horzcat(cell_array, num2cell(weighted_average), num2cell(weighted_SEM));

% cell to table
header = {'measure', 'info', 'weighted_average', 'weighted_SEM'};
table_array = cell2table(cell_array, 'VariableNames', header);

end