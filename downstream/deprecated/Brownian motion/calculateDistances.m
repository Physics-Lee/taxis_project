function result = calculateDistances(matrix)

    n = size(matrix, 2);
    result = cell(n-1, 2);

    for m = 0:n-2

        distances = zeros(1, n-m-1);

        for i = 1:n-m-1
            point1 = [matrix(1, i); matrix(2, i)];
            point2 = [matrix(1, i+m+1); matrix(2, i+m+1)];
            distances(i) = norm(point2 - point1);
        end
        
        result{m+1, 1} = m;
        result{m+1, 2} = distances;        

    end

end