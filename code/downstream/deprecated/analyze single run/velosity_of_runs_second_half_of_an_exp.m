function velosity_second_half_of_an_exp = velosity_of_runs_second_half_of_an_exp(eset)

    velosity_second_half_of_an_exp = []; 
    for expt = eset.expt
        
        % get the start frame and the end frame of an exp
        start_frame_of_an_exp = min([expt.track.startFrame]);
        end_frame_of_an_exp = max([expt.track.endFrame]);
        half_ind = (start_frame_of_an_exp + end_frame_of_an_exp)/2;
        
        for track = expt.track            
            if screen_a_track(track)
                for run = track.run                    
                    if screen_a_run(run)                        
                        start_ind = run.startInd;
                        if start_ind + track.startFrame > half_ind
                            velosity_second_half_of_an_exp(end+1) = (run.pathLength/22)/run.runTime; % mm/s
                        end
                    end
                end
            end            
        end
    end
    
end