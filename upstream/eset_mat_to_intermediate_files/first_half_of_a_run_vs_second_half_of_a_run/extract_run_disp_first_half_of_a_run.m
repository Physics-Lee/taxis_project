% extract run disps (mm) of all tracks (only the first half of a run) from an eset
%
% 2023-11-05, Yixuan Li
%

function run_disp_first_half_of_a_run = extract_run_disp_first_half_of_a_run(eset)

run_disp_first_half_of_a_run = cell(1,1);
count = 0;

for expt = eset.expt
    for track = expt.track
        if screen_a_track(track)
            for run = track.run
                if screen_a_run(run)
                    count = count + 1;
                    start_ind = run.startInd;
                    end_ind = run.endInd;
                    half_ind = floor((start_ind+end_ind)/2);
                    run_disp_first_half_of_a_run{count,1} = run.track.dq.displacement(:,start_ind:half_ind);
                end
            end
        end
    end
end

end