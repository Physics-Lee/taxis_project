function v = calculate_v(run_disp_all)

% calculate the velocity of each run
% run_disp_all contains runs of all worms in a kind of taxis exp
% v is n*2, the 1st column is v of each run, the 2nd column is t of each run.

n = length(run_disp_all);
v = nan(n,2);
for i = 1:n

    % calculate path length
    points = run_disp_all{i};
    disp_vectors = (points(:, 2:end) - points(:, 1:end - 1));
    path_lengths = sqrt(sum(disp_vectors.^2, 1)); % path_length is sqrt(delta_x^2 + delta_y^2)
    path_length_sum = sum(path_lengths);

    % calculate v and t
    n_frame = size(points,2);
    f_sample = 2; % assume f_sample is 2 Hz.
    t = n_frame/f_sample;
    v(i,1) = path_length_sum/t;
    v(i,2) = t;

end

end