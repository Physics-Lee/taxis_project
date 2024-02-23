function theta_normalized = normalize_theta(theta)

% Normalize theta to [0, 2*pi) for all elements
theta_normalized = mod(theta, 2*pi);

% Find elements that are greater than pi and adjust them
adjustment_indices = theta_normalized > pi;
theta_normalized(adjustment_indices) = theta_normalized(adjustment_indices) - 2*pi;

% Additional step to check if initial adjustment was necessary
% This is more for logical completeness as the adjustment has already been made
initially_within_range = (theta > -pi) & (theta < pi);
theta_normalized(initially_within_range) = theta(initially_within_range);

end
