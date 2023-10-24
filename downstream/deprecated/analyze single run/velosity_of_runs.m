function velosity = velosity_of_runs(eset)

    velosity = []; 
    for expt = eset.expt
        for track = expt.track            
            if screen_a_track(track)
                for run = track.run
                    if screen_a_run(run)
                        velosity(end+1) = (run.pathLength/22)/run.runTime; % mm/s
                    end
                end
            end            
        end
    end
    
end