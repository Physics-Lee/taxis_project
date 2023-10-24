% calculate the persistent length based on measure, partition and ideal
% direction.
%
% 2023-09-26, Yixuan Li
%

function mean_of_data = persistent_length(mats,option_measure,option_partition_region,option_ideal_theta,save_folder_path)

% loop to process each run_disp
for ii = 1:size(mats,1)

    %% get the theta_in-correlation-path_length martix
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
    n_threshold_for_plot = 100; % a super-parameter
    custom_colors = [0 0 1; 0 1 1; 0 0 0; 1 0 0]; % set custom colors
    for j = 1:n_regions

        % only plot bins which have more points than n_threshold
        mask = counts{j} > n_threshold_for_plot;

        % plot with error-bar
        errorbar(...
            x{j}(mask),...
            mean_of_data{j}(mask),...
            error_bar_of_data{j}(mask),...
            'Color',custom_colors(j,:)...
            );
        hold on;

    end

    % add label, lim, title, legend
    add_title(mats{ii,2},option_measure,option_ideal_theta);
    add_legend(option_partition_region);
    x_up_limit = add_label_and_lim(option_measure);

    % save
    global is_save_fig
    if is_save_fig
        output_figures(save_folder_path,option_measure,option_partition_region,option_ideal_theta,x_up_limit,'fig');
        output_figures(save_folder_path,option_measure,option_partition_region,option_ideal_theta,x_up_limit,'png');
        close;
    else
        close;
    end

    %% process mean_of_data
    n_threshold_for_save = 100; % super-parameter
    for j = 1:n_regions
        mask = counts{j} < n_threshold_for_save;
        mean_of_data{j}(mask) = NaN;
    end

end

end