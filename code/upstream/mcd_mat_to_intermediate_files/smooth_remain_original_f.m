% smooth
%
% 2023-11-05, Yixuan Li
%

function run_disp_smoothed = smooth_remain_original_f(run_disp)

% smooth
T = 3; % s
f_sample = 66;
window_size = f_sample*T;
run_disp_smoothed = smooth_run_disp(run_disp,window_size);

end