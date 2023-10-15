function [label_0,ratio_0_5,ratio_0_1,ratio_0_0] = label_reorientation_ortho_v2(theta_in,theta_out)
    count_0 = 0;
    count_0_5 = 0;
    count_0_1 = 0; % wrong to right    
    count_0_0 = 0; % wrong to wrong
    label_0 = [];
    for i = 1:length(theta_in)
        if theta_in(i) > pi*1/2 || theta_in(i) < -pi*1/2
        else
            count_0 = count_0 + 1;
            if abs(theta_out(i)-theta_in(i)) < 10/180*pi
                count_0_5 = count_0_5 + 1;
                label_0(end+1) = 0.5;
            else
                if my_abs_NC_NT(theta_out(i)) < my_abs_NC_NT(theta_in(i))
                    count_0_1 = count_0_1 + 1;
                    label_0(end+1) = 1;
                else
                    count_0_0 = count_0_0 + 1;
                    label_0(end+1) = 0;
                end
            end
        end
    end
    label_0 = label_0';
    ratio_0_5 = count_0_5/count_0;
    ratio_0_1 = count_0_1/count_0;
    ratio_0_0 = count_0_0/count_0;    
end