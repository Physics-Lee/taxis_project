function index_first_half_of_a_run = index_of_runs_NC_NT_first_half_of_a_run(eset)

    index_first_half_of_a_run = []; 
    for expt = eset.expt
        for track = expt.track            
            if screen_a_track(track)
                for run = track.run
                    if screen_a_run(run)
                        
                        start_ind = run.startInd;
                        end_ind = run.endInd;
                        half_ind = floor((start_ind+end_ind)/2);
                        
                        x_0 = track.dq.displacement(1,start_ind);
                        x_n = track.dq.displacement(1,half_ind);
                        index_first_half_of_a_run(end+1) = (x_n - x_0)/run.pathLength; % this is wrong
                        
                    end
                end
            end
        end
    end
    
end