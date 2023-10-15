load('D:\Public_repository\Worm-Thermo-Chemotaxis\Code\YixuanLi\run strategy\persistent length\data\all_second_half_of_a_run\n2_NC.mat');
run_disps = run_displacement;
number_of_runs = length(run_disps);

MSE = zeros(1,number_of_runs);
theta_in = zeros(1,number_of_runs);

for i = 1:number_of_runs
    
    % get theta from disp
    points = run_disps{i};
    v_direction = (points(:,2:end) - points(:,1:end-1));
    path_length = sqrt(sum(v_direction.^2,1));
    v_norm = v_direction./repmat(path_length,2,1);
    number_of_theta_in_a_run = size(v_direction,2);
    theta = zeros(number_of_theta_in_a_run,1);
    for p = 1:number_of_theta_in_a_run
        theta(p) = angle(complex(v_norm(1,p),v_norm(2,p))); % v_norm(1,p) is x coordinate and v_norm(2,p) is y coordinate
    end
    
    % calculate MSE for each run
    MSE(i) = mean_square_error_to_initial_v2(theta);
    
    % conditioned by theta_in of run
    theta_in(i) = theta(1);
    
end

fprintf('mean MSE is %f \n',mean(MSE))

option = 1; % 1 for NC, NT
switch option
    case 1
        MSE_1 = MSE(theta_in > -1/4*pi & theta_in < +1/4*pi);
        MSE_2 = MSE(theta_in > +1/4*pi & theta_in < +3/4*pi);
        MSE_3 = MSE(theta_in > +3/4*pi | theta_in < -3/4*pi);
        MSE_4 = MSE(theta_in > -3/4*pi & theta_in < -1/4*pi);
    case 2
        MSE_1 = MSE(theta_in > 0 & theta_in < pi/2);
        MSE_2 = MSE(theta_in > pi/2);
        MSE_3 = MSE(theta_in < -pi/2);
        MSE_4 = MSE(theta_in < 0 & theta_in > -pi/2);
end

fprintf('mean MSE of region 1 is %f \n',mean(MSE_1))
fprintf('mean MSE of region 2 is %f \n',mean(MSE_2))
fprintf('mean MSE of region 3 is %f \n',mean(MSE_3))
fprintf('mean MSE of region 4 is %f \n',mean(MSE_4))