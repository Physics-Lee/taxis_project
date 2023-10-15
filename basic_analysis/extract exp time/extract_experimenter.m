function dirname = extract_experimenter(str)

expr = '\\([^\\]+?)\d'; % Regular expression to match the first directory name before a number
match = regexp(str, expr, 'match');
dirname = match{1}(2:end-1); % Extract the first match and remove the leading '\' and trailing number

end