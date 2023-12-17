% One of 2 mostly used normalization methods
%
% Yixuan Li, 2023-12-05
%

function y = normalization_to_0_1(x)

y = (x - min(x))./(max(x) - min(x));

end