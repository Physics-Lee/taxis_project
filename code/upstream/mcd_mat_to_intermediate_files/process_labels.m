% get run disp or reorientation disp
%
% 2023-11-05, Yixuan Li
%

function disp = process_labels(label_rearranged, mcd, label)

if nargin == 2
    rows = label_rearranged(2:end,:);
else
    rows = label_rearranged(string(label_rearranged(:,3)) == label,:);
end

start_end = cell2mat(rows(:,[1,2]));
disp = get_disp(mcd,start_end(:,1),start_end(:,2));

end