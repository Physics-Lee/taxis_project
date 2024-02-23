% Linjiao Plot
%
% Yixuan Li, 2024-02-22
%

clc;clear;close all;

% chose the folder to analyze
root_folder_path = uigetdir;

% if the user choose a folder
if root_folder_path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(root_folder_path,'run_disp_of_all_*.mat');

    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Choose files');

    % if at least 1 file is choosed
    if tf == 1

        % loop to process each file
        for i = indx

            %% load run disp
            full_path = list{i};
            run_disp = load_data_from_mat(full_path);

            %% create a sub-folder for savings
            full_path_of_eset = fileparts(fileparts(full_path));
            save_folder_path = fullfile(full_path_of_eset,'Linjiao_Plot');
            create_folder(save_folder_path);

            %% get theta from run disp
            theta_cell = cellfun(@from_points_to_unwrapped_theta, run_disp, 'UniformOutput', false);
            
            %% get run length from run disp
            run_length_cell = cellfun(@from_points_to_run_length, run_disp, 'UniformOutput', false);

            %% Linjiao Plot
            
            % calculate mean theta
            theta_mean = calculate_mean_theta(theta_cell);

            % normalize to (-pi,+pi)
            theta_mean = normalize_theta(theta_mean);

            % get ideal theta
            theta_ideal = get_ideal_theta(full_path_of_eset);

            % split 4 regions
            region_flags = split_4_regions(theta_mean, theta_ideal);

            % add std2mean
            % std2mean = 0.6;
            % region_flags = screened_by_std_to_mean(region_flags,theta_cell,std2mean);

            % allocate theta cell
            theta_cell_4_region = allocate_theta_cell(theta_cell, region_flags);

            % get run time
            mean_SEM_of_run_time_4_regions = calculate_mean_std_of_run_time(theta_cell_4_region);

            % plot
            Linjiao_Plot(mean_SEM_of_run_time_4_regions);

            % save
            saveas(gcf,fullfile(save_folder_path,"Linjiao_Plot"),"png");
        end
    end
end