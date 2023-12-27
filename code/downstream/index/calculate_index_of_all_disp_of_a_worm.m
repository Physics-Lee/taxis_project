% Calculate the index of all disp (containing both run and reorientation)
% of a worm
%
% 2023-12-02, Yixuan Li
%

function [index,path_length_sum] = calculate_index_of_all_disp_of_a_worm(all_disp,ideal_unit_vector)

% calculate path length
points = all_disp{1};
disp_vectors = (points(:, 2:end) - points(:, 1:end - 1));
path_lengths = sqrt(sum(disp_vectors.^2, 1));
path_length_sum = sum(path_lengths);

% calculate cos_to_ideal and tortuosity
point_start = points(:, 1)';
point_end = points(:, end)';
Euclid_distance = sqrt(sum((point_start - point_end).^2));
disp_normalized = (point_end - point_start) / Euclid_distance;
cos_to_ideal = dot(disp_normalized, ideal_unit_vector);
tortuosity = Euclid_distance / path_length_sum;

% calculate index,t and save
index = cos_to_ideal * tortuosity;

end