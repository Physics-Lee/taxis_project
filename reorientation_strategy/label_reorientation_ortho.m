function [ratio_0_1,ratio_1_1,label_0,label_1,label] = label_reorientation_ortho(theta_in,theta_out)
    count_1 = 0;
    count_0 = 0;
    count_1_1 = 0; % right to right
    count_0_1 = 0; % wrong to right
    label_0 = [];
    label_1 = [];
    label = zeros(length(theta_in),1);
    for i = 1:length(theta_in)
        if theta_in(i) < -pi*1/4 || theta_in(i) > +pi*3/4
            count_1 = count_1 +  1;
            if theta_out(i) < -pi*1/4 || theta_out(i) > +pi*3/4
                count_1_1 = count_1_1 + 1;
                label_1(end+1) = 1;
                label(i) = 1;
            else
                label_1(end+1) = 0;
                label(i) = 0;
            end
        else
            count_0 = count_0 + 1;
            if my_abs_ortho(theta_out(i)) < my_abs_ortho(theta_in(i))
                count_0_1 = count_0_1 + 1;
                label_0(end+1) = 1;
                label(i) = 1;
            else
                label_0(end+1) = 0;
                label(i) = 0;
            end
        end
    end
    ratio_0_1 = count_0_1/count_0;
    ratio_1_1 = count_1_1/count_1;
    label_0 = label_0';
    label_1 = label_1';
end