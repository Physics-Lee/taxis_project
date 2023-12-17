function velosity_first_half_of_a_run = velosity_of_runs_first_half_of_a_run(eset)

    velosity_first_half_of_a_run = []; 
    for expt = eset.expt        
        for track = expt.track            
            if screen_a_track(track)
                for run = track.run                    
                    if screen_a_run(run)                        
                        start_ind = run.startInd;
                        if start_ind + track.startFrame <= half_ind
                            velosity_first_half_of_a_run(end+1) = (run.pathLength/22)/run.runTime; % mm/s
                        end
                    end
                end
            end            
        end
    end
    
end