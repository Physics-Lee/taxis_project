% screen a theta_0 (the first theta of a run) by both theta threshold
%
% 2023-09-30, Yixuan Li
%

function is_passed = screen_a_theta_0(theta_0,theta_0_next)

    theta_threshold = 20; % deg
    theta_threshold = theta_threshold/180*pi;
    if my_diff_abs(theta_0,theta_0_next) < theta_threshold
        is_passed = 1;
    else
        is_passed = 0;
    end
    
end