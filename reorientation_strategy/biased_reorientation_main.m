% all_eset = read_all_eset;
n = size(all_eset,1);
for i = 1:n
    eset = all_eset{i,1}.eset;
    eset_info = all_eset{i,2};
    % theta_delta_conditioned_by_theta_in_v2(eset,eset_info);
    my_delete(eset_info);
end