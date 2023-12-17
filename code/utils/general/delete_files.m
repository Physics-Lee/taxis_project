% delete files
%
% 2023-10-02, Yixuan Li
%

clc;clear;close all;

%% input strings

% Create GUI to input file extension
prompt = {'Enter file extension (e.g., *.tif):'};
title = 'Input';
dims = [1 50];
definput = {'*.tif'};
answer = inputdlg(prompt, title, dims, definput);

% If the user presses 'Cancel' or provides an empty input, exit
if isempty(answer) || isempty(answer{1})
    msgbox("Invalid Input", 'Warn', 'warn');
    return;
end

file_type = answer{1};

%% delete

% chose the folder to analyze
path = uigetdir;

% if the user choose a folder
if path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path,file_type);

    % if empty
    if isempty(list)
        msgbox("No file type like that in your folder.", 'Success', 'help');
        return;
    end

    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files');

    % if at least 1 file is choosed
    if tf == 1

        % loop to process each file
        for i = indx
            delete(list{i}); % core
        end

        % Inform the user of completion
        msgbox('Selected files have been deleted.', 'Success', 'help');

    end
end