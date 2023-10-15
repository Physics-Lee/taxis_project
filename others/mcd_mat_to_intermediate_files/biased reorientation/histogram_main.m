common_prefix = 'F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\result\theta';
path = uigetdir(common_prefix);
if path ~= 0
    list = get_all_files_of_a_certain_type_in_a_rootpath(path,'*.mat');
    if size(list,2) ~= 0 
        [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files to convert');
        if tf == 1
            for i = indx
                full_path = list{i};
                data = load_struct(full_path);
                x_label_str = prepare_x_label_str(full_path);
                histogram_for_theta(data, x_label_str);

                % save
                [folder_path,file_name,~] = fileparts(full_path);
                full_path_save = fullfile(folder_path,file_name);
                saveas(gcf,[full_path_save '.png'])
                close;
            end
        end
    end
end

function x_label_str = prepare_x_label_str(full_path)
if contains(full_path,'delta_theta')
    x_label_str = '$\Delta \theta$';
elseif contains(full_path,'theta_in')
    x_label_str = '$\theta_{in}$';
elseif contains(full_path,'theta_out')
    x_label_str = '$\theta_{out}$';
end
end