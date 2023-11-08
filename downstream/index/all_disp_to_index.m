% Calculate the index of each track or worm and save the mean.
%
% option_measure: "chemo-index-left", "chemo-index-down", "thermo-index", "ortho-index"
%
% index := cos_to_ideal * tortuosity
%
% 2023-11-08, Yixuan Li
%

clear;clc;close all;

dbstop if error;

option_measure = "chemo-index-left";

% use GUI to choose .mat files
path = uigetdir;

% if choose a folder
if path ~= 0

    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path,'all_disp_of_*.mat');
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Choose files');

    if tf == 1

        % init
        n_worm = length(indx);
        index = zeros(n_worm,1);
        count = 0;

        % loop to calculate the index for each track or worm
        for i = indx

            count = count + 1;

            % load
            full_path = list{i};
            all_disp = load_data_from_mat(full_path);

            % for save
            [folder_path,file_name,~] = fileparts(full_path);
            folder_path_to_eset = fileparts(folder_path);

            % for Colbert data which are not done within 1 day
            if contains(folder_path_to_eset,'all_disp_of')
                folder_path_to_eset = fileparts(folder_path_to_eset);
            end

            % switch
            switch option_measure
                case "chemo-index-down"
                    ideal_unit_vector = [0 -1];
                case "chemo-index-left"
                    ideal_unit_vector = [-1 0];
                case "thermo-index"
                    ideal_unit_vector = [-1 0];
                case "ortho-index"
                    ideal_unit_vector = [-1 -1]/sqrt(2);
            end

            % calculate and save
            index(count) = calculate_index_of_all_disp_of_a_worm(all_disp,ideal_unit_vector);

        end

        % save
        save_folder_name = "index";
        save_folder_path = fullfile(folder_path_to_eset,save_folder_name);
        create_folder(save_folder_path);
        save_file_name = option_measure;
        save_full_path = fullfile(save_folder_path,save_file_name);
        save_full_path_csv = strcat(save_full_path,'.csv');
        writematrix(index, save_full_path_csv);

        % index
        Mean_of_worms = mean(index);
        SEM_of_worms = std(index)/sqrt(length(index));
        fprintf('mean of worms: %.4f\n',Mean_of_worms);
        fprintf('SEM of worms: %.4f\n',SEM_of_worms);

    end
end