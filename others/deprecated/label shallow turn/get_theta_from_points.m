function theta = get_theta_from_points(points)
    % points should be 2*n, the first line is x coordinates, the second 
    % line is y coordinates
    v_direction = (points(:, 2:end) - points(:, 1:end - 1)); % disp vectors
    theta = unwrap(atan2(v_direction(2,:), v_direction(1,:))); % unwrap can take place of my_diff
end