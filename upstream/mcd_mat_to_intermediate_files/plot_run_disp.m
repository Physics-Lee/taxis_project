% only plot run disp, no reoriention disp.
%
% 2023-11-05, Yixuan Li
%

function plot_run_disp(run_disp_merged,f_sample,color,legend_str)

figure;
x = run_disp_merged(1,:);
y = run_disp_merged(2,:);
scatter(x,y,color);
axis equal;
xlabel('x(mm)');
ylabel('y(mm)');
title(['f sample = ' num2str(f_sample) 'Hz']);
legend(legend_str)

end