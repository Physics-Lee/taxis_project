function corr = cos_delta_theta(branches)

    number_of_runs = length(branches);
    number_of_pairs = 0;
    for i=1:number_of_runs
        number_of_theta_in_a_run = size(branches{i},2) - 1;
        temp = number_of_theta_in_a_run - 2; % abandon the first and the last theta
        number_of_pairs = number_of_pairs + temp*(temp-1)/2;
    end
    corr = zeros(number_of_pairs,3); % pre-assign to raise speed
    idx = 1; 

    for i = 1:number_of_runs        
        branch = branches{i};
        points = branch;
        v_direction = (points(:,2:end) - points(:,1:end-1));    
        path_length = sqrt(sum(v_direction.^2,1)); % path_length is sqrt(delta_x^2 + delta_y^2)    
        v_norm = v_direction./repmat(path_length,2,1);

        number_of_theta_in_a_run = size(v_direction,2);
        if number_of_theta_in_a_run >= 4 % only >=4 is meaningful

            theta = zeros(number_of_theta_in_a_run,1);        
            for p = 1:number_of_theta_in_a_run
                theta(p) = angle(complex(v_norm(1,p),v_norm(2,p))); % v_norm(1,p) is x coordinate and v_norm(2,p) is y coordinate 
            end

            for j = 2:number_of_theta_in_a_run - 2 % abandon the first and the last theta
                if screen_a_theta(theta(j),theta(j-1),theta(j+1)) % screen theta(j)
                    for k = j + 1:number_of_theta_in_a_run - 1
                        if screen_a_theta(theta(k),theta(k-1),theta(k+1)) % screen theta(k)
                            corr(idx,:) = [theta(j),dot(v_norm(:,j),v_norm(:,k)),sum(path_length(j:k))];
                            idx = idx + 1;                            
                        end
                    end
                end
            end
        end
    end

    corr = corr(1:idx-1,:);

end