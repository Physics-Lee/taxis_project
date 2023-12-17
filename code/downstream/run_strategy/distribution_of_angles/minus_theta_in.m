% calculate theta - theta_in
%
% 2023-09-30, Yixuan Li
%

function [theta_minus_theta_in_vector,theta_minus_theta_in_cell] = minus_theta_in(theta_cell,theta_in)

theta_minus_theta_in_vector = [];
theta_minus_theta_in_cell = cell(length(theta_cell),1);
for i = 1:length(theta_cell)
    data_new = my_diff_v2(theta_in(i),theta_cell{i});
    theta_minus_theta_in_cell{i} = data_new;
    theta_minus_theta_in_vector = [theta_minus_theta_in_vector, data_new];
end

end