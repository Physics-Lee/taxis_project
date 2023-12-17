% load mcd.mat
%
% 2023-11-05, Yixuan Li
%

function mcd = load_mcd(full_path_to_mcd)

mcd = load_data_from_mat(full_path_to_mcd);
disp('mcd file loaded successfully.');

end