% Allocate angles (theta, Delta theta, etc) to 4 regions according to theta_in
%
% 2023-11-06, Yixuan Li
%

function [cell_1,cell_2,cell_3,cell_4]...
    = allocate_angles_to_4_regions_and_remain_cell_array(option_taxis,theta_in,cell_array_of_angles)

% allocate according to theta in
if option_taxis == "NC" || option_taxis == "NT"
    is_region_1 = theta_in > -1/4*pi & theta_in < +1/4*pi;
    is_region_2 = theta_in > +1/4*pi & theta_in < +3/4*pi;
    is_region_3 = theta_in > +3/4*pi | theta_in < -3/4*pi;
    is_region_4 = theta_in > -3/4*pi & theta_in < -1/4*pi;
elseif option_taxis == "Or" || option_taxis == "Ctl" || option_taxis == "Pa"
    is_region_1 = theta_in > 0 & theta_in < pi/2;
    is_region_2 = theta_in > pi/2;
    is_region_3 = theta_in < -pi/2;
    is_region_4 = theta_in < 0 & theta_in > -pi/2;
elseif option_taxis == "NC_Runhui"
    is_region_1 = theta_in > +1/4*pi & theta_in < +3/4*pi;
    is_region_2 = theta_in > +3/4*pi | theta_in < -3/4*pi;
    is_region_3 = theta_in > -3/4*pi & theta_in < -1/4*pi;
    is_region_4 = theta_in > -1/4*pi & theta_in < +1/4*pi;
end

% allocate
cell_1 = cell_array_of_angles(is_region_1);
cell_2 = cell_array_of_angles(is_region_2);
cell_3 = cell_array_of_angles(is_region_3);
cell_4 = cell_array_of_angles(is_region_4);

end