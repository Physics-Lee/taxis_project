function corr = angular_correlation_v2(run_disps)

    number_of_runs = length(run_disps);
    corr = zeros(number_of_runs,3);
    for i = 1:number_of_runs
        
        % prepare
        points = run_disps{i};
        v_direction = (points(:,2:end) - points(:,1:end-1));
        path_length = sqrt(sum(v_direction.^2,1));
        v_norm = v_direction./repmat(path_length,2,1);
        theta_in = angle(complex(v_norm(1,1),v_norm(2,1)));
        
        % calculate the measure
        corr(i,:) = [theta_in,dot(v_norm(:,1),v_norm(:,end)),sum(path_length(1:end))];
        
    end
    
end