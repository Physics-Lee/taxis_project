clc;clear;close all;

%% upload
[eset,type_of_C_elegans,type_of_taxis] = upload_eset;

%% get theta_in and theta_out
count_reorientation = 0;
number_of_experiment = length(eset.expt);
for experiment_number = 1:number_of_experiment
    number_of_track = length(eset.expt(1,experiment_number).track);
    for track_number = 1:number_of_track
        %% screen
        track = eset.expt(1,experiment_number).track(1,track_number);
        flag = screen_a_track(track);
        if flag == 0
            continue;
        end   
        
        %% count reorientation
        total_reorientation_number = length(track.reorientation);
        for reorientation_number = 1:total_reorientation_number
            count_reorientation = count_reorientation + 1;
            theta_in(count_reorientation) = track.reorientation(reorientation_number).thetaIn;
            theta_out(count_reorientation) = track.reorientation(reorientation_number).thetaOut;
        end
    end
end

%% 1D histogram
number_of_bin = 20;
edges = [-pi -pi:(2*pi)/number_of_bin:+pi +pi];

h_theta_in = histogram(theta_in,edges,'Normalization','probability');
f_of_theta_in = h_theta_in.Values(2:number_of_bin+1);

h_theta_out = histogram(theta_out,edges,'Normalization','probability');
f_of_theta_out = h_theta_out.Values(2:number_of_bin+1);

%% 2D histogram
number_of_bin = 20; % a hyper-parameter, use 20 temporarily
X_edges = [-pi -pi:(2*pi)/number_of_bin:+pi +pi];
Y_edges = [-pi -pi:(2*pi)/number_of_bin:+pi +pi];
h_2D_histogram = histogram2(theta_in,theta_out,X_edges,Y_edges,'Normalization','probability');
f_of_joint_distribution = h_2D_histogram.Values(2:number_of_bin+1,2:number_of_bin+1);

%% calculate mutual information

% don't use Laplace smooth 
I_mutual = calculate_the_mutual_information(f_of_joint_distribution,f_of_theta_in,f_of_theta_out);
I_mutual_dual = calculate_the_mutual_information(f_of_joint_distribution.',f_of_theta_out,f_of_theta_in);

% use Laplace smooth
h_theta_in = histogram(theta_in,edges);
count_of_theta_in = h_theta_in.Values(2:number_of_bin+1);
count_of_theta_in = count_of_theta_in + ones(size(count_of_theta_in));
f_of_theta_in_Laplace_smooth = count_of_theta_in / sum(count_of_theta_in);

h_theta_out = histogram(theta_out,edges);
count_of_theta_out = h_theta_out.Values(2:number_of_bin+1);
count_of_theta_out = count_of_theta_out + ones(size(count_of_theta_out));
f_of_theta_out_Laplace_smooth = count_of_theta_out / sum(count_of_theta_out);

h_2D_histogram = histogram2(theta_in,theta_out,X_edges,Y_edges);
count_of_joint_distribution = h_2D_histogram.Values(2:number_of_bin+1,2:number_of_bin+1);
count_of_joint_distribution = count_of_joint_distribution + ones(size(count_of_joint_distribution));
f_of_joint_distribution_Laplace_smooth = count_of_joint_distribution / sum(sum(count_of_joint_distribution));

I_mutual_Laplace_smooth = calculate_the_mutual_information(f_of_joint_distribution_Laplace_smooth,f_of_theta_in_Laplace_smooth,f_of_theta_out_Laplace_smooth);
I_mutual_Laplace_smooth_dual = calculate_the_mutual_information(f_of_joint_distribution_Laplace_smooth.',f_of_theta_out_Laplace_smooth,f_of_theta_in_Laplace_smooth);

fprintf("I_mutual_Laplace_smooth = %.4f\n",I_mutual_Laplace_smooth);