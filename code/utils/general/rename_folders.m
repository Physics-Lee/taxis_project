% rename folders
%
% 2023-10-08, Yixuan Li
%

clc; clear; close all;

%% input old name

% Create GUI to prompt the user for the type of folder to search for.
prompt = {'Enter the old folder name or pattern (e.g., data_*):'};
title = 'Old Name';
dims = [1 60];
definput = {''};
answer = inputdlg(prompt, title, dims, definput);

% If the user presses 'Cancel' or provides an empty input, exit.
if isempty(answer) || isempty(answer{1})
    msgbox("Invalid Input", 'Warn', 'warn');
    return;
end

folderPattern = answer{1};

%% input new name

% Ask the user for the new name
prompt = {'Enter the new folder name (e.g., data_new):'};
title = 'New Name';
dims = [1 60];
definput = {''};
new_name = inputdlg(prompt, title, dims, definput);

% If the user presses 'Cancel' or provides an empty input, exit.
if isempty(answer) || isempty(answer{1})
    msgbox("Invalid Input", 'Warn', 'warn');
    return;
end

%% Get folders

% choose the source folder to get a list of folders
path = uigetdir;

% if the user chooses a source folder
if path ~= 0

    % Get all subfolders matching the pattern recursively.
    all_folders = get_all_folders_of_a_certain_name_pattern_in_a_rootpath(path, folderPattern);

    % if no folders are present
    if isempty(all_folders)
        msgbox("No folders in your source directory.", 'Info', 'help');
        return;
    end

    % choose folders
    [indx, tf] = listdlg('ListString', all_folders, 'ListSize', [800, 600], 'Name', 'Choose folders to rename');

    % if at least 1 folder is chosen
    if tf == 1

        for i = indx
            old_folder_path = all_folders{i};
            father_folder_path = fileparts(old_folder_path);
            new_folder_path = fullfile(father_folder_path, new_name{1});
            movefile(old_folder_path, new_folder_path); % Core
        end

        % Inform the user of completion
        msgbox('Selected folders have been renamed.', 'Success', 'help');
    end
end