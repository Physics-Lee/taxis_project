% get all folders of a certain name pattern in a rootpath and its sub-folders.
%
% genpath can obtain all subfolders.
%
% regexp can find all files which obey the regular expression.
%
% 2023-10-07, Yixuan Li
%

function list = get_all_folders_of_a_certain_name_pattern_in_a_rootpath(rootpath, name_pattern)

% Obtain all the subfolders
folders = string(split(genpath(rootpath), pathsep));

% Delete the last one
folders = folders(1:length(folders)-1);

% Init
list = {};

% Loop over all folders
for i = 1:length(folders)
    
    % Get a list of all items in the folder
    all_items = dir(folders{i});

    % Filter for items that are folders
    folder_items = all_items([all_items.isdir]);

    % Loop over all folder items and check for name pattern match using regexp
    for j = 1:length(folder_items)
        if ~isempty(regexp(folder_items(j).name, name_pattern, 'once'))
            list{end+1} = fullfile(folder_items(j).folder, folder_items(j).name);
        end
    end
end

% transpose
list = list';

end