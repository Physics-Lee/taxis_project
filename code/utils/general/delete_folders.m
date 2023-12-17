% delete folders
%
% 2023-10-07, Yixuan Li (Modified by ChatGPT)
%

clc;clear;close all;


%% input folder pattern

% Create GUI to prompt the user for the type of folder to search for.
prompt = {'Enter the folder name or pattern (e.g., ^disp$):'};
title = 'Folder Search Pattern';
dims = [1 60];
definput = {''};
answer = inputdlg(prompt, title, dims, definput);

% If the user presses 'Cancel' or provides an empty input, exit.
if isempty(answer) || isempty(answer{1})
    msgbox("Invalid Input", 'Warn', 'warn');
    return;
end

folder_pattern = answer{1};

%% delete

% Chose the root folder to analyze.
path = uigetdir;

% If the user chooses a folder.
if path ~= 0

    % Get all subfolders matching the pattern recursively.
    all_folders = get_all_folders_of_a_certain_name_pattern_in_a_rootpath(path, folder_pattern);

    % If no matched folders are found.
    if isempty(all_folders)
        msgbox("No folders matching the pattern were found in your directory.", 'Info', 'help');
        return;
    end

    % Choose folders to delete.
    [indx,tf] = listdlg('ListString',all_folders,'ListSize',[800,600],'Name','Chose folders to delete');

    % If at least 1 folder is chosen.
    if tf == 1

        % Loop to process each folder.
        for i = indx
            rmdir(all_folders{i}, 's'); % core % 's' argument also removes subdirectories and files.
        end

        % Inform the user of completion.
        msgbox('Selected folders have been deleted.', 'Success', 'help');
    end
end