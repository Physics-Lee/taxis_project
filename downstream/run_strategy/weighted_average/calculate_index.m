% Calculate the index of each run
%
% 2023-10-25, Yixuan Li
%

function index = calculate_index(run_disp,ideal_unit_vector)

% init
n_runs = length(run_disp);
index = nan(n_runs,2);

% loop to process each run
for i = 1:n_runs

    % calculate path length
    points = run_disp{i};
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

    % calculate index and save
    index(i,1) = cos_to_ideal * tortuosity;

    % calculate t and save
    n_frame = size(points,2);
    t = calculate_t(n_frame);
    index(i,2) = t;

end

end