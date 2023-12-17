% To handle the situation of crossing the line, I make the neighbor of the
% edge to be 0.
%
% Input: deg
% Output: deg
%
% 2023-10-31, Yixuan Li
%

function result = set_neighbor_to_0(Delta_theta)

angle_threshold = 30; % deg
if Delta_theta <= angle_threshold
    result = 0;
elseif Delta_theta > angle_threshold
    result = Delta_theta;
end

end