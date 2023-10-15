% extract run disps (mm) of each track from an eset
%
% 2023-09-26, Yixuan Li
%

function run_disp_of_all_tracks = extract_run_disp_of_each_eset(eset)

% init
run_disp_of_all_tracks = {};

% loop to get run disp of all tracks
for i = 1:length(eset.expt)
    for j = 1:length(eset.expt(i).track)
        if screen_a_track(eset.expt(i).track(j))

            % init
            run_disp_of_a_track = {};

            % loop to get run disp of a track
            for k = 1:length(eset.expt(i).track(j).run)
                if screen_a_run(eset.expt(i).track(j).run(k))
                    start_ind = eset.expt(i).track(j).run(k).startInd;
                    end_ind = eset.expt(i).track(j).run(k).endInd;
                    displacement = eset.expt(i).track(j).run(k).track.dq.displacement(:, start_ind:end_ind) / 22; % (mm)
                    run_disp_of_a_track{end+1,1} = displacement;
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
