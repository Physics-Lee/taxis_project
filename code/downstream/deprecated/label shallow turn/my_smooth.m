% the input should be 2*n numerical array, 1st row for x and 2nd for y
% the output is also 2*n numerical array, 1st row for x and 2nd for y
%
% Yixuan Li, 2023-12-29
%

function smoothed_trajectory = my_smooth(trajectory)
trajectory = trajectory';
window_size = 5;
smoothed_trajectory = smoothdata(trajectory, 'movmean', window_size);
smoothed_trajectory = smoothed_trajectory';
end