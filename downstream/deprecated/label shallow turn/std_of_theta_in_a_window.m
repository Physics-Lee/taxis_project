function std_of_theta = std_of_theta_in_a_window(theta,frame_window)

% theta should be 1*n
std_of_theta = zeros(1,length(theta)-frame_window);
for i = 1:length(theta)-frame_window+1
    std_of_theta(i) = weighted_std(theta(i:i+frame_window-1),frame_window);
end

end