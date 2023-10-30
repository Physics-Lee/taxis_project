% 创建一些随机数据
data = randn(100, 3);

% 画小提琴图
violinplot(data);

% 添加标题和轴标签
title('Violin Plot Example');
xlabel('Category');
ylabel('Value');
