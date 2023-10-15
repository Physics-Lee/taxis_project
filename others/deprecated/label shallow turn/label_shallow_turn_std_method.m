function label = label_shallow_turn_std_method(run_displacement,...
    frame_window,std_threshold,frame_threshold)

label = cell(length(run_displacement),1);
for i = 1:length(run_displacement)
    theta = get_theta_from_points(run_displacement{i,1});
    std_of_theta = std_of_theta_in_a_window(theta,frame_window);
    label_of_a_run = zeros(1,length(theta)+1);
    if length(label_of_a_run) > frame_threshold
        if ~isempty(std_of_theta)
            mask = std_of_theta > std_threshold;
            for j = 1:length(mask)
                if mask(j) == 1
                    label_of_a_run(j:j+frame_window) = 1;
                end
            end
        end
    end
    label_of_a_run(end) = 0; %to make label of a run the same length as this run.
    label{i} = label_of_a_run;
end

end