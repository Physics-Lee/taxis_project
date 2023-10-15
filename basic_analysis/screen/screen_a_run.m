% screen a run by both t threshold
%
% 2023-09-26, Yixuan Li
%

function is_passed = screen_a_run(run)

%% t threshold
t_threshold = 5; % s
if run.runTime > t_threshold
    is_passed_1 = 1;
else
    is_passed_1 = 0;
end

%% n_unique_point_threshold
n_threshold = 5;
start_ind = run.startInd;
end_ind = run.endInd;
points = run.track.dq.displacement(:,start_ind:end_ind) / 22; % (mm)
points = unique(points', 'rows', 'stable')';
if size(points,2) > n_threshold
    is_passed_2 = 1;
else
    is_passed_2 = 0;
end

%% Overall screening result
is_passed = is_passed_1 & is_passed_2;

end