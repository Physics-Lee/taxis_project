function list_filtered = screen_list(list,substr)
% only preserve elements containing substr

containsSubstr = contains(list, substr);
list_filtered = list(containsSubstr);

end