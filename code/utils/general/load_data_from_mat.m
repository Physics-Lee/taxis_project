% load data from a .mat file.
%
% The .mat must cain only 1 field!
%
% 2023-10-24, Yixuan Li
%

function data = load_data_from_mat(full_path)

loaded_data = load(full_path);
data = loaded_data.(char(fieldnames(loaded_data)));

end