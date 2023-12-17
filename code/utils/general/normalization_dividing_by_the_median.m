% Very useful when comparing the citation count of 2 scientists.
%
% Yixuan Li, 2023-12-05
%

function y = normalization_dividing_by_the_median(x)

y = x./median(x,'omitnan');

end