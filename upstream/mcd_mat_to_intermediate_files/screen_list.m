% only preserve elements containing substr
%
% 2023-11-05, Yixuan Li
%

function list_filtered = screen_list(list,substr)

containsSubstr = contains(list, substr);
list_filtered = list(containsSubstr);

end