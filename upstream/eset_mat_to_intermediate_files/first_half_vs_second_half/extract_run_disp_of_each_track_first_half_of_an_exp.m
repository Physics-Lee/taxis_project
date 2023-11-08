% extract run disps (mm) of all tracks (only the first half of a run which is longer than 20s) from an eset
%
% 2023-11-05, Yixuan Li
%

function run_disp_of_all_tracks = extract_run_disp_of_each_track_first_half_of_an_exp(eset)

% init
run_disp_of_all_tracks = {};

% loop to get run disp of all tracks
for expt = eset.expt

    start_frame_of_an_exp = min([expt.track.startFrame]);
    end_frame_of_an_exp = max([expt.track.endFrame]);
    half_ind = (start_frame_of_an_exp + end_frame_of_an_exp)/2;

    for track = expt.track
        if screen_a_track(track)

            % init
            run_disp_of_a_track = {};

            for run = track.run
                if screen_a_run(run)
                    start_ind = run.startInd;
                    end_ind = run.endInd;
                    if start_ind + track.startFrame <= half_ind
                        run_disp_of_a_track{end+1,1} = run.track.dq.displacement(:,start_ind:end_ind) / 22;
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