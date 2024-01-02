% Set the first point of the trajectory as (0,0)
%
% 2024-01-02, Yixuan Li
%

function all_disp = set_the_first_point_as_the_origin(all_disp)
all_disp(1,:) = all_disp(1,:) - all_disp(1,1);
all_disp(2,:) = all_disp(2,:) - all_disp(2,1);
end