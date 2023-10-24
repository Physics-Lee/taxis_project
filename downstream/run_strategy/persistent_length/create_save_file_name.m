% create save file name based on measure, partition and ideal theta
%
% 2023-10-03, Yixuan Li
%

function save_file_name = create_save_file_name(option_measure,option_partition_region,option_ideal_theta)

save_file_name = strcat(option_measure,'___',option_partition_region,'___',option_ideal_theta);
save_file_name = strrep(save_file_name,'*','_');
save_file_name = strrep(save_file_name,'/','_');

end