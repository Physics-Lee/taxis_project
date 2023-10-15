function corr = tortuosity_v2(run_disps)

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
        j = 1;
        k = length(v_norm);
        point_1 = points(:,j)';
        point_2 = points(:,k)';
        Euclid_disp = sqrt(sum((point_1 - point_2).^2));
        tortuosity_from_j_to_k = Euclid_disp/sum(path_length(j:k));
        corr(i,:) = [theta_in,tortuosity_from_j_to_k,sum(path_length(j:k))];
        
    end
    
end