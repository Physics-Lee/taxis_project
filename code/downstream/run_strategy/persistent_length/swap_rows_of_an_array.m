function my_array = swap_rows_of_an_array(my_array, row1, row2)

% This function swaps two rows in a MATLAB array.
%
% Arguments:
% my_array - The input array
% row1 - The index of the first row to swap
% row2 - The index of the second row to swap

% Swap the rows
temp = my_array(row1, :);
my_array(row1, :) = my_array(row2, :);
my_array(row2, :) = temp;

end