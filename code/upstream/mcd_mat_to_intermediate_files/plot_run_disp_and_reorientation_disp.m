% plot run and reorientation
%
% 2023-11-05, Yixuan Li
%

function plot_run_disp_and_reorientation_disp(run_disp_merged,reorientation_disp_merged)

figure;
hold on;
axis equal;

x_run = run_disp_merged(1,:);
y_run = run_disp_merged(2,:);
scatter(x_run,y_run,'blue');

x_reorientation = reorientation_disp_merged(1,:);
y_reorientation = reorientation_disp_merged(2,:);
scatter(x_reorientation,y_reorientation,'red');

scatter(x_run(1),y_run(1),'cyan','filled');
scatter(x_run(end),y_run(end),'magenta','filled');

xlabel('x(mm)');
ylabel('y(mm)');

f_sample = 66;
title(['f sample = ' num2str(f_sample) 'Hz']);

legend('run','reorientation','start','end');

end