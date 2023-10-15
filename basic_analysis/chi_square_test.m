function p_value = chi_square_test(theta_delta)

number_of_bins = 20;
edges = [-pi -pi:2*pi/number_of_bins:+pi +pi];
h = histogram(theta_delta,edges);
Observed = h.Values(2:21);
len = length(Observed);
N = sum(Observed);
Expected = N/len * ones(1,20);
chi_square = sum((Observed - Expected).^2./Expected);
degree_of_freedom = len - 1;
p_value = 1 - chi2cdf(chi_square, degree_of_freedom);
fprintf("p_value = %.4f\n",p_value);

end