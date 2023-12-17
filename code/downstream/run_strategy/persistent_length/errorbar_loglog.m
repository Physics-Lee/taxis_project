% draw the unsymmetric error-bar plot on loglog for 4 regions.
%
% 2023-10-10, Yixuan Li
%

function errorbar_loglog

% set both x-axis and y-axis to logrithm scale
set(gca, 'XScale', 'log', 'YScale', 'log');

% set y_lim to make comparison between figures.
x_limits = [0 10^(log(2)/log(10))]; % log_{10}^{2} = log_{e}^{2} / log_{e}^{10}
y_limits = [10^(-1) 10^(0)];
xlim(x_limits)
ylim(y_limits);

end