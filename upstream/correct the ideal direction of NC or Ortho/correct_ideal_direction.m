clc;clear;close all;

path = uigetdir;
if path ~= 0

    % load using *
    list = get_all_files_of_a_certain_type_in_a_rootpath(path,'run_disp_of_worm_*');

    % choose what u want through GUI
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files to convert');
    
    if tf == 1
        for i = indx

            % load
            full_path = list{i};
            run_disp = load_data_from_mat(full_path);

            % correct
            if contains(full_path,'NC')
                run_disp_corrected = correct_NC_direction(run_disp);
            elseif contains(full_path,'Or')
                run_disp_corrected = correct_ortho_direction(run_disp);
            end

            % save
            [folder_path,file_name,ext] = fileparts(full_path);
            save_file_name = strcat(file_name,'_corrected',ext);
            save_full_path = fullfile(folder_path,save_file_name);
            save(save_full_path,"run_disp_corrected","run_disp_corrected");

            % delete
            delete(full_path);

        end
    end
end