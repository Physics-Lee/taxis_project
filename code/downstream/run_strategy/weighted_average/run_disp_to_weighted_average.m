% Calculate the weighted average of each track or worm and save the mean.
%
% option_measure: "velocity", "chemo-index-left", "chemo-index-down", "thermo-index", "ortho-index"
%
% index := cos_to_ideal * tortuosity
%
% 2023-10-25, Yixuan Li
%

dbstop if error;
clear;clc;close all;

%% option
option_measure = "thermo-index";
type_of_run_disp = "each_worm";

%%
path = uigetdir;
if path ~= 0

    switch type_of_run_disp
        case "each_worm"
            list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path,'run_disp_of_worm_*.mat');
        case "each_track"
            list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path,'run_disp_of_track_*.mat');
    end

    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Choose files');
    
    if tf == 1

        % init
        measure_cell = cell(length(indx),2);

        % loop to process all run disps of each worm.
        count = 0;
        for i = indx

            %% load
            full_path = list{i};
            run_disp = load_data_from_mat(full_path);

            %% file name

            % for save
            [folder_path,file_name,~] = fileparts(full_path);
            folder_path_to_eset = fileparts(folder_path);

            % info is the serial number of the track
            info_str = strrep(file_name,'_',' ');
            info_str = strrep(info_str,'run disp of worm ','');
            info_str = strrep(info_str,'run disp of track ','');
            info_str = strrep(info_str,' corrected','');

            % for Colbert data which are not done within 1 day
            if contains(folder_path_to_eset,'run_disp_of')
                folder_path_to_eset = fileparts(folder_path_to_eset);
            end

            %% calculate
            switch option_measure
                case "velocity"
                    measure = calculate_v(run_disp);
                case "chemo-index-down"
                    measure = calculate_chemo_index(run_disp);
                case "chemo-index-left"
                    measure = calculate_thermo_index(run_disp);
                case "thermo-index"
                    measure = calculate_thermo_index(run_disp);
                case "ortho-index"
                    measure = calculate_ortho_index(run_disp);
            end

            %% add info
            count = count + 1;
            measure_cell(count,:) = {measure, info_str};

        end

        % cell to table, also add weighted mean and SEM
        measure_table = my_cell2table(measure_cell);

        %% bar plot with the error-bar capturing the deviance of runs

        % plot
        switch option_measure
            case "velocity"
                y_label_str = "v (mm/s)";
                y_lim_range = [0,0.3];
            case "chemo-index-down"
                y_label_str = "chemo-index-down";
                y_lim_range = [-1,+1];
            case "chemo-index-left"
                y_label_str = "chemo-index-left";
                y_lim_range = [-1,+1];
            case "thermo-index"
                y_label_str = "thermo-index";
                y_lim_range = [-1,+1];
            case "ortho-index"
                y_label_str = "ortho-index";
                y_lim_range = [-1,+1];
        end
        my_bar(measure_table,y_label_str,y_lim_range);

        % save
        save_folder_name = "weighted_average";
        save_folder_path = fullfile(folder_path_to_eset,save_folder_name);
        create_folder(save_folder_path);

        save_file_name = strcat(option_measure,"_each-worm");
        save_full_path = fullfile(save_folder_path,save_file_name);
        saveas(gcf,save_full_path,'png');

        close;

        %% save the weighted mean for the next step

        save_full_path_csv = strcat(save_full_path,'.csv');
        weighted_average = measure_table.weighted_average;
        writematrix(weighted_average, save_full_path_csv);

        %% distribution of worms or tracks

        % plot
        figure;
        histogram(weighted_average);
        xlabel(option_measure);
        ylabel('count');
        title(strcat("distribution of ",option_measure));

        % save
        save_file_name = strcat(option_measure,"_all-worms_histogram");
        save_full_path = fullfile(save_folder_path,save_file_name);
        saveas(gcf,save_full_path,'png');
        close;
    end
end