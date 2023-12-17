esets = read_all_esets_in_a_root_folder;
for ii = 1:length(esets)
    eset = esets{ii,1}.eset;
    [n_exp, n_track_before, n_run_before, n_reorientation_before, n_track_after, n_run_after, n_reorientation_after] = count_expt_track_run_reorientation(eset);
    esets{ii,3} = n_exp;
    esets{ii,4} = n_track_before;
    esets{ii,5} = n_run_before;
    esets{ii,6} = n_reorientation_before;
    esets{ii,7} = n_track_after;
    esets{ii,8} = n_run_after;
    esets{ii,9} = n_reorientation_after;
end