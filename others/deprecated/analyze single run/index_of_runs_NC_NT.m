% calculate the index for NC and NT
%
% 2023-09-29, Yixuan Li
%

function index = index_of_runs_NC_NT(eset)

    index = []; 
    for expt = eset.expt
        for track = expt.track            
            if screen_a_track(track)
                for run = track.run
                    if screen_a_run(run)
                        x_0 = track.dq.displacement(1,run.startInd);
                        x_n = track.dq.displacement(1,run.endInd);
                        index(end+1) = (x_n - x_0)/run.pathLength;
                    end
                end
            end
        end
    end
    
end