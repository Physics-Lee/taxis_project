function [theta_delta_region_1, theta_delta_region_2, theta_delta_region_3, theta_delta_region_4] = partition(theta_in,theta_delta,type_of_taxis) % partition the second parameter by the first parameter

theta_in = theta_in + pi; % from [-pi,+pi] to [0,+2pi]
if contains(type_of_taxis,'NC') ||  contains(type_of_taxis,'NT') || contains(type_of_taxis,'Pa')
    the_most_wrong_direction = pi;
end
if contains(type_of_taxis,'ortho')
    the_most_wrong_direction = 5/4 * pi;
end

number_of_regions = 4; % 2 4 6 8
part = 2 * pi / ( 2 * number_of_regions );

partition = floor( (theta_in - the_most_wrong_direction) / part );
partition_unique = unique(partition);

switch number_of_regions
    case 4
        index_of_0 = find(~partition_unique);
        flag_test = false(4,length(theta_delta));
        for i = 1:4
            index(1,i) = my_mod(index_of_0 - i,2*number_of_regions);
            index(2,i) = my_mod(index_of_0 + (i-1),2*number_of_regions);
            flag_test(i,:) = partition == partition_unique(index(1,i)) | partition == partition_unique(index(2,i));
            histogram_theta_delta(theta_delta(flag_test(i,:)),type_of_C_elegans,type_of_taxis,i);
        end
end

end