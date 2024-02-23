function theta_mean = calculate_mean_theta(theta_cell)

theta_mean = nan(size(theta_cell,1),1);

for i = 1:size(theta_cell,1)
    theta_mean(i) = mean(theta_cell{i});
end

end