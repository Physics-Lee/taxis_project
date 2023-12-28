% plot bar and error-bar
%
% 2023-10-25, Yixuan Li
%

function my_bar(measure_table,y_label_str,y_lim_range)

weighted_average = measure_table.weighted_average;
weighted_SEM = measure_table.weighted_SEM;

% plot bar
figure;
hold on;
barHandle = bar(weighted_average);

% plot error-bar
x = barHandle.XData + barHandle.XOffset;
y = weighted_average;
e = weighted_SEM;
errorbar(x, y, e, 'k', 'linestyle', 'none');

% label
xlabel('worm');
ylabel(y_label_str);

% tick
% xticks(1:length(weighted_average));
% xticklabels(measure_table.info);

% title
title('error bar for SEM');
subtitle('error bar capturing the deviance of runs');

% lim
ylim(y_lim_range);

end