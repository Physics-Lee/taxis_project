function data_vector = cell_array_to_numerical_array_after_drop_n_frames(data_cell, n_frame)
    % Initialize an empty cell array to hold the modified data
    modified_data_cell = cell(size(data_cell));
    
    % Loop through each cell, removing the last n_frame elements
    for i = 1:length(data_cell)
        current_element = data_cell{i};
        % Ensure there are enough elements to drop
        if numel(current_element) > n_frame
            modified_data_cell{i} = current_element(1:end-n_frame);
        else
            % Handle case where current_element has fewer elements than n_frame
            modified_data_cell{i} = [];
        end
    end
    
    % Convert the modified cell array to a numerical array
    data_vector = horzcat(modified_data_cell{:});
end
