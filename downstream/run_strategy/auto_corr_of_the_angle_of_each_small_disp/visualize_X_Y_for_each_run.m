% calculate \theta(t) and \theta(t+\tau) from theta_cell
%
% Yixuan Li, 2023-11-29
%

function visualize_X_Y_for_each_run(theta_cell_filted_unwrapped,max_frame,save_folder_path)

max_frame = max_frame - 10; % make sure you at least have 10 points to calculate Pearson r

for i = 1:length(theta_cell_filted_unwrapped)

    % get
    theta_now = theta_cell_filted_unwrapped{i,1};
    theta_now = rad2deg(theta_now);
    n_theta = length(theta_now);
    theta_t1 = theta_now(1:n_theta-max_frame);
    theta_t2 = theta_now(1+max_frame:n_theta);
    
    % r
    r = corrcoef(theta_t1,theta_t2);

    % plot
    figure;
    hold on;
    axis equal; % always useful of same dimension X and Y!
    plot(theta_t1,theta_t2,'k-o');
    xlabel('$\theta(t)$',Interpreter='latex');
    ylabel('$\theta(t+\tau)$',Interpreter='latex');
    legend('data','y = x + 90','y = x - 90');
    title(sprintf("r = %.2f",r(1,2)));

    y1 = theta_t1 + 90; % Calculate y values for y = x + 90
    y2 = theta_t1 - 90; % Calculate y values for y = x - 90
    plot(theta_t1, y1, 'r--'); % Plotting y = x + 90 in red dashed line
    plot(theta_t1, y2, 'b--'); % Plotting y = x - 90 in blue dashed line

    % save
    save_folder_path_now = fullfile(save_folder_path, strcat(sprintf("max_frame_%d",max_frame),'_for_each_run'));
    create_folder(save_folder_path_now);
    save_file_name = sprintf("run_%d",i);
    save_full_path = fullfile(save_folder_path_now,save_file_name);
    saveas(gcf,save_full_path,'png');
    close;

end

end