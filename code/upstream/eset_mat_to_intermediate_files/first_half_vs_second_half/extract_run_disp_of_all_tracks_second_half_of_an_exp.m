% extract run disps (mm) of all tracks (only the second half of an exp) from an eset
%
% 2023-11-05, Yixuan Li
%

function run_disp = extract_run_disp_of_all_tracks_second_half_of_an_exp(eset)

run_disp = {};

for i = 1:length(eset.expt)

    % get the start frame and the end frame of an exp
    expt = eset.expt(i);
    start_frame_of_an_exp = min([expt.track.startFrame]);
    end_frame_of_an_exp = max([expt.track.endFrame]);

    % calculate the half frame
    half_ind = (start_frame_of_an_exp + end_frame_of_an_exp)/2;

    for j = 1:length(expt.track)
        track = expt.track(j);
        if screen_a_track(track)
            for k = 1:length(track.run)
                run = track.run(k);
                if screen_a_run(run)
                    start_ind = run.startInd;
                    end_ind = run.endInd;
                    if start_ind + track.startFrame > half_ind
                        run_disp{end+1,1} = run.track.dq.displacement(:,start_ind:end_ind) / 22;
                    end
                end
            end
        end
    end
end

end