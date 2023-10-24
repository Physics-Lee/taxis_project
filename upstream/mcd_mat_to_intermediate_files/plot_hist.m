function plot_hist(v)

    n_exp = length(v);
    n_bin = 20;
    my_edges = 5:10:85;
    folder_path = 'F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\result\hist_edge_semilogy';
    
    for i = 1:n_exp
        v_now = v{i};
    
        % plot for v
        % figure;
        % histogram(v_now(:,1), n_bin);
        % xlabel('index');
        % ylabel('count');
        % saveas(gcf, fullfile(folder_path, ['hist_index_exp_' num2str(i) '.png']), 'png');
    
        % plot for t
        
        t = v_now(:,2);
        t = t(t<85);    
        t_semilogy_v2(t,my_edges)
        saveas(gcf, fullfile(folder_path, ['hist_t_exp_' num2str(i) '.png']), 'png');
    
    end
    
    close all;

end

function t_semilogy_v2(t,my_edges)

% 计算直方图
[N, edges] = histcounts(t, my_edges); 

% 计算 bin 中心
binCenters = edges(1:end-1) + diff(edges)/2;

% 创建直方图
bar(binCenters, N); 
hold on;

% 创建散点图
scatterHandle = scatter(binCenters, N, 'blue',"filled");

% 使用 semilogy 创建半对数图
set(gca, 'YScale', 'log');

% 进行线性拟合
coefficients = polyfit(binCenters, log(N + 1), 1); 
yFitted = polyval(coefficients, binCenters); 

% 画出拟合线
fitHandle = plot(binCenters, exp(yFitted), 'r-');

% 设定轴标签
xlabel('t(s)');
ylabel('Count (log scale)');
xticks(0:5:100);

% 添加图例
slope = coefficients(1);
intercept = coefficients(2);
legend([scatterHandle fitHandle], 'Scatter', sprintf('Linear Fit (slope = %.4f)', slope));

% 计算 R^2
SSresid = sum((N - exp(yFitted)).^2);
SStotal = (length(N)-1) * var(N);
rsq = 1 - SSresid/SStotal;

% 显示 R^2
text(0.8, 0.8, ['R^2 = ' num2str(rsq)], 'Units', 'normalized');

hold off;

end
