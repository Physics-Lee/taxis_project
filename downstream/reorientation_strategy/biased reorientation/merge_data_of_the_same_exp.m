function merge_data_of_the_same_exp(data_str,save_str)

path = uigetdir('F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\data\theta');
if path ~= 0
    list = get_all_files_of_a_certain_type_in_a_rootpath(path,data_str);
    disp(['number of exps: ' num2str(size(list,2))]);

    for substr = ["Ctl" "NC" "NT" "Or"]

        % screen
        list_screened = screen_list(list,substr);
        if size(list_screened,2) == 0
            disp(['For ' char(substr) ', The list is empty!']);
            continue;
        end

        % choose
        [indx,tf] = listdlg('ListString',list_screened,'ListSize',[800,600],'Name','Chose files');

        % merge
        if tf==1

            % load
            n = length(indx);
            data_all = cell(n,1);
            for i = indx
                full_path = list_screened{i};
                data_all{i} = load_struct(full_path);
            end

            % concatenate
            data_all = vertcat(data_all{:});

            % save
            father_folder_path = fullfile('F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\result\',save_str);
            name_of_new_folder = get_suitable_folder_name(full_path);
            file_name = [char(substr) '.mat'];
            folder_path_of_save = create_save_folder(father_folder_path,name_of_new_folder);
            file_path_of_save = fullfile(folder_path_of_save,file_name);
            save(file_path_of_save,'data_all');

        end

    end

end

end