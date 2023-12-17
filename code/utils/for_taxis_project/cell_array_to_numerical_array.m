% convert a n*1 cell array to a 1*m numerical array.
%
% 2023-09-30, Yixuan Li
%

function data_vector = cell_array_to_numerical_array(data_cell)

data_vector = horzcat(data_cell{:});

end