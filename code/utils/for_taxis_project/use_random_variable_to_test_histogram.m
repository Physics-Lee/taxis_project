% use random variables to test histogram of linear, semilogy and loglog.
%
% 2023-10-30, Yixuan Li
%

n_sample = 10000;
x = randn(n_sample);
x = abs(x);

figure;
histogram(x);

figure;
histogram(x);
set_semilogy;

figure;
histogram(x);
set_loglog;