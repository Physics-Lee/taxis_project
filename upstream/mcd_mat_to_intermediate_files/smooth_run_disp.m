function run_disp_smoothed = smooth_run_disp(run_disp,window_size)

n = length(run_disp);
run_disp_smoothed = cell(n,1);
for i = 1:n
    run_disp_now = run_disp{i};
    x = run_disp_now(1,:);
    y = run_disp_now(2,:);
    x_smoothed = smoothdata(x, 'movmean', window_size);
    y_smoothed = smoothdata(y, 'movmean', window_size);
    run_disp_smoothed{i} = [x_smoothed;y_smoothed];
end

end