% save gcf to fig and png
%
% 2023-11-05, Yixuan Li
%

function my_save_for_gcf(father_folder_path, name_of_new_folder, file_name)

folder_path_of_save = create_save_folder(father_folder_path,name_of_new_folder);
file_path_of_save = fullfile(folder_path_of_save,file_name);
saveas(gcf,file_path_of_save,'fig');
saveas(gcf,file_path_of_save,'png');

end