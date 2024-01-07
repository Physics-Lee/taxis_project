clc;clear;close all;

%% load data

% option_measure = "chemo-index-down";
% option_measure = "chemo-index-left";
option_measure = "thermo-index";

% option_measure = "chemo-index-down_each-worm";
% option_measure = "chemo-index-left_each-worm";
% option_measure = "thermo-index_each-worm";

file_name = strcat(option_measure,".csv");

root_folder_path = uigetdir;
list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(root_folder_path, file_name);

if size(list,1) ~= 2
    error("The number of .csv files is not 2!");
end

loaded_table = readtable(list{1});
control_group = table2array(loaded_table);

loaded_table = readtable(list{2});
test_group = table2array(loaded_table);

%% for save
save_folder_path = fileparts(list{1});

%% boot-strap
n_bootstrap_samples = 100000;
boot_strap_for_hypothesis_test(control_group, test_group, n_bootstrap_samples);

% save
save_full_path = fullfile(save_folder_path,strcat(option_measure,'_hypothesis-test'));
saveas(gcf,save_full_path,"png");

%% histogram
figure;
n_bins = 10;
y_up_limit = 0.3;
normalization_method = 'probability';

subplot(2,1,1);
histogram(control_group(:,1),n_bins,'Normalization',normalization_method);
xlim([-1,+1]);
ylim([0 y_up_limit]);
xlabel("index");
ylabel(normalization_method);
title("control");

subplot(2,1,2);
histogram(test_group(:,1),n_bins,'Normalization',normalization_method);
xlim([-1,+1]);
ylim([0 y_up_limit]);
xlabel("index");
ylabel(normalization_method);
title("test");

% save
save_full_path = fullfile(save_folder_path,strcat(option_measure,'_histogram'));
saveas(gcf,save_full_path,"png");

close all;