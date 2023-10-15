function disp_merged = merge_cell_array(disp)

% merge n*1 cell array with 2*m numerical array as elements into 2*N numerical array

disp_merged = horzcat(disp{:});

end