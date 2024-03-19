function label_rearranged_numerical_array = cell2numerical_for_label_arranged(label_rearranged)
label_rearranged_temp = label_rearranged(2:end,1:3);
numerical_array = cellfun(@(x) double(strcmp(x, 'forward')), label_rearranged_temp(:,3));
numerical_array_columns_1_2 = cell2mat(label_rearranged_temp(:, 1:2));
label_rearranged_numerical_array = [numerical_array_columns_1_2, numerical_array];
end