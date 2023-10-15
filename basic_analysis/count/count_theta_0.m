% esets = read_all_eset;
for ii = 1:length(esets)
    
    eset = esets{ii,1}.eset;
    run_theta = extract_run_theta(eset);
    theta_0 = cellfun(@(x) x(1), run_theta);
    theta_0_next =  cellfun(@(x) x(2), run_theta);
    
    % before screen
    n_theta_0_before = length(theta_0);
    esets{ii,3} = n_theta_0_before;
    
    % after screen
    n_theta_0_after = 0;
    for i = 1:length(theta_0)
        if screen_a_theta_0(theta_0(i),theta_0_next(i))
            n_theta_0_after = n_theta_0_after + 1;
        end
    end    
    esets{ii,4} = n_theta_0_after;
    esets{ii,5} = n_theta_0_after/n_theta_0_before;
    
end