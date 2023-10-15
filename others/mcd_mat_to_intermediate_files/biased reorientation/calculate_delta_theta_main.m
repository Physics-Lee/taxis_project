clear;clc;close all;

my_add_path;
path = uigetdir('F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\data');
if path ~= 0
    list = get_all_files_of_a_certain_type_in_a_rootpath(path,'run_disp_smoothed_downsampled_smoothed*.mat');
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files');
    if tf == 1
        for i = indx

            % load
            full_path = list{i};
            run_disp = load_struct(full_path);

            % calculate
            [theta_in,theta_out,delta_theta] = calculate_delta_theta(run_disp);

            % save
            [parent_dir,~,~] = fileparts(full_path);
            [folder_path_of_mcd,~,~] = fileparts(parent_dir);
            save_my_data(folder_path_of_mcd, 'disp', {'theta_in', 'theta_out', 'delta_theta'}, {theta_in, theta_out, delta_theta});

        end
    end
end

function save_my_data(folder_path, subfolder, data_types, data_values)
    for i = 1:length(data_types)
        my_save(folder_path, subfolder, [data_types{i}, '.mat'], data_types{i}, data_values{i});
    end
end