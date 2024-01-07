function my_table = swap_rows_of_a_table(my_table, row1, row2)

% This function swaps two rows in a MATLAB table.
%
% Arguments:
% tbl - The input table
% row1 - The index of the first row to swap
% row2 - The index of the second row to swap

% Verify if row indices are within the bounds of the table
if row1 > height(my_table) || row2 > height(my_table) || row1 < 1 || row2 < 1
    error('Row indices are out of table bounds.');
end

% Swap the rows
temp = my_table(row1, :);
my_table(row1, :) = my_table(row2, :);
my_table(row2, :) = temp;

end