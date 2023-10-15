% esets = read_all_eset;
for ii = 1:length(esets)
    
    eset = esets{ii,1}.eset;
    run_theta = extract_run_theta_second_half_of_a_run(eset); % change here to explore different timescale.
    
    % new_MSE
    pairwise_MSE = cellfun(@new_MSE, run_theta);
    
    % new_MSE conditioned by theta_in of run
    theta_in = cellfun(@(x) x(1), run_theta); % initial angle of each run
    
    if ~isempty(strfind(esets{ii,2}, 'NC')) || ~isempty(strfind(esets{ii,2}, 'NT'))
        pairwise_MSE_1 = pairwise_MSE(theta_in > -1/4*pi & theta_in < +1/4*pi);
        pairwise_MSE_2 = pairwise_MSE(theta_in > +1/4*pi & theta_in < +3/4*pi);
        pairwise_MSE_3 = pairwise_MSE(theta_in > +3/4*pi | theta_in < -3/4*pi);
        pairwise_MSE_4 = pairwise_MSE(theta_in > -3/4*pi & theta_in < -1/4*pi);
    end
    
    if strfind(esets{ii,2}, 'ortho')
        pairwise_MSE_1 = pairwise_MSE(theta_in > 0 & theta_in < pi/2);
        pairwise_MSE_2 = pairwise_MSE(theta_in > pi/2);
        pairwise_MSE_3 = pairwise_MSE(theta_in < -pi/2);
        pairwise_MSE_4 = pairwise_MSE(theta_in < 0 & theta_in > -pi/2);
    end
        
    % save to esets
    esets{ii,3} = mean(pairwise_MSE);
    esets{ii,4} = mean(pairwise_MSE_1);
    esets{ii,5} = mean(pairwise_MSE_2);
    esets{ii,6} = mean(pairwise_MSE_3);
    esets{ii,7} = mean(pairwise_MSE_4);    
    
    esets{ii,8} = pairwise_MSE;
    esets{ii,9} = pairwise_MSE_1;
    esets{ii,10} = pairwise_MSE_2;
    esets{ii,11} = pairwise_MSE_3;
    esets{ii,12} = pairwise_MSE_4;    
    
end