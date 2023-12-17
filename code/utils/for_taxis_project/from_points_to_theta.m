% Calculate theta from points.
%
% The input are 2*n array, where the 1st row is the x coordinate and the
% 2nd row is the y coordinate.
%
% The output is 1*n array, each element is the theta of the disp vector.
%
% theta belongs to [-pi,+pi].
%
% 2023-09-30, Yixuan Li
%

function [theta,disp_vectors,path_length,disp_vectors_normalized] = from_points_to_theta(points)

% delete same column
points = unique(points', 'rows', 'stable')';

% error if less than 2 unique points
if size(points, 2) <= 1
    error("This run has less than 2 unique points!");
end

% disp vectors
disp_vectors = (points(:,2:end) - points(:,1:end-1));

% path_length is sqrt(delta_x^2 + delta_y^2)
path_length = sqrt(sum(disp_vectors.^2,1));

% normalized disp vectors
disp_vectors_normalized = disp_vectors./repmat(path_length,2,1);

% calculate theta
theta = angle(complex(disp_vectors_normalized(1, :), disp_vectors_normalized(2, :)));

end