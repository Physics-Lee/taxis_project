% run_disp should be n_runs*1 cell array where each element is 2*n_points float
% array.
%
% return theta_in-correlation-path_length martix.
%
% theta_in is the first theta of each run, that is how we preseve the time
% order.
%
% correlation is "cos", "MSE", "tortuosity", "cos_to_ideal",
% "MSE_to_ideal", "velocity" or "Iino_curving_rate"
%
% path_length is the path length of each run.
%
% 2023-09-26, Yixuan Li
%

function corr = analyze_branches(run_disp, option_measure, option_ideal_theta)

% ideal direction and ideal theta
switch option_ideal_theta
    case "-pi"
        ideal_unit_vector = [-1,0];
        ideal_theta = -pi; % -pi and +pi have the same effect in function my_diff_v2
    case "-3/4*pi"
        ideal_unit_vector = [-1,-1]/sqrt(2);
        ideal_theta = -3/4*pi;
    case "-1/2*pi"
        ideal_unit_vector = [0,-1];
        ideal_theta = -1/2*pi;
    case "1/4*pi" % just for testing if the code is right
        ideal_unit_vector = [1,1]/sqrt(2);
        ideal_theta = 1/4*pi;
end

% pre-assign to raise speed
n_runs = length(run_disp);
n_pairs = 0;
for i = 1:n_runs
    n_theta_of_a_run = size(run_disp{i}, 2) - 1;
    n_temp = n_theta_of_a_run - 2; % abandon the first and the last theta
    n_pairs = n_pairs + n_temp * (n_temp - 1) / 2;
end
corr = zeros(n_pairs, 3);
idx = 1;

% loop to process each run
for i = 1:n_runs

    % get points
    points = run_disp{i};

    % from points to theta
    [theta,~,path_length,v_norm] = from_points_to_theta(points);

    % error if less than 5 unique points
    n_theta_of_a_run = size(theta, 2);
    if n_theta_of_a_run <= 3
        error("This run has less than 5 unique points!");
    end

    % loop to process each theta (abandon the first and the last)
    for j = 2:n_theta_of_a_run - 2
        if screen_a_theta(theta(j), theta(j - 1), theta(j + 1)) % screen
            for k = j + 1:n_theta_of_a_run - 1
                if screen_a_theta(theta(k), theta(k - 1), theta(k + 1)) % screen
                    switch option_measure
                        case "cos"
                            measure = cos_analysis(v_norm, j, k);
                        case "MSE"
                            measure = MSE_analysis(theta, j, k);
                        case "tortuosity"
                            measure = tortuosity_analysis(points, path_length, j, k);
                        case "cos_to_ideal"
                            measure = cos_to_ideal_analysis(points, j, k, ideal_unit_vector);
                        case "MSE_to_ideal"
                            measure = MSE_to_ideal_analysis(theta, j, k, ideal_theta);
                        case "velocity"
                            measure = v_analysis(path_length, j, k);
                        case "Iino_curving_rate"
                            measure = Iino_curving_rate(theta, path_length, j, k, ideal_theta);
                        case "Iino_curving_rate_v2"
                            measure = Iino_curving_rate_v2(theta, path_length, j, k);
                        case "Iino_curving_rate_v3"
                            measure = Iino_curving_rate_v3(theta, path_length, j, k);
                        otherwise
                            error("Invalid measure option.");
                    end

                    % save theta-in, measure, path length
                    corr(idx, :) = [theta(j), measure, sum(path_length(j:k))];
                    idx = idx + 1;
                end
            end
        end
    end

end

% delete those point-pairs which are screened
corr = corr(1:idx - 1, :);

end

% local functions
function measure = cos_analysis(v_normal, j, k)
measure = dot(v_normal(:,j),v_normal(:,k));
end

function measure = MSE_analysis(theta, j, k)
measure = mean_square_error_to_initial_v2(theta(j:k));
end

function measure = tortuosity_analysis(points, path_length, j, k)
point_1 = points(:, j)';
point_2 = points(:, k)';
Euclidean_distance = sqrt(sum((point_1 - point_2).^2));
d = sum(path_length(j:k));
measure = Euclidean_distance / d;
end

function measure = cos_to_ideal_analysis(points, j, k, ideal_unit_vector)
point_1 = points(:, j)';
point_2 = points(:, k)';
Euclidean_distance = sqrt(sum((point_1 - point_2).^2));
disp_normal = (point_2 - point_1) / Euclidean_distance;
measure = dot(disp_normal, ideal_unit_vector);
end

function measure = MSE_to_ideal_analysis(theta, j, k, ideal_theta)
measure = mean_square_error_to_ideal_v2(theta(j:k),ideal_theta);
end

function measure = v_analysis(path_length, j, k)
run_time = (k - j)/2;
d = sum(path_length(j:k));
measure = d/run_time;
end

function measure = Iino_curving_rate(theta, path_length, j, k, ideal_theta)
delta_theta = my_diff_abs(theta(k),ideal_theta) - my_diff_abs(theta(j),ideal_theta); % delta-delta-theta
delta_theta = rad2deg(delta_theta);
d = sum(path_length(j:k));
measure = - delta_theta / d; % minu sign will make it more in line with habits.
end

function measure = Iino_curving_rate_v2(theta, path_length, j, k)
delta_theta = my_diff(theta(j),theta(k)); % delta-theta/d
delta_theta = rad2deg(delta_theta);
d = sum(path_length(j:k));
measure = delta_theta / d;
end

function measure = Iino_curving_rate_v3(theta, path_length, j, k)
delta_theta = my_diff_abs(theta(j),theta(k)); % abs(delta-theta)/d
delta_theta = rad2deg(delta_theta);
d = sum(path_length(j:k));
measure = delta_theta / d;
end