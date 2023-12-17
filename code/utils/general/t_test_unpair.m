% Sample data
data1 = randn(30,1); % Random data for group 1
data2 = randn(30,1) + 1; % Random data for group 2 (with a different mean)

% Unpaired t-test
[h, p, ci, stats] = ttest2(data1, data2);

% Bar graph
means = [mean(data1), mean(data2)];
errors = [std(data1)/sqrt(length(data1)), std(data2)/sqrt(length(data2))];
bar(means);
hold on;
errorbar(means, errors, '.');
hold off;

% Display p-value
p_value_text = sprintf('p = %.3f', p);
text(1.5, max(means) + max(errors), p_value_text, 'HorizontalAlignment', 'center');

% Labels and Title
xlabel('Group');
ylabel('Mean Value');
title('Unpaired t-test and Bar Graph with P-value');