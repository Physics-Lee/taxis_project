% Calculate the persistent length of each experiment.
%
% You can choose a folder containing a single exp or multi exps.
%
% Save the mat of the mean of branches.
%
% option_measure: "cos", "MSE", "tortuosity", "cos_to_ideal",
% "MSE_to_ideal", "velocity", "Iino_curving_rate", "Delta_Delta_theta",
% "Delta_cos_Delta_theta"
%
% option_partition_region: "-3/4*pi_as_ideal", "-pi_as_ideal", "-1/2*pi_as_ideal"
%
% option_ideal_theta: "-pi", "-3/4*pi", "-1/2*pi"
%
% 2023-09-26, Yixuan Li
%

dbstop if error;

clc;clear;close all;

global folder_path_of_eset;

global is_save_fig;

global type_of_run_disp;

%% if Runhui's NC
is_Runhui_NC = false;

%% super-parameter
n_threshold_for_save = 10;

%% choose measure
option_measure = "Delta_cos_Delta_theta_v2";

%% choose ideal theta
option_ideal_theta = "-pi";

%% choose files to analyze

% chose the folder to analyze
path = uigetdir;

% if the user choose a folder
if path ~= 0

    % choose type of run disp
    type_of_run_disp = "each_track";
    switch type_of_run_disp
        case "each_worm"
            name_pattern = 'run_disp_of_worm_*.mat';
            is_save_fig = false;
        case "all_worms"
            name_pattern = '*.mat';
            is_save_fig = true;
        case "each_track"
            name_pattern = 'run_disp_of_track_*.mat';
            is_save_fig = false;
        case "all_tracks"
            name_pattern = 'run_disp_of_all_tracks.mat';
            is_save_fig = true;
    end

    % get full paths of files
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path,name_pattern);

    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files');

    % if at least 1 file is choosed
    if tf == 1

        % loop to process each file
        for i = indx

            % load
            full_path = list{i};
            run_disp = load_data_from_mat(full_path);

            % get information contained by path
            common_prefix = strcat(path,'\');
            [folder_path,file_name] = fileparts(full_path);
            folder_path_of_eset = fileparts(folder_path);
            title_str = strrep(folder_path_of_eset,common_prefix,'');
            title_str = strrep(title_str,'\','_');
            mats = cell(1,2);
            mats{1,1} = run_disp;
            mats{1,2} = title_str;

            % get taxis type
            option_taxis = get_taxis_type_by_full_path(full_path);

            % option_partition_region: 1 for traditional, 2 for NT like, 3 for NC like
            switch option_taxis
                case {"NC","NT","Pa"}
                    option_partition_region = "-pi_as_ideal";
                    % continue;
                case {"Ctl"}
                    option_partition_region = "-3/4*pi_as_ideal";
                    % continue;
                case {"Or"}
                    option_partition_region = "-3/4*pi_as_ideal";
                    % continue;
            end

            % you can change partition region here if you like
            if is_Runhui_NC
                option_partition_region = "-1/2*pi_as_ideal"; % special for Runhui's data
            end

            % calculate, plot and save figs
            mean_of_data = persistent_length(mats,option_measure,option_partition_region,option_ideal_theta,folder_path_of_eset,n_threshold_for_save);

            % save
            save_file_name = create_save_file_name(option_measure,option_partition_region,option_ideal_theta);
            save_file_name = [char(save_file_name) '___mean_of_data.mat'];
            if type_of_run_disp == "each_track" || type_of_run_disp == "each_worm"
                new_str = ['___' file_name '.mat'];
                save_file_name = strrep(save_file_name,'.mat',new_str);
            end
            save_full_path = fullfile(folder_path,save_file_name);
            save(save_full_path,"mean_of_data");

        end
    end
end

disp('<<<END>>>');