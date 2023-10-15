function polarhistogram_for_theta(theta_rad, xlabel_str)
    theta_deg = theta_rad / pi * 180;

    edges = deg2rad(-195:30:195);  % start from -195
    counts = histcounts(deg2rad(theta_deg), edges);

    % Take the sum of the first and last count and replace the first one
    total_count = counts(1) + counts(end);
    counts = [total_count, counts(2:end-1)];  % remove the last count

    % Set the bin edges to start from -180, length needs to be length(counts)+1
    edges = linspace(deg2rad(-180), deg2rad(180), length(counts)+1);

    figure;
    polarhistogram('BinEdges', edges, 'BinCounts', counts, 'DisplayStyle','stairs');
    rticklabels([]);
    title(['Distribution of ' xlabel_str], 'Interpreter', 'latex');
end
