% allocate angles (theta, delta theta, etc) to 4 regions according to theta_in
%
% 2023-09-30, Yixuan Li
%

function [vector_1,vector_2,vector_3,vector_4]...
    = allocate_angles_to_4_regions(option_taxis,theta_in,cell_array)

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
end

% init
vector_1 = [];
vector_2 = [];
vector_3 = [];
vector_4 = [];

% allocate
for i = 1:length(cell_array)
    if is_region_1(i)
        vector_1 = [vector_1 cell_array{i}];
    elseif is_region_2(i)
        vector_2 = [vector_2 cell_array{i}];
    elseif is_region_3(i)
        vector_3 = [vector_3 cell_array{i}];
    elseif is_region_4(i)
        vector_4 = [vector_4 cell_array{i}];
    end
end

end