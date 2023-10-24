function is_passed = screen_a_track_by_max_displacement(track)

    d_threshold = 2; % mm
    trajectory = track.dq.displacement;
    x = trajectory(1,:)/22;
    y = trajectory(2,:)/22;
    displacement = sqrt(x.^2 + y.^2);
    if max(displacement) < d_threshold
        is_passed = 0;
    else
        is_passed = 1;
    end

end