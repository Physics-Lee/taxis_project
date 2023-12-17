% return abs(theta_2 - theta_1)
% theta_2 is a vector
%
% 2023-09-28, Yixuan Li
%

function delta_theta = my_diff_v2(theta_1,theta_2)

delta_theta = zeros(1,length(theta_2));

for i = 1:length(theta_2)
    threshold = pi;
    if abs(theta_2(i) - theta_1) <= threshold
        delta_theta(i) = theta_2(i) - theta_1;
    elseif theta_2(i) - theta_1 > threshold
        delta_theta(i) = (theta_2(i) - theta_1) - 2*pi;
    elseif theta_2(i) - theta_1 < -threshold
        delta_theta(i) = (theta_2(i) - theta_1) + 2*pi;
    end
end

end