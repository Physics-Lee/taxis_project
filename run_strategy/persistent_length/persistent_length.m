% calculate the persistent length based on measure, partition and ideal
% direction.
%
% 2023-09-26, Yixuan Li
%

function mean_of_data = persistent_length(mats,option_measure,option_partition_region,option_ideal_theta,save_folder_path)

% init
% persistent_length = cell(size(mats,1),5);
% persistent_length(:,1) = mats(:,2);

% loop to process each run_disp
for ii = 1:size(mats,1)

    %% get the theta_in-correlation-displacement martix
    %
    % theta_in is the theta_in of each run, that is how we presever the time order
    %
    run_disp = mats{ii,1};
    corr = analyze_branches(run_disp, option_measure, option_ideal_theta);

    %% partition
    switch option_partition_region
        case "-3/4*pi_as_ideal"
            [corr_sorted_by_theta_in,number_of_theta_in_of_each_region] = partition_conventional_quadrant(corr);
        case "-pi_as_ideal"
            [corr_sorted_by_theta_in,number_of_theta_in_of_each_region] = partition_NT_as_ideal(corr);
        case "-1/2*pi_as_ideal"
            [corr_sorted_by_theta_in,number_of_theta_in_of_each_region] = partition_NC_as_ideal(corr);
    end

    %% drop theta_in
    corr_sorted_by_theta_in = corr_sorted_by_theta_in(:,2:end); 

    %% calculate mean and error bar in each small bin of path length

    % init
    n_regions = 4;
    x = cell(n_regions,1);
    mean_of_data = cell(n_regions,1);
    error_bar_of_data = cell(n_regions,1);
    counts = cell(n_regions,1);
    count_theta_in = 1;

    % loop to process each region
    for j = 1:n_regions
        if number_of_theta_in_of_each_region(j) >= 1

            % use more meanful variable name
            path_length_all = corr_sorted_by_theta_in(count_theta_in:count_theta_in + number_of_theta_in_of_each_region(j) - 1,2);
            corr_all = corr_sorted_by_theta_in(count_theta_in:count_theta_in + number_of_theta_in_of_each_region(j) - 1,1);

            % calculate averaged correlation
            [x{j},mean_of_data{j},error_bar_of_data{j},counts{j}] = averaged_correlation(path_length_all,corr_all);

            % update
            count_theta_in = count_theta_in + number_of_theta_in_of_each_region(j);

        end
    end

    %% plot

    % loop to plot each region
    figure;
    n_threshold = 100; % a super-parameter
    custom_colors = [0 0 1; 0 1 1; 0 0 0; 1 0 0]; % set custom colors
    for j = 1:n_regions

        % only plot bins which have more points than n_threshold
        mask = counts{j} > n_threshold;

        % plot with error-bar
        errorbar(...
            x{j}(mask),...
            mean_of_data{j}(mask),...
            error_bar_of_data{j}(mask),...
            'Color',custom_colors(j,:)...
            );
        hold on;

        % linear fit
        % persistent_length{ii,j + 1} = linear_fit(path_length{j}, mean_of_data{j});
   
    end

    % add label, lim, title, legend
    add_title(mats{ii,2},option_measure,option_ideal_theta);
    add_legend(option_partition_region);
    add_label_and_lim(save_folder_path,option_measure,option_partition_region,option_ideal_theta);

end

% % save persistent length (deprecated temporarily)
% header = {'persistent length (mm)','quadrant 3', 'quadrant 4','quadrant 1','quadrant 2'};
% persistent_length = [header; persistent_length];
% [~, save_file_name, ~] = fileparts(output_folder);
% save_file_name = [save_file_name '_persistent_length.csv'];
% writecell(persistent_length, file_name);

end