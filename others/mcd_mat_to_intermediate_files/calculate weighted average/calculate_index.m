function index = calculate_index(run_disp_all,ideal_unit_vector)

% init
n = length(run_disp_all);
index = nan(n,2);
for i = 1:n

    % calculate path length
    points = run_disp_all{i};
    disp_vectors = (points(:, 2:end) - points(:, 1:end - 1)); % disp vectors
    path_lengths = sqrt(sum(disp_vectors.^2, 1)); % path_length is sqrt(delta_x^2 + delta_y^2)
    path_length_sum = sum(path_lengths);

    % calculate cos and tortuosity
    point_start = points(:, 1)';
    point_end = points(:, end)';
    Euclid_distance = sqrt(sum((point_start - point_end).^2));
    disp_normalized = (point_end - point_start) / Euclid_distance;
    cos_to_ideal = dot(disp_normalized, ideal_unit_vector);
    tortuosity = Euclid_distance / path_length_sum;

    % calculate index
    index(i,1) = cos_to_ideal * tortuosity;

    % calculate t
    n_frame = size(points,2);
    f_sample = 2; % assume f_sample is 2 Hz.
    t = n_frame/f_sample;
    index(i,2) = t;

end

end