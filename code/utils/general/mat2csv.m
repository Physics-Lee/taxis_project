% mat2csv
%
% 2023-11-13, Yixuan Li
%

clc;clear;close all;

%% delete

% chose the folder to analyze
path = uigetdir;

% if the user choose a folder
if path ~= 0

    % get full paths of files
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path,'*.mat');

    % choose files
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files');

    % if at least 1 file is choosed
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

                % generate CSV file name
                [save_folder_path, ~, ~] = fileparts(list{i});
                save_file_name = field_name{j};
                save_full_path = fullfile(save_folder_path, [save_file_name, '.csv']);

                % save
                if istable(data_to_save)
                    writetable(data_to_save, save_full_path);
                else
                    writematrix(data_to_save, save_full_path);
                end
            end

        end

    end
end