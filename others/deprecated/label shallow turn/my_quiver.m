function my_quiver(run_disp,theta,label,my_start,my_end)
    my_scatter(run_disp,label,my_start,my_end);

    for i = my_start:my_end

        % define points and theta
        points = run_disp{i,1};
        theta_of_a_run = theta{i,1};

        % Calculate the number of points
        n = size(points, 2);

        % Normalize theta to obtain unit vectors
        unit_vectors = [cos(theta_of_a_run); sin(theta_of_a_run)];

        % Plot unit vectors at each point
        quiver(points(1,1:n-1), points(2,1:n-1), unit_vectors(1,:), unit_vectors(2,:),0.1, 'Color', 'green');
        
    end
    
    % Add labels and legend
    xlabel('x (mm)');
    ylabel('y (mm)');    
    title_str = inputname(2);
    title_str = strrep(title_str,'_',' ');
    title(title_str);
    legend('forward','shallow turn',title_str);
end