% Calculate the velocity of each run
%
% Input: run_disp contains runs of all worms in a type of taxis
% Output: v is n*2 where the 1st column is v of each run, the 2nd column is t of each run.
%
% 2023-10-25, Yixuan Li
%

function v = calculate_v(run_disp)

% init
n_runs = length(run_disp);
v = nan(n_runs,2);

% loop to process each run
for i = 1:n_runs

    % calculate the path length
    points = run_disp{i};
    disp_vectors = (points(:, 2:end) - points(:, 1:end - 1));
    path_lengths = sqrt(sum(disp_vectors.^2, 1));
    path_length_sum = sum(path_lengths);    
    
    % calculate v,t and save
    n_frame = size(points,2);
    t = calculate_t(n_frame);
    v(i,1) = path_length_sum/t;
    v(i,2) = t;

end

end