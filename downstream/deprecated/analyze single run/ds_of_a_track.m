function ds = ds_of_a_track(track)
    r = track.dq.displacement;
    ds = [0, sqrt(sum(diff(r,1,2).^2))];
end