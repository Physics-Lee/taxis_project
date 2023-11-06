folder_path = 'F:\1_learning\research\taxis of C.elegans\data analysis of high throughout system\Another N2 data of Bingzhen\50-100-cold';
load(fullfile(folder_path,'eset.mat'));
i = 1;
esets{i,1} = eset;
esets{i,2} = 'N2_ortho_1';
save_folder_path = 'F:\1_learning\research\taxis of C.elegans\data analysis of high throughout system\Another N2 data of Bingzhen\visulization';
count = 0;
for i = 1:1
    
    eset = esets{i,1};
    n_exp = length(eset.expt);
    file_name = esets{i,2};    
    
    for exp_number = 1:n_exp
        n_track = length(eset.expt(1,exp_number).track);
        for track_number = 1:n_track            
            track = eset.expt(1,exp_number).track(1,track_number);
            
            % screen
            if ~screen_a_track(track)
                continue;
            end
            
            % plot
            trajectory = track.dq.displacement;
            x = trajectory(1,:)/22;
            y = trajectory(2,:)/22;
            bool_vec = track.isrun;
            scatter(x(bool_vec), y(bool_vec), 'b');
            hold on;
            scatter(x(~bool_vec), y(~bool_vec), 'r');
            xlabel('x (mm)');
            ylabel('y (mm)');
            title([strrep(file_name, '\', '\\') ' ' 'exp' num2str(exp_number) ' ' 'track' num2str(track_number)]);

            % Define file name and directory
            save_file_path = fullfile(save_folder_path, file_name, ['exp' num2str(exp_number) '_' 'track' num2str(track_number) '.png']);
%             count = count + 1;
%             save_file_name = fullfile(directory,[num2str(count),'.png']);

            % Save the plot to the specified directory
            saveas(gcf,save_file_path);
            clf;
            
        end
    end
end