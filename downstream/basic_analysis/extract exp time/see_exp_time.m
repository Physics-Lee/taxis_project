size_of_x = size(x);
n = size_of_x(1);
start_time = string(zeros(n,1));
end_time = string(zeros(n,1));
for i = 1:n
    number_of_experiment = length(x{i,1}.eset.expt);
    % read the first and the last
    start_time(i) = x{i, 1}.eset.expt(1, 1).fname;
    end_time(i) = x{i, 1}.eset.expt(1, number_of_experiment).fname;
end

% extract time
start_time_new = string(zeros(n,1));
end_time_new = string(zeros(n,1));
experimenter = string(zeros(n,1));
for i = 1:n
%     start_time_new(i) = extract(char(start_time(i)));
%     end_time_new(i) = extract(char(end_time(i)));
    experimenter(i) = extract_experimenter(char(start_time(i)));
end