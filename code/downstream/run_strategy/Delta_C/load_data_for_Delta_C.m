function all_disp = load_data_for_Delta_C(name_patthern)

root_path = uigetdir;
if root_path ~= 0
    
    list_all_disp = get_all_files_of_a_certain_type_in_a_rootpath(root_path,name_patthern);
    [indx,tf] = listdlg('ListString',list_all_disp,'ListSize',[800,600],'Name','Chose files');

    if length(indx)~=1
        error("Now only support 1");
    end
    
    if tf == 1
        for i = indx
            full_path_to_all_disp = list_all_disp{i};

            try
                all_disp = load_data_from_mat(full_path_to_all_disp);
            catch
                all_disp = readcell(full_path_to_all_disp);
            end
        end
    end
end

end