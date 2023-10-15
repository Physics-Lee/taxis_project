esets = read_all_eset;
esets_results = cell(size(esets));
esets_results(:,2) = esets(:,2);
for ii = 1:length(esets)
    
    eset = esets{ii,1}.eset;
    run_theta = extract_run_theta_first_half_of_a_run(eset); % change here to explore different timescale: whole, first, second.
    
    % MSE
    MSE = cellfun(@mean_square_error_to_initial, run_theta);
    
    % MSE conditioned by theta_in of run
    theta_in = cellfun(@(x) x(1), run_theta); % initial angle of each run
    
    if ~isempty(strfind(esets{ii,2}, 'NC')) || ~isempty(strfind(esets{ii,2}, 'NT'))
        MSE_1 = MSE(theta_in > -1/4*pi & theta_in < +1/4*pi);
        MSE_2 = MSE(theta_in > +1/4*pi & theta_in < +3/4*pi);
        MSE_3 = MSE(theta_in > +3/4*pi | theta_in < -3/4*pi);
        MSE_4 = MSE(theta_in > -3/4*pi & theta_in < -1/4*pi);
    end
    
    if strfind(esets{ii,2}, 'ortho')
        MSE_1 = MSE(theta_in > 0 & theta_in < pi/2);
        MSE_2 = MSE(theta_in > pi/2);
        MSE_3 = MSE(theta_in < -pi/2);
        MSE_4 = MSE(theta_in < 0 & theta_in > -pi/2);
    end
        
    % save to esets
    esets_results{ii,3} = mean(MSE);
    esets_results{ii,4} = mean(MSE_1);
    esets_results{ii,5} = mean(MSE_2);
    esets_results{ii,6} = mean(MSE_3);
    esets_results{ii,7} = mean(MSE_4);    
    
    esets_results{ii,8} = MSE;
    esets_results{ii,9} = MSE_1;
    esets_results{ii,10} = MSE_2;
    esets_results{ii,11} = MSE_3;
    esets_results{ii,12} = MSE_4;
    
end