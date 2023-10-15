function histogram_for_theta_using_bar(theta_rad, xlabel_str)

% hist
theta_deg = theta_rad / pi * 180;
figure;
edges = [-180 -165:30:165 180];
[counts, ~] = histcounts(theta_deg,edges,'Normalization','probability');
counts(1) = counts(1) + counts(end);
counts(end) = [];

% draw
edges_new = -180:30:150;
bar(edges_new, counts, 'hist', 'FaceColor', [0.5 0.5 0.5]);

% label
xlabel(xlabel_str, 'Interpreter', 'latex');
ylabel('probability');
title(['distribution of ' xlabel_str], 'Interpreter', 'latex');
xticks(-195:30:165);

end
