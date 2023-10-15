function distribution_of_the_number_of_reorientation(eset,type_of_C_elegans,type_of_taxis)
count_track_after_screen = 0;
number_of_experiment = length(eset.expt);
for experiment_number = 1:number_of_experiment
    number_of_track = length(eset.expt(1,experiment_number).track);
    for track_number = 1:number_of_track
        %% screen
        track = eset.expt(1,experiment_number).track(1,track_number);
        flag = screen_a_track(track);
        if flag == 0
            continue;
        end
        count_track_after_screen = count_track_after_screen + 1;
        
        %% number_of_reorientation
        number_of_reorientation(count_track_after_screen) = length(track.reorientation);   
        
    end
end

histogram(number_of_reorientation);
xlabel('count');
ylabel('number of reorientation');
title([type_of_C_elegans ' ' type_of_taxis]);

sum(number_of_reorientation)/count_track_after_screen

end