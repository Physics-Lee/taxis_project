% Calculate the time of each run
%
% 2023-10-25, Yixuan Li
%

function t = calculate_t(n_frame)
f_sample = 2; % Hz
t = n_frame/f_sample;
end