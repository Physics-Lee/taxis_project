% partition the whole plane to 4 regions where -1/2*pi is ideal direction
%
% 2023-09-27, Yixuan Li
%

function [corr,number_of_theta_in_of_each_region] = partition_NC_as_ideal(corr)

    % for theta from -pi to -3/4*pi, plus 2*pi
    theta = corr(:,1);
    mask = theta < -3/4*pi;
    theta(mask) = theta(mask) + 2*pi;
    corr(:,1) = theta;
    
    % sort
    corr = sortrows(corr,1);    

    % partition into 4 regions
    M = 4;
    x_bin_length = 2*pi/M;
    x_bins = -3/4*pi+x_bin_length/2:x_bin_length:5/4*pi-x_bin_length/2;
    number_of_theta_in_of_each_region = hist(corr(:,1),x_bins);
    
end