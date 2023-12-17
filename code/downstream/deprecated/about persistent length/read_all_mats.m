function [mats,folder] = read_all_mats
root_dir = 'D:\Public_repository\Worm-Thermo-Chemotaxis\Code\YixuanLi\data\run_disp';
% print_menu_input_data;

option_input_data = 1;
switch option_input_data
    case 1
        folder = 'whole';
    case 2
        folder = 'all_first_half_of_a_run';
    case 3
        folder = 'all_second_half_of_a_run';
    case 4
        folder = 'all_first_half_of_an_exp';
    case 5
        folder = 'all_second_half_of_an_exp';
    case 6
        folder = 'run_disp_first_half_of_a_run_which_is_longer_than_20s';
    case 7
        folder = 'run_disp_second_half_of_a_run_which_is_longer_than_20s';
end
full_path = fullfile(root_dir,folder);

files = dir(fullfile(full_path,'\*.mat'));
len = length(files);
mats = cell(len,2);
for i = 1:len
    file_name = fullfile(files(i).folder,files(i).name);
    mats{i,1} = load(file_name);
    mats{i,2} = strrep(files(i).name, '.mat', '');
end

end