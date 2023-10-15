% esets = read_all_eset;

root_folder_path= 'D:\Public_repository\Worm-Thermo-Chemotaxis\Code\YixuanLi\result\basic\visulization in 2D\visulization in 2D_800-900s_v3';
for i = 1:length(esets)
    
    eset = esets{i,1}.eset;
    n_exp = length(esets{i,1}.eset.expt);
    child_folder = esets{i,2};    
    
    for exp_number = 1:n_exp
        n_track = length(eset.expt(1,exp_number).track);
        for track_number = 1:n_track            
            track = eset.expt(1,exp_number).track(1,track_number);
            
            % screen
            if ~screen_a_track(track)
                continue;
            end
            
            % extract
            trajectory = track.dq.displacement;
            x = trajectory(1,:)/22; % convert to mm
            y = trajectory(2,:)/22; % convert to mm
            bool_vec = track.isrun;

            % plot
            figure;
            axis equal;
            hold on;
            scatter(x(bool_vec), y(bool_vec), 'b');
            scatter(x(~bool_vec), y(~bool_vec), 'r');
            xlabel('x (mm)');
            ylabel('y (mm)');
            title([strrep(child_folder, '\', '\\') ' ' 'exp' num2str(exp_number) ' ' 'track' num2str(track_number)]);

            % Define file name and directory
            file_name = ['exp' num2str(exp_number) '_' 'track' num2str(track_number) '.png'];
            folder_name = fullfile(root_folder_path, child_folder);
            if ~isfolder(folder_name)
                mkdir(folder_name)
            end
            full_path = fullfile(folder_name, file_name);

            % Save the plot to the specified directory
            saveas(gcf,full_path);
            close;
            
        end
    end
end