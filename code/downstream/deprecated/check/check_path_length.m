ds = ds_of_a_track(track);
my_path_length = cumsum(ds);
if sum(abs(my_path_length - track.dq.pathLength)) < 0.01
    disp('The path length of this track is right.\n');
end