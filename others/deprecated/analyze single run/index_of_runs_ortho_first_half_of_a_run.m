function index_first_half_of_a_run = index_of_runs_ortho_first_half_of_a_run(eset)

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
                        y_0 = track.dq.displacement(2,start_ind);
                        x_n = track.dq.displacement(1,half_ind);
                        y_n = track.dq.displacement(2,half_ind);
                        
                        % In new Oxy, which has (x_0,y_0) as (0,0), projects (x_n,y_n) to y = x
                        x_proj = ( (x_n-x_0) + (y_n-y_0) )/2;
                        y_proj = x_proj;
                        
                        % calculate index
                        L_parallel = sign(x_proj - 0) * pdist2(single([0,0]), [x_proj,y_proj], 'euclidean');
                        index_first_half_of_a_run(end+1) = L_parallel/run.pathLength;
                        
                    end
                end
            end            
        end
    end
    
end