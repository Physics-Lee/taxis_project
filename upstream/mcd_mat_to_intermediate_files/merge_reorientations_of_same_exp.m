% merge reorientation disp of all worms within a group
%
% 2023-10-30, Yixuan Li
%

clear;clc;close all;

path = uigetdir;

type_of_reorientation_disp = "all_worms";

if path ~= 0

    list = get_all_files_of_a_certain_type_in_a_rootpath(path,'reorientation_disp_*.mat');

    for substr = ["Ctl" "NC" "NT" "Or"]

        list_screened = screen_list(list,substr);

        if size(list_screened,1) == 0
            disp(['For ' char(substr) ', The list is empty!']);
            continue;
        end

        [indx,tf] = listdlg('ListString',list_screened,'ListSize',[800,600],'Name','Chose files');

        if tf==1

            n = length(indx);
            reorientation_disp_all = cell(n,1);
            for i = indx
                full_path = list_screened{i};
                reorientation_disp_all{i} = load_data_from_mat(full_path);
            end

            % concatenate
            reorientation_disp_all = vertcat(reorientation_disp_all{:});

            % save
            father_folder_path = fileparts(fileparts(fileparts(full_path)));

            switch type_of_reorientation_disp
                case "all_worms"
                    save_folder_path = fullfile(father_folder_path,'reorientation_disp_of_all_worms');
                    save_file_name = 'reorientation_disp_of_all_worms.mat';
                case "all_tracks"
                    save_folder_path = fullfile(father_folder_path,'reorientation_disp_of_all_tracks');
                    save_file_name = 'reorientation_disp_of_all_tracks.mat';
            end
            
            save_full_path = fullfile(save_folder_path,save_file_name);
            create_folder(save_folder_path);
            save(save_full_path,'reorientation_disp_all');

        end
    end
end