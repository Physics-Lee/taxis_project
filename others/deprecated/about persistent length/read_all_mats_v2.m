function mats = read_all_mats_v2
    root_dir = 'D:\Public_repository\Worm-Thermo-Chemotaxis\Code\YixuanLi\run strategy\persistent length\data';
    print_menu_input_data;
    
    option_input_data = input("Which data to input?\n");
    folder = get_folder_name(option_input_data);
    folder = fullfile(root_dir, folder);    
    
    files = dir(fullfile(folder, '*.mat'));
    len = length(files);
    mats = cell(len, 2);
    for i = 1:len
        file_name = fullfile(files(i).folder, files(i).name);
        mats{i, 1} = load(file_name);
        mats{i, 2} = remove_file_extension(files(i).name);
    end
end