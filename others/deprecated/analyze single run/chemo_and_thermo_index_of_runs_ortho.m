function [chemo_index, thermo_index] = chemo_and_thermo_index_of_runs_ortho(eset)

chemo_index = [];
thermo_index = [];
for expt = eset.expt
    for track = expt.track
        if screen_a_track(track)
            for run = track.run
                if screen_a_run(run)

                    x_0 = track.dq.displacement(1,run.startInd);
                    y_0 = track.dq.displacement(2,run.startInd);
                    x_n = track.dq.displacement(1,run.endInd);
                    y_n = track.dq.displacement(2,run.endInd);

                    chemo_index(end+1) = (y_n - y_0)/run.pathLength;
                    thermo_index(end+1) = (x_n - x_0)/run.pathLength;

                end
            end
        end
    end
end

end