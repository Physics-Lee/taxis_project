% choose file for hist count
%
% 2024-01-07, Yixuan Li
%

function [hist_count,full_path] = choose_file_for_hist_count

root_folder_path = uigetdir;
list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(root_folder_path,'histcount_of_theta_pdf.mat');
[indx,~] = listdlg('ListString',list,'ListSize',[800,600],'Name','Choose files');
if length(indx) ~= 1
    error("More than 1 files is selected!");
end
full_path = list{indx(1)};
hist_count = load_data_from_mat(full_path);

end