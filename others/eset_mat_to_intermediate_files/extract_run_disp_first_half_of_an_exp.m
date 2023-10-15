function [run_disp_first_half_of_an_exp,mask] = extract_run_disp_first_half_of_an_exp(eset)

    run_disp_first_half_of_an_exp = cell(1,1);
    count = 0;
    mask = [];
    
    for i = 1:length(eset.expt)
        
        % get the start frame and the end frame of an exp
        expt = eset.expt(i);
        start_frame_of_an_exp = min([expt.track.startFrame]);
        end_frame_of_an_exp = max([expt.track.endFrame]);
        half_ind = (start_frame_of_an_exp + end_frame_of_an_exp)/2;
        
        for j = 1:length(expt.track) 
            track = expt.track(j);
            if screen_a_track(track)
                for k = 1:length(track.run)
                    run = track.run(k);
                    if screen_a_run(run) % only preserve run > 5s
                        mask(end+1) = 0;
                        start_ind = run.startInd;
                        end_ind = run.endInd;   
                        if start_ind + track.startFrame <= half_ind
                            mask(end) = 1;
                            count = count + 1;
                            run_disp_first_half_of_an_exp{count,1} = run.track.dq.displacement(:,start_ind:end_ind);
                        end
                    end
                end
            end
        end
    end
    
end