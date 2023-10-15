% try to label shallow turn
%
% 2023-09-29, Yixuan Li
%

%% load run disp
clc;clear;close all;
load('D:\Public_repository\Worm-Thermo-Chemotaxis\Code\YixuanLi\run strategy\persistent length\data\all\n2_ortho.mat')
run_disp = cellfun(@(x) x/22, run_displacement, 'UniformOutput', false); % convert to mm
run_disp = smooth_disp(run_disp);

for frame_window = [10,20,40]
    for flag = [1,2]

    %% calculate theta, std of theta,smoothed theta and delta theta
    theta = cell(length(run_disp),1);
    std_of_theta = cell(length(run_disp),1);
    smoothed_theta = cell(length(run_disp),1);
    delta_theta = cell(length(run_disp),1);
    for i = 1:length(run_disp)
        theta{i,1} = get_theta_from_points(run_disp{i,1});
        std_of_theta{i,1} = std_of_theta_in_a_window(theta{i,1},frame_window);
        window_size = 5;
        smoothed_theta{i,1} = smoothdata(theta{i,1}, 'movmean', window_size);
        delta_theta{i,1} = get_delta_theta(smoothed_theta{i,1},frame_window);
    end

    %% hist and label
    IQR_index = 1.5; % a super parameter
    frame_threshold = 40; % 20 s, 2 mm % We only consider the spatial scale which > 2 mm
    switch flag
        case 1
            std_of_theta_all = cell_to_mat(std_of_theta);
            std_threshold = my_hist_with_Tukey_test(std_of_theta_all,IQR_index);
            label = label_shallow_turn_std_method(run_disp,...
                frame_window,std_threshold,frame_threshold);
        case 2
            delta_theta_all = cell_to_mat(delta_theta);
            delta_theta_all = delta_theta_all/pi*180; % rad to deg
            delta_theta_threshold = my_hist_with_Tukey_test(delta_theta_all,IQR_index);
            delta_theta_threshold = delta_theta_threshold/180*pi;
            label = label_shallow_turn_delta_theta_method(run_displacement,...
                frame_window,delta_theta_threshold,frame_threshold);
    end

    %% scatter
    my_start = 1;
    my_end = 18;
    my_quiver(run_disp,smoothed_theta,label,my_start,my_end);

    %% save
    folder_name = 'C:\Users\11097\Desktop\figs_exp1_track_1';
    if ~isfolder(folder_name)
        mkdir(folder_name)
    end
    file_name = ['Method' num2str(flag) '_' 'FrameWindow' num2str(frame_window)];
    full_path = fullfile(folder_name, file_name);
    saveas(gcf,[full_path '.png']);
    saveas(gcf,[full_path '.fig']);
    
    end
end

close all;