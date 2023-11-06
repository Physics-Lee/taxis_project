function visualize_a_track_v3(track)
    trajectory = track.dq.displacement;
    x = trajectory(1,:);
    y = trajectory(2,:);
    bool_vec = track.isrun;
    scatter(x(bool_vec), y(bool_vec), 'b');
    hold on;
    scatter(x(~bool_vec), y(~bool_vec), 'r');
    xlabel('x');
    ylabel('y');
end