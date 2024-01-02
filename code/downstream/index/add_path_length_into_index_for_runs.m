% add the path length to index-for-runs
%
% 2024-01-02, Yixuan Li
%

clc;clear;close all;

%% load data
root_folder_path = uigetdir;
list_eset = get_all_files_of_a_certain_name_pattern_in_a_rootpath(root_folder_path,'eset.mat');
[indx,tf] = listdlg('ListString',list_eset,'ListSize',[800,600],'Name','Choose files');
for i = indx
    full_path_to_eset = list_eset{i};

    %% load path length
    folder_path_to_path_length = fullfile(fileparts(full_path_to_eset),'path_length_of_each_worm');
    full_path_to_path_length = fullfile(folder_path_to_path_length,'path_length_of_each_worm.csv');
    path_length = readtable(full_path_to_path_length);
    path_length_numerical = path_length.path_length_mm;

    %% load index
    folder_path_to_weighted_average = fullfile(fileparts(full_path_to_eset),'weighted_average');
    list_csv = get_all_files_of_a_certain_name_pattern_in_a_rootpath(folder_path_to_weighted_average,'*.csv');
    
    if isempty(list_csv)
        disp("This eset.mat folder has no such .csv files!");
        continue;
    end

    for j = 1:length(list_csv)

        full_path_to_csv = list_csv{j};
        index = readmatrix(full_path_to_csv);

        if size(index,2) == 2
            disp("This .csv already has 2 columns!");
            continue;
        end

        %% concatenate
        index_weight = horzcat(index,path_length_numerical);
        index_weight_table = array2table(index_weight, 'VariableNames', {'index', 'path_length_mm'});

        %% save
        writetable(index_weight_table,full_path_to_csv);

    end

end