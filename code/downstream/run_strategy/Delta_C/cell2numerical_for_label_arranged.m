function label_rearranged_numerical_array = cell2numerical_for_label_arranged(label_rearranged)
% From cell array to numerical array for "label_rearranged". 1 for
% "forward", 0 for "reorientation", and 2 for "outlier".
%
% 2024-03-25, Yixuan Li
%

% Extract the relevant portion of the cell array
label_rearranged_temp = label_rearranged(2:end,1:3);

% Convert "forward" to 1
numerical_forward = cellfun(@(x) double(strcmp(x, 'forward')), label_rearranged_temp(:,3));

% Convert "reorientation" to 0
numerical_reorientation = cellfun(@(x) double(strcmp(x, 'reorientation')), label_rearranged_temp(:,3)) * 0;

% Convert "outlier" to 2
numerical_outlier = cellfun(@(x) double(strcmp(x, 'outlier')), label_rearranged_temp(:,3)) * 2;

% Combine the numerical representations. 
% Since "forward" and "reorientation" are exclusive and represented as 1 and 0 respectively,
% adding "outlier" which is represented as 2 will not interfere.
% This assumes the labels are mutually exclusive.
numerical_label = numerical_forward + numerical_reorientation + numerical_outlier;

% Convert the first two columns of the cell array to a numerical array
numerical_array_columns_1_2 = cell2mat(label_rearranged_temp(:, 1:2));

% Combine the first two columns with the newly generated numerical label column
label_rearranged_numerical_array = [numerical_array_columns_1_2, numerical_label];
end