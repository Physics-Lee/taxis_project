function std_threshold = my_hist_with_Tukey_test(std_of_theta_all,IQR_index)
histogram_of_std_of_theta(std_of_theta_all);
[~, ~, ~, ~,...
    up_limit, down_limit, upper_bound, lower_bound] = ...
    Tukey_test(std_of_theta_all, IQR_index);
draw_lines(up_limit, down_limit, upper_bound, lower_bound);
std_threshold = up_limit;
end