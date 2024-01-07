% NC-NT-fake vs NC-NT-real
%
% 2024-01-07, Yixuan Li
%

clc;clear;close all;

% NC
hist_count_NC = choose_file_for_hist_count;

% NT
hist_count_NT = choose_file_for_hist_count;

% Or
[hist_count_Or,full_path] = choose_file_for_hist_count;

% fake
hist_count_NC_NT = (hist_count_NC + hist_count_NT) / 2;

% for save
folder_path = fileparts(full_path);

% plot
figure;
reconstruct_histogram(hist_count_NC);
title("NC");
saveas(gcf,fullfile(folder_path,"NC"),'png');

figure;
reconstruct_histogram(hist_count_NT);
title("NT");
saveas(gcf,fullfile(folder_path,"NT"),'png');

figure;
reconstruct_histogram(hist_count_NC_NT);
title("NC + NT (fake)");
saveas(gcf,fullfile(folder_path,"NC_NT_fake"),'png');

figure;
reconstruct_histogram(hist_count_Or);
title("NC + NT (real)");
saveas(gcf,fullfile(folder_path,"NC_NT_real"),'png');


%
close all;