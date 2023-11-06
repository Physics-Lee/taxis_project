% count the number of experiments, tracks, runs and reorientations, with
% screening.
%
% 2023-09-28, Yixuan Li
%

function [n_exp, n_track_before, n_run_before, n_reorientation_before, n_track_after, n_run_after, n_reorientation_after] = count_expt_track_run_reorientation(eset)

    n_exp = length(eset.expt);
    n_track_before = 0;
    n_run_before = 0;
    n_reorientation_before = 0;
    n_track_after = 0;
    n_run_after = 0;
    n_reorientation_after = 0;
    
    for expt = eset.expt
        n_track_before = n_track_before + length(expt.track);
        for track = expt.track
            n_run_before = n_run_before + length(track.run);
            n_reorientation_before = n_reorientation_before + length(track.reorientation);
            if screen_a_track(track)
                n_track_after = n_track_after + 1;
                n_reorientation_after = n_reorientation_after + length(track.reorientation);
                for run = track.run
                    if screen_a_run(run)
                        n_run_after = n_run_after + 1;
                    end
                end
            end
        end
    end

end