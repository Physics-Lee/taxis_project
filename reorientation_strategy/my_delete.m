function my_delete(eset_info)

root_folder = 'D:\Public_repository\Worm-Thermo-Chemotaxis\Code\YixuanLi\result\reorientation strategy\biased reorientation\';
folder_name = fullfile(root_folder,eset_info);
if isfolder(folder_name) == 0
    mkdir(folder_name);
end

file_name = 'theta_delta.png';
full_path = fullfile(folder_name,file_name);
delete(full_path)

end