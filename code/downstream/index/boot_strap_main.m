clc;clear;close all;

% load data
option_measure = "chemo-index-down";
file_name = strcat(option_measure,".csv");

save_full_path_csv = fullfile("F:\1_learning\research\taxis of C.elegans\high throughout system\data\smd-rmd-coablation\mockkill\Or\index",file_name);
loaded_table = readtable(save_full_path_csv);
control_group = table2array(loaded_table);

save_full_path_csv = fullfile("F:\1_learning\research\taxis of C.elegans\high throughout system\data\smd-rmd-coablation\ablation\Or\index",file_name);
loaded_table = readtable(save_full_path_csv);
test_group = table2array(loaded_table);

% boot-strap
n_bootstrap_samples = 100000;
boot_strap_for_hypothesis_test(control_group, test_group, n_bootstrap_samples);

% histogram
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