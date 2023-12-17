function smoothed_trajectory = my_smooth(trajectory)
% the input should be 2*n
% the output is also 2*n
trajectory = trajectory';
window_size = 5;
smoothed_trajectory = smoothdata(trajectory, 'movmean', window_size);
smoothed_trajectory = smoothed_trajectory';
end