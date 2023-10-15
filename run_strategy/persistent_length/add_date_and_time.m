% add date and time at the end of a string
%
% 2023-10-03, Yixuan Li
%

function output_string = add_date_and_time(input_string)
formatted_date_time = datetime('now', 'Format', 'yyyyMMdd-HHmmss');
date_time_string = datestr(formatted_date_time, 'yyyymmdd-HHMMSS');
output_string = strcat(input_string,'_',date_time_string);
end