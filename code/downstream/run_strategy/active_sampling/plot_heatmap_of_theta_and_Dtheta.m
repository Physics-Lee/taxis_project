function plot_heatmap_of_theta_and_Dtheta(theta_vector, Delta_theta_vector)

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

    % Plot the heatmap
    figure;
    imagesc(edges_theta, edges_Delta, hist_mat);
    set(gca,'YDir','normal') % Set Y-axis to increase from bottom to top
    colormap('hot'); % Set the colormap to 'hot' (you can choose others like 'jet', 'hsv' etc.)
    colorbar; % To show the color scale
    xlabel('\theta');
    ylabel('\Delta\theta');
    title('Heatmap');
    ylim([-20 +20]);
end