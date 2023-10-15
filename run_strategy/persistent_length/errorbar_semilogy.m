% draw the unsymmetric error-bar plot on semilogy for 4 regions.
%
% 2023-10-10, Yixuan Li
%

function errorbar_semilogy

% set y-axis to logrithm scale
set(gca, 'YScale', 'log');

% set y_lim to make comparison between figures.
y_limits = [10^(-1) 10^(0)];
ylim(y_limits);

end