% calculate the mutual info of 2 angle random variable.
%
% Yixuan Li, 2023-12-01
%

function I_mutual = calculate_mutual_information_given_angle_rv(X_1, X_2, use_Laplace_smooth)

% Default argument for Laplace smoothing
if nargin < 3
    use_Laplace_smooth = true;
end

% Parameters
number_of_bin = 20;
edges = [-pi, linspace(-pi, pi, number_of_bin), pi];

% 1D histograms for theta_1 and theta_2
h1 = histogram(X_1, edges, 'Normalization', 'count');
f_of_theta_1 = h1.Values(2:end-1);

h2 = histogram(X_2, edges, 'Normalization', 'count');
f_of_theta_2 = h2.Values(2:end-1);

% 2D histogram
h_2D = histogram2(X_1, X_2, edges, edges, 'Normalization', 'count');
f_of_joint_distribution = h_2D.Values(2:end-1, 2:end-1);

% Calculate mutual information
if use_Laplace_smooth
    % Laplace smoothing
    count_of_theta_1 = f_of_theta_1 + 1;
    f_of_theta_1_smooth = count_of_theta_1 / sum(count_of_theta_1);

    count_of_theta_2 = f_of_theta_2 + 1;
    f_of_theta_2_smooth = count_of_theta_2 / sum(count_of_theta_2);

    count_of_joint_distribution = f_of_joint_distribution + 1;
    f_of_joint_distribution_smooth = count_of_joint_distribution / sum(sum(count_of_joint_distribution));

    I_mutual = calculate_mutual_information_given_f(f_of_joint_distribution_smooth, f_of_theta_1_smooth, f_of_theta_2_smooth);
else
    % Without Laplace smoothing
    I_mutual = calculate_mutual_information_given_f(f_of_joint_distribution, f_of_theta_1, f_of_theta_2);
end

end