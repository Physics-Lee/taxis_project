% visualize boxes with trajectory.
% X is a 2D trajectory, where X(1,:) are the x-coordinates and X(2,:) are the y-coordinates.
% i is the number of figs.
%
% 2023-09-28, Yixuan Li
%

function visualizeBoxesWithTrajectory(X, i)

    % Define the range of box sizes for x-axis
    r_x = round(linspace(5, max(diff([min(X(1,:)), max(X(1,:))])), 50));

    % Get the box sizes for the chosen i
    r_x_i = r_x(i);
    r_y_i = round(r_x_i * (max(diff([min(X(2,:)), max(X(2,:))])) / max(diff([min(X(1,:)), max(X(1,:))]))));

    % Create a grid of boxes for the chosen i
    xEdges = min(X(1,:)):r_x_i:max(X(1,:));
    yEdges = min(X(2,:)):r_y_i:max(X(2,:));

    % Determine which boxes contain the trajectory
    H = histcounts2(X(1,:), X(2,:), xEdges, yEdges) > 0;

    % Plotting
    figure;

    % Plot the trajectory
    scatter(X(1,:), X(2,:), 5, 'filled'); hold on;

    % Plot boxes that contain the trajectory
    for ix = 1:length(xEdges)-1
        for iy = 1:length(yEdges)-1
            if H(ix, iy)
                rectangle('Position', [xEdges(ix), yEdges(iy), r_x_i, r_y_i], 'EdgeColor', 'r', 'LineWidth', 1);
            end
        end
    end

    title(['2D Trajectory with Highlighted Boxes (i=', num2str(i), ')']);
    xlabel('X-coordinates');
    ylabel('Y-coordinates');
    grid on;
    hold off;
end