function histogram_for_theta_using_ploar(theta_rad, xlabel_str)

% hist count
theta_deg = theta_rad / pi * 180;
edges = -180:30:180;
[counts, ~] = histcounts(theta_deg,edges,'Normalization','probability');

% polarplot
figure;
edges_new = edges(1:end-1);
polarplot(edges_new, sqrt(counts));

% 获取 PolarAxes 对象的句柄
ax = gca;

% 设置线条属性，使其不连线
set(ax, 'LineStyle', 'none');

end
