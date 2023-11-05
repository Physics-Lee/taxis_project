% merge n*1 cell array with 2*m numerical array as elements into 2*N numerical array
%
% 2023-11-05, Yixuan Li
%

function disp_merged = merge_cell_array(disp)

disp_merged = horzcat(disp{:});

end