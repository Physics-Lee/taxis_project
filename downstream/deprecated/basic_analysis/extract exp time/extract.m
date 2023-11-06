function datestr = extract(str)

expr = '(\d{8})'; % Regular expression to match 8 digits
match = regexp(str, expr, 'match');
datestr = match{1}; % Extract the first match

end