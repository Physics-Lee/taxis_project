% smooth-downsample-smooth
%
% 2023-11-05, Yixuan Li
%

function run_disp_smoothed_downsampled_smoothed = smooth_to_desire_f(run_disp,f_sample_old,f_sample_new)

% smooth
T = 3; % s
f_sample = 66;
window_size = f_sample*T;
run_disp_smoothed = smooth_run_disp(run_disp,window_size);

% downsample
run_disp_smoothed_downsampled = down_sample(run_disp_smoothed,f_sample_old,f_sample_new);

% smooth
window_size = 11;
run_disp_smoothed_downsampled_smoothed = smooth_run_disp(run_disp_smoothed_downsampled,window_size);

end