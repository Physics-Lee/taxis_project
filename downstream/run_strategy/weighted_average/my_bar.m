% plot bar and error-bar
%
% 2023-10-25, Yixuan Li
%

function my_bar(measure_table,y_label_str,measure_str)

weighted_average = measure_table.weighted_average;
weighted_std = measure_table.weighted_std;

% plot bar
figure;
hold on;
barHandle = bar(weighted_average);

% plot error-bar
x = barHandle.XData + barHandle.XOffset;
y = weighted_average;
e = weighted_std;
errorbar(x, y, e, 'k', 'linestyle', 'none');

% label and tick
xlabel('track or worm');
ylabel(y_label_str);
xticks(1:length(weighted_average));
xticklabels(measure_table.info);

% lim
ylim([0,0.2]); % mm/s

% full screen
% set(gcf, 'WindowState', 'maximized');

end