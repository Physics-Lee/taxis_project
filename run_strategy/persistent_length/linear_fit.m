% Perform linear fit on semilogy to get the persistent length.
%
% 2023-09-26, Yixuan Li
%

function L = linear_fit(path_length, mean_of_data)

% perform linear fit in semilogy
d_threshold_down = 0.125; %mm
d_threshold_up = 2; % mm
mask = path_length < d_threshold_up & path_length > d_threshold_down & mean_of_data > 0;
coefficients = polyfit(path_length(mask), log(mean_of_data(mask)), 1);

% calculate L
slope = coefficients(1);
L = -1/slope;

end