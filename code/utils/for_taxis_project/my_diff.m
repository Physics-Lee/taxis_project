% return theta_2 - theta_1
% theta_2 is a number
%
% 2023-09-28, Yixuan Li
%

function delta_theta = my_diff(theta_1,theta_2)

threshold = pi;
if abs(theta_2 - theta_1) <= threshold
    delta_theta = theta_2 - theta_1;
elseif theta_2 - theta_1 > threshold
    delta_theta = (theta_2 - theta_1) - 2*pi;
elseif theta_2 - theta_1 < -threshold
    delta_theta = (theta_2 - theta_1) + 2*pi;
end

end