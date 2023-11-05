function run_theta = extract_run_theta_v2(eset)

run_theta = cell(1,1);
count = 0;

for expt = eset.expt
    for track = expt.track
        if screen_a_track(track)
            for run = track.run
                if screen_a_run(run)
                    count = count + 1;
                    start_ind = run.startInd;
                    end_ind = run.endInd;
                    run_theta{count,1} = run.track.dq.theta(start_ind:end_ind);
                end
            end
        end
    end
end

end