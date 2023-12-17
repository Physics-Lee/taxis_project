% add linear fit to test Poisson process, using least square and calculate 
% the coefficient of determination
%
% SS means Sum of Square
%
% use pdf, instead of probability, to get lambda in the future.
%
% 2023-11-05, Yixuan Li
%

function [slope,intercept] = add_linear_fit(time_of_disp, edges)

%% Least Square

% get y_data
[y_data, bin_edges] = histcounts(time_of_disp, edges(2:end-1), 'Normalization', 'pdf');

% get bin centers
bin_centers = (bin_edges(1:end-1) + bin_edges(2:end))/2;

% avoid log(0)
non_zero_inds = y_data > 0;

% linear fit, using least square
fit_coeffs = polyfit(bin_centers(non_zero_inds), log(y_data(non_zero_inds)), 1);

% get y_predict
y_predict = polyval(fit_coeffs, bin_centers);

%% Compute the coefficient of determination

SS_residue = sum((log(y_data(non_zero_inds)) - y_predict(non_zero_inds)).^2);
SS_total = (length(log(y_data(non_zero_inds)))-1) * var(log(y_data(non_zero_inds)));
r_squared = 1 - SS_residue/SS_total;

%% Plot

% Plot the linear fit and scatter points on the semilogy plot
hold on;
h_scatter = scatter(bin_centers(non_zero_inds), y_data(non_zero_inds), 'blue',"filled");
h_fit = semilogy(bin_centers, exp(y_predict), 'r-');

% legend
slope = fit_coeffs(1);
intercept = fit_coeffs(2);
legend([h_scatter, h_fit], 'Data Points', sprintf('Slope: %.2f, Intercept: %.2f', slope, intercept));

% text
text(0.8, 0.8, ['R^2 = ' num2str(r_squared)], 'Units', 'normalized');

hold off;

end