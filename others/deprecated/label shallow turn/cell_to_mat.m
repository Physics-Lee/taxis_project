function mergedMatrix = cell_to_mat(cellArray)

% Determine the number of rows for the merged matrix
numRows = size(cellArray{1}, 1);

% Calculate the total number of columns for the merged matrix
totalColumns = sum(cellfun(@(x) size(x, 2), cellArray));

% Create the merged matrix with the appropriate size
mergedMatrix = zeros(numRows, totalColumns);

% Traverse each matrix and copy its content to the merged matrix
currentColumn = 1;
for i = 1:numel(cellArray)
    currentMatrix = cellArray{i};
    currentColumns = size(currentMatrix, 2);
    
    % Copy the current matrix's content to the corresponding position in the merged matrix
    mergedMatrix(:, currentColumn:currentColumn+currentColumns-1) = currentMatrix;
    
    % Update the current column position
    currentColumn = currentColumn + currentColumns;
end

end
