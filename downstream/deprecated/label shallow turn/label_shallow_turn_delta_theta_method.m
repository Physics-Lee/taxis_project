function label = label_shallow_turn_delta_theta_method(run_displacement,...
    frame_window,delta_theta_threshold,frame_threshold)

label = cell(length(run_displacement),1);
for i = 1:length(run_displacement)
    theta = get_theta_from_points(run_displacement{i,1});
    window_size = 5;
    smoothed_theta = smoothdata(theta, 'movmean', window_size);
    label_of_a_run = zeros(1,length(smoothed_theta)+1);
    if length(label_of_a_run) > frame_threshold
        j = 1;
        while j <= length(smoothed_theta) - frame_window
            if abs(smoothed_theta(j)-smoothed_theta(j+frame_window)) > delta_theta_threshold
                label_of_a_run(j:j+frame_window) = 1;
                j = j + frame_window/2 + 1;
            else
                j = j + 1;
            end
        end
    end
    label_of_a_run(end) = 0; %to make label of a run the same length as this run.
    label{i} = label_of_a_run;
end

end