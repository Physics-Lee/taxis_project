% basic count
%
% 2023-09-28, Yixuan Li
%

esets = read_all_eset;
for i = 1:length(esets)
    eset = esets{i,1}.eset;
    [esets{i,3},esets{i,4},esets{i,5},esets{i,6},esets{i,7},esets{i,8},esets{i,9}] = count_expt_track_run_reorientation(eset);
end