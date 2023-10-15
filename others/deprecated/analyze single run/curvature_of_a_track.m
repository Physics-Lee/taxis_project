function curvature = curvature_of_a_track(track)
    ds = ds_of_a_track(track);    
    dtheta = [0, diff(track.dq.theta,1)];
    curvature = abs(dtheta./ds);
end