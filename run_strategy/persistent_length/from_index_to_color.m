% from index of partitioning to color
%
% 2023-10-08, Yixuan Li
%

function color_str = from_index_to_color(i)
switch i
    case 1
        color_str = 'blue';
    case 2
        color_str = 'cyan';
    case 3
        color_str = 'black';
    case 4
        color_str = 'red';
end
end