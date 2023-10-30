% Calculate the weighted average of each track or worm and save the mean.
%
% option_measure: "velocity", "chemo-index-left", "chemo-index-down", "thermo-index", "ortho-index"
%
% index := cos_to_ideal * tortuosity
%
% 2023-10-25, Yixuan Li
%

clear;clc;close all;

dbstop if error;

option_measure = "chemo-index-down";
type_of_run_disp = "each_worm";

% use GUI to choose .mat files
path = uigetdir;

% if choose a folder
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
        measure_cell = {};

        % calculate through loop
        for i = indx

            % load
            full_path = list{i};
            run_disp = load_struct(full_path);

            % for save
            [folder_path,file_name,~] = fileparts(full_path);
            folder_path_to_eset = fileparts(folder_path);

            % for Colbert data which are not done within 1 day
            if contains(folder_path_to_eset,'run_disp_of')
                folder_path_to_eset = fileparts(folder_path_to_eset);
            end

            % core
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

            % generate info for save
            info_str = strrep(file_name,'_',' ');
            info_str = strrep(info_str,'run disp of worm ','');
            info_str = strrep(info_str,'run disp of track ','');
            info_str = strrep(info_str,' corrected','');

            % save
            measure_cell = [measure_cell; {measure, info_str}];

            % plot the histogram of a single point capturing deviation for runs
            %             histogram_of_a_single_point_capturing_deviation_of_runs(measure,...
            %                 option_measure,folder_path_to_eset,i);

        end

        % calculate weighted mean and std
        measure_table = my_cell2table(measure_cell);

        %% bar plot with the error-bar

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

        %% save the mean for the next step

        % save_full_path_mat = strcat(save_full_path,'.mat');
        % weighted_average = measure_table.weighted_average;
        % save(save_full_path_mat,'weighted_average');

        save_full_path_csv = strcat(save_full_path,'.csv');
        weighted_average = measure_table.weighted_average;
        writematrix(weighted_average, save_full_path_csv);

        %% bar plot with the error-bar

        % plot
        figure;
        Mean_of_worms = mean(weighted_average);
        SEM_of_worms = std(weighted_average)/sqrt(length(weighted_average));
        errorbar(Mean_of_worms,SEM_of_worms);

        xlabel("no meaning");
        ylabel(option_measure);
        title('error bar for SEM');
        ylim(y_lim_range);

        % disp
        fprintf('mean of worms: %.4f\n',Mean_of_worms);
        fprintf('SEM of worms: %.4f\n',SEM_of_worms);

        % save
        save_file_name = strcat(option_measure,"_all-worms_mean-and-deviation");
        save_full_path = fullfile(save_folder_path,save_file_name);
        saveas(gcf,save_full_path,'png');
        close;

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