% output figs, with the file name contains information of measure, partition,
% ideal direction and the up limit of x axis.
%
% 2023-09-27, Yixuan Li
%

function output_figures(save_folder_path,option_measure,option_partition_region,option_ideal_theta,x_up_limit,ext)

save_folder_path = fullfile(save_folder_path,'persistent_length_error_bar_for_branches');
create_folder(save_folder_path);

% modify save file name
save_file_name = create_save_file_name(option_measure,option_partition_region,option_ideal_theta);

if ext == "png"
    save_file_name = strcat(save_file_name,'_x_lim_',num2str(x_up_limit),'mm');
end

save_file_name = add_date_and_time(save_file_name);

% save
save_full_path = fullfile(save_folder_path,save_file_name);
saveas(gcf,save_full_path,ext);

% disp
disp('figs saved successfully!');

end