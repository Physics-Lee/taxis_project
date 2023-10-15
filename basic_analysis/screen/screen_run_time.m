function run_time_screened = screen_run_time(run_time,t_threshold) % only returns run time which > t_threshold

count = 0;
for i = 1:length(run_time)
    if run_time(i) >= t_threshold
        count = count + 1;
        run_time_screened(count) = run_time(i);
    end
end

end