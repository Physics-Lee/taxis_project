% calculate the tortuosity of an eset
%
% 2023-09-30, Yixuan Li
%

function tortuosity = tortuosity_of_a_eset(eset)

    tortuosity = []; 
    for expt = eset.expt
        for track = expt.track            
            if screen_a_track(track)
                for run = track.run
                    tortuosity(end+1) = run.pathLength/run.euclidLength;
                end
            end            
        end
    end
    
end