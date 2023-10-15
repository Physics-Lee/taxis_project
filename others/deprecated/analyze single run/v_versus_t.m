function velosity_of_all_run = v_versus_t(eset)

count_track_after_screen = 0;
number_of_experiment = length(eset.expt);
velosity_of_all_run = []; 
for experiment_number = 1:number_of_experiment
    number_of_track = length(eset.expt(1,experiment_number).track);
    for track_number = 1:number_of_track
        track = eset.expt(1,experiment_number).track(1,track_number);        
        if screen_a_track(track) && screen_a_track_by_max_displacement(track)
            count_track_after_screen = count_track_after_screen + 1;            
            number_of_run = length(track.run);
            for run_number = 1:number_of_run
                velosity_of_all_run(end+1) = track.run(run_number).pathLength/track.run(run_number).runTime; % core
            end
        end
     
    end
end
end