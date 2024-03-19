function plot_Delta_C(all_disp_vector,label_rearranged)

% Assume 'theta' is defined somewhere in your workspace
ideal_theta = -1/2*pi;

% Find the indexes where the label is 'forward'
label_rearranged_numerical_array = cell2numerical_for_label_arranged(label_rearranged);
label = anti_rearrange_label(label_rearranged_numerical_array);
forward_indexes = label(1:end-1)';
logical_array = logical(forward_indexes);

%
[theta,~,~,~] = from_points_to_theta(all_disp_vector);

% Initialize the plot arrays with NaN, which will not be plotted (it will leave gaps)
theta_plot = nan(size(theta));
cos_plot = nan(size(theta));

% Only fill in the 'forward' segments
theta_plot(logical_array) = theta(logical_array) - ideal_theta;
cos_plot(logical_array) = cos(theta(logical_array) - ideal_theta);

% Now, let's plot
figure;
subplot(2,1,1)
plot(theta_plot);
xlabel("frame")
ylabel("$\theta - \theta_{ideal}$","Interpreter","latex")

subplot(2,1,2)
plot(cos_plot);
xlabel("frame")
ylabel("$cos(\theta - \theta_{ideal})$","Interpreter","latex")

%% plot cos
figure;
plot(cos_plot);
xlabel("frame","FontSize",18)
ylabel("$cos(\theta - \theta_{ideal})$","Interpreter","latex","FontSize",18)

%% smooth
T = 1; % s
f_sample = 66;
window_size = f_sample*T;
cos_plot_smoothed = smoothdata(cos_plot, 'movmean', window_size);

figure;
plot(cos_plot_smoothed);
xlabel("frame","FontSize",18)
ylabel("$cos(\theta - \theta_{ideal})$","Interpreter","latex","FontSize",18)

end