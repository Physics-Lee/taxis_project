% Calculate the delta theta between n frames
%
% The input is a n*1 cell array, each element is the theta of a run.
%
% The output is a n*1 cell array, each element is the delta theta of a run.
%
% 2023-09-30, Yixuan Li
%

function run_delta_theta_cell = calculate_Delta_theta_between_n_frames(run_theta_cell,n_frame)

n_1 = length(run_theta_cell);
run_delta_theta_cell = cell(n_1,1);
for i = 1:n_1
    n_2 = length(run_theta_cell{i});
    run_delta_theta_vector = zeros(1,n_2 - n_frame);
    for j = 1:n_2 - n_frame
        run_delta_theta_vector(j) = my_diff(run_theta_cell{i}(j),run_theta_cell{i}(j + n_frame));
    end
    run_delta_theta_cell{i} = run_delta_theta_vector;
end

end