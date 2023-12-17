% Very useful when analyzing the calcium time series.
%
% Yixuan Li, 2023-12-05
%

function y = normalization_dividing_by_the_mean(x)

y = (x - mean(x,'omitnan'))./mean(x,'omitnan');

end