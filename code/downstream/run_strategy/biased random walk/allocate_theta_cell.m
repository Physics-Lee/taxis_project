function theta_cell_4_region = allocate_theta_cell(theta_cell, region_flags)

% Initialize the output cell array
theta_cell_4_region = cell(4,1); % Each cell for a region

% Loop through each region
for region = 1:4
    % Find indices of theta_cell that belong to the current region
    region_indices = region_flags == region;

    % Allocate theta_cell elements to the corresponding region
    % If there are no indices for a region, the cell will remain empty
    theta_cell_4_region{region} = theta_cell(region_indices);
end

end