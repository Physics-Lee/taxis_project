% get all files of a certain name pattern in a rootpath and its sub-folders.
%
% genpath can obtain all subfolders.
%
% dir can find all files which obey the regular expression.
%
% 2023-09-26, Yixuan Li
%

function list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(rootpath, name_pattern)

% Obtain all the subfolders
folders = string(split(genpath(rootpath), pathsep));

% Delete the last one
folders = folders(1:length(folders)-1);

% Init
list = {};

% Loop to process each folder
for i = 1:length(folders)

    % Get a list of all files in the folder that match the filetype
    files = dir(fullfile(folders{i}, name_pattern));
    
    % Loop over all files and append to the list
    for j = 1:length(files)
        list{end+1} = fullfile(files(j).folder, files(j).name);
    end
    
end

% transpose
list = list';

end