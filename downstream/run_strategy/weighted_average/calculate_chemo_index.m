% Calculate the chemo-index of each run
%
% Input: run_disp contains runs of all worms in a type of taxis
% Output: index is n*2 where the 1st column is the index of each run and
% the 2nd column is t of each run.
%
% 2023-10-25, Yixuan Li
%

function index = calculate_chemo_index(run_disp)

ideal_unit_vector = [0 -1];
index = calculate_index(run_disp,ideal_unit_vector);

end