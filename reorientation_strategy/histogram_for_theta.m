function histogram_for_theta(theta_rad, xlabel_str, title_str)

% rad2deg
theta_deg = theta_rad / pi * 180;

% draw
figure;
edges = -180:30:180;
histogram(theta_deg,edges,'Normalization','probability');

% label
xlabel(xlabel_str, 'Interpreter', 'latex');
ylabel('probability');

% title
title(title_str);

% ticks
xticks(edges);

% lim
ylim([0,0.30]);

end

function theta_deg = process_theta_deg(theta_deg)
% concatenate around 180 and -180
theta_deg(theta_deg > 165) = theta_deg(theta_deg > 165) - 360;
end