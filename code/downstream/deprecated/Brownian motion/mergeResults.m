function [maxPoints, mergedResult] = mergeResults(result_all)

    numTrajectories = numel(result_all);
    maxPoints = 0;

    % Find the maximum number of numPointsBetween
    for i = 1:numTrajectories
        result = result_all{i};
        numPoints = max(cell2mat(result(:, 1)));
        if numPoints > maxPoints
            maxPoints = numPoints;
        end
    end

    % Merge the elements of result_all
    mergedResult = cell(maxPoints + 1, 2);
    for i = 0:maxPoints
        mergedResult{i+1, 1} = i;
    end

    for i = 1:numTrajectories
        result = result_all{i};
        for j = 1:size(result, 1)
            numPoints = result{j, 1};
            distances = result{j, 2};            
            mergedResult{numPoints + 1, 2} = [mergedResult{numPoints + 1, 2} distances];
        end
    end
    
end