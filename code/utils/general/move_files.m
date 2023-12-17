% move files
%
% 2023-10-02, Yixuan Li
%

clc; clear; close all;

%% input strings

% Create GUI to input file extension
prompt = {'Enter file extension (e.g., *.png):'};
title = 'Input';
dims = [1 50];
definput = {'*.png'};
answer = inputdlg(prompt, title, dims, definput);

% If the user presses 'Cancel' or provides an empty input, exit
if isempty(answer) || isempty(answer{1})
    msgbox("Invalid Input", 'Warn', 'warn');
    return;
end

file_type = answer{1};

%% move

% choose the source folder to analyze
src_path = uigetdir('', 'Choose the source folder');

% if the user chooses a source folder
if src_path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(src_path, file_type);

    % if empty
    if isempty(list)
        msgbox("No file type like that in your source folder.", 'Info', 'help');
        return;
    end

    % choose files
    [indx, tf] = listdlg('ListString', list, 'ListSize', [800, 600], 'Name', 'Choose files');

    % if at least 1 file is chosen
    if tf == 1

        % choose the destination folder
        dest_path = uigetdir('', 'Choose the destination folder');

        % if the user chooses a destination folder
        if dest_path ~= 0

            % loop to process each file
            for i = indx
                movefile(list{i}, dest_path); % core
            end

            % Inform the user of completion
            msgbox('Selected files have been moved.', 'Success', 'help');

        end
    end
end