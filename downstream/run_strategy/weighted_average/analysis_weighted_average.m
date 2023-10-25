clear;clc;close all;

root_folder_path = 'F:\1_learning\research\taxis of C.elegans\Colbert\data';
path = uigetdir(root_folder_path);
if path ~= 0
    list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(path,'*.mat');
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files');
    if tf == 1

        % init
        v_all = {};
        index_all = {};

        % calculate through loop
        for i = indx

            % load
            full_path = list{i};
            run_disp_all = load_struct(full_path);

            % v
            v = calculate_v(run_disp_all);
            v_all = [v_all; {v, process_full_path(full_path,root_folder_path)}];

            % index
            index_all = three_index_for_ortho(index_all, run_disp_all, full_path, root_folder_path);

        end

        % calculate weighted average
        v_table = my_cell2table(v_all);
        index_table = my_cell2table(index_all);

        my_bar(v_table,"v(mm/s)","v");
        my_bar(index_table,"index","index");

    end
end

function index_all = three_index_for_ortho(index_all, run_disp_all, full_path, common_prefix)

% calculate index
index_sub = @(unit_vec) calculate_index(run_disp_all,unit_vec);

% for 4 taxis
if contains(full_path,'Ctl') || contains(full_path,'Or')

    % for control and ortho, calculate 3 kind of index
    ideal_vectors = {[0 -1], [-1 0], [-1 -1]/sqrt(2)};
    strings = {' chemo-index.mat', ' thermo-index.mat', ' ortho-index.mat'};
    for k = 1:length(ideal_vectors)
        index = index_sub(ideal_vectors{k});
        full_path_new = strrep(full_path,'.mat',strings{k});
        index_all = [index_all; {index, process_full_path(full_path_new,common_prefix)}];
    end

elseif contains(full_path,'NC')

    % for NC, calculate chemo-taxis
    index_all = add_index(index_all, run_disp_all, full_path, [0 -1], common_prefix);

elseif contains(full_path,'NT')

    % for NT, calculate thermo-taxis
    index_all = add_index(index_all, run_disp_all, full_path, [-1 0], common_prefix);

end

end

function index_all = add_index(index_all, run_disp_all, full_path, ideal_vector, common_prefix)

index = calculate_index(run_disp_all,ideal_vector);
index_all = [index_all; {index, process_full_path(full_path,common_prefix)}];

end

function v_table = my_cell2table(v_all)

weighted_average = calculate_weighted_average(v_all);
weighted_std = calculate_weighted_std(v_all);
v_all = [v_all num2cell(weighted_average) num2cell(weighted_std)];

header = {'measure', 'full_path', 'weighted_average', 'weighted_std'};
v_table = cell2table(v_all, 'VariableNames', header);

end

function full_path = process_full_path(full_path,common_prefix)

full_path = strrep(full_path,common_prefix,'');

full_path = strrep(full_path,'.mat','');

full_path = strrep(full_path,'_taxis','');

full_path = strrep(full_path,'\N2\','N2 ');

full_path = strrep(full_path,'\WEN0216\','RIA ');

full_path = strrep(full_path,'\WEN0216_test_1.7Agar\','RIA 1.7Agar ');

end