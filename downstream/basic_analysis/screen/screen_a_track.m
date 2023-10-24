% screen a track by both t threshold and d threshold
%
% 2023-09-26, Yixuan Li
%

function is_passed = screen_a_track(track)

%% time threshold
% set threshold
t_threshold = 200; % s; % don't change it casually since 2023-03-25 11:36

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
if max_time >= t_threshold
    is_passed_1 = 1;
else
    is_passed_1 = 0;
end

%% displacement threshold
d_threshold = 2; % mm
trajectory = track.dq.displacement;
x = trajectory(1,:)/22;
y = trajectory(2,:)/22;
displacement = sqrt(x.^2 + y.^2);
is_passed_2 = max(displacement) >= d_threshold;

%% Overall screening result
is_passed = is_passed_1 & is_passed_2;

end