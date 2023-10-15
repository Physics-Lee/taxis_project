function is_passed = screen_a_track_test_t(track)

% set threshold
t_threshold_1 = 200; % s
t_threshold_2 = 800;

% get the last Ind of the last run
number_of_run = length(track.run);
if number_of_run >= 1
    t_1 = track.run(number_of_run).endInd;
else
    t_1 = 0;
end

% get the last Ind of the last reorientation
number_of_reorientation = length(track.reorientation);
if number_of_reorientation >= 1
    t_2 = track.reorientation(number_of_reorientation).endInd;
else
    t_2 = 0;
end

% calculate the max Ind
if t_1 > t_2
    max_Ind = t_1;
else
    max_Ind = t_2;
end

% calculate the ratio and the max time
ratio_of_this_track = track.run(number_of_run).runTime/(track.run(number_of_run).endInd - track.run(number_of_run).startInd);
max_time = max_Ind * ratio_of_this_track;

% compare the max time with the threshold
if max_time >= t_threshold_1 && max_time <= t_threshold_2
    is_passed = 1;
else
    is_passed = 0;
end

end