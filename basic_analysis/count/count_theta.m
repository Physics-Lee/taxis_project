% esets = read_all_eset;
for ii = 1:length(esets)
    
    eset = esets{ii,1}.eset;
    run_theta = extract_run_theta(eset);
    run_theta_vector = extract_run_theta_vector(eset);
    
    % before screen
    n_theta_before = length(run_theta_vector) - 2*length(run_theta);
    esets{ii,3} = n_theta_before;
    
    % after screen
    n_theta_after = 0;
    for i = 1:length(run_theta)
        run_theta_new = run_theta{i};
        for j = 2:length(run_theta_new) - 1
            if screen_a_theta(run_theta_new(j),run_theta_new(j-1),run_theta_new(j+1))
                n_theta_after = n_theta_after + 1;
            end
        end
    end    
    esets{ii,4} = n_theta_after;
    esets{ii,5} = n_theta_after/n_theta_before;
    
end