% calculate the fractional dimension
% X is a 2D trajectory, where X(1,:) are the x-coordinates and X(2,:) are the y-coordinates.
%
% 2023-09-28, Yixuan Li
%

function D = boxCountingDim(X)

    % Define the range of box sizes for x-axis
    r_x = round(linspace(5, max(diff([min(X(1,:)), max(X(1,:))])), 50));
    count = zeros(1, length(r_x));

    for i = 1:length(r_x) - 1
        % Determine the corresponding box size for y-axis based on r_x to maintain consistent area
        r_y = round(r_x(i) * (max(diff([min(X(2,:)), max(X(2,:))])) / max(diff([min(X(1,:)), max(X(1,:))]))));

        % Create a grid of boxes
        xEdges = min(X(1,:)):r_x(i):max(X(1,:));
        yEdges = min(X(2,:)):r_y:max(X(2,:));

        % Count how many boxes contain part of the trajectory
        count(i) = nnz(histcounts2(X(1,:), X(2,:), xEdges, yEdges) > 0);
    end

    down_lim = 5;
    mask = count > down_lim;
    count = count(mask);
    r_x = r_x(mask);

    % Estimate the fractal dimension as the negative slope of the log-log plot
    p = polyfit(log(r_x), log(count), 1);
    D = p(1);

    % Optional: plot the log-log graph
    figure;
    loglog(r_x, count, 'o', 'MarkerSize', 8);
    hold on;
    loglog(r_x, exp(p(2)) * r_x.^p(1), '-');
    xlabel('Box size along X');
    ylabel('Number of boxes');
    title(['Box-counting dimension: D = ' num2str(D)]);
end
