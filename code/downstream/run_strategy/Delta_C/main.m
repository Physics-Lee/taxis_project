%%
clear;clc;close all;
dbstop if error;

%% Load all_disp.mat
name_patthern = 'all_disp_of_*.mat';
all_disp = load_data_for_Delta_C(name_patthern);

%% Load Machine_Label_v2.csv
name_patthern = 'machine_label_v2_frame_window_10.csv';
machine_label_v2 = load_data_for_Delta_C(name_patthern);

%% process

% basic
label_rearranged_numerical_array = cell2numerical_for_label_arranged(machine_label_v2);
label = anti_rearrange_label(label_rearranged_numerical_array);
all_disp_vector = cell_array_to_numerical_array(all_disp);
n_frame = min(length(label),size(all_disp_vector,2));

% set the first point to the center of the plate
all_disp_vector(1,:) = all_disp_vector(1,:) - all_disp_vector(1,1);
all_disp_vector(2,:) = all_disp_vector(2,:) - all_disp_vector(2,1);

% calculate C
x = all_disp_vector(1,:);
k = 50 / 60; % mM / mm
C = x * k;
C = C + 75;

% cut label
label = label';
label = label(1:n_frame);

%% Plot
figure;
t = (1:n_frame) / 66;
plot(t,C);
xlabel("t (s)");
ylabel("C (mM)");

%% Plot (separate forward and reorientation)
plot_C_t_Separating_f_r(t,C,label);