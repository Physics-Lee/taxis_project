function region_flags = split_4_regions(theta_mean, theta_ideal)

% init
region_flags = nan(size(theta_mean,1),1);

% split
if theta_ideal == +pi
    region_flags(theta_mean < +pi & theta_mean > +7/8*pi) = 3;
    region_flags(theta_mean > -pi & theta_mean < -7/8*pi) = 3;
    region_flags(theta_mean > -5/8*pi & theta_mean < -3/8*pi) = 4;
    region_flags(theta_mean > -1/8*pi & theta_mean < +1/8*pi) = 1;
    region_flags(theta_mean > +3/8*pi & theta_mean < +5/8*pi) = 2;
elseif theta_ideal == -3/4*pi
    region_flags(theta_mean > -7/8*pi & theta_mean < -5/8*pi) = 3;
    region_flags(theta_mean > -3/8*pi & theta_mean < -1/8*pi) = 4;
    region_flags(theta_mean > +1/8*pi & theta_mean < +3/8*pi) = 1;
    region_flags(theta_mean > +5/8*pi & theta_mean < +7/8*pi) = 2;
elseif theta_ideal == -1/2*pi
    region_flags(theta_mean < +pi & theta_mean > +7/8*pi) = 2;
    region_flags(theta_mean > -pi & theta_mean < -7/8*pi) = 2;
    region_flags(theta_mean > -5/8*pi & theta_mean < -3/8*pi) = 3;
    region_flags(theta_mean > -1/8*pi & theta_mean < +1/8*pi) = 4;
    region_flags(theta_mean > +3/8*pi & theta_mean < +5/8*pi) = 1;
else
    error("theta_ideal is not right!");
end

% disp
percentage_region_1 = sum(region_flags == 1) / size(theta_mean, 1) * 100;
percentage_region_2 = sum(region_flags == 2) / size(theta_mean, 1) * 100;
percentage_region_3 = sum(region_flags == 3) / size(theta_mean, 1) * 100;
percentage_region_4 = sum(region_flags == 4) / size(theta_mean, 1) * 100;

disp("run percentage:");
fprintf('Region 1: %.2f%%\n', percentage_region_1);
fprintf('Region 2: %.2f%%\n', percentage_region_2);
fprintf('Region 3: %.2f%%\n', percentage_region_3);
fprintf('Region 4: %.2f%%\n', percentage_region_4);
fprintf('Others: %.2f%%\n', 100 - percentage_region_1 - percentage_region_2 - percentage_region_3 - percentage_region_4);

end