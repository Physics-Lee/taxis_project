function plot_heatmap_of_theta_and_Dtheta_normalized(theta_vector, Delta_theta_vector)

    % limit
    Delta_theta_vector(Delta_theta_vector > 20) = 20;
    Delta_theta_vector(Delta_theta_vector < -20) = -20;

    % Define the number of bins for the histogram
    num_bins_theta = 20; % Number of bins for theta
    num_bins_Delta = 10; % Number of bins for Delta_theta

    % Create a 2D histogram of the data
    edges_theta = linspace(min(theta_vector), max(theta_vector), num_bins_theta + 1); % Edges for theta
    edges_Delta = linspace(min(Delta_theta_vector), max(Delta_theta_vector), num_bins_Delta + 1); % Edges for Delta_theta
    hist_mat = hist3([theta_vector(:), Delta_theta_vector(:)], 'Edges', {edges_theta, edges_Delta});
    hist_mat = hist_mat';

    % Remove a strange end
    hist_mat = hist_mat(1:end, 1:end-1);

    % Normalize each column along the y-axis so that the sum is 1 (or 100%)
    col_sums = sum(hist_mat, 1); % Find the sum of each column
    col_sums(col_sums == 0) = 1; % Avoid division by zero for columns with all zeros
    hist_mat_normalized = bsxfun(@rdivide, hist_mat, col_sums); % Normalize each column to sum to 1

    % Plot the normalized heatmap
    figure;
    imagesc(edges_theta, edges_Delta, hist_mat_normalized);
    set(gca, 'YDir', 'normal'); % Set Y-axis to increase from bottom to top
    colormap('hot'); % Set the colormap to 'hot'
    colorbar; % To show the color scale
    xlabel('\theta');
    ylabel('\Delta\theta');
    title('Normalized Heatmap');
    ylim([-20 +20]);
end