% extract run disps (mm) of all tracks (only the first half of a run which is longer than 20s) from an eset
%
% 2023-11-05, Yixuan Li
%

function run_disp_of_all_tracks = extract_run_disp_of_each_track_second_half_of_a_run(eset)

% init
run_disp_of_all_tracks = {};
t_threshold = 0; % s

% loop to get run disp of all tracks
for expt = eset.expt
    for track = expt.track
        if screen_a_track(track)

            % init
            run_disp_of_a_track = {};

            for run = track.run
                if screen_a_run(run)
                    if run.runTime > t_threshold
                        start_ind = run.startInd;
                        end_ind = run.endInd;
                        half_ind = floor((start_ind+end_ind)/2);
                        run_disp_of_a_track{end+1,1} = run.track.dq.displacement(:,half_ind:end_ind) / 22;
                    end
                end
            end

            % append if not empty
            if ~isempty(run_disp_of_a_track)
                run_disp_of_all_tracks{end+1,1} = run_disp_of_a_track;
            end

        end
    end
end

end