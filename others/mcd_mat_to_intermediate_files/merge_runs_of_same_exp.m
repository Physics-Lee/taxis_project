clear;clc;close all;

my_add_path;
path = uigetdir('F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\data');
if path ~= 0
    list = get_all_files_of_a_certain_type_in_a_rootpath(path,'run_disp_smoothed_downsampled_smoothed*.mat');
    for substr = ["Ctl" "NC" "NT" "Or"]
        list_screened = screen_list(list,substr);
        if size(list_screened,2) == 0
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
            father_folder_path = 'F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\result\run_disp_smoothed_downsampled_smoothed' ;
            name_of_new_folder = get_suitable_folder_name(full_path);
            file_name = [char(substr) '.mat'];
            folder_path_of_save = create_save_folder(father_folder_path,name_of_new_folder);
            file_path_of_save = fullfile(folder_path_of_save,file_name);
            save(file_path_of_save,'run_disp_all');
    
        end
    end
end