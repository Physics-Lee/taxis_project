% Calculate the path length of all disp (containing both run and reorientation)
% of a worm
%
% 2023-12-28, Yixuan Li
%

function path_length_sum = calculate_path_length_of_all_disp_of_a_worm(all_disp)

points = all_disp{1};
disp_vectors = (points(:, 2:end) - points(:, 1:end - 1));
path_lengths = sqrt(sum(disp_vectors.^2, 1));
path_length_sum = sum(path_lengths);

end