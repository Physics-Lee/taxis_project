% mat2txt
%
% 2023-11-13, Yixuan Li
%

clc; clear; close all;

% choose the folder to analyze
path = uigetdir;

% if the user chose a folder
if path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path, '*.mat');

    % choose files
    [indx, tf] = listdlg('ListString', list, 'ListSize', [800, 600], 'Name', 'Choose files');

    % if at least 1 file is chosen
    if tf == 1

        % loop to process each file
        for i = indx

            % load
            full_path = list{i};
            data = load(full_path);

            % loop to process each field
            field_name = fieldnames(data);
            for j = 1:length(field_name)
                data_to_save = data.(field_name{j});

                % generate TXT file name
                [save_folder_path, ~, ~] = fileparts(list{i});
                save_file_name = field_name{j};
                save_full_path = fullfile(save_folder_path, [save_file_name, '.txt']);

                % save
                if isnumeric(data_to_save) || iscell(data_to_save)
                    writematrix(data_to_save, save_full_path);
                else
                    % Handle other data types if necessary
                    disp(['Skipping non-numeric/cell data in field: ', field_name{j}]);
                end
            end

        end

    end
end