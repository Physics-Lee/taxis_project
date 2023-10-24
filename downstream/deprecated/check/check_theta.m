% upload
[eset,type_of_C_elegans,type_of_taxis] = upload_eset; % choose N2 ortho
x = eset.expt(1, 1).track(1, 1).dq.displacement(1,48:72);
y = eset.expt(1, 1).track(1, 1).dq.displacement(2,48:72);
theta = eset.expt(1, 1).track(1, 1).dq.theta(48:72);

% Plot the scatter plot
scatter(x, y);

% Add arrows to the scatter plot
hold on;
quiver(x, y, cos(theta), sin(theta),0.1, 'LineWidth', 1, 'Color', 'r')
hold off;

% Set the axis limits and labels
xlabel('x');
ylabel('y');
title('Scatter plot with arrows');