% all_eset = read_all_eset;

for ii = 1:length(all_eset)
    
    eset = all_eset{ii,1}.eset;
    run_theta = extract_run_theta(eset);
    
    % var
    my_var = zeros(length(run_theta),1);
    for i = 1:length(run_theta)
        x = run_theta{i,1};
        my_var(i) = var(x);
    end

    % var conditioned by theta_in of run
    var_1 = [];
    var_2 = [];
    var_3 = [];
    var_4 = [];
    for i = 1:length(my_var)
        if run_theta{i,1}(1) > 0 && run_theta{i,1}(1) < pi/2
            var_1(end+1) = my_var(i);
        elseif run_theta{i,1}(1) > pi/2
            var_2(end+1) = my_var(i);
        elseif run_theta{i,1}(1) < -pi/2
            var_3(end+1) = my_var(i);
        else
            var_4(end+1) = my_var(i);
        end
    end
    
    all_eset{ii,2} = mean(var_1);
    all_eset{ii,3} = mean(var_2);
    all_eset{ii,4} = mean(var_3);
    all_eset{ii,5} = mean(var_4);
    
end