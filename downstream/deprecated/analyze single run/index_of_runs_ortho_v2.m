function index = index_of_runs_ortho_v2(eset)

    index = []; 
    for expt = eset.expt
        for track = expt.track            
            if screen_a_track(track)
                for run = track.run
                    if screen_a_run(run)

                        ideal_direction = [-1,-1]/sqrt(2);

                        x_0 = track.dq.displacement(1,run.startInd);
                        y_0 = track.dq.displacement(2,run.startInd);
                        x_n = track.dq.displacement(1,run.endInd);
                        y_n = track.dq.displacement(2,run.endInd);

                        point_1 = [x_0,y_0];
                        point_2 = [x_n,y_n];

                        Euclid_distance = sqrt(sum((point_1 - point_2).^2));
                        disp_from_j_to_k = (point_2 - point_1)/Euclid_distance;

                        index(end+1) = -dot(disp_from_j_to_k,ideal_direction);                        
                        
                    end
                end
            end            
        end
    end
    
end