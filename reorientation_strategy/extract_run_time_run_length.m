function [run_times,run_lengths] = extract_run_time_run_length(eset)

    run_lengths = [];
    run_times = [];

    for i = 1:length(eset.expt)
        for j = 1:length(eset.expt(i).track)
            
            % screen track
            if ~screen_a_track(eset.expt(i).track(j))
                continue;
            end

            % extract run lengths and run times
            for k = 1:length(eset.expt(i).track(j).run)
                run_lengths(end+1) = eset.expt(i).track(j).run(k).pathLength;
                run_times(end+1) = eset.expt(i).track(j).run(k).runTime;
            end
            
        end
    end
    
end