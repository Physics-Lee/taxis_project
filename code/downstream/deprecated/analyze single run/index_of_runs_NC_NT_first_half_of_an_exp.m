function index_first_half_of_an_exp = index_of_runs_NC_NT_first_half_of_an_exp(eset)

    index_first_half_of_an_exp = [];
    for expt = eset.expt

        % get the start frame and the end frame of an exp
        start_frame_of_an_exp = min([expt.track.startFrame]);
        end_frame_of_an_exp = max([expt.track.endFrame]);
        half_frame_of_an_exp = (start_frame_of_an_exp + end_frame_of_an_exp)/2;

        for track = expt.track
            if screen_a_track(track)
                for run = track.run
                    if screen_a_run(run)
                        start_ind = run.startInd;
                        if start_ind + track.startFrame <= half_frame_of_an_exp
                            x_0 = track.dq.displacement(1,run.startInd);
                            x_n = track.dq.displacement(1,run.endInd);
                            index_first_half_of_an_exp(end+1) = (x_n - x_0)/run.pathLength;
                        end
                    end
                end
            end
        end

    end

end