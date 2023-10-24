function [run_disp_before_t_threshold,run_disp_after_t_threshold] = extract_run_disp_split_by_t_threshold(eset)

    run_disp_before_t_threshold = cell(1,1);
    run_disp_after_t_threshold = cell(1,1);
    count_before = 0;
    count_after = 0;
    t_threshold = 10; % s
    ind_threshold = t_threshold*2;
    
    for expt = eset.expt
        for track = expt.track            
            if screen_a_track(track)
                for run = track.run
                    if screen_a_run(run)
                        count_before = count_before + 1;
                        start_ind = run.startInd;
                        end_ind = run.endInd;
                        if end_ind - start_ind <= ind_threshold
                            run_disp_before_t_threshold{count_before,1} = run.track.dq.displacement(:,start_ind:end_ind);
                        else
                            count_after = count_after + 1;
                            run_disp_before_t_threshold{count_before,1} = run.track.dq.displacement(:,start_ind:start_ind + ind_threshold - 1);
                            run_disp_after_t_threshold{count_after,1} = run.track.dq.displacement(:,start_ind + ind_threshold:end_ind);
                        end                       
                    end
                end
            end            
        end
    end
    
end