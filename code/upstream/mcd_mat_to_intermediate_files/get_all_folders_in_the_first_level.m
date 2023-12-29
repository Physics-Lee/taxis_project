function folders = get_all_folders_in_the_first_level(folder_path)
% Get a list of all files and folders in this folder
files = dir(folder_path);

% Get a logical vector that tells which is a directory
dirFlags = [files.isdir];

% Extract only those that are directories
subFolders = files(dirFlags);

% Remove '.' and '..' directories
subFolders = subFolders(~ismember({subFolders.name}, {'.', '..'}));

% Extract the folder names
folders = {subFolders.name};

%
folders = folders';

end