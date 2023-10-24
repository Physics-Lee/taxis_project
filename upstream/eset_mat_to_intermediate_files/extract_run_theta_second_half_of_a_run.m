function run_theta_second_half_of_a_run = extract_run_theta_second_half_of_a_run(eset)

    run_theta_second_half_of_a_run = cell(1,1);
    count = 0;
    
    for expt = eset.expt
        for track = expt.track            
            if screen_a_track(track)
                for run = track.run
                    if screen_a_run(run)
                        count = count + 1;
                        start_ind = run.startInd;
                        end_ind = run.endInd;
                        half_ind = floor((start_ind+end_ind)/2);
                        run_theta_second_half_of_a_run{count,1} = run.track.dq.theta(half_ind:end_ind);
                    end
                end
            end            
        end
    end
    
end