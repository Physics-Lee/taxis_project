path = uigetdir('F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\data');
if path ~= 0

    % load using *
    list = get_all_files_of_a_certain_type_in_a_rootpath(path,'*run_disp_smoothed_downsampled_smoothed.mat');

    % choose what u want through GUI
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files to convert');
    
    if tf == 1
        for i = indx

            % load
            full_path = list{i};
            run_disp_smoothed_downsampled_smoothed = load_struct(full_path);

            % correct
            if contains(full_path,'NC')
                run_disp_smoothed_downsampled_smoothed_corrected = correct_NC_direction(run_disp_smoothed_downsampled_smoothed);
            elseif contains(full_path,'Or')
                run_disp_smoothed_downsampled_smoothed_corrected = correct_ortho_direction(run_disp_smoothed_downsampled_smoothed);
            end

            % save
            [folder_name,~,~] = fileparts(full_path);
            [grand_folder_name,~,~] = fileparts(folder_name);
            folder_path_of_mcd = grand_folder_name;
            my_save(folder_path_of_mcd, 'disp',...
                'run_disp_smoothed_downsampled_smoothed_corrected.mat',...
                'run_disp_smoothed_downsampled_smoothed_corrected',...
                run_disp_smoothed_downsampled_smoothed_corrected);

            delete(full_path);

        end
    end
end