% partition the whole plane to conventional 4 quadrants
%
% 2023-09-27, Yixuan Li
%

function [corr,number_of_theta_in_of_each_region] = partition_conventional_quadrant(corr)

    % sort
    corr = sortrows(corr,1); 

    % partition into 4 regions
    M = 4;
    x_bin_length = 2*pi/M;
    x_bins = -pi + x_bin_length / 2 : x_bin_length : pi - x_bin_length / 2; % here is where Ping made mistakes
    number_of_theta_in_of_each_region = hist(corr(:,1),x_bins);

end