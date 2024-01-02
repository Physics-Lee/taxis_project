% Draw all disp of each worm in the same figure.
%
% 2024-01-02, Yixuan Li
%

clc;clear;close all;

dbstop if error;

root_folder_path = uigetdir;

if root_folder_path ~= 0
    list_eset = get_all_files_of_a_certain_name_pattern_in_a_rootpath(root_folder_path,'eset.mat');
    [indx,tf] = listdlg('ListString',list_eset,'ListSize',[800,600],'Name','Choose files');
    if tf == 1
        for i = indx

            %
            full_path_to_eset = list_eset{i};
            folder_path_to_eset = fileparts(full_path_to_eset);

            %
            if isfolder(fullfile(folder_path_to_eset,"all_disp_of_each_track"))
                folder_path_to_all_disp = fullfile(folder_path_to_eset,"all_disp_of_each_track");
            elseif isfolder(fullfile(folder_path_to_eset,"all_disp_of_each_worm"))
                folder_path_to_all_disp = fullfile(folder_path_to_eset,"all_disp_of_each_worm");
            else
                error("no folder of all disp!");
            end

            %
            list_all_disp = get_all_files_of_a_certain_name_pattern_in_a_rootpath(folder_path_to_all_disp,'all_disp_of_*.mat');
            figure;
            hold on;
            axis equal;
            xlabel("x (mm)");
            ylabel("y (mm)");

            % high
            % xlim([-100 +100]);
            % ylim([-100 +100]);

            % Colbert
            xlim([-30 +30]); % mm
            ylim([-30 +30]); % mm

            title_str = get_title_str(folder_path_to_eset);
            title(title_str);
            subtitle(sprintf("n = %d",length(list_all_disp)));
            for j = 1:length(list_all_disp)
                full_path_to_all_disp = list_all_disp{j};
                all_disp = load_data_from_mat(full_path_to_all_disp);
                all_disp = all_disp{1,1};
                all_disp = set_the_first_point_as_the_origin(all_disp);
                plot(all_disp(1,:),all_disp(2,:),'blue');
            end
            scatter(0,0,'red','filled');

            % save
            save_folder_path = fullfile(folder_path_to_eset,"visualize_all_disp");
            create_folder(save_folder_path);
            save_full_path = fullfile(save_folder_path,"all_worms");
            saveas(gcf,save_full_path,"png");
            % close;

        end
    end
end