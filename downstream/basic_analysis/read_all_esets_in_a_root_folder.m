% read all esets in a root folder
%
% return a n*2 cell array, the first column is esets, the second column is
% descriptions.
%
% 2023-09-30, Yixuan Li
%

function esets = read_all_esets_in_a_root_folder

root_folder = 'F:\1_learning\research\taxis of C.elegans\high throughout system\data';
path_ = [root_folder '\**\eset.mat'];
files = dir(path_);
len = length(files);
esets = cell(len,2);
for i = 1:len
    file_name{i} = [ files(i).folder '\' files(i).name ];
    esets{i,1} = load(file_name{i});
    esets{i,2} = strrep(files(i).folder, root_folder, '');
end

end