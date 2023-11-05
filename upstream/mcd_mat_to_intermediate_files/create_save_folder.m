% create save folder
%
% 2023-11-05, Yixuan Li
%

function full_path_of_save = create_save_folder(folder_path,folder_name)

full_path_of_save = fullfile(folder_path,folder_name);
create_folder(full_path_of_save);

end