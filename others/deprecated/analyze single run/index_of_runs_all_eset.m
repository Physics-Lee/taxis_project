esets = read_all_eset;
esets_results = cell(size(esets));
esets_results(:,2) = esets(:,2);
for ii = 1:length(esets)
    
    eset = esets{ii,1}.eset;
    
    % index
    if contains(esets{ii,2}, 'NC') || contains(esets{ii,2}, 'NT')
        index = index_of_runs_NC_NT(eset);
    elseif contains(esets{ii,2}, 'ortho')
        index = index_of_runs_ortho_v2(eset);
    else
        continue;
    end    
    
    % index conditioned by theta_in of run
    run_theta = extract_run_theta(eset);
    theta_in = cellfun(@(x) x(1), run_theta); % initial angle of each run

    if contains(esets{ii,2}, 'NC') || contains(esets{ii,2}, 'NT')
        index_1 = index(theta_in > -1/4*pi & theta_in < +1/4*pi);
        index_2 = index(theta_in > +1/4*pi & theta_in < +3/4*pi);
        index_3 = index(theta_in > +3/4*pi | theta_in < -3/4*pi);
        index_4 = index(theta_in > -3/4*pi & theta_in < -1/4*pi);
    elseif contains(esets{ii,2}, 'ortho')
        index_1 = index(theta_in > 0 & theta_in < pi/2);
        index_2 = index(theta_in > pi/2);
        index_3 = index(theta_in < -pi/2);
        index_4 = index(theta_in < 0 & theta_in > -pi/2);
    end
    
    esets_results{ii,3} = mean(index);
    esets_results{ii,4} = mean(index_1);
    esets_results{ii,5} = mean(index_2);
    esets_results{ii,6} = mean(index_3);
    esets_results{ii,7} = mean(index_4);
    
    esets_results{ii,8} = index';
    esets_results{ii,9} = index_1';
    esets_results{ii,10} = index_2';
    esets_results{ii,11} = index_3';
    esets_results{ii,12} = index_4';
    
end