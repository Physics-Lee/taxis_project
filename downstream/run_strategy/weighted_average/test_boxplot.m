% 创建一些随机数据
data = weighted_average;

% 画箱线图
boxplot(data);

% 获取当前轴句柄
ax = gca;

% 在箱线图上添加数据点
hold on;
for i = 1:size(data, 2)
    % 计算jitter（抖动）以防止点重叠
    jitter = 0.1 * (rand(size(data, 1), 1) - 0.5);
    
    % 画散点图
    scatter(i + jitter, data(:, i), 'r', 'filled');
end
hold off;

% 添加标题和轴标签
title('Boxplot with Individual Data Points');
xlabel('Category');
ylabel('Value');