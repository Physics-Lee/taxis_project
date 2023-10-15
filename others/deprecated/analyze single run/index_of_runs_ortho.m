% calculate the index for ortho
%
% 2023-09-29, Yixuan Li
%

function index = index_of_runs_ortho(eset)

    index = []; 
    for expt = eset.expt
        for track = expt.track            
            if screen_a_track(track)
                for run = track.run
                    if screen_a_run(run)
                        
                        x_0 = track.dq.displacement(1,run.startInd);
                        y_0 = track.dq.displacement(2,run.startInd);
                        x_n = track.dq.displacement(1,run.endInd);
                        y_n = track.dq.displacement(2,run.endInd);
                        
                        % In new Oxy, which has (x_0,y_0) as (0,0), projects (x_n,y_n) to y = x
                        x_proj = ( (x_n-x_0) + (y_n-y_0) )/2;
                        y_proj = x_proj;
                        
                        % calculate index
                        L_parallel = sign(x_proj - 0) * pdist2(single([0,0]), [x_proj,y_proj], 'euclidean');
                        index(end+1) = L_parallel/run.pathLength;
                        
                    end
                end
            end            
        end
    end
    
end