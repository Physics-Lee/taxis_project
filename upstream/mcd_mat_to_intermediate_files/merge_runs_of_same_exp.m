clear;clc;close all;

path = uigetdir;

if path ~= 0

    list = get_all_files_of_a_certain_type_in_a_rootpath(path,'run_disp_*.mat');

    for substr = ["Ctl" "NC" "NT" "Or"]

        list_screened = screen_list(list,substr);

        if size(list_screened,1) == 0
            disp(['For ' char(substr) ', The list is empty!']);
            continue;
        end

        [indx,tf] = listdlg('ListString',list_screened,'ListSize',[800,600],'Name','Chose files');

        if tf==1
    
            n = length(indx);
            run_disp_all = cell(n,1);
            for i = indx
                full_path = list_screened{i};
                run_disp_all{i} = load_struct(full_path);
            end
    
            % concatenate
            run_disp_all = vertcat(run_disp_all{:});
    
            % save
            % father_folder_path = fileparts(fileparts(fileparts(full_path)));
            father_folder_path = fileparts(fileparts(full_path));
            save_folder_path = fullfile(father_folder_path,'run_disp_of_all_worms');
            save_file_name = [char(substr) '.mat'];
            save_full_path = fullfile(save_folder_path,save_file_name);
            save(save_full_path,'run_disp_all');
    
        end
    end
end