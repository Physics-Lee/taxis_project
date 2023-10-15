function histogram_theta_delta(theta_delta,type_of_C_elegans,type_of_taxis,region)

% draw
number_of_bin = 20;
edges = [-pi -pi:2*pi/number_of_bin:+pi +pi];
histogram(theta_delta,edges,'Normalization','probability')
ylim([0 0.25])
xlabel('theta delta');
ylabel('frequency');
title([type_of_C_elegans ' ' type_of_taxis  ' '  'region\_' num2str(region)]);

% save
folder_name = ['D:\' type_of_C_elegans ' ' type_of_taxis '_frequecy_of_reorientation_versus_theta_conditional'];
if isfolder(folder_name) == 0
    mkdir(folder_name);
end
saveas(gcf,[folder_name '\' 'region_' num2str(region) '.png']);

% p-value of chi-square test
p_value = chi_square_test(theta_delta);

end