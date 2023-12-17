% esets = read_all_eset;
for i = 1:length(esets)
    
    eset = esets{i,1}.eset;
    tortuosity = tortuosity_of_a_eset(eset);
    
    % conditioned by theta_in of run
    run_theta = extract_run_theta(eset);
    theta_in = cellfun(@(x) x(1), run_theta); % initial angle of each run
    if ~isempty(strfind(esets{i,2}, 'NC')) || ~isempty(strfind(esets{i,2}, 'NT'))
        tortuosity_1 = tortuosity(theta_in > -1/4*pi & theta_in < +1/4*pi);
        tortuosity_2 = tortuosity(theta_in > +1/4*pi & theta_in < +3/4*pi);
        tortuosity_3 = tortuosity(theta_in > +3/4*pi | theta_in < -3/4*pi);
        tortuosity_4 = tortuosity(theta_in > -3/4*pi & theta_in < -1/4*pi);
    end
    
    if strfind(esets{i,2}, 'ortho')
        tortuosity_1 = tortuosity(theta_in > 0 & theta_in < pi/2);
        tortuosity_2 = tortuosity(theta_in > pi/2);
        tortuosity_3 = tortuosity(theta_in < -pi/2);
        tortuosity_4 = tortuosity(theta_in < 0 & theta_in > -pi/2);
    end    
    
    % save to esets
    esets{i,3} = (tortuosity_1);
    esets{i,4} = (tortuosity_2);
    esets{i,5} = (tortuosity_3);
    esets{i,6} = (tortuosity_4);
    esets{i,7} = (tortuosity);    
    
end