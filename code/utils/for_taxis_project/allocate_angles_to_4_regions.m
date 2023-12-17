% Allocate angles (theta, Delta theta, etc) to 4 regions according to theta_in
%
% Input:
% - option_taxis: contains info of taxis.
% - theta_in: theta in of each cell
% - array_of_angles: cell array (most case) or numerical array of angles 
% (only for biased reorientation).
%
% Output: 4 numerical array of 4 regions.
%
% 2023-11-06, Yixuan Li
%

function [vector_1,vector_2,vector_3,vector_4]...
    = allocate_angles_to_4_regions(option_taxis,theta_in,array_of_angles)

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

% init
vector_1 = [];
vector_2 = [];
vector_3 = [];
vector_4 = [];

% for cell array
if iscell(array_of_angles)
    for i = 1:length(array_of_angles)
        if is_region_1(i)
            vector_1 = [vector_1 array_of_angles{i}];
        elseif is_region_2(i)
            vector_2 = [vector_2 array_of_angles{i}];
        elseif is_region_3(i)
            vector_3 = [vector_3 array_of_angles{i}];
        elseif is_region_4(i)
            vector_4 = [vector_4 array_of_angles{i}];
        end
    end
end

% for numerical array
if isnumeric(array_of_angles)
    vector_1 = array_of_angles(is_region_1);
    vector_2 = array_of_angles(is_region_2);
    vector_3 = array_of_angles(is_region_3);
    vector_4 = array_of_angles(is_region_4);
end

end