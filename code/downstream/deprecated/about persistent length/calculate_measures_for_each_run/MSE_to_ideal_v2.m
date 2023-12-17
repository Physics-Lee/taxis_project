function corr = MSE_to_ideal_v2(run_disps,ideal_theta)

    number_of_runs = length(run_disps);
    corr = zeros(number_of_runs,3);
    for i = 1:number_of_runs
        
        % prepare
        points = run_disps{i};
        v_direction = (points(:,2:end) - points(:,1:end-1));
        path_length = sqrt(sum(v_direction.^2,1));
        v_norm = v_direction./repmat(path_length,2,1);
        number_of_theta_in_a_run = size(v_direction,2);
        theta = zeros(number_of_theta_in_a_run,1);
        for p = 1:number_of_theta_in_a_run
            theta(p) = angle(complex(v_norm(1,p),v_norm(2,p)));
        end
        
        % calculate the measure
        j = 1;
        k = length(v_norm);
        MSE_to_ideal_from_j_to_k = mean_square_error_to_ideal_v2(theta(j:k),ideal_theta);
        corr(i,:) = [theta(j),MSE_to_ideal_from_j_to_k,sum(path_length(j:k))];
        
    end

end