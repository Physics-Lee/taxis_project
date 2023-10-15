function histogram_for_theta(theta_rad, xlabel_str)
theta_deg = theta_rad / pi * 180;
figure;
edges = -180:30:180;
histogram(theta_deg,edges,'Normalization','probability');

% label
xlabel(xlabel_str, 'Interpreter', 'latex');
ylabel('probability');

% title
title(['distribution of ' xlabel_str], 'Interpreter', 'latex');

% ticks
xticks(edges);

% lim
ylim([0,0.30]);

end

function theta_deg = process_theta_deg(theta_deg)
% concatenate around 180 and -180
theta_deg(theta_deg > 165) = theta_deg(theta_deg > 165) - 360;
end