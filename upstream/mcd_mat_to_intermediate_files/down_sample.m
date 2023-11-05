% down-sample
%
% 2023-11-05, Yixuan Li
%

function run_disp_downsampled = down_sample(run_disp,f_sample_old,f_sample_new)

n = length(run_disp);
run_disp_downsampled = cell(n,1);
for i = 1:n
    run_disp_now = run_disp{i};
    frames = 1:round(f_sample_old/f_sample_new):length(run_disp_now);
    run_disp_downsampled{i} = run_disp_now(:,frames);
end

end