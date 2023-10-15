function run_disp = extract_run_disp_first_half_of_a_run_which_is_longer_than_20s(eset)

    run_disp = cell(1,1);
    count = 0;
    
    for expt = eset.expt
        for track = expt.track            
            if screen_a_track(track)
                for run = track.run
                    if screen_a_run(run)
                        if run.runTime > 20
                            count = count + 1;
                            start_ind = run.startInd;
                            end_ind = run.endInd;
                            half_ind = floor((start_ind+end_ind)/2);
                            run_disp{count,1} = run.track.dq.displacement(:,start_ind:half_ind);
                        end
                    end
                end
            end
        end
    end
end