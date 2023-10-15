function delta_theta = get_delta_theta(smoothed_theta,frame_window)
% smoothed_theta should be 1*n
delta_theta = zeros(1,length(smoothed_theta)-frame_window);
for i = 1:length(smoothed_theta)-frame_window
    delta_theta(i) = my_diff(smoothed_theta(i),smoothed_theta(i+frame_window));
end
end